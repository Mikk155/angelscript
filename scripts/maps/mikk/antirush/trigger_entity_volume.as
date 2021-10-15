enum entity_zone_flags
{
	IGNORE_DEAD 	= 1 << 0,
	START_INACTIVE 	= 1 << 1
}

class trigger_entity_volume : ScriptBaseEntity
{
	private string strInTarget, strOutTarget;
	private uint iInCount, iOutCount, iMaxCount = 128;
	private Vector vecZoneCornerMin, vecZoneCornerMax;
	private float flZoneRadius = 256;
	private bool blActivated = true;

	bool KeyValue(const string& in szKey, const string& in szValue)
	{
		if( szKey == "intarget" )
			strInTarget = szValue;
		else if( szKey == "outtarget" )
			strOutTarget = szValue;
		else if( szKey == "incount" )
			iInCount = atoui( szValue );
		else if( szKey ==  "outcount" )
			iOutCount = atoui( szValue );
		else if( szKey ==  "maxcount" )
			iMaxCount = atoui( szValue );
		else if( szKey == "zoneradius" )
            flZoneRadius = Math.clamp( 16.0f, 2048.0f, atof( szValue ) );
		else if( szKey == "zonecornermin" )
            g_Utility.StringToVector( vecZoneCornerMin, szValue );
        else if( szKey == "zonecornermax" )
			g_Utility.StringToVector( vecZoneCornerMax, szValue );
        else
            return BaseClass.KeyValue( szKey, szValue );

		return true;
	}

	void Spawn()
    {
        self.pev.movetype   = MOVETYPE_NONE;
        self.pev.solid      = SOLID_NOT;
        self.pev.effects    |= EF_NODRAW;
        g_EntityFuncs.SetOrigin( self, self.pev.origin );

		blActivated = !self.pev.SpawnFlagBitSet( START_INACTIVE );

		BaseClass.Spawn();
    }

	void Use(CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue)
	{
		if( !blActivated )
		{
			blActivated = true;
			return;
		}

		array<CBaseEntity@> P_ENTITIES( iMaxCount );
		int iNumEntities = g_EntityFuncs.Instance( 0 ).FindMonstersInWorld( @P_ENTITIES, FL_CLIENT | FL_MONSTER );
		
		if( iNumEntities < 1 )
			return;

		uint iEntitiesInZone = 0, iEntitiesOutZone = 0;

		for( uint i = 0; i < P_ENTITIES.length(); i++ )
		{
			if( P_ENTITIES[i] is null || ( self.pev.SpawnFlagBitSet( IGNORE_DEAD ) && !P_ENTITIES[i].IsAlive() ) )
				continue;

			if( FIsInZone( P_ENTITIES[i] ) )
			{
				iEntitiesInZone++;

				if( iInCount > 0 && iEntitiesInZone < iInCount )
					continue;

				if( strInTarget != "" && strInTarget != self.GetTargetname() )
					g_EntityFuncs.FireTargets( strInTarget, P_ENTITIES[i], pActivator, useType, 0.0f );
			}
			else
			{
				iEntitiesOutZone++;

				if( iOutCount > 0 && iEntitiesOutZone < iOutCount )
					continue;

				if( strOutTarget != "" && strOutTarget != self.GetTargetname() )
					g_EntityFuncs.FireTargets( strOutTarget, P_ENTITIES[i], pActivator, useType, 0.0f );
			}
		}

		self.pev.health = iEntitiesInZone;
		self.pev.frags = iEntitiesOutZone;
	}

	bool FIsInZone(EHandle hEntity)
	{
		if( !hEntity )
			return false;

		if( vecZoneCornerMin != g_vecZero && vecZoneCornerMax != g_vecZero && vecZoneCornerMin != vecZoneCornerMax )
			return EntityInBounds( hEntity, vecZoneCornerMin, vecZoneCornerMax );
		else
			return EntityInRadius( hEntity, self.GetOrigin(), flZoneRadius );
	}

	bool EntityInBounds(EHandle hEntity, Vector vecAbsMin, Vector vecAbsMax)
	{
		if( !hEntity )
			return false;

		return ( hEntity.GetEntity().GetOrigin().x >= vecAbsMin.x && hEntity.GetEntity().GetOrigin().x <= vecAbsMax.x )
			&& ( hEntity.GetEntity().GetOrigin().y >= vecAbsMin.y && hEntity.GetEntity().GetOrigin().y <= vecAbsMax.y )
			&& ( hEntity.GetEntity().GetOrigin().z >= vecAbsMin.z && hEntity.GetEntity().GetOrigin().z <= vecAbsMax.z );
	}

	bool EntityInRadius(EHandle hEntity, Vector vecOrigin, float flRadius)
	{
		if( !hEntity || flRadius <= 0 )
			return false;

		return( ( vecOrigin - hEntity.GetEntity().pev.origin ).Length() <= flRadius );
	}

}