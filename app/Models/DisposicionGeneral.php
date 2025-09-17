<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DisposicionGeneral extends Model
{
    use HasFactory;

    protected $connection = 'osgo';
    protected $table = 'osgo_disposiciones_generales';
    protected $primaryKey = 'ID_DISPOSICION';

    protected $fillable = [
        'NUMERO_DISPOSICION',
        'TITULO',
        'CONTENIDO',
        'CATEGORIA',
        'ES_OBLIGATORIA',
        'ACTIVO'
    ];

    protected $casts = [
        'ES_OBLIGATORIA' => 'boolean',
        'ACTIVO' => 'boolean',
    ];

    // Relaciones
    public function disposicionesOrden()
    {
        return $this->hasMany(DisposicionOrden::class, 'ID_DISPOSICION', 'ID_DISPOSICION');
    }

    public function ordenesServicio()
    {
        return $this->belongsToMany(OrdenServicio::class, 'osgo_disposiciones_orden', 'ID_DISPOSICION', 'ID_ORDEN_SERVICIO')
                    ->withPivot([
                        'ID_DISPOSICION_ORDEN',
                        'INCLUIDA',
                        'OBSERVACIONES'
                    ])
                    ->withTimestamps();
    }


    // Scopes
    public function scopeActivas($query)
    {
        return $query->where('ACTIVO', true);
    }

    public function scopeObligatorias($query)
    {
        return $query->where('ES_OBLIGATORIA', true)->where('ACTIVO', true);
    }

    public function scopePorCategoria($query, $categoria)
    {
        return $query->where('CATEGORIA', $categoria);
    }

    // Métodos estáticos útiles
    public static function todasParaFormulario()
    {
        return static::activas()
            ->orderBy('NUMERO_DISPOSICION')
            ->get()
            ->groupBy('CATEGORIA')
            ->map(function ($disposiciones) {
                return $disposiciones->map(function ($disposicion) {
                    return [
                        'id' => $disposicion->ID_DISPOSICION,
                        'numero' => $disposicion->NUMERO_DISPOSICION,
                        'titulo' => $disposicion->TITULO,
                        'contenido' => $disposicion->CONTENIDO,
                        'obligatoria' => $disposicion->ES_OBLIGATORIA,
                        'categoria' => $disposicion->CATEGORIA
                    ];
                });
            });
    }

    public static function obligatoriasParaOrden()
    {
        return static::obligatorias()
            ->orderBy('NUMERO_DISPOSICION')
            ->pluck('ID_DISPOSICION')
            ->toArray();
    }

    // Accessor para mostrar en formularios
    public function getTextoCompletoAttribute()
    {
        return $this->NUMERO_DISPOSICION . '. ' . $this->TITULO;
    }

    public function getResumenAttribute()
    {
        return strlen($this->CONTENIDO) > 100 
            ? substr($this->CONTENIDO, 0, 97) . '...'
            : $this->CONTENIDO;
    }
}