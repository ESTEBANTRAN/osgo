<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class DetalleOrdenServicio
 * 
 * @property int $ID_DET_ORDEN_SERVICIO
 * @property int|null $ID_ORDEN_SERVICIO
 * @property int|null $ID_FUNCION
 * @property string|null $GRUPO_FUNCIONAL
 * @property string|null $FUNCION
 * @property string|null $RESPONSABLE
 * @property string|null $SECTOR
 * @property string|null $NOVEDADES
 * @property string|null $OBSERVACION
 * @property string|null $HORARIO
 * @property string|null $TIPO_SERVICIO
 * @property string|null $PLACA_VEHICULO
 * @property string|null $GRUPO_ASIGNADO
 * @property string|null $CIRCUITO
 * @property string|null $DESCRIPCION_RUTA
 * @property string|null $TIPO_VEHICULO
 * @property bool|null $REQUIERE_ACOMPANANTE
 * @property string|null $ACOMPANANTE
 * @property string|null $INSTRUCCIONES_ESPECIALES
 *
 * @package App\Models
 */
class DetalleOrdenServicio extends Model
{
    protected $connection = 'osgo';
	protected $table = 'osgo_detalle_orden_servicio';
	protected $primaryKey = 'ID_DET_ORDEN_SERVICIO';
	public $timestamps = false;

	protected $casts = [
		'ID_ORDEN_SERVICIO' => 'int',
		'ID_FUNCION' => 'int',
		'REQUIERE_ACOMPANANTE' => 'bool'
	];

	protected $fillable = [
		'ID_ORDEN_SERVICIO',
		'ID_FUNCION',
		'GRUPO_FUNCIONAL',
		'FUNCION',
		'RESPONSABLE',
		'SECTOR',
		'NOVEDADES',
		'OBSERVACION',
		'HORARIO',
		'TIPO_SERVICIO',
		'PLACA_VEHICULO',
		'GRUPO_ASIGNADO',
		'CIRCUITO',
		'DESCRIPCION_RUTA',
		'TIPO_VEHICULO',
		'REQUIERE_ACOMPANANTE',
		'ACOMPANANTE',
		'INSTRUCCIONES_ESPECIALES'
	];

	public function orden_servicio()
	{
		return $this->belongsTo(OrdenServicio::class, 'ID_ORDEN_SERVICIO');
	}

	public function funcion()
	{
		return $this->belongsTo(Funcione::class, 'ID_FUNCION');
	}
}
