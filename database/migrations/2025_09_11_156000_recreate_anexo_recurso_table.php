<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Eliminar tabla existente y recrearla con estructura correcta
        Schema::dropIfExists('osgo_anexo_recurso');
        
        Schema::create('osgo_anexo_recurso', function (Blueprint $table) {
            $table->integer('ID_ANEXO_RECURSO')->autoIncrement();
            $table->integer('ID_ANEXO');
            $table->enum('TIPO_RECURSO', ['PATRULLERO','MOTOCICLETA','PASOLA','GRUA','TANGO','CONO']);
            $table->integer('CANTIDAD')->default(1);
            $table->text('OBSERVACIONES')->nullable();
            $table->timestamps();
            
            // Índices
            $table->index(['ID_ANEXO']);
            $table->index(['TIPO_RECURSO']);
            
            // Sin FK - tabla huérfana para almacenar recursos
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('osgo_anexo_recurso');
    }
};
