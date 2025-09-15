<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models\Base;

use App\Models\Sistema;
use App\Models\Usuario;
use Illuminate\Database\Eloquent\Model;

/**
 * Class UsuarioSistema
 * 
 * @property int $ID_USUARIO_SISTEMA
 * @property int|null $ID_SISTEMA
 * @property int|null $ID_USUARIO
 * @property string|null $ESTADO_USUARIO_SISTEMA
 * 
 * @property Sistema|null $sistema
 * @property Usuario|null $usuario
 *
 * @package App\Models\Base
 */
class UsuarioSistema extends Model
{
    protected $connection = 'principal';
	protected $table = 'usuario_sistema';
	protected $primaryKey = 'ID_USUARIO_SISTEMA';
	public $timestamps = false;

	protected $casts = [
		'ID_SISTEMA' => 'int',
		'ID_USUARIO' => 'int'
	];

	public function sistema()
	{
		return $this->belongsTo(Sistema::class, 'ID_SISTEMA');
	}

	public function usuario()
	{
		return $this->belongsTo(Usuario::class, 'ID_USUARIO');
	}
}
