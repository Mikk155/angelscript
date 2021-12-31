/*
	a script for customize difficulty per campaigns.
	this script will write into a .dat file a text. 
	if the text contain a certain word it'll execute
	a .cfg for a whole campaign using this script. 
	you could add there any cvar included skls.
	it is used via trigger_script in a "lobby" map
	call functions "Diff_Easy" "Diff_Medium" "Diff_Hard" "Diff_HardCore"
	a sample how to set up this into a lobby is 
	residualpoint_lobby.bsp at my residual point scmapdb page.

-this script will not generate the files, you need create them first
-important place that files into svencoop/ and NOT svencoop_addon/
-do NOT use quotes " into the cfg files
-do NOT use ; into the cfg files
-hardcore mode will add 1hp to the players. check line 132

*/

string load_diff_file = "scripts/maps/store/campaignname_store.dat";
dictionary dCvars;

void DiffVerify()
{
    File@ file = g_FileSystem.OpenFile(load_diff_file, OpenFile::READ);
    string fileContent, diff_path;

    if( file.IsOpen() )
    {
        file.ReadLine(fileContent);

        if( fileContent == "easy" )
        {
            diff_path = "scripts/maps/store/campaignname_easy.cfg"; 
        }
        else if( fileContent == "medium" ) 
        {
            diff_path = "scripts/maps/store/campaignname_medium.cfg"; 
        }
        else if( fileContent == "hard" ) 
        {
            diff_path = "scripts/maps/store/campaignname_hard.cfg"; 
			
			g_Scheduler.SetTimeout( "ExtraNpc", 2.0f );
        }
        else if( fileContent == "hardcore" ) 
        {
           diff_path = "scripts/maps/store/campaignname_hardcore.cfg";
		   
		   g_Hooks.RegisterHook( Hooks::Player::PlayerSpawn, @PlayerSpawn );
        }
        else
        {
            diff_path = "scripts/maps/store/campaignname_easy.cfg"; // this will be the default cfg used if not selected.
        }

        file.Close();    
    }

    // Take'd from StaticCfg plugin by Outerbeast
    // https://github.com/Outerbeast/Addons/blob/main/StaticCfg.as
    ReadCfg( diff_path );

	array<string> @dCvarsKeys = dCvars.getKeys();
	dCvarsKeys.sortAsc();
	string CvarValue;

	for( uint i = 0; i < dCvarsKeys.length(); ++i )
	{
		dCvars.get( dCvarsKeys[i], CvarValue );
		g_EngineFuncs.CVarSetFloat( dCvarsKeys[i], atof( CvarValue ) );
		g_EngineFuncs.ServerPrint( "StaticCfg: Set CVar " + dCvarsKeys[i] + " " + CvarValue + "\n" );
	}
}

void Diff_Easy( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
{
    File@ file = g_FileSystem.OpenFile(load_diff_file, OpenFile::WRITE);
    string fileContent = "easy";
                
    if( file.IsOpen() )
    {            
        file.Write( fileContent );    
        file.Close();
    }
}

void Diff_Medium( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
{
    File@ file = g_FileSystem.OpenFile(load_diff_file, OpenFile::WRITE);
    string fileContent = "medium";
                
    if( file.IsOpen() )
    {            
        file.Write( fileContent );    
        file.Close();
    }
}

void Diff_Hard( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
{
    File@ file = g_FileSystem.OpenFile(load_diff_file, OpenFile::WRITE);
    string fileContent = "hard";
                
    if( file.IsOpen() )
    {            
        file.Write( fileContent );    
        file.Close();
    }
}

void Diff_HardCore( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
{
    File@ file = g_FileSystem.OpenFile(load_diff_file, OpenFile::WRITE);
    string fileContent = "hardcore";
                
    if( file.IsOpen() )
    {            
        file.Write( fileContent );    
        file.Close();
    }
}

HookReturnCode PlayerSpawn(CBasePlayer@ pPlayer)
{
    pPlayer.pev.health = 1;
    pPlayer.pev.max_health = 1;
    pPlayer.pev.armortype = 5;

    return HOOK_CONTINUE;
}

void ReadCfg( string diff )
{
	File@ pFile = g_FileSystem.OpenFile( diff, OpenFile::READ );

	if( pFile !is null && pFile.IsOpen() )
	{
		while( !pFile.EOFReached() )
		{
			string sLine;
			pFile.ReadLine( sLine );
			if( sLine.SubString(0,1) == "#" || sLine.IsEmpty() )
				continue;

			array<string> parsed = sLine.Split( " " );
			if( parsed.length() < 2 )
				continue;

			dCvars[parsed[0]] = parsed[1];
		}
		pFile.Close();
	}
}