<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class GrupoOperativo
 * 
 * @property int $ID_GRUPO_OPERATIVO
 * @property string|null $GRUPO_OPERATIVO
 * @property string|null $ACTIVO
 * 
 * @property TipoGrupo|null $tipo_grupo
 * @property Collection|Funcione[] $funciones
 *
 * @package App\Models
 */
class GrupoOperativo extends Model
{
    protected $connection = 'principal';
	protected $table = 'grupo_operativo';
	protected $primaryKey = 'ID_GRUPO_OPERATIVO';
	public $timestamps = false;

	protected $fillable = [
		'GRUPO_OPERATIVO',
		'ACTIVO'
	];

	public function funciones()
	{
		return $this->hasMany(
			Funcione::class,          // modelo hijo
			'ID_GRUPO_OPERATIVO',     // FK en funciones
			'ID_GRUPO_OPERATIVO'      // PK local
		);
	}

	public static function options(): array
	{
		return static::query()
			->selectRaw("ID_GRUPO_OPERATIVO, TRIM(COALESCE(GRUPO_OPERATIVO, '')) AS label")
			->orderBy('label')
			->get()
			->filter(fn ($row) => ($row->label ?? '') !== '')
			->mapWithKeys(fn ($row) => [$row->ID_GRUPO_OPERATIVO => (string) $row->label])
			->toArray();
	}
}
