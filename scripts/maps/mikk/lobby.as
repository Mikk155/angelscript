// Plugin ported by Outerbeast. version map script
const string strWelcomeModel = "models/lobby.mdl"; //-name of the motd V_ view model 

void MapInit()
{
	g_Hooks.RegisterHook( Hooks::Player::PlayerSpawn, @DrawGordonAnimation );
	g_Game.PrecacheModel( strWelcomeModel );
	CreateMusic();
	PrecacheSound( SoundsZzz );
}

const array<string> SoundsZzz = 
{
    "mikk/motd/central_fbi.mp3",
    "mikk/motd/coshunie.mp3",
    "mikk/motd/deny.mp3",
    "mikk/motd/themarias.mp3"
};

// Precaches an array of sounds
void PrecacheSound( const array<string> pSound )
{
    for( uint i = 0; i < pSound.length(); i++ )
    {
        g_SoundSystem.PrecacheSound( pSound[i] );
        g_Game.PrecacheGeneric( "sound/" + pSound[i] );
    }
}

HookReturnCode DrawGordonAnimation(CBasePlayer@ pPlayer)
{
	if( pPlayer !is null )
	{
		pPlayer.pev.viewmodel = strWelcomeModel;
	}
	
	return HOOK_CONTINUE;
}

void CreateMusic();
{
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "triggerstate", "1" },
        { "delay", "4"},
        { "target", "enable_trigger_random" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", keyvalues, true );

    keyvalues =
    {
        { "target1", "enable_music_1" },
        { "target2", "enable_music_2"},
        { "target3", "enable_music_3"},
        { "target4", "enable_music_4"},
        { "max_delay", "5.0"},
        { "min_delay", "3.0"},
        { "target_count", "4"},
        { "targetname", "enable_trigger_random" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_random", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "1" },
        { "x", "-1"},
        { "y", "0.67"},
        { "effect", "2"},
        { "color", "255 0 255"},
        { "color2", "0 255 0"},
        { "fadein", "0.01"},
        { "fadeout", "0.01"},
        { "holdtime", "10.0"},
        { "fxtime", "0.01"},
        { "message", "Song name: Central FBI: Me cohi a mi abuelo"},
        { "channel", "1"},
        { "targetname", "enable_music_1" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "game_text", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "3" },
        { "message", "mikk/motd/central_fbi.mp3"},
        { "volume", "10"},
        { "targetname", "enable_music_1" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "ambient_music", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "1" },
        { "x", "-1"},
        { "y", "0.67"},
        { "effect", "2"},
        { "color", "255 0 255"},
        { "color2", "0 255 0"},
        { "fadein", "0.01"},
        { "fadeout", "0.01"},
        { "holdtime", "10.0"},
        { "fxtime", "0.01"},
        { "message", "Song name: Co Shu Nie: Fool in a tank"},
        { "channel", "1"},
        { "targetname", "enable_music_2" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "game_text", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "3" },
        { "message", "mikk/motd/coshunie.mp3"},
        { "volume", "10"},
        { "targetname", "enable_music_2" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "ambient_music", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "1" },
        { "x", "-1"},
        { "y", "0.67"},
        { "effect", "2"},
        { "color", "255 0 255"},
        { "color2", "0 255 0"},
        { "fadein", "0.01"},
        { "fadeout", "0.01"},
        { "holdtime", "10.0"},
        { "fxtime", "0.01"},
        { "message", "Song name: DENY: aire"},
        { "channel", "1"},
        { "targetname", "enable_music_3" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "game_text", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "3" },
        { "message", "mikk/motd/deny.mp3"},
        { "volume", "10"},
        { "targetname", "enable_music_3" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "ambient_music", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "1" },
        { "x", "-1"},
        { "y", "0.67"},
        { "effect", "2"},
        { "color", "255 0 255"},
        { "color2", "0 255 0"},
        { "fadein", "0.01"},
        { "fadeout", "0.01"},
        { "holdtime", "10.0"},
        { "fxtime", "0.01"},
        { "message", "Song name: The Marias: Pop it up"},
        { "channel", "1"},
        { "targetname", "enable_music_4" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "game_text", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "3" },
        { "message", "mikk/motd/themarias.mp3"},
        { "volume", "10"},
        { "targetname", "enable_music_4" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "ambient_music", keyvalues, true );
}