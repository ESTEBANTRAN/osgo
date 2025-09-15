<?php

namespace App\Filament\Resources;

use App\Filament\Resources\HorarioTrabajoResource\Pages;
use App\Filament\Resources\HorarioTrabajoResource\RelationManagers;
use App\Models\HorarioTrabajo;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class HorarioTrabajoResource extends Resource
{
    protected static ?string $model = HorarioTrabajo::class;

    protected static ?string $navigationIcon = 'heroicon-o-calendar-days';
    
    protected static ?string $navigationLabel = 'Horarios';
    
    protected static ?string $modelLabel = 'Horario';
    
    protected static ?string $pluralModelLabel = 'Horarios';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('NOMBRE')
                    ->required()
                    ->maxLength(100),
                Forms\Components\TextInput::make('HORA_INICIO')
                    ->label('Hora Inicio')
                    ->required()
                    ->numeric()
                    ->minValue(0)
                    ->maxValue(23),
                Forms\Components\TextInput::make('HORA_FIN')
                    ->label('Hora Fin')
                    ->required()
                    ->numeric()
                    ->minValue(0)
                    ->maxValue(23),
                Forms\Components\Select::make('ACTIVO')
                    ->options([
                        'SI' => 'Sí',
                        'NO' => 'No',
                    ])
                    ->default('SI')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('NOMBRE')
                    ->searchable(),
                Tables\Columns\TextColumn::make('HORA_INICIO')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('HORA_FIN')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('ACTIVO')
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
            'index' => Pages\ListHorarioTrabajos::route('/'),
            'create' => Pages\CreateHorarioTrabajo::route('/create'),
            'edit' => Pages\EditHorarioTrabajo::route('/{record}/edit'),
        ];
    }
}
