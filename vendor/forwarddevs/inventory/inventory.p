#include <YSI\y_hooks>
#if defined _Inventories_Component
	#endinput
#endif
#define _Inventories_Component


#define Inventories::%0(%1) forward Inventories_%0(%1);public Inventories_%0(%1)
#define Items::%0(%1) forward Items_%0(%1);public Items_%0(%1)



hook OnPlayerConnect(playerid)
{
	for(new i=0; i < MAX_INVENTORY; ++i)
	{
		static const empty_inv[E_INVENTORY];
		Inventory[playerid][i] = empty_inv;
	}
	new query[256];
	format(query, sizeof(query), "SELECT * FROM `inventories` WHERE `user_id` = '%d'", User::playerid(id));
	mysql_tquery(g_SQL, query, "Inventories_Load", "d", playerid);

	return 1;
}
Inventories::Load(playerid)
{
	new count = 0;
	for(new i=0; i < cache_num_rows(); ++i)
	{
		count++;
		// Crea una instancia orm y carga todas las variables requeridas
		new ORM: ormid = Inventory(playerid)::i(ORM_ID) = orm_create("inventories", g_SQL);
		orm_addvar_int(ormid, Inventory(playerid)::i(id), "id");
		orm_addvar_int(ormid, Inventory(playerid)::i(user_id), "user_id");
		orm_addvar_int(ormid, Inventory(playerid)::i(item_id), "Items_id");
		orm_addvar_int(ormid, Inventory(playerid)::i(slot), "slot");
		orm_addvar_int(ormid, Inventory(playerid)::i(quantity), "quantity");
		orm_apply_cache(ormid, i);

	}
	return 1;
}
Inventories::Clear(playerid)
{
	static
	    string[64];

	for(new i=0; i < MAX_INVENTORY; ++i)
	{
		static const empty_inv[E_INVENTORY];
		Inventory[playerid][i] = empty_inv;
	}
	format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", User::playerid(id));
	return mysql_tquery(g_SQL, string);
}


hook OnGameModeInit()
{
	mysql_tquery(g_SQL, "SELECT * FROM `items`", "Items_Load", "");
	return 1;
}

Items::Load()
{
	new count = 0;
	for(new i=0; i < cache_num_rows(); ++i)
	{
		count++;
		// Crea una instancia orm y carga todas las variables requeridas
		new ORM: ormid = Item::i(ORM_ID) = orm_create("items", g_SQL);
		orm_addvar_int(ormid, Item::i(id), "id");
		orm_addvar_int(ormid, Item::i(model), "model");
		orm_addvar_int(ormid, Item::i(type), "type");
		orm_addvar_string(ormid, Item::i(name), 32, "name");
		orm_apply_cache(ormid, i);

	}
	printf("Component: Items (FR0Z3NH34R7) loaded (%d Items).", count);
	return 1;
}

CMD:inv(playerid,params[]) {
	new idd;
	if(sscanf(params,"i",idd)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage: /inv [invid]");
	new string[128];
	format(string,sizeof(string), "InvSlot %d Item: %d",Inventory(playerid)::idd+1(slot),Items_GetItemById(Inventory(playerid)::idd+1(item_id)));
	SendClientMessage(playerid,0xFFFFFFFF,string);

	return true;
}

Items::GetItemById(iditem)
{
	for(new i=0; i < MAX_ITEMS; ++i)
	{
		if(Item::i(id) == iditem)
		{
			return Item::i(id);
		}
	}
	return -1;
}