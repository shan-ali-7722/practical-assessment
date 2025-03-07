<?php

namespace App\Policies;

use App\Models\Attribute;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class AttributePolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     *
     * @param  \App\Models\User  $user
     * @return bool
     */
    public function viewAny(User $user)
    {
        return true; // All authenticated users can view attributes
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Attribute  $attribute
     * @return bool
     */
    public function view(User $user, Attribute $attribute)
    {
        return true; // All authenticated users can view attributes
    }

    /**
     * Determine whether the user can create models.
     *
     * @param  \App\Models\User  $user
     * @return bool
     */
    public function create(User $user)
    {
        return true; // All authenticated users can create attributes
    }

    /**
     * Determine whether the user can update the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Attribute  $attribute
     * @return bool
     */
    public function update(User $user, Attribute $attribute)
    {
        return true; // All authenticated users can update attributes
    }

    /**
     * Determine whether the user can delete the model.
     * Only allows deletion if the attribute is not being used in any projects
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Attribute  $attribute
     * @return bool
     */
    public function delete(User $user, Attribute $attribute)
    {
        // Check if the attribute has any values (is being used)
        return $attribute->attributeValues()->count() === 0;
    }
} 