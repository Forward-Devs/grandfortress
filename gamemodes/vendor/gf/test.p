

public OnGameModeInit()
{
	print("Test 1");
	#if defined Hook_OnGameModeInit
        return Hook_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif

#define OnGameModeInit Hook_OnGameModeInit

#if defined Hook_OnGameModeInit
    forward Hook_OnGameModeInit();
#endif
#include "./vendor/gf/testo.p"



    stock Inventory_Clear(playerid)
{
	static
	    string[64];

	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (InventarioData[playerid][i][invExists])
	    {
	        InventarioData[playerid][i][invExists] = 0;
	        InventarioData[playerid][i][invModel] = 0;
	        InventarioData[playerid][i][invQuantity] = 0;
		}
	}
	format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", PlayerData[playerid][pID]);
	return mysql_tquery(g_iHandle, string);
}

stock Inventory_Set(playerid, item[], model, amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
		Inventario_Add(playerid, item, model, amount);

	else if (amount > 0 && itemid != -1)
	    Inventory_SetQuantity(playerid, item, amount);

	else if (amount < 1 && itemid != -1)
	    Inventario_Borrar(playerid, item, -1);

	return 1;
}

stock Inventory_GetItemID(playerid, item[])
{
	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!InventarioData[playerid][i][invExists])
	        continue;

		if (!strcmp(InventarioData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

stock Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= PlayerData[playerid][pCapacity])
		return -1;

	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!InventarioData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

stock Inventory_Items(playerid)
{
    new count;

    for (new i = 0; i != MAX_INVENTORY; i ++) if (InventarioData[playerid][i][invExists]) {
        count++;
	}
	return count;
}

stock Inventario_Contar(playerid, item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return InventarioData[playerid][itemid][invQuantity];

	return 0;
}

stock Inventario_Tiene(playerid, item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

stock Inventory_SetQuantity(playerid, item[], quantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item),
	    string[128];

	if (itemid != -1)
	{
	    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerData[playerid][pID], InventarioData[playerid][itemid][invID]);
	    mysql_tquery(g_iHandle, string);

	    InventarioData[playerid][itemid][invQuantity] = quantity;
	}
	return 1;
}

stock Inventario_Add(playerid, item[], model, quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	        InventarioData[playerid][itemid][invExists] = true;
	        InventarioData[playerid][itemid][invModel] = model;
	        InventarioData[playerid][itemid][invQuantity] = quantity;

	        strpack(InventarioData[playerid][itemid][invItem], item, 32 char);

			if (strcmp(item, "Demo Soda") != 0)
			{
				format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d')", PlayerData[playerid][pID], item, model, quantity);
				mysql_tquery(g_iHandle, string, "OnInventoryAdd", "dd", playerid, itemid);
			}
	        return itemid;
		}
		return -1;
	}
	else
	{
	    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerData[playerid][pID], InventarioData[playerid][itemid][invID]);
	    mysql_tquery(g_iHandle, string);

	    InventarioData[playerid][itemid][invQuantity] += quantity;
	}
	return itemid;
}

stock Inventario_Borrar(playerid, item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid != -1)
	{
	    if (InventarioData[playerid][itemid][invQuantity] > 0)
	    {
	        InventarioData[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || InventarioData[playerid][itemid][invQuantity] < 1)
		{
		    InventarioData[playerid][itemid][invExists] = false;
		    InventarioData[playerid][itemid][invModel] = 0;
		    InventarioData[playerid][itemid][invQuantity] = 0;

		    format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d' AND `invID` = '%d'", PlayerData[playerid][pID], InventarioData[playerid][itemid][invID]);
	        mysql_tquery(g_iHandle, string);
		}
		else if (quantity != -1 && InventarioData[playerid][itemid][invQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerData[playerid][pID], InventarioData[playerid][itemid][invID]);
            mysql_tquery(g_iHandle, string);
		}
		return 1;
	}
	return 0;
}
forward OnInventoryAdd(playerid, itemid);
public OnInventoryAdd(playerid, itemid)
{
	InventarioData[playerid][itemid][invID] = cache_insert_id(g_iHandle);
	return 1;
}

forward OpenInventory(playerid);
public OpenInventory(playerid)
{
    if (!IsPlayerConnected(playerid) || !PlayerData[playerid][pCharacter])
	    return 0;

	static
	    items[MAX_INVENTORY],
		amounts[MAX_INVENTORY];

    for (new i = 0; i < PlayerData[playerid][pCapacity]; i ++)
	{
 		if (InventarioData[playerid][i][invExists]) {
   			items[i] = InventarioData[playerid][i][invModel];
   			amounts[i] = InventarioData[playerid][i][invQuantity];
		}
		else {
		    items[i] = -1;
		    amounts[i] = -1;
		}
	}

	
	
	PlayerData[playerid][pStorageSelect] = 0;
	return ShowModelSelectionMenu(playerid, "Inventario", MODEL_SELECTION_INVENTORY, items, sizeof(items), 0.0, 0.0, 0.0, 1.0, -1, true, amounts);
}