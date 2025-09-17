<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Database\Seeders\HorariosSeeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Primero creamos los roles
        $this->call([
            RolesTableSeeder::class,
        ]);
        
        // Luego ejecutamos los demás seeders
        $this->call([
            OsgoDatabaseSeeder::class,
            PrincipalDatabaseSeeder::class,
        ]);
    }
}
