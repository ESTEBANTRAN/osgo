<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Verificar y corregir tipos de datos antes de agregar FKs
        $this->fixDataTypes();
        
        // Agregar FKs después de corregir tipos
        $this->addForeignKeys();
        
        // Agregar índices
        $this->addIndexes();
    }

    private function fixDataTypes(): void
    {
        // Verificar si id_funcion existe y renombrarlo usando SQL directo
        if (Schema::hasTable('osgo_detalle_orden_servicio')) {
            if (Schema::hasColumn('osgo_detalle_orden_servicio', 'id_funcion')) {
                DB::statement('ALTER TABLE osgo_detalle_orden_servicio CHANGE id_funcion ID_FUNCION INT(11)');
            }
        }
    }

    private function addForeignKeys(): void
    {
        // FK de osgo_detalle_orden_servicio a funciones
        if (Schema::hasTable('osgo_detalle_orden_servicio') && Schema::hasTable('funciones')) {
            $exists = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='osgo_detalle_orden_servicio' AND CONSTRAINT_NAME='fk_detalle_funcion'");
            if (!$exists || (int) $exists->c === 0) {
                try {
                    Schema::table('osgo_detalle_orden_servicio', function (Blueprint $table) {
                        $table->foreign('ID_FUNCION', 'fk_detalle_funcion')
                              ->references('ID_FUNCION')
                              ->on('funciones')
                              ->onDelete('restrict');
                    });
                } catch (Exception $e) {
                    // Si falla, solo agregar índice
                    Schema::table('osgo_detalle_orden_servicio', function (Blueprint $table) {
                        $table->index(['ID_FUNCION'], 'idx_detalle_funcion');
                    });
                }
            }
        }

        // FK de osgo_anexo a osgo_orden_servicio
        if (Schema::hasTable('osgo_anexo') && Schema::hasTable('osgo_orden_servicio')) {
            $exists = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='osgo_anexo' AND CONSTRAINT_NAME='fk_anexo_orden'");
            if (!$exists || (int) $exists->c === 0) {
                try {
                    Schema::table('osgo_anexo', function (Blueprint $table) {
                        $table->foreign('ID_ORDEN_SERVICIO', 'fk_anexo_orden')
                              ->references('ID_ORDEN_SERVICIO')
                              ->on('osgo_orden_servicio')
                              ->onDelete('cascade');
                    });
                } catch (Exception $e) {
                    Schema::table('osgo_anexo', function (Blueprint $table) {
                        $table->index(['ID_ORDEN_SERVICIO'], 'idx_anexo_orden');
                    });
                }
            }
        }

        // FK de osgo_anexo_detalle a osgo_anexo
        if (Schema::hasTable('osgo_anexo_detalle') && Schema::hasTable('osgo_anexo')) {
            $exists = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='osgo_anexo_detalle' AND CONSTRAINT_NAME='fk_anexo_detalle_anexo'");
            if (!$exists || (int) $exists->c === 0) {
                try {
                    Schema::table('osgo_anexo_detalle', function (Blueprint $table) {
                        $table->foreign('ID_ANEXO', 'fk_anexo_detalle_anexo')
                              ->references('ID_ANEXO')
                              ->on('osgo_anexo')
                              ->onDelete('cascade');
                    });
                } catch (Exception $e) {
                    Schema::table('osgo_anexo_detalle', function (Blueprint $table) {
                        $table->index(['ID_ANEXO'], 'idx_anexo_detalle_anexo');
                    });
                }
            }
        }
    }

    private function addIndexes(): void
    {
        // Índices para osgo_orden_servicio
        if (Schema::hasTable('osgo_orden_servicio')) {
            Schema::table('osgo_orden_servicio', function (Blueprint $table) {
                if (!$this->indexExists('osgo_orden_servicio', 'idx_orden_fecha')) {
                    $table->index(['FECHA'], 'idx_orden_fecha');
                }
                if (!$this->indexExists('osgo_orden_servicio', 'idx_orden_estado')) {
                    $table->index(['ID_ESTADO_ORDEN'], 'idx_orden_estado');
                }
                if (!$this->indexExists('osgo_orden_servicio', 'idx_orden_creado_por')) {
                    $table->index(['CREADO_POR'], 'idx_orden_creado_por');
                }
            });
        }

        // Índices para osgo_anexo
        if (Schema::hasTable('osgo_anexo')) {
            Schema::table('osgo_anexo', function (Blueprint $table) {
                if (!$this->indexExists('osgo_anexo', 'idx_anexo_tipo')) {
                    $table->index(['TIPO_ANEXO'], 'idx_anexo_tipo');
                }
                if (!$this->indexExists('osgo_anexo', 'idx_anexo_fecha')) {
                    $table->index(['FECHA'], 'idx_anexo_fecha');
                }
                if (!$this->indexExists('osgo_anexo', 'idx_anexo_estado')) {
                    $table->index(['ESTADO'], 'idx_anexo_estado');
                }
            });
        }

        // Índices para osgo_detalle_orden_servicio
        if (Schema::hasTable('osgo_detalle_orden_servicio')) {
            Schema::table('osgo_detalle_orden_servicio', function (Blueprint $table) {
                if (!$this->indexExists('osgo_detalle_orden_servicio', 'idx_detalle_responsable')) {
                    $table->index(['RESPONSABLE'], 'idx_detalle_responsable');
                }
            });
        }

        // Índices para osgo_control_horas
        if (Schema::hasTable('osgo_control_horas')) {
            Schema::table('osgo_control_horas', function (Blueprint $table) {
                if (!$this->indexExists('osgo_control_horas', 'idx_control_persona')) {
                    $table->index(['ID_PERSONA'], 'idx_control_persona');
                }
                if (!$this->indexExists('osgo_control_horas', 'idx_control_estado')) {
                    $table->index(['ESTADO'], 'idx_control_estado');
                }
            });
        }

        // Índices para personas
        if (Schema::hasTable('personas')) {
            Schema::table('personas', function (Blueprint $table) {
                if (!$this->indexExists('personas', 'idx_persona_funcion')) {
                    $table->index(['ID_FUNCION'], 'idx_persona_funcion');
                }
                if (!$this->indexExists('personas', 'idx_persona_grupo')) {
                    $table->index(['ID_GRUPO_OPERATIVO'], 'idx_persona_grupo');
                }
                if (!$this->indexExists('personas', 'idx_persona_agente')) {
                    $table->index(['AGENTE'], 'idx_persona_agente');
                }
            });
        }
    }

    private function indexExists(string $table, string $index): bool
    {
        $result = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND INDEX_NAME = ?", [$table, $index]);
        return $result && (int) $result->c > 0;
    }

    public function down(): void
    {
        // Revertir cambios si es necesario
    }
};
