<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

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
 * @package App\Models
 */
class Vehiculo extends Model
{
    protected $connection = 'osgo';
	protected $table = 'osgo_vehiculo';
	protected $primaryKey = 'ID_VEHICULO';
	public $timestamps = false;

	protected $casts = [
		'ID_TIPO_VEHICULO' => 'int'
	];

	protected $fillable = [
		'PLACA',
		'ID_TIPO_VEHICULO',
		'ACTIVO'
	];

	public function tipo_vehiculo()
	{
		return $this->belongsTo(TipoVehiculo::class, 'ID_TIPO_VEHICULO');
	}

	public function detalle_orden_servicios()
	{
		return $this->hasMany(DetalleOrdenServicio::class, 'ID_VEHICULO');
	}

	public static function options(): array
	{
		return static::query()
			->selectRaw("ID_VEHICULO, TRIM(COALESCE(PLACA, '')) AS label")
			->orderBy('label')
			->get()
			->filter(fn ($row) => ($row->label ?? '') !== '')
			->mapWithKeys(fn ($row) => [$row->ID_VEHICULO => (string) $row->label])
			->toArray();
	}
}
