#include <YSI\y_hooks>


#if defined _Schema_Component
    #endinput
#endif
#define _Schema_Component

hook OnGameModeInit()
{


		new MySQLOpt: option_id = mysql_init_options();

		mysql_set_option(option_id, AUTO_RECONNECT, true); // Reconecta automáticamente al perder la conexión.

		g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id); // AUTO_RECONNECT esta activado solo para esta conexión.
		if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
		{
				print("MariaDB: conexión fallida, cerrando Gamemode.");
				SendRconCommand("exit"); // Cierra el servidor si no se estableció conexión con Maria DB
				return 1;
		}
		else
		{
			print("Conexion exitosa con MariaDB");
		}


		return 1;
}
hook OnGameModeExit()
{


	mysql_close(g_SQL);
	print("Cerrando Gamemode, por favor espere...");

	return 1;
}