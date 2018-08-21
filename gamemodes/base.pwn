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
#include <crashdetect>
#include <DialogCenter>

main()
{

}

#include "../vendor/framework/config.p"
/* Load All Models */
#include "../vendor/framework/models.p"
/* MYSQL */
#include "../vendor/framework/schema.p"
/* Auto Load */
#include "../autoload.p" 

new SafeZone, PlayZone, SafeArea;




public OnGameModeInit()
{
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	SetNameTagDrawDistance(10.0);
	ShowPlayerMarkers(0);

	PlayZone = GangZoneCreate(-2930.1165, -2979.5657, 82.7065, -353.7682);
	SafeZone = GangZoneCreate(-2268.1316, -2592.7222, -1916.3226, -2204.0454);
	SafeArea = CreateDynamicRectangle(-2268.1316, -2592.7222, -1916.3226, -2204.0454);
	return 1;
}

public OnGameModeExit()
{
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
public OnPlayerText(playerid, text[])
{
    return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerWorldBounds(playerid, 82.7065, -2930.1165, -353.7682, -2979.5657);
	GangZoneShowForPlayer(playerid, PlayZone, 0xEF000055);
	GangZoneShowForPlayer(playerid, SafeZone, 0x0000EF55);
	SetPlayerColor(playerid, -1);
	return 1;
}
public OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(areaid == SafeArea)
	{
		new nuevo[120];
	    format(nuevo, sizeof(nuevo), "~g~Entrando a la zona segura.");
	    MostrarInfoJugador(playerid, nuevo, 3);
		SendClientMessage(playerid, 0xFFFFFFEE, "Entrando a la zona segura..");
	}
}
public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(areaid == SafeArea)
	{
		new nuevo[120];
	    format(nuevo, sizeof(nuevo), "~r~Saliendo de la zona segura.");
	    MostrarInfoJugador(playerid, nuevo, 3);
		SendClientMessage(playerid, 0xFFFFFFEE, "Saliendo de la zona segura..");
	}
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

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{

    return 1;
}