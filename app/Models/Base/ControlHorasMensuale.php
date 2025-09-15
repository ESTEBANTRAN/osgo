<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

/**
 * Class ControlHorasMensuale
 * 
 * @property int $id
 * @property string|null $CODIGO_AGENTE
 * @property string|null $NOMBRES
 * @property string|null $APELLIDOS
 * @property int|null $ANIO
 * @property int|null $MES
 * @property int|null $HORAS_TRABAJADAS
 * @property int|null $HORAS_EXTRAS
 * @property int|null $HORAS_FALTANTES
 *
 * @package App\Models\Base
 */
class ControlHorasMensuale extends Model
{
	protected $table = 'osgo_control_horas_mensuales';
	public $timestamps = false;

	protected $casts = [
		'ANIO' => 'int',
		'MES' => 'int',
		'HORAS_TRABAJADAS' => 'int',
		'HORAS_EXTRAS' => 'int',
		'HORAS_FALTANTES' => 'int'
	];
}
