<?php

namespace App\Filament\Resources\ControlHorasResource\Pages;

use App\Filament\Resources\ControlHorasResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListControlHoras extends ListRecords
{
    protected static string $resource = ControlHorasResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
