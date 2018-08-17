/* Level Model */
#define 	MAX_LEVELS			85 //Máximo de niveles

#define Level::%0(%1) Level[%0][Level_%1] // Usage: Level::1(exp) | Return exp of level 1

enum E_LEVELS
{
	ORM: Level_ORM_ID,
	Level_id,
	Level_level,
	Level_exp
};
new Level[MAX_LEVELS][E_LEVELS];