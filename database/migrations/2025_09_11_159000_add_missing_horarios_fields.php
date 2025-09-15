<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Agregar campos faltantes a osgo_horarios según esquema aprobado
        if (Schema::hasTable('osgo_horarios')) {
            Schema::table('osgo_horarios', function (Blueprint $table) {
                if (!Schema::hasColumn('osgo_horarios', 'descripcion')) {
                    $table->string('descripcion', 20)->after('HORA_FIN');
                }
                if (!Schema::hasColumn('osgo_horarios', 'duracion_horas')) {
                    $table->integer('duracion_horas')->after('descripcion');
                }
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('osgo_horarios')) {
            Schema::table('osgo_horarios', function (Blueprint $table) {
                if (Schema::hasColumn('osgo_horarios', 'descripcion')) {
                    $table->dropColumn('descripcion');
                }
                if (Schema::hasColumn('osgo_horarios', 'duracion_horas')) {
                    $table->dropColumn('duracion_horas');
                }
            });
        }
    }
};
