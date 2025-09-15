<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AnexoRecurso extends Model
{
    protected $connection = 'osgo';
    protected $table = 'osgo_anexo_recurso';
    protected $primaryKey = 'ID_ANEXO_RECURSO';
    public $timestamps = true;

    protected $casts = [
        'ID_ANEXO' => 'int',
        'ID_RECURSO' => 'int',
        'CANTIDAD' => 'int',
    ];

    protected $fillable = [
        'ID_ANEXO',
        'ID_RECURSO',
        'TIPO_RECURSO',
        'CANTIDAD',
        'OBSERVACIONES',
    ];

    /**
     * Relación con el recurso del catálogo
     */
    public function recurso(): BelongsTo
    {
        return $this->belongsTo(Recurso::class, 'ID_RECURSO', 'ID_RECURSO');
    }

    /**
     * Relación con el anexo
     */
    public function anexo(): BelongsTo
    {
        return $this->belongsTo(Anexo::class, 'ID_ANEXO', 'ID_ANEXO');
    }
}


