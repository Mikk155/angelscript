/********************************************************************************************/
/*																							*/
/*		This plugin will prevent players from farm-dupe weapons	and will suddenly			*/
/*		Enable the Survival-mode with not count-down messages.				 				*/
/*		Thanks to Outerbeast for the schedoule i had no idea how to do :p					*/
/*		Thanks to Incognico for the MapBlackList code. so you can exlude intros				*/
/*																							*/
/********************************************************************************************/
bool bEnabled;

const array<string> DISALLOWED_MAPS = { 'sc_tetris*', 'of0a0', 'aom*', 'bm_sts' };

void PluginInit()
{
    g_Module.ScriptInfo.SetAuthor( "Mikk" );
    g_Module.ScriptInfo.SetContactInfo( "please no" );
}

void MapInit()
{
    g_EngineFuncs.CVarSetFloat( "mp_survival_starton", 0 );
    g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 0 );
    float flSurvivalStartDelay = g_EngineFuncs.CVarGetFloat( "mp_survival_startdelay" ); // copy the mp_survival_startdelay value
    g_SurvivalMode.Disable(); // Temporarily disable survival mode - Outerbeast
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
	{
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTNOTIFY, "Survival-mode Disabled.\n" );
		g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 1 );
	}
	else
    g_Scheduler.SetTimeout( "SurvivalModeVoteEnd", flSurvivalStartDelay ); // Schedule activation of survival mode after delay period
}

void SurvivalModeVoteEnd()
{
    g_EngineFuncs.CVarSetFloat( "mp_survival_startdelay", 0 );
    g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 1 );
    g_SurvivalMode.Enable( true ); // Reenable survival mode
    g_PlayerFuncs.ClientPrintAll( HUD_PRINTNOTIFY, "Survival-mode & Player-Drop has been enabled.\n" );

    NetworkMessage message( MSG_ALL, NetworkMessages::SVC_STUFFTEXT );
    message.WriteString( "spk buttons/bell1" );
    message.End();
}