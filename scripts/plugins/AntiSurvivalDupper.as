const Cvar@ g_GetValueRDelay;

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Mikk" );
	g_Module.ScriptInfo.SetContactInfo( "please no" );

	@g_GetValueRDelay = g_EngineFuncs.CVarGetPointer( "mp_survival_startdelay" );		// copy the mp_survival_startdelay value
	SurvivalModeVoteEnd();	// add the mp_survival_startdelay value
	g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 0 );
}

void SurvivalModeVoteEnd()
{
	g_PlayerFuncs.ClientPrintAll( HUD_PRINTNOTIFY, "Survival-mode & Player-Drop has been enabled.\n" );
	g_EngineFuncs.CVarSetFloat( "mp_survival_startdelay", 0 );
	g_EngineFuncs.CVarSetFloat( "mp_dropweapons", 1 );
	g_SurvivalMode.Activate();

	NetworkMessage message( MSG_ALL, NetworkMessages::SVC_STUFFTEXT );
	message.WriteString( "spk buttons/bell1" );
	message.End();
}