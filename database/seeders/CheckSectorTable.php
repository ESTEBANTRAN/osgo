<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CheckSectorTable extends Seeder
{
    public function run()
    {
        if (Schema::connection('osgo')->hasTable('osgo_sectores')) {
            $columns = Schema::connection('osgo')->getColumnListing('osgo_sectores');
            echo "Columns in osgo_sectores table: " . implode(', ', $columns) . "\n";
            
            $sampleData = DB::connection('osgo')->table('osgo_sectores')->first();
            echo "Sample data: " . json_encode($sampleData) . "\n";
        } else {
            echo "Table osgo_sectores does not exist.\n";
        }
    }
}
