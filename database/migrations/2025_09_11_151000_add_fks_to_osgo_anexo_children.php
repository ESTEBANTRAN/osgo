<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // osgo_anexo_detalle → FK(ID_ANEXO) a osgo_anexo(ID_ANEXO)
        $det = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='osgo_anexo_detalle' AND CONSTRAINT_NAME='fk_anexo_detalle_anexo'");
        if (!$det || (int) $det->c === 0) {
            DB::statement("ALTER TABLE osgo_anexo_detalle ADD CONSTRAINT fk_anexo_detalle_anexo FOREIGN KEY (ID_ANEXO) REFERENCES osgo_anexo(ID_ANEXO) ON DELETE CASCADE");
        }

        // osgo_anexo_recurso → FK(ID_ANEXO) a osgo_anexo(ID_ANEXO)
        $rec = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='osgo_anexo_recurso' AND CONSTRAINT_NAME='fk_anexo_recurso_anexo'");
        if (!$rec || (int) $rec->c === 0) {
            DB::statement("ALTER TABLE osgo_anexo_recurso ADD CONSTRAINT fk_anexo_recurso_anexo FOREIGN KEY (ID_ANEXO) REFERENCES osgo_anexo(ID_ANEXO) ON DELETE CASCADE");
        }
    }

    public function down(): void
    {
        // Intentar eliminar las FKs si existen
        try { DB::statement("ALTER TABLE osgo_anexo_detalle DROP FOREIGN KEY fk_anexo_detalle_anexo"); } catch (\Throwable $e) {}
        try { DB::statement("ALTER TABLE osgo_anexo_recurso DROP FOREIGN KEY fk_anexo_recurso_anexo"); } catch (\Throwable $e) {}
    }
};


