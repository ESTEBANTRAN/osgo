<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Indisponibilidad;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class TipoIndisponibilidad
 * 
 * @property int $ID_TIPO_INDISPONIBILIDAD
 * @property string|null $TIPO_INDISPONIBILIDAD
 * @property string|null $ESTADO
 * 
 * @property Collection|Indisponibilidad[] $indisponibilidads
 *
 * @package App\Models\Base
 */
class TipoIndisponibilidad extends Model
{
    protected $connection = 'principal';
	protected $table = 'tipo_indisponibilidad';
	protected $primaryKey = 'ID_TIPO_INDISPONIBILIDAD';
	public $timestamps = false;

	public function indisponibilidads()
	{
		return $this->hasMany(Indisponibilidad::class, 'ID_TIPO_INDISPONIBILIDAD');
	}
}
