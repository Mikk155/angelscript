/********************************************************************************************/
/*																							*/
/*			This plugin will let players to use Zoom IN-OUT									*/
/*																							*/
/********************************************************************************************/

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Mikk" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );
	
	g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @PlayerZoom::PlayerZoom );
}

bool m_fInZoom;

// Kerncore code: https://github.com/KernCore91/Random-Sven-Co-op-Plugins/blob/main/scripts/plugins/kern/PlayerSpeedFix.as
namespace PlayerZoom
{

	
HookReturnCode PlayerZoom( CBasePlayer@ pPlayer, uint& out uiFlags )
{
	CBasePlayer@ pSetter = null;
	
	if( pPlayer is null )
		return HOOK_CONTINUE;

	if( pPlayer.pev.flags & FL_ONGROUND != 0 && (pPlayer.m_afButtonLast & IN_USE != 0 || pPlayer.m_afButtonPressed & IN_USE != 0) )
	{
		pPlayer.pev.fov != 10;
		m_fInZoom = true;
        pPlayer.pev.fov = pPlayer.m_iFOV = 10;
	}
	else if( pPlayer.m_afButtonReleased & IN_USE != 0 )
	{
		pPlayer.pev.fov != 0;
		m_fInZoom = false;
		pPlayer.pev.fov = pPlayer.m_iFOV = 0;
	}

	return HOOK_CONTINUE;
}

}