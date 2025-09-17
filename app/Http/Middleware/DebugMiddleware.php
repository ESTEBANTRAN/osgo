<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class DebugMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        // Log request info
        Log::info('Request Debug Info:', [
            'url' => $request->url(),
            'method' => $request->method(),
            'user_agent' => $request->userAgent(),
            'memory_usage' => memory_get_usage(true) . ' bytes',
            'memory_limit' => ini_get('memory_limit'),
        ]);

        $response = $next($request);

        // Log response info
        Log::info('Response Debug Info:', [
            'status' => $response->getStatusCode(),
            'final_memory' => memory_get_usage(true) . ' bytes',
        ]);

        return $response;
    }
}