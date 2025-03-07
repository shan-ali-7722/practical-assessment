<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'status',
        'creator_id',
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = ['attributes'];

    /**
     * The "booted" method of the model.
     */
    protected static function booted(): void
    {
        static::deleting(function (Project $project) {
            // Delete all attribute values for this project
            $project->attributeValues()->delete();
        });
    }

    /**
     * Get the users associated with the project.
     */
    public function users()
    {
        return $this->belongsToMany(User::class);
    }

    /**
     * Get the timesheets for the project.
     */
    public function timesheets()
    {
        return $this->hasMany(Timesheet::class);
    }

    /**
     * Get the user who created this project.
     */
    public function creator()
    {
        return $this->belongsTo(User::class, 'creator_id');
    }

    /**
     * Get the attribute values for this project.
     */
    public function attributeValues()
    {
        return $this->morphMany(AttributeValue::class, 'entity');
    }

    /**
     * Get the attributes for this project.
     *
     * @return array
     */
    public function getAttributesAttribute()
    {
        $attributes = [];
        
        foreach ($this->attributeValues as $attributeValue) {
            $attribute = $attributeValue->attribute;
            $value = $attributeValue->value;
            
            // Cast the value based on attribute type
            switch ($attribute->type) {
                case 'number':
                    $value = (float) $value;
                    break;
                case 'date':
                    $value = $value; // Keep as string for date
                    break;
                case 'select':
                    $value = $value; // Keep as string for select
                    break;
                default:
                    $value = $value; // Keep as string for text
            }
            
            $attributes[$attribute->name] = $value;
        }
        
        return $attributes;
    }

    /**
     * Set an attribute value.
     *
     * @param string $name
     * @param mixed $value
     * @return void
     */
    public function setAttribute($name, $value)
    {
        // Check if this is a dynamic attribute
        $attribute = Attribute::where('name', $name)->first();
        
        if ($attribute) {
            // This is a dynamic attribute, save it to attribute_values
            $attributeValue = $this->attributeValues()
                ->where('attribute_id', $attribute->id)
                ->first();
            
            if ($attributeValue) {
                // Update existing attribute value
                $attributeValue->value = $value;
                $attributeValue->save();
            } else {
                // Create new attribute value
                $this->attributeValues()->create([
                    'attribute_id' => $attribute->id,
                    'value' => $value,
                ]);
            }
            
            return;
        }
        
        // This is a regular attribute, use parent method
        parent::setAttribute($name, $value);
    }
} 