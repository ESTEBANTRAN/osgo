<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Funcione;
use App\Models\TipoGrupo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class GrupoOperativo
 * 
 * @property int $ID_GRUPO_OPERATIVO
 * @property string|null $GRUPO_OPERATIVO
 * @property string|null $ACTIVO
 * 
 * @property TipoGrupo|null $tipo_grupo
 * @property Collection|Funcione[] $funciones
 *
 * @package App\Models\Base
 */
class GrupoOperativo extends Model
{
	protected $table = 'grupo_operativo';
	protected $primaryKey = 'ID_GRUPO_OPERATIVO';
	public $timestamps = false;

	public function funciones()
	{
		return $this->hasMany(Funcione::class, 'id_grupo_operativo');
	}
}
