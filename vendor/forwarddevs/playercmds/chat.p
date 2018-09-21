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

CMD:me(playerid,params[]) {
	new action[124];
	if(sscanf(params,"s",action)) return  Sintaxis(playerid, "/me <Accion>", 3);
	new string[128];
	format(string,sizeof(string), "* %s %s",User::playerid(name), action);
	ProxDetector(playerid, 30.0, 0xD000F4FF, string);
	return true;
}

CMD:do(playerid,params[]) {
	new action[124];
	if(sscanf(params,"s",action)) return  Sintaxis(playerid, "/do <Accion>", 3);
	new string[128];
	format(string,sizeof(string), "* %s * ((%s))", action,User::playerid(name));
	ProxDetector(playerid, 30.0, 0xD000F4FF, string);
	return true;
}

CMD:b(playerid,params[]) {
	new message[124];
	if(sscanf(params,"s",message)) return  Sintaxis(playerid, "/b <Mensaje>", 3);
	new string[128];
	format(string,sizeof(string), "(( %s : %s ))", User::playerid(name), message);
	ProxDetector(playerid, 30.0, 0xAEB6BF71, string);
	return true;
}