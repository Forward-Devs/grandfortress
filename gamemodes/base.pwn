/*
Grand Fortress main code does not change!
Developer: FR0Z3NH34R7 (Oscar Fernandez)
*/
// Core
#include <a_samp>
#include <a_mysql> // R41-4 Download: https://github.com/pBlueG/SA-MP-MySQL/releases/tag/R41-4
#include <foreach>
#include <easyDialog>
#include <bcrypt> // 2.2.3 Download: https://github.com/lassir/bcrypt-samp/releases/tag/v2.2.3
#include <sscanf2>
#include <streamer>
#include <a_actor>
#include <zcmd>
#include <crashdetect>
#include <DialogCenter>

#define GM_VERSION "1.0.4"

// Temporal fix to "bypass" recursion of y_amx by FedesUy
#if __Pawn == 778 && __Pawn != 0x030A
	#pragma disablerecursion
#endif

main()
{

}
/* Carga la configuración */
#include "../vendor/framework/config.p"
/* Load All Models */
#include "../vendor/framework/models.p"

/* MYSQL */
#include "../vendor/framework/schema.p"
/* Load Helpers */
#include "../vendor/framework/helpers.p"
/* Auto Load Un archivo para cargar componentes */
#include "../autoload.p" 






public OnGameModeInit()
{
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	SetNameTagDrawDistance(10.0);
	ShowPlayerMarkers(0);
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
	SetPlayerColor(playerid, -1);
	return 1;
}
public OnPlayerEnterDynamicArea(playerid, areaid)
{
	return 1;
}
public OnPlayerLeaveDynamicArea(playerid, areaid)
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

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{

    return 1;
}

public OnPlayerRequestDownload(playerid, type, crc)
{

	return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{

    return 1;
}

