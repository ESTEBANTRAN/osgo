<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Session\DatabaseSessionHandler;
use Illuminate\Contracts\Foundation\Application;

class SessionServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->singleton('session', function (Application $app) {
            return new \Illuminate\Session\SessionManager($app);
        });
    }

    public function boot(): void
    {
        $this->app['session']->extend('database', function ($app) {
            $connection = $app['db']->connection($app['config']['session.connection']);
            $table = $app['config']['session.table'];
            $lifetime = $app['config']['session.lifetime'];
            
            return new DatabaseSessionHandler($connection, $table, $lifetime, $app);
        });
    }
}
