<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\GrupoOperativo;
use App\Models\Persona;
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
 * @package App\Models\Base
 */
class Funcione extends Model
{
	protected $table = 'funciones';
	protected $primaryKey = 'ID_FUNCION';
	public $timestamps = false;

	protected $casts = [
		'id_grupo_operativo' => 'int'
	];

	public function grupo_operativo()
	{
		return $this->belongsTo(GrupoOperativo::class, 'id_grupo_operativo');
	}

	public function personas()
	{
		return $this->hasMany(Persona::class, 'ID_FUNCION');
	}
}
