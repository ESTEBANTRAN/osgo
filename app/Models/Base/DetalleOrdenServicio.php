<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Horario;
use App\Models\OrdenServicio;
use App\Models\Sectore;
use App\Models\Vehiculo;
use Illuminate\Database\Eloquent\Model;

/**
 * Class DetalleOrdenServicio
 * 
 * @property int $ID_DET_ORDEN_SERVICIO
 * @property int|null $ID_ORDEN_SERVICIO
 * @property string|null $FUNCION
 * @property string|null $CODIGO_RESPONSABLE
 * @property string|null $RESPONSABLE
 * @property int|null $ID_SECTOR
 * @property int|null $ID_VEHICULO
 * @property int|null $ID_HORARIO
 * @property string|null $NOVEDADES
 * @property string|null $OBSERVACION
 * 
 * @property OrdenServicio|null $orden_servicio
 * @property Horario|null $horario
 * @property Sectore|null $sectore
 * @property Vehiculo|null $vehiculo
 *
 * @package App\Models\Base
 */
class DetalleOrdenServicio extends Model
{
	protected $table = 'osgo_detalle_orden_servicio';
	protected $primaryKey = 'ID_DET_ORDEN_SERVICIO';
	public $timestamps = false;

	protected $casts = [
		'ID_ORDEN_SERVICIO' => 'int',
		'ID_SECTOR' => 'int'
	];

	public function orden_servicio()
	{
		return $this->belongsTo(OrdenServicio::class, 'ID_ORDEN_SERVICIO');
	}

	// Relación con horario eliminada - tabla huérfana

	public function sectore()
	{
		return $this->belongsTo(Sectore::class, 'ID_SECTOR');
	}

	public function vehiculo()
	{
		return $this->belongsTo(Vehiculo::class, 'ID_VEHICULO');
	}

	public function persona()
	{
		return $this->belongsTo(Persona::class, 'CODIGO_RESPONSABLE', 'CODIGO_AGENTE');
	}
}
