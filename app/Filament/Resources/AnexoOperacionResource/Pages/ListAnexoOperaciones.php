<?php

namespace App\Filament\Resources\AnexoOperacionResource\Pages;

use App\Filament\Resources\AnexoOperacionResource;
use Filament\Resources\Pages\ListRecords;

class ListAnexoOperaciones extends ListRecords
{
    protected static string $resource = AnexoOperacionResource::class;

    protected function getHeaderActions(): array
    {
        return [];
    }
}


