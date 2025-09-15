<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Sectore
 * 
 * @property int $ID_SECTOR
 * @property string|null $SECTOR
 * @property string|null $DISTRITO
 * @property string|null $CANTON
 * @property string|null $ACTIVO
 *
 * @package App\Models
 */
class Sectore extends Model
{
    protected $connection = 'osgo';
	protected $table = 'osgo_sectores';
	protected $primaryKey = 'ID_SECTOR';
	public $timestamps = false;

	protected $fillable = [
		'SECTOR',
		'DISTRITO',
		'CANTON',
		'ACTIVO'
	];

	public static function options(): array
	{
		return static::query()
			->selectRaw("ID_SECTOR, TRIM(COALESCE(SECTOR, '')) AS label")
			->orderBy('label')
			->get()
			->filter(fn ($row) => ($row->label ?? '') !== '')
			->mapWithKeys(fn ($row) => [$row->ID_SECTOR => (string) $row->label])
			->toArray();
	}
}
