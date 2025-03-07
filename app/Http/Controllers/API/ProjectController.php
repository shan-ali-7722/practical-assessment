<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProjectResource;
use App\Http\Requests\Project\StoreProjectRequest;
use App\Http\Requests\Project\UpdateProjectRequest;
use App\Models\Attribute;
use App\Models\Project;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class ProjectController extends Controller
{
    /**
     * Validate all attribute values
     *
     * @param array $attributes
     * @return array
     * @throws ValidationException
     */
    private function validateAttributes(array $attributes): array
    {
        $validatedAttributes = [];
        $errors = [];

        foreach ($attributes as $name => $value) {
            $attribute = Attribute::where('name', $name)->first();

            if (!$attribute) {
                $errors[$name] = ["Attribute '{$name}' does not exist."];
                continue;
            }

            try {
                $this->validateAttributeValue($value, $attribute);
                $validatedAttributes[$name] = [
                    'attribute' => $attribute,
                    'value' => $value
                ];
            } catch (ValidationException $e) {
                $errors = array_merge($errors, $e->errors());
            }
        }

        if (!empty($errors)) {
            throw ValidationException::withMessages($errors);
        }

        return $validatedAttributes;
    }

    /**
     * Validate attribute value based on its type
     *
     * @param string $value
     * @param Attribute $attribute
     * @throws ValidationException
     */
    private function validateAttributeValue($value, Attribute $attribute)
    {
        $rules = [];

        switch ($attribute->type) {
            case 'date':
                $rules['value'] = 'required|date';
                break;
            case 'number':
                $rules['value'] = 'required|numeric';
                break;
            case 'text':
                $rules['value'] = 'required|string|max:255';
                break;
            case 'select':
                $rules['value'] = 'required|string';
                break;
        }

        $validator = Validator::make(['value' => $value], $rules);

        if ($validator->fails()) {
            throw ValidationException::withMessages([
                $attribute->name => ["The {$attribute->name} must be a valid {$attribute->type}."]
            ]);
        }
    }

    /**
     * Parse filter operator and value
     *
     * @param string $value
     * @return array
     */
    private function parseFilterValue($value): array
    {
        if (str_starts_with($value, 'LIKE')) {
            return ['LIKE', '%' . substr($value, 5) . '%'];
        }
        if (str_starts_with($value, '>')) {
            return ['>', substr($value, 2)];
        }
        if (str_starts_with($value, '<')) {
            return ['<', substr($value, 2)];
        }
        return ['=', $value];
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        if (!$request->user()->can('viewAny', Project::class)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to view projects'
            ], 403);
        }

        $query = Project::with(['users', 'attributeValues.attribute']);

        // Apply filters if provided
        if ($request->has('filters')) {
            $filters = $request->input('filters');
            
            foreach ($filters as $field => $value) {
                // Parse operator and value
                [$operator, $filterValue] = $this->parseFilterValue($value);
                
                // Check if this is a regular field
                if (in_array($field, ['name', 'status'])) {
                    $query->where($field, $operator, $filterValue);
                    continue;
                }
                
                // Otherwise, treat as dynamic attribute
                $attribute = Attribute::where('name', $field)->first();
                if ($attribute) {
                    $query->whereHas('attributeValues', function ($q) use ($attribute, $operator, $filterValue) {
                        $q->where('attribute_id', $attribute->id)
                            ->where('value', $operator, $filterValue);
                    });
                }
            }
        }

        $projects = $query->get();

        return response()->json([
            'success' => true,
            'data' => ProjectResource::collection($projects)
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\Project\StoreProjectRequest  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreProjectRequest $request)
    {
        if (!$request->user()->can('create', Project::class)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to create projects'
            ], 403);
        }

        // Validate attributes first if provided
        $validatedAttributes = [];
        if ($request->has('attributes')) {
            try {
                $validatedAttributes = $this->validateAttributes($request->input('attributes'));
            } catch (ValidationException $e) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $e->errors()
                ], 422);
            }
        }

        // Create project
        $project = Project::create([
            'name' => $request->name,
            'status' => $request->status,
            'creator_id' => auth()->id(),
        ]);

        // Assign users to the project if provided
        if ($request->has('user_ids')) {
            $project->users()->attach($request->user_ids);
        }

        // Set validated attributes
        foreach ($validatedAttributes as $name => $data) {
            $project->attributeValues()->create([
                'attribute_id' => $data['attribute']->id,
                'value' => $data['value'],
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Project created successfully',
            'data' => new ProjectResource($project->load(['users', 'attributeValues.attribute']))
        ], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Project  $project
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Request $request, Project $project)
    {
        if (!$request->user()->can('view', $project)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to view this project'
            ], 403);
        }

        return response()->json([
            'success' => true,
            'data' => new ProjectResource($project->load(['users', 'attributeValues.attribute']))
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\Project\UpdateProjectRequest  $request
     * @param  \App\Models\Project  $project
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UpdateProjectRequest $request, Project $project)
    {
        if (!$request->user()->can('update', $project)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to update this project'
            ], 403);
        }

        // Validate attributes first if provided
        $validatedAttributes = [];
        if ($request->has('attributes')) {
            try {
                $validatedAttributes = $this->validateAttributes($request->input('attributes'));
            } catch (ValidationException $e) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $e->errors()
                ], 422);
            }
        }

        // Update project
        if ($request->has('name')) {
            $project->name = $request->name;
        }

        if ($request->has('status')) {
            $project->status = $request->status;
        }

        $project->save();

        // Update assigned users if provided
        if ($request->has('user_ids')) {
            if (!$request->user()->can('assignUsers', $project)) {
                return response()->json([
                    'success' => false,
                    'message' => 'You are not authorized to assign users to this project'
                ], 403);
            }

            $project->users()->sync($request->user_ids);
        }

        // Update validated attributes
        foreach ($validatedAttributes as $name => $data) {
            $attributeValue = $project->attributeValues()
                ->where('attribute_id', $data['attribute']->id)
                ->first();

            if ($attributeValue) {
                // Update existing attribute value
                $attributeValue->value = $data['value'];
                $attributeValue->save();
            } else {
                // Create new attribute value
                $project->attributeValues()->create([
                    'attribute_id' => $data['attribute']->id,
                    'value' => $data['value'],
                ]);
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Project updated successfully',
            'data' => new ProjectResource($project->fresh(['users', 'attributeValues.attribute']))
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Project  $project
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Request $request, Project $project)
    {
        if (!$request->user()->can('delete', $project)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to delete this project'
            ], 403);
        }

        $project->delete();

        return response()->json([
            'success' => true,
            'message' => 'Project deleted successfully'
        ]);
    }

    /**
     * Assign users to the project.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Project  $project
     * @return \Illuminate\Http\JsonResponse
     */
    public function assignUsers(Request $request, Project $project)
    {
        if (!$request->user()->can('assignUsers', $project)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to assign users to this project'
            ], 403);
        }

        $request->validate([
            'user_ids' => 'required|array',
            'user_ids.*' => 'exists:users,id'
        ]);

        $project->users()->sync($request->user_ids);

        return response()->json([
            'success' => true,
            'message' => 'Users assigned to project successfully',
            'data' => $project->load('users')
        ]);
    }
}
