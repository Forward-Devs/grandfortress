<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;


class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('email')->unique();
            $table->string('password');
            $table->integer('kills')->default(0);
            $table->integer('deaths')->default(0);
            $table->float('xPos')->default('-2113.0093');
            $table->float('yPos')->default('-2407.8127');
            $table->float('zPos')->default('31.3024');
            $table->float('aPos')->default('321.7117');
            $table->integer('interior')->default(0);
            $table->integer('gender')->default(0);
            $table->integer('skin')->default(20010);
            $table->integer('exp')->default(0);
            $table->integer('level')->default(1);
            $table->tinyInteger('verified')->default(0);
            $table->string('email_token')->nullable();
            $table->string('avatar')->default('images/avatard.png');
            $table->boolean('admin')->default(0);
            $table->boolean('developer')->default(0);
            $table->integer('user_id')->references(config('jugadores.id'))->on(config('jugadores.tabla'))->nullable();
            $table->rememberToken();
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
        Schema::dropIfExists('users');
    }
}
