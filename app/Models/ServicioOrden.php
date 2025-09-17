<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServicioOrden extends Model
{
    use HasFactory;

    protected $connection = 'osgo';
    protected $table = 'osgo_servicios_orden';
    protected $primaryKey = 'ID_SERVICIO_ORDEN';

    protected $fillable = [
        'ID_ORDEN_SERVICIO',
        'ID_TIPO_SERVICIO',
        'HORARIO',
        'PLACA_VEHICULO',
        'GRUPO_ASIGNADO',
        'RESPONSABLE',
        'CODIGO_RESPONSABLE',
        'SECTOR_DESCRIPCION',
        'NOVEDADES',
        'OBSERVACIONES',
        'ACTIVO'
    ];

    protected $casts = [
        'ACTIVO' => 'boolean',
    ];

    // Relaciones
    public function ordenServicio()
    {
        return $this->belongsTo(OrdenServicio::class, 'ID_ORDEN_SERVICIO', 'ID_ORDEN_SERVICIO');
    }

    public function tipoServicio()
    {
        return $this->belongsTo(TipoServicio::class, 'ID_TIPO_SERVICIO', 'ID_TIPO_SERVICIO');
    }

    // Scopes
    public function scopeActivos($query)
    {
        return $query->where('ACTIVO', true);
    }

    public function scopePorOrden($query, $idOrden)
    {
        return $query->where('ID_ORDEN_SERVICIO', $idOrden);
    }

    public function scopePorTipo($query, $tipoServicio)
    {
        return $query->whereHas('tipoServicio', function ($q) use ($tipoServicio) {
            $q->where('CATEGORIA', $tipoServicio);
        });
    }

    // Accessors
    public function getRequiereVehiculoAttribute()
    {
        return $this->tipoServicio?->REQUIERE_VEHICULO ?? false;
    }

    public function getCategoriaServicioAttribute()
    {
        return $this->tipoServicio?->CATEGORIA ?? 'GENERAL';
    }
}