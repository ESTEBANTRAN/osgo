<?php

namespace App\Filament\Resources\OrdenServicioResource\Pages;

use App\Filament\Resources\OrdenServicioResource;
use Filament\Actions\Action;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\EditRecord;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Auth;

class EditOrdenServicio extends EditRecord
{
    protected static string $resource = OrdenServicioResource::class;

    /* ─── 1. Quitamos los botones inferiores (Save / Cancel) ─── */
    protected function getFormActions(): array
    {
        return [];              // sin botones en el pie
    }

    protected function getHeaderActions(): array
    {
        return [
            Action::make('guardarDraft')
                ->label('Guardar progreso')
                ->icon('heroicon-o-cloud-arrow-down')
                ->color('primary')
                ->keyBindings(['ctrl+s'])
                ->action('guardarDraft'),
            /* Anular orden  */
            Action::make('anular')
                ->label('Anular')
                ->icon('heroicon-m-x-circle')
                ->color('danger')
                ->requiresConfirmation()          // ← mantiene la confirmación
                ->modalHeading('Confirmar anulación')          // título
                ->modalDescription(
                    'Esta acción marcará la orden como «Anulada». '
                        . 'No se eliminará ningún dato histórico. ¿Desea continuar?'
                )                                                // mensaje
                ->modalSubmitActionLabel('Sí, anular')           // botón rojo
                ->modalCancelActionLabel('Cancelar')             // botón gris
                ->visible(fn($record) => $record->ID_ESTADO_ORDEN !== 4)
                ->action(function () {
                    $this->record->update([
                        'ID_ESTADO_ORDEN' => 4,
                        'FECHA_ACTUAL'    => now(),
                    ]);

                    Notification::make()
                        ->success()
                        ->title('Orden anulada')
                        ->body('La orden se marcó como «Anulada».')
                        ->send();

                    $this->redirect(static::getResource()::getUrl('index'));
                }),
        ];
    }

    /** Reutiliza el mismo método */
    public function guardarDraft(): void
    {
        /* 1) Obtiene el estado bruto (sin required) */
        $raw = $this->form->getRawState();

        /* 2) Datos que siempre queremos guardar */
        $extra = [
            'FECHA_ACTUAL'    => now(),
            'CREADO_POR'      => Auth::user()->name,
            'ID_ESTADO_ORDEN' => 1,          // sigue siendo borrador
        ];

        /* 3) Filtra: sólo columnas reales de la tabla */
        $data = Arr::only($raw + $extra, $this->record->getFillable());

        /* 4) Guarda sin disparar validaciones del formulario */
        $this->record->forceFill($data)->save();

        Notification::make()
            ->success()
            ->title('Progreso guardado')
            ->body('Se guardó tu avance a las ' . now()->format('H:i'))
            ->send();
    }
}
