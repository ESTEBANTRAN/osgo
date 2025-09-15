<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HorarioTrabajo extends Model
{
    protected $table = 'osgo_horarios';
    protected $primaryKey = 'ID_HORARIO';
    public $timestamps = false;

    protected $casts = [
        'HORA_INICIO' => 'int',
        'HORA_FIN' => 'int',
    ];

    protected $fillable = [
        'NOMBRE',
        'HORA_INICIO',
        'HORA_FIN',
        'ACTIVO',
    ];
}


