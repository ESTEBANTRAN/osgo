<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('osgo_horarios')) {
            return;
        }
        Schema::create('osgo_horarios', function (Blueprint $table): void {
            $table->integer('ID_HORARIO')->autoIncrement();
            $table->string('NOMBRE', 100);
            $table->unsignedTinyInteger('HORA_INICIO'); // 0-23
            $table->unsignedTinyInteger('HORA_FIN');    // 0-23
            $table->string('ACTIVO', 2)->default('SI'); // SI/NO

            $table->index(['ACTIVO']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('osgo_horarios');
    }
};


