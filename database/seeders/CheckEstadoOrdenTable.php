<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CheckEstadoOrdenTable extends Seeder
{
    public function run()
    {
        if (Schema::connection('osgo')->hasTable('osgo_estado_orden')) {
            $columns = Schema::connection('osgo')->getColumnListing('osgo_estado_orden');
            echo "Columns in osgo_estado_orden table: " . implode(', ', $columns) . "\n";
            
            $sampleData = DB::connection('osgo')->table('osgo_estado_orden')->first();
            echo "Sample data: " . json_encode($sampleData) . "\n";
        } else {
            echo "Table osgo_estado_orden does not exist.\n";
        }
    }
}
