<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\TipoIndisponibilidad;
use App\Models\Usuario;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Indisponibilidad
 * 
 * @property int $ID_INDISPONIBILIDAD
 * @property int|null $ID_USUARIO
 * @property int|null $ID_TIPO_INDISPONIBILIDAD
 * @property Carbon|null $FECHA_DESDE
 * @property Carbon|null $FECHA_HASTA
 * 
 * @property Usuario|null $usuario
 * @property TipoIndisponibilidad|null $tipo_indisponibilidad
 *
 * @package App\Models\Base
 */
class Indisponibilidad extends Model
{
    protected $connection = 'principal';
	protected $table = 'indisponibilidad';
	protected $primaryKey = 'ID_INDISPONIBILIDAD';
	public $timestamps = false;

	protected $casts = [
		'ID_USUARIO' => 'int',
		'ID_TIPO_INDISPONIBILIDAD' => 'int',
		'FECHA_DESDE' => 'datetime',
		'FECHA_HASTA' => 'datetime'
	];

	public function usuario()
	{
		return $this->belongsTo(Usuario::class, 'ID_USUARIO');
	}

	public function tipo_indisponibilidad()
	{
		return $this->belongsTo(TipoIndisponibilidad::class, 'ID_TIPO_INDISPONIBILIDAD');
	}
}
