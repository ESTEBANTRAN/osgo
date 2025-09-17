<?php

namespace App\Filament\Resources;

use App\Filament\Resources\OrdenServicioResource\Pages;
use App\Models\DistritosAgente;
use App\Models\Horario;
use App\Models\OrdenServicio;
use App\Models\Persona;
use App\Models\Sectore;
use App\Models\Vehiculo;
use Carbon\Carbon;
use Filament\Forms\Components\Actions\Action as FormsAction;   // ← Wizard / formulario
use Filament\Forms\Components\Actions;                        // ← Componente Actions
use Filament\Forms\Components\Actions\Action;                 // ← Acción individual
use Filament\Tables\Actions\Action  as TableAction;            // ← Acciones de la tabla
use Filament\Forms\Get;
use Filament\Forms\Form;
use Filament\Forms\Components\Wizard;
use Filament\Forms\Components\Wizard\Step;
use Filament\Forms\Components\Tabs;
use Filament\Forms\Components\Tabs\Tab;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Hidden;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Toggle;
use Filament\Resources\Resource;
use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\EditAction;
use Filament\Tables\Actions\BulkActionGroup;
use Filament\Tables\Actions\DeleteBulkAction;
use Filament\Tables\Columns\BadgeColumn;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\HtmlString;
use Illuminate\Support\Str;
use App\Models\TipoServicio;
use App\Models\DisposicionGeneral;




class OrdenServicioResource extends Resource
{
    protected static ?string $model = OrdenServicio::class;

    protected static ?string $modelLabel       = 'Orden de Servicio';
    protected static ?string $pluralModelLabel = 'Orden de Servicio';

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-check';
    protected static ?string $navigationLabel = 'Orden de Servicio';
    protected static ?string $navigationGroup = 'Principal';
    protected static ?int $navigationSort = 0;

    public static function form(Form $form): Form
    {
        $ids = [12, 13, 14, 15, 16, 17, 18];

        // Optimización: Cache las funciones para evitar consultas repetidas
        $funciones = cache()->remember('funciones_orden_servicio', 3600, function() use ($ids) {
            return \App\Models\Funcione::query()
            ->whereIn('ID_FUNCION', $ids)
            ->orderByRaw('FIELD(ID_FUNCION, ' . implode(',', $ids) . ')')
            ->pluck('FUNCION', 'ID_FUNCION')
            ->toArray();
        });

        // Optimización: Pre-cargar todas las opciones de personas por función usando vistas
        $personasPorFuncion = cache()->remember('personas_por_funcion_orden_v2', 1800, function() {
            $opciones = [];
            
            // Usar vista optimizada para obtener solo personas disponibles
            $personas_disponibles = DB::connection('sistema_principal')
                ->table('v_personas_disponibles')
                ->select('ID_PERSONA', 'ID_FUNCION', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                ->get();
            
            foreach ($personas_disponibles as $persona) {
                $funcion_id = $persona->ID_FUNCION;
                if (!isset($opciones[$funcion_id])) {
                    $opciones[$funcion_id] = [];
                }
                $opciones[$funcion_id][$persona->ID_PERSONA] = $persona->CODIGO_AGENTE . ' - ' . $persona->NOMBRE_COMPLETO;
            }
            
            return $opciones;
        });

        return $form
            ->schema([
                Wizard::make()
                    ->persistStepInQueryString()
                    ->live()
                    ->steps([
                        Step::make('Anexos')
                            ->description('Selecciona los anexos que deseas incluir en esta orden.')
                            ->completedIcon('heroicon-m-hand-thumb-up')
                            ->schema([
                                Toggle::make('includeEventos')
                                    ->label('Incluir Anexo Eventos')
                                    ->helperText('Marca para adjuntar el anexo de eventos.')
                                    ->reactive()
                                    ->default(true),
                                
                                Toggle::make('includeOperaciones')
                                    ->label('Incluir Anexo Operaciones')
                                    ->helperText('Marca para adjuntar el anexo de operaciones.')
                                    ->reactive()
                                    ->default(false),
                            ]),

                        Step::make('Orden de Servicio')
                            ->description('Captura aquí los datos principales de la orden generada.')
                            ->completedIcon('heroicon-m-hand-thumb-up')
                            ->schema([
                                Tabs::make('Detalles')
                                    ->tabs([
                                        Tab::make('Información General')
                                            ->schema([
                                                Grid::make(2)
                                                    ->schema([
                                                        Placeholder::make('responsable_operativo_display')
                                                            ->label('Responsable Operativo')
                                                            ->content(function() {
                                                                $user = Auth::user();
                                                                return $user->NAME ?? 'Usuario actual';
                                                            })
                                                            ->helperText('Usuario que está creando la orden de servicio.'),

                                                        Hidden::make('CREADO_POR')
                                                            ->default(fn() => Auth::user()->ID_USUARIO)
                                                            ->required(),

                                                        Placeholder::make('NRO_ORDEN')
                                                            ->label('Número de Orden')
                                                            ->reactive()
                                                            ->content(function (Get $get) {
                                                                if (! $get('FECHA')) {
                                                                    return '—';
                                                                }
                                                                $FECHA = Carbon::parse($get('FECHA'));
                                                                $daysInYear = $FECHA->isLeapYear() ? 366 : 365;
                                                                $dayOfYear  = $FECHA->dayOfYear;
                                                                return $daysInYear - $dayOfYear + 1;
                                                            })
                                                            ->helperText('Se calcula automáticamente según la fecha y el año.'),


                                                        DatePicker::make('FECHA')
                                                            ->label('Fecha de la Orden')
                                                            ->required()
                                                            ->reactive()
                                                            // Evita que el usuario seleccione fechas previas
                                                            ->minDate(Carbon::today()->toDateString())
                                                            // Regla de validación Laravel
                                                            ->rules(['after_or_equal:today'])
                                                            ->helperText('Selecciona la fecha en que se emitirá la orden.')
                                                            ->validationAttribute('Fecha de la Orden')
                                                            ->validationMessages([
                                                                'required'           => 'El campo Fecha de la Orden es obligatorio.',
                                                                'after_or_equal'     => 'La fecha no puede ser anterior al día de hoy.',
                                                            ]),

                                                        Select::make('distrito_canton')
                                                            ->label('Distrito')
                                                            ->options(
                                                                DistritosAgente::query()
                                                                    ->selectRaw("CONCAT(DISTRITO, ' - ', CANTON) AS full")
                                                                    ->orderBy('DISTRITO')
                                                                    ->orderBy('CANTON')
                                                                    ->pluck('full', 'full')
                                                            )
                                                            ->dehydrated(false)               // no lo mapea a la BD
                                                            ->reactive()                      // para disparar afterStateUpdated
                                                            ->afterStateHydrated(function ($state, callable $set, $record) {
                                                                if ($record) {
                                                                    $set('distrito_canton', "{$record->DISTRITO} - {$record->PROVINCIA}");
                                                                }
                                                            })
                                                            ->afterStateUpdated(function (string $state, callable $set) {
                                                                [$distrito, $canton] = explode(' - ', $state, 2);
                                                                $set('DISTRITO', $distrito);
                                                                $set('PROVINCIA', $canton); // Mapeamos CANTON a PROVINCIA en la BD
                                                            })
                                                            ->searchable()
                                                            ->required()
                                                            ->helperText('Ej.: “CENTRO - IBARRA”…'),

                                                        Hidden::make('DISTRITO')
                                                            ->required()
                                                            ->dehydrated()                     // sí se mapea
                                                            ->default(fn(callable $get) => explode(' - ', $get('distrito_canton') ?? '', 2)[0] ?? ''),

                                                        Hidden::make('PROVINCIA')
                                                            ->required()
                                                            ->dehydrated()
                                                            ->default(fn(callable $get) => explode(' - ', $get('distrito_canton') ?? '', 2)[1] ?? ''),

                                                        /*Placeholder::make('DISTRITO')
                                                            ->label('Distrito')
                                                            ->content(function () {
                                                                // Asumo que tu User model tiene relación persona() y esta a su vez distritoAgente()
                                                                $persona = Auth::user()->persona;

                                                                if (! $persona || ! $persona->distritoAgente) {
                                                                    return '—';
                                                                }

                                                                return "{$persona->distritoAgente->DISTRITO} - {$persona->distritoAgente->CANTON}";
                                                            })
                                                            ->helperText('Distrito asignado según tu perfil.')
                                                            */
                                                    ]),

                                                // 2) Selección de funciones (estáticas)
                                                Section::make('Seleccione a los Funcionarios Actuales')
                                                    ->schema([
                                                        Grid::make(3)
                                                            ->schema([
                                                                /***** Gerente Operativo  (ID_FUNCION = 1) *****/
                                                                Select::make('funciones.1')
                                                                    ->label('Gerente Operativo')
                                                                    ->options($personasPorFuncion[1] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '1')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Gerente Operativo')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Gerente Operativo es obligatorio.',
                                                                    ]),

                                                                /***** Jefe de Tránsito  (ID_FUNCION = 2) *****/
                                                                Select::make('funciones.2')
                                                                    ->label('Jefe de Tránsito')
                                                                    ->options($personasPorFuncion[2] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '2')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Jefe de Tránsito')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Jefe de Tránsito es obligatorio.',
                                                                    ]),

                                                                /***** Sub Jefe de Tránsito  (ID_FUNCION = 3) *****/
                                                                Select::make('funciones.3')
                                                                    ->label('Sub Jefe de Tránsito')
                                                                    ->options($personasPorFuncion[3] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '3')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Sub Jefe de Tránsito')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Sub Jefe de Tránsito es obligatorio.',
                                                                    ]),

                                                                /***** Inspector Distrito Centro  (ID_FUNCION = 4) *****/
                                                                Select::make('funciones.4')
                                                                    ->label('Inspector Distrito Centro')
                                                                    ->options($personasPorFuncion[4] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '4')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Inspector Distrito Centro')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Inspector Distrito Centro es obligatorio.',
                                                                    ]),

                                                                /***** Operaciones P3  (ID_FUNCION = 5) *****/
                                                                Select::make('funciones.5')
                                                                    ->label('Operaciones P3')
                                                                    ->options($personasPorFuncion[5] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '5')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Operaciones P3')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Operaciones P3 es obligatorio.',
                                                                    ]),

                                                                /***** Inspector Distrito Sur  (ID_FUNCION = 6) *****/
                                                                Select::make('funciones.6')
                                                                    ->label('Inspector Distrito Sur')
                                                                    ->options($personasPorFuncion[6] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '6')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Inspector Distrito Sur')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Inspector Distrito Sur es obligatorio.',
                                                                    ]),

                                                                /***** Inspector Distrito Norte  (ID_FUNCION = 7) *****/
                                                                Select::make('funciones.7')
                                                                    ->label('Inspector Distrito Norte')
                                                                    ->options($personasPorFuncion[7] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '7')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Inspector Distrito Norte')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Inspector Distrito Norte es obligatorio.',
                                                                    ]),

                                                                /***** Sub Inspector Cantón Pimampiro  (ID_FUNCION = 8) *****/
                                                                Select::make('funciones.8')
                                                                    ->label('Sub Inspector Cantón Pimampiro')
                                                                    ->options($personasPorFuncion[8] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '8')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Sub Inspector Cantón Pimampiro')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Sub Inspector Cantón Pimampiro es obligatorio.',
                                                                    ]),

                                                                /***** Conductor G.O.T.  (ID_FUNCION = 9) *****/
                                                                Select::make('funciones.9')
                                                                    ->label('Conductor G.O.T.')
                                                                    ->options($personasPorFuncion[9] ?? [])
                                                                    ->default(
                                                                        fn(?OrdenServicio $record) =>
                                                                        $record
                                                                            ?->detalle_orden_servicios
                                                                            ->firstWhere('ID_FUNCION', '9')
                                                                            ?->persona
                                                                            ?->ID_PERSONA
                                                                    )
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required()
                                                                    ->validationAttribute('Conductor G.O.T.')
                                                                    ->validationMessages([
                                                                        'required' => 'El campo Conductor G.O.T. es obligatorio.',
                                                                    ]),
                                                            ]),
                                                    ]),
                                            ]),

                                        Tab::make('Control')
                                            ->schema([
                                                // --- Título: Jefe de Control Distrito Centro ---
                                                Placeholder::make('titulo_jefe_control')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Encargados de Control Distrito Centro</h2>'
                                                    )),

                                                // --- Encargados de Control (hasta 4: inspectores/sub-inspectores) ---
                                                Repeater::make('control.jefe_control')
                                                    ->label('')
                                                    ->addable(false)
                                                    ->deletable(false)
                                                    ->reorderable(false)
                                                    ->minItems(4)
                                                    ->maxItems(4)
                                                    ->default([
                                                        ['funcion_id' => 10],
                                                        ['funcion_id' => 11],
                                                        ['funcion_id' => 10],
                                                        ['funcion_id' => 11],
                                                    ])
                                                    ->schema([
                                                        /* Horario */
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        /* Función (solo lectura) */
                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Función')
                                                            ->content(fn(Get $get) => Str::of(
                                                                \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                            )->replace('_', ' ')->upper()),

                                                        /* Responsable filtrado por función */
                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required()
                                                            ->searchable()
                                                            ->preload()
                                                            ->required()
                                                            ->placeholder('Seleccione un responsable'),

                                                        /* Función oculta para persistir */
                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full')
                                                    ->validationAttribute('Encargados de Control')
                                                    ->validationAttribute('Encargados de Control'),
                                                // --- Separador visual ---
                                                Placeholder::make('separador_control')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                // --- Título: Personal Administrativo Operativo ---
                                                Placeholder::make('titulo_personal_admin')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Personal Administrativo Operativo</h2>'
                                                    )),

                                                // --- Grid con roles administrativos fijos (7) ---
                                                Repeater::make('control.personal_admin.funciones')
                                                    ->label('')
                                                    ->minItems(count($funciones))
                                                    ->maxItems(count($funciones))
                                                    ->addable(false)
                                                    ->deletable(false)
                                                    ->reorderable(false)
                                                    ->default(
                                                        collect(array_keys($funciones))
                                                            ->map(fn($id) => ['funcion_id' => $id])
                                                            ->toArray()
                                                    )
                                                    ->schema([
                                                        // Usuario sólo elige horario
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        // Muestra el nombre según el ID
                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Función')
                                                            ->content(fn(Get $get) => $funciones[$get('funcion_id')] ?? ''),

                                                        // Usuario sólo elige responsable, filtrado por función fija
                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required()
                                                            ->placeholder('Seleccione un responsable'),

                                                        // Guarda internamente el ID de la función para el model
                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),
                                            ]),

                                        Tab::make('Despacho')
                                            ->schema([

                                                /* ──────────────── SALA DE OPERACIONES Y DESPACHO ──────────────── */
                                                Placeholder::make('titulo_sala_ops')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Sala de Operaciones y Despacho</h2>'
                                                    )),

                                                Repeater::make('despacho.sala_ops')
                                                    ->label('')
                                                    ->addable(false)
                                                    ->deletable(false)
                                                    ->reorderable(false)
                                                    ->minItems(5)->maxItems(5)           // DESPACHO-A…E
                                                    ->default([
                                                        ['funcion_id' => 19], // DESPACHO-A
                                                        ['funcion_id' => 20], // DESPACHO-B
                                                        ['funcion_id' => 21], // DESPACHO-C
                                                        ['funcion_id' => 22], // DESPACHO-D
                                                        ['funcion_id' => 23], // DESPACHO-E
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(\App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? '')
                                                                    ->replace('_', ' ')
                                                                    ->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),

                                                /* Separador visual */
                                                Placeholder::make('sep_despacho1')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                /* ──────────────── SALA VIDEO VIGILANCIA ──────────────── */
                                                Placeholder::make('titulo_video_vig')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Sala Video Vigilancia</h2>'
                                                    )),

                                                Repeater::make('despacho.video_vig')
                                                    ->label('')
                                                    ->addable(false)
                                                    ->deletable(false)
                                                    ->reorderable(false)
                                                    ->minItems(5)->maxItems(5)           // VISOR-A…E
                                                    ->default([
                                                        ['funcion_id' => 24], // VISOR-A
                                                        ['funcion_id' => 25], // VISOR-B
                                                        ['funcion_id' => 26], // VISOR-C
                                                        ['funcion_id' => 27], // VISOR-D
                                                        ['funcion_id' => 28], // VISOR-E
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(\App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? '')
                                                                    ->replace('_', ' ')
                                                                    ->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),

                                                /* Separador visual */
                                                Placeholder::make('sep_despacho2')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                /* ──────────────── TERMINAL T.P. ──────────────── */
                                                Placeholder::make('titulo_terminal')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Unidad de Control de Transporte Público Terminal</h2>'
                                                    )),

                                                Repeater::make('despacho.terminal')
                                                    ->label('')
                                                    ->addable(false)
                                                    ->deletable(false)
                                                    ->reorderable(false)
                                                    ->minItems(3)->maxItems(3)           // 3 filas
                                                    ->default([
                                                        ['funcion_id' => 29],
                                                        ['funcion_id' => 29],
                                                        ['funcion_id' => 29],
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(\App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? '')
                                                                    ->replace('_', ' ')
                                                                    ->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),
                                            ]),


                                        Tab::make('Centros de Retención Vehicular')
                                            ->schema([

                                                /* ────────── 1. REVIPLUS ────────── */
                                                Placeholder::make('titulo_retvplus')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Centro de Retención Vehicular – REVIPLUS</h2>'
                                                    )),

                                                Repeater::make('retencion.retvplus')
                                                    ->label('')
                                                    ->addable(false)->deletable(false)->reorderable(
                                                        false
                                                    )
                                                    ->minItems(5)->maxItems(5)
                                                    ->default([
                                                        ['funcion_id' => 30],
                                                        ['funcion_id' => 30],
                                                        ['funcion_id' => 30],
                                                        ['funcion_id' => 30],
                                                        ['funcion_id' => 30],
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        /* ➜ Texto dinámico, igual al bloque VISOR */
                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(
                                                                    \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                                )->replace('_', ' ')->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),

                                                Placeholder::make('sep_ret1')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                /* ────────── 2. Av. 13 DE ABRIL ────────── */
                                                Placeholder::make('titulo_av13')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Centro de Retención Vehicular – Av. 13 de Abril</h2>'
                                                    )),

                                                Repeater::make('retencion.av13')
                                                    ->label('')
                                                    ->addable(false)->deletable(false)->reorderable(
                                                        false
                                                    )
                                                    ->minItems(6)->maxItems(6)
                                                    ->default([
                                                        ['funcion_id' => 31],
                                                        ['funcion_id' => 31],
                                                        ['funcion_id' => 31],
                                                        ['funcion_id' => 31],
                                                        ['funcion_id' => 31],
                                                        ['funcion_id' => 31],
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(
                                                                    \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                                )->replace('_', ' ')->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),

                                                Placeholder::make('sep_ret2')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                /* ────────── 3. CDIT ────────── */
                                                Placeholder::make('titulo_cdit')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Centro de Detención de Infractores de Tránsito</h2>'
                                                    )),

                                                Repeater::make('retencion.cdit')
                                                    ->label('')
                                                    ->addable(false)->deletable(false)->reorderable(
                                                        false
                                                    )
                                                    ->minItems(5)->maxItems(5)
                                                    ->default([
                                                        ['funcion_id' => 32],
                                                        ['funcion_id' => 32],
                                                        ['funcion_id' => 32],
                                                        ['funcion_id' => 32],
                                                        ['funcion_id' => 32],
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(
                                                                    \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                                )->replace('_', ' ')->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),
                                            ]),

                                        Tab::make('Grupos Operativos Especiales')
                                            ->schema([

                                                /* ────────────── GRUPO DE GESTIÓN OPERATIVA ────────────── */
                                                Placeholder::make('titulo_gop')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Grupo de Gestión Operativa</h2>'
                                                    )),

                                                Repeater::make('grupos.gestion_op')
                                                    ->label('')
                                                    ->addable(false)->deletable(false)->reorderable(false)
                                                    ->minItems(5)->maxItems(5)
                                                    ->default([
                                                        ['funcion_id' => 33],
                                                        ['funcion_id' => 33],
                                                        ['funcion_id' => 33],
                                                        ['funcion_id' => 33],
                                                        ['funcion_id' => 33],
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horarios')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(
                                                                    \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                                )->replace('_', ' ')->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),

                                                Placeholder::make('sep_go1')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                /* ────────────── GRUPO OPERATIVO INFORMALIDAD ────────────── */
                                                Placeholder::make('titulo_informal')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Grupo Operativo Informalidad</h2>'
                                                    )),

                                                Repeater::make('grupos.informalidad')
                                                    ->label('')
                                                    ->addable(false)->deletable(false)->reorderable(false)
                                                    ->minItems(5)->maxItems(5)
                                                    ->default([
                                                        ['funcion_id' => 34],
                                                        ['funcion_id' => 34],
                                                        ['funcion_id' => 34],
                                                        ['funcion_id' => 34],
                                                        ['funcion_id' => 34],
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horarios')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(
                                                                    \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                                )->replace('_', ' ')->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),

                                                Placeholder::make('sep_go2')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                /* ────────────── GRUPO OPERATIVO ESTADOS DE EMBRIAGUEZ ────────────── */
                                                Placeholder::make('titulo_embriaguez')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Grupo Operativo Estados de Embriaguez</h2>'
                                                    )),

                                                Repeater::make('grupos.embriaguez')
                                                    ->label('')
                                                    ->addable(false)->deletable(false)->reorderable(false)
                                                    ->minItems(5)->maxItems(5)
                                                    ->default([
                                                        ['funcion_id' => 35],
                                                        ['funcion_id' => 35],
                                                        ['funcion_id' => 35],
                                                        ['funcion_id' => 35],
                                                        ['funcion_id' => 35],
                                                    ])
                                                    ->schema([
                                                        Select::make('horario_id')
                                                            ->label('Horarios')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(
                                                                    \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                                )->replace('_', ' ')->upper()
                                                            ),

                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),
                                            ]),


                                        Tab::make('Educación Vial y Grúa')
                                            ->schema([

                                                /* ─────────── EDUCACIÓN VIAL ─────────── */
                                                Placeholder::make('titulo_edu_vial')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Educación Vial</h2>'
                                                    )),

                                                Repeater::make('educacion.vial')
                                                    ->label('Educación Vial')
                                                    ->addable(false)->deletable(false)->reorderable(false)
                                                    ->minItems(5)->maxItems(5)                    // 5 horarios
                                                    ->default([
                                                        ['funcion_id' => 36],
                                                        ['funcion_id' => 36],
                                                        ['funcion_id' => 36],
                                                        ['funcion_id' => 36],
                                                        ['funcion_id' => 36],
                                                    ])
                                                    ->schema([
                                                        /* Horario */
                                                        Select::make('horario_id')
                                                            ->label('Horarios')
                                                            ->options(\App\Models\Horario::options())
                                                            ->required(),

                                                        /* Descripción fija de la función (se extrae de la BD) */
                                                        Placeholder::make('funcion_nombre')
                                                            ->label('Funciones')
                                                            ->content(
                                                                fn(Get $get) =>
                                                                Str::of(
                                                                    \App\Models\Funcione::find($get('funcion_id'))->FUNCION ?? ''
                                                                )->replace('_', ' ')->upper()
                                                            ),

                                                        /* Responsable */
                                                        Select::make('responsable_id')
                                                            ->label('Responsable')
                                                            ->options(function() {
                                                                return DB::connection('sistema_principal')
                                                                    ->table('v_personas_disponibles')
                                                                    ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                    ->get()
                                                                    ->mapWithKeys(function($item) {
                                                                        return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                    })
                                                                    ->toArray();
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(),

                                                        Hidden::make('funcion_id'),
                                                    ])
                                                    ->columns(3)
                                                    ->columnSpan('full'),

                                                Placeholder::make('sep_evg1')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString('<hr class="my-4" />')),

                                                /* ─────────── SERVICIO DE GRÚA PARTICULAR ─────────── */
                                                Placeholder::make('titulo_grua_particular')
                                                    ->label('')
                                                    ->columnSpan('full')
                                                    ->content(new HtmlString(
                                                        '<h2 class="text-xl font-bold">Servicio de Grúa Particular (en caso de no disponer grúas de la empresa)</h2>'
                                                    )),

                                                Repeater::make('educacion.grua')
                                                    ->label('SERVICIO DE GRÚA PARTICULAR')
                                                    ->addable(true)
                                                    ->deletable(true)
                                                    ->reorderable(false)
                                                    ->minItems(1)
                                                    ->maxItems(2)
                                                    ->default([])
                                                    ->schema([
                                                        Select::make('servicio_grua_id')
                                                            ->label('CONTRATO Y PROPIETARIO')
                                                            ->options(function () {
                                                                return \App\Models\ServicioGrua::all()->mapWithKeys(function ($row) {
                                                                    return [
                                                                        $row->ID_SERVICIO_GRUA => $row->PROPIETARIO . ' - ' . substr($row->CONTRATO, 0, 2)
                                                                    ];
                                                                });
                                                            })
                                                            ->searchable()
                                                            ->preload()
                                                            ->required(fn($get) => !empty($get('servicio_grua_id')))
                                                            ->reactive(),


                                                        Placeholder::make('contacto')
                                                            ->label('CONTACTO')
                                                            ->content(function ($get) {
                                                                // Verificar si 'servicio_grua_id' tiene valor
                                                                $servicioId = $get('servicio_grua_id');
                                                                if (!$servicioId) {
                                                                    return ''; // Si no tiene valor, no hacer nada
                                                                }

                                                                $servicio = \App\Models\ServicioGrua::find($servicioId);
                                                                return $servicio ? $servicio->CONTRATO . ' / ' . $servicio->TELEFONO : '';
                                                            })
                                                            ->columnSpan(1),

                                                        Hidden::make('funcion_id')->default(37),
                                                    ])
                                                    ->columns(2)
                                                    ->columnSpan('full'),

                                            ]),

                                        Tab::make('Conductor y Acompañante')
                                            ->schema([
                                                /* -------------------------- DOTACIÓN (padre) ------------------------- */
                                                Repeater::make('dotaciones')
                                                    ->label('Dotaciones por Horario y Grupo Operativo')
                                                    ->addable()
                                                    ->deletable()
                                                    ->schema([
                                                        // Horario y Grupo Operativo para todo el bloque
                                                        Select::make('horario_id')
                                                            ->label('Horario')
                                                            ->options(Horario::options())
                                                            ->required(),

                                                        Select::make('grupo_operativo_id')
                                                            ->label('Grupo Operativo')
                                                            ->options(\App\Models\GrupoOperativo::pluck('grupo_operativo', 'id_grupo_operativo'))
                                                            ->required()
                                                            ->reactive(),

                                                        // Sectores/Vehículos y Personal (repeater hijo)
                                                        Repeater::make('sectores')
                                                            ->label('Sectores y Vehículos')
                                                            ->addable()
                                                            ->deletable()
                                                            ->schema([
                                                                Select::make('vehiculo_id')
                                                                    ->label('Placa')
                                                                    ->options(Vehiculo::options())
                                                                    ->searchable()
                                                                    ->required(),

                                                                Select::make('sector_id')
                                                                    ->label('Sector')
                                                                    ->options(Sectore::options())
                                                                    ->searchable()
                                                                    ->required(),

                                                                // Novedades/Observaciones para este sector/vehículo
                                                                Textarea::make('novedades')
                                                                    ->label('Novedades a cumplir')
                                                                    ->rows(1)
                                                                    ->autosize()
                                                                    ->columnSpan('full')
                                                                    ->maxLength(2000),

                                                                // Personal para este sector/vehículo
                                                                Repeater::make('personal')
                                                                    ->label('Personal asignado')
                                                                    ->addable()
                                                                    ->deletable()
                                                                    ->minItems(1)
                                                                    ->schema([
                                                                        Select::make('persona_id')
                                                                            ->label('Persona')
                                                                            ->options(function (callable $get) {
                                                                                $grupoId = data_get($get('../../'), 'grupo_operativo_id');
                                                                                if (!$grupoId) {
                                                                                    return [];
                                                                                }
                                                                                return \App\Models\Persona::where('grupo_operativo_id', $grupoId)
                                                                                    ->pluck('nombre', 'ID_PERSONA');
                                                                            })
                                                                            ->searchable()
                                                                            ->required(),
                                                                    ])
                                                                    ->columns(1)
                                                                    ->columnSpan('full'),
                                                            ])
                                                            ->columns(2)
                                                            ->columnSpan('full'),
                                                    ])
                                                    ->columns(2)
                                                    ->columnSpan('full'),
                                            ]),


                                        Tab::make('Tipos de Servicio')
                                            ->schema([
                                                Section::make('Servicios Seleccionados')
                                                    ->description('Configura los tipos de servicio que aplicarán a esta orden')
                                                    ->schema([
                                                        Repeater::make('tipos_servicio_seleccionados')
                                                            ->label('Servicios Incluídos')
                                                            ->addActionLabel('Agregar Tipo de Servicio')
                                                            ->schema([
                                                                Select::make('id_tipo_servicio')
                                                                    ->label('Tipo de Servicio')
                                                                    ->options(function() {
                                                                        return \App\Models\TipoServicio::where('ACTIVO', true)
                                                                            ->pluck('TIPO_SERVICIO', 'ID_TIPO_SERVICIO')
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->required()
                                                                    ->reactive()
                                                                    ->afterStateUpdated(function($state, $set) {
                                                                        if ($state) {
                                                                            $tipo = \App\Models\TipoServicio::find($state);
                                                                            if ($tipo) {
                                                                                $set('requiere_vehiculo', $tipo->REQUIERE_VEHICULO);
                                                                                $set('requiere_horario', $tipo->REQUIERE_HORARIO);
                                                                                $set('requiere_sector', $tipo->REQUIERE_SECTOR);
                                                                            }
                                                                        }
                                                                    }),

                                                                Hidden::make('requiere_vehiculo'),
                                                                Hidden::make('requiere_horario'),
                                                                Hidden::make('requiere_sector'),

                                                                Grid::make(2)->schema([
                                                                    Select::make('horario')
                                                                        ->label('Horario')
                                                                        ->visible(fn(Get $get) => $get('requiere_horario'))
                                                                        ->options(function() {
                                                                            return DB::connection('osgo')
                                                                                ->table('osgo_horarios')
                                                                                ->where('ACTIVO', 'SI')
                                                                                ->pluck('NOMBRE', 'NOMBRE')
                                                                                ->toArray();
                                                                        })
                                                                        ->searchable(),

                                                                    Select::make('placa_vehiculo')
                                                                        ->label('Placa del Vehículo')
                                                                        ->visible(fn(Get $get) => $get('requiere_vehiculo'))
                                                                        ->options(function() {
                                                                            return DB::connection('osgo')
                                                                                ->table('osgo_vehiculo')
                                                                                ->where('ACTIVO', 'SI')
                                                                                ->pluck('PLACA', 'PLACA')
                                                                                ->toArray();
                                                                        })
                                                                        ->searchable(),
                                                                ]),

                                                                Grid::make(2)->schema([
                                                                    Select::make('grupo_asignado')
                                                                        ->label('Grupo Asignado')
                                                                        ->options([
                                                                            'GRUPO_A' => 'GRUPO A',
                                                                            'GRUPO_B' => 'GRUPO B', 
                                                                            'GRUPO_C' => 'GRUPO C',
                                                                            'GRUPO_D' => 'GRUPO D',
                                                                            'GRUPO_E' => 'GRUPO E',
                                                                            'GRUPO_A_M' => 'GRUPO A MOTORIZADO',
                                                                            'GRUPO_B_M' => 'GRUPO B MOTORIZADO',
                                                                            'GRUPO_C_M' => 'GRUPO C MOTORIZADO',
                                                                            'GRUPO_A_MOTOS' => 'GRUPO A MOTOS',
                                                                            'GRUPO_B_MOTOS' => 'GRUPO B MOTOS',
                                                                            'GRUPO_C_MOTOS' => 'GRUPO C MOTOS',
                                                                            'GA_PEDESTRE' => 'GRUPO A PEDESTRE',
                                                                            'GB_PEDESTRE' => 'GRUPO B PEDESTRE',
                                                                            'GC_PEDESTRE' => 'GRUPO C PEDESTRE'
                                                                        ])
                                                                        ->searchable(),

                                                                    Select::make('responsable')
                                                                        ->label('Responsable')
                                                                        ->options(function() {
                                                                            return DB::connection('sistema_principal')
                                                                                ->table('v_personas_disponibles')
                                                                                ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                                ->get()
                                                                                ->mapWithKeys(function($item) {
                                                                                    return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                                })
                                                                                ->toArray();
                                                                        })
                                                                        ->searchable()
                                                                        ->preload(),
                                                                ]),

                                                                Hidden::make('codigo_responsable')
                                                                    ->label('Código del Responsable')
                                                                    ->reactive()
                                                                    ->afterStateUpdated(function($state, $set, $get) {
                                                                        if ($get('responsable')) {
                                                                            $persona = DB::connection('sistema_principal')
                                                                                ->table('v_personas_disponibles')
                                                                                ->where('ID_PERSONA', $get('responsable'))
                                                                                ->first();
                                                                            if ($persona) {
                                                                                $set('codigo_responsable', $persona->CODIGO_AGENTE);
                                                                            }
                                                                        }
                                                                    }),

                                                                Textarea::make('sector_descripcion')
                                                                    ->label('Descripción del Sector')
                                                                    ->visible(fn(Get $get) => $get('requiere_sector'))
                                                                    ->rows(2)
                                                                    ->placeholder('Describe el sector o área específica'),

                                                                Textarea::make('novedades')
                                                                    ->label('Novedades')
                                                                    ->rows(2)
                                                                    ->placeholder('Registra cualquier novedad o evento importante'),

                                                                Textarea::make('observaciones')
                                                                    ->label('Observaciones')
                                                                    ->rows(2)
                                                                    ->placeholder('Observaciones adicionales del servicio'),
                                                            ])
                                                            ->columns(1)
                                                            ->columnSpanFull()
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),
                                            ]),

                                        Tab::make('Jefe de Control Distrito Centro')
                                            ->schema([
                                                Section::make('Control de Distrito Centro')
                                                    ->description('Asignación de personal para control del distrito centro')
                                                    ->schema([
                                                        Repeater::make('control_distrito_centro')
                                                            ->label('Asignaciones de Control')
                                                            ->addActionLabel('Agregar Asignación')
                                                            ->schema([
                                                                Select::make('horario')
                                                                    ->label('Horario')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_horarios')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE', 'NOMBRE')
                                                                            ->toArray();
                                                                    })
                                                                    ->required()
                                                                    ->searchable(),

                                                                Select::make('funcion')
                                                                    ->label('Función')
                                                                    ->options([
                                                                        'INSPECTOR DE CONTROL GENERAL' => 'INSPECTOR DE CONTROL GENERAL',
                                                                        'SUB INSPECTOR DE CONTROL GENERAL' => 'SUB INSPECTOR DE CONTROL GENERAL',
                                                                        'JEFE DE CONTROL DISTRITO CENTRO' => 'JEFE DE CONTROL DISTRITO CENTRO'
                                                                    ])
                                                                    ->required(),

                                                                Select::make('responsable')
                                                                    ->label('Responsable')
                                                                    ->options(function() {
                                                                        return DB::connection('sistema_principal')
                                                                            ->table('v_personas_disponibles')
                                                                            ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                            ->get()
                                                                            ->mapWithKeys(function($item) {
                                                                                return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                            })
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required(),
                                                            ])
                                                            ->columns(3)
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),
                                            ]),

                                        Tab::make('Personal Administrativo Operativo')
                                            ->schema([
                                                Section::make('Personal Administrativo')
                                                    ->description('Asignación de personal administrativo y operativo')
                                                    ->schema([
                                                        Repeater::make('personal_administrativo')
                                                            ->label('Personal Administrativo')
                                                            ->addActionLabel('Agregar Personal')
                                                            ->schema([
                                                                Select::make('horario')
                                                                    ->label('Horario')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_horarios')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE', 'NOMBRE')
                                                                            ->toArray();
                                                                    })
                                                                    ->required()
                                                                    ->searchable(),

                                                                Select::make('funcion')
                                                                    ->label('Función')
                                                                    ->options([
                                                                        'LOGISTICA P4' => 'LOGISTICA P4',
                                                                        'COORDINACIÓN SISTEMA INTEGRADO DE SEGURIDAD ECU.911' => 'COORDINACIÓN SISTEMA INTEGRADO DE SEGURIDAD ECU.911',
                                                                        'COMISIONADO CENTRO DE RETENCION VEHICULAR' => 'COMISIONADO CENTRO DE RETENCION VEHICULAR',
                                                                        'GESTOR DE DATOS' => 'GESTOR DE DATOS',
                                                                        'ASISTENTE DEL JEFE DE TRÁNSITO' => 'ASISTENTE DEL JEFE DE TRÁNSITO',
                                                                        'ESTADISTICAS GERENCIA OPERATIVA' => 'ESTADISTICAS GERENCIA OPERATIVA',
                                                                        'PROCESO DE CHATARRIZACIÓN' => 'PROCESO DE CHATARRIZACIÓN'
                                                                    ])
                                                                    ->required(),

                                                                Select::make('responsable')
                                                                    ->label('Responsable')
                                                                    ->options(function() {
                                                                        return DB::connection('sistema_principal')
                                                                            ->table('v_personas_disponibles')
                                                                            ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                            ->get()
                                                                            ->mapWithKeys(function($item) {
                                                                                return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                            })
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required(),
                                                            ])
                                                            ->columns(3)
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),
                                            ]),

                                        Tab::make('Salas de Operaciones y Despacho')
                                            ->schema([
                                                Section::make('Salas de Operaciones')
                                                    ->description('Asignación de personal para salas de operaciones y despacho')
                                                    ->schema([
                                                        Repeater::make('salas_operaciones')
                                                            ->label('Salas de Operaciones')
                                                            ->addActionLabel('Agregar Sala')
                                                            ->schema([
                                                                Select::make('horario')
                                                                    ->label('Horario')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_horarios')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE', 'NOMBRE')
                                                                            ->toArray();
                                                                    })
                                                                    ->required()
                                                                    ->searchable(),

                                                                Select::make('funcion')
                                                                    ->label('Función')
                                                                    ->options([
                                                                        'DESPACHO A' => 'DESPACHO A',
                                                                        'DESPACHO B' => 'DESPACHO B',
                                                                        'DESPACHO C' => 'DESPACHO C',
                                                                        'DESPACHO D' => 'DESPACHO D',
                                                                        'DESPACHO E' => 'DESPACHO E'
                                                                    ])
                                                                    ->required(),

                                                                Select::make('responsable')
                                                                    ->label('Responsable')
                                                                    ->options(function() {
                                                                        return DB::connection('sistema_principal')
                                                                            ->table('v_personas_disponibles')
                                                                            ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                            ->get()
                                                                            ->mapWithKeys(function($item) {
                                                                                return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                            })
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required(),
                                                            ])
                                                            ->columns(3)
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),
                                            ]),

                                        Tab::make('Sala Video Vigilancia')
                                            ->schema([
                                                Section::make('Video Vigilancia')
                                                    ->description('Asignación de personal para sala de video vigilancia')
                                                    ->schema([
                                                        Repeater::make('video_vigilancia')
                                                            ->label('Video Vigilancia')
                                                            ->addActionLabel('Agregar Asignación')
                                                            ->schema([
                                                                Select::make('horario')
                                                                    ->label('Horario')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_horarios')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE', 'NOMBRE')
                                                                            ->toArray();
                                                                    })
                                                                    ->required()
                                                                    ->searchable(),

                                                                Select::make('funcion')
                                                                    ->label('Función')
                                                                    ->options([
                                                                        'VISOR A' => 'VISOR A',
                                                                        'VISOR B' => 'VISOR B',
                                                                        'VISOR C' => 'VISOR C',
                                                                        'VISOR D' => 'VISOR D',
                                                                        'VISOR E' => 'VISOR E'
                                                                    ])
                                                                    ->required(),

                                                                Select::make('responsable')
                                                                    ->label('Responsable')
                                                                    ->options(function() {
                                                                        return DB::connection('sistema_principal')
                                                                            ->table('v_personas_disponibles')
                                                                            ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                            ->get()
                                                                            ->mapWithKeys(function($item) {
                                                                                return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                            })
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required(),
                                                            ])
                                                            ->columns(3)
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),
                                            ]),

                                        Tab::make('Servicios Motorizados')
                                            ->schema([
                                                Section::make('Circuitos y Asignaciones')
                                                    ->description('Asignación de circuitos y personal para servicios motorizados')
                                                    ->schema([
                                                        Repeater::make('servicios_motorizados')
                                                            ->label('Servicios Motorizados')
                                                            ->addActionLabel('Agregar Servicio')
                                                            ->schema([
                                                                Select::make('horario')
                                                                    ->label('Horario')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_horarios')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE', 'NOMBRE')
                                                                            ->toArray();
                                                                    })
                                                                    ->required()
                                                                    ->searchable(),

                                                                Select::make('placa_vehiculo')
                                                                    ->label('Placa del Vehículo')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_vehiculo')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('PLACA', 'PLACA')
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable(),

                                                                Select::make('circuito')
                                                                    ->label('Circuito')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_circuitos')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE_CIRCUITO', 'NOMBRE_CIRCUITO')
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable(),

                                                                Select::make('sector')
                                                                    ->label('Sector')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_sectores')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE_SECTOR', 'NOMBRE_SECTOR')
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable(),

                                                                Select::make('novedades')
                                                                    ->label('Novedades a Cumplir')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_novedades')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('DESCRIPCION', 'DESCRIPCION')
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->multiple(),

                                                                Select::make('responsable')
                                                                    ->label('Responsable')
                                                                    ->options(function() {
                                                                        return DB::connection('sistema_principal')
                                                                            ->table('v_personas_disponibles')
                                                                            ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                            ->get()
                                                                            ->mapWithKeys(function($item) {
                                                                                return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                            })
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->preload()
                                                                    ->required(),

                                                                Select::make('grupo_operativo')
                                                                    ->label('Grupo Operativo')
                                                                    ->options(function() {
                                                                        return DB::connection('osgo')
                                                                            ->table('osgo_grupos_operativos')
                                                                            ->where('ACTIVO', 'SI')
                                                                            ->pluck('NOMBRE_GRUPO', 'CODIGO_GRUPO')
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable(),
                                                            ])
                                                            ->columns(3)
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),
                                            ]),

                                        Tab::make('Control de Personal')
                                            ->schema([
                                                Section::make('Personal Franco y Vacaciones')
                                                    ->description('Configura el personal que estará en franco, vacaciones u otras indisponibilidades')
                                                    ->schema([
                                                        Repeater::make('personal_control')
                                                            ->label('Personal con Control Especial')
                                                            ->addActionLabel('Agregar Personal')
                                                            ->schema([
                                                                Select::make('id_persona')
                                                                    ->label('Personal')
                                                                    ->options(function() {
                                                                        return DB::connection('sistema_principal')
                                                                            ->table('v_personas_disponibles')
                                                                            ->select('ID_PERSONA', 'CODIGO_AGENTE', 'NOMBRE_COMPLETO')
                                                                            ->get()
                                                                            ->mapWithKeys(function($item) {
                                                                                return [$item->ID_PERSONA => $item->CODIGO_AGENTE . ' - ' . $item->NOMBRE_COMPLETO];
                                                                            })
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->required()
                                                                    ->reactive()
                                                                    ->afterStateUpdated(function($state, $set) {
                                                                        if ($state) {
                                                                            $persona = DB::connection('sistema_principal')
                                                                                ->table('v_personas_disponibles')
                                                                                ->where('ID_PERSONA', $state)
                                                                                ->first();
                                                                            if ($persona) {
                                                                                $set('codigo_agente', $persona->CODIGO_AGENTE);
                                                                                $set('nombre_completo', $persona->NOMBRE_COMPLETO);
                                                                                $set('funcion', $persona->FUNCION ?? '');
                                                                            }
                                                                        }
                                                                    }),

                                                                Hidden::make('codigo_agente'),
                                                                Hidden::make('nombre_completo'),
                                                                Hidden::make('funcion'),

                                                                Select::make('tipo_control')
                                                                    ->label('Tipo de Control')
                                                                    ->options([
                                                                        'FRANCO' => 'FRANCO',
                                                                        'VACACIONES' => 'VACACIONES',
                                                                        'ENFERMEDAD' => 'ENFERMEDAD',
                                                                        'LICENCIA' => 'LICENCIA',
                                                                        'CAPACITACIÓN' => 'CAPACITACIÓN',
                                                                        'COMISIÓN DE SERVICIOS' => 'COMISIÓN DE SERVICIOS',
                                                                        'PERMISO PERSONAL' => 'PERMISO PERSONAL',
                                                                        'SUB INSPECTOR FRANCO' => 'SUB INSPECTOR FRANCO',
                                                                        'PERSONAL VACACIONES' => 'PERSONAL VACACIONES',
                                                                        'PERSONAL ENFERMEDAD' => 'PERSONAL ENFERMEDAD',
                                                                        'PERSONAL LICENCIA' => 'PERSONAL LICENCIA',
                                                                        'PERSONAL CAPACITACIÓN' => 'PERSONAL CAPACITACIÓN',
                                                                        'PERSONAL COMISIÓN' => 'PERSONAL COMISIÓN',
                                                                        'PERSONAL PERMISO' => 'PERSONAL PERMISO',
                                                                    ])
                                                                    ->required()
                                                                    ->searchable(),

                                                                Grid::make(2)->schema([
                                                                    DatePicker::make('fecha_desde')
                                                                        ->label('Fecha Desde')
                                                                        ->required()
                                                                        ->default(now()),

                                                                    DatePicker::make('fecha_hasta')
                                                                        ->label('Fecha Hasta')
                                                                        ->required()
                                                                        ->default(now()->addDays(1)),
                                                                ]),

                                                                Textarea::make('observaciones')
                                                                    ->label('Observaciones')
                                                                    ->rows(2)
                                                                    ->placeholder('Observaciones específicas sobre este control de personal')
                                                                    ->columnSpanFull(),

                                                                Toggle::make('activo')
                                                                    ->label('Activo')
                                                                    ->helperText('Marca si este control está activo')
                                                                    ->default(true)
                                                                    ->inline(false),
                                                            ])
                                                            ->columns(2)
                                                            ->columnSpanFull()
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),

                                                Section::make('Resumen de Personal')
                                                    ->description('Vista resumida del personal con controles especiales')
                                                    ->schema([
                                                        Placeholder::make('resumen_personal')
                                                            ->label('Personal con Control')
                                                            ->content(function(Get $get) {
                                                                $personal = $get('personal_control') ?? [];
                                                                if (empty($personal)) {
                                                                    return 'No hay personal con control especial configurado.';
                                                                }

                                                                $resumen = [];
                                                                foreach ($personal as $item) {
                                                                    if (!empty($item['nombre_completo'])) {
                                                                        $resumen[] = "• {$item['nombre_completo']} - {$item['tipo_control']}";
                                                                    }
                                                                }

                                                                return implode("\n", $resumen);
                                                            })
                                                            ->columnSpanFull(),
                                                    ]),
                                            ]),

                                        Tab::make('Disposiciones Generales')
                                            ->schema([
                                                Section::make('Disposiciones Incluídas')
                                                    ->description('Selecciona las disposiciones generales que se incluirán en esta orden')
                                                    ->schema([
                                                        Repeater::make('disposiciones_seleccionadas')
                                                            ->label('Disposiciones de la Orden')
                                                            ->addActionLabel('Agregar Disposición')
                                                            ->schema([
                                                                Select::make('id_disposicion')
                                                                    ->label('Disposición General')
                                                                    ->options(function() {
                                                                        return \App\Models\DisposicionGeneral::where('ACTIVO', true)
                                                                            ->get()
                                                                            ->mapWithKeys(function($item) {
                                                                                return [$item->ID_DISPOSICION => "#{$item->NUMERO_DISPOSICION} - {$item->TITULO}"];
                                                                            })
                                                                            ->toArray();
                                                                    })
                                                                    ->searchable()
                                                                    ->required()
                                                                    ->reactive()
                                                                    ->afterStateUpdated(function($state, $set) {
                                                                        if ($state) {
                                                                            $disposicion = \App\Models\DisposicionGeneral::find($state);
                                                                            if ($disposicion) {
                                                                                $set('es_obligatoria', $disposicion->ES_OBLIGATORIA);
                                                                                $set('categoria', $disposicion->CATEGORIA);
                                                                                $set('contenido', $disposicion->CONTENIDO);
                                                                            }
                                                                        }
                                                                    }),

                                                                Hidden::make('es_obligatoria'),
                                                                Hidden::make('categoria'),

                                                                Toggle::make('incluida')
                                                                    ->label('Incluir en la Orden')
                                                                    ->helperText('Marca si esta disposición se incluye en la orden')
                                                                    ->default(true)
                                                                    ->inline(false),

                                                                Textarea::make('contenido')
                                                                    ->label('Contenido de la Disposición')
                                                                    ->rows(3)
                                                                    ->disabled()
                                                                    ->dehydrated(false),

                                                                Textarea::make('observaciones')
                                                                    ->label('Observaciones Específicas')
                                                                    ->rows(2)
                                                                    ->placeholder('Observaciones específicas para esta disposición en esta orden')
                                                                    ->columnSpanFull(),
                                                            ])
                                                            ->columns(2)
                                                            ->columnSpanFull()
                                                            ->defaultItems(0)
                                                            ->collapsible(),
                                                    ]),
                                            ]),
                                    ]),
                            ]),

                        Step::make('Anexo Eventos')
                            ->description('Configura el anexo de eventos para esta orden')
                            ->completedIcon('heroicon-m-hand-thumb-up')
                            ->visible(fn(Get $get) => $get('includeEventos'))
                            ->schema([
                                Section::make('Anexo de Eventos')
                                    ->schema([
                                        DatePicker::make('anexo_evento_fecha')
                                            ->label('Fecha del Evento')
                                            ->required()
                                            ->default(now()),
                                        
                                        Textarea::make('anexo_evento_observaciones')
                                            ->label('Observaciones del Evento')
                                            ->rows(3)
                                            ->columnSpanFull(),
                                        
                                        Repeater::make('anexo_evento_personal')
                                            ->label('Personal Asignado al Evento')
                                            ->addable()
                                            ->deletable()
                                            ->schema([
                                                TextInput::make('orden')
                                                    ->label('Orden')
                                                    ->numeric()
                                                    ->default(1)
                                                    ->required(),
                                                
                                                TextInput::make('responsable')
                                                    ->label('Responsable')
                                                    ->required(),
                                                
                                                TextInput::make('funcion')
                                                    ->label('Función')
                                                    ->required(),
                                                
                                                TextInput::make('puesto_servicio')
                                                    ->label('Puesto de Servicio')
                                                    ->nullable(),
                                                
                                                Textarea::make('observacion')
                                                    ->label('Observación')
                                                    ->rows(2)
                                                    ->nullable(),
                                            ])
                                            ->columns(2)
                                            ->columnSpanFull(),
                                        
                                        Repeater::make('anexo_evento_recursos')
                                            ->label('Recursos del Evento')
                                            ->addable()
                                            ->deletable()
                                            ->schema([
                                                Select::make('tipo_recurso')
                                                    ->label('Tipo de Recurso')
                                                    ->options([
                                                        'PATRULLERO' => 'Patrullero',
                                                        'MOTOCICLETA' => 'Motocicleta',
                                                        'PASOLA' => 'Pasola',
                                                        'GRUA' => 'Grúa',
                                                        'TANGO' => 'Tango',
                                                        'CONO' => 'Cono',
                                                    ])
                                                    ->required(),
                                                
                                                TextInput::make('cantidad')
                                                    ->label('Cantidad')
                                                    ->numeric()
                                                    ->default(1)
                                                    ->required(),
                                                
                                                Textarea::make('observaciones')
                                                    ->label('Observaciones')
                                                    ->rows(2),
                                            ])
                                            ->columns(3)
                                            ->columnSpanFull(),
                                    ]),
                            ]),

                        Step::make('Anexo Operaciones')
                            ->description('Configura el anexo de operaciones para esta orden')
                            ->completedIcon('heroicon-m-hand-thumb-up')
                            ->visible(fn(Get $get) => $get('includeOperaciones'))
                            ->schema([
                                Section::make('Anexo de Operaciones')
                                    ->schema([
                                        DatePicker::make('anexo_operacion_fecha')
                                            ->label('Fecha de la Operación')
                                            ->required()
                                            ->default(now()),
                                        
                                        Textarea::make('anexo_operacion_observaciones')
                                            ->label('Observaciones de la Operación')
                                            ->rows(3)
                                            ->columnSpanFull(),
                                        
                                        Repeater::make('anexo_operacion_personal')
                                            ->label('Personal Asignado a la Operación')
                                            ->addable()
                                            ->deletable()
                                            ->schema([
                                                TextInput::make('orden')
                                                    ->label('Orden')
                                                    ->numeric()
                                                    ->default(1)
                                                    ->required(),
                                                
                                                TextInput::make('responsable')
                                                    ->label('Responsable')
                                                    ->required(),
                                                
                                                TextInput::make('funcion')
                                                    ->label('Función')
                                                    ->required(),
                                                
                                                TextInput::make('puesto_servicio')
                                                    ->label('Puesto de Servicio')
                                                    ->nullable(),
                                                
                                                Textarea::make('observacion')
                                                    ->label('Observación')
                                                    ->rows(2)
                                                    ->nullable(),
                                            ])
                                            ->columns(2)
                                            ->columnSpanFull(),
                                        
                                        Repeater::make('anexo_operacion_recursos')
                                            ->label('Recursos de la Operación')
                                            ->addable()
                                            ->deletable()
                                            ->schema([
                                                Select::make('tipo_recurso')
                                                    ->label('Tipo de Recurso')
                                                    ->options([
                                                        'PATRULLERO' => 'Patrullero',
                                                        'MOTOCICLETA' => 'Motocicleta',
                                                        'PASOLA' => 'Pasola',
                                                        'GRUA' => 'Grúa',
                                                        'TANGO' => 'Tango',
                                                        'CONO' => 'Cono',
                                                    ])
                                                    ->required(),
                                                
                                                TextInput::make('cantidad')
                                                    ->label('Cantidad')
                                                    ->numeric()
                                                    ->default(1)
                                                    ->required(),
                                                
                                                Textarea::make('observaciones')
                                                    ->label('Observaciones')
                                                    ->rows(2),
                                            ])
                                            ->columns(3)
                                            ->columnSpanFull(),
                                    ]),
                            ]),

                    ])
                    ->previousAction(fn(FormsAction $action) => $action->label('Anterior'))
                    ->nextAction(fn(FormsAction $action) => $action->label('Siguiente'))
                    ->submitAction('Crear Orden')
                    ->columnSpan('full'),

            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->recordUrl(null)
            /* ─────────── Columnas ─────────── */
            ->columns([
                TextColumn::make('NRO_ORDEN')
                    ->label('Nro'),

                TextColumn::make('FECHA')
                    ->date()
                    ->label('Fecha'),

                TextColumn::make('DISTRITO')
                    ->label('Distrito'),

                TextColumn::make('PROVINCIA')
                    ->label('Provincia'),

                BadgeColumn::make('estado_orden.ESTADO_ORDEN')
                    ->label('Estado')
                    ->colors([
                        'warning'  => fn($state) => $state === 'Creada',
                        'primary'  => fn($state) => $state === 'En Curso',
                        'success'  => fn($state) => $state === 'Finalizada',
                        'danger'   => fn($state) => $state === 'Anulada',
                    ])
            ])

            /* ─────────── Acciones por fila ─────────── */
            ->actions([
                /* Botón CONTINUAR (solo para borradores) */
                TableAction::make('continuar')
                    ->label('Continuar')
                    ->icon('heroicon-m-arrow-path-rounded-square')
                    ->color('primary')
                    ->button()
                    ->visible(fn($record) => $record->ID_ESTADO_ORDEN === 1)
                    ->url(
                        fn($record) =>
                        OrdenServicioResource::getUrl('edit', ['record' => $record])
                    )
                    ->tooltip('Reanudar la edición de este borrador'),

                /* Botón EDITAR (no se muestra en borradores) */
                EditAction::make()
                    ->color('secondary')
                    ->visible(fn($record) => $record->ID_ESTADO_ORDEN !== 1 && Gate::allows('crear-orden-servicio')),

                /* Botón APROBAR (solo Jefe de Distrito y pendientes) */
                TableAction::make('aprobar')
                    ->label('Aprobar')
                    ->icon('heroicon-m-check-circle')
                    ->color('success')
                    ->requiresConfirmation()
                    ->visible(fn($record) => in_array($record->ID_ESTADO_ORDEN, [1], true) && Gate::allows('aprobar-orden-servicio'))
                    ->action(function ($record) {
                        $record->update([
                            'ID_ESTADO_ORDEN' => 2,
                            'FECHA_ACTUAL'    => now(),
                        ]);
                    }),
            ])


            /* ─────────── Acciones masivas ─────────── */
            ->bulkActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }


    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index'  => Pages\ListOrdenServicios::route('/'),
            'create' => Pages\CreateOrdenServicio::route('/create'),
            'edit'   => Pages\EditOrdenServicio::route('/{record}/edit'),
        ];
    }
}
