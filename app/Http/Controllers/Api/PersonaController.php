<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Persona;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PersonaController extends Controller
{
    /**
     * Get people by function ID
     *
     * @param int $funcionId
     * @return JsonResponse
     */
    public function getByFuncion($funcionId): JsonResponse
    {
        try {
            $personas = Persona::where('ID_FUNCION', $funcionId)
                ->where('ESTADO', 'A')  // Assuming 'A' means active
                ->orderBy('NOMBRES')
                ->get(['ID_PERSONA', 'NOMBRES', 'APELLIDOS', 'CODIGO_AGENTE'])
                ->map(function($persona) {
                    return [
                        'id' => $persona->ID_PERSONA,
                        'codigo_agente' => $persona->CODIGO_AGENTE,
                        'nombres' => $persona->NOMBRES,
                        'apellidos' => $persona->APELLIDOS,
                        'nombre_completo' => trim($persona->NOMBRES . ' ' . $persona->APELLIDOS),
                    ];
                });

            return response()->json([
                'success' => true,
                'data' => $personas
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener la lista de personas: ' . $e->getMessage()
            ], 500);
        }
    }
}
