# Sistema de Sintáxis / SAMP

## Instalación con Composer.

Abre la consola (WIN+R y escribe cmd) y dirigete al directorio raíz de tu proyecto (Ejemplo: `cd C:\Users\Forward\Documents\GitHub\sintaxis`)

Ejecuta el siguiente comando:

`composer require forwarddevs/sintaxis`

## Incluir en Pawn
### Composer Install
`#include "../vendor/forwarddevs/sintaxis/sintaxis.inc"`

### Normal Install
`#include <sintaxis.inc>`

## Uso

`native Sintaxis(playerid, const texto[], tiempo*1000);`

## Ejemplo

	`zcmd(check, playerid, params[])
    {
        if(Info[playerid][pAdmin] < 1) return Permisos(playerid, "Admin 1 o mayor");
        if(!sscanf(params, "d", params[0]))
        {
            if(!IsPlayerConnected(params[0])) return SendClientMessageEx(playerid, COLOR_GRAD2, "Esa ID es inválida.");
            ShowStats(playerid,params[0]);
        }
        else Sintaxis(playerid, "/Check <ID>", 5); // Mostrará la sintáxis por 5 segundos.
        return 1;
    }`