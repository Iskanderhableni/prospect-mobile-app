<?php

namespace App\Models;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class File extends Model
{
    use HasFactory;
    protected $fillable = ['title','file','user_id','note'];


    public function user():BelongsTo{
           return $this->belongsTo(User::class);
    }



    // bech nfasskhou el file mel disk
    protected static function boot()
    {
        parent::boot();

        static::deleting(function ($file) {
            if (Storage::exists($file->file)) {
                Storage::delete($file->file);
            }
        });
    }
}
