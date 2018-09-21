#include <YSI\y_hooks>

#define Levels::%0(%1) forward Levels_%0(%1);public Levels_%0(%1)
new LevelsCount = 0;

hook OnGameModeInit()
{
	mysql_tquery(g_SQL, "SELECT * FROM `levels`", "Levels_Load", "");

	return 1;
}

Levels::Load()
{
	for(new i=0; i < cache_num_rows(); ++i)
	{
		// Crea una instancia orm y carga todas las variables requeridas
		new ORM: ormid = Level::i(ORM_ID) = orm_create("levels", g_SQL);
		orm_addvar_int(ormid, Level::i(id), "id");
		orm_addvar_int(ormid, Level::i(level), "level");
		orm_addvar_int(ormid, Level::i(exp), "exp");
		orm_apply_cache(ormid, i);
		LevelsCount++;

	}
	print("Component: Levels (FR0Z3NH34R7) loaded.");
	return 1;
}

Levels::GetExp(level_id)
{
	new expe;
	expe = Level::level_id(exp);
	return expe;
}
Levels::GetLevelId(level_n)
{
	new levelid = -1;
	for(new i=0; i < LevelsCount+1; ++i)
	{
		if(Level::i(level) == level_n)
		{
			levelid = i;
		}
	}
	return levelid;
}
Global::SetPlayerLevel(playerid, newlevel)
{
	if(newlevel <= LevelsCount)
	{
		User::playerid(level) = newlevel;
		OnPlayerReceiveExperience(playerid);
	}
	return 1;
}
Global::SetPlayerExperience(playerid, experience)
{
	User::playerid(exp) = experience;
	OnPlayerReceiveExperience(playerid);
	return 1;
}
Global::GivePlayerExperience(playerid, experience)
{
	User::playerid(exp) = User::playerid(exp)+experience;
	OnPlayerReceiveExperience(playerid);
	return 1;
}
Global::OnPlayerReceiveExperience(playerid)
{
	new playerExp = User::playerid(exp);
	new playerLevel = User::playerid(level);
	if(playerLevel <= LevelsCount)
	{
		new levelId = Levels_GetLevelId(playerLevel);
		if(playerExp >= Level::levelId(exp))
		{
			User::playerid(level)++;
			User::playerid(exp) = User::playerid(exp)-Level::levelId(exp);
		}
	}
	
	return true;
}
CMD:level(playerid,params[]) {
	new idd;
	if(sscanf(params,"i",idd)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage: /level [Level ID]");
	new string[128];
	format(string,sizeof(string), "Level %d Exp: %d",Level::idd+1(level),Level::idd+1(exp));
	SendClientMessage(playerid,0xFFFFFFFF,string);

	return true;
}