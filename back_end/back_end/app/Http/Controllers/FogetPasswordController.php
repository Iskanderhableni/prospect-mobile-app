<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Password;
use App\Models\User;
use Carbon\Carbon;
use GuzzleHttp\Psr7\Message;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use App\Mail\ResetPasswordEmail;
use Illuminate\Support\Facades\Validator;

class ForgetPasswordController extends Controller
{
  /*  public function forgotPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'message' => 'We could not find a user with that email address.',
            ], 404);
        }

        $token = $user->createToken('reset-password')->plainTextToken;

        // Send password reset email with the token
        Mail::to($user)->send(new ResetPasswordEmail($token));

        return response()->json([
            'message' => 'Password reset email has been sent to your email address.',
        ]);
    }

    public function resetPassword(Request $request)
    {
        $request->validate([
            'password' => 'required|min:8|confirmed',
        ]);

        $request->user()->update([
            'password' => Hash::make($request->password),
        ]);

        $request->user()->tokens()->delete();

        return response()->json([
            'message' => 'Your password has been reset successfully.',
        ]);0
    }*/
    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $status = Password::sendResetLink(
            $request->only('email')
        );

        return $status === Password::RESET_LINK_SENT
            ? response()->json(['message' => 'Password reset link sent on your email id.'], 200)
            : response()->json(['message' => 'Unable to send reset link'], 500);
    }
}
