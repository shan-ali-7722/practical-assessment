<?php

namespace Database\Seeders;

use App\Models\Project;
use App\Models\User;
use Illuminate\Database\Seeder;

class ProjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Create sample projects
        $projects = [
            [
                'name' => 'Website Redesign',
                'status' => 'active',
            ],
            [
                'name' => 'Mobile App Development',
                'status' => 'active',
            ],
            [
                'name' => 'Database Migration',
                'status' => 'completed',
            ],
            [
                'name' => 'API Integration',
                'status' => 'active',
            ],
            [
                'name' => 'Legacy System Maintenance',
                'status' => 'inactive',
            ],
        ];

        foreach ($projects as $project) {
            Project::create($project);
        }

        // Assign users to projects
        $users = User::all();
        $projects = Project::all();

        // Assign each user to 1-3 random projects
        foreach ($users as $user) {
            $projectsToAssign = $projects->random(rand(1, 3));
            $user->projects()->attach($projectsToAssign->pluck('id')->toArray());
        }
    }
} 