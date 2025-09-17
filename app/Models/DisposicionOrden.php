<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DisposicionOrden extends Model
{
    use HasFactory;

    protected $connection = 'osgo';
    protected $table = 'osgo_disposiciones_orden';
    protected $primaryKey = 'ID_DISPOSICION_ORDEN';

    protected $fillable = [
        'ID_ORDEN_SERVICIO',
        'ID_DISPOSICION',
        'INCLUIDA',
        'OBSERVACIONES'
    ];

    protected $casts = [
        'INCLUIDA' => 'boolean',
    ];

    // Relaciones
    public function ordenServicio()
    {
        return $this->belongsTo(OrdenServicio::class, 'ID_ORDEN_SERVICIO', 'ID_ORDEN_SERVICIO');
    }

    public function disposicionGeneral()
    {
        return $this->belongsTo(DisposicionGeneral::class, 'ID_DISPOSICION', 'ID_DISPOSICION');
    }

    // Scopes
    public function scopeIncluidas($query)
    {
        return $query->where('INCLUIDA', true);
    }

    public function scopePorOrden($query, $idOrden)
    {
        return $query->where('ID_ORDEN_SERVICIO', $idOrden);
    }
}