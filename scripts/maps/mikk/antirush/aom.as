/* 
*	Anti-Rush for Afraid Of Monsters Custom. but you can change the g_Engine.mapname at any time if you recognize the maps
*	This script just creates a entities required for a certain maps.
*	think on this like a .ent file but that you can set disabled at any time
*
*	How to use? go to the MapActivate() then edit any IF - mapname.
*	there's one line per entity. you can edit keyvalues for certain map.
*
*	How install:
*	add these lines on the main map script

#include "mikk/antirush/anti_rush"
#include "mikk/antirush/aom"

bool blAntiRushEnabled = true; // true = Anti-Rush mode

void MapInit()
{
	if( blAntiRushEnabled )
		MapActivate();
		RegisterAntiRushEntity(
	);
}

SAMPLES:

		Wall blocker												Message per reach zone player
		AntiRushBlocker( "origin", "model", "targetname", "origin", "model", "targetname", "target");
		
		Game_Text
		AntiRushText( "percentage (text) ", "alternative antirush text");
		
		Anti_Rush entity
		AntiRushEntity( "percentage", "Maxhullsize", "Minhullsize", "master", "target", "killtarget");
		
		Skull stuff
		AntiRushSkull( "GC target", "GC name", "GC Health", "CV new value", "CV name and multisource", "CV target");
		
		
Blank text for lazy people

		AntiRushBlocker( "", "", "", "", "", "", "");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "", "", "", "", "", "");
		AntiRushSkull( "", "", "", "", "", "");
*/

void MapActivate()
{//	Name of the map this next entities will be created.
    if( string(g_Engine.mapname) == "aom_4" )
    {	// Percent Lock 4
		AntiRushBlocker( "151 -240 0", "78", "percent_lock_4_blocker", "0 0 0", "34", "percent_lock_4_multiple", "percent_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "852 3533 -2794", "438 3201 -2944", "", "percent_lock_4_blocker", "percent_lock_4_multiple");
		// Percent Lock 3
		AntiRushBlocker( "2 0 0", "78", "percent_lock_3_blocker", "193 -141 0", "78", "percent_lock_3_multiple", "percent_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "-252 2494 -2244", "-878 2052 -2367", "", "percent_lock_3_blocker", "percent_lock_3_multiple");
		// Percent Lock 2
		AntiRushBlocker( "0 -1 0", "74", "percent_lock_2_blocker", "0 75 9", "153", "percent_lock_2_multiple", "skull_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "928 756 -2495", "579 461 -2776", "deathcount_2_antirush", "percent_lock_2_blocker", "percent_lock_2_multiple");
		AntiRushSkull( "", "", "", "percent_lock_text", "deathcount_2_antirush", "percent_lock_2_multiple");
		// Percent Lock 1
		AntiRushBlocker( "-267 -691 -30", "184", "percent_lock_1_blocker", "-267 -631 -30", "184", "percent_lock_1_multiple", "skull_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "2051 1552 -2475", "961 1020 -2712", "deathcount_antirush", "percent_lock_1_blocker", "percent_lock_1_multiple");
		AntiRushSkull( "", "", "", "percent_lock_text", "deathcount_antirush", "percent_lock_1_multiple");
    }
	
    if( string(g_Engine.mapname) == "aom_3" )
    {	// Percent Lock 3
		AntiRushBlocker( "1 0 0", "105", "percent_lock_3_blocker", "334 0 0", "105", "percent_lock_3_multiple", "antirush_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "3418 3985 -2461", "2849 3364 -2742", "deathcount_3_antirush", "percent_lock_3_blocker", "percent_lock_3_multiple");
		AntiRushSkull( "", "", "", "percent_lock_text", "deathcount_3_antirush", "percent_lock_3_multiple");
		// Percent Lock 2
		AntiRushBlocker( "1756 -209 -2697", "298", "percent_lock_2_blocker", "95 89 14", "279", "percent_lock_2_multiple", "antirush_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "2347 -22 -2474", "1635 -981 -2762", "deathcount_2_antirush", "percent_lock_2_blocker", "percent_lock_2_multiple");
		AntiRushSkull( "", "", "", "percent_lock_text", "deathcount_2_antirush", "percent_lock_2_multiple");
		// Percent Lock 1
		AntiRushBlocker( "1435 -9 84", "74", "percent_lock_1_blocker", "0 -558 0", "92", "percent_lock_1_multiple", "antirush_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "4004 1444 -2488", "3631 867 -2720", "deathcount_antirush", "percent_lock_1_blocker", "percent_lock_1_multiple");
		AntiRushSkull( "", "", "", "percent_lock_text", "deathcount_antirush", "percent_lock_1_multiple");
    }

	if( string(g_Engine.mapname) == "aom_2" )
    {
		// Percent Lock 3
		AntiRushBlocker( "-680 -440 14", "99", "percent_lock_3_blocker", "-438 -1791 -214", "29", "percent_lock_3_multiple", "percent_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "1996 -363 -2617", "1265 -1026 -2797", "", "percent_lock_3_blocker", "percent_lock_3_multiple");
		// Percent Lock 2
		AntiRushBlocker( "1056 -1174 -2522", "9", "percent_lock_2_blocker", "-983 -2359 -34", "29", "percent_lock_2_multiple", "antirush_lock_text");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "1268 -800 -2374", "956 -1176 -2582", "deathzomb_cv", "percent_lock_2_blocker", "percent_lock_2_multiple");
		AntiRushSkull( "", "", "", "percent_lock_text", "deathzomb_cv", "percent_lock_2_multiple");
		// Percent Lock 1
		AntiRushBlocker( "-3128 -1228 280", "320", "percent_lock_1_blocker", "-3128 -1173 280", "320", "percent_lock_1_multiple", "antirush_lock_text");
		AntiRushSkull( "", "", "", "percent_lock_text", "deathbull_cv", "percent_lock_1_multiple");
		AntiRushText( "66 percent players needed", "some enemies are still alive");
		AntiRushEntity( "66", "-689 -678 -804", "-1520 -1153 -964", "deathbull_cv", "percent_lock_1_blocker", "percent_lock_1_multiple" );
    }
	
    if( string(g_Engine.mapname) == "aom_1" )
    {	// Percent Lock 1
		AntiRushBlocker( "-1 0 0", "356", "percent_lock_1_blocker", "217 643 486", "247", "percent_lock_1_multiple", "percent_lock_text");
		AntiRushText( "66 percent players needed", "");
		AntiRushEntity( "66", "1020 537 -724", "1364 764 -588", "percent_lock_1_ms", "percent_lock_1_blocker", "percent_lock_1_multiple");
    }
}

void AntiRushText( const string message1, const string altmessage )
{
	CBaseEntity@ pEntity = null;
	dictionary gametext;
	
	gametext =													//	Display the text to the player who reach the zone.
	{															//	Dont spoiler the players with icons where the way are.
		{ "effect", "2" },
		{ "y", "0.67"},
		{ "x", "-1"},
		{ "color", "100 100 100"},
		{ "color2", "240 110 0"},
		{ "fadein", "0.0"},
		{ "fadeout", "1"},
		{ "holdtime", "5"},
		{ "fxtime", "0.0"},
		{ "channel", "1"},
		{ "message", "ANTI-RUSH: " + message1 },
		{ "targetname", "percent_lock_text" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", gametext, true );

	gametext =
	{
		{ "effect", "2" },
		{ "y", "0.67"},
		{ "x", "-1"},
		{ "color", "100 100 100"},
		{ "color2", "240 110 0"},
		{ "fadein", "0.0"},
		{ "fadeout", "1"},
		{ "holdtime", "5"},
		{ "fxtime", "0.0"},
		{ "channel", "1"},
		{ "message", "ANTI-RUSH: " + altmessage },
		{ "targetname", "antirush_lock_text" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", gametext, true );
}

void AntiRushBlocker( const string wo, const string wm, const string wn, const string mes1, const string mes2, const string mes3, const string mes4 )
{
	CBaseEntity@ pEntity = null;
	dictionary blocker;

	blocker =														// Blocker wall BSP Model.
	{
		{ "origin", "" + wo },
		{ "model", "*" + wm },
		{ "rendermode", "5"},
		{ "renderamt", "0"},
		{ "targetname", "" + wn }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "func_wall_toggle", blocker, true );

	blocker =														//	may game_player_zone work better. i didn't. just edit this
	{
		{ "origin", "" + mes1 },
		{ "wait", "0.5"},
		{ "model", "*" + mes2 },
		{ "targetname", "" + mes3 },
		{ "target", "" + mes4 }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_multiple", blocker, true );
}

void AntiRushEntity( const string percent, const string minh, const string maxh, const string am, const string at, const string akt )
{
	CBaseEntity@ pEntity = null;
	dictionary antirush;

	antirush =														// antirush entities Mash-up
	{
		{ "percentage", "" + percent },
		{ "zonecornermin", "" + minh },
		{ "zonecornermax", "" + maxh },
		{ "master", "" + am },
		{ "target", "" + at },
		{ "killtarget", "" + akt }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "anti_rush", antirush, true );
}

void AntiRushSkull( const string npctarget, const string npcname, const string npccount, const string cvv, const string skulltarget, const string cvt )
{
	CBaseEntity@ pEntity = null;
	dictionary skull;

	skull =														// Skull Stuff
	{
		{ "target", "" + npctarget },
		{ "targetname", "" + npcname },
		{ "frags", "0"},
		{ "health", "" + npccount },
		{ "spawnflags", "5" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_counter", skull, true );
	
	skull =
	{
		{ "m_iszNewValue", "" + cvv },
		{ "m_iszValueType", "0"},
		{ "m_iszValueName", "target"},
		{ "m_trigonometricBehaviour", "0"},
		{ "m_iAppendSpaces", "0"},
		{ "targetname", "" + skulltarget },
		{ "target", "" + cvt }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_changevalue", skull, true );
	
	skull =
	{
		{ "targetname", "" + skulltarget }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multisource", skull, true );
}