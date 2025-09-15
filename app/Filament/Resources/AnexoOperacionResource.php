<?php

namespace App\Filament\Resources;

use App\Models\Anexo;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class AnexoOperacionResource extends Resource
{
    protected static ?string $model = Anexo::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Anexo Operaciones';
    protected static ?string $modelLabel = 'Anexo Operación';
    protected static ?string $pluralModelLabel = 'Anexo Operaciones';
    protected static ?string $navigationGroup = 'Listado de Anexos';
    protected static ?int $navigationSort = 11;

    public static function table(Table $table): Table
    {
        return $table
            ->query(Anexo::query()->where('TIPO_ANEXO', 'OPERACION'))
            ->columns([
                Tables\Columns\TextColumn::make('ID_ORDEN_SERVICIO')->label('Orden'),
                Tables\Columns\TextColumn::make('NOMBRE')->label('Anexo Operación'),
                Tables\Columns\TextColumn::make('FECHA')->date()->label('Fecha'),
                Tables\Columns\TextColumn::make('LUGAR')->label('Lugar'),
                Tables\Columns\TextColumn::make('ESTADO')->badge(),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => AnexoOperacionResource\Pages\ListAnexoOperaciones::route('/'),
        ];
    }
}


