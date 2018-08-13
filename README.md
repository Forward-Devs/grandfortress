# grandfortress
Gamemode de SAMP Open Source. Modo de juego: Survival/RPG

## 1.0.1
 -Login por FR0Z3NH34R7 (Usando bcrypt)

## Migración: 

### \database\migrations\2014_10_12_000000_create_users_table.php

Luego de `$table->string('password');` insertar: 

      `$table->integer('kills')->default(0);
            $table->integer('deaths')->default(0);
            $table->float('xPos')->default('-2113.0093');
            $table->float('yPos')->default('-2407.8127');
            $table->float('zPos')->default('31.3024');
            $table->float('aPos')->default('321.7117');
            $table->integer('interior')->default(0);`
Al finalizar, ejecutar `php artisan migrate:refresh --seed`
