<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('osgo_anexo_detalle')) {
            return;
        }
        Schema::create('osgo_anexo_detalle', function (Blueprint $table): void {
            $table->unsignedInteger('ID_ANEXO_DETALLE')->autoIncrement();
            $table->unsignedInteger('ID_ANEXO');
            $table->integer('ID_PERSONA')->nullable();
            $table->string('FUNCION_ASIGNADA', 100)->nullable();

            $table->index(['ID_ANEXO']);
            $table->index(['ID_PERSONA']);

            $table->foreign('ID_ANEXO')
                ->references('ID_ANEXO')
                ->on('osgo_anexo')
                ->onUpdate('cascade')
                ->onDelete('cascade');

            $table->foreign('ID_PERSONA')
                ->references('ID_PERSONA')
                ->on('personas')
                ->onUpdate('cascade')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('osgo_anexo_detalle');
    }
};


