<?php

use App\Http\Controllers\API\AttributeController;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\ProjectController;
use App\Http\Controllers\API\TimesheetController;
use App\Http\Controllers\API\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Protected routes
Route::middleware('auth:api')->group(function () {
    // Auth routes
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);
    
    // User routes
    Route::apiResource('users', UserController::class);
    
    // Project routes
    Route::apiResource('projects', ProjectController::class);
    
    // Timesheet routes
    Route::apiResource('timesheets', TimesheetController::class);

    // New route for assigning users to projects
    Route::post('/projects/{project}/assign-users', [ProjectController::class, 'assignUsers']);
    
    // Attribute routes
    Route::apiResource('attributes', AttributeController::class);
});

Route::get('/test', function () {
    return response()->json(['message' => 'API is working!']);
});