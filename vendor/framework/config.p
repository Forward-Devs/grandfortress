#define MYSQL_HOST          "localhost"
#define MYSQL_USER          "root"
#define MYSQL_PASSWORD      ""
#define MYSQL_DATABASE      "pcu"
#define DEFAULT_MYSQL_HANDLE 1

// MySQL connection handle
new MySQL: g_SQL;

//dialog data
enum
{
	DIALOG_UNUSED,

	DIALOG_LOGIN,
	DIALOG_REGISTER
};

#define BCRYPT_COST 12

#undef 		MAX_PLAYERS
#define 	MAX_PLAYERS 		50 //Máximo de jugadores
#define	 SECONDS_TO_LOGIN 		120 // Cantidad de segundos para loguear
#define 	DEFAULT_POS_X 		-2113.0093 // Punto de Spawn por defecto.
#define 	DEFAULT_POS_Y 		-2407.8127 // Punto de Spawn por defecto.
#define 	DEFAULT_POS_Z 		31.3024 // Punto de Spawn por defecto.
#define 	DEFAULT_POS_A 		321.7117 // Punto de Spawn por defecto.

// Components

#define AUTH_ENABLED 1 // Login by FR0Z3NH34R7 | table "users" | use bcrypt
#define LEVELS_ENABLED 1 // Levels by FR0Z3NH34R7 | table "levels"
#define INVENTORY_ENABLED 1 // Inventory and Items by FR0Z3NH34R7 | table "inventories" & "items"
#define ACTORS_ENABLED 1 // Actors by FR0Z3NH34R7 | table "actors"