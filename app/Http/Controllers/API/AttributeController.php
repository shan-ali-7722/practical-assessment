<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Attribute\StoreAttributeRequest;
use App\Http\Requests\Attribute\UpdateAttributeRequest;
use App\Models\Attribute;
use Illuminate\Http\Request;

class AttributeController extends Controller
{
    /**
     * Display a listing of the attributes.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        if (!$request->user()->can('viewAny', Attribute::class)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to view attributes'
            ], 403);
        }

        $attributes = Attribute::all();

        return response()->json([
            'success' => true,
            'data' => $attributes
        ]);
    }

    /**
     * Store a newly created attribute.
     *
     * @param  \App\Http\Requests\Attribute\StoreAttributeRequest  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreAttributeRequest $request)
    {
        if (!$request->user()->can('create', Attribute::class)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to create attributes'
            ], 403);
        }

        $attribute = Attribute::create([
            'name' => $request->name,
            'type' => $request->type,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Attribute created successfully',
            'data' => $attribute
        ], 201);
    }

    /**
     * Display the specified attribute.
     *
     * @param  \App\Models\Attribute  $attribute
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Request $request, Attribute $attribute)
    {
        if (!$request->user()->can('view', $attribute)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to view this attribute'
            ], 403);
        }

        return response()->json([
            'success' => true,
            'data' => $attribute
        ]);
    }

    /**
     * Update the specified attribute.
     *
     * @param  \App\Http\Requests\Attribute\UpdateAttributeRequest  $request
     * @param  \App\Models\Attribute  $attribute
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UpdateAttributeRequest $request, Attribute $attribute)
    {
        if (!$request->user()->can('update', $attribute)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to update this attribute'
            ], 403);
        }

        $attribute->update([
            'name' => $request->name,
            'type' => $request->type,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Attribute updated successfully',
            'data' => $attribute
        ]);
    }

    /**
     * Remove the specified attribute.
     *
     * @param  \App\Models\Attribute  $attribute
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Request $request, Attribute $attribute)
    {
        if (!$request->user()->can('delete', $attribute)) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to delete this attribute'
            ], 403);
        }

        // Check if the attribute is in use
        if ($attribute->attributeValues()->count() > 0) {
            return response()->json([
                'success' => false,
                'message' => 'Cannot delete attribute because it is in use'
            ], 422);
        }

        $attribute->delete();

        return response()->json([
            'success' => true,
            'message' => 'Attribute deleted successfully'
        ]);
    }
}
