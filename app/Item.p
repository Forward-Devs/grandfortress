#define Item::%0(%1) Item[%0][Item_%1]

#define MAX_ITEMS (1000)

enum E_ITEMS {
	ORM: Item_ORM_ID,

	Item_id,
	Item_model,
	Item_type,
	Item_name[32 char]
}
new Item[MAX_ITEMS][E_ITEMS];