#include <YSI\y_hooks>

#define SZ::%0(%1) forward SZ_%0(%1);public SZ_%0(%1)
//Colores
#define SZ_PLAYCOLOR 0xEF000055 //Color de la Zona de Juego
#define SZ_SAFECOLOR 0x0000EF55 //Color de la Zona Segura
// Coordenadas Zona Segura
#define SZ_MINX -2268.1316
#define SZ_MINY -2592.7222
#define SZ_MAXX -1916.3226
#define SZ_MAXY -2204.0454
// Coordenadas Zona de Juego (Limites)
#define PZ_MAXX 82.7065
#define PZ_MAXY -353.7682
#define PZ_MINX -2930.1165
#define PZ_MINY -2979.5657

new SafeZone, PlayZone, SafeArea;

hook OnGameModeInit()
{
	PlayZone = GangZoneCreate(PZ_MINX, PZ_MINY, PZ_MAXX, PZ_MAXY);
	SafeZone = GangZoneCreate(SZ_MINX, SZ_MINY, SZ_MAXX, SZ_MAXY);
	SafeArea = CreateDynamicRectangle(SZ_MINX, SZ_MINY, SZ_MAXX, SZ_MAXY);
	print("Component: SafeZone loaded.");
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	SetPlayerWorldBounds(playerid, PZ_MAXX, PZ_MINX, PZ_MAXY, PZ_MINY);
	GangZoneShowForPlayer(playerid, PlayZone, SZ_PLAYCOLOR);
	GangZoneShowForPlayer(playerid, SafeZone, SZ_SAFECOLOR);
	return 1;
}

hook OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(areaid == SafeArea)
	{
		new nuevo[120];
	    format(nuevo, sizeof(nuevo), "~g~Entrando a la zona segura.");
	    MostrarInfoJugador(playerid, nuevo, 3);
		SendClientMessage(playerid, 0xFFFFFFEE, "Entrando a la zona segura..");
	}
	return 1;
}

hook OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(areaid == SafeArea)
	{
		new nuevo[120];
	    format(nuevo, sizeof(nuevo), "~r~Saliendo de la zona segura.");
	    MostrarInfoJugador(playerid, nuevo, 3);
		SendClientMessage(playerid, 0xFFFFFFEE, "Saliendo de la zona segura..");
	}
	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
 	if(issuerid != INVALID_PLAYER_ID) /// If not self-inflicted
	{ 
	    if(!IsPlayerInDynamicArea(playerid, SafeArea) && !IsPlayerInDynamicArea(issuerid, SafeArea)) 
	    { 
	    	new Float:armour;
			GetPlayerArmour(playerid, armour);
			if(armour > 0.0) 
			{
				SetTimerEx("SZ_DamagedAP", 1500, false, "i", playerid);  
			    SetPlayerAttachedObject(playerid,1,1242,17,0.601999,-0.036000,0.011000,96.299972,79.500015,-81.599990,1.000000,1.000000,1.000000); // ARMOUR ICONS.
			}
			new Float:health;
    		GetPlayerHealth(playerid,health);
			if(health > 0.0) 
			{
				SetTimerEx("SZ_DamagedHP", 1500, false, "i", playerid); 
			    SetPlayerAttachedObject(playerid,2,1240,17,0.587000,-0.027000,0.028000,86.100051,79.499977,-69.599990,1.000000,1.000000,1.000000); // HEALTH ICONS.
			}
	        return 1;
	    } 
    	else 
		{ 
		    
		} 
	}
    return 1;
}

SZ::DamagedHP(playerid)
{
    RemovePlayerAttachedObject(playerid, 2); 
}

SZ::DamagedAP(playerid)
{
    RemovePlayerAttachedObject(playerid, 1); 
}