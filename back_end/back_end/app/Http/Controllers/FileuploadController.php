<?php

namespace App\Http\Controllers;
use App\Models\File;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class FileUploadController extends Controller
{
  function upload(Request $request)
{
    $this->validate($request, [
        'title' => 'required|string|max:255',
        'file' => 'required|file|mimes:doc,pdf,docx,zip,png',
    ]);

    if ($request->hasFile('file')) {
        $file = $request->file('file');
        $fileName = $file->getClientOriginalName();
        $path = $file->store('public/files');
        $fileModel = File::create([
            'title' => $request->input('title'),
            'file' => $path,
            'user_id' => $request->user()->id,
            'note' => $request->input('note'),
        ]);

        return response()->json(['message' => 'File uploaded successfully']);
    } else {
        return response()->json(['message' => 'No file uploaded'], 422);
    }
}

    public function index()
    {
        $files = File::with('user')->latest()->get();
        return response(['files'=>$files]);
    }
    public function destroy_file($id)
    {
        $file = File::findOrFail($id);
        $file->delete();
        return response()->json(['message' => 'File deleted successfully']);
    }
}
