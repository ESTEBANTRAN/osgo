<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\GrupoOperativo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class TipoGrupo
 * 
 * @property int $ID_TIPO_GRUPO
 * @property string|null $TIPO_GRUPO
 * @property string|null $DESCRIPCION
 * 
 * @property Collection|GrupoOperativo[] $grupo_operativos
 *
 * @package App\Models\Base
 */
class TipoGrupo extends Model
{
    protected $connection = 'principal';
	protected $table = 'tipo_grupo';
	protected $primaryKey = 'ID_TIPO_GRUPO';
	public $timestamps = false;

	public function grupo_operativos()
	{
		return $this->hasMany(GrupoOperativo::class, 'ID_TIPO_GRUPO');
	}
}
