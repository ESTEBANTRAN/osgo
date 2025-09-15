<?php

use App\Http\Controllers\CheckDbController;
use Illuminate\Support\Facades\Route;

Route::view('/', 'welcome');

Route::view('dashboard', 'dashboard')
    ->middleware(['auth', 'verified'])
    ->name('dashboard');

Route::view('profile', 'profile')
    ->middleware(['auth'])
    ->name('profile');

require __DIR__.'/auth.php';

// Debug route to check database structure
Route::get('/check-db', [CheckDbController::class, 'checkTables'])->name('check.db');
