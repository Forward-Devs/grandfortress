#include <YSI\y_hooks>

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

	// create orm instance and register all needed variables
	new ORM: ormid = Player[playerid][ORM_ID] = orm_create("players", g_SQL);

	orm_addvar_int(ormid, Player[playerid][id], "id");
	orm_addvar_string(ormid, Player[playerid][name], MAX_PLAYER_NAME, "name");
	orm_addvar_string(ormid, Player[playerid][password], BCRYPT_HASH_LENGTH, "password");
	orm_addvar_int(ormid, Player[playerid][kills], "kills");
	orm_addvar_int(ormid, Player[playerid][deaths], "deaths");
	orm_addvar_float(ormid, Player[playerid][xPos], "x");
	orm_addvar_float(ormid, Player[playerid][yPos], "y");
	orm_addvar_float(ormid, Player[playerid][zPos], "z");
	orm_addvar_float(ormid, Player[playerid][aPos], "angle");
	orm_addvar_int(ormid, Player[playerid][interior], "interior");
	orm_setkey(ormid, "username");

	// tell the orm system to load all data, assign it to our variables and call our callback when ready
	orm_load(ormid, "Login_OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	g_MysqlRaceCheck[playerid]++;

	UpdatePlayerData(playerid, reason);

  	// if the player was kicked before the time expires (30 seconds), kill the timer
	if (Player[playerid][LoginTimer])
	{
  	KillTimer(Player[playerid][LoginTimer]);
  	Player[playerid][LoginTimer] = 0;
  }

  	// sets "IsLoggedIn" to false when the player disconnects, it prevents from saving the player data twice when "gmx" is used
	Player[playerid][IsLoggedIn] = false;
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	// spawn the player to their last saved position
	SetPlayerInterior(playerid, Player[playerid][interior]);
	SetPlayerPos(playerid, Player[playerid][xPos], Player[playerid][yPos], Player[playerid][zPos]);
	SetPlayerFacingAngle(playerid, Player[playerid][aPos]);

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

			// from now on, the player has 30 seconds to login
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
	// reset the variable that stores the timerid
	Player[playerid][LoginTimer] = 0;

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been kicked for taking too long to login successfully to your account.", "Okay", "");
	DelayedKick(playerid);
	return 1;
}

Login::OnPlayerRegister(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Registration", "Account successfully registered, you have been automatically logged in.", "Okay", "");

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

  // sends an INSERT query
  orm_save(Player[playerid][ORM_ID], "Login_OnPlayerRegister", "d", playerid);
	return 1;
}

Login::OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();


  if (match)
  {
    //correct password, spawn the player
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been successfully logged in.", "Okay", "");

    KillTimer(Player[playerid][LoginTimer]);
    Player[playerid][LoginTimer] = 0;
    Player[playerid][IsLoggedIn] = true;

    // spawn the player to their last saved position after login
    SetSpawnInfo(playerid, NO_TEAM, 0, Player[playerid][xPos], Player[playerid][yPos], Player[playerid][zPos], Player[playerid][aPos], 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);
  }
  else
  {
    Player[playerid][LoginAttempts]++;

    if (Player[playerid][LoginAttempts] >= 3)
    {
      ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have mistyped your password too often (3 times).", "Okay", "");
      DelayedKick(playerid);
    }
    else ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Wrong password!\nPlease enter your password in the field below:", "Login", "Abort");
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

	// if the client crashed, it's not possible to get the player's position in OnPlayerDisconnect callback
	// so we will use the last saved position (in case of a player who registered and crashed/kicked, the position will be the default spawn point)
	if (reason == 1)
	{
		GetPlayerPos(playerid, Player[playerid][xPos], Player[playerid][yPos], Player[playerid][zPos]);
		GetPlayerFacingAngle(playerid, Player[playerid][aPos]);
	}

	// it is important to store everything in the variables registered in ORM instance
	Player[playerid][interior] = GetPlayerInterior(playerid);

	// orm_save sends an UPDATE query
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
	// we must check before if the killer wasn't valid (connected) player to avoid run time error 4
	if (killerid == INVALID_PLAYER_ID) return 0;
	if (Player[killerid][IsLoggedIn] == false) return 0;

	Player[killerid][kills]++;

	orm_update(Player[killerid][ORM_ID]);
	return 1;
}
