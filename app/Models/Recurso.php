<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Recurso extends Model
{
    protected $connection = 'osgo';
    protected $table = 'osgo_recursos';
    protected $primaryKey = 'ID_RECURSO';
    public $timestamps = true;

    protected $casts = [
        'ACTIVO' => 'boolean',
    ];

    protected $fillable = [
        'NOMBRE_RECURSO',
        'TIPO_RECURSO',
        'DESCRIPCION',
        'UNIDAD_MEDIDA',
        'ACTIVO',
    ];

    /**
     * Relación con anexo_recursos
     */
    public function anexoRecursos(): HasMany
    {
        return $this->hasMany(AnexoRecurso::class, 'ID_RECURSO', 'ID_RECURSO');
    }

    /**
     * Scope para recursos activos
     */
    public function scopeActivos($query)
    {
        return $query->where('ACTIVO', true);
    }

    /**
     * Scope para filtrar por tipo de recurso
     */
    public function scopePorTipo($query, string $tipo)
    {
        return $query->where('TIPO_RECURSO', $tipo);
    }
}
