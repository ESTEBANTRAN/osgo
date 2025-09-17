<?php

// Script para actualizar OrdenServicioResource con datos parametrizados
// Este script debe ejecutarse después de cada actualización de personal

use Illuminate\Support\Facades\DB;

// Obtener personas por función desde sistema_principal
$personasPorFuncion = [];
$funcionesPrincipales = [1,2,3,4,5,6,7,8,9,10];

foreach ($funcionesPrincipales as $idFuncion) {
    $personas = DB::connection('sistema_principal')
        ->table('v_personas_disponibles')
        ->where('ID_FUNCION', $idFuncion)
        ->get();

    $personasPorFuncion[$idFuncion] = $personas->mapWithKeys(function($persona) {
        return [$persona->ID_PERSONA => $persona->CODIGO_AGENTE . ' - ' . $persona->NOMBRE_COMPLETO];
    })->toArray();
}

// Usar $personasPorFuncion en los Select del OrdenServicioResource
