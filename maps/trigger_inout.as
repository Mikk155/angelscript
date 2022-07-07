/*Original Script by Cubemath*/
/*
	I'm not really sure how this is supposed to work with more than 1 player. probably this seems obsolete for now but
	for only one player this is working fine for enable a squadmaker for spawn enemies when the player is far 
	outside this zone and turning them off when the player is near it
	the idea comes from SoHL but i didn't even tried that entity. so i literally did what i think it does
	as far as i know, this is only useful for what i have mention.
*/
enum trigger_once_flag
{
    SF_START_OFF = 1 << 0,
}

class trigger_inout : ScriptBaseEntity
{
	private USE_TYPE m_flTriggerTypeOut = USE_TOGGLE; // State to send TOGGLE/ON/OFF/KILL
	private USE_TYPE m_flTriggerTypeIn = USE_TOGGLE; // State to send TOGGLE/ON/OFF/KILL
	private float m_flDelay = 0.0f; // delay before trigger his target.
	private float m_flDelayIn = 0.0f; // delay before trigger his target.
	
	bool KeyValue( const string& in szKey, const string& in szValue ) 
	{
		if( szKey == "minhullsize" ) 
		{
			g_Utility.StringToVector( self.pev.vuser1, szValue );
			return true;
		} 
		else if( szKey == "maxhullsize" ) 
		{
			g_Utility.StringToVector( self.pev.vuser2, szValue );
			return true;
		}
        else if( szKey == "SendStateOut" )
		{
            string m_flValue = szValue;

			if( m_flValue == "USE_OFF" )
			{
				m_flTriggerTypeOut = USE_OFF;
			}
			else if( m_flValue == "USE_ON" )
			{
				m_flTriggerTypeOut = USE_ON;	
			}
			else if( m_flValue == "USE_TOGGLE" )
			{
				m_flTriggerTypeOut = USE_TOGGLE;	
			}
			else if( m_flValue == "USE_KILL" )
			{
				m_flTriggerTypeOut = USE_KILL;	
			}

			return true;
		}
        else if( szKey == "SendStateIn" )
		{
            string m_flValue = szValue;

			if( m_flValue == "USE_OFF" )
			{
				m_flTriggerTypeIn = USE_OFF;
			}
			else if( m_flValue == "USE_ON" )
			{
				m_flTriggerTypeIn = USE_ON;	
			}
			else if( m_flValue == "USE_TOGGLE" )
			{
				m_flTriggerTypeIn = USE_TOGGLE;	
			}
			else if( m_flValue == "USE_KILL" )
			{
				m_flTriggerTypeIn = USE_KILL;	
			}

			return true;
		}
        else if( szKey == "delay" )
		{
            m_flDelay = atof( szValue );
			return true;
		}
        else if( szKey == "delayIn" )
		{
            m_flDelayIn = atof( szValue );
			return true;
		}
		else 
			return BaseClass.KeyValue( szKey, szValue );
	}
	
	void Spawn() 
	{
        self.Precache();

        self.pev.movetype = MOVETYPE_NONE;
        self.pev.solid = SOLID_NOT;

        if( self.GetClassname() == "trigger_inout" && string( self.pev.model )[0] == "*" && self.IsBSPModel() )
        {
            g_EntityFuncs.SetModel( self, self.pev.model );
            g_EntityFuncs.SetSize( self.pev, self.pev.mins, self.pev.maxs );
        }
		else
		{
			g_EntityFuncs.SetSize( self.pev, self.pev.vuser1, self.pev.vuser2 );		
		}

		g_EntityFuncs.SetOrigin( self, self.pev.origin );

        BaseClass.Spawn();
		
        if( !self.pev.SpawnFlagBitSet( SF_START_OFF ) )
		{	
			SetThink( ThinkFunction( this.TriggerThink ) );
			self.pev.nextthink = g_Engine.time + 0.1f;
		}
	}

    void Use(CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float value)
    {
        if( self.pev.SpawnFlagBitSet( SF_START_OFF ) )
		{	
			SetThink( ThinkFunction( this.TriggerThink ) );
			self.pev.nextthink = g_Engine.time + 0.1f;
		}
	}
	
	void TriggerThink() {
		for( int iPlayer = 1; iPlayer <= g_PlayerFuncs.GetNumPlayers(); ++iPlayer ){
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

			if( pPlayer is null || !pPlayer.IsConnected() || !pPlayer.IsAlive() )
				continue;

			if( Inside( pPlayer ) ){
				self.SUB_UseTargets( @self, m_flTriggerTypeIn, m_flDelayIn );
				SetThink( ThinkFunction( this.previusthink ) );
				self.pev.nextthink = g_Engine.time + 0.1f;
			}
			else
			self.pev.nextthink = g_Engine.time + 0.1f;
		}
	}
	
	void previusthink(){
		for( int iPlayer = 1; iPlayer <= g_PlayerFuncs.GetNumPlayers(); ++iPlayer ){
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );

			if( pPlayer is null || !pPlayer.IsConnected() || !pPlayer.IsAlive() )
				continue;
			// maybe this is inside and not outside? so much things to test and so much desire to sleep -El hombre R
			if( !Inside( pPlayer ) ){
				self.SUB_UseTargets( @self, m_flTriggerTypeOut, m_flDelay );
				SetThink( ThinkFunction( this.TriggerThink ) );
				self.pev.nextthink = g_Engine.time + 0.1f;
			}
			else
			self.pev.nextthink = g_Engine.time + 0.1f;
		}
	}

	bool Inside(CBasePlayer@ pPlayer)
	{
		bool a = true;
		a = a && pPlayer.pev.origin.x + pPlayer.pev.maxs.x >= self.pev.origin.x + self.pev.mins.x;
		a = a && pPlayer.pev.origin.y + pPlayer.pev.maxs.y >= self.pev.origin.y + self.pev.mins.y;
		a = a && pPlayer.pev.origin.z + pPlayer.pev.maxs.z >= self.pev.origin.z + self.pev.mins.z;
		a = a && pPlayer.pev.origin.x + pPlayer.pev.mins.x <= self.pev.origin.x + self.pev.maxs.x;
		a = a && pPlayer.pev.origin.y + pPlayer.pev.mins.y <= self.pev.origin.y + self.pev.maxs.y;
		a = a && pPlayer.pev.origin.z + pPlayer.pev.mins.z <= self.pev.origin.z + self.pev.maxs.z;

		if(a)
			return true;
		else
			return false;
	}
}

void RegisterTriggerInOut() 
{
	g_CustomEntityFuncs.RegisterCustomEntity( "trigger_inout", "trigger_inout" );
}