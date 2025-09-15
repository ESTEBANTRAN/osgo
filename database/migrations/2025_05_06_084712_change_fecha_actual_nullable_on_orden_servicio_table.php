<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('orden_servicio', function (Blueprint $table) {
            // Quitamos el DEFAULT CURRENT_TIMESTAMP
            $table->timestamp('FECHA_ACTUAL')
                  ->nullable()
                  ->default(null)
                  ->change();
        });
    }

    public function down()
    {
        Schema::table('orden_servicio', function (Blueprint $table) {
            // Volvemos a poner el default CURRENT_TIMESTAMP
            $table->timestamp('FECHA_ACTUAL')
                  ->useCurrent()
                  ->change();
        });
    }
};
