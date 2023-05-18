<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;


class AuthentificationController extends Controller
{
    public function register(RegisterRequest $request)
    {
        $request->validated();
        $userData=[
            'name'=>$request->name,
            'username'=>$request->username,
            'email'=>$request->email,
            'password'=>Hash::make ($request->password),
        ];
        $user=User::create($userData);
        $token=$user->createToken('back_end')->plainTextToken;
        return response([
            'user'=>$user,
            'token'=> $token
        ],201);

    }
    public function login (LoginRequest $request){
        $request->validated();
        $user = User::whereUsername($request->username)->first();
        if(!$user || !Hash::check($request->password,$user->password)){
return response([
    'message'=>'invalid credentials'
],422);
        }
        $token=$user->createToken('back_end')->plainTextToken;
        return response([
            'user'=>$user,
            'token'=>$token
        ],201);

    }
}
