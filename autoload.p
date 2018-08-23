
/* To add components use "composer require autor/component" */
#if defined AUTH_ENABLED
	#if AUTH_ENABLED==1
		#include "../vendor/forwarddevs/login/login.p"
	#endif
#endif
#if defined LEVELS_ENABLED
	#if LEVELS_ENABLED==1
		#include "../vendor/forwarddevs/levels/levels.p"
	#endif
#endif
#if defined INVENTORY_ENABLED
	#if INVENTORY_ENABLED==1
		#include "../vendor/forwarddevs/inventory/inventory.p"
	#endif
#endif
#if defined ACTORS_ENABLED
	#if ACTORS_ENABLED==1
		#include "../vendor/forwarddevs/actors/actors.p"
	#endif
#endif
#if defined SINTAXIS_ENABLED
	#if SINTAXIS_ENABLED==1
		#include "../vendor/forwarddevs/sintaxis/sintaxis.p"
	#endif
#endif

#if defined ADMIN_ENABLED
	#if ADMIN_ENABLED==1
		#include "../vendor/forwarddevs/admin/cmds.p"
	#endif
#endif

#if defined PLAYERCMDS_ENABLED
	#if PLAYERCMDS_ENABLED==1
		
		#include "../vendor/forwarddevs/playercmds/pcmds.p"
	#endif
#endif

#if defined SAFEZONE_ENABLED
	#if SAFEZONE_ENABLED==1
		#include "../vendor/forwarddevs/safezone/safezone.p"
	#endif
#endif
