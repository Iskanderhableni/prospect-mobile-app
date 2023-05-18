<?php

namespace App\Http\Controllers;
use app\Models\File;
use Illuminate\Http\Request;
use app\Http\Controllers\ProspectRequest;
use LDAP\Result;

class ProspectController extends Controller
{
    public function epingler(Request $request) {
        $request->validated();
        $pindata=[
            'titre'=>$request->titre,
            'heure'=>$request->heure,
            'joure'=>$request->joure,
            'duree'=>$request->duree,
        ];


    }
}
