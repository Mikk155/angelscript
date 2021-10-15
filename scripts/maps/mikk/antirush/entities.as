/* 
*	Anti-Rush by Mikk
*
*	Special thanks to:
*
*	Cubemath for trigger_ once & multiple _mp.as
*
*	Outerbeast for anti_rush and trigger_entity_volume.as
*
*	Gaftherman for simplify the code to make this easy and better to edit
*
*	Sparks for the idea
*
*	So. whats different with this antirush?
*
*	1)	This script just creates a entities required to make the anti-rush work on the specified maps.
*		think on this like a .ent file but that you can set disabled at any time.
*		yes. its basically edit maps without edit the map really.
*
*	2)	This Anti-Rush will haven't floating icons. this mean players that don't know the map
*		Will be not spoiled the experience by the floating icons that tell where the way are
*		And prevent the players to rush the level change. so everyone can enjoy new maps.
*
*	3)	Server Operators are able to Dis/Able Anti-Rush via mapScript
*	
*	4)	Players are able to vote to disable or enable the anti-rush.
*		Due to the problems this can cause the vote to enable the anti-rush
*		Will work only on the first 40 seconds of the MapLoad. after it.
*		Players will be unable to activate it. but they will be able to disable it.
* 		(vote to enable WiP. vote to disable functional)
*
*	5)	this is easy to implement on any map. looks like a smart edit but isn't
*
*	How install:
*	add these lines on the main map script

#include "mikk/antirush/anti_rush"
#include "mikk/antirush/campaign script"

bool blAntiRushEnabled = true;

void MapInit()
{
	if( blAntiRushEnabled )
		MapActivate();
		RegisterAntiRushEntity(
	);
}

*	How to use? go to the MapActivate() then edit any IF - mapname.

there are ennumerations with the KV's

SAMPLES:


AntiRushPercent( "1", "2", "3", "4", "5", "6", "7" );
1	=	percentage of players needed
2	=	detection zone Max Hull Size
3	=	detection zone Min hull Size
4	=	anti_rush master, target and kill target		(leave blank if just use 1 antirush)
5	=	func_wall_toggle BSP model						(no need the * only the number)
6	=	func_wall_toggle origin
7	=	text to display when players reach zone


advanced entities that you need to read how the script works

AntiRushKeyPadlock( "1", "2", "3", "4", "5" );
1	=	entities target/name 							(leave blank if just use 1 key/padlock)
2	=	padlock origin
3	=	padlock angles
4	=	key origin
5	=	key angles


PathTrack( "1", "2", "3", "4", "5", "6", "7" );
1	=	targetname								(be sure the first path_track is named "antirush_path_1"
2	=	target									(be sure the last path_track is named "antirush_path_end"
3	=	message
4	=	speed
5	=	newspeed
6	=	spawnflags
7	=	origin


AntiRushNpcEnts( "1", "2" )
1	=	skull name
2	=	ammout of enemies needed to unlock antirush


AntiRushNpcRequired( "1", "2", "3" )
1	=	name
2	=	origin (be sure is the same of the monster you want to edit. need one AntiRushNpcRequired() per npc
3	=	radius (on units)



*/

// PERCENT LOCK STUFF
void AntiRushPercent( const string percent, const string minh, const string maxh, const string namese, const string model, const string origin, const string texto )
{
	CBaseEntity@ pEntity = null;
	dictionary antirush;

	antirush =														// antirush entities Mash-up
	{
		{ "percentage", "" + percent },
		{ "zonecornermin", "" + minh },
		{ "zonecornermax", "" + maxh },
		{ "master", "antirush_master_" + namese },
		{ "target", "antirush_target_" + namese },
		{ "killtarget", "antirush_vol_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "anti_rush", antirush, true );

	antirush =														// BSP Model BLOCKER
	{
		{ "percentage", "*" + model },
		{ "origin", "" + origin },
		{ "rendermode", "5"},
		{ "renderamt", "0"},
		{ "targetname", "antirush_target_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "func_wall_toggle", antirush, true );

	antirush =														// sound to play when antirush get triggered
	{
		{ "pitchstart", "100" },
		{ "linearmax", "5"},
		{ "linearmin", "2"},
		{ "pitch", "100"},
		{ "health", "10"},
		{ "message", "buttons/bell1.wav"},
		{ "spawnflags", "52"},
		{ "targetname", "antirush_target_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "ambient_generic", antirush, true );

	antirush =
	{
		{ "percentage", "01"},
		{ "zonecornermin", "" + minh },
		{ "zonecornermax", "" + maxh },
		{ "master", "antirush_master_" + namese },
		{ "target", "antirush_vol_" + namese },
		{ "wait", "1"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "anti_rush", antirush, true );

	antirush =														// trigger_entity_volume by outerbeast
	{
		{ "intarget", "antirush_text_" + namese },
		{ "zonecornermin", "" + minh },
		{ "zonecornermax", "" + maxh },
		{ "incount", "1"},
		{ "targetname", ""},
		{ "spawnflags", "1"},
		{ "targetname", "antirush_vol_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_entity_volume", antirush, true );

	gametext =
	{
		{ "m_iszNewValue", "ANTI-RUSH: "+ percent +" percent of players needed" },
		{ "m_iszValueType", "0"},
		{ "m_iszValueName", "message"},
		{ "m_trigonometricBehaviour", "0"},
		{ "m_iAppendSpaces", "0"},
		{ "targetname", "antirush_master_" + namese },
		{ "target", "antirush_text_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_changevalue", gametext, true );
	
	antirush =													//	Display the text to the player who reach the zone.
	{															//	Dont spoiler the map with floating icons.
		{ "effect", "2" },
		{ "spawnflags", "2"},
		{ "y", "0.67"},
		{ "x", "-1"},
		{ "color", "100 100 100"},
		{ "color2", "240 110 0"},
		{ "fadein", "0.0"},
		{ "fadeout", "1"},
		{ "holdtime", "5"},
		{ "fxtime", "0.0"},
		{ "channel", "1"},
		{ "message", "ANTI-RUSH: " + texto },
		{ "targetname", "antirush_text_" + namese },
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", antirush, true );
}

// KEY & PADLOCK STUFF
void AntiRushKeyPadlock( const string namese, const string padorigin, const string padangles, const string keyorigin, const string angles2 )
{
	CBaseEntity@ pEntity = null;
	dictionary train;

	train =
	{
		{ "copypointer", "antirush_train_" + namese },
		{ "target", "antirush_key_" + namese },
		{ "spawnflags", "1009"},
		{ "angleoffset", "0 180 0"},
		{ "targetname", "antirush_setorigin" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_setorigin", train, true );

	train =
	{
		{ "spawnflags", "1"},
		{ "triggerstate", "1"},
		{ "target", "antirush_setorigin" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", train, true );
	
	train =
	{
		{ "targetname", "antirush_train_" + namese },
		{ "target", "antirush_path_start"},
		{ "spawnflags", "10"},
		{ "wheels", "32"},
		{ "height", "0"},
		{ "speed", "256"},
		{ "rendermode", "5"},
		{ "renderamt", "0"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "func_tracktrain", train, true );
	
	train =
	{
		{ "targetname", "antirush_key_" + namese },
		{ "model", "models/cubemath/key.mdl"},
		{ "movetype", "5"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "item_generic", train, true );
	
	train =
	{
		{ "targetname", "antirush_padlock_" + namese },
		{ "model", "models/cubemath/padlock.mdl"},
		{ "topcolor", "170"},
		{ "origin", "" + padorigin },
		{ "angles", "" + padangles }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "item_generic", train, true );

	train =
	{
		{ "targetname", "antirush_path_start"},
		{ "target", "antirush_path_1"},
		{ "angles", "" + angles2 },
		{ "origin", "" + keyorigin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "path_track", train, true );
	
	train =
	{
		{ "targetname", "antirush_path_end"},
		{ "message", "antirush_key_mm_" + namese },
		{ "origin", "" + padorigin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "path_track", train, true );
	
	train =
	{
		{ "targetname", "antirush_key_mm_" + namese },
		{ "antirush_key_relay_" + namese , "1"},
		{ "antirush_master_" + namese , "1"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multi_manager", train, true );
	
	train =
	{
		{ "killtarget", "antirush_train_" + namese },
		{ "targetname", "antirush_key_relay_" + namese },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "killtarget", "antirush_padlock_" + namese },
		{ "targetname", "antirush_key_relay_" + namese },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "killtarget", "antirush_key_" + namese },
		{ "targetname", "antirush_key_relay_" + namese },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "targetname", "antirush_master_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multisource", train, true );
}

// KEY & PADLOCK STUFF
void PathTrack( const string track, const string tnext, const string message1, const string speed, const string newspeed, const string spawnflags, const string origin )
{
	CBaseEntity@ pEntity = null;
	dictionary tracks;

	tracks =
	{
		{ "targetname", "antirush_path_" + track },
		{ "target", "antirush_path_" + tnext },
		{ "message", "" + message1 },
		{ "speed", "" + speed },
		{ "newspeed", "" + newspeed },
		{ "spawnflags", "" + spawnflags },
		{ "origin", "" + origin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "path_track", tracks, true );
}

// SKULL NPC REQUIRED STUFF
void AntiRushNpcRequired( const string skull, const string origin, const string radius )
{
	CBaseEntity@ pEntity = null;
	dictionary npcskull2;

	npcskull2 =
	{
		{ "intarget", "antirush_setskll_" + skull },
		{ "zoneradius", "" + radius },
		{ "origin", "" + origin },
		{ "incount", "1"},
		{ "targetname", ""},
		{ "spawnflags", "1"},
		{ "targetname", "antirush_setskull_" + skull }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_entity_volume", npcskull2, true );
}

// SKULL NPC REQUIRED STUFF
void AntiRushNpcEnts( const string skull, const string ammout, )
{
	CBaseEntity@ pEntity = null;
	dictionary npcskull;

	npcskull =
	{
		{ "spawnflags", "1"},
		{ "triggerstate", "1"},
		{ "delay", "5"},
		{ "target", "antirush_setskull_" + skull }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", npcskull, true );
	
	npcskull =
	{
		{ "targetname", "antirush_count_" + skull },
		{ "target", "antirush_master_" + skull },
		{ "frags", "0"},
		{ "health", "" + ammout },
		{ "spawnflags", "5" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_counter", npcskull, true );
	
	npcskull =
	{
		{ "m_iszNewValue", "antirush_count_" + skull },
		{ "m_iszValueType", "0"},
		{ "m_iszValueName", "TriggerTarget"},
		{ "m_trigonometricBehaviour", "0"},
		{ "m_iAppendSpaces", "0"},
		{ "targetname", "antirush_setskll_" + skull },
		{ "target", "!activator" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_changevalue", npcskull, true );
	
	npcskull =
	{
		{ "m_iszNewValue", "4" },
		{ "m_iszValueType", "0"},
		{ "m_iszValueName", "TriggerCondition"},
		{ "m_trigonometricBehaviour", "0"},
		{ "m_iAppendSpaces", "0"},
		{ "targetname", "antirush_setskll_" + skull },
		{ "target", "!activator" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_changevalue", npcskull, true );
}