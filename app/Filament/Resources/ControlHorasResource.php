<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ControlHorasResource\Pages;
use App\Filament\Resources\ControlHorasResource\RelationManagers;
use App\Models\ControlHoras;
use App\Models\Persona;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ControlHorasResource extends Resource
{
    protected static ?string $model = ControlHoras::class;

    protected static ?string $navigationIcon = 'heroicon-o-clock';
    
    protected static ?string $navigationLabel = 'Control de Horas';
    
    protected static ?string $modelLabel = 'Control de Horas';
    
    protected static ?string $pluralModelLabel = 'Control de Horas';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('ID_PERSONA')
                    ->label('Persona')
                    ->options(Persona::all()->pluck('NOMBRES', 'ID_PERSONA'))
                    ->searchable()
                    ->required(),
                Forms\Components\DatePicker::make('FECHA')
                    ->required(),
                Forms\Components\TextInput::make('HORAS_TRABAJADAS')
                    ->required()
                    ->numeric()
                    ->default(0.00),
                Forms\Components\Select::make('ESTADO')
                    ->options([
                        'DISPONIBLE' => 'Disponible',
                        'EN_SERVICIO' => 'En Servicio',
                        'HORAS_COMPLETADAS' => 'Horas Completadas',
                    ])
                    ->default('DISPONIBLE')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('persona.NOMBRES')
                    ->label('Persona')
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('FECHA')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('HORAS_TRABAJADAS')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('ESTADO')
                    ->searchable(),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListControlHoras::route('/'),
            'create' => Pages\CreateControlHoras::route('/create'),
            'edit' => Pages\EditControlHoras::route('/{record}/edit'),
        ];
    }
}
