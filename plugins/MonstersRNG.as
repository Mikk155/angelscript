const array<string> ALLOWED_MAPS = 
{ 
	"hcl_*",
	"of*",
	"hl_c*",
	"ins2_*",
	"tunnelvision*",
	"sc_persia",
	"infested"
};

void PluginInit()
{
    g_Module.ScriptInfo.SetAuthor( "Mikk" );
    g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );
}

void MapInit()
{
	float flSurvivalStartDelay = g_EngineFuncs.CVarGetFloat( "mp_survival_startdelay" );
	
	bool bEnabled;

	uint uiCount = 0;

	for( uint i = 0; i < ALLOWED_MAPS.length(); i++ ) 
	{
		bool wildcard = false;
		string tmp = ALLOWED_MAPS[i];
        
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
	{
		g_Scheduler.SetTimeout( "EnableRoam", flSurvivalStartDelay );
	}
}

void EnableRoam()
{
    CBaseEntity@ pEntity = null;
    while( (	@pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_*" ) ) !is null )
	{
        g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "freeroam", "2" );
    }
	g_PlayerFuncs.ClientPrintAll(HUD_PRINTNOTIFY, "Npcs will start scaning for enemies.\n");
}