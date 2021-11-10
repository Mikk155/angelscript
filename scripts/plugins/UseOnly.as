void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Mikk" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );

	g_Scheduler.SetInterval( "CheckWeaponsFlags", 10.0 );
}

void MapActivate()
{
    CBaseEntity@ pEntity = null;
    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "weapon_*" ) ) !is null ) // Dont use scheduler with weapons. it may be a bad experience when drop
    {
        g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "spawnflags", "256" );
    }
}

void CheckWeaponsFlags()
{
    CBaseEntity@ pEntity = null;
    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "ammo_*" ) ) !is null )
    {
        g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "spawnflags", "256" );
    }

    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "item_battery" ) ) !is null ) // Using certain names due to bug item_inventory / generic
    {
        g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "spawnflags", "256" );
    }

    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "item_healthkit" ) ) !is null )
    {
        g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "spawnflags", "256" );
    }
}