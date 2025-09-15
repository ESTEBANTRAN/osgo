<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

class Anexo extends Model
{
    protected $connection = 'osgo';
    protected $table = 'osgo_anexo';
    protected $primaryKey = 'ID_ANEXO';
    public $timestamps = false;

    protected $casts = [
        'ID_ORDEN_SERVICIO' => 'int',
        'FECHA' => 'date',
        'HORA_FORMACION' => 'datetime',
        'HORA_INICIO' => 'datetime',
        'HORA_FIN' => 'datetime',
    ];

    protected $fillable = [
        'ID_ORDEN_SERVICIO',
        'TIPO_ANEXO',
        'NOMBRE',
        'ORGANIZADOR',
        'TELEFONO_ORGANIZADOR',
        'FECHA',
        'HORA_FORMACION',
        'HORA_INICIO',
        'HORA_FIN',
        'LUGAR',
        'MANDO',
        'JEFE_CONTROL',
        'MISION',
        'GESTION_REQUERIDA',
        'RECORRIDO',
        'ANTECEDENTES',
        'INSTRUCCIONES_COORDINACION',
        'RUTAGRAMA_IMAGEN',
        'NOTAS_RUTAGRAMA',
        'ESTADO',
        'CREADO_POR',
    ];

    public function ordenServicio()
    {
        return $this->belongsTo(OrdenServicio::class, 'ID_ORDEN_SERVICIO');
    }

    public function detalles()
    {
        return $this->hasMany(AnexoDetalle::class, 'ID_ANEXO');
    }

    public function recursos()
    {
        return $this->hasMany(AnexoRecurso::class, 'ID_ANEXO');
    }
}


