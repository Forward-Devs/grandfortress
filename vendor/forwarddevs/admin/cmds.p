
#include <YSI\y_hooks>

#define ACMDS_ERROR401 "Error 401: No estás autorizado."

hook OnGameModeInit()
{
	print("AdminCmds Enabled");

	return 1;
}
stock GetPlayersName( playerid )
{
	new name[ MAX_PLAYER_NAME ];
	GetPlayerName( playerid, name, sizeof( name ) );
	return name;
}

stock ReturnPlayerIp( playerid )
{
	new Ip[ 16 ];
	GetPlayerIp( playerid, Ip, sizeof( Ip ) );
	return Ip;
}
CMD:gotospawn(playerid,params[]) {
	if(User::playerid(admin))
	{
		User::playerid(xPos) = DEFAULT_POS_X;
		User::playerid(yPos) = DEFAULT_POS_Y;
		User::playerid(zPos) = DEFAULT_POS_Z;
		User::playerid(aPos) = DEFAULT_POS_A;

		SetSpawnInfo(playerid, NO_TEAM, 0, User::playerid(xPos), User::playerid(yPos), User::playerid(zPos), User::playerid(aPos), 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
	}
	else
	{
		return SendClientMessage(playerid,0xFFFFFFFF,ACMDS_ERROR401);
	}
	return true;
}


CMD:veh(playerid,params[]) {
	if(User::playerid(admin))
	{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(520, x+1, y+1, z, az, -1, -1, 180);

	}
	else
	{
		return SendClientMessage(playerid,0xFFFFFFFF,ACMDS_ERROR401);
	}
	return true;
}


// CMD para cambiar de skin | Required: AUTH & SINTAXIS
CMD:setskin(playerid,params[]) {
	if(User::playerid(admin))
	{
		new target, skinn;
		if(sscanf(params,"id",target, skinn)) return  Sintaxis(playerid, "/setskin <PlayerID> <SkinID>", 3);
		SetPlayerSkin(target, skinn);
		User::target(skin) = skinn;
		orm_save(User::target(ORM_ID));
		new string[128];
		format(string,sizeof(string), "AdminActions: Cambiaste el skin de %s a %d",User::target(name),skinn);
		SendClientMessage(playerid,0xFFFFFFFF,string);

	}
	else
	{
		return SendClientMessage(playerid,0xFFFFFFFF,ACMDS_ERROR401);
	}
	return true;
}

// CMD para banear a un usuario| Required: AUTH & SINTAXIS
CMD:banear(playerid,params[]) {
	if(User::playerid(admin))
	{
		new targetid, reason[ 64 ];
		if(sscanf(params,"us[64]",targetid, reason)) return  Sintaxis(playerid, "/banear <PlayerID> <Motivo>", 3);
		if( targetid == INVALID_PLAYER_ID || playerid == targetid ) return SendClientMessage( playerid, 0xFFFF0000, "Error: ID inválida." );
		new str[ 128 ];
		format( str, sizeof( str ), "%s ha baneado a %s por %s.", GetPlayersName( playerid ), GetPlayersName( targetid ), reason );
		SendClientMessageToAll( -1, str );
		BlockIpAddress( ReturnPlayerIp( targetid ), 0 );
	}
	else
	{
		return SendClientMessage(playerid,0xFFFFFFFF,ACMDS_ERROR401);
	}
	return true;
}

// CMD para suspender a un usuario | Required: AUTH & SINTAXIS
CMD:suspender(playerid,params[]) {
	if(User::playerid(admin))
	{
		new targetid, reason[ 64 ], hours, days;
		if( sscanf( params, "uiis[64]", targetid, hours, days, reason ) ) return Sintaxis(playerid, "/suspender <PlayerID> <Horas> <Dias> <Motivo>", 3);
		if( targetid == INVALID_PLAYER_ID || playerid == targetid ) return SendClientMessage( playerid, 0xFFFF0000, "Error: ID inválida." );
		
		new total_suspension = ( ( ( ( hours * 60 ) * 60 ) * 1000 ) + ( ( ( ( days * 24 ) * 60 ) * 60 ) * 1000 ) );
		
		new str[ 186 ];
		
		format( str, sizeof( str ), "%s ha suspendido a %s por %i dias y %i horas, motivo: %s", ReturnPlayerName( playerid ), ReturnPlayerName( targetid ), days, hours, reason );
		SendClientMessageToAll( -1, str );
		BlockIpAddress( ReturnPlayerIp( targetid ), total_suspension );
	}
	else
	{
		return SendClientMessage(playerid,0xFFFFFFFF,ACMDS_ERROR401);
	}
	return true;
}

// CMD para desbanear a un usuario | Required: AUTH & SINTAXIS
CMD:desbanear(playerid,params[]) {
	if(User::playerid(admin))
	{
		new ip_address[ 16 ];
	    if( sscanf( params, "s[16]", ip_address ) ) return Sintaxis(playerid, "/desbanear <IP>", 3);

	    new str[ 94 ];
	    format( str, sizeof( str ), "AdminActions: Desbaneaste la IP %s", ip_address );
	    SendClientMessage(playerid, -1, str );
		
		UnBlockIpAddress( ip_address );
	}
	else
	{
		return SendClientMessage(playerid,0xFFFFFFFF,ACMDS_ERROR401);
	}
	return true;
}

hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(User::playerid(admin))
	{
		SetPlayerPosFindZ(playerid, fX, fY, fZ); 
	}
    return 1;
}