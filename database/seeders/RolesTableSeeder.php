<?php
declare(strict_types=1);

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RolesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Upsert de roles requeridos con columnas en MAYÚSCULAS
        \DB::table('osgo_roles')->updateOrInsert(
            ['NOMBRE' => 'RESPONSABLE_OPERATIVO'],
            [
                'DESCRIPCION' => 'Crea órdenes de servicio',
                'ACTIVO' => 1,
                'CREATED_AT' => now(),
                'UPDATED_AT' => now(),
            ]
        );

        \DB::table('osgo_roles')->updateOrInsert(
            ['NOMBRE' => 'JEFE_DISTRITO'],
            [
                'DESCRIPCION' => 'Aprueba órdenes de servicio',
                'ACTIVO' => 1,
                'CREATED_AT' => now(),
                'UPDATED_AT' => now(),
            ]
        );
    }
}
