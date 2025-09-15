<?php

namespace App\Filament\Resources\ControlHorasResource\Pages;

use App\Filament\Resources\ControlHorasResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditControlHoras extends EditRecord
{
    protected static string $resource = ControlHorasResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
