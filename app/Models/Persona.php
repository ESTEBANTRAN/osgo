<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

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
 * @package App\Models
 */
class Persona extends Model
{
    // Use principal system database
    protected $connection = 'principal';
	protected $table = 'personas';
	protected $primaryKey = 'ID_PERSONA';
	public $timestamps = false;

	protected $casts = [
		'ID_DISTRITO_AGENTE' => 'int',
		'ID_FUNCION' => 'int'
	];

	protected $fillable = [
		'ID_DISTRITO_AGENTE',
		'ID_FUNCION',
		'CEDULA',
		'NOMBRES',
		'APELLIDOS',
		'CODIGO_AGENTE',
		'TELEFONO_AGENTE',
		'AGENTE',
		'EMAIL'
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


	/*
	//MÉTODOS INGRESADOS
	public static function opcionesPorFuncion(int $funcionId): array
	{
		return static::query()
			->join('usuarios AS u', 'u.ID_PERSONA', '=', 'personas.ID_PERSONA')
			->leftJoin('indisponibilidad AS i', function ($join) {
				$join->on('i.ID_USUARIO', '=', 'u.ID_USUARIO')
					->where('i.FECHA_DESDE', '<=', now())
					->where('i.FECHA_HASTA', '>=', now());
			})
			->where('personas.ID_FUNCION', $funcionId)
			//->where('personas.AGENTE', 'SI')
			->where('u.ESTADO', 'AC')
			->whereNull('i.ID_INDISPONIBILIDAD')
			->selectRaw("CONCAT(personas.NOMBRES, ' ', personas.APELLIDOS) AS full, personas.ID_PERSONA")
			->pluck('full', 'ID_PERSONA')
			->toArray();
	}*/


	public static function opcionesPorFuncion(?int $funcionId): array
	{
		if (is_null($funcionId)) {
			return [];
		}

		$rows = static::query()
			->join('usuarios AS u', 'u.ID_PERSONA', '=', 'personas.ID_PERSONA')
			->leftJoin('indisponibilidad AS i', function ($join) {
				$join->on('i.ID_USUARIO', '=', 'u.ID_USUARIO')
					->where('i.FECHA_DESDE', '<=', now())
					->where('i.FECHA_HASTA', '>=', now());
			})
			->where('personas.ID_FUNCION', $funcionId)
			->where('u.ESTADO', 'AC')
			->whereNull('i.ID_INDISPONIBILIDAD')
			->selectRaw("TRIM(CONCAT(COALESCE(personas.NOMBRES, ''), ' ', COALESCE(personas.APELLIDOS, ''))) AS full, personas.ID_PERSONA AS id_persona")
			->get();

		return $rows
			->filter(function ($row) {
				return isset($row->full) && $row->full !== '';
			})
			->mapWithKeys(function ($row) {
				return [$row->id_persona => (string) $row->full];
			})
			->toArray();
	}
}
