<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Eliminar FK de osgo_detalle_orden_servicio a osgo_vehiculo
        $this->removeVehicleForeignKeys();
        
        // 2. Eliminar FK de osgo_anexo_recurso a osgo_anexo
        $this->removeResourceForeignKeys();
        
        // 3. Eliminar FK de osgo_detalle_orden_servicio a osgo_horarios
        $this->removeHorarioForeignKeys();
    }

    private function removeVehicleForeignKeys(): void
    {
        // Eliminar FK de osgo_detalle_orden_servicio a osgo_vehiculo
        try {
            DB::statement('ALTER TABLE osgo_detalle_orden_servicio DROP FOREIGN KEY fk_detalle_vehiculo');
        } catch (\Throwable $e) {
            // FK no existe, continuar
        }
        
        // Eliminar columna ID_VEHICULO de osgo_detalle_orden_servicio
        if (Schema::hasColumn('osgo_detalle_orden_servicio', 'ID_VEHICULO')) {
            DB::statement('ALTER TABLE osgo_detalle_orden_servicio DROP COLUMN ID_VEHICULO');
        }
    }

    private function removeResourceForeignKeys(): void
    {
        // Eliminar FK de osgo_anexo_recurso a osgo_anexo
        try {
            DB::statement('ALTER TABLE osgo_anexo_recurso DROP FOREIGN KEY fk_anexo_recurso_anexo');
        } catch (\Throwable $e) {
            // FK no existe, continuar
        }
        
        // Eliminar columna ID_ANEXO de osgo_anexo_recurso
        if (Schema::hasColumn('osgo_anexo_recurso', 'ID_ANEXO')) {
            DB::statement('ALTER TABLE osgo_anexo_recurso DROP COLUMN ID_ANEXO');
        }
    }

    private function removeHorarioForeignKeys(): void
    {
        // Eliminar FK de osgo_detalle_orden_servicio a osgo_horarios
        try {
            DB::statement('ALTER TABLE osgo_detalle_orden_servicio DROP FOREIGN KEY osgo_detalle_orden_servicio_ibfk_4');
        } catch (\Throwable $e) {
            // FK no existe, continuar
        }
        
        // Eliminar columna ID_HORARIO de osgo_detalle_orden_servicio
        if (Schema::hasColumn('osgo_detalle_orden_servicio', 'ID_HORARIO')) {
            DB::statement('ALTER TABLE osgo_detalle_orden_servicio DROP COLUMN ID_HORARIO');
        }
    }

    public function down(): void
    {
        // Revertir cambios si es necesario
        // (Implementación de rollback si se requiere)
    }
};
