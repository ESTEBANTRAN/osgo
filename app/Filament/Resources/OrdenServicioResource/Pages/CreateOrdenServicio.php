<?php
declare(strict_types=1);

namespace App\Filament\Resources\OrdenServicioResource\Pages;

use App\Filament\Resources\OrdenServicioResource;
use App\Models\OrdenServicio;
use Filament\Actions\Action;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Validation\ValidationException;

class CreateOrdenServicio extends CreateRecord
{
    protected static string $resource = OrdenServicioResource::class;

    protected static ?string $title      = 'Crear Orden de Servicio';
    protected static ?string $breadcrumb = 'Crear';

    /* -----------------------------------------------------------------
     | 1. Acciones del formulario
     * -----------------------------------------------------------------*/
    /** Suprimimos los botones inferiores del wizard */
    protected function getFormActions(): array
    {
        return [];
    }

    /** Botón fijo en la esquina superior derecha */
    protected function getHeaderActions(): array
    {
        return [
            Action::make('guardarDraft')
                ->label('Guardar progreso')
                ->icon('heroicon-o-cloud-arrow-down')
                ->color('primary')
                ->keyBindings(['ctrl+s'])
                ->submit(null)          // evita el submit con validación HTML
                ->action('guardarDraft'),
        ];
    }

    public static function canCreate(): bool
    {
        return Gate::allows('crear-orden-servicio');
    }

    /* -----------------------------------------------------------------
     | 2. Lógica de “Guardar progreso”
     * -----------------------------------------------------------------*/
    public function guardarDraft(): void
    {
        $raw = $this->form->getRawState();

        /* ───── 0. Fecha obligatoria ───── */
        if (blank($raw['FECHA'] ?? null)) {
            $this->addError('FECHA', 'La fecha de la orden es obligatoria para registrar el borrador.');
            Notification::make()
                ->danger()
                ->title('Acción requerida')
                ->body('Seleccione la fecha de la orden y vuelva a pulsar «Guardar progreso».')
                ->send();
            return;
        }

        /* ───── 1. Duplicados en Encargados de Control (func. 10-11) ───── */
        $idsRepetidos = collect($raw['control']['jefe_control'] ?? [])
            ->pluck('responsable_id')
            ->filter(fn($id) => $id && $id !== 'S/S')
            ->duplicates()
            ->all();

        if ($idsRepetidos) {
            $this->addError(
                'control.jefe_control',
                'Un mismo responsable no puede ocupar más de un horario de control.'
            );

            Notification::make()
                ->danger()
                ->title('Responsable duplicado')
                ->body('Un mismo responsable se repite en los horarios de control. Ajusta la selección antes de guardar.')
                ->send();
            return;                  
        }

        /* ───── 2. Validación de duplicados de grúas ───── */
        $gruasSeleccionadas = collect($raw['educacion']['grua'] ?? [])
            ->pluck('servicio_grua_id')
            ->filter()
            ->unique()
            ->values();

        $duplicados = collect($raw['educacion']['grua'] ?? [])
            ->pluck('servicio_grua_id')
            ->groupBy(fn($value) => $value)
            ->filter(fn($group) => $group->count() > 1);

        if ($duplicados->isNotEmpty()) {
            $this->addError(
                'educacion.grua',
                'No puedes seleccionar la misma grúa más de una vez.'
            );

            Notification::make()
                ->danger()
                ->title('Servicio de Grúa duplicado')
                ->body('Has seleccionado la misma grúa más de una vez. Por favor, elige diferentes servicios de grúa.')
                ->send();
            return;
        }

        /* ───── 3. Datos de cabecera ───── */
        $data = $raw + [
            'CREADO_POR'      => Auth::user()->NAME,
            'ID_ESTADO_ORDEN' => 1,
            'FECHA_ACTUAL'    => now(),
        ];

        /* ───── 4. Construye $funciones y $horarios ───── */
        $funciones = [];
        $horarios  = [];

        /* 3.1 ▸ Personal Administrativo (12-18) */
        foreach ($raw['control']['personal_admin']['funciones'] ?? [] as $item) {
            $key             = 'rol_' . $item['funcion_id'] . '_id';
            $funciones[$key] = $item['responsable_id'];
            $horarios[$key]  = $item['horario_id'] ?? null;
        }

        /* 3.2 ▸ Encargados de Control (10-11) */
        foreach ($raw['control']['jefe_control'] ?? [] as $i => $item) {
            $key             = 'rol_' . $item['funcion_id'] . "_{$i}_id";
            $funciones[$key] = $item['responsable_id'];
            $horarios[$key]  = $item['horario_id'] ?? null;
        }

        /* 3.3 ▸ Funciones estáticas (1-9) */
        foreach ($raw['funciones'] ?? [] as $clave => $personaId) {
            $funciones['funciones.' . $clave] = $personaId;
        }

        /*  Despacho y Centros de Retención  (funciones 19-32)  */
        foreach (
            [
                'despacho.sala_ops',
                'despacho.video_vig',
                'despacho.terminal',
                'retencion.retvplus',
                'retencion.av13',
                'retencion.cdit',
                'grupos.gestion_op',     // ← NEW
                'grupos.informalidad',   // ← NEW
                'grupos.embriaguez',     // ← NEW
            ] as $grupo
        ) {
            foreach (data_get($raw, $grupo, []) as $i => $item) {
                $key             = 'rol_' . $item['funcion_id'] . "_{$i}_id";
                $funciones[$key] = $item['responsable_id'];
                $horarios[$key]  = $item['horario_id'] ?? null;
            }
        }

        /* ───── 5. Persistencia ───── */
        try {
            $this->record
                ? $this->record->update($data)
                : $this->record = OrdenServicio::create($data);

            // Sincroniza los detalles con las funciones y horarios
            $this->record->syncDetalles($funciones, $horarios);

            // --- ASOCIAR SERVICIOS DE GRÚA PARTICULARES TAMBIÉN EN BORRADOR ---
            // Obtén las grúas actualmente seleccionadas
            $gruasSeleccionadas = collect($raw['educacion']['grua'] ?? [])
                ->pluck('servicio_grua_id')
                ->filter()
                ->unique()
                ->all();

            // Sincroniza las grúas seleccionadas
            if ($gruasSeleccionadas) {
                $this->record->serviciosGrua()->sync($gruasSeleccionadas);  // Esto eliminará las grúas no seleccionadas
            } else {
                // Si no hay grúas seleccionadas, limpia la relación
                $this->record->serviciosGrua()->detach();
            }

            // Notificación de éxito
            Notification::make()
                ->success()
                ->title('Progreso guardado')
                ->body('Se guardó tu avance a las ' . now()->format('H:i') . '.')
                ->send();
        } catch (ValidationException $e) {
            $this->setErrorBag($e->errors());
            Notification::make()
                ->danger()
                ->title('No se pudo guardar')
                ->body(collect($e->errors())->flatten()->join("\n"))
                ->send();
        }
    }

    /* -----------------------------------------------------------------
     | 3. Redirección al finalizar el wizard (botón Crear Orden)
     * -----------------------------------------------------------------*/
    protected function getRedirectUrl(): string
    {
        return static::getResource()::getUrl('index');
    }

    /* -----------------------------------------------------------------
     | 4. Procesamiento adicional al crear la orden definitiva
     * -----------------------------------------------------------------*/
    /** Guarda las asignaciones persona-función para afterCreate() */
    protected array $funciones = [];
    protected array $horarios  = [];

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $state           = $this->form->getState();   // estado reactivo del form
        $this->funciones = [];
        $this->horarios  = [];

        /* 1 ▸ Encargados de Control (10-11) */
        foreach ($state['control']['jefe_control'] ?? [] as $i => $item) {
            $key                    = 'rol_' . $item['funcion_id'] . "_{$i}_id";
            $this->funciones[$key]  = $item['responsable_id'];
            $this->horarios[$key]   = $item['horario_id'] ?? null;
        }

        /* 2 ▸ Personal Administrativo (12-18) */
        foreach ($state['control']['personal_admin']['funciones'] ?? [] as $item) {
            $key                    = 'rol_' . $item['funcion_id'] . '_id';
            $this->funciones[$key]  = $item['responsable_id'];
            $this->horarios[$key]   = $item['horario_id'] ?? null;
        }

        /* 3 ▸ Funciones estáticas (1-9) */
        foreach ($state['funciones'] ?? [] as $clave => $personaId) {
            $this->funciones['funciones.' . $clave] = $personaId;
        }

        /* 4 ▸ Despacho + Centros de Retención + Grupos Operativos Especiales */
        foreach (
            [
                'despacho.sala_ops',
                'despacho.video_vig',
                'despacho.terminal',
                'retencion.retvplus',
                'retencion.av13',
                'retencion.cdit',
                'grupos.gestion_op',
                'grupos.informalidad',
                'grupos.embriaguez',
            ] as $grupo
        ) {
            foreach (data_get($state, $grupo, []) as $i => $item) {
                $key                    = 'rol_' . $item['funcion_id'] . "_{$i}_id";
                $this->funciones[$key]  = $item['responsable_id'];
                $this->horarios[$key]   = $item['horario_id'] ?? null;
            }
        }

        /* 5 ▸ Limpia nodos que no van a la cabecera ----------------------- */
        unset($data['control']);
        unset($data['despacho']);
        unset($data['retencion']);
        unset($data['grupos']);
        unset($data['educacion']);


        /* 6 ▸ Devuelve sólo los campos de la cabecera --------------------- */
        return [
            'FECHA'      => $data['FECHA']     ?? $data['fecha']    ?? null,
            'DISTRITO'   => $data['DISTRITO']  ?? $data['distrito'] ?? null,
            'CANTON'     => $data['CANTON']    ?? $data['canton']   ?? null,
            'CREADO_POR' => Auth::user()->NAME,
        ];
    }



    protected function afterCreate(): void
    {
        // Sincroniza todo el detalle (incluye horarios)
        $this->record->syncDetalles($this->funciones, $this->horarios);

        // --- ASOCIAR SERVICIOS DE GRÚA PARTICULARES ---
        $state = $this->form->getState();
        $gruas = collect($state['educacion']['grua'] ?? [])
            ->pluck('servicio_grua_id')
            ->filter()
            ->unique()
            ->all();

        if ($gruas) {
            $this->record->serviciosGrua()->sync($gruas);
        }
    }
}