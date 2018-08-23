#include <YSI\y_hooks>
#include "../vendor/forwarddevs/playercmds/chat.p"

#define PCMDS::%0(%1) forward PCMDS_%0(%1);public PCMDS_%0(%1)

hook OnGameModeInit()
{
	print("Component: Player CMDS loaded.");
	return 1;
}
CMD:spawn(playerid, params[]) {
	if(User::playerid(HomeTimer))
	{
		KillTimer(User::playerid(HomeTimer));
		User::playerid(HomeTimer) = 0;
		SendClientMessage(playerid,0x0000EE55,"<PCMDS> {FFFFFF}Cancelaste el regreso al spawn.");
		return 1;
	}
	else
	{
		User::playerid(HomeTimer) = SetTimerEx("PCMDS_GoToSpawn", 30 * 1000, false, "d", playerid);
		SendClientMessage(playerid,0x0000EE55,"<PCMDS> {FFFFFF}Te estás teletransportando al Spawn, espera 30 segundos sin recibir daño.");
	}
	
	return true;
}

PCMDS::GoToSpawn(playerid)
{
	User::playerid(HomeTimer) = 0;
	User::playerid(xPos) = DEFAULT_POS_X;
	User::playerid(yPos) = DEFAULT_POS_Y;
	User::playerid(zPos) = DEFAULT_POS_Z;
	User::playerid(aPos) = DEFAULT_POS_A;
	SetSpawnInfo(playerid, NO_TEAM, 0, User::playerid(xPos), User::playerid(yPos), User::playerid(zPos), User::playerid(aPos), 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(User::playerid(HomeTimer))
	{
		KillTimer(User::playerid(HomeTimer));
		User::playerid(HomeTimer) = 0;
		SendClientMessage(playerid,0x0000EE55,"<PCMDS> {FFFFFF}Se canceló el regreso al spawn por que recibiste daño.");
	}
	return 1;
}