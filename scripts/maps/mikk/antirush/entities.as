void AntiRushEntity( const string percent, const string minh, const string maxh, const string am, const string at, const string akt, const string aw )
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
		{ "killtarget", "antirush_passed_" + akt },
		{ "wait", "" + aw }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "anti_rush", antirush, true );
}
void MultiSource( const string msource )
{
	CBaseEntity@ pEntity = null;
	dictionary multisource;

	multisource =
	{
		{ "targetname", "antirush_ms_" + msource }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multisource", multisource, true );
}

void AntiRushKey( const string trainame, const string mdlname, const string origin, const string padlock, const string padorigin, const string padangles, const string killp )
{
	CBaseEntity@ pEntity = null;
	dictionary train;

	train =
	{
		{ "copypointer", "antirush_train_" + trainame },
		{ "target", "antirush_key_" + mdlname },
		{ "spawnflags", "1009"},
		{ "angleoffset", "0 180 0"},
		{ "targetname", "antirush_setorigin" + origin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_setorigin", train, true );

	train =
	{
		{ "spawnflags", "1"},
		{ "triggerstate", "1"},
		{ "target", "antirush_setorigin" + origin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_auto", train, true );
	
	train =
	{
		{ "targetname", "antirush_train_" + trainame },
		{ "target", "antirush_path_1"},
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
		{ "targetname", "antirush_key_" + mdlname },
		{ "model", "models/cubemath/key.mdl"},
		{ "movetype", "5"}
	};
	@pEntity = g_EntityFuncs.CreateEntity( "item_generic", train, true );
	
	train =
	{
		{ "targetname", "antirush_padlock_" + padlock },
		{ "model", "models/cubemath/padlock.mdl"},
		{ "topcolor", "170"},
		{ "origin", "" + padorigin },
		{ "angles", "" + padangles }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "item_generic", train, true );
	
	train =
	{
		{ "targetname", "antirush_path_end"},
		{ "message", "antirush_ms_" + killp },
		{ "origin", "" + padorigin }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "path_track", train, true );
		
	train =
	{
		{ "killtarget", "antirush_padlock_" + padlock },
		{ "targetname", "antirush_ms_" + killp },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "killtarget", "antirush_padlock_" + mdlname },
		{ "targetname", "antirush_ms_" + killp },
		{ "triggerstate", "0" }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_relay", train, true );

	train =
	{
		{ "targetname", "antirush_ms_" + killp }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "multisource", train, true );
}

void PathTrack( const string track, const string tnext, const string message1, const string speed, const string newspeed, const string spawnflags )
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
		{ "spawnflags", "" + spawnflags }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "path_track", tracks, true );
}

void AntiRushText( const string message1, const string cvv, const string textname, const string cvtname )
{
	CBaseEntity@ pEntity = null;
	dictionary gametext;
	
	gametext =													//	Display the text to the player who reach the zone.
	{															//	Dont spoiler the map with floating icons.
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
		{ "targetname", "" + textname }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "game_text", gametext, true );

	gametext =
	{
		{ "m_iszNewValue", "" + cvv },
		{ "m_iszValueType", "0"},
		{ "m_iszValueName", "message"},
		{ "m_trigonometricBehaviour", "0"},
		{ "m_iAppendSpaces", "0"},
		{ "targetname", "antirush_ms_" + cvtname },
		{ "target", "" + textname }
	};
	@pEntity = g_EntityFuncs.CreateEntity( "trigger_changevalue", gametext, true );
}