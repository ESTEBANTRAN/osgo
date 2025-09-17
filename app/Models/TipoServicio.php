<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoServicio extends Model
{
    use HasFactory;

    protected $connection = 'osgo';
    protected $table = 'osgo_tipos_servicio';
    protected $primaryKey = 'ID_TIPO_SERVICIO';

    protected $fillable = [
        'TIPO_SERVICIO',
        'DESCRIPCION',
        'CATEGORIA',
        'REQUIERE_VEHICULO',
        'REQUIERE_HORARIO',
        'REQUIERE_SECTOR',
        'ACTIVO'
    ];

    protected $casts = [
        'REQUIERE_VEHICULO' => 'boolean',
        'REQUIERE_HORARIO' => 'boolean',
        'REQUIERE_SECTOR' => 'boolean',
        'ACTIVO' => 'boolean',
    ];

    // Relaciones
    public function serviciosOrden()
    {
        return $this->hasMany(ServicioOrden::class, 'ID_TIPO_SERVICIO', 'ID_TIPO_SERVICIO');
    }

    public function ordenesServicio()
    {
        return $this->belongsToMany(OrdenServicio::class, 'osgo_servicios_orden', 'ID_TIPO_SERVICIO', 'ID_ORDEN_SERVICIO')
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

    // Scopes
    public function scopeActivos($query)
    {
        return $query->where('ACTIVO', true);
    }

    public function scopePorCategoria($query, $categoria)
    {
        return $query->where('CATEGORIA', $categoria);
    }

    // Métodos estáticos útiles
    public static function opcionesParaFormulario()
    {
        return static::activos()
            ->orderBy('CATEGORIA')
            ->orderBy('TIPO_SERVICIO')
            ->get()
            ->groupBy('CATEGORIA')
            ->map(function ($tipos) {
                return $tipos->pluck('TIPO_SERVICIO', 'ID_TIPO_SERVICIO');
            });
    }

    public static function porCategoria($categoria)
    {
        return static::activos()
            ->porCategoria($categoria)
            ->pluck('TIPO_SERVICIO', 'ID_TIPO_SERVICIO');
    }
}