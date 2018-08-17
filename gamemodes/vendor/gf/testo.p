public OnGameModeInit()
{
	print("Test 2");
	#if defined Hok_OnGameModeInit
        return Hok_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif

#define OnGameModeInit Hok_OnGameModeInit

#if defined Hok_OnGameModeInit
    forward Hok_OnGameModeInit();
#endif