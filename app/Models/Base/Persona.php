<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\DistritosAgente;
use App\Models\Funcione;
use App\Models\Usuario;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Persona
 * 
 * @property int $ID_PERSONA
 * @property int|null $ID_DISTRITO_AGENTE
 * @property int|null $ID_FUNCION
 * @property string|null $CEDULA
 * @property string|null $NOMBRES
 * @property string|null $APELLIDOS
 * @property string|null $CODIGO_AGENTE
 * @property string|null $TELEFONO_AGENTE
 * @property string|null $AGENTE
 * @property string|null $EMAIL
 * 
 * @property DistritosAgente|null $distritos_agente
 * @property Funcione|null $funcione
 * @property Collection|Usuario[] $usuarios
 *
 * @package App\Models\Base
 */
class Persona extends Model
{
	protected $table = 'personas';
	protected $primaryKey = 'ID_PERSONA';
	public $timestamps = false;

	protected $casts = [
		'ID_DISTRITO_AGENTE' => 'int',
		'ID_FUNCION' => 'int'
	];

	public function distritos_agente()
	{
		return $this->belongsTo(DistritosAgente::class, 'ID_DISTRITO_AGENTE');
	}

	public function funcione()
	{
		return $this->belongsTo(Funcione::class, 'ID_FUNCION');
	}

	public function usuarios()
	{
		return $this->hasMany(Usuario::class, 'ID_PERSONA');
	}
}
