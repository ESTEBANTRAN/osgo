@extends('layout')

@section('page-title', 'Crear Orden de Servicio')

@section('content')
<form
  x-data="wizard()"
  x-init="init()"
  @submit.prevent="submitForm()"
  id="ordenForm"
  action="{{ route('retornarOrden') }}"
  method="POST"
  class="max-w-5xl mx-auto p-6 space-y-8 w-full"
>
  @csrf

  {{-- STEPPER PRINCIPAL --}}
  <div class="flex items-center justify-between w-full mb-6">
    <template x-for="(step, i) in steps" :key="i">
      <div class="flex-1 relative text-center">
        <button
          type="button"
          @click="goTo(i+1)"
          class="mx-auto w-10 h-10 rounded-full flex items-center justify-center font-semibold focus:outline-none"
          :class="{
            'bg-blue-600 text-white shadow-lg': currentStep>i+1,
            'bg-blue-100 text-blue-600': currentStep===i+1,
            'bg-gray-200 text-gray-500': currentStep<i+1
          }"
        >
          <span x-text="i+1"></span>
        </button>
        <div
          class="mt-2 text-sm font-medium truncate"
          :class="currentStep===i+1 ? 'text-blue-600' : 'text-gray-500'"
          x-text="step.label"
        ></div>
        <template x-if="i < steps.length-1">
          <div
            class="absolute top-1/2 right-0 w-full h-1 transform translate-x-1/2"
            :class="currentStep>i+1 ? 'bg-blue-600' : 'bg-gray-200'"
          ></div>
        </template>
      </div>
    </template>
  </div>

  <div class="space-y-8 w-full">

    {{-- PASO 1: Selección de anexos --}}
    <div
      x-show="currentStep===1"
      x-transition
      class="bg-white rounded-2xl shadow-lg p-8 space-y-6 w-full"
    >
      <h2 class="text-2xl font-bold text-blue-800">1. Seleccione Anexos</h2>
      <div class="flex flex-col sm:flex-row sm:space-x-8 space-y-4 sm:space-y-0">
        <label class="inline-flex items-center space-x-2">
          <input type="checkbox" x-model="includeUEA" class="toggle-checkbox" />
          <span class="text-gray-700">Anexo Unidades Educativas</span>
        </label>
        <label class="inline-flex items-center space-x-2">
          <input type="checkbox" x-model="includeEventos" class="toggle-checkbox" />
          <span class="text-gray-700">Anexo Eventos</span>
        </label>
      </div>
      <div class="flex justify-end mt-6">
        <button
          type="button"
          @click="next()"
          class="px-6 py-2 bg-gradient-to-r from-blue-500 to-blue-700 text-white rounded-lg shadow hover:from-blue-600 hover:to-blue-800 transition"
        >
          Siguiente
        </button>
      </div>
    </div>

    {{-- PASO 2: Información General con TABS internos --}}
    <div
      x-show="currentStep===2"
      x-transition
      class="bg-white rounded-2xl shadow-lg p-8 space-y-6 w-full"
    >
      <h2 class="text-2xl font-bold text-blue-800">2. Orden de Servicio</h2>

      <!-- NAV CON SCROLL HORIZONTAL Y VALIDACIONES POR TAB -->
      <div class="overflow-x-auto mb-4">
        <nav class="inline-flex space-x-4 border-b border-gray-200">

          <button
            type="button"
            @click="switchTab('basic')"
            :class="innerTab==='basic'
              ? 'border-blue-600 text-blue-600'
              : 'border-transparent text-gray-600'"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            1. Información General
          </button>

          <button
            type="button"
            @click="switchTab('control')"
            :disabled="!validateBasic()"
            :class="innerTab==='control'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            2. Funciones y Personal de Control
          </button>

          <button
            type="button"
            @click="switchTab('despacho')"
            :disabled="!validateBasic() || !validateControl()"
            :class="innerTab==='despacho'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic() || !validateControl()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
           3. Despacho y Videovigilancia
          </button>

          <button
            type="button"
            @click="switchTab('centros')"
            :disabled="!validateBasic() || !validateControl() || !validateDespacho()"
            :class="innerTab==='centros'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic() || !validateControl() || !validateDespacho()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            4. Centros de Retención Vehicular
          </button>

          <button
            type="button"
            @click="switchTab('gruposespeciales')"
            :disabled="!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros()"
            :class="innerTab==='gruposespeciales'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            5. Grupos Operativos Especiales
          </button>

          <button
            type="button"
            @click="switchTab('educacion')"
            :disabled="!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales()"
            :class="innerTab==='educacion'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            6. Educación Vial y Servicios de Grúa
          </button>

          <button
            type="button"
            @click="switchTab('conductor')"
            :disabled="!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales() || !validateEducacion()"
            :class="innerTab==='conductor'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales() || !validateEducacion()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            7. Conductor y Acompañante
          </button>

          <button
            type="button"
            @click="switchTab('tiposervicio')"
            :disabled="!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales() || !validateEducacion() || !validateConductor()"
            :class="innerTab==='tiposervicio'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales() || !validateEducacion() || !validateConductor()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            8. Tipos de Servicio
          </button>

          <button
            type="button"
            @click="switchTab('permisos')"
            :disabled="!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales() || !validateEducacion() || !validateConductor() || !validateTipoServicio()"
            :class="innerTab==='permisos'
              ? 'border-blue-600 text-blue-600'
              : (!validateBasic() || !validateControl() || !validateDespacho() || !validateCentros() || !validateGruposespeciales() || !validateEducacion() || !validateConductor() || !validateTipoServicio()
                  ? 'border-transparent text-gray-400 cursor-not-allowed'
                  : 'border-transparent text-gray-600')"
            class="flex-shrink-0 pb-2 px-3 text-xs sm:text-sm font-medium border-b-2 whitespace-nowrap transition"
          >
            9. Permisos y Disposiciones Generales
          </button>

        </nav>
      </div>

      {{-- PANELES DE TABS --}}
      <div class="space-y-6">
        <!-- Panel Básico -->
        <div
          x-show="innerTab==='basic'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="fecha" class="block text-sm font-medium">Fecha de la Orden</label>
              <input
                id="fecha"
                type="date"
                name="fecha"
                x-model="form.fecha"
                class="input-base"
              />
            </div>
            <div>
              <label for="numero" class="block text-sm font-medium">N° de Ejemplar</label>
              <input
                id="numero"
                type="text"
                name="numero"
                readonly
                placeholder="Autogenerado"
                :value="form.numero"
                class="input-base input-readonly"
              />
            </div>
            <div>
              <label for="distrito" class="block text-sm font-medium">Distrito</label>
              <select
                id="distrito"
                name="distrito"
                x-model="form.distrito"
                class="select-base"
              >
                <option value="">Seleccione</option>
                <option>Centro</option>
                <option>Norte</option>
                <option>Sur</option>
              </select>
            </div>
            <div>
              <label for="responsable" class="block text-sm font-medium">Responsable Operativo</label>
              <select
                id="responsable"
                name="responsable"
                x-model="form.responsable"
                class="select-base"
                @change="$dispatch('responsable-selected', { value: $event.target.value })"
              >
                <option value="">Seleccione un responsable</option>
                <template x-for="persona in personas" :key="persona.id">
                  <option :value="persona.id" x-text="persona.nombre_completo"></option>
                </template>
              </select>
              <div x-show="loadingPersonas" class="mt-1 text-sm text-gray-500">Cargando responsables...</div>
            </div>
          </div>
          <div>
            <label for="observaciones" class="block text-sm font-medium">Observaciones Generales</label>
            <textarea
              id="observaciones"
              name="observaciones"
              rows="3"
              x-model="form.observaciones"
              class="textarea-base"
              placeholder="Ingrese observaciones..."
            ></textarea>
          </div>
        </div>

        <!-- Panel Control -->
        <div
          x-show="innerTab==='control'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="control_jefeCentro" class="block text-sm font-medium">
                Jefe de Control Distrito Centro
              </label>
              <input
                id="control_jefeCentro"
                type="text"
                x-model="form.control_jefeCentro"
                class="input-base"
                placeholder="Nombre del jefe…"
              />
            </div>
            <div>
              <label for="control_personalAdmin" class="block text-sm font-medium">
                Personal Administrativo Operativo
              </label>
              <input
                id="control_personalAdmin"
                type="text"
                x-model="form.control_personalAdmin"
                class="input-base"
                placeholder="Nombre del personal…"
              />
            </div>
          </div>
        </div>

        <!-- Panel 3: Despacho y Videovigilancia -->
        <div
          x-show="innerTab==='despacho'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="despacho_salaOps" class="block text-sm font-medium">
                Sala de Operaciones y Despacho
              </label>
              <input
                id="despacho_salaOps"
                type="text"
                x-model="form.despacho_salaOps"
                class="input-base"
                placeholder="Código o responsable…"
              />
            </div>
            <div>
              <label for="despacho_videoVig" class="block text-sm font-medium">
                Sala Video Vigilancia
              </label>
              <input
                id="despacho_videoVig"
                type="text"
                x-model="form.despacho_videoVig"
                class="input-base"
                placeholder="Equipo asignado…"
              />
            </div>
          </div>
        </div>

        <!-- Panel 4: Centros de Retención Vehicular -->
        <div
          x-show="innerTab==='centros'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="centros_retvplus" class="block text-sm font-medium">
                Centro Retención Vehicular – REVIPLUS
              </label>
              <input
                id="centros_retvplus"
                type="text"
                x-model="form.centros_retvplus"
                class="input-base"
                placeholder="Turno o contacto…"
              />
            </div>
            <div>
              <label for="centros_av13" class="block text-sm font-medium">
                Centro Retención Vehicular – Av. 13 de Abril
              </label>
              <input
                id="centros_av13"
                type="text"
                x-model="form.centros_av13"
                class="input-base"
                placeholder="Turno o contacto…"
              />
            </div>
          </div>
        </div>

        <!-- Panel 5: Grupos Operativos Especiales -->
        <div
          x-show="innerTab==='gruposespeciales'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="grupos_gestionOp" class="block text-sm font-medium">
                Grupo de Gestión Operativa
              </label>
              <input
                id="grupos_gestionOp"
                type="text"
                x-model="form.grupos_gestionOp"
                class="input-base"
                placeholder="Responsable…"
              />
            </div>
            <div>
              <label for="grupos_informalidad" class="block text-sm font-medium">
                Grupo Operativo Informalidad
              </label>
              <input
                id="grupos_informalidad"
                type="text"
                x-model="form.grupos_informalidad"
                class="input-base"
                placeholder="Responsable…"
              />
            </div>
          </div>
        </div>

        <!-- Panel 6: Educación Vial y Servicios de Grúa -->
        <div
          x-show="innerTab==='educacion'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="educacion_vial" class="block text-sm font-medium">
                Educación Vial
              </label>
              <input
                id="educacion_vial"
                type="text"
                x-model="form.educacion_vial"
                class="input-base"
                placeholder="Tema o instructor…"
              />
            </div>
            <div>
              <label for="educacion_grua" class="block text-sm font-medium">
                Servicio de Grúa Particular
              </label>
              <input
                id="educacion_grua"
                type="text"
                x-model="form.educacion_grua"
                class="input-base"
                placeholder="Proveedor…"
              />
            </div>
          </div>
        </div>

        <!-- Panel 7: Conductor y Acompañante -->
        <div
          x-show="innerTab==='conductor'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="conductor_patruya" class="block text-sm font-medium">
                Conductor y Acompañante de Patrullero
              </label>
              <input
                id="conductor_patruya"
                type="text"
                x-model="form.conductor_patruya"
                class="input-base"
                placeholder="Nombre conductor…"
              />
            </div>
            <div>
              <label for="conductor_grua" class="block text-sm font-medium">
                Conductor y Acompañante de Grúa
              </label>
              <input
                id="conductor_grua"
                type="text"
                x-model="form.conductor_grua"
                class="input-base"
                placeholder="Nombre conductor…"
              />
            </div>
          </div>
        </div>

        <!-- Panel 8: Tipos de Servicio -->
        <div
          x-show="innerTab==='tiposervicio'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="tipo_motorizado" class="block text-sm font-medium">
                Servicio Motorizado
              </label>
              <input
                id="tipo_motorizado"
                type="text"
                x-model="form.tipo_motorizado"
                class="input-base"
                placeholder="Descripción…"
              />
            </div>
            <div>
              <label for="tipo_pedestre" class="block text-sm font-medium">
                Servicio Pedestre
              </label>
              <input
                id="tipo_pedestre"
                type="text"
                x-model="form.tipo_pedestre"
                class="input-base"
                placeholder="Descripción…"
              />
            </div>
          </div>
        </div>

        <!-- Panel 9: Permisos y Disposiciones Generales -->
        <div
          x-show="innerTab==='permisos'"
          x-transition
          class="space-y-6"
        >
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="permisos_franco" class="block text-sm font-medium">
                Personal de Franco
              </label>
              <input
                id="permisos_franco"
                type="text"
                x-model="form.permisos_franco"
                class="input-base"
                placeholder="Responsable…"
              />
            </div>
            <div>
              <label for="permisos_medico" class="block text-sm font-medium">
                Permiso Médico
              </label>
              <input
                id="permisos_medico"
                type="text"
                x-model="form.permisos_medico"
                class="input-base"
                placeholder="Documento…"
              />
            </div>
          </div>
        </div>
      </div>

      {{-- BOTONES DE NAVEGACIÓN EN ESTE CARD --}}
      <div class="flex justify-between space-x-3 mt-6">
        <button
          type="button"
          x-show="innerTab!=='basic'"
          @click="prevTab()"
          class="px-6 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition"
        >
          Anterior sección
        </button>
        <button
          type="button"
          x-show="innerTab==='basic'"
          @click="prev()"
          class="px-6 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition"
        >
          Atrás
        </button>
        <button
          type="button"
          x-show="innerTab!=='permisos'"
          @click="nextTab()"
          class="px-6 py-2 bg-gradient-to-r from-blue-500 to-blue-700 text-white rounded-lg shadow hover:from-blue-600 hover:to-blue-800 transition"
        >
          Siguiente sección
        </button>
        <button
          type="button"
          x-show="innerTab==='permisos'"
          @click="next()"
          :disabled="!validateGeneral()"
          class="px-6 py-2 rounded-lg transition
                 bg-gradient-to-r from-blue-500 to-blue-700 text-white
                 hover:from-blue-600 hover:to-blue-800
                 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Siguiente
        </button>
      </div>
    </div>

    {{-- PASO 3: Anexo Eventos --}}
    <div
      x-show="currentStep===3"
      x-transition
      class="bg-white rounded-2xl shadow-lg p-8 space-y-6 w-full"
    >
      <h2 class="text-2xl font-bold text-purple-800">3. Anexo Eventos</h2>
      <template x-if="includeEventos">
        <div class="space-y-6">
          <div>
            <label for="evento_nombre" class="block text-sm font-medium">Nombre del Evento</label>
            <input
              id="evento_nombre"
              type="text"
              name="evento_nombre"
              x-model="form.evento_nombre"
              class="input-base"
            />
          </div>
          <div>
            <label for="evento_fecha" class="block text-sm font-medium">Fecha del Evento</label>
            <input
              id="evento_fecha"
              type="date"
              name="evento_fecha"
              x-model="form.evento_fecha"
              class="input-base"
            />
          </div>
        </div>
      </template>
      <div class="flex justify-between mt-6">
        <button
          type="button"
          @click="prev()"
          class="px-6 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition"
        >
          Atrás
        </button>
        <button
          type="button"
          @click="next()"
          :disabled="!validateEventos()"
          class="px-6 py-2 rounded-lg transition
                 bg-gradient-to-r from-purple-500 to-purple-700 text-white
                 hover:from-purple-600 hover:to-purple-800
                 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Siguiente
        </button>
      </div>
    </div>

    {{-- PASO 4: Anexo Unidades Educativas --}}
    <div
      x-show="currentStep===4"
      x-transition
      class="bg-white rounded-2xl shadow-lg p-8 space-y-6 w-full"
    >
      <h2 class="text-2xl font-bold text-teal-800">4. Anexo Unidades Educativas</h2>
      <template x-if="includeUEA">
        <div class="space-y-6">
          <div>
            <label for="uea_nombre" class="block text-sm font-medium">Nombre de la Unidad</label>
            <input
              id="uea_nombre"
              type="text"
              name="uea_nombre"
              x-model="form.uea_nombre"
              class="input-base"
            />
          </div>
          <div>
            <label for="uea_direccion" class="block text-sm font-medium">Dirección</label>
            <input
              id="uea_direccion"
              type="text"
              name="uea_direccion"
              x-model="form.uea_direccion"
              class="input-base"
            />
          </div>
        </div>
      </template>
      <div class="flex justify-between mt-6">
        <button
          type="button"
          @click="prev()"
          class="px-6 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition"
        >
          Atrás
        </button>
        <button
          type="submit"
          :disabled="!validateUEA()"
          class="px-6 py-2 rounded-lg transition
                 bg-gradient-to-r from-teal-500 to-teal-700 text-white
                 hover:from-teal-600 hover:to-teal-800
                 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Crear Orden
        </button>
      </div>
    </div>

  </div>
</form>

<script>
  function wizard() {
    return {
      // pasos superiores
      includeEventos: false,
      includeUEA: false,
      currentStep: 1,
      
      // estado para personas
      personas: [],
      loadingPersonas: false,
      errorLoadingPersonas: false,
      
      // Inicialización del componente
      init() {
        this.loadPersonas();
      },
      
      // Cargar la lista de personas
      async loadPersonas() {
        this.loadingPersonas = true;
        this.errorLoadingPersonas = false;
        
        try {
          // Asumimos que el ID de función para 'Gerente Operativo' es 1
          // Ajusta este valor según corresponda en tu base de datos
          const funcionId = 1; 
          
          const response = await fetch(`/api/personas/por-funcion/${funcionId}`);
          
          if (!response.ok) {
            throw new Error('Error al cargar los responsables');
          }
          
          const data = await response.json();
          
          if (data.success) {
            this.personas = data.data;
          } else {
            throw new Error(data.message || 'Error al cargar los responsables');
          }
        } catch (error) {
          console.error('Error:', error);
          this.errorLoadingPersonas = true;
          // Mostrar mensaje de error al usuario
          alert('No se pudieron cargar los responsables. Por favor, intente recargar la página.');
        } finally {
          this.loadingPersonas = false;
        }
      },

      // pestañas internas
      innerTab: 'basic',
      tabs: [
        'basic',
        'control',
        'despacho',
        'centros',
        'gruposespeciales',
        'educacion',
        'conductor',
        'tiposervicio',
        'permisos'
      ],

      // datos del formulario
      form: {
        fecha: '',
        numero: '',
        distrito: '',
        responsable: '',
        observaciones: '',
        control_jefeCentro: '',
        control_personalAdmin: '',
        despacho_salaOps: '',
        despacho_videoVig: '',
        centros_retvplus: '',
        centros_av13: '',
        grupos_gestionOp: '',
        grupos_informalidad: '',
        educacion_vial: '',
        educacion_grua: '',
        conductor_patruya: '',
        conductor_grua: '',
        tipo_motorizado: '',
        tipo_pedestre: '',
        permisos_franco: '',
        permisos_medico: '',
        evento_nombre: '',
        evento_fecha: '',
        uea_nombre: '',
        uea_direccion: ''
      },

      // definimos etiquetas de pasos superiores
      get steps() {
        const list = [
          { label: 'Anexos' },
          { label: 'Orden de Servicio' }
        ];
        if (this.includeEventos) list.push({ label: 'Anexo Eventos' });
        if (this.includeUEA)    list.push({ label: 'Anexo Unidades Educativas' });
        return list;
      },

      // navegación pasos superiores
      goTo(step) {
        this.currentStep = step;
        if (step === 2) this.innerTab = 'basic';
      },

      // cambiar pestaña interna con validaciones
      switchTab(tab) {
        if (tab === 'control' && !this.validateBasic()) {
          return alert('Debe completar primero Información General.');
        }
        if (tab === 'despacho' && !this.validateControl()) {
          return alert('Complete primero Funciones y Personal de Control.');
        }
        if (tab === 'centros' && !this.validateDespacho()) {
          return alert('Complete primero Despacho y Videovigilancia.');
        }
        if (tab === 'gruposespeciales' && !this.validateCentros()) {
          return alert('Complete primero Centros de Retención Vehicular.');
        }
        if (tab === 'educacion' && !this.validateGruposespeciales()) {
          return alert('Complete primero Grupos Operativos Especiales.');
        }
        if (tab === 'conductor' && !this.validateEducacion()) {
          return alert('Complete primero Educación Vial y Servicios de Grúa.');
        }
        if (tab === 'tiposervicio' && !this.validateConductor()) {
          return alert('Complete primero Conductor y Acompañante.');
        }
        if (tab === 'permisos' && !this.validateTipoServicio()) {
          return alert('Complete primero Tipos de Servicio.');
        }
        this.innerTab = tab;
      },

      // validaciones secciones
      validateBasic() {
        return this.form.fecha && this.form.distrito && this.form.responsable;
      },
      validateControl() {
        return this.form.control_jefeCentro && this.form.control_personalAdmin;
      },
      validateDespacho() {
        return this.form.despacho_salaOps && this.form.despacho_videoVig;
      },
      validateCentros() {
        return this.form.centros_retvplus && this.form.centros_av13;
      },
      validateGruposespeciales() {
        return this.form.grupos_gestionOp && this.form.grupos_informalidad;
      },
      validateEducacion() {
        return this.form.educacion_vial && this.form.educacion_grua;
      },
      validateConductor() {
        return this.form.conductor_patruya && this.form.conductor_grua;
      },
      validateTipoServicio() {
        return this.form.tipo_motorizado && this.form.tipo_pedestre;
      },
      validateGeneral() {
        return (
          this.validateBasic() &&
          this.validateControl() &&
          this.validateDespacho() &&
          this.validateCentros() &&
          this.validateGruposespeciales() &&
          this.validateEducacion() &&
          this.validateConductor() &&
          this.validateTipoServicio()
        );
      },
      validateEventos() {
        if (!this.includeEventos) return true;
        return this.form.evento_nombre && this.form.evento_fecha;
      },
      validateUEA() {
        if (!this.includeUEA) return true;
        return this.form.uea_nombre && this.form.uea_direccion;
      },

      // ----- Nuevo método: solo saveBasic -----
      savingBasic: false,
      orden_id: null,
      async saveBasic() {
        this.savingBasic = true;
        try {
          const res = await fetch('{{ route("ordenes.guardarInfoGen") }}', {
            method: 'POST',
            credentials: 'same-origin',
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({
              fecha:         this.form.fecha,
              distrito:      this.form.distrito,
              responsable:   this.form.responsable,
              observaciones: this.form.observaciones,
              orden_id:      this.orden_id
            })
          });
          if (!res.ok) throw new Error('Status ' + res.status);
          const json = await res.json();
          if (!json.success) throw new Error('Guardado básico fallido');
          this.orden_id = json.orden_id;
        } catch (e) {
          alert(e.message || 'Error al guardar Información General');
          throw e;
        } finally {
          this.savingBasic = false;
        }
      },

      // avanzar/retroceder pestañas internas
      async nextTab() {
        // Si estamos en BASIC, guardamos antes de avanzar
        if (this.innerTab === 'basic') {
          try {
            await this.saveBasic();
          } catch {
            return; // si falla, no avanzamos
          }
        }

        // lógica original para avanzar al siguiente tab
        const i = this.tabs.indexOf(this.innerTab);
        if (i < this.tabs.length - 1) {
          this.innerTab = this.tabs[i + 1];
        }
      },
      prevTab() {
        const i = this.tabs.indexOf(this.innerTab);
        if (i > 0) this.innerTab = this.tabs[i - 1];
      },

      // avanzar/retroceder pasos superiores
      next() {
        const nxt = this.currentStep + 1;
        if (nxt <= this.steps.length) this.goTo(nxt);
        else this.submitForm();
      },
      prev() {
        if (this.currentStep > 1) this.goTo(this.currentStep - 1);
      },

      // envío final
      submitForm() {
        document.getElementById('ordenForm').submit();
      }
    };
  }
</script>


<style>
  .toggle-checkbox {
    width: 1.5rem;
    height: 1rem;
    border-radius: 9999px;
    background: #e5e7eb;
    position: relative;
    appearance: none;
    cursor: pointer;
    transition: background .2s;
  }
  .toggle-checkbox:checked {
    background: #34d399;
  }
  .toggle-checkbox::after {
    content: '';
    position: absolute;
    width: .875rem;
    height: .875rem;
    top: .0625rem;
    left: .0625rem;
    background: white;
    border-radius: 9999px;
    transition: transform .2s;
  }
  .toggle-checkbox:checked::after {
    transform: translateX(.5rem);
  }
</style>
@endsection
