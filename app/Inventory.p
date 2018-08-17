#define Inventory(%0)::%1(%2) Inventory[%0][%1][Inventory_%2] // Use Inventory::playerid(0, slot)

#define MAX_INVENTORY (120)

enum E_INVENTORY {
	ORM: Inventory_ORM_ID,

	Inventory_id,
	bool:Inventory_exist,
	Inventory_user_id,
	Inventory_item_id,
	Inventory_slot,
	Inventory_quantity
};
new Inventory[MAX_PLAYERS][MAX_INVENTORY][E_INVENTORY];