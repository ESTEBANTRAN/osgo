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
        Schema::create('osgo_recursos', function (Blueprint $table) {
            $table->id('ID_RECURSO');
            $table->string('NOMBRE_RECURSO', 100)->comment('Nombre del recurso (ej: Conos, Varillas, Señaléticas)');
            $table->string('TIPO_RECURSO', 50)->comment('Tipo de recurso (ej: PATRULLERO, MOTOCICLETA, CONO)');
            $table->text('DESCRIPCION')->nullable()->comment('Descripción detallada del recurso');
            $table->string('UNIDAD_MEDIDA', 20)->default('UNIDAD')->comment('Unidad de medida (UNIDAD, METROS, LITROS, etc.)');
            $table->boolean('ACTIVO')->default(true)->comment('Indica si el recurso está activo');
            $table->timestamps();
            
            // Índices
            $table->index('TIPO_RECURSO');
            $table->index('ACTIVO');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('osgo_recursos');
    }
};
