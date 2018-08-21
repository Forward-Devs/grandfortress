#include <YSI\y_hooks>

#if defined _Login_Component
    #endinput
#endif
#define _Login_Component

#define Login::%0(%1) forward Login_%0(%1);public Login_%0(%1)
#define BCRYPT_COST 12



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

	GetPlayerName(playerid, User::playerid(name), MAX_PLAYER_NAME);

	// Crea una instancia orm y carga todas las variables requeridas
	new ORM: ormid = User::playerid(ORM_ID) = orm_create("users", g_SQL);

	orm_addvar_int(ormid, User::playerid(id), "id");
	orm_addvar_string(ormid, User::playerid(name), MAX_PLAYER_NAME, "name");
	orm_addvar_string(ormid, User::playerid(password), BCRYPT_HASH_LENGTH, "password");
	orm_addvar_int(ormid, User::playerid(kills), "kills");
	orm_addvar_int(ormid, User::playerid(deaths), "deaths");
	orm_addvar_float(ormid, User::playerid(xPos), "xPos");
	orm_addvar_float(ormid, User::playerid(yPos), "yPos");
	orm_addvar_float(ormid, User::playerid(zPos), "zPos");
	orm_addvar_float(ormid, User::playerid(aPos), "aPos");
	orm_addvar_int(ormid, User::playerid(interior), "interior");
	orm_addvar_int(ormid, User::playerid(skin), "skin");
	orm_addvar_int(ormid, User::playerid(admin), "admin");
	orm_addvar_int(ormid, User::playerid(developer), "developer");
	orm_addvar_int(ormid, User::playerid(gender), "gender");
	orm_addvar_int(ormid, User::playerid(level), "level");
	orm_addvar_int(ormid, User::playerid(exp), "exp");
	orm_setkey(ormid, "name");

	orm_load(ormid, "Login_OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	g_MysqlRaceCheck[playerid]++;

	UpdatePlayerData(playerid, reason);

  // Si el jugador fue kickeado por timeout, elimina el timer
	if (User::playerid(LoginTimer))
	{
  	KillTimer(User::playerid(LoginTimer));
  	User::playerid(LoginTimer) = 0;
  }

  // setea "IsLoggedIn" en false cuando el jugador se desconecta, esto previene guardar la información cuando se usa el "gmx"
	User::playerid(IsLoggedIn) = false;
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	// spawnea el jugador en su ultima ubicación.
	SetPlayerInterior(playerid, User::playerid(interior));
	SetPlayerPos(playerid, User::playerid(xPos), User::playerid(yPos), User::playerid(zPos));
	SetPlayerFacingAngle(playerid, User::playerid(aPos));
	SetPlayerSkin(playerid, User::playerid(skin));
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
    bcrypt_check(inputtext, User::playerid(password),  "Login_OnPasswordChecked", "d", playerid);
  }
  if(dialogid == DIALOG_REGISTER)
  {
    if (!response) return Kick(playerid);
    if (strlen(inputtext) <= 5) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Your password must be longer than 5 characters!\nPlease enter your password in the field below:", "Register", "Abort");
    bcrypt_hash(inputtext, BCRYPT_COST, "Login_OnPasswordHashed", "d", playerid);
	}
  return 1;
}
hook OnGameModeInit()
{
	print("Component: Login (FR0Z3NH34R7) loaded.");
	return 1;
}

Login::OnPlayerDataLoaded(playerid, race_check)
{

	if (race_check != g_MysqlRaceCheck[playerid]) return Kick(playerid);

	orm_setkey(User::playerid(ORM_ID), "id");

	new string[254];
	switch (orm_errno(User::playerid(ORM_ID)))
	{
		case ERROR_OK:
		{
			format(string, sizeof(string), "\\c{FFFFFF}Bienvenido de nuevo, {09E627}%s \n \n\\c{FFFFFF}Por favor, escriba su contraseña en el siguiente cuadro.", User::playerid(name));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "\\c{FFFFFF}Login", string, "Jugar", "Salir");

			// A partir de ahora tiene 30 segundos para loguear
			User::playerid(LoginTimer) = SetTimerEx("Login_OnLoginTimeout", SECONDS_TO_LOGIN * 1000, false, "d", playerid);
		}
		case ERROR_NO_DATA:
		{
			format(string, sizeof(string), "\\c{FFFFFF}Bienvenido {09E627}%s \n \n\\c{FFFFFF}Puedes registrarte escribiendo una contraseña en el siguiente cuadro.", User::playerid(name));
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "\\c{FFFFFF}Registro", string, "Registrarme", "Salir");
		}
	}
	return 1;
}

Login::OnLoginTimeout(playerid)
{
	// Resetea la variable que contiene el timer
	User::playerid(LoginTimer) = 0;

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "\\c{FFFFFF}Login", "\\c{FFFFFF}Fuiste kickeado por permanecer mucho tiempo sin loguear", "Aceptar", "");
	DelayedKick(playerid);
	return 1;
}

Login::OnPlayerRegister(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "\\c{FFFFFF}Registro", "\\c{FFFFFF}Registraste una cuenta e ingresaste automáticamente.", "Aceptar", "");

	User::playerid(IsLoggedIn) = true;

	User::playerid(xPos) = DEFAULT_POS_X;
	User::playerid(yPos) = DEFAULT_POS_Y;
	User::playerid(zPos) = DEFAULT_POS_Z;
	User::playerid(aPos) = DEFAULT_POS_A;

	SetSpawnInfo(playerid, NO_TEAM, 0, User::playerid(xPos), User::playerid(yPos), User::playerid(zPos), User::playerid(aPos), 0, 0, 0, 0, 0, 0);
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
	bcrypt_get_hash(User::playerid(password));

  	// envia un INSERT
  	orm_save(User::playerid(ORM_ID), "Login_OnPlayerRegister", "d", playerid);
	return 1;
}

Login::OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();


  	if (match)
	{
	    //Contraseña correcta, spawnea al jugador
	  	
		KillTimer(User::playerid(LoginTimer));
	    User::playerid(LoginTimer) = 0;
	    User::playerid(IsLoggedIn) = true;
	    SetSpawnInfo(playerid, NO_TEAM, 20011, User::playerid(xPos), User::playerid(yPos), User::playerid(zPos), User::playerid(aPos), 0, 0, 0, 0, 0, 0);
	    SpawnPlayer(playerid);
	}
	else
	{
		User::playerid(LoginAttempts)++;

	    if (User::playerid(LoginAttempts) >= 3)
	    {
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "\\c{FFFFFF}Login", "\\c{FFFFFF}Fallaste muchas veces la contraseña (3 veces).", "Aceptar", "");
	      	DelayedKick(playerid);
	    }
	    else ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "\\c{FFFFFF}Login", "\\c{FFFFFF}¡Contraseña incorrecta!\nPor favor intentelo nuevamente:", "Aceptar", "Salir");
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
	if (User::playerid(IsLoggedIn) == false) return 0;

	// si se crashea el cliente no es posible recuperar la posición en la que estaba
	// asi que se usa la ultima posición guardada (en caso de que crashee en el registro, la posición es la predeterminada)
	if (reason == 1)
	{
		GetPlayerPos(playerid, User::playerid(xPos), User::playerid(yPos), User::playerid(zPos));
		GetPlayerFacingAngle(playerid, User::playerid(aPos));
	}

	// Esto es importante para guardar todas las variables en el ORM
	User::playerid(interior) = GetPlayerInterior(playerid);

	// se guardan los datos
	orm_save(User::playerid(ORM_ID));
	orm_destroy(User::playerid(ORM_ID));
	return 1;
}

UpdatePlayerDeaths(playerid)
{
	if (User::playerid(IsLoggedIn) == false) return 0;

	User::playerid(deaths)++;
	
	orm_update(User::playerid(ORM_ID));
	return 1;
}

UpdatePlayerKills(killerid)
{
	// checkea si el asesino esta logueado
	if (killerid == INVALID_PLAYER_ID) return 0;
	if (User::killerid(IsLoggedIn) == false) return 0;

	User::killerid(kills)++;

	orm_update(User::killerid(ORM_ID));
	return 1;
}
hook OnPlayerFinishedDownloading(playerid, virtualworld)
{
    SendClientMessage(playerid, 0xffffffff, "Downloads finished.");
    return 1;
}
