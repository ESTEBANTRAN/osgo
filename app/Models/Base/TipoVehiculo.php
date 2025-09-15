<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Vehiculo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class TipoVehiculo
 * 
 * @property int $ID_TIPO_VEHICULO
 * @property string|null $TIPO_VEHICULO
 * 
 * @property Collection|Vehiculo[] $vehiculos
 *
 * @package App\Models\Base
 */
class TipoVehiculo extends Model
{
	protected $table = 'osgo_tipo_vehiculo';
	protected $primaryKey = 'ID_TIPO_VEHICULO';
	public $timestamps = false;

	public function vehiculos()
	{
		return $this->hasMany(Vehiculo::class, 'ID_TIPO_VEHICULO');
	}
}
