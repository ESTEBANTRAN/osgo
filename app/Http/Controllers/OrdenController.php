<?php

namespace App\Http\Controllers;

use App\Http\Requests\InformacionGeneralRequest;
use App\Models\OrdenServicio;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;



class OrdenController extends Controller
{
  public function index()
  {
    // tu código para listar órdenes
    return view('ordenes/index', [
      // pasa datos si es necesario
    ]);
  }

  public function create()
  {
    // carga el formulario para crear una orden
    return view('ordenes/create');
  }

  /**
   * Almacena la nueva orden en base de datos.
   */
  public function guardarInfoGen(InformacionGeneralRequest $request): JsonResponse
  {
    $userName = Auth::user()?->name ?? 'Sistema';

    $orden = OrdenServicio::updateOrCreate(
      ['ID_ORDEN_SERVICIO' => $request->orden_id ?? null],
      [
        'FECHA'         => $request->validated()['fecha'],
        'DISTRITO'      => $request->validated()['distrito'],
        'CREADO_POR'    => $userName,
        'ID_ESTADO_ORDEN' => 1,
        'FECHA_ACTUAL'  => now(),
      ]
    );

    return response()->json([
      'success'  => true,
      'orden_id' => $orden->ID_ORDEN_SERVICIO,
    ]);
  }
}
