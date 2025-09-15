<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\DetalleOrdenServicio;
use App\Models\EstadoOrden;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class OrdenServicio
 * 
 * @property int $ID_ORDEN_SERVICIO
 * @property string|null $NRO_ORDEN
 * @property Carbon|null $FECHA
 * @property string|null $DISTRITO
 * @property string|null $CANTON
 * @property string|null $CREADO_POR
 * @property int|null $ID_ESTADO_ORDEN
 * @property Carbon|null $FECHA_ACTUAL
 * 
 * @property EstadoOrden|null $estado_orden
 * @property Collection|DetalleOrdenServicio[] $detalle_orden_servicios
 *
 * @package App\Models\Base
 */
class OrdenServicio extends Model
{
	protected $table = 'osgo_orden_servicio';
	protected $primaryKey = 'ID_ORDEN_SERVICIO';
	public $timestamps = false;

	protected $casts = [
		'FECHA' => 'datetime',
		'ID_ESTADO_ORDEN' => 'int',
		'FECHA_ACTUAL' => 'datetime'
	];

	public function estado_orden()
	{
		return $this->belongsTo(EstadoOrden::class, 'ID_ESTADO_ORDEN');
	}

	public function detalle_orden_servicios()
	{
		return $this->hasMany(DetalleOrdenServicio::class, 'ID_ORDEN_SERVICIO');
	}
}
