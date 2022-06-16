/*
	Custom Survival mode with dupe AKA "Ammo duplication" fixed for survival mode.
	also will enable the survival mode without countdown messages (suddenly start) After the "mp_survival_startdelay" time passed
	this is automatically and the script will check if the map/server cvars bellow is in true (1) otherwise this script wont do anything.
	Plugin version https://github.com/Mikk155/angelscript/blob/main/plugins/SurvivalDeluxe.as
	
	Credits:
	Mikk Script
	Outerbeast for help
	Gaftherman for help
*/
const bool bSurvivalEnabled = g_EngineFuncs.CVarGetFloat("mp_survival_starton") == 1 && g_EngineFuncs.CVarGetFloat("mp_survival_supported") == 1;

const bool bDropWeapEnabled = g_EngineFuncs.CVarGetFloat("mp_dropweapons") == 1;

float flSurvivalStartDelay = g_EngineFuncs.CVarGetFloat( "mp_survival_startdelay" );

void SurvivalMode() // Register this
{
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
