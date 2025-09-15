<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class InformacionGeneralRequest extends FormRequest
{
    public function authorize() { return true; }

    public function rules()
    {
        return [
            'fecha'         => 'required|date',
            'distrito'      => 'required|string|max:50',
            'responsable'   => 'required|string|max:100',
            'observaciones' => 'nullable|string',
            'orden_id'      => 'nullable|exists:orden_servicio,ID_ORDEN_SERVICIO',
        ];
    }
}
