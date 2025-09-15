<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('osgo_anexo_recurso')) {
            return;
        }
        Schema::create('osgo_anexo_recurso', function (Blueprint $table): void {
            $table->unsignedInteger('ID_ANEXO_RECURSO')->autoIncrement();
            $table->unsignedInteger('ID_ANEXO');
            $table->integer('ID_VEHICULO')->nullable();
            $table->unsignedInteger('CANTIDAD_CONOS')->default(0);

            $table->index(['ID_ANEXO']);
            $table->index(['ID_VEHICULO']);

            $table->foreign('ID_ANEXO')
                ->references('ID_ANEXO')
                ->on('osgo_anexo')
                ->onUpdate('cascade')
                ->onDelete('cascade');

            $table->foreign('ID_VEHICULO')
                ->references('ID_VEHICULO')
                ->on('osgo_vehiculo')
                ->onUpdate('cascade')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('osgo_anexo_recurso');
    }
};


