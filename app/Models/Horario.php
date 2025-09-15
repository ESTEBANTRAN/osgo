<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Horario
 * 
 * @property int $ID_HORARIO
 * @property Carbon|null $HORA_INICIO
 * @property Carbon|null $HORA_FIN
 * @property string|null $NOMBRE
 * @property int|null $duracion_horas
 * 
 * @property Collection|DetalleOrdenServicio[] $detalle_orden_servicios
 *
 * @package App\Models
 */
class Horario extends Model
{
    protected $connection = 'osgo';
	protected $table = 'osgo_horarios';
	protected $primaryKey = 'ID_HORARIO';
	public $timestamps = false;

	protected $casts = [
		'HORA_INICIO' => 'datetime',
		'HORA_FIN' => 'datetime',
		'duracion_horas' => 'int'
	];

	protected $fillable = [
		'HORA_INICIO',
		'HORA_FIN',
		'NOMBRE',
		'duracion_horas'
	];

	public function detalle_orden_servicios()
	{
		return $this->hasMany(DetalleOrdenServicio::class, 'ID_HORARIO');
	}

	public static function options(): array
	{
		return static::query()
			->selectRaw("ID_HORARIO, TRIM(COALESCE(NOMBRE, '')) AS label")
			->orderBy('label')
			->get()
			->filter(fn ($row) => ($row->label ?? '') !== '')
			->mapWithKeys(fn ($row) => [$row->ID_HORARIO => (string) $row->label])
			->toArray();
	}
}
