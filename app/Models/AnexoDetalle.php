<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AnexoDetalle extends Model
{
    protected $connection = 'osgo';
    protected $table = 'osgo_anexo_detalle';
    protected $primaryKey = 'ID_ANEXO_DETALLE';
    public $timestamps = false;

    protected $casts = [
        'ID_ANEXO' => 'int',
        'ORDEN' => 'int',
    ];

    protected $fillable = [
        'ID_ANEXO',
        'ORDEN',
        'RESPONSABLE',
        'FUNCION',
        'PUESTO_SERVICIO',
        'OBSERVACION',
    ];

    public function anexo()
    {
        return $this->belongsTo(Anexo::class, 'ID_ANEXO');
    }
}


