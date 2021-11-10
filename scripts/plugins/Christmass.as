#include "../maps/w00tguy/env_weather"

// Fog
bool blEnableFog = true;
// brigh
bool blEnablebrigh = true;
// Music
bool blEnableMusic = true;
// skybox
bool blEnableSky = true;
// Gifts
bool blEnableGiftDrops = true;
// Snow
bool blEnableSnow = true;
const string strSnowSprite = "models/mikk/christmass/snow.spr";
const bool blEnableSnowfall = true;
EHandle hSnowFall;

const array<CCustomModel@> aryModels = {
	CCustomModel("monster_barnacle",
		"models/barnacle.mdl",
		array<string> = {
			"models/mikk/christmass/barnacle.mdl"
		}),
	CCustomModel("monster_gman", 
		"models/gman.mdl",
		array<string> = {
			"models/mikk/christmass/gman.mdl"
		}),
	CCustomModel("monster_zombie", 
		"models/zombie.mdl",
		array<string> = {
			"models/mikk/christmass/zombie.mdl",
			"models/mikk/christmass/zombie_barney.mdl"
		}),
	CCustomModel("monster_headcrab", 
		"models/headcrab.mdl",
		array<string> = {
			"models/mikk/christmass/headcrab.mdl"
		})
};

array<string>@ aryModelsNames = {
	"models/mikk/christmass/items/ball.mdl",
	"models/mikk/christmass/items/balloon.mdl",
	"models/mikk/christmass/items/box0.mdl",
	"models/mikk/christmass/items/box1.mdl",
	"models/mikk/christmass/items/box2.mdl",
	"models/mikk/christmass/items/box3.mdl",
	"models/mikk/christmass/items/box4.mdl",
	"models/mikk/christmass/items/candy_cane.mdl"
};

array<string>@ aryItemTier1 = {
	"item_healthkit",
	"weapon_rpg",
	"weapon_gauss",
	"weapon_9mmAR",
	"weapon_m16",
	"weapon_mp5",
	"monster_handgrenade", // :Trollge:
	"monster_handgrenade",
	"monster_handgrenade",
	"monster_handgrenade",
	"monster_handgrenade",
	"monster_handgrenade",
	"monster_handgrenade",
	"weapon_tripmine",
	"weapon_handgrenade",
	"weapon_9mmhandgun",
	"weapon_crowbar",
	"weapon_knife",
	"weapon_pipewrench",
	"weapon_grapple",
	"weapon_shotgun",
	"weapon_displacer",
	"weapon_sporelauncher",
	"weapon_crossbow",
	"weapon_m249",
	"weapon_sniperrifle",
	"monster_handgrenade",
	"monster_handgrenade",
	"ammo_9mmclip",
	"ammo_buckshot",
	"ammo_crossbow"
};

array<string>@ arySongName = {
    "mikk/music/xmass/deanmartin.mp3",
	"mikk/music/xmass/jinglebell.mp3",
	"mikk/music/xmass/bell.wav",
	"mikk/music/xmass/ho.wav",
	"mikk/music/xmass/track_2k13_3.wav",
	"mikk/music/xmass/track_2k13_2.wav"
};

CScheduledFunction@ g_explosion = null;
const int e_rat = 1;

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Mikk" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/ED6kPN9MuA" );
	
	// Hooks
	g_Hooks.RegisterHook(Hooks::Game::EntityCreated, @EntityCreated);
	g_Hooks.RegisterHook( Hooks::Player::PlayerSpawn, @PlayerSpawn );
}

void PrecacheSound( const array<string> pSound )
{
    for( uint i = 0; i < pSound.length(); i++ )
    {
        g_SoundSystem.PrecacheSound( pSound[i] );
        g_Game.PrecacheGeneric( "sound/"+ pSound[i]);
    }
}

EHandle CreateSnowWeather()
{
    dictionary snow =
    {
        { "angles", "90 0 0" },
        { "intensity", "16" },
        { "particle_spr", "" + strSnowSprite },
        { "radius", "1280" },
        { "speed_mult", "1.3" },
        { "weather_type", "2" },
        { "spawnflags", "" + Math.RandomLong( 0, 1 ) },
        { "targetname", "snow" }
    };

    EHandle hEnvWeather = EHandle( g_EntityFuncs.CreateEntity( "env_weather1", snow, true ) );

    if( hEnvWeather )
    {
        g_Scheduler.SetTimeout( "SnowThink", Math.RandomFloat( 60.0f, 120.0f ) );
        return hEnvWeather;
    }
    else
        return EHandle( null );
}

void SnowThink()
{
    if( !hSnowFall )
        return;

    hSnowFall.GetEntity().Use( hSnowFall.GetEntity(), hSnowFall.GetEntity(), USE_TOGGLE, 0.0f );
    g_Scheduler.SetTimeout( "SnowThink", Math.RandomFloat( 180.0f, 300.0f ) );
}

void UpdateOnRemove() // i'm pavo that can't fix DeadDropper. so i do this like a pavo
{
	CBaseEntity@ pEntity = null;
	while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_scientist_dead" )) !is null)
	{
		g_EntityFuncs.Remove(pEntity);
		continue;
	}
	while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_barney_dead" )) !is null)
	{
		g_EntityFuncs.Remove(pEntity);
		continue;
	}
	while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_hgrunt_dead" )) !is null)
	{
		g_EntityFuncs.Remove(pEntity);
		continue;
	}
	while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_handgrenade" )) !is null)
	{
		g_EntityFuncs.Remove(pEntity);
		continue;
	}
	while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_headcrab" )) !is null)
	{
		g_EntityFuncs.Remove(pEntity);
		continue;
	}
}

void MapActivate()
{	
	UpdateOnRemove(); // When pavolife v9
	
	if( blEnableMusic )
	{	// Spawnmusic
        RespawnMusic();
	}
	
    if( blEnableSnowfall )
	{	// Enable snow
		hSnowFall = CreateSnowWeather();
	}
    if( blEnableSky )
	{	// Enable ChangeSky
		ChangeSky();
	}
	
	if( blEnableFog )
	{	// Register fog in-map
		FogInMap();
	}
	
	if( blEnablebrigh )
	{	// Register brigh-map
		BrighMap();
	}
}

void MapInit()
{
	if( blEnableSnow )
	{	// Register env_weather
		WeatherMapInit();
	}
	
	g_Game.PrecacheModel("models/mikk/christmass/items/ball.mdl");
	g_Game.PrecacheModel("models/mikk/christmass/items/balloon.mdl");
	g_Game.PrecacheModel("models/mikk/christmass/items/box0.mdl");
	g_Game.PrecacheModel("models/mikk/christmass/items/box1.mdl");
	g_Game.PrecacheModel("models/mikk/christmass/items/box2.mdl");
	g_Game.PrecacheModel("models/mikk/christmass/items/box3.mdl");
	g_Game.PrecacheModel("models/mikk/christmass/items/box4.mdl");
	g_Game.PrecacheModel("models/mikk/christmass/items/candy_cane.mdl");
	g_Game.PrecacheGeneric("gfx/env/mk_wintherbk.tga");
	g_Game.PrecacheGeneric("gfx/env/mk_wintherdn.tga");
	g_Game.PrecacheGeneric("gfx/env/mk_wintherlf.tga");
	g_Game.PrecacheGeneric("gfx/env/mk_wintherft.tga");
	g_Game.PrecacheGeneric("gfx/env/mk_wintherrt.tga");
	g_Game.PrecacheGeneric("gfx/env/mk_wintherup.tga");
	
	PrecacheSound( arySongName );
	
	if( blEnableGiftDrops )
	{	// Register gift drops
		DeadDropper();
	}
	
	for(uint i = 0; i < aryModels.length(); i++){
		aryModels[i].Precache();
	}
}

HookReturnCode PlayerSpawn(CBasePlayer@ pPlayer)
{
    g_PlayerFuncs.ClientPrintAll(  HUD_PRINTTALK, "hey " + pPlayer.pev.netname + "! Merry Christmass!.\n" );

    return HOOK_CONTINUE;
}

void DeadDropper()
{
  @ents::g_entity = g_Scheduler.SetInterval( "Entitys", 4 );
}

namespace ents
{
	CScheduledFunction@ g_entity = null;

  void Entitys()
  {

    CBaseEntity@ rat = null;

    while( ( @rat = g_EntityFuncs.FindEntityByClassname( rat, "monster_*" ) ) !is null )
    {
      if( rat.IsAlive() == false || rat.pev.health < -50)
      {
        array<CBaseEntity@> booms(e_rat);				
        for (int y = 0; y < e_rat; ++y) 
        {
          @booms[y] = g_EntityFuncs.Create(""+ aryItemTier1[Math.RandomLong(0, aryItemTier1.length()-1)],rat.pev.origin + Vector(Math.RandomLong(0, 0), Math.RandomLong(0, 0), 0 ), Vector(0, 0, 0), false);	
			g_EntityFuncs.SetModel( rat, "" + aryModelsNames[Math.RandomLong(0, aryModelsNames.length()-1)] );  
        }
      }
    }
  }
}

class CCustomModel{
	string szClassName;
	string szOriginPath;
	array<string> aryPaths = {};

	CCustomModel(string c, string o, array<string>@ a){
		szClassName = c;
		szOriginPath = o;
		aryPaths = a;
	}

	void Precache(){
		for(uint i = 0; i < aryPaths.length(); i++){
			g_Game.PrecacheModel(aryPaths[i]);
		}
	}

	string GetModel(){
		return aryPaths[Math.RandomLong(0, aryPaths.length()-1)];
	}
}

CCustomModel@ GetPath(string szClassName)
{
	for(uint i = 0; i < aryModels.length(); i++){
		if(szClassName == aryModels[i].szClassName)
			return aryModels[i];
	}
	return null;
}

void MapStart()
{
    CBaseEntity@ pMonster = null;
    while((@pMonster = g_EntityFuncs.FindEntityByClassname(pMonster, "monster_*")) !is null)
	{
        ChangeName(@pMonster);
    }
	
    CBaseEntity@ pEntity = null;
    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "weapon_*" ) ) !is null )
    {
		g_EntityFuncs.SetModel( pEntity, "" + aryModelsNames[Math.RandomLong(0, aryModelsNames.length()-1)] );  
    }
	
    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "ammo_*" ) ) !is null )
    {
		g_EntityFuncs.SetModel( pEntity, "" + aryModelsNames[Math.RandomLong(0, aryModelsNames.length()-1)] );  
    }
	
    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "item_battery" ) ) !is null )
    {
		g_EntityFuncs.SetModel( pEntity, "" + aryModelsNames[Math.RandomLong(0, aryModelsNames.length()-1)] );  
    }
	
    while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "item_healthkit" ) ) !is null )
    {
		g_EntityFuncs.SetModel( pEntity, "" + aryModelsNames[Math.RandomLong(0, aryModelsNames.length()-1)] );  
    }
}

void ChangeName(CBaseEntity@ pEntity)
{
    if(string(pEntity.pev.classname).StartsWith("monster_") && pEntity.pev.spawnflags & 128 == 0 && pEntity.pev.targetname == ""){
        CBaseMonster@ pMonster = cast<CBaseMonster@>(@pEntity);
        if(@pMonster !is null && !pMonster.m_fCustomModel){
            CCustomModel@ pPath = GetPath(pMonster.pev.classname);
            if(pPath !is null && pPath.szOriginPath != pMonster.pev.model)
            	g_Scheduler.SetTimeout("SetUpModel", 0.01, EHandle(@pMonster), pPath.GetModel());
        }
    }
}

void SetUpModel(EHandle eEntity, string p)
{
	if(eEntity.IsValid()){
		g_EntityFuncs.SetModel(eEntity.GetEntity(), p);
		g_EntityFuncs.SetSize(eEntity.GetEntity().pev, VEC_HUMAN_HULL_MIN, VEC_HUMAN_HULL_MAX);
	}
}

HookReturnCode EntityCreated( CBaseEntity@ pEntity )
{
    ChangeName(@pEntity);
    return HOOK_CONTINUE;
}

void RespawnMusic()
{
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "volume", "10"},
        { "spawnflags", "5"},
        { "targetname", "game_playerspawn"},
        { "message", ""+ arySongName[Math.RandomLong(0, arySongName.length()-1)] }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "ambient_music", keyvalues, true );
}

void ChangeSky()
{
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "spawnflags", "1" },
        { "triggerstate", "0" },
        { "target", "skynamese"},
        { "delay", "5"},
        { "targetname", "game_playerspawn" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", keyvalues, true );

    keyvalues =
    {
        { "skyname", "mk_winther"},
        { "spawnflags", "5"},
        { "targetname", "skynamese" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_changesky", keyvalues, true );
}

void BrighMap()
{
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "spawnflags", "1" },
        { "triggerstate", "0" },
        { "target", "glc_a"},
        { "delay", "5"},
        { "targetname", "game_playerspawn" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", keyvalues, true );

    keyvalues =
    {
        { "pattern", "z"},
        { "targetname", "glc_a" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "global_light_control", keyvalues, true );
}

void FogInMap()
{
    CBaseEntity@ pEntity = null;
    dictionary keyvalues;

    keyvalues =
    {
        { "spawnflags", "1" },
        { "triggerstate", "0" },
        { "target", "add_fogs"},
        { "delay", "5"},
        { "targetname", "game_playerspawn" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", keyvalues, true );

    keyvalues =
    {
        { "spawnflags", "1"},
        { "iuser2", "1000"},
        { "iuser3", "15000"},
        { "rendercolor", "250 250 250"},
        { "targetname", "add_fogs" }
    };
    @pEntity = g_EntityFuncs.CreateEntity( "env_fog", keyvalues, true );
}