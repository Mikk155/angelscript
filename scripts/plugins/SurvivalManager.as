/********************************************************************************************/
/*																							*/
/*		This plugin will prevent players from farm-dupe weapons	and will suddenly			*/
/*		Enable the Survival-mode with not count-down messages.				 				*/
/*																							*/
/*		Thanks to Outerbeast for the schedoule i had no idea how to do :p					*/
/*		https://github.com/Outerbeast														*/
/*																							*/
/*		Thanks to Incognico for the MapBlackList code. so you can exlude intros				*/
/*		https://github.com/incognico														*/
/*																							*/
/*		Thanks to Gaftherman bc kinda pavo													*/
/*		https://github.com/Gaftherman														*/
/*																							*/
/********************************************************************************************/
bool bEnabled;

const array<string> DISALLOWED_MAPS = { 'sc_tetris*', 'of0a0', 'aom*', 'bm_sts' };

void PluginInit()
{
    g_Module.ScriptInfo.SetAuthor( "Mikk" );
    g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );
}

void MapInit()
{	// Check if map supports survivel if yes. execute next code
    if( g_SurvivalMode.MapSupportEnabled() )
    {
        g_EngineFuncs.CVarSetFloat( "mp_survival_starton", 0 );
        g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 0 );
		// copy the mp_survival_startdelay value
        float flSurvivalStartDelay = g_EngineFuncs.CVarGetFloat( "mp_survival_startdelay" );
		// Temporaly disable survival mode - Outerbeast
        g_SurvivalMode.Disable();
        uint uiCount = 0;

        for( uint i = 0; i < DISALLOWED_MAPS.length(); i++ ) 
        {
        
        bool wildcard = false;
        string tmp = DISALLOWED_MAPS[i];
        
            if ( tmp.SubString( tmp.Length()-1, 1 ) == "*" )
            {
                wildcard = true;
                tmp = tmp.SubString( 0, tmp.Length()-1 );
            }
            
            if ( wildcard )
            {
                if ( tmp == string(g_Engine.mapname).SubString( 0, tmp.Length() ) )
                {
                    uiCount++;
                }
            }
            else if( g_Engine.mapname == DISALLOWED_MAPS[i] )
            {
                uiCount++;
            }
        }

        if( uiCount <= 0 )
            bEnabled = true;
        else
            bEnabled = false;
        
        if( !bEnabled )
        {	// Echo. server console print if failed
            g_PlayerFuncs.ServerPrint( "Survival-mode Disabled.\n" );
			// Return drop weapons if the plugin are disabled
            g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 1 );
        }
        else	// SetTimeOut if map is not on the black list.
        g_Scheduler.SetTimeout( "SurvivalModeEnable", flSurvivalStartDelay );
    }
}

void SurvivalModeEnable()
{
    g_EngineFuncs.CVarSetFloat( "mp_survival_startdelay", 0 );
    g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 1 );
	// Reenable survival mode
    g_SurvivalMode.Activate( true );
    g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "Survival-mode & Player-Drop has been enabled.\n" );

    NetworkMessage message( MSG_ALL, NetworkMessages::SVC_STUFFTEXT );
    message.WriteString( "spk buttons/bell1" );
    message.End();
}