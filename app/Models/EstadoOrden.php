<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

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
 * @package App\Models
 */
class EstadoOrden extends Model
{
    protected $connection = 'osgo';
	protected $table = 'osgo_estado_orden';
	protected $primaryKey = 'ID_ESTADO_ORDEN';
	public $timestamps = false;

	protected $fillable = [
		'ESTADO_ORDEN',
		'DESCRIPCION'
	];

	public function orden_servicios()
	{
		return $this->hasMany(OrdenServicio::class, 'ID_ESTADO_ORDEN');
	}
}
