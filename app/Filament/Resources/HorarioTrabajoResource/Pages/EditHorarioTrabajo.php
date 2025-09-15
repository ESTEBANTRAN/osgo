<?php

namespace App\Filament\Resources\HorarioTrabajoResource\Pages;

use App\Filament\Resources\HorarioTrabajoResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditHorarioTrabajo extends EditRecord
{
    protected static string $resource = HorarioTrabajoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
