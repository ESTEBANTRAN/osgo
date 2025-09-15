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
        if (! Schema::hasTable('ORDEN_SERVICIO_GRUA')) {
            Schema::create('ORDEN_SERVICIO_GRUA', function (Blueprint $table) {
                $table->increments('ID_ORDEN_GRUA');
                $table->unsignedInteger('ID_ORDEN_SERVICIO')->nullable();
                $table->unsignedInteger('ID_SERVICIO_GRUA')->nullable();

                $table->foreign('ID_ORDEN_SERVICIO')
                    ->references('ID_ORDEN_SERVICIO')
                    ->on('osgo_orden_servicio')
                    ->onUpdate('cascade')
                    ->onDelete('cascade');

                $table->foreign('ID_SERVICIO_GRUA')
                    ->references('ID_SERVICIO_GRUA')
                    ->on('osgo_servicio_grua')
                    ->onUpdate('cascade')
                    ->onDelete('restrict');

                $table->unique(
                    ['ID_ORDEN_SERVICIO', 'ID_SERVICIO_GRUA'],
                    'UK_ORDEN_GRUA'
                );
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('ORDEN_SERVICIO_GRUA');
    }
};
