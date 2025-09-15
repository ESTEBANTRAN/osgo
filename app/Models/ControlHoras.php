<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ControlHoras extends Model
{
    protected $connection = 'osgo';
    protected $table = 'osgo_control_horas';
    protected $primaryKey = 'ID_CONTROL_HORAS';
    public $timestamps = false;

    protected $casts = [
        'ID_PERSONA' => 'int',
        'FECHA' => 'date',
        'HORAS_TRABAJADAS' => 'float',
    ];

    protected $fillable = [
        'ID_PERSONA',
        'FECHA',
        'HORAS_TRABAJADAS',
        'ESTADO',
    ];

    public function persona()
    {
        return $this->belongsTo(Persona::class, 'ID_PERSONA');
    }
}


