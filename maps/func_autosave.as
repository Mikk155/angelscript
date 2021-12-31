// Idk que xuxa haces leyendo esto.

enum FuncAutoSaveFlags
{
	SF_AUTOSAVE_OFF	= 1 << 0
}

class func_autosave : ScriptBaseEntity  
{
    dictionary g_OriginPlayers, g_IDPlayers, g_IDPlayers2;
	Vector PrimerSpawn, SegundoSpawn, TercerSpawn, CuartoSpawn;

	bool KeyValue( const string& in szKey, const string& in szValue )
	{
		if( szKey == "PrimerSpawn" )
		{
			g_Utility.StringToVector( PrimerSpawn, szValue );
			return true;
		}
		else if( szKey == "SegundoSpawn" )
		{
			g_Utility.StringToVector( SegundoSpawn, szValue );
			return true;
		}
		else if( szKey == "TercerSpawn" )
		{
			g_Utility.StringToVector( TercerSpawn, szValue );
			return true;
		}
		else if( szKey == "CuartoSpawn" )
		{
			g_Utility.StringToVector( CuartoSpawn, szValue );
			return true;
		}
		else
			return BaseClass.KeyValue( szKey, szValue );
	}

    void Spawn()
    {
		self.pev.movetype = MOVETYPE_NONE;
		self.pev.solid = SOLID_TRIGGER;

		g_EntityFuncs.SetModel( self, self.pev.model );
		g_EntityFuncs.SetSize( self.pev, self.pev.mins, self.pev.maxs );
		g_EntityFuncs.SetOrigin( self, self.pev.origin );

		self.pev.effects |= EF_NODRAW;

		if( self.pev.SpawnFlagBitSet( SF_AUTOSAVE_OFF ) )
		{
			SetThink( null );
			SetTouch( null );
		}
		else
		{
			SetThink( ThinkFunction( this.SpawnThink ) );
			SetTouch( TouchFunction( this.SpawnTouch ) );
			self.pev.nextthink = g_Engine.time + 0.1f;
		}

	    BaseClass.Spawn();
    }

	void AddPlayer( CBasePlayer@ pPlayer )
	{	
        string SteamID = g_EngineFuncs.GetPlayerAuthId(pPlayer.edict());

        if( pPlayer is null || g_IDPlayers.exists(SteamID) || g_IDPlayers2.exists(SteamID)  )
			return;

        g_IDPlayers[SteamID] = @pPlayer;

        g_Game.AlertMessage( at_console, "SteamID ha sido añadido \n" );
    }

    void Use(CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue = 0.0f)
    {
		if( self.pev.SpawnFlagBitSet( SF_AUTOSAVE_OFF ) )
		{
			SetThink( ThinkFunction( this.SpawnThink ) );
			SetTouch( TouchFunction( this.SpawnTouch ) );

			self.pev.nextthink = g_Engine.time + 0.1f;
		}
	}

	void SpawnTouch( CBaseEntity@ pOther )
	{
		if( pOther is null || !pOther.IsPlayer() || !pOther.IsAlive() )
			return;
				
		AddPlayer( cast<CBasePlayer@>( pOther ) );
	}

	void SpawnThink()
	{	
		array<Vector> Spawns = { PrimerSpawn, SegundoSpawn, TercerSpawn, CuartoSpawn };

		for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

			if( pPlayer is null or !pPlayer.IsConnected() )
				continue;

            string SteamID = g_EngineFuncs.GetPlayerAuthId(pPlayer.edict());

			if( g_IDPlayers.exists(SteamID) && !pPlayer.IsAlive() && pPlayer.GetObserver().IsObserver() )
            {
                //Revive player and move to this checkpoint
				pPlayer.GetObserver().RemoveDeadBody();

				if( Spawns[0] != Vector(0,0,0) && Spawns[1] != Vector(0,0,0) && Spawns[2] != Vector(0,0,0) && Spawns[3] != Vector(0,0,0) )
					pPlayer.SetOrigin( Spawns[Math.RandomLong( 0, 3 )] );
				else if( Spawns[0] != Vector(0,0,0) && Spawns[1] != Vector(0,0,0) && Spawns[2] != Vector(0,0,0) && Spawns[3] == Vector(0,0,0) )
					pPlayer.SetOrigin( Spawns[Math.RandomLong( 0, 2 )] );
				else if( Spawns[0] != Vector(0,0,0) && Spawns[1] != Vector(0,0,0) && Spawns[2] == Vector(0,0,0) && Spawns[3] == Vector(0,0,0) )
					pPlayer.SetOrigin( Spawns[Math.RandomLong( 0, 1 )] );
				else if( Spawns[0] != Vector(0,0,0) && Spawns[1] == Vector(0,0,0) && Spawns[2] == Vector(0,0,0) && Spawns[3] == Vector(0,0,0) )
					pPlayer.SetOrigin( Spawns[0] );
				else
					pPlayer.SetOrigin( self.Center() );

				pPlayer.Revive();

				g_Game.AlertMessage( at_console, "Player: | " + pPlayer.pev.netname + " | ha sido respawneado \n" );
		
				g_IDPlayers2[SteamID] = @pPlayer;
				g_IDPlayers.delete(SteamID);
            }
        }
        
        self.pev.nextthink = g_Engine.time + 0.1f; //per frame
    }
}

void RegisterTriggerPlayerSaveFunc() 
{
	g_CustomEntityFuncs.RegisterCustomEntity( "func_autosave", "func_autosave" );
}