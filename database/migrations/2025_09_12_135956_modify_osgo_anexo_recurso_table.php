<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('osgo_anexo_recurso', function (Blueprint $table) {
            // Agregar la nueva columna para la relación con osgo_recursos
            $table->unsignedBigInteger('ID_RECURSO')->nullable()->after('ID_ANEXO')->comment('ID del recurso en el catálogo');
            
            // Mantener TIPO_RECURSO para compatibilidad hacia atrás
            // pero ahora será una referencia al catálogo
            
            // Agregar índice para la nueva relación
            $table->index('ID_RECURSO');
            
            // Agregar clave foránea
            $table->foreign('ID_RECURSO')->references('ID_RECURSO')->on('osgo_recursos')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('osgo_anexo_recurso', function (Blueprint $table) {
            // Eliminar la clave foránea
            $table->dropForeign(['ID_RECURSO']);
            
            // Eliminar el índice
            $table->dropIndex(['ID_RECURSO']);
            
            // Eliminar la columna
            $table->dropColumn('ID_RECURSO');
        });
    }
};
