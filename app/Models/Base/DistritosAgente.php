<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Persona;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class DistritosAgente
 * 
 * @property int $ID_DISTRITO_AGENTE
 * @property string|null $DISTRITO
 * @property string|null $CANTON
 * 
 * @property Collection|Persona[] $personas
 *
 * @package App\Models\Base
 */
class DistritosAgente extends Model
{
	protected $table = 'distritos_agentes';
	protected $primaryKey = 'ID_DISTRITO_AGENTE';
	public $timestamps = false;

	public function personas()
	{
		return $this->hasMany(Persona::class, 'ID_DISTRITO_AGENTE');
	}
}
