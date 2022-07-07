/********************************************************************************************************************************************************/
/*																			*/
/*		This plugin will prevent players from farm-dupe weapons	and will suddenly								*/
/*		Enable the Survival-mode with not count-down messages.				 							*/
/*		this plugin will check if survival is supported. how many time it take to get on.							*/
/*		if mp_dropweapons are enabled or disabled. and if the map is not on the blacklist							*/
/*		and check if conditions are meet													*/
/*																			*/
/*		Special Thanks to: 															*/
/*		Outerbeast for scripting support													*/
/*		https://github.com/Outerbeast														*/
/*																			*/
/*		Incognico for Black-List code														*/
/*		https://github.com/incognico														*/
/*																			*/
/*		Gaftherman for scripting support													*/
/*		https://github.com/Gaftherman														*/
/*																			*/
/*		MapScript version https://github.com/Mikk155/angelscript/blob/main/maps/Survivalmode.as							*/
/********************************************************************************************************************************************************/

/*
	Add here the maps you don't want this plugin to be enabled. use * at the end to specif a mapseries                   
	this is not really needed, this script will see if the map supports and have survival mode enabled.
	but in case you want to *anyways* disable this
*/

const array<string> DISALLOWED_MAPS = 
{ 
	"hcl_*",
	"infested*", 
	"sc_*", 
	"aom*"
};

void PluginInit()
{
    g_Module.ScriptInfo.SetAuthor( "Mikk" );
    g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );
}

void MapInit()
{
	const bool bSurvivalEnabled = g_EngineFuncs.CVarGetFloat("mp_survival_starton") == 1 && g_EngineFuncs.CVarGetFloat("mp_survival_supported") == 1;

	const bool bDropWeapEnabled = g_EngineFuncs.CVarGetFloat("mp_dropweapons") == 1;

	bool bEnabled;

	uint uiCount = 0;

	for( uint i = 0; i < DISALLOWED_MAPS.length(); i++ ) 
	{
		bool wildcard = false;
		string tmp = DISALLOWED_MAPS[i];
        
	if( tmp.SubString( tmp.Length()-1, 1 ) == "*" )
	{
		wildcard = true;
		tmp = tmp.SubString( 0, tmp.Length()-1 );
	}
            
		if( wildcard )
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
        
	if( bEnabled ) // SetTimeOut if map is not on the black list.
	{
		float flSurvivalStartDelay = g_EngineFuncs.CVarGetFloat( "mp_survival_startdelay" );
	
		if( bSurvivalEnabled )
		{
			g_SurvivalMode.Disable();
			g_Scheduler.SetTimeout( "SurvivalModeEnable", flSurvivalStartDelay );
			g_EngineFuncs.CVarSetFloat( "mp_survival_startdelay", 0 );
			g_EngineFuncs.CVarSetFloat( "mp_survival_starton", 0 );
			g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 0 );
		}
		
		if( bDropWeapEnabled )
		{
			g_Scheduler.SetTimeout( "Dropenabled", flSurvivalStartDelay );
			g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 0 );
		}
	}
}

void SurvivalModeEnable()
{
    g_SurvivalMode.Activate( true );
    NetworkMessage message( MSG_ALL, NetworkMessages::SVC_STUFFTEXT );
    message.WriteString( "spk buttons/bell1" );
    message.End();
}

void Dropenabled()
{
    g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 1 );
}
