<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Funcione
 * 
 * @property int $ID_FUNCION
 * @property string|null $FUNCION
 * @property string|null $ESTADO_FUNCION
 * @property int|null $id_grupo_operativo
 * 
 * @property GrupoOperativo|null $grupo_operativo
 * @property Collection|Persona[] $personas
 *
 * @package App\Models
 */
class Funcione extends Model
{
    // Use principal system database
    protected $connection = 'principal';
	protected $table = 'funciones';
	protected $primaryKey = 'ID_FUNCION';
	public $timestamps = false;

	protected $casts = [
		'ID_GRUPO_OPERATIVO' => 'int'
	];

	protected $fillable = [
		'FUNCION',
		'ESTADO_FUNCION',
		'ID_GRUPO_OPERATIVO'
	];

	public function grupo_operativo()
	{
		return $this->belongsTo(
        GrupoOperativo::class,    // modelo padre
        'ID_GRUPO_OPERATIVO',     // FK en esta tabla
        'ID_GRUPO_OPERATIVO'      // PK en grupo_operativo
    );
	}

	public function personas()
	{
		return $this->hasMany(Persona::class, 'ID_FUNCION');
	}
}
