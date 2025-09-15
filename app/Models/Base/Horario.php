<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\DetalleOrdenServicio;
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
 * @package App\Models\Base
 */
class Horario extends Model
{
	protected $table = 'osgo_horarios';
	protected $primaryKey = 'ID_HORARIO';
	public $timestamps = false;

	protected $casts = [
		'HORA_INICIO' => 'datetime',
		'HORA_FIN' => 'datetime',
		'duracion_horas' => 'int'
	];

	public function detalle_orden_servicios()
	{
		return $this->hasMany(DetalleOrdenServicio::class, 'ID_HORARIO');
	}
}
