<?php
declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Rol extends Model
{
    use SoftDeletes;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'osgo_roles';

    /**
     * Customize timestamp column names to match uppercase schema.
     */
    public const CREATED_AT = 'CREATED_AT';
    public const UPDATED_AT = 'UPDATED_AT';
    public const DELETED_AT = 'DELETED_AT';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'NOMBRE',
        'DESCRIPCION',
        'ACTIVO'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'ACTIVO' => 'boolean',
    ];

    /**
     * Get the users for the role.
     */
    public function users()
    {
        return $this->hasMany(User::class, 'ROL_ID');
    }
}
