<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\TimesheetResource;
use App\Http\Requests\Timesheet\StoreTimesheetRequest;
use App\Http\Requests\Timesheet\UpdateTimesheetRequest;
use App\Models\Timesheet;
use App\Models\Project;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TimesheetController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        if (!$request->user()->can('viewAny', Timesheet::class)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to view timesheets'
            ], 403);
        }
        $query = Timesheet::with(['user', 'project']);
        
        // Filter by user_id if provided
        if ($request->has('user_id')) {
            $query->where('user_id', $request->user_id);
        }
        
        // Filter by project_id if provided
        if ($request->has('project_id')) {
            $query->where('project_id', $request->project_id);
        }
        
        // Filter by date range if provided
        if ($request->has('start_date')) {
            $query->where('date', '>=', $request->start_date);
        }
        
        if ($request->has('end_date')) {
            $query->where('date', '<=', $request->end_date);
        }
        
        $timesheets = $query->get();
        
        return response()->json([
            'success' => true,
            'data' => TimesheetResource::collection($timesheets)
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\Timesheet\StoreTimesheetRequest  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreTimesheetRequest $request)
    {
        if (!$request->user()->can('create', [Timesheet::class, $request->project_id])) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to create timesheets for this project'
            ], 403);
        }
        
        $timesheet = Timesheet::create([
            'task_name' => $request->task_name,
            'date' => $request->date,
            'hours' => $request->hours,
            'user_id' => $request->user_id,
            'project_id' => $request->project_id,
        ]);
        
        return response()->json([
            'success' => true,
            'message' => 'Timesheet created successfully',
            'data' => new TimesheetResource($timesheet->load(['user', 'project']))
        ], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Timesheet  $timesheet
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Request $request, Timesheet $timesheet)
    {
        if (!$request->user()->can('view', $timesheet)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to view this timesheet'
            ], 403);
        }
        
        return response()->json([
            'success' => true,
            'data' => new TimesheetResource($timesheet->load(['user', 'project']))
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\Timesheet\UpdateTimesheetRequest  $request
     * @param  \App\Models\Timesheet  $timesheet
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UpdateTimesheetRequest $request, Timesheet $timesheet)
    {
        if (!$request->user()->can('update', $timesheet)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to update this timesheet'
            ], 403);
        }
        
        $timesheet->update($request->validated());
        
        return response()->json([
            'success' => true,
            'message' => 'Timesheet updated successfully',
            'data' => new TimesheetResource($timesheet->fresh(['user', 'project']))
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Timesheet  $timesheet
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Request $request, Timesheet $timesheet)
    {
        if (!$request->user()->can('delete', $timesheet)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to delete this timesheet'
            ], 403);
        }
        
        $timesheet->delete();
        
        return response()->json([
            'success' => true,
            'message' => 'Timesheet deleted successfully'
        ]);
    }
} 