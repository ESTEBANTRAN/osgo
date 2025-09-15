<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Indisponibilidad;
use App\Models\Persona;
use App\Models\Sistema;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Usuario
 * 
 * @property int $ID_USUARIO
 * @property int|null $ID_PERSONA
 * @property string|null $USUARIO
 * @property string|null $PASS
 * @property string|null $ESTADO
 * @property string|null $HASH
 * @property Carbon|null $FECHA
 * 
 * @property Persona|null $persona
 * @property Collection|Indisponibilidad[] $indisponibilidads
 * @property Collection|Sistema[] $sistemas
 *
 * @package App\Models\Base
 */
class Usuario extends Model
{
    protected $connection = 'principal';
	protected $table = 'usuarios';
	protected $primaryKey = 'ID_USUARIO';
	public $timestamps = false;

	protected $casts = [
		'ID_PERSONA' => 'int',
		'FECHA' => 'datetime'
	];

	public function persona()
	{
		return $this->belongsTo(Persona::class, 'ID_PERSONA');
	}

	public function indisponibilidads()
	{
		return $this->hasMany(Indisponibilidad::class, 'ID_USUARIO');
	}

	public function sistemas()
	{
		return $this->belongsToMany(Sistema::class, 'usuario_sistema', 'ID_USUARIO', 'ID_SISTEMA')
					->withPivot('ID_USUARIO_SISTEMA', 'ESTADO_USUARIO_SISTEMA');
	}
}
