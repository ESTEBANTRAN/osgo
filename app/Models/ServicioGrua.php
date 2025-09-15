<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class ServicioGrua extends Model
{
    protected $connection = 'osgo';
    // Nombre de la tabla
    protected $table = 'osgo_servicio_grua';

    // Clave primaria real
    protected $primaryKey = 'ID_SERVICIO_GRUA';

    // Si no tienes created_at/updated_at
    public $timestamps = false;

    // Columnas asignables
    protected $fillable = [
        'PROPIETARIO',
        'CONTRATO',
        'TELEFONO',
    ];

    /**
     * Relación M-M con OrdenServicio
     */
    public function ordenesServicio(): BelongsToMany
    {
        return $this->belongsToMany(
            OrdenServicio::class,        // el modelo relacionado
            'orden_servicio_grua',       // tabla pivote
            'ID_SERVICIO_GRUA',          // FK en pivote hacia este modelo
            'ID_ORDEN_SERVICIO'          // FK en pivote hacia OrdenServicio
        )
        // Si quieres usar tu modelo pivot personalizado:
        ->using(OrdenServicioGrua::class)
        // Para incluir el ID de la propia fila pivote si lo necesitas:
        ->withPivot('ID_ORDEN_GRUA');
    }
}
