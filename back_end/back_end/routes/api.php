<?php

use App\Http\Controllers\AuthentificationController;
use App\Http\Controllers\PinController;
use App\Http\Controllers\ForgetPasswordController;
use App\Http\Controllers\FileUploadController;
use App\Http\Controllers\ResetPasswordController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;




Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();

});



Route::get('/pins',[PinController::class,'index'])->middleware('auth:sanctum');
Route::post('/pins/store',[PinController::class,'store'])->middleware('auth:sanctum');
Route::delete('/pins/destroy/{id}',[PinController::class,'destroy'])->middleware('auth:sanctum');
Route::post('register',[AuthentificationController::class,'register']);
Route::post('login',[AuthentificationController::class,'login']);
Route::post('/forget-password', [ForgetPasswordController::class, 'forgotPassword'])->middleware(['auth:sanctum']);
Route::post('/reset-password', [ResetPasswordController::class, 'reset'])->middleware(['auth:sanctum']);
Route::get('/reset-password/{token}', [ResetPasswordController::class, 'showResetForm'])->name('password.reset')->middleware(['throttle:6,1']);



Route::post('/sanctum/token', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'device_name' => 'required',
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }

    return $user->createToken($request->device_name)->plainTextToken;
});







Route::middleware('auth:sanctum')->get('/user/revoke', function (Request $request) { //bech nfaskhou l user
    $user=$request->user();
    $user->tokens()->delete();
    return 'tokens are deleted';
});



Route::get('getfiles',[FileUploadController::class,'index'])->middleware('auth:sanctum');
Route::post('file-upload', [FileUploadController::class,'upload'])->middleware(['auth:sanctum']);
Route::delete('file-upload/destroy/{id}', [FileUploadController::class,'destroy_file'])->middleware(['auth:sanctum']);
