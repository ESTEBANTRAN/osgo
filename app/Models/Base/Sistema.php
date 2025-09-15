<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Usuario;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Sistema
 * 
 * @property int $ID_SISTEMA
 * @property string|null $NOMBRE_SISTEMA
 * @property string|null $ESTADO_SISTEMA
 * 
 * @property Collection|Usuario[] $usuarios
 *
 * @package App\Models\Base
 */
class Sistema extends Model
{
    protected $connection = 'principal';
	protected $table = 'sistemas';
	protected $primaryKey = 'ID_SISTEMA';
	public $timestamps = false;

	public function usuarios()
	{
		return $this->belongsToMany(Usuario::class, 'usuario_sistema', 'ID_SISTEMA', 'ID_USUARIO')
					->withPivot('ID_USUARIO_SISTEMA', 'ESTADO_USUARIO_SISTEMA');
	}
}
