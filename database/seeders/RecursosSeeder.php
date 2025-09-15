<?php

namespace Database\Seeders;

use App\Models\Recurso;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RecursosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $recursos = [
            // Vehículos
            [
                'NOMBRE_RECURSO' => 'Patrullero',
                'TIPO_RECURSO' => 'PATRULLERO',
                'DESCRIPCION' => 'Vehículo patrullero para servicios de seguridad',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Motocicleta',
                'TIPO_RECURSO' => 'MOTOCICLETA',
                'DESCRIPCION' => 'Motocicleta para servicios de seguridad',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Pasola',
                'TIPO_RECURSO' => 'PASOLA',
                'DESCRIPCION' => 'Pasola para servicios de seguridad',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Grúa',
                'TIPO_RECURSO' => 'GRUA',
                'DESCRIPCION' => 'Grúa para servicios de remolque',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Tango',
                'TIPO_RECURSO' => 'TANGO',
                'DESCRIPCION' => 'Vehículo tango para servicios especiales',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            
            // Señalización
            [
                'NOMBRE_RECURSO' => 'Conos de Seguridad',
                'TIPO_RECURSO' => 'CONO',
                'DESCRIPCION' => 'Conos de seguridad para señalización vial',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Varillas Reflectivas',
                'TIPO_RECURSO' => 'VARILLA',
                'DESCRIPCION' => 'Varillas reflectivas para señalización',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Señaléticas',
                'TIPO_RECURSO' => 'SENALETICA',
                'DESCRIPCION' => 'Señaléticas de tránsito',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Cinta de Seguridad',
                'TIPO_RECURSO' => 'CINTA',
                'DESCRIPCION' => 'Cinta de seguridad para delimitar áreas',
                'UNIDAD_MEDIDA' => 'METROS',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Barreras de Tránsito',
                'TIPO_RECURSO' => 'BARRERA',
                'DESCRIPCION' => 'Barreras de tránsito portátiles',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            
            // Equipos de Comunicación
            [
                'NOMBRE_RECURSO' => 'Radio Comunicación',
                'TIPO_RECURSO' => 'RADIO',
                'DESCRIPCION' => 'Equipo de radio comunicación',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Megáfono',
                'TIPO_RECURSO' => 'MEGAFONO',
                'DESCRIPCION' => 'Megáfono para comunicación',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            
            // Equipos de Seguridad
            [
                'NOMBRE_RECURSO' => 'Chaleco Reflectivo',
                'TIPO_RECURSO' => 'CHALECO',
                'DESCRIPCION' => 'Chaleco reflectivo de seguridad',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Linterna',
                'TIPO_RECURSO' => 'LINTERNA',
                'DESCRIPCION' => 'Linterna para servicios nocturnos',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
            [
                'NOMBRE_RECURSO' => 'Extintor',
                'TIPO_RECURSO' => 'EXTINTOR',
                'DESCRIPCION' => 'Extintor de incendios',
                'UNIDAD_MEDIDA' => 'UNIDAD',
                'ACTIVO' => true,
            ],
        ];

        foreach ($recursos as $recurso) {
            Recurso::create($recurso);
        }
    }
}
