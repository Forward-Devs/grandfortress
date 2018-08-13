<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateActorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('actors', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name')->default('Actor');
            $table->integer('type')->default(0);
            $table->integer('skin')->default(0);
            $table->float('xPos')->default('-2113.0093');
            $table->float('yPos')->default('-2407.8127');
            $table->float('zPos')->default('31.3024');
            $table->float('aPos')->default('321.7117');
            $table->integer('interior')->default(0);
            $table->float('health')->default(100);
            $table->boolean('invulnerable')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('actors');
    }
}
