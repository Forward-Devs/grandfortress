/*
Motor principal de Grand Fortress, no modificar codigo de Ã©ste archivo.

Desarrollador: FR0Z3NH34R7

*/
// Core
#include <a_samp>
#include <a_mysql> // R41-4 Descarga: https://github.com/pBlueG/SA-MP-MySQL/releases/tag/R41-4
#include <foreach>
#include <easyDialog>
#include <bcrypt> // 2.2.3 Descarga: https://github.com/lassir/bcrypt-samp/releases/tag/v2.2.3
#include <progress2>
#include <sscanf2>
#include <streamer>
#include <a_actor>
#include <zcmd>

// Codigo
#include "./vendor/config.pwn"
#include "./vendor/gf/login.pwn" // Login by FR0Z3NH34R7 | table "users" | use bcrypt




main()
{

}

public OnGameModeInit()
{

		#if defined GetPlayerPoolSize
		new
			LAST_PLAYER_ID = GetPlayerPoolSize() + 1,
			LAST_VEHICLE_ID = GetVehiclePoolSize() + 1,
			LAST_ACTOR_ID = GetActorPoolSize() + 1;
		#else
			#define LAST_PLAYER_ID  MAX_PLAYERS
			#define LAST_VEHICLE_ID MAX_VEHICLES
			#define LAST_ACTOR_ID   MAX_ACTORS
		#endif

		new MySQLOpt: option_id = mysql_init_options();

		mysql_set_option(option_id, AUTO_RECONNECT, true); // it automatically reconnects when loosing connection to mysql server

		g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id); // AUTO_RECONNECT is enabled for this connection handle only
		if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
		{
				print("MySQL connection failed. Server is shutting down.");
				SendRconCommand("exit"); // close the server if there is no connection
				return 1;
		}
		else
		{
			print("Conexión exitosa con MariaDB");
		}
		
		return 1;
}

public OnGameModeExit()
{


	mysql_close(g_SQL);
	print("Cerrando Gamemode, por favor espere...");

	return 1;
}
public OnPlayerConnect(playerid)
{

	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{

	return 1;
}

public OnPlayerSpawn(playerid)
{

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

		if(dialogid == DIALOG_UNUSED) return 1;
		return 1;
}

//-----------------------------------------------------


AntiDeAMX()
{
    new a[][] = {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}
