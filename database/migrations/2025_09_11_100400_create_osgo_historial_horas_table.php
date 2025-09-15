<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('osgo_historial_horas')) {
            return;
        }
        Schema::create('osgo_historial_horas', function (Blueprint $table): void {
            $table->integer('ID_HISTORIAL')->autoIncrement();
            $table->integer('ID_CONTROL_HORAS');
            $table->decimal('HORAS_ANTERIORES', 5, 2);
            $table->decimal('HORAS_NUEVAS', 5, 2);
            $table->string('MOTIVO', 255)->nullable();
            $table->timestamp('CREATED_AT')->useCurrent();

            $table->index(['ID_CONTROL_HORAS']);

            $table->foreign('ID_CONTROL_HORAS')
                ->references('ID_CONTROL_HORAS')
                ->on('osgo_control_horas')
                ->onUpdate('cascade')
                ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('osgo_historial_horas');
    }
};


