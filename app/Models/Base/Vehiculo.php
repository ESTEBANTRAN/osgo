<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\DetalleOrdenServicio;
use App\Models\TipoVehiculo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Vehiculo
 * 
 * @property int $ID_VEHICULO
 * @property string|null $PLACA
 * @property int|null $ID_TIPO_VEHICULO
 * @property string|null $ACTIVO
 * 
 * @property TipoVehiculo|null $tipo_vehiculo
 * @property Collection|DetalleOrdenServicio[] $detalle_orden_servicios
 *
 * @package App\Models\Base
 */
class Vehiculo extends Model
{
	protected $table = 'osgo_vehiculo';
	protected $primaryKey = 'ID_VEHICULO';
	public $timestamps = false;

	protected $casts = [
		'ID_TIPO_VEHICULO' => 'int'
	];

	public function tipo_vehiculo()
	{
		return $this->belongsTo(TipoVehiculo::class, 'ID_TIPO_VEHICULO');
	}

	public function detalle_orden_servicios()
	{
		return $this->hasMany(DetalleOrdenServicio::class, 'ID_VEHICULO');
	}
}
