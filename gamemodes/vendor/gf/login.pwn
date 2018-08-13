
#if defined _Login_Component
    #endinput
#endif
#define _Login_Component

#define Login::%0(%1) forward Login_%0(%1);public Login_%0(%1)
#define BCRYPT_COST 12
enum E_PLAYERS
{
	ORM: ORM_ID,

	id,
	name[MAX_PLAYER_NAME],
	password[BCRYPT_HASH_LENGTH], // bcrypt
	kills,
	deaths,
	Float: xPos,
	Float: yPos,
	Float: zPos,
	Float: aPos,
	interior,
	skin,
	gender,
	level,
	exp,

	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer
};
new Player[MAX_PLAYERS][E_PLAYERS];
// MySQL connection handle
new MySQL: g_SQL;

//dialog data
enum
{
	DIALOG_UNUSED,

	DIALOG_LOGIN,
	DIALOG_REGISTER
};
new g_MysqlRaceCheck[MAX_PLAYERS];

hook OnGameModeExit()
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) // GetPlayerPoolSize fue añadida en la 0.3.7 y su función es tomar el id más alto en uso.
	{
		if (IsPlayerConnected(i))
		{
	      	// La razón es 1 para una salida normal
	    	OnPlayerDisconnect(i, 1);
	    }
	  }
	return 1;
}

hook OnPlayerConnect(playerid)
{
  	g_MysqlRaceCheck[playerid]++;

  	// reset player data
  	static const empty_player[E_PLAYERS];
	Player[playerid] = empty_player;

	GetPlayerName(playerid, Player[playerid][name], MAX_PLAYER_NAME);

	// Crea una instancia orm y carga todas las variables requeridas
	new ORM: ormid = Player[playerid][ORM_ID] = orm_create("users", g_SQL);

	orm_addvar_int(ormid, Player[playerid][id], "id");
	orm_addvar_string(ormid, Player[playerid][name], MAX_PLAYER_NAME, "name");
	orm_addvar_string(ormid, Player[playerid][password], BCRYPT_HASH_LENGTH, "password");
	orm_addvar_int(ormid, Player[playerid][kills], "kills");
	orm_addvar_int(ormid, Player[playerid][deaths], "deaths");
	orm_addvar_float(ormid, Player[playerid][xPos], "xPos");
	orm_addvar_float(ormid, Player[playerid][yPos], "yPos");
	orm_addvar_float(ormid, Player[playerid][zPos], "zPos");
	orm_addvar_float(ormid, Player[playerid][aPos], "aPos");
	orm_addvar_int(ormid, Player[playerid][interior], "interior");
	orm_addvar_int(ormid, Player[playerid][skin], "skin");
	orm_addvar_int(ormid, Player[playerid][gender], "gender");
	orm_addvar_int(ormid, Player[playerid][level], "level");
	orm_addvar_int(ormid, Player[playerid][exp], "exp");
	orm_setkey(ormid, "name");

	orm_load(ormid, "Login_OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	g_MysqlRaceCheck[playerid]++;

	UpdatePlayerData(playerid, reason);

  // Si el jugador fue kickeado por timeout, elimina el timer
	if (Player[playerid][LoginTimer])
	{
  	KillTimer(Player[playerid][LoginTimer]);
  	Player[playerid][LoginTimer] = 0;
  }

  // setea "IsLoggedIn" en false cuando el jugador se desconecta, esto previene guardar la información cuando se usa el "gmx"
	Player[playerid][IsLoggedIn] = false;
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	// spawnea el jugador en su ultima ubicación.
	SetPlayerInterior(playerid, Player[playerid][interior]);
	SetPlayerPos(playerid, Player[playerid][xPos], Player[playerid][yPos], Player[playerid][zPos]);
	SetPlayerFacingAngle(playerid, Player[playerid][aPos]);
	SetPlayerSkin(playerid, Player[playerid][skin]);
	SetCameraBehindPlayer(playerid);
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
  UpdatePlayerDeaths(playerid);
  UpdatePlayerKills(killerid);
  return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  if(dialogid == DIALOG_LOGIN)
  {
    if (!response) return Kick(playerid);
    bcrypt_check(inputtext, Player[playerid][password],  "Login_OnPasswordChecked", "d", playerid);
  }
  if(dialogid == DIALOG_REGISTER)
  {
    if (!response) return Kick(playerid);
    if (strlen(inputtext) <= 5) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Your password must be longer than 5 characters!\nPlease enter your password in the field below:", "Register", "Abort");
    bcrypt_hash(inputtext, BCRYPT_COST, "Login_OnPasswordHashed", "d", playerid);
	}
  return 1;
}
Login::OnComponentInit()
{
	print("Component: Login (FR0Z3NH34R7) loaded.");
	return 1;
}

Login::OnPlayerDataLoaded(playerid, race_check)
{

	if (race_check != g_MysqlRaceCheck[playerid]) return Kick(playerid);

	orm_setkey(Player[playerid][ORM_ID], "id");

	new string[115];
	switch (orm_errno(Player[playerid][ORM_ID]))
	{
		case ERROR_OK:
		{
			format(string, sizeof string, "This account (%s) is registered. Please login by entering your password in the field below:", Player[playerid][name]);
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Abort");

			// A partir de ahora tiene 30 segundos para loguear
			Player[playerid][LoginTimer] = SetTimerEx("Login_OnLoginTimeout", SECONDS_TO_LOGIN * 1000, false, "d", playerid);
		}
		case ERROR_NO_DATA:
		{
			format(string, sizeof string, "Welcome %s, you can register by entering your password in the field below:", Player[playerid][name]);
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", string, "Register", "Abort");
		}
	}
	return 1;
}

Login::OnLoginTimeout(playerid)
{
	// Resetea la variable que contiene el timer
	Player[playerid][LoginTimer] = 0;

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "Fuiste kickeado por permanecer mucho tiempo sin loguear", "Aceptar", "");
	DelayedKick(playerid);
	return 1;
}

Login::OnPlayerRegister(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Registro", "Registraste una cuenta e ingresaste automáticamente.", "Aceptar", "");

	Player[playerid][IsLoggedIn] = true;

	Player[playerid][xPos] = DEFAULT_POS_X;
	Player[playerid][yPos] = DEFAULT_POS_Y;
	Player[playerid][zPos] = DEFAULT_POS_Z;
	Player[playerid][aPos] = DEFAULT_POS_A;

	SetSpawnInfo(playerid, NO_TEAM, 0, Player[playerid][xPos], Player[playerid][yPos], Player[playerid][zPos], Player[playerid][aPos], 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return 1;
}

Login::KickPlayerDelayed(playerid)
{
	Kick(playerid);
	return 1;
}

Login::OnPasswordHashed(playerid)
{
	bcrypt_get_hash(Player[playerid][password]);

  	// envia un INSERT
  	orm_save(Player[playerid][ORM_ID], "Login_OnPlayerRegister", "d", playerid);
	return 1;
}

Login::OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();


  	if (match)
	{
	    //Contraseña correcta, spawnea al jugador
	  	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "Ingresaste correctamente al servidor.", "Aceptar", "");
		KillTimer(Player[playerid][LoginTimer]);
	    Player[playerid][LoginTimer] = 0;
	    Player[playerid][IsLoggedIn] = true;
	    SetSpawnInfo(playerid, NO_TEAM, 20011, Player[playerid][xPos], Player[playerid][yPos], Player[playerid][zPos], Player[playerid][aPos], 0, 0, 0, 0, 0, 0);
	    SpawnPlayer(playerid);
	}
	else
	{
		Player[playerid][LoginAttempts]++;

	    if (Player[playerid][LoginAttempts] >= 3)
	    {
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "Fallaste muchas veces la contraseña (3 veces).", "Aceptar", "");
	      	DelayedKick(playerid);
	    }
	    else ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "¡Contraseña incorrecta!\nPor favor intentelo nuevamente:", "Aceptar", "Salir");
	}
	return 1;
}


//-----------------------------------------------------

DelayedKick(playerid, time = 500)
{
	SetTimerEx("Login_KickPlayerDelayed", time, false, "d", playerid);
	return 1;
}


UpdatePlayerData(playerid, reason)
{
	if (Player[playerid][IsLoggedIn] == false) return 0;

	// si se crashea el cliente no es posible recuperar la posición en la que estaba
	// asi que se usa la ultima posición guardada (en caso de que crashee en el registro, la posición es la predeterminada)
	if (reason == 1)
	{
		GetPlayerPos(playerid, Player[playerid][xPos], Player[playerid][yPos], Player[playerid][zPos]);
		GetPlayerFacingAngle(playerid, Player[playerid][aPos]);
	}

	// Esto es importante para guardar todas las variables en el ORM
	Player[playerid][interior] = GetPlayerInterior(playerid);

	// se guardan los datos
	orm_save(Player[playerid][ORM_ID]);
	orm_destroy(Player[playerid][ORM_ID]);
	return 1;
}

UpdatePlayerDeaths(playerid)
{
	if (Player[playerid][IsLoggedIn] == false) return 0;

	Player[playerid][deaths]++;
	
	orm_update(Player[playerid][ORM_ID]);
	return 1;
}

UpdatePlayerKills(killerid)
{
	// checkea si el asesino esta logueado
	if (killerid == INVALID_PLAYER_ID) return 0;
	if (Player[killerid][IsLoggedIn] == false) return 0;

	Player[killerid][kills]++;

	orm_update(Player[killerid][ORM_ID]);
	return 1;
}
hook OnPlayerFinishedDownloading(playerid, virtualworld)
{
    SendClientMessage(playerid, 0xffffffff, "Downloads finished.");
    return 1;
}
