/********************************************************************************************/
/*																							*/
/*		This plugin will Remove players Crosshairs											*/
/*																							*/
/*		Thanks to Incognico for the MapBlackList code										*/
/*		https://github.com/incognico														*/
/*																							*/
/********************************************************************************************/
bool bEnabled;

// Add here the maps that you want this plugin be enabled -mikk
const array<string> ALLOWED_MAPS = { 'hl_*', 'ba_*', 'of*', 'infested', 'ofhlv9_c*', 'hlcs_*', 'ins2_*', 'tronal_pinger' };

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Mikk" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );
}

void MapInit()
{
     uint uiCount = 0;

	for( uint i = 0; i < ALLOWED_MAPS.length(); i++ ) 
	{
        
	bool wildcard = false;
	string tmp = ALLOWED_MAPS[i];
        
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
		else if( g_Engine.mapname == ALLOWED_MAPS[i] )
		{
			uiCount++;
		}
	}

	if( uiCount <= 0 )
	bEnabled = true;
	else
		bEnabled = false;
        
	if( !bEnabled )
	{	// Register Hook ONLY if the map is on the whitelist
		g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @croshair_PPreThink );
	}
}

HookReturnCode croshair_PPreThink( CBasePlayer@ pPlayer, uint& out uiFlags )
{
	NetworkMessage msg(MSG_ONE, NetworkMessages::SVC_STUFFTEXT, pPlayer.edict());
		msg.WriteString("crosshair 0");
	msg.End();

    return HOOK_CONTINUE;
}