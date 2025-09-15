<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Normalizar campos a MAYÚSCULAS
        $this->normalizeFieldNames();
        
        // 2. Desconectar tablas de recursos (vehículos independientes)
        $this->disconnectResourceTables();
        
        // 3. Agregar FK faltante en historial_horas
        $this->addMissingForeignKey();
        
        // 4. Eliminar tablas duplicadas
        $this->removeDuplicateTables();
    }

    private function normalizeFieldNames(): void
    {
        // osgo_users: id -> ID_USUARIO
        if (Schema::hasColumn('osgo_users', 'id') && !Schema::hasColumn('osgo_users', 'ID_USUARIO')) {
            DB::statement('ALTER TABLE osgo_users CHANGE COLUMN id ID_USUARIO INT(11) AUTO_INCREMENT');
        }
        
        // osgo_control_horas_mensuales: id -> ID_CONTROL_MENSUAL
        if (Schema::hasColumn('osgo_control_horas_mensuales', 'id') && !Schema::hasColumn('osgo_control_horas_mensuales', 'ID_CONTROL_MENSUAL')) {
            DB::statement('ALTER TABLE osgo_control_horas_mensuales CHANGE COLUMN id ID_CONTROL_MENSUAL INT(11) AUTO_INCREMENT');
        }
        
        // password_reset_tokens: email -> EMAIL
        if (Schema::hasColumn('password_reset_tokens', 'email') && !Schema::hasColumn('password_reset_tokens', 'EMAIL')) {
            DB::statement('ALTER TABLE password_reset_tokens CHANGE COLUMN email EMAIL VARCHAR(255)');
        }
        
        // sessions: id -> ID_SESSION
        if (Schema::hasColumn('sessions', 'id') && !Schema::hasColumn('sessions', 'ID_SESSION')) {
            DB::statement('ALTER TABLE sessions CHANGE COLUMN id ID_SESSION VARCHAR(255)');
        }
    }

    private function disconnectResourceTables(): void
    {
        // Eliminar FK de osgo_vehiculo a osgo_tipo_vehiculo
        try {
            DB::statement('ALTER TABLE osgo_vehiculo DROP FOREIGN KEY fk_tipo_vehiculo');
        } catch (\Throwable $e) {
            // FK no existe, continuar
        }
        
        // Eliminar columna ID_TIPO_VEHICULO de osgo_vehiculo
        if (Schema::hasColumn('osgo_vehiculo', 'ID_TIPO_VEHICULO')) {
            DB::statement('ALTER TABLE osgo_vehiculo DROP COLUMN ID_TIPO_VEHICULO');
        }
    }

    private function addMissingForeignKey(): void
    {
        // Agregar columna ID_ORDEN_SERVICIO a osgo_historial_horas si no existe
        if (!Schema::hasColumn('osgo_historial_horas', 'ID_ORDEN_SERVICIO')) {
            DB::statement('ALTER TABLE osgo_historial_horas ADD COLUMN ID_ORDEN_SERVICIO INT(11) AFTER ID_CONTROL_HORAS');
        }
        
        // Agregar FK de osgo_historial_horas a osgo_orden_servicio
        $exists = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='osgo_historial_horas' AND CONSTRAINT_NAME='fk_historial_horas_orden'");
        if (!$exists || (int) $exists->c === 0) {
            DB::statement("ALTER TABLE osgo_historial_horas ADD CONSTRAINT fk_historial_horas_orden FOREIGN KEY (ID_ORDEN_SERVICIO) REFERENCES osgo_orden_servicio(ID_ORDEN_SERVICIO) ON DELETE CASCADE");
        }
    }

    private function removeDuplicateTables(): void
    {
        // Eliminar osgo_horario (duplicada de osgo_horarios)
        if (Schema::hasTable('osgo_horario')) {
            // Primero eliminar FKs que referencian osgo_horario
            try {
                DB::statement('ALTER TABLE osgo_detalle_orden_servicio DROP FOREIGN KEY osgo_detalle_orden_servicio_ibfk_4');
            } catch (\Throwable $e) {
                // FK no existe, continuar
            }
            
            Schema::dropIfExists('osgo_horario');
        }
    }

    public function down(): void
    {
        // Revertir cambios si es necesario
        // (Implementación de rollback si se requiere)
    }
};
