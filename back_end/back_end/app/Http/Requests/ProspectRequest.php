<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProspectRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\Rule|array|string>
     */
    public function rules(): array
    {
        return [
        'title' => 'required|min:3',
        'Horaire' => 'required|date_format:H:i:s',
        'date' => 'required|date_format:Y-m-d',
        'localisation' => 'required|min:3',
        'description'=>'required|min:3',
        ];
    }
}
