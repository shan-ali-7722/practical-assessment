<?php

namespace App\Policies;

use App\Models\Timesheet;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class TimesheetPolicy
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
        return true; // All authenticated users can view the list of timesheets
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Timesheet  $timesheet
     * @return bool
     */
    public function view(User $user, Timesheet $timesheet)
    {
        // Users can view timesheets for projects they're assigned to or created
        return $timesheet->project->users->contains($user) || 
               $user->id === $timesheet->project->creator_id || 
               $user->id === $timesheet->user_id;
    }

    /**
     * Determine whether the user can create models.
     *
     * @param  \App\Models\User  $user
     * @param  int  $projectId
     * @return bool
     */
    public function create(User $user, $projectId)
    {
        // User can create timesheets for projects they're assigned to or created
        $project = \App\Models\Project::find($projectId);
        
        if (!$project) {
            return false;
        }
        
        return $project->users->contains($user) || $user->id === $project->creator_id;
    }

    /**
     * Determine whether the user can update the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Timesheet  $timesheet
     * @return bool
     */
    public function update(User $user, Timesheet $timesheet)
    {
        // Users can only update their own timesheets or timesheets for projects they created
        return $user->id === $timesheet->user_id || $user->id === $timesheet->project->creator_id;
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Timesheet  $timesheet
     * @return bool
     */
    public function delete(User $user, Timesheet $timesheet)
    {
        // Users can only delete their own timesheets or timesheets for projects they created
        return $user->id === $timesheet->user_id || $user->id === $timesheet->project->creator_id;
    }
} 