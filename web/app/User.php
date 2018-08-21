<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'user_id', 'avatar', 'email_token', 'kills', 'deaths', 'xPos', 'yPos', 'zPos', 'aPos', 'interior', 'skin', 'gender', 'exp', 'level', 
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    protected $casts = [
        'admin' => 'boolean',
        'developer' => 'boolean',
    ];

    public function isAdmin()
    {
        return $this->admin;
    }
    public function isDev()
    {
        return $this->developer;
    }
}
