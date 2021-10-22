/*
*	Survival generic for Limitless Potential
*	this script just remove the survival-count-down
*	this prevent players farm weapons for the first seconds
*	and let them be scared about the survival time
*	how to install

#include "mikk/gamemodes/survival"

bool blSurvivalEnable = true; // true = Survival-Mode

void MapInit()
{
	if( blSurvivalEnable )
		Survival_on();
		ActivateCvars(
	);
}
*/
#include "../hunger/leveldead_loadsaved"

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
        { "delay", "30"},
        { "target", "survival_on" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", keyvalues, true );

    keyvalues =
    {
        { "m_iMode", "1" },
        { "SetType", "0"},
        { "m_iszCVarToChange", "mp_dropweapons"},
        { "message", "1"},
        { "targetname", "survival_on" }
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