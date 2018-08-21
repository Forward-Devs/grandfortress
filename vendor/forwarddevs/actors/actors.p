#include <YSI\y_hooks>
#if defined _Actors_Component
	#endinput
#endif
#define _Actors_Component

#define Actors::%0(%1) forward Actors_%0(%1);public Actors_%0(%1)




hook OnGameModeInit()
{
	mysql_tquery(g_SQL, "SELECT * FROM `actors`", "Actors_Load", "");
	return 1;
}

Actors::Load()
{
	for(new i=0; i < cache_num_rows(); ++i)
	{

		// Crea una instancia orm y carga todas las variables requeridas
		new ORM: ormid = Actor::i(ORM_ID) = orm_create("actors", g_SQL);
		orm_addvar_int(ormid, Actor::i(id), "id");
		orm_addvar_string(ormid, Actor::i(name), MAX_PLAYER_NAME, "name");
		orm_addvar_int(ormid, Actor::i(type), "type");
		orm_addvar_int(ormid, Actor::i(skin), "skin");
		orm_addvar_float(ormid, Actor::i(xPos), "xPos");
		orm_addvar_float(ormid, Actor::i(yPos), "yPos");
		orm_addvar_float(ormid, Actor::i(zPos), "zPos");
		orm_addvar_float(ormid, Actor::i(aPos), "aPos");
		orm_addvar_int(ormid, Actor::i(interior), "interior");
		orm_addvar_float(ormid, Actor::i(health), "health");
		orm_addvar_int(ormid, Actor::i(invulnerable), "invulnerable");
		orm_apply_cache(ormid, i);

		Actor::i(ActorText) = CreateDynamic3DTextLabel(Actor::i(name), 0x008080FF,Actor::i(xPos), Actor::i(yPos), Actor::i(zPos)+1.05, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
		Actor::i(actor) = CreateActor(Actor::i(skin), Actor::i(xPos), Actor::i(yPos), Actor::i(zPos), Actor::i(aPos));
		SetActorHealth(Actor::i(actor), Actor::i(health));
		SetActorInvulnerable(Actor::i(actor), Actor::i(invulnerable));
		printf("Actor %d Cargado", Actor::i(actor));
	}
	print("Component: Actors (FR0Z3NH34R7) loaded.");
	return 1;
}

