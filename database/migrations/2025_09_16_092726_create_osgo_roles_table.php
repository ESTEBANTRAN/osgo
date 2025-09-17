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
        Schema::create('osgo_roles', function (Blueprint $table) {
            $table->id();
            $table->string('NOMBRE', 50)->unique();
            $table->string('DESCRIPCION', 200)->nullable();
            $table->boolean('ACTIVO')->default(true);
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('osgo_roles');
    }
};
