/*
Motor principal de Grand Fortress, no modificar codigo de éste archivo.

Desarrollador: FR0Z3NH34R7

*/
// Core
#include <a_samp>
#include <a_mysql> // R41-4 Descarga: https://github.com/pBlueG/SA-MP-MySQL/releases/tag/R41-4
#include <foreach>
#include <easyDialog>
#include <bcrypt> // 2.2.3 Descarga: https://github.com/lassir/bcrypt-samp/releases/tag/v2.2.3
#include <sscanf2>
#include <streamer>
#include <a_actor>
#include <zcmd>

#include "../vendor/framework/config.p"
/* Load All Models */
#include "../vendor/framework/models.p"
/* Auto Load */
#include "../autoload.p" 



main()
{

}

public OnGameModeInit()
{
		/*
		#if defined GetPlayerPoolSize
		new
			LAST_PLAYER_ID = GetPlayerPoolSize() + 1,
			LAST_VEHICLE_ID = GetVehiclePoolSize() + 1,
			LAST_ACTOR_ID = GetActorPoolSize() + 1;
		#else
			#define LAST_PLAYER_ID  MAX_PLAYERS
			#define LAST_VEHICLE_ID MAX_VEHICLES
			#define LAST_ACTOR_ID   MAX_ACTORS
		#endif*/

		new MySQLOpt: option_id = mysql_init_options();

		mysql_set_option(option_id, AUTO_RECONNECT, true); // Reconecta automáticamente al perder la conexión.

		g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id); // AUTO_RECONNECT esta activado solo para esta conexión.
		if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
		{
				print("MariaDB: conexión fallida, cerrando Gamemode.");
				SendRconCommand("exit"); // Cierra el servidor si no se estableció conexión con Maria DB
				return 1;
		}
		else
		{
			print("Conexion exitosa con MariaDB");
		}
		DisableInteriorEnterExits();
		EnableStuntBonusForAll(0);

		SetNameTagDrawDistance(10.0);
		ShowPlayerMarkers(0);
		#if defined _Login_Component
		print("Login Cargado");
		#endif
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

CMD:setskin(playerid,params[]) {
	new target, skinn;
	if(sscanf(params,"id",target, skinn)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage: /setskin [userid] [skin]");
	SetPlayerSkin(target, skinn);
	new string[128];
	format(string,sizeof(string), "New Skin %d To player: %d",skinn,target);
	SendClientMessage(playerid,0xFFFFFFFF,string);

	return true;
}
