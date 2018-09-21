#define MYSQL_HOST          "localhost"
#define MYSQL_USER          "root"
#define MYSQL_PASSWORD      ""
#define MYSQL_DATABASE      "forwardgames"
#define DEFAULT_MYSQL_HANDLE 1

#define Global::%0(%1) forward %0(%1);public %0(%1)
// MySQL connection handle
new MySQL: g_SQL;

//dialog data
enum
{
	DIALOG_UNUSED,

	DIALOG_LOGIN,
	DIALOG_REGISTER
};

 // Hasta aquí es del Mysql y parte del login

#undef 		MAX_PLAYERS
#define 	MAX_PLAYERS 		50 //Máximo de jugadores
#define 	DEFAULT_POS_X 		-2113.0093 // Punto de Spawn por defecto.
#define 	DEFAULT_POS_Y 		-2407.8127 // Punto de Spawn por defecto.
#define 	DEFAULT_POS_Z 		31.3024 // Punto de Spawn por defecto.
#define 	DEFAULT_POS_A 		321.7117 // Punto de Spawn por defecto.

// Components

#define AUTH_ENABLED 1 // Login by FR0Z3NH34R7 | table "users" | use bcrypt
#define LEVELS_ENABLED 1 // Levels by FR0Z3NH34R7 | table "levels"
#define INVENTORY_ENABLED 1 // Inventory and Items by FR0Z3NH34R7 | table "inventories" & "items"
#define ACTORS_ENABLED 1 // Actors by FR0Z3NH34R7 | table "actors"
#define SINTAXIS_ENABLED 1 // Sintaxis by FR0Z3NH34R7
#define ADMIN_ENABLED 1 // Admin CMDS by FR0Z3NH34R7
#define PLAYERCMDS_ENABLED 1 // Comandos para Usuario by FR0Z3NH34R7
#define SAFEZONE_ENABLED 0 // Zona Segura by FR0Z3NH34R7 

