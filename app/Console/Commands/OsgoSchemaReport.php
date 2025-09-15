<?php

declare(strict_types=1);

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class OsgoSchemaReport extends Command
{
    protected $signature = 'osgo:schema-report {--schema=osgo : Nombre del esquema/base de datos}';
    protected $description = 'Audita FKs y relaciones maestro-detalle en el esquema indicado.';

    public function handle(): int
    {
        $schema = (string) $this->option('schema');

        $this->info("Esquema: {$schema}");

        $tables = collect(DB::select(<<<SQL
            SELECT t.TABLE_NAME, t.TABLE_TYPE
            FROM information_schema.TABLES t
            WHERE t.TABLE_SCHEMA = ?
            ORDER BY t.TABLE_NAME
        SQL, [$schema]))->map(fn($r) => (array) $r);

        $fks = collect(DB::select(<<<SQL
            SELECT k.TABLE_NAME,
                   k.CONSTRAINT_NAME,
                   k.COLUMN_NAME,
                   k.REFERENCED_TABLE_NAME,
                   k.REFERENCED_COLUMN_NAME
            FROM information_schema.KEY_COLUMN_USAGE k
            WHERE k.TABLE_SCHEMA = ?
              AND k.REFERENCED_TABLE_NAME IS NOT NULL
            ORDER BY k.TABLE_NAME, k.CONSTRAINT_NAME
        SQL, [$schema]))->map(fn($r) => (array) $r);

        $pkCols = collect(DB::select(<<<SQL
            SELECT k.TABLE_NAME, k.COLUMN_NAME
            FROM information_schema.KEY_COLUMN_USAGE k
            JOIN information_schema.TABLE_CONSTRAINTS c
              ON c.TABLE_SCHEMA = k.TABLE_SCHEMA
             AND c.TABLE_NAME = k.TABLE_NAME
             AND c.CONSTRAINT_NAME = k.CONSTRAINT_NAME
             AND c.CONSTRAINT_TYPE = 'PRIMARY KEY'
            WHERE k.TABLE_SCHEMA = ?
            ORDER BY k.TABLE_NAME
        SQL, [$schema]))->map(fn($r) => (array) $r)
          ->groupBy('TABLE_NAME')->map(fn($g) => $g->pluck('COLUMN_NAME')->all());

        $fkByTable = $fks->groupBy('TABLE_NAME');

        $this->line("\n== Resumen FKs por tabla ==");
        foreach ($tables as $t) {
            $name = $t['TABLE_NAME'];
            $pks  = $pkCols[$name] ?? [];
            $rels = $fkByTable[$name] ?? collect();
            $this->line(sprintf("- %s | PK: [%s] | FKs: %d",
                $name,
                implode(',', $pks),
                $rels instanceof \Illuminate\Support\Collection ? $rels->count() : 0
            ));
        }

        // Heurística maestro-detalle: tablas que contienen palabras clave deberían tener al menos 1 FK
        $detailKeywords = ['detalle', 'detalles', 'recurso', 'recursos', 'historial', 'pivot'];
        $this->line("\n== Posibles violaciones maestro-detalle ==");
        $violations = [];
        foreach ($tables as $t) {
            $name = strtolower($t['TABLE_NAME']);
            $isDetailName = false;
            foreach ($detailKeywords as $kw) {
                if (str_contains($name, $kw)) { $isDetailName = true; break; }
            }
            if ($isDetailName) {
                $hasFk = ($fkByTable[$t['TABLE_NAME']] ?? collect())->count() > 0;
                if (! $hasFk) {
                    $violations[] = $t['TABLE_NAME'];
                }
            }
        }

        if (empty($violations)) {
            $this->info('OK: No se detectaron tablas detalle sin FK.');
        } else {
            foreach ($violations as $tbl) {
                $this->error("- {$tbl} no posee FK aparente (revisar).");
            }
        }

        $this->line("\n== Listado completo de FKs ==");
        foreach ($fks as $fk) {
            $this->line(sprintf(
                '%s.%s -> %s.%s (%s)',$fk['TABLE_NAME'],$fk['COLUMN_NAME'],$fk['REFERENCED_TABLE_NAME'],$fk['REFERENCED_COLUMN_NAME'],$fk['CONSTRAINT_NAME']
            ));
        }

        return self::SUCCESS;
    }
}


