<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Verificar si la tabla sessions existe y tiene la estructura correcta
        if (Schema::hasTable('sessions')) {
            // Si la columna ID_SESSION existe, renombrarla a id
            if (Schema::hasColumn('sessions', 'ID_SESSION') && !Schema::hasColumn('sessions', 'id')) {
                Schema::table('sessions', function (Blueprint $table) {
                    $table->renameColumn('ID_SESSION', 'id');
                });
            }
            
            // Asegurar que tenga las columnas necesarias para Laravel
            if (!Schema::hasColumn('sessions', 'user_id')) {
                Schema::table('sessions', function (Blueprint $table) {
                    $table->unsignedBigInteger('user_id')->nullable();
                });
            }
            
            if (!Schema::hasColumn('sessions', 'ip_address')) {
                Schema::table('sessions', function (Blueprint $table) {
                    $table->string('ip_address', 45)->nullable();
                });
            }
            
            if (!Schema::hasColumn('sessions', 'user_agent')) {
                Schema::table('sessions', function (Blueprint $table) {
                    $table->text('user_agent')->nullable();
                });
            }
            
            if (!Schema::hasColumn('sessions', 'payload')) {
                Schema::table('sessions', function (Blueprint $table) {
                    $table->longText('payload');
                });
            }
            
            if (!Schema::hasColumn('sessions', 'last_activity')) {
                Schema::table('sessions', function (Blueprint $table) {
                    $table->integer('last_activity')->index();
                });
            }
        } else {
            // Crear la tabla sessions si no existe
            Schema::create('sessions', function (Blueprint $table) {
                $table->string('id')->primary();
                $table->foreignId('user_id')->nullable()->index();
                $table->string('ip_address', 45)->nullable();
                $table->text('user_agent')->nullable();
                $table->longText('payload');
                $table->integer('last_activity')->index();
            });
        }
    }

    public function down(): void
    {
        // Revertir cambios si es necesario
        if (Schema::hasTable('sessions')) {
            if (Schema::hasColumn('sessions', 'id') && !Schema::hasColumn('sessions', 'ID_SESSION')) {
                Schema::table('sessions', function (Blueprint $table) {
                    $table->renameColumn('id', 'ID_SESSION');
                });
            }
        }
    }
};
