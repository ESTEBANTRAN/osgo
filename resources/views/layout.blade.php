<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8" />
  <meta name="csrf-token" content="{{ csrf_token() }}">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>@yield('title', 'Dashboard')</title>
  @vite(['resources/css/app.css', 'resources/js/app.js'])
  <script src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>

<body
  x-data="{ sidebarOpen: false, ordersOpen: false }"
  class="bg-gray-50 text-gray-900 antialiased">
  <div class="flex flex-col h-screen md:flex-row">

    {{-- 1) Sidebar de escritorio --}}
    <aside class="hidden md:flex md:flex-col w-64 bg-white border-r border-gray-200">
      <div class="p-4 text-lg font-semibold">
        Sistema de Órdenes de Servicio - EPM
      </div>
      <nav class="mt-4 px-2 space-y-2">
        <a
          href="{{ route('dashboard') }}"
          class="block px-4 py-2 rounded-md font-medium
            {{ request()->is('dashboard') ? 'text-blue-600 bg-blue-50' : 'hover:bg-gray-100 text-gray-700' }}">Inicio</a>

        {{-- Menú desplegable --}}
        <div class="space-y-1">
          <button
            @click="ordersOpen = !ordersOpen"
            class="flex items-center justify-between w-full px-4 py-2 font-medium rounded-md
                   hover:bg-gray-100 text-gray-700 focus:outline-none">
            <span>Órdenes de Servicio</span>
            <svg
              :class="{ 'rotate-90': ordersOpen }"
              class="w-4 h-4 transition-transform"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M9 5l7 7-7 7" />
            </svg>
          </button>
          <div
            x-show="ordersOpen"
            x-transition
            class="pl-8 space-y-1"
            style="display: none;">
            <a
              href="{{ route('ordenes') }}"
              class="block px-4 py-2 rounded-md text-gray-600 hover:bg-gray-100">Listado de órdenes</a>
            <a
              href="{{ route('crearOrden') }}"
              class="block px-4 py-2 rounded-md text-gray-600 hover:bg-gray-100">Crear orden</a>
          </div>
        </div>

        <a
          href="{{ route('cronogramas') }}"
          class="block px-4 py-2 rounded-md font-medium
            {{ request()->is('cronogramas*') ? 'text-blue-600 bg-blue-50' : 'hover:bg-gray-100 text-gray-700' }}">Cronogramas</a>
        <a
          href="{{ route('talento') }}"
          class="block px-4 py-2 rounded-md font-medium
            {{ request()->is('cronogramas*') ? 'text-blue-600 bg-blue-50' : 'hover:bg-gray-100 text-gray-700' }}">Talento Humano</a>
      </nav>
    </aside>

    {{-- 2) Drawer de móvil --}}
    <!-- Overlay limitado al contenido -->
    <div
      x-show="sidebarOpen"
      @click="sidebarOpen = false"
      x-transition.opacity.duration.200
      class="fixed inset-y-0 left-64 right-0 z-20 md:hidden backdrop-blur-sm"
      style="display: none;"></div>

    <aside
      x-show="sidebarOpen"
      @click.away="sidebarOpen = false"
      @keydown.escape.window="sidebarOpen = false"
      x-transition:enter="transition transform duration-300 ease-out"
      x-transition:enter-start="-translate-x-full"
      x-transition:enter-end="translate-x-0"
      x-transition:leave="transition transform duration-300 ease-in"
      x-transition:leave-start="translate-x-0"
      x-transition:leave-end="-translate-x-full"
      class="fixed inset-y-0 left-0 z-30 w-64 bg-white border-r border-gray-200 shadow-xl transform md:hidden"
      style="display: none;">
      <div class="flex items-center justify-between p-4 border-b border-gray-200">
        <span class="text-lg font-semibold">Menú</span>
        <button
          @click="sidebarOpen = false"
          class="p-2 text-gray-600 hover:text-gray-800 focus:outline-none"
          aria-label="Cerrar menú">
          <svg
            class="w-6 h-6"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>

      <nav class="mt-2 px-4 space-y-1">
        <a
          href="{{ route('dashboard') }}"
          class="block px-4 py-2 rounded-md font-medium
            {{ request()->is('dashboard') ? 'text-blue-600 bg-blue-50' : 'hover:bg-gray-100 text-gray-700' }}">Inicio</a>

        {{-- Desplegable móvil --}}
        <div class="space-y-1">
          <button
            @click="ordersOpen = !ordersOpen"
            class="flex items-center justify-between w-full px-4 py-2 font-medium rounded-md
                   hover:bg-gray-100 text-gray-700 focus:outline-none">
            <span>Órdenes de Servicio</span>
            <svg
              :class="{ 'rotate-90': ordersOpen }"
              class="w-4 h-4 transition-transform"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M9 5l7 7-7 7" />
            </svg>
          </button>
          <div
            x-show="ordersOpen"
            x-transition
            class="pl-8 space-y-1"
            style="display: none;">
            <a
              href="{{ route('ordenes') }}"
              class="block px-4 py-2 rounded-md text-gray-600 hover:bg-gray-100">Listado de órdenes</a>
            <a
              href="{{ route('crearOrden') }}"
              class="block px-4 py-2 rounded-md text-gray-600 hover:bg-gray-100">Crear orden</a>
          </div>
        </div>

        <a
          href="{{ route('cronogramas') }}"
          class="block px-4 py-2 rounded-md font-medium
            {{ request()->is('cronogramas*') ? 'text-blue-600 bg-blue-50' : 'hover:bg-gray-100 text-gray-700' }}">Cronogramas</a>
        <a
          href="{{ route('talento') }}"
          class="block px-4 py-2 rounded-md font-medium
            {{ request()->is('cronogramas*') ? 'text-blue-600 bg-blue-50' : 'hover:bg-gray-100 text-gray-700' }}">Talento Humano</a>
      </nav>
    </aside>

    {{-- 3) Contenido principal --}}
    <div class="flex-1 flex flex-col">
      <header class="flex items-center justify-between px-4 py-3 bg-white border-b md:px-6">
        <div class="flex items-center">
          <button
            @click="sidebarOpen = !sidebarOpen"
            class="p-2 text-gray-600 hover:text-gray-800 focus:outline-none md:hidden"
            aria-label="Abrir menú">
            <svg
              class="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
          <h1 class="ml-3 text-lg font-semibold">
            @yield('page-title', 'HOME')
          </h1>
        </div>
        <div class="flex items-center gap-4">
          <button class="relative p-2 text-gray-600 hover:text-gray-800 focus:outline-none">
            🔔
            <span class="absolute -top-1 -right-1 w-2 h-2 bg-red-500 rounded-full"></span>
          </button>
          <img
            src="{{ asset('images/ot_epm.png') }}"
            class="w-8 h-8 rounded-full"
            alt="Perfil usuario" />
        </div>
      </header>

      <main class="flex-1 p-4 sm:p-6 lg:p-8 overflow-y-auto">
        @yield('content')
      </main>
    </div>

  </div>
</body>

</html>