/* To add components use "composer require autor/component" */
#if defined AUTH_ENABLED
	#if AUTH_ENABLED==1
		#include <YSI\y_hooks>
		#include "../vendor/forwarddevs/login/login.p"
	#endif
#endif
#if defined LEVELS_ENABLED
	#if LEVELS_ENABLED==1
		#include <YSI\y_hooks>
		#include "../vendor/forwarddevs/levels/levels.p"
	#endif
#endif
#if defined INVENTORY_ENABLED
	#if INVENTORY_ENABLED==1
		#include <YSI\y_hooks>
		#include "../vendor/forwarddevs/inventory/inventory.p"
	#endif
#endif
#if defined ACTORS_ENABLED
	#if ACTORS_ENABLED==1
		#include <YSI\y_hooks>
		#include "../vendor/forwarddevs/actors/actors.p"
	#endif
#endif