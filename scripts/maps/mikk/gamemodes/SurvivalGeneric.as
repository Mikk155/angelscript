/*	

Survival generic that will prevent from players drop-in Aka dupe weapons
also survival will get enable without the count-down



#include "mikk/gamemodes/SurvivalGeneric"

void MapInit()
{
	Survival_on();
}



*/
#include "../../hunger/leveldead_loadsaved"

void Survival_on()
{
	g_EngineFuncs.CVarSetFloat( "mp_survival_starton", 0 );
	g_EngineFuncs.CVarSetFloat( "mp_survival_startdelay", 0 );
	g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 0 );
	
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "triggerstate", "0" },
        { "delay", "30"},
        { "spawnflags", "1"},
        { "targetname", "game_playerspawn"},
        { "target", "genericsurvival_on" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", keyvalues, true );

    keyvalues =
    {
        { "m_iMode", "1" },
        { "SetType", "0"},
        { "m_iszCVarToChange", "mp_dropweapons"},
        { "message", "1"},
        { "targetname", "genericsurvival_on" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_setcvar", keyvalues, true );

    keyvalues =
    {
        { "m_iMode", "1" },
        { "m_iszScriptFunctionName", "ActivateSurvival"},
        { "targetname", "genericsurvival_on" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_script", keyvalues, true );
}

void ActivateSurvival(CBaseEntity@ pActivator,CBaseEntity@ pCaller, USE_TYPE useType, float flValue)
{
	g_SurvivalMode.Activate();
}