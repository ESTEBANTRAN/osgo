<?php

namespace App\Filament\Resources\AnexoResource\Pages;

use App\Filament\Resources\AnexoResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditAnexo extends EditRecord
{
    protected static string $resource = AnexoResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
