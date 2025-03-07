<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProjectResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'status' => $this->status,
            'creator_id' => $this->creator_id,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'users' => UserResource::collection($this->whenLoaded('users')),
            'timesheets' => TimesheetResource::collection($this->whenLoaded('timesheets')),
            'attributes' => $this->when($this->attributeValues->isNotEmpty(), 
                $this->attributeValues->mapWithKeys(function ($attributeValue) {
                    return [$attributeValue->attribute->name => $attributeValue->value];
                })
            ),
        ];
    }
} 