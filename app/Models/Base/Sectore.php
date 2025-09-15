<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\DetalleOrdenServicio;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Sectore
 * 
 * @property int $ID_SECTOR
 * @property string|null $SECTOR
 * @property string|null $DISTRITO
 * @property string|null $CANTON
 * @property string|null $ACTIVO
 * 
 * @property Collection|DetalleOrdenServicio[] $detalle_orden_servicios
 *
 * @package App\Models\Base
 */
class Sectore extends Model
{
	protected $table = 'osgo_sectores';
	protected $primaryKey = 'ID_SECTOR';
	public $timestamps = false;

	public function detalle_orden_servicios()
	{
		return $this->hasMany(DetalleOrdenServicio::class, 'ID_SECTOR');
	}
}
