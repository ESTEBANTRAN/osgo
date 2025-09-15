<?php

namespace App\Filament\Resources;

use App\Filament\Resources\AnexoResource\Pages;
use App\Filament\Resources\AnexoResource\RelationManagers;
use App\Models\Anexo;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class AnexoResource extends Resource
{
    protected static ?string $model = Anexo::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static bool $shouldRegisterNavigation = false;
    
    protected static ?string $navigationLabel = 'Anexos';
    
    protected static ?string $modelLabel = 'Anexo';
    
    protected static ?string $pluralModelLabel = 'Anexos';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('ID_ORDEN_SERVICIO')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('TIPO_ANEXO')
                    ->required()
                    ->maxLength(20),
                Forms\Components\DateTimePicker::make('FECHA_ANEXO')
                    ->required(),
                Forms\Components\Textarea::make('OBSERVACIONES')
                    ->columnSpanFull(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('ID_ORDEN_SERVICIO')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('TIPO_ANEXO')
                    ->searchable(),
                Tables\Columns\TextColumn::make('FECHA_ANEXO')
                    ->dateTime()
                    ->sortable(),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
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
            'index' => Pages\ListAnexos::route('/'),
            // Solo listado, no creación directa
        ];
    }
}
