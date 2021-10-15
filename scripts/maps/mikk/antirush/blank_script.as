/* 
*	Anti-Rush by Mikk
*
*	Special thanks to:
*
*	Cubemath for trigger_ once & multiple _mp.as
*
*	Outerbeast for anti_rush.as
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

AntiRushEntity( "1", "2", "3", "4", "5", "6", "7");
1	=	percentage of players needed
2	=	detection zone Max Hull Size
3	=	detection zone Min hull Size
4	=	anti_rush entity keyvalue master
5	=	anti_rush entity keyvalue target (if target a "master" this'll create a multisource as intermediary)
6	=	anti_rush entity keyvalue killtarget
7	=	anti_rush entity keyvalue wait (if set. the entity will be restarted depend the time on seconds you specify)

MultiSource( "1" );
1	=	multisource name. no more xd (just use this if you need for some weird things. most of the string already have multisource included)

AntiRushKey( "1", "2", "3", "4", "5", "6", "7" );
1	=	func_tracktrain targetname
2	=	the key model name
3	=	trigger_setorigin targetname
4	=	padlock model targetname, trigger_relay killtarget (you can leave previus keyvalues blank if you're using just one key one padlock)
5	=	padlock model origin and last path_track origin
6	=	padlock model angles
7	=	target to apply when key get the padlock. (no need multisource. this'll create one.)

PathTrack( "1", "2", "3", "4", "5", "6" );
1	=	targetname	(be sure the first PathTrack you add is the same as		AntiRushKey("1") or func_tracktrain will go to nothing
2	=	target		(be sure the last PathTrack you add is the same as 		AntiRushKey("5") padlock and path_track origin
3	=	message
4	=	speed
5	=	newspeed
6	=	spawnflags	make sure not add invalid parameters.

AntiRushText( "1", "2", "3", "4" )
1	=	game_text message
2	=	game_text new message after trigger_changevalue
3	=	game_text targetname
4	=	trigger_changevalue targetname

Blank text for lazy people
		AntiRushEntity( "", "", "", "", "", "", "");
		AntiRushKey( "", "", "", "", "", "", "" );
		PathTrack( "", "", "", "", "", "" );
		AntiRushText( "", "", "", "" )
		MultiSource( "" );


*/
#include "entities"

void MapActivate()
{//	Name of the map this next entities will be created.
    if( string(g_Engine.mapname) == "hl_c07_a1" )
    {	// Percent Lock 1
		AntiRushEntity( "", "", "", "", "", "", "");
		AntiRushKey( "", "", "", "", "", "", "" );
		PathTrack( "", "", "", "", "", "" );
		AntiRushText( "", "", "", "" )
		MultiSource( "" );
    }
}