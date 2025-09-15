<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('osgo_control_horas')) {
            return;
        }
        Schema::create('osgo_control_horas', function (Blueprint $table): void {
            $table->integer('ID_CONTROL_HORAS')->autoIncrement();
            $table->integer('ID_PERSONA');
            $table->date('FECHA');
            $table->decimal('HORAS_TRABAJADAS', 5, 2)->default(0);
            $table->string('ESTADO', 30)->default('DISPONIBLE');

            $table->unique(['ID_PERSONA', 'FECHA']);
            $table->index(['ESTADO']);

            $table->foreign('ID_PERSONA')
                ->references('ID_PERSONA')
                ->on('personas')
                ->onUpdate('cascade')
                ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('osgo_control_horas');
    }
};


