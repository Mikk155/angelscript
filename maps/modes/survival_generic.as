/* Survival generic for Limitless Potential's campaigns.
this script just remove the survival-count-down and prevent players
farm weapons for the first seconds*/
#include "hunger/leveldead_loadsaved"

void MapStart()
{
	Survival_on();
	ActivateCvars();
}

void Survival_on()
{
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "triggerstate", "1" },
        { "delay", "20"},
        { "target", "survival_on_relay" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", keyvalues, true );

    keyvalues =
    {
        { "triggerstate", "0" },
        { "delay", "10"},
        { "target", "survival_on"},
        { "targetname", "survival_on_relay" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", keyvalues, true );

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
        { "message", "Drop weapons enabled\nSurvival will start in a few seconds"},
        { "channel", "1"},
        { "targetname", "survival_on_relay" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "game_text", keyvalues, true );

    keyvalues =
    {
        { "m_iMode", "1" },
        { "SetType", "0"},
        { "m_iszCVarToChange", "mp_dropweapons"},
        { "message", "1"},
        { "targetname", "survival_on_relay" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_setcvar", keyvalues, true );

    keyvalues =
    {
        { "m_iMode", "1" },
        { "m_iszScriptFunctionName", "ActivateSurvival"},
        { "targetname", "survival_on" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_script", keyvalues, true );
}

void ActivateCvars();
{
	g_EngineFuncs.CVarSetFloat( "mp_survival_starton", 0 );
	g_EngineFuncs.CVarSetFloat( "mp_survival_startdelay", 0 );
	g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 0 );
}

void ActivateSurvival(CBaseEntity@ pActivator,CBaseEntity@ pCaller, USE_TYPE useType, float flValue)
{
	g_SurvivalMode.Activate();
}