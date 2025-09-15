<?php

namespace App\Filament\Resources\HorarioTrabajoResource\Pages;

use App\Filament\Resources\HorarioTrabajoResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListHorarioTrabajos extends ListRecords
{
    protected static string $resource = HorarioTrabajoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
