<?php

namespace App\Policies;

use App\Models\Pin;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class PinPolicy
{

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user)
    {
        //
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Pin $pin)
    {
        return $user->id === $pin->user_id;
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user)
    {
        //
    }

    /**
     * Determine whether the user can update the mode.
     */
    public function update(User $user, Pin $pin)
    {
        //
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Pin $pin)
    {
        return $user->id === $pin->user_id;
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, Pin $pin)
    {
        //
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, Pin $pin)
    {
        //
    }
}
