#if defined _Levels_Component
    #endinput
#endif
#define _Levels_Component

#define Level::%0(%1) forward Level_%0(%1);public Level_%0(%1)


enum E_LEVELS
{
	ORM: ORM_ID,

	id,
	level,
	exp
};
new Level[MAX_LEVELS][E_LEVELS];
Level::OnComponentInit()
{
	mysql_tquery(g_SQL, "SELECT * FROM `levels`", "Level_Load", "");
	return 1;
}

Level::Load()
{
	for(new i=0; i < cache_num_rows(); ++i)
	{
		// Crea una instancia orm y carga todas las variables requeridas
		new ORM: ormid = Level[i][ORM_ID] = orm_create("levels", g_SQL);
		orm_addvar_int(ormid, Level[i][id], "id");
		orm_addvar_int(ormid, Level[i][level], "level");
		orm_addvar_int(ormid, Level[i][exp], "exp");
		orm_apply_cache(ormid, i);

	}
	print("Component: Levels (FR0Z3NH34R7) loaded.");
	return 1;
}

Level::GetExp(level_id)
{
	new expe;
	expe = Level[level_id][exp];
	return expe;
}