<?php
declare(strict_types=1);

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'osgo_users';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'ID_USUARIO';

    /**
     * Customize timestamp column names to match uppercase schema.
     */
    public const CREATED_AT = 'CREATED_AT';
    public const UPDATED_AT = 'UPDATED_AT';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'NAME',
        'EMAIL',
        'PASSWORD',
        'ROL_ID',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'PASSWORD',
        'REMEMBER_TOKEN',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    // Use casts() method below; property removed to avoid duplication issues

    /**
     * Get the role that owns the user.
     */
    public function rol()
    {
        return $this->belongsTo(Rol::class, 'ROL_ID', 'ID');
    }

    /**
     * Check if the user has a specific role.
     *
     * @param string $roleName
     * @return bool
     */
    public function hasRole($roleName)
    {
        return $this->rol && $this->rol->NOMBRE === $roleName;
    }

    /**
     * Check if the user is a 'responsable_operativo'.
     *
     * @return bool
     */
    public function isResponsableOperativo()
    {
        return $this->hasRole('responsable_operativo');
    }

    /**
     * Check if the user is a 'jefe_distrito'.
     *
     * @return bool
     */
    public function isJefeDistrito()
    {
        return $this->hasRole('jefe_distrito');
    }

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'EMAIL_VERIFIED_AT' => 'datetime',
            'PASSWORD' => 'hashed',
        ];
    }

    /**
     * Use custom remember token column name.
     */
    public function getRememberTokenName(): string
    {
        return 'REMEMBER_TOKEN';
    }

    /**
     * Use custom password column name.
     */
    public function getAuthPassword(): string
    {
        return (string) $this->getAttribute('PASSWORD');
    }

    /**
     * Accessor to expose lowercase 'name' expected by packages like Filament.
     */
    public function getNameAttribute(): ?string
    {
        $name = $this->attributes['NAME'] ?? null;
        return is_string($name) && $name !== '' ? $name : null;
    }

    /**
     * Accessor to expose lowercase 'email'.
     */
    public function getEmailAttribute(): ?string
    {
        return $this->attributes['EMAIL'] ?? null;
    }

    /**
     * Filament display name.
     */
    public function getFilamentName(): string
    {
        $name  = $this->attributes['NAME'] ?? null;
        $email = $this->attributes['EMAIL'] ?? null;
        return is_string($name) && $name !== ''
            ? $name
            : ((string) ($email ?? 'Usuario'));
    }
}
