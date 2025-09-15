<?php

namespace App\Filament\Resources\AnexoEventoResource\Pages;

use App\Filament\Resources\AnexoEventoResource;
use Filament\Resources\Pages\ListRecords;

class ListAnexoEventos extends ListRecords
{
    protected static string $resource = AnexoEventoResource::class;

    protected function getHeaderActions(): array
    {
        return [];
    }
}


