<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;


/**
 * Class OrdenServicio
 * 
 * @property int $ID_ORDEN_SERVICIO
 * @property string|null $NRO_ORDEN
 * @property Carbon|null $FECHA
 * @property string|null $DISTRITO
 * @property string|null $CANTON
 * @property string|null $CREADO_POR
 * @property int|null $ID_ESTADO_ORDEN
 * @property Carbon|null $FECHA_ACTUAL
 * 
 * @property EstadoOrden|null $estado_orden
 * @property Collection|DetalleOrdenServicio[] $detalle_orden_servicios
 *
 * @package App\Models
 */
class OrdenServicio extends Model
{
    protected $connection = 'osgo';
    protected $table = 'osgo_orden_servicio';
    protected $primaryKey = 'ID_ORDEN_SERVICIO';
    public $timestamps = false;

    protected $casts = [
        'FECHA' => 'datetime',
        'ID_ESTADO_ORDEN' => 'int',
        'FECHA_ACTUAL' => 'datetime'
    ];

    protected $fillable = [
        'NRO_ORDEN',
        'FECHA',
        'DISTRITO',
        'CANTON',
        'CREADO_POR',
        'ID_ESTADO_ORDEN',
        'FECHA_ACTUAL'
    ];

    public function estado_orden()
    {
        return $this->belongsTo(EstadoOrden::class, 'ID_ESTADO_ORDEN');
    }

    public function detalle_orden_servicios()
    {
        return $this->hasMany(DetalleOrdenServicio::class, 'ID_ORDEN_SERVICIO');
    }

    public function serviciosGrua(): BelongsToMany
    {
        return $this->belongsToMany(
            ServicioGrua::class,
            'osgo_orden_servicio_grua',
            'ID_ORDEN_SERVICIO',
            'ID_SERVICIO_GRUA'
        )
            // ->using(OrdenServicioGrua::class) // Commented out - class doesn't exist
            ->withPivot('ID_ORDEN_GRUA');
    }

    // Relaciones para tipos de servicio y disposiciones (maestro-detalle optimizado)
    public function tiposServicio()
    {
        return $this->belongsToMany(TipoServicio::class, 'osgo_servicios_orden', 'ID_ORDEN_SERVICIO', 'ID_TIPO_SERVICIO')
                    ->withPivot([
                        'ID_SERVICIO_ORDEN',
                        'HORARIO',
                        'PLACA_VEHICULO', 
                        'GRUPO_ASIGNADO',
                        'RESPONSABLE',
                        'CODIGO_RESPONSABLE',
                        'SECTOR_DESCRIPCION',
                        'NOVEDADES',
                        'OBSERVACIONES',
                        'ACTIVO'
                    ])
                    ->withTimestamps();
    }

    public function disposicionesGenerales()
    {
        return $this->belongsToMany(DisposicionGeneral::class, 'osgo_disposiciones_orden', 'ID_ORDEN_SERVICIO', 'ID_DISPOSICION')
                    ->withPivot([
                        'ID_DISPOSICION_ORDEN',
                        'INCLUIDA',
                        'OBSERVACIONES'
                    ])
                    ->withTimestamps();
    }


    //MÉTODOS INGRESADOS

    protected static function boot()
    {
        parent::boot();

        // Se dispara tanto en create() como en update()
        static::saving(function (OrdenServicio $model) {

            $model->FECHA_ACTUAL    ??= now();
            $model->ID_ESTADO_ORDEN ??= 1;

            /* 1) Calcula siempre NRO_ORDEN si falta */
            if ($model->FECHA && blank($model->NRO_ORDEN)) {
                $fecha       = Carbon::parse($model->FECHA);
                $daysInYear  = $fecha->isLeapYear() ? 366 : 365;
                $model->NRO_ORDEN = $daysInYear - $fecha->dayOfYear + 1;
            }

            /* ── 2) Valida duplicados por FECHA + USUARIO + DISTRITO ── */
            $duplicado = self::whereDate('FECHA', $model->FECHA)
                ->where('CREADO_POR', $model->CREADO_POR)
                ->where('DISTRITO',   $model->DISTRITO)
                ->when(
                    $model->exists,
                    fn($q) =>
                    $q->whereKeyNot($model->getKey())
                )
                ->exists();

            if ($duplicado) {
                throw ValidationException::withMessages([
                    'FECHA' => ['Ya existe una orden con el mismo número, usuario y distrito.'],
                ]);
            }

            /* ── 3) Fecha no puede ser pasada ── */
            if ($model->FECHA && Carbon::parse($model->FECHA)->lt(Carbon::today())) {
                throw ValidationException::withMessages([
                    'FECHA' => ['La fecha de la orden no puede ser anterior al día de hoy.'],
                ]);
            }
        });
    }

    /**
     * Sincroniza los funcionarios actuales con detalle_orden_servicio.
     *
     * @param  array  $funciones  Array ['clave' => persona_id, …]
     * @return void
     */

    /**
     * Sincroniza el detalle con el estado actual del formulario.
     *
     *  – Elimina inspectores/subinspectores anteriores (10-11)  
     *  – Crea o actualiza los registros con los datos en pantalla  
     *  – Borra los estáticos 1-9 que quedaron vacíos  
     *  – Actualiza horario y responsable de los administrativos 12-18,
     *    incluso si el usuario los deja en blanco (NULL)
     */
    public function syncDetalles(array $funciones, array $horarios = []): void
    {
        /* 1 ▸ Borra todas las filas variables antes de recrearlas -------------- */
        DetalleOrdenServicio::where('ID_ORDEN_SERVICIO', $this->ID_ORDEN_SERVICIO)
            ->whereIn('ID_FUNCION', array_merge(
                [10, 11],          // Inspectores / Sub-inspectores
                range(19, 29),     // Despacho
                range(30, 32),
                range(33, 35)     // Centros de Retención
            ))
            ->delete();

        $mapa                  = self::getMapaFunciones();   // slug → ID_FUNCION
        $idsPrincipalesActivos = [];                         // qué 1-9 conservar
        $cuenta10y11           = [10 => 0, 11 => 0];         // máx. 2
        $responsablesUsados    = [];                         // evita duplicados 10-11

        /* 2 ▸ Recorre todas las claves enviadas desde el formulario ------------- */
        foreach ($funciones as $clave => $personaId) {

            /* A ▸ Claves con índice  (rol_ID_N_id) ----------------------------- */
            if (preg_match('/^rol_(\d+)_([^_]+)_id$/', $clave, $m)) {
                $idFuncion = (int) $m[1];                   // 10, 24, 30…

                /* Lógica especial solo para 10-11 */
                if (in_array($idFuncion, [10, 11], true)) {
                    if ($cuenta10y11[$idFuncion] >= 2) {
                        continue;                           // tope alcanzado
                    }
                    if (
                        $personaId && $personaId !== 'S/S' &&
                        in_array($personaId, $responsablesUsados, true)
                    ) {
                        continue;                           // duplicado
                    }
                    $cuenta10y11[$idFuncion]++;
                    if ($personaId && $personaId !== 'S/S') {
                        $responsablesUsados[] = $personaId;
                    }
                }

                $this->guardarDetalle(
                    $idFuncion,
                    $personaId,
                    $this->valorHorario($horarios[$clave] ?? null),
                    false      // create
                );
                continue;
            }

            /* B ▸ Personal administrativo fijo (12-18) ------------------------- */
            if (preg_match('/^rol_(\d+)_id$/', $clave, $m)) {
                $idFuncion = (int) $m[1];
                $this->guardarDetalle(
                    $idFuncion,
                    $personaId,
                    $this->valorHorario($horarios[$clave] ?? null),
                    true       // updateOrCreate
                );
                continue;
            }

            /* C ▸ Funciones estáticas por ID (1-9) ----------------------------- */
            if (preg_match('/^funciones\.(\d+)$/', $clave, $m)) {
                $idFuncion = (int) $m[1];
                if (!blank($personaId) && $personaId !== 'null') {
                    $this->guardarDetalle($idFuncion, $personaId, null, true);
                    $idsPrincipalesActivos[] = $idFuncion;
                }
                continue;
            }

            /* D ▸ Funciones estáticas por slug --------------------------------- */
            if (str_starts_with($clave, 'funciones.')) {
                $slug = substr($clave, 10);
                if (!isset($mapa[$slug])) {
                    continue;
                }
                $idFuncion = (int) $mapa[$slug];
                if (!blank($personaId) && $personaId !== 'null') {
                    $this->guardarDetalle($idFuncion, $personaId, null, true);
                    $idsPrincipalesActivos[] = $idFuncion;
                }
            }
        }

        /* 3 ▸ Borra 1-9 que quedaron sin selección --------------------------- */
        DetalleOrdenServicio::where('ID_ORDEN_SERVICIO', $this->ID_ORDEN_SERVICIO)
            ->whereIn('ID_FUNCION', range(1, 9))
            ->whereNotIn('ID_FUNCION', $idsPrincipalesActivos)
            ->delete();
    }




    /**
     * Convierte string|int|null a ?int de forma segura.
     */
    /* Convierte string|int|null a ?int */
    private function valorHorario(mixed $valor): ?int
    {
        if ($valor === null || $valor === '' || $valor === 'null') {
            return null;
        }
        return (int) $valor;
    }

    /* Helper central */
    private function guardarDetalle(
        int   $idFuncion,
        mixed $personaId,
        ?int  $idHorario      = null,
        bool  $soloActualizar = false     // true → updateOrCreate, false → create
    ): void {
        /* 0 ▸ Normaliza horario a ?int ------------------------------------------ */
        $idHorario = $this->valorHorario($idHorario);

        $conHorario        = $idFuncion >= 10;               // 1-9 no usan horario
        $responsableVacio  = blank($personaId) || $personaId === 'null';
        $horarioVacio      = $idHorario === null;

        /* 1 ▸ Decide si omitir (create) o borrar (update) ------------------------ */
        if ($soloActualizar) {
            // UPDATE: elimina si la fila queda totalmente vacía
            if ((!$conHorario && $responsableVacio) ||        // 1-9 sin responsable
                ($conHorario  && $responsableVacio && $horarioVacio)
            ) { // ≥10 sin nada
                DetalleOrdenServicio::where([
                    'ID_ORDEN_SERVICIO' => $this->ID_ORDEN_SERVICIO,
                    'ID_FUNCION'        => $idFuncion,
                ])->delete();
                return;
            }
        } else {
            // CREATE: omite si no hay nada que guardar
            if ((!$conHorario && $responsableVacio) ||        // 1-9 sin responsable
                ($conHorario  && $responsableVacio && $horarioVacio)
            ) { // ≥10 sin nada
                return;
            }
        }

        /* 2 ▸ Obtiene nombre de la función -------------------------------------- */
        $funcionModel = Funcione::find($idFuncion);
        if (!$funcionModel) {
            return;                                          // ID desconocido
        }
        $funcionNombre = Str::of($funcionModel->FUNCION)
            ->replace('_', ' ')
            ->upper();

        /* 3 ▸ Procesa responsable ------------------------------------------------ */
        $codigo      = null;
        $responsable = null;

        if (is_numeric($personaId) && ($p = Persona::find($personaId))) {
            $codigo      = $p->CODIGO_AGENTE;
            $responsable = "{$p->NOMBRES} {$p->APELLIDOS}";
        } elseif ($personaId === 'S/S') {
            $responsable = 'S/S';
        }

        $data = [
            'ID_FUNCION'         => $idFuncion,
            'FUNCION'            => $funcionNombre,
            'CODIGO_RESPONSABLE' => $codigo,
            'RESPONSABLE'        => $responsable,
            'ID_HORARIO'         => $idHorario,
            'GRUPO_FUNCIONAL'    => 'PRINCIPAL',
        ];

        /* 4 ▸ Persiste ----------------------------------------------------------- */
        $soloActualizar
            ? DetalleOrdenServicio::updateOrCreate(
                [
                    'ID_ORDEN_SERVICIO' => $this->ID_ORDEN_SERVICIO,
                    'ID_FUNCION'        => $idFuncion,
                ],
                $data
            )
            : DetalleOrdenServicio::create($data + [
                'ID_ORDEN_SERVICIO' => $this->ID_ORDEN_SERVICIO,
            ]);
    }




    /* --------------------------------------------------------------------
 |  Devuelve un mapa [ slug => ID_FUNCION ] en caché (1 h, por ejemplo)
 |  Para no golpear la BD en cada syncDetalles o cada carga del form
 * ------------------------------------------------------------------*/
    private static function getMapaFunciones(): array
    {
        return Cache::remember('mapa_funciones_slug', 3600, function () {
            return Funcione::all()
                ->mapWithKeys(function ($row) {
                    $slug = Str::of($row->FUNCION)->lower()->snake()->toString(); // ej. gerente_operativo
                    return [$slug => $row->ID_FUNCION];                          // 'gerente_operativo' => 1
                })
                ->toArray();
        });
    }
}
