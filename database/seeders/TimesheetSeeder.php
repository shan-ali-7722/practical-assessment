<?php

namespace Database\Seeders;

use App\Models\Project;
use App\Models\Timesheet;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class TimesheetSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = User::all();
        $projects = Project::all();
        $taskNames = [
            'Development',
            'Testing',
            'Bug fixing',
            'Code review',
            'Documentation',
            'Meeting',
            'Planning',
            'Research',
            'Design',
            'Deployment',
        ];

        // Create 50 random timesheet entries
        for ($i = 0; $i < 50; $i++) {
            $user = $users->random();
            // Get one of the projects the user is assigned to
            $userProjects = $user->projects;
            
            if ($userProjects->count() > 0) {
                $project = $userProjects->random();
                
                Timesheet::create([
                    'task_name' => $taskNames[array_rand($taskNames)],
                    'date' => Carbon::now()->subDays(rand(0, 30))->format('Y-m-d'),
                    'hours' => rand(1, 8) + (rand(0, 1) ? 0.5 : 0),
                    'user_id' => $user->id,
                    'project_id' => $project->id,
                ]);
            }
        }
    }
} 