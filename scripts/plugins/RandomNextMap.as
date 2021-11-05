/* 
	not an aparently reason to do this.
	i just did this shitty script to play
	random maps in a random day

*/
void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Mikk" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );
}

void MapActivate()
{
    CBaseEntity@ pEntity = null;
    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "trigger_changelevel" ) ) !is null )
    {
        g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "keep_inventory", "1" );
        g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "map", "" + aryMapName[Math.RandomLong(0, aryMapName.length()-1)]);
    }
}

array<string>@ aryMapName = {
    "hl_c02_a1",
	"hl_c02_a2", 
	"hl_c03*", 
	"hl_c04", 
	"hl_c05_a1", 
	"hl_c05_a2", 
	"hl_c06", 
	"hl_c07_a1", 
	"hl_c07_a2",
    "hl_c08_a1", 
	"hl_c08_a2", 
	"hl_c09_a1", 
	"hl_c09_a2", 
	"hl_c10", 
	"hl_c11_a1", 
	"hl_c11_a2", 
	"hl_c11_a3", 
	"hl_c11_a4",
    "hl_c11_a5", 
	"hl_c12", 
	"hl_c13_a1", 
	"hl_c13_a2", 
	"hl_c13_a3", 
	"hl_c13_a4", 
	"hl_c14", 
	"hl_c15", 
	"hl_c16_a1",
    "hl_c16_a2", 
	"hl_c16_a3", 
	"hl_c16_a4", 
	"hl_c17", 
	"hl_c18", 
	"mk_accesspoint", 
	"mk_bridge_the_gap", 
	"affliction1", 
	"affliction2",
    "tunnelvision6", 
	"tunnelvision5", 
	"tunnelvision4", 
	"tunnelvision3", 
	"tunnelvision2", 
	"tunnelvision1", 
	"reviviscence",
	"arctic_incident2", 
	"arctic_incident1",
    "", 
	"", 
	"", 
	"", 
	"", 
	"", 
	"", 
	"", 
	"",
    "", 
	"", 
	"", 
	"", 
	"", 
	"", 
	"", 
	"", 
	""
};