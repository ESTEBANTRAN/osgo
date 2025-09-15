<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('users') && ! Schema::hasTable('osgo_users')) {
            Schema::rename('users', 'osgo_users');
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('osgo_users') && ! Schema::hasTable('users')) {
            Schema::rename('osgo_users', 'users');
        }
    }
};


