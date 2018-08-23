#include <YSI\y_hooks>

new bool:ToggleChat[MAX_PLAYERS] = false;

hook OnPlayerText(playerid, text[])
{
    if(ToggleChat[playerid])return 0;
    return 1;
}

CMD:togglechat(playerid,params[]) {
	if(ToggleChat[playerid])
	{
		ToggleChat[playerid] = false;
		SendClientMessage(playerid,0x0000EE55,"<Chat> {FFFFFF}Deshabilitado.");
	}
	else
	{
		ToggleChat[playerid] = true;
		SendClientMessage(playerid,0x0000EE55,"<Chat> {FFFFFF}Deshabilitado.");
	}
	return true;
}
