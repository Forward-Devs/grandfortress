/*
    Sintaxis include by FR0Z3NH34R7
*/
#if !defined _samp_included
    #error "Primero debes incluir a_samp"
#endif

new PlayerText:SintaxisInfo[MAX_PLAYERS],
    SintaxisTiempo[MAX_PLAYERS],
    MostrandoSintaxis[MAX_PLAYERS]; 


public OnPlayerDisconnect(playerid, reason)
{

    PlayerTextDrawDestroy(playerid, SintaxisInfo[playerid]);
    #if defined Hook_OnPlayerDisconnect
        return Hook_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

public OnPlayerConnect(playerid)
{
    // Crear Textdraw
    SintaxisInfo[playerid] = CreatePlayerTextDraw(playerid, 319.999938, 401.955749, "_");
    PlayerTextDrawLetterSize(playerid, SintaxisInfo[playerid], 0.241999, 1.280593);
    PlayerTextDrawAlignment(playerid, SintaxisInfo[playerid], 2);
    PlayerTextDrawColor(playerid, SintaxisInfo[playerid], -1);
    PlayerTextDrawSetShadow(playerid, SintaxisInfo[playerid], 0);
    PlayerTextDrawSetOutline(playerid, SintaxisInfo[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, SintaxisInfo[playerid], 51);
    PlayerTextDrawFont(playerid, SintaxisInfo[playerid], 1);
    PlayerTextDrawSetProportional(playerid, SintaxisInfo[playerid], 1);
    
    MostrandoSintaxis[playerid] = 0;
    #if defined Hook_OnPlayerConnect
        return Hook_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

stock MostrarInfoJugador(playerid, text[], time) 
{
    KillTimer(SintaxisTiempo[playerid]);
    PlayerTextDrawHide(playerid, SintaxisInfo[playerid]);
    MostrandoSintaxis[playerid] = 1;
    PlayerTextDrawSetString(playerid, SintaxisInfo[playerid], text);
    PlayerTextDrawShow(playerid, SintaxisInfo[playerid]);
    SintaxisTiempo[playerid] = SetTimerEx("CerrarSintaxis", time*1000, false, "i", playerid);
    return 1;
}

forward CerrarSintaxis(playerid);
public CerrarSintaxis(playerid)
{
    if(!IsPlayerConnected(playerid)) return 1;
    PlayerTextDrawHide(playerid, SintaxisInfo[playerid]);
    MostrandoSintaxis[playerid] = 0;
    return 1;
}

stock Sintaxis(playerid, const texto[], tiempo)
{
    new nuevo[120];
    format(nuevo, sizeof(nuevo), "~w~Sintaxis ~y~- ~r~ %s",texto);
    MostrarInfoJugador(playerid, nuevo, tiempo);
    return 1;
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect Hook_OnPlayerDisconnect

#if defined Hook_OnPlayerDisconnect
    forward Hook_OnPlayerDisconnect(playerid, reason);
#endif

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect Hook_OnPlayerConnect

#if defined Hook_OnPlayerConnect
    forward Hook_OnPlayerConnect(playerid);
#endif

