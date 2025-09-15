<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('osgo_anexo')) {
            return;
        }
        Schema::create('osgo_anexo', function (Blueprint $table): void {
            $table->unsignedInteger('ID_ANEXO')->autoIncrement();
            $table->integer('ID_ORDEN_SERVICIO');
            $table->string('TIPO_ANEXO', 20); // EVENTO | OPERACION
            $table->dateTime('FECHA_ANEXO');
            $table->text('OBSERVACIONES')->nullable();

            // Índices
            $table->index(['ID_ORDEN_SERVICIO']);
            $table->index(['TIPO_ANEXO']);
            $table->index(['FECHA_ANEXO']);

            // FKs (tablas existentes en el proyecto actual)
            $table->foreign('ID_ORDEN_SERVICIO')
                ->references('ID_ORDEN_SERVICIO')
                ->on('osgo_orden_servicio')
                ->onUpdate('cascade')
                ->onDelete('restrict');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('osgo_anexo');
    }
};


