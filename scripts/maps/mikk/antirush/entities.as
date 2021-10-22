/*
*	Anti-Rush by Mikk
*
*	Special thanks to:
*
*	Cubemath for trigger_once / multiple_mp.as
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
*		yes. it's basicaly edit maps without edit the map really.
*
*	2)	This Anti-Rush will haven't floating icons. this mean players that don't know the map
*		Will be not spoiled by icons so they can enjoy the experience to find the way by their own
*
*	3)	Server Operators are able to Dis/Able Anti-Rush via mapScript
*	
*	4)	Players are able to vote to disable the anti-rush in-game
*		The vote to Enable it has been not implemented yet.
*		Due to the problems this can cause the vote to enable the anti-rush
*		Like players OUT / IN a percentage zone while it get on.
*
*	5)	this is easy to implement on any map. looks like a smart edit but isn't
*
*	How install:
*	add these lines on the main map script

#include "mikk/antirush/antirush"
#include "mikk/antirush/mapantirush"

bool blAntiRushEnabled = true;

void MapInit()
{
	if( blAntiRushEnabled )
	{
		g_CustomEntityFuncs.RegisterCustomEntity( "anti_rush", "anti_rush" );
		g_CustomEntityFuncs.RegisterCustomEntity( "trigger_once_mp", "trigger_once_mp" );
		g_CustomEntityFuncs.RegisterCustomEntity( "trigger_multiple_mp", "trigger_multiple_mp" );
		g_CustomEntityFuncs.RegisterCustomEntity( "trigger_entity_volume", "trigger_entity_volume");
	}
}

*	How to use? go to the MapActivate() then edit any IF - mapname.
*
*	there are ennumerations with the KV's on the Github Repository.
*
*
*
*	Blank text to edit.

		AntiRushPercent( "", "", "", "", "", "" );
		AntiRushAlt( "1", "", "", "" );
		AntiRushKeyPadlock( "", "", "", "", "", "" );
		PathTrack( "", "", "", "", "", "", "" );
		AntiRushNpcEnts( "", "" );
		AntiRushNpcRequired( "", "", "" );
		AntiRushRelayInit( "", "", "" );
		TriggerOnce( "", "", "", "" ); if needed for anything
		AntiRushBeams( "", "", "" );
		AntiRushRender( "" );

*/

// PERCENT LOCK STUFF
void AntiRushAlt( const string messag, const string maxh, const string minh, const string namese )
{
	CBaseEntity@ pEntity = null;
	dictionary altmess;
	
	altmess =														// sound to play when antirush get triggered
	{
		{ "pitchstart", "100" },
		{ "linearmax", "5"},
		{ "linearmin", "2"},
		{ "pitch", "100"},
		{ "health", "10"},
		{ "message", "buttons/bell1.wav"},
		{ "spawnflags", "52"},
		{ "targetname", "unlock_percentage_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "ambient_generic", altmess, true );

	altmess =
	{
		{ "percentage", "01"},
		{ "zonecornermin", "" + minh },
		{ "zonecornermax", "" + maxh },
		{ "target", "antirush_vol2_" + namese },
		{ "wait", "1"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "anti_rush", altmess, true );

	altmess =														// trigger_entity_volume by outerbeast
	{
		{ "intarget", "antirush_2text_" + namese },
		{ "zonecornermin", "" + minh },
		{ "zonecornermax", "" + maxh },
		{ "incount", "1"},
		{ "spawnflags", "1"},
		{ "targetname", "antirush_vol2_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_entity_volume", altmess, true );

	altmess =													//	Display the text to the player who reach the zone.
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
		{ "message", "ANTI-RUSH: " + messag },
		{ "targetname", "antirush_2text_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", altmess, true );
}

// BLOCKER WALL
void AntiRushBlocker( const string namese, const string model, const string origin )
{
	CBaseEntity@ pEntity = null;
	dictionary wall;

	wall =														// BSP Model BLOCKER
	{
		{ "model", "*" + model },
		{ "origin", "" + origin },
		{ "rendermode", "1"},
		{ "renderamt", "255"},
		{ "rendercolor", "255 0 0"},
		{ "targetname", "antirush_target_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "func_wall_toggle", wall, true );
}

// PERCENT LOCK STUFF
void AntiRushPercent( const string percent, const string maxh, const string minh, const string namese )
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
		{ "spawnflags", "1"},
		{ "targetname", "antirush_vol_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_entity_volume", antirush, true );

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
		{ "message", "ANTI-RUSH: "+ percent +" percent of players needed" },
		{ "targetname", "antirush_text_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", antirush, true );
}

// KEY & PADLOCK STUFF
void AntiRushKeyPadlock( const string namese, const string padorigin, const string padangles, const string keyorigin, const string angles2, const string model )
{
	CBaseEntity@ pEntity = null;
	dictionary train;

	train =
	{
		{ "copypointer", "antirush_train" },
		{ "target", "antirush_key"},
		{ "spawnflags", "1009"},
		{ "angleoffset", "0 180 0"},
		{ "targetname", "antirush_setorigin" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_setorigin", train, true );

	train =
	{
		{ "spawnflags", "1"},
		{ "triggerstate", "1"},
		{ "delay", "1"},
		{ "target", "antirush_setorigin" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", train, true );
	
	train =
	{
		{ "targetname", "antirush_train" },
		{ "model", "*" + model },
		{ "target", "antirush_path_start"},
		{ "spawnflags", "10"},
		{ "wheels", "32"},
		{ "height", "0"},
		{ "speed", "256"},
		{ "rendermode", "5"},
		{ "renderamt", "255"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "func_tracktrain", train, true );
	
	train =
	{
		{ "targetname", "antirush_key" },
		{ "model", "models/cubemath/key.mdl"},
		{ "movetype", "5"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "item_generic", train, true );
	
	train =
	{
		{ "targetname", "antirush_padlock" },
		{ "model", "models/cubemath/padlock.mdl"},
		{ "topcolor", "170"},
		{ "movetype", "5"},
		{ "origin", "" + padorigin },
		{ "angles", "" + padangles }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "item_generic", train, true );

	train =
	{
		{ "targetname", "antirush_path_start"},
		{ "target", "antirush_path_1" },
		{ "angles", "" + angles2 },
		{ "origin", "" + keyorigin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "path_track", train, true );
	
	train =
	{
		{ "targetname", "antirush_path_end"},
		{ "message", "antirush_key_relay" },
		{ "origin", "" + padorigin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "path_track", train, true );
	
	train =
	{
		{ "killtarget", "antirush_train" },
		{ "targetname", "antirush_key_relay" },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );
	
	train =
	{
		{ "target", "unlock_percentage" },
		{ "targetname", "antirush_key_relay" },
		{ "killtarget", "antirush_vol2_" + namese },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "target", "unlock_percentage_" },
		{ "killtarget", "antirush_padlock" },
		{ "targetname", "antirush_key_relay" },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "killtarget", "antirush_key" },
		{ "targetname", "antirush_key_relay" },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "targetname", "unlock_percentage" },
		{ "target", "antirush_master_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "anti_rush", train, true );
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
		{ "spawnflags", "1"},
		{ "targetname", "antirush_setvalues" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_entity_volume", npcskull2, true );
}

// SKULL NPC REQUIRED STUFF
void AntiRushNpcEnts( const string skull, const string ammout )
{
	CBaseEntity@ pEntity = null;
	dictionary npcskull;

	npcskull =
	{
		{ "spawnflags", "1"},
		{ "triggerstate", "1"},
		{ "delay", "5"},
		{ "target", "antirush_setvalues" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", npcskull, true );
	
	npcskull =
	{
		{ "targetname", "antirush_count_" + skull },
		{ "target", "unlock_percentage_" + skull },
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

	npcskull =
	{
		{ "targetname", "unlock_percentage_" + skull },
		{ "killtarget", "antirush_vol2_" + skull },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", npcskull, true );

	npcskull =
	{
		{ "targetname", "unlock_percentage_" + skull },
		{ "target", "antirush_master_" + skull }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "anti_rush", npcskull, true );
}

// Beam's stuff
void AntiRushBeams( const string namese, const string origin1, const string origin2 )
{
	CBaseEntity@ pEntity = null;
	dictionary beam;

	beam =
	{
		{ "LightningStart", "antirush_pb_" + namese },
		{ "LightningEnd", "antirush_bp_" + namese },
		{ "texture", "sprites/laserbeam.spr"},
		{ "life", "0"},
		{ "BoltWidth", "7"},
		{ "NoiseAmplitude", "0"},
		{ "spawnflags", "1"},
		{ "renderamt", "128"},
		{ "rendercolor", "255 0 0"},
		{ "TextureScroll", "100"},
		{ "renderfx", "0"},
		{ "Radius", "256"},
		{ "targetname", "blocker_beam_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "env_beam", beam, true );

	beam =
	{
		{ "origin", "" + origin1 },
		{ "targetname", "antirush_pb_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "info_target", beam, true );

	beam =
	{
		{ "origin", "" + origin2 },
		{ "targetname", "antirush_bp_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "info_target", beam, true );
}

// Beam's stuff rendermode
void AntiRushRender( const string namese )
{
	CBaseEntity@ pEntity = null;
	dictionary beam;

	beam =
	{
		{ "rendercolor", "0 255 0"},
		{ "spawnflags", "7"},
		{ "target", "blocker_beam_" + namese },
		{ "targetname", "antirush_target_" + namese }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "env_render", beam, true );
}

// map start blocker relay init
void AntiRushRelayInit( const string origin, const string model, const string times )
{
	CBaseEntity@ pEntity = null;
	dictionary relayinit;

	relayinit =														// BSP Model BLOCKER
	{
		{ "model", "*" + model },
		{ "origin", "" + origin },
		{ "rendermode", "5"},
		{ "renderamt", "255"},
		{ "targetname", "antirush_initwall" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "func_wall_toggle", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 30 seconds.." },
		{ "targetname", "msg_countdown_1" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 29 seconds.." },
		{ "targetname", "msg_countdown_2" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 28 seconds.." },
		{ "targetname", "msg_countdown_3" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 27 seconds.." },
		{ "targetname", "msg_countdown_4" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 26 seconds.." },
		{ "targetname", "msg_countdown_5" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 25 seconds.." },
		{ "targetname", "msg_countdown_6" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 24 seconds.." },
		{ "targetname", "msg_countdown_7" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 23 seconds.." },
		{ "targetname", "msg_countdown_8" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 22 seconds.." },
		{ "targetname", "msg_countdown_9" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );
	
	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 21 seconds.." },
		{ "targetname", "msg_countdown_10" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 20 seconds.." },
		{ "targetname", "msg_countdown_11" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 19 seconds.." },
		{ "targetname", "msg_countdown_12" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 18 seconds.." },
		{ "targetname", "msg_countdown_13" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 17 seconds.." },
		{ "targetname", "msg_countdown_14" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 16 seconds.." },
		{ "targetname", "msg_countdown_13" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 15 seconds.." },
		{ "targetname", "msg_countdown_14" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 14 seconds.." },
		{ "targetname", "msg_countdown_15" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 13 seconds.." },
		{ "targetname", "msg_countdown_16" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 12 seconds.." },
		{ "targetname", "msg_countdown_17" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 16 seconds.." },
		{ "targetname", "msg_countdown_18" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 15 seconds.." },
		{ "targetname", "msg_countdown_19" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 14 seconds.." },
		{ "targetname", "msg_countdown_20" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 13 seconds.." },
		{ "targetname", "msg_countdown_21" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 12 seconds.." },
		{ "targetname", "msg_countdown_22" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 11 seconds.." },
		{ "targetname", "msg_countdown_23" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 10 seconds.." },
		{ "targetname", "msg_countdown_24" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 9 seconds.." },
		{ "targetname", "msg_countdown_25" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 8 seconds.." },
		{ "targetname", "msg_countdown_26" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 7 seconds.." },
		{ "targetname", "msg_countdown_27" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 6 seconds.." },
		{ "targetname", "msg_countdown_28" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 5 seconds.." },
		{ "targetname", "msg_countdown_29" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 4 seconds.." },
		{ "targetname", "msg_countdown_30" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 3 seconds.." },
		{ "targetname", "msg_countdown_31" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 2 seconds.." },
		{ "targetname", "msg_countdown_32" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "spawnflags", "3"},
		{ "y", "-.25"},
		{ "x", "-1"},
		{ "color", "255 255 255"},
		{ "color2", "255 255 255"},
		{ "fadein", "1"},
		{ "fadeout", "0.5"},
		{ "holdtime", "2"},
		{ "fxtime", "0.25"},
		{ "channel", "4"},
		{ "message", "Game will begin in 1 seconds.." },
		{ "targetname", "msg_countdown_33" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", relayinit, true );

	relayinit =
	{
		{ "delay", "1"},
		{ "triggerstate", "1"},
		{ "target", "relay_init_map_" + times }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", relayinit, true );

	relayinit =
	{
		{ "msg_countdown_1", "1.5"},
		{ "msg_countdown_2", "2.5"},
		{ "msg_countdown_3", "3.5"},
		{ "msg_countdown_4", "4.5"},
		{ "msg_countdown_5", "5.5"},
		{ "msg_countdown_6", "6.5"},
		{ "msg_countdown_7", "7.5"},
		{ "msg_countdown_8", "8.5"},
		{ "msg_countdown_9", "9.5"},
		{ "msg_countdown_10", "10.5"},
		{ "msg_countdown_11", "11.5"},
		{ "msg_countdown_12", "12.5"},
		{ "msg_countdown_13", "13.5"},
		{ "msg_countdown_14", "14.5"},
		{ "msg_countdown_15", "15.5"},
		{ "msg_countdown_16", "16.5"},
		{ "msg_countdown_17", "17.5"},
		{ "msg_countdown_18", "18.5"},
		{ "msg_countdown_19", "19.5"},
		{ "msg_countdown_20", "20.5"},
		{ "msg_countdown_21", "21.5"},
		{ "msg_countdown_22", "22.5"},
		{ "msg_countdown_23", "23.5"},
		{ "msg_countdown_24", "24.5"},
		{ "msg_countdown_25", "25.5"},
		{ "msg_countdown_26", "26.5"},
		{ "msg_countdown_27", "27.5"},
		{ "msg_countdown_28", "28.5"},
		{ "msg_countdown_29", "29.5"},
		{ "msg_countdown_30", "30.5"},
		{ "msg_countdown_31", "31.5"},
		{ "msg_countdown_32", "32.5"},
		{ "msg_countdown_33", "33.5"},
		{ "antirush_initwall", "33.5"},
		{ "targetname", "relay_init_map_30" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multi_manager", relayinit, true );

	relayinit =
	{
		{ "msg_countdown_11", "1.5"},
		{ "msg_countdown_12", "2.5"},
		{ "msg_countdown_13", "3.5"},
		{ "msg_countdown_14", "4.5"},
		{ "msg_countdown_15", "5.5"},
		{ "msg_countdown_16", "6.5"},
		{ "msg_countdown_17", "7.5"},
		{ "msg_countdown_18", "8.5"},
		{ "msg_countdown_19", "9.5"},
		{ "msg_countdown_20", "10.5"},
		{ "msg_countdown_21", "11.5"},
		{ "msg_countdown_22", "12.5"},
		{ "msg_countdown_23", "13.5"},
		{ "msg_countdown_24", "14.5"},
		{ "msg_countdown_25", "15.5"},
		{ "msg_countdown_26", "16.5"},
		{ "msg_countdown_27", "17.5"},
		{ "msg_countdown_28", "18.5"},
		{ "msg_countdown_29", "19.5"},
		{ "msg_countdown_30", "20.5"},
		{ "msg_countdown_31", "21.5"},
		{ "msg_countdown_32", "22.5"},
		{ "msg_countdown_33", "23.5"},
		{ "antirush_initwall", "23.5"},
		{ "targetname", "relay_init_map_20" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multi_manager", relayinit, true );

	relayinit =
	{
		{ "msg_countdown_24", "1.5"},
		{ "msg_countdown_25", "2.5"},
		{ "msg_countdown_26", "3.5"},
		{ "msg_countdown_27", "4.5"},
		{ "msg_countdown_28", "5.5"},
		{ "msg_countdown_29", "6.5"},
		{ "msg_countdown_30", "7.5"},
		{ "msg_countdown_31", "8.5"},
		{ "msg_countdown_32", "9.5"},
		{ "msg_countdown_33", "10.5"},
		{ "antirush_initwall", "10.5"},
		{ "targetname", "relay_init_map_10" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multi_manager", relayinit, true );
}
// Trigger_once
void TriggerOnce( const string origin, const string model, const string namese, const string master )
{
	CBaseEntity@ pEntity = null;
	dictionary once;

	once =
	{
		{ "origin", "" + origin },
		{ "model", "*" + model },
		{ "target", "" + namese },
		{ "master", "" + master }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_once", once, true );
}