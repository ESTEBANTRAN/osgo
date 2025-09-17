<?php
declare(strict_types=1);

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Gate;
use App\Models\User;
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
        // Force file drivers to avoid missing database tables for sessions/cache in local
        config([
            'session.driver' => 'file',
            'cache.default'  => 'file',
        ]);

        Gate::define('crear-orden-servicio', function (User $user): bool {
            return optional($user->rol)->NOMBRE === 'RESPONSABLE_OPERATIVO';
        });

        Gate::define('aprobar-orden-servicio', function (User $user): bool {
            return optional($user->rol)->NOMBRE === 'JEFE_DISTRITO';
        });
    }
}
