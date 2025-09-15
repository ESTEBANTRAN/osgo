<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\OrdenServicio;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class EstadoOrden
 * 
 * @property int $ID_ESTADO_ORDEN
 * @property string|null $ESTADO_ORDEN
 * @property string|null $DESCRIPCION
 * 
 * @property Collection|OrdenServicio[] $orden_servicios
 *
 * @package App\Models\Base
 */
class EstadoOrden extends Model
{
	protected $table = 'osgo_estado_orden';
	protected $primaryKey = 'ID_ESTADO_ORDEN';
	public $timestamps = false;

	public function orden_servicios()
	{
		return $this->hasMany(OrdenServicio::class, 'ID_ESTADO_ORDEN');
	}
}
