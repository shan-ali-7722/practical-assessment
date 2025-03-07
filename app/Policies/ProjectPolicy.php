<?php

namespace App\Policies;

use App\Models\Project;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class ProjectPolicy
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
        return true; // All authenticated users can view the list of projects
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Project  $project
     * @return bool
     */
    public function view(User $user, Project $project)
    {
        // Users can view projects they're assigned to or projects they created
        return $project->users->contains($user) || $user->id === $project->creator_id;
    }

    /**
     * Determine whether the user can create models.
     *
     * @param  \App\Models\User  $user
     * @return bool
     */
    public function create(User $user)
    {
        return true; // All authenticated users can create projects
    }

    /**
     * Determine whether the user can update the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Project  $project
     * @return bool
     */
    public function update(User $user, Project $project)
    {
        // Only the creator can update the project
        return $user->id === $project->creator_id;
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Project  $project
     * @return bool
     */
    public function delete(User $user, Project $project)
    {
        // Only the creator can delete the project
        return $user->id === $project->creator_id;
    }

    /**
     * Determine whether the user can assign users to the project.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Project  $project
     * @return bool
     */
    public function assignUsers(User $user, Project $project)
    {
        // Only the creator can assign users to the project
        return $user->id === $project->creator_id;
    }
} 