<?php

namespace App\Http\Requests\Timesheet;

use App\Models\Project;
use Illuminate\Foundation\Http\FormRequest;

class UpdateTimesheetRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'task_name' => 'sometimes|required|string|max:255',
            'date' => 'sometimes|required|date',
            'hours' => 'sometimes|required|numeric|min:0.1|max:24',
            'user_id' => 'sometimes|required|exists:users,id',
            'project_id' => 'sometimes|required|exists:projects,id',
        ];
    }
}
