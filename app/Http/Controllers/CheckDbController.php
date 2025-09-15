<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CheckDbController extends Controller
{
    public function checkTables()
    {
        $tables = [
            'osgo_sectores',
            'osgo_estado_orden',
            'osgo_vehiculos',
            'osgo_recursos',
            'osgo_horarios',
            'osgo_orden_servicio',
            'osgo_detalle_orden_servicio',
            'osgo_anexo',
            'osgo_anexo_detalle',
            'osgo_anexo_recurso',
            'osgo_control_horas',
            'osgo_servicio_grua'
        ];

        $results = [];
        
        foreach ($tables as $table) {
            if (Schema::connection('osgo')->hasTable($table)) {
                $results[$table] = [
                    'columns' => Schema::connection('osgo')->getColumnListing($table),
                    'count' => DB::connection('osgo')->table($table)->count(),
                ];
            }
        }

        return response()->json($results);
    }
}
