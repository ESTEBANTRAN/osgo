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
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\HtmlString;
use Illuminate\Support\Str;




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

        $funciones = \App\Models\Funcione::query()
            ->whereIn('ID_FUNCION', $ids)
            ->orderByRaw('FIELD(ID_FUNCION, ' . implode(',', $ids) . ')')
            ->pluck('FUNCION', 'ID_FUNCION')
            ->toArray();

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
                                                        TextInput::make('CREADO_POR')
                                                            ->label('Responsable Operativo')
                                                            ->default(fn() => Auth::user()->name)
                                                            ->disabled()
                                                            ->helperText('Nombre completo de quien firma la orden.')
                                                            ->validationAttribute('Responsable Operativo')
                                                            ->validationMessages([
                                                                'required' => 'El campo Responsable Operativc es obligatorio.',
                                                            ]),

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
                                                                    $set('distrito_canton', "{$record->DISTRITO} - {$record->CANTON}");
                                                                }
                                                            })
                                                            ->afterStateUpdated(function (string $state, callable $set) {
                                                                [$distrito, $canton] = explode(' - ', $state, 2);
                                                                $set('DISTRITO', $distrito);
                                                                $set('CANTON', $canton);
                                                            })
                                                            ->searchable()
                                                            ->required()
                                                            ->helperText('Ej.: “CENTRO - IBARRA”…'),

                                                        Hidden::make('DISTRITO')
                                                            ->required()
                                                            ->dehydrated()                     // sí se mapea
                                                            ->default(fn(callable $get) => explode(' - ', $get('distrito_canton') ?? '', 2)[0] ?? ''),

                                                        Hidden::make('CANTON')
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
                                                                    ->options(Persona::opcionesPorFuncion(1))
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
                                                                    ->options(Persona::opcionesPorFuncion(2))
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
                                                                    ->options(Persona::opcionesPorFuncion(3))
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
                                                                    ->options(Persona::opcionesPorFuncion(4))
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
                                                                    ->options(Persona::opcionesPorFuncion(5))
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
                                                                    ->options(Persona::opcionesPorFuncion(6))
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
                                                                    ->options(Persona::opcionesPorFuncion(7))
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
                                                                    ->options(Persona::opcionesPorFuncion(8))
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
                                                                    ->options(Persona::opcionesPorFuncion(9))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                $get('funcion_id')
                                                                ? \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                                : []
                                                            ))
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
                                                            ->options(
                                                                fn(callable $get) =>
                                                                ['S/S' => 'S/S']
                                                                    + (
                                                                        $get('funcion_id')
                                                                        ? Persona::opcionesPorFuncion($get('funcion_id'))
                                                                        : []
                                                                    )
                                                            )
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                $get('funcion_id')
                                                                ? \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                                : []
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                $get('funcion_id')
                                                                ? \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                                : []
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                $get('funcion_id')
                                                                ? \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                                : []
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                            ))
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
                                                            ->options(fn(callable $get) => [
                                                                'S/S' => 'S/S',
                                                            ] + (
                                                                \App\Models\Persona::opcionesPorFuncion($get('funcion_id'))
                                                            ))
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
                                                TextInput::make('tipo_motorizado')->label('Servicio Motorizado'),
                                                TextInput::make('tipo_pedestre')->label('Servicio Pedestre'),
                                            ]),

                                        Tab::make('Permisos y Disposiciones')
                                            ->schema([
                                                TextInput::make('permisos_franco')->label('Personal de Franco'),
                                                TextInput::make('permisos_medico')->label('Permiso Médico'),
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

                TextColumn::make('CANTON')
                    ->label('Cantón'),

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
                    ->visible(fn($record) => $record->ID_ESTADO_ORDEN !== 1),
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
