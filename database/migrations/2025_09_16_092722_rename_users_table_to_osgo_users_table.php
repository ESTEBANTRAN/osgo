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
        // Renombrar la tabla users a osgo_users
        Schema::rename('users', 'osgo_users');
        
        // Agregar la columna ROL_ID a la tabla osgo_users
        Schema::table('osgo_users', function (Blueprint $table) {
            $table->unsignedBigInteger('ROL_ID')->after('ID_USUARIO')->default(1);
            $table->foreign('ROL_ID')->references('id')->on('osgo_roles');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Eliminar la clave foránea y la columna ROL_ID
        Schema::table('osgo_users', function (Blueprint $table) {
            $table->dropForeign(['ROL_ID']);
            $table->dropColumn('ROL_ID');
        });
        
        // Volver a renombrar la tabla a su nombre original
        Schema::rename('osgo_users', 'users');
    }
};
