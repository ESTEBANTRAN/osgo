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
        // Solo crear si NO existe
        if (! Schema::hasTable('SERVICIO_GRUA')) {
            Schema::create('SERVICIO_GRUA', function (Blueprint $table) {
                $table->increments('ID_SERVICIO_GRUA');
                $table->string('PROPIETARIO', 100)->nullable();
                $table->string('CONTRATO', 20)->nullable();
                $table->string('TELEFONO', 20)->nullable();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('SERVICIO_GRUA');
    }
};
