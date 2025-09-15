<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Console\Commands\OsgoSchemaReport;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->commands([
            OsgoSchemaReport::class,
        ]);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
