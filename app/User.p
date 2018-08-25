/* User Model */
#define User::%0(%1) Player[%0][P_%1] // Creamos un preprocesador, para utilizar nuestra variable así: User::playerid(name) == Player[playerid][P_name]

enum E_PLAYERS
{
	ORM: P_ORM_ID,

	P_id,
	P_name[MAX_PLAYER_NAME],
	P_password[BCRYPT_HASH_LENGTH], // bcrypt
	P_kills,
	P_deaths,
	Float: P_xPos,
	Float: P_yPos,
	Float: P_zPos,
	Float: P_aPos,
	P_interior,
	P_skin,
	P_gender,
	P_level,
	P_exp,
	bool: P_admin,
	bool: P_developer,
	bool: P_IsLoggedIn,
	P_LoginAttempts,
	P_LoginTimer,
	P_HomeTimer
};

new Player[MAX_PLAYERS][E_PLAYERS];

