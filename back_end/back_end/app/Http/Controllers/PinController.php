<?php

namespace App\Http\Controllers;
use App\Models\Pin;
use App\Http\Requests\PinRequest;
use Illuminate\Http\Request;

class PinController extends Controller
{

    public function index()
    {
        $pins = Pin::with('user')->latest()->get();
        return response(['pins'=>$pins]);
    }
    /*public function index(Request $request)
{
    $user = $request->user();
    $pins = $user->pins;
    return response()->json(['pins' => $pins]);
}*/

    public function store(PinRequest $request)
    {
        $validated = $request->validated();
        auth()->user()->pins()->create([
            'content' => $validated['content']
        ]);
        return response([
            'message' => 'success',
        ], 201);
    }

    public function destroy($id)
{
    $pin = Pin::findOrFail($id);
    $this->authorize('delete', $pin);

    $pin->delete();

    return response()->json(['message' => 'Pin deleted'], 200);
}
}
