<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('attribute_values', function (Blueprint $table) {
            $table->id();
            $table->foreignId('attribute_id')->constrained()->onDelete('cascade');
            // Using morphs() since we want to support any model in future, not just Projects
            $table->morphs('entity'); // Creates entity_type and entity_id columns with index
            $table->text('value');
            $table->timestamps();

            // Ensure each entity can only have one value per attribute
            $table->unique(['attribute_id', 'entity_type', 'entity_id'], 'unique_attribute_value');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attribute_values');
    }
}; 