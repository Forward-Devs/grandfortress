/*
	Include 'Logros y Objetivos' por FrozenHeart©.
	
	Un elegante sistema adaptable para cualquier tipo de servidor,
	y fácil de utilizar. 
	
	Hecho para Brooklyn RP.
*/


new PlayerText:Logross[10][MAX_PLAYERS];
new PlayerText:Objetivoss[6][MAX_PLAYERS];
#define SVTag "CP:RP" // Modificar por el tag del servidor


hook OnPlayerDisconnect(playerid, reason)
{
	for(new i = 0; i < 10; i++) { PlayerTextDrawHide(playerid, Logross[i][playerid]); }
	for(new i = 0; i < 6; i++) { PlayerTextDrawHide(playerid, Objetivoss[i][playerid]); }
	return 1;
}

hook OnPlayerConnect(playerid)
{
/* Sistema de Objetivos */
 	Objetivoss[0][playerid] = CreatePlayerTextDraw(playerid,364.000000, 376.000000, "_");
	PlayerTextDrawAlignment(playerid,Objetivoss[0][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Objetivoss[0][playerid], 255);
	PlayerTextDrawFont(playerid,Objetivoss[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Objetivoss[0][playerid], 0.500000, 2.000000);
	PlayerTextDrawColor(playerid,Objetivoss[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Objetivoss[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Objetivoss[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Objetivoss[0][playerid], 1);
	PlayerTextDrawUseBox(playerid,Objetivoss[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Objetivoss[0][playerid], 370546431);
	PlayerTextDrawTextSize(playerid,Objetivoss[0][playerid], 60.000000, 220.000000);
	PlayerTextDrawSetSelectable(playerid,Objetivoss[0][playerid], 0);

	Objetivoss[1][playerid] = CreatePlayerTextDraw(playerid,364.000000, 399.000000, "_");
	PlayerTextDrawAlignment(playerid,Objetivoss[1][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Objetivoss[1][playerid], 255);
	PlayerTextDrawFont(playerid,Objetivoss[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Objetivoss[1][playerid], 0.500000, 2.000000);
	PlayerTextDrawColor(playerid,Objetivoss[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Objetivoss[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Objetivoss[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Objetivoss[1][playerid], 1);
	PlayerTextDrawUseBox(playerid,Objetivoss[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Objetivoss[1][playerid], 286331391);
	PlayerTextDrawTextSize(playerid,Objetivoss[1][playerid], 60.000000, 220.000000);
	PlayerTextDrawSetSelectable(playerid,Objetivoss[1][playerid], 0);

	Objetivoss[2][playerid] = CreatePlayerTextDraw(playerid,358.000000, 373.000000, "OBJETIVO CUMPLIDO");
	PlayerTextDrawAlignment(playerid,Objetivoss[2][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Objetivoss[2][playerid], 741092607);
	PlayerTextDrawFont(playerid,Objetivoss[2][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Objetivoss[2][playerid], 0.210000, 1.200000);
	PlayerTextDrawColor(playerid,Objetivoss[2][playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,Objetivoss[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Objetivoss[2][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Objetivoss[2][playerid], 0);

	Objetivoss[3][playerid] = CreatePlayerTextDraw(playerid,220.000000, 373.000000, "LD_CHAT:thumbup");
	PlayerTextDrawBackgroundColor(playerid,Objetivoss[3][playerid], 255);
	PlayerTextDrawFont(playerid,Objetivoss[3][playerid], 4);
	PlayerTextDrawLetterSize(playerid,Objetivoss[3][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Objetivoss[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Objetivoss[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Objetivoss[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Objetivoss[3][playerid], 1);
	PlayerTextDrawUseBox(playerid,Objetivoss[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Objetivoss[3][playerid], 255);
	PlayerTextDrawTextSize(playerid,Objetivoss[3][playerid], 51.000000, 48.000000);
	PlayerTextDrawSetSelectable(playerid,Objetivoss[3][playerid], 0);

	Objetivoss[4][playerid] = CreatePlayerTextDraw(playerid,359.000000, 384.000000, "Cambio de ropa");
	PlayerTextDrawAlignment(playerid,Objetivoss[4][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Objetivoss[4][playerid], 741092607);
	PlayerTextDrawFont(playerid,Objetivoss[4][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Objetivoss[4][playerid], 0.210000, 1.200000);
	PlayerTextDrawColor(playerid,Objetivoss[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Objetivoss[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Objetivoss[4][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Objetivoss[4][playerid], 0);

	Objetivoss[5][playerid] = CreatePlayerTextDraw(playerid,359.000000, 402.000000, "10 DP + $2.000");
	PlayerTextDrawAlignment(playerid,Objetivoss[5][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Objetivoss[5][playerid], 741092607);
	PlayerTextDrawFont(playerid,Objetivoss[5][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Objetivoss[5][playerid], 0.210000, 1.200000);
	PlayerTextDrawColor(playerid,Objetivoss[5][playerid], -65281);
	PlayerTextDrawSetOutline(playerid,Objetivoss[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Objetivoss[5][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Objetivoss[5][playerid], 0);
	/* Sistema de logros */
	// In OnPlayerConnect prefferably, we procced to create our textdraws:
	Logross[0][playerid] = CreatePlayerTextDraw(playerid,379.000000, 376.000000, "_");
	PlayerTextDrawAlignment(playerid,Logross[0][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[0][playerid], 255);
	PlayerTextDrawFont(playerid,Logross[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Logross[0][playerid], 0.500000, 2.000000);
	PlayerTextDrawColor(playerid,Logross[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Logross[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Logross[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Logross[0][playerid], 1);
	PlayerTextDrawUseBox(playerid,Logross[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Logross[0][playerid], 370546431);
	PlayerTextDrawTextSize(playerid,Logross[0][playerid], 127.000000, 263.000000);
	PlayerTextDrawSetSelectable(playerid,Logross[0][playerid], 0);

	Logross[1][playerid] = CreatePlayerTextDraw(playerid,375.000000, 399.000000, "_");
	PlayerTextDrawAlignment(playerid,Logross[1][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[1][playerid], 255);
	PlayerTextDrawFont(playerid,Logross[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Logross[1][playerid], 0.500000, 2.000000);
	PlayerTextDrawColor(playerid,Logross[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Logross[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Logross[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Logross[1][playerid], 1);
	PlayerTextDrawUseBox(playerid,Logross[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Logross[1][playerid], 286331391);
	PlayerTextDrawTextSize(playerid,Logross[1][playerid], 60.000000, 271.000000);
	PlayerTextDrawSetSelectable(playerid,Logross[1][playerid], 0);

	Logross[2][playerid] = CreatePlayerTextDraw(playerid,376.000000, 373.000000, "LOGRO DESBLOQUEADO");
	PlayerTextDrawAlignment(playerid,Logross[2][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[2][playerid], 741092607);
	PlayerTextDrawFont(playerid,Logross[2][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Logross[2][playerid], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,Logross[2][playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,Logross[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Logross[2][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Logross[2][playerid], 0);

	Logross[3][playerid] = CreatePlayerTextDraw(playerid,220.000000, 373.000000, "LD_DRV:silver");
	PlayerTextDrawBackgroundColor(playerid,Logross[3][playerid], 255);
	PlayerTextDrawFont(playerid,Logross[3][playerid], 4);
	PlayerTextDrawLetterSize(playerid,Logross[3][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Logross[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Logross[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Logross[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Logross[3][playerid], 1);
	PlayerTextDrawUseBox(playerid,Logross[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Logross[3][playerid], 255);
	PlayerTextDrawTextSize(playerid,Logross[3][playerid], 51.000000, 48.000000);
	PlayerTextDrawSetSelectable(playerid,Logross[3][playerid], 0);

	Logross[4][playerid] = CreatePlayerTextDraw(playerid,375.000000, 384.000000, "''Alcanzando el nivel 2''");
	PlayerTextDrawAlignment(playerid,Logross[4][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[4][playerid], 741092607);
	PlayerTextDrawFont(playerid,Logross[4][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Logross[4][playerid], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,Logross[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Logross[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Logross[4][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Logross[4][playerid], 0);

	Logross[5][playerid] = CreatePlayerTextDraw(playerid,381.000000, 402.000000, "Llegaste a nivel dos, es una gran noticia.");
	PlayerTextDrawAlignment(playerid,Logross[5][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[5][playerid], 741092607);
	PlayerTextDrawFont(playerid,Logross[5][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Logross[5][playerid], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,Logross[5][playerid], -65281);
	PlayerTextDrawSetOutline(playerid,Logross[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Logross[5][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Logross[5][playerid], 0);

	Logross[6][playerid] = CreatePlayerTextDraw(playerid,246.000000, 401.000000, "_");
	PlayerTextDrawAlignment(playerid,Logross[6][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[6][playerid], 255);
	PlayerTextDrawFont(playerid,Logross[6][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Logross[6][playerid], 0.500000, 0.599999);
	PlayerTextDrawColor(playerid,Logross[6][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Logross[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Logross[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Logross[6][playerid], 1);
	PlayerTextDrawUseBox(playerid,Logross[6][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Logross[6][playerid], 255);
	PlayerTextDrawTextSize(playerid,Logross[6][playerid], 62.000000, 39.000000);
	PlayerTextDrawSetSelectable(playerid,Logross[6][playerid], 0);

	Logross[7][playerid] = CreatePlayerTextDraw(playerid,245.000000, 379.000000, "+5 DP");
	PlayerTextDrawAlignment(playerid,Logross[7][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[7][playerid], -1);
	PlayerTextDrawFont(playerid,Logross[7][playerid], 3);
	PlayerTextDrawLetterSize(playerid,Logross[7][playerid], 0.280000, 1.100000);
	PlayerTextDrawColor(playerid,Logross[7][playerid], 255);
	PlayerTextDrawSetOutline(playerid,Logross[7][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Logross[7][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Logross[7][playerid], 0);

	Logross[8][playerid] = CreatePlayerTextDraw(playerid,245.000000, 388.000000, "+1000$");
	PlayerTextDrawAlignment(playerid,Logross[8][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Logross[8][playerid], -1);
	PlayerTextDrawFont(playerid,Logross[8][playerid], 3);
	PlayerTextDrawLetterSize(playerid,Logross[8][playerid], 0.280000, 1.100000);
	PlayerTextDrawColor(playerid,Logross[8][playerid], 255);
	PlayerTextDrawSetOutline(playerid,Logross[8][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Logross[8][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Logross[8][playerid], 0);

	Logross[9][playerid] = CreatePlayerTextDraw(playerid,236.000000, 398.000000, "SV:RP");
	PlayerTextDrawBackgroundColor(playerid,Logross[9][playerid], 255);
	PlayerTextDrawFont(playerid,Logross[9][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Logross[9][playerid], 0.190000, 1.100000);
	PlayerTextDrawColor(playerid,Logross[9][playerid], -65281);
	PlayerTextDrawSetOutline(playerid,Logross[9][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Logross[9][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Logross[9][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Logross[9][playerid], 0);
	
	return 1;
}

stock ObjetivoOOC(playerid, logro[], dpss, dinero)
{
	new string[156];
    	for(new i = 0; i < 6; i++) { PlayerTextDrawShow(playerid, Logross[i][playerid]); }
    	format(string, sizeof(string), "%d DP + $%d",dpss, dinero);
    	PlayerTextDrawSetString(playerid, Objetivoss[5][playerid], string);
	PlayerTextDrawSetString(playerid, Objetivoss[4][playerid], logro);
	SetTimerEx("OcultarObjetivo", 5000, false, "u", playerid);
	return 1;
}
forward OcultarObjetivo(playerid);
public OcultarObjetivo(playerid)
{
	for(new i = 0; i < 6; i++) { PlayerTextDrawHide(playerid, Objetivoss[i][playerid]); }
}
stock LogroOOC(playerid, logro[], mensaje[], dpss, dinero)
{
	new string[156];
    	for(new i = 0; i < 10; i++) { PlayerTextDrawShow(playerid, Logross[i][playerid]); }
    	format(string, sizeof(string), "+%d DP",dpss);
    	PlayerTextDrawSetString(playerid,Logross[7][playerid], string);
	PlayerTextDrawSetString(playerid, Logross[4][playerid], logro);
	PlayerTextDrawSetString(playerid,Logross[5][playerid], mensaje);
	format(string, sizeof(string), "+%d$",dinero);
	PlayerTextDrawSetString(playerid,Logross[8][playerid], string);
	PlayerTextDrawSetString(playerid,Logross[9][playerid], ""SVTag"");
	SetTimerEx("OcultarLogro", 5000, false, "u", playerid);
	//Earn(playerid, dinero);
	return 1;
}
forward OcultarLogro(playerid);
public OcultarLogro(playerid)
{
	for(new i = 0; i < 10; i++) { PlayerTextDrawHide(playerid, Logross[i][playerid]); }
}
