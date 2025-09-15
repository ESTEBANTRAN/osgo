<?php

declare(strict_types=1);

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class HorariosSeeder extends Seeder
{
    public function run(): void
    {
        $path = base_path('DATOS EXISTENTES/Horarios.txt');
        if (! File::exists($path)) {
            return;
        }

        $raw = File::get($path);
        $lines = preg_split('/\r?\n/', $raw);

        $inserted = [];

        foreach ($lines as $idx => $line) {
            if ($idx === 0) { // encabezado "HORARIOS"
                continue;
            }
            $line = trim($line);
            if ($line === '') {
                continue;
            }

            // Separar por tabuladores y/o espacios consecutivos
            $parts = preg_split('/\t+/', $line);
            foreach ($parts as $part) {
                $part = trim($part, " \"\t");
                if ($part === '' || strtoupper($part) === 'FRANCO') {
                    continue;
                }
                // Formato esperado HH:MM-HH:MM o multilinea "06:00-14:00/22:00-06:00"
                $chunks = preg_split('/\s*\/\s*/', $part);
                foreach ($chunks as $chunk) {
                    if (!preg_match('/^(\d{2}):(\d{2})-(\d{2}):(\d{2})$/', $chunk, $m)) {
                        continue;
                    }
                    $startHour = (int) $m[1];
                    $endHour   = (int) $m[3];
                    $name      = $chunk;

                    if (isset($inserted[$name])) {
                        continue;
                    }
                    $inserted[$name] = true;

                    DB::table('osgo_horarios')->updateOrInsert(
                        ['NOMBRE' => $name],
                        [
                            'HORA_INICIO' => $startHour,
                            'HORA_FIN'    => $endHour,
                            'ACTIVO'      => 'SI',
                        ]
                    );
                }
            }
        }
    }
}


