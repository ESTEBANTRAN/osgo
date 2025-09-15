<?php

namespace App\Filament\Resources\AnexoResource\Pages;

use App\Filament\Resources\AnexoResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListAnexos extends ListRecords
{
    protected static string $resource = AnexoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
