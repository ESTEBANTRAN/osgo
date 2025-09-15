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
        Schema::table('detalle_orden_servicio', function (Blueprint $table) {
            $table->string('id_funcion', 25)
                ->nullable()
                ->after('id_orden_servicio');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('detalle_orden_servicio', function (Blueprint $table) {
            //
        });
    }
};
