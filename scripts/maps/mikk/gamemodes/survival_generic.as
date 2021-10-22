/*
*	Survival generic script
*	this script just let server Ops
*	to dis/able survival without modify
*	any cfg file
*	how to install

#include "mikk/gamemodes/survival_generic"

bool blSurvivalEnable = true; // true = Survival-Mode

void MapInit()
{
	if( blSurvivalEnable )
		Survival_on();
		ActivateCvars(
	);
}
*/
#include "../../hunger/leveldead_loadsaved"

void MapStart()
{
	Survival_on();
	g_EngineFuncs.CVarSetFloat( "mp_survival_starton", 0 );
}

void Survival_on()
{
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "triggerstate", "1" },
        { "delay", "1"},
        { "target", "survival_on" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", keyvalues, true );

    keyvalues =
    {
        { "m_iMode", "1" },
        { "m_iszScriptFunctionName", "ActivateSurvival"},
        { "targetname", "survival_on" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_script", keyvalues, true );
}

void ActivateSurvival(CBaseEntity@ pActivator,CBaseEntity@ pCaller, USE_TYPE useType, float flValue)
{
	g_SurvivalMode.Activate();
}