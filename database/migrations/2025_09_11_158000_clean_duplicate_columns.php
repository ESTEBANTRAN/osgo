<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Limpiar tabla osgo_anexo - eliminar columnas duplicadas
        if (Schema::hasTable('osgo_anexo')) {
            Schema::table('osgo_anexo', function (Blueprint $table) {
                // Eliminar FECHA_ANEXO duplicada
                if (Schema::hasColumn('osgo_anexo', 'FECHA_ANEXO')) {
                    $table->dropColumn('FECHA_ANEXO');
                }
                // Eliminar OBSERVACIONES duplicada
                if (Schema::hasColumn('osgo_anexo', 'OBSERVACIONES')) {
                    $table->dropColumn('OBSERVACIONES');
                }
            });
        }

        // 2. Corregir tabla osgo_anexo_detalle - agregar campos faltantes
        if (Schema::hasTable('osgo_anexo_detalle')) {
            Schema::table('osgo_anexo_detalle', function (Blueprint $table) {
                // Agregar campos faltantes según esquema aprobado
                if (!Schema::hasColumn('osgo_anexo_detalle', 'ORDEN')) {
                    $table->integer('ORDEN')->after('ID_ANEXO');
                }
                if (!Schema::hasColumn('osgo_anexo_detalle', 'RESPONSABLE')) {
                    $table->string('RESPONSABLE', 200)->after('ORDEN');
                }
                if (!Schema::hasColumn('osgo_anexo_detalle', 'FUNCION')) {
                    $table->string('FUNCION', 100)->after('RESPONSABLE');
                }
                if (!Schema::hasColumn('osgo_anexo_detalle', 'PUESTO_SERVICIO')) {
                    $table->string('PUESTO_SERVICIO', 300)->nullable()->after('FUNCION');
                }
                if (!Schema::hasColumn('osgo_anexo_detalle', 'OBSERVACION')) {
                    $table->string('OBSERVACION', 300)->nullable()->after('PUESTO_SERVICIO');
                }
                
                // Eliminar campos que no deben existir
                if (Schema::hasColumn('osgo_anexo_detalle', 'ID_PERSONA')) {
                    $table->dropColumn('ID_PERSONA');
                }
                if (Schema::hasColumn('osgo_anexo_detalle', 'FUNCION_ASIGNADA')) {
                    $table->dropColumn('FUNCION_ASIGNADA');
                }
            });
        }

        // 3. Corregir tabla osgo_anexo_recurso - cambiar TIPO_RECURSO a varchar(50)
        if (Schema::hasTable('osgo_anexo_recurso')) {
            Schema::table('osgo_anexo_recurso', function (Blueprint $table) {
                // Cambiar TIPO_RECURSO de ENUM a VARCHAR(50) según esquema aprobado
                if (Schema::hasColumn('osgo_anexo_recurso', 'TIPO_RECURSO')) {
                    $table->dropColumn('TIPO_RECURSO');
                }
                $table->string('TIPO_RECURSO', 50)->after('ID_ANEXO');
            });
        }

        // 4. Corregir tabla osgo_horario - agregar campos faltantes
        if (Schema::hasTable('osgo_horario')) {
            Schema::table('osgo_horario', function (Blueprint $table) {
                if (!Schema::hasColumn('osgo_horario', 'HORA_INICIO')) {
                    $table->time('HORA_INICIO')->after('ID_HORARIO');
                }
                if (!Schema::hasColumn('osgo_horario', 'HORA_FIN')) {
                    $table->time('HORA_FIN')->after('HORA_INICIO');
                }
                if (!Schema::hasColumn('osgo_horario', 'descripcion')) {
                    $table->string('descripcion', 20)->after('HORA_FIN');
                }
                if (!Schema::hasColumn('osgo_horario', 'duracion_horas')) {
                    $table->integer('duracion_horas')->after('descripcion');
                }
            });
        }

        // 5. Corregir tabla osgo_users - cambiar id a ID_USUARIO
        if (Schema::hasTable('osgo_users')) {
            Schema::table('osgo_users', function (Blueprint $table) {
                if (Schema::hasColumn('osgo_users', 'id') && !Schema::hasColumn('osgo_users', 'ID_USUARIO')) {
                    $table->renameColumn('id', 'ID_USUARIO');
                }
            });
        }
    }

    public function down(): void
    {
        // Revertir cambios si es necesario
    }
};
