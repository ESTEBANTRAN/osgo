<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('funciones', function (Blueprint $table) {
            // ¡NO crear la columna otra vez!
            $table->foreign('ID_GRUPO_OPERATIVO', 'fk_funciones_grupo_operativo')
                ->references('ID_GRUPO_OPERATIVO')
                ->on('grupo_operativo')
                ->onUpdate('cascade')
                ->onDelete('restrict');   // o 'cascade' si así lo necesitas
        });
    }

    public function down(): void
    {
        // 1. Quitar la FK de funciones
        Schema::table('funciones', function (Blueprint $table) {
            $table->dropForeign('fk_funciones_grupo_operativo');
        });

        // 2. Quitar la PK de grupo_operativo (opcional; solo si necesitas revertirla)
        Schema::table('grupo_operativo', function (Blueprint $table) {
            $table->dropPrimary(['ID_GRUPO_OPERATIVO']); // 'PRIMARY' también funcionaría
        });
    }
};
