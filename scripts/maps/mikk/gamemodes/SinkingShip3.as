/********************************************************************/
/*																	*/
/*		Script that will make Dead Players SOLID. this'll prevent	*/
/*		Player body to fall underground.							*/
/*		Original plugin by CubeMath									*/
/*		steamcommunity.com/id/CubeMath								*/
/*																	*/
/*																	*/
/*																	*/
/*		HOW TO INSTALL:												*/
/*			Add this to the BOTTOM of the MapInit			
	
#include "mikk/gamemodes/SinkingShip3"


bool bEnabled;

void MapInit()
{

	//	HLSPClassicMode
	ClassicModeMapInit();
	
	//	SinkingShip3
    uint uiCount = 0;

    for( uint i = 0; i < DISALLOWED_MAPS.length(); i++ ) 
    {
    
    bool wildcard = false;
    string tmp = DISALLOWED_MAPS[i];
    
        if ( tmp.SubString( tmp.Length()-1, 1 ) == "*" )
        {
            wildcard = true;
            tmp = tmp.SubString( 0, tmp.Length()-1 );
        }
        
        if ( wildcard )
        {
            if ( tmp == string(g_Engine.mapname).SubString( 0, tmp.Length() ) )
            {
                uiCount++;
            }
        }
        else if( g_Engine.mapname == DISALLOWED_MAPS[i] )
        {
            uiCount++;
        }
    }

    if( uiCount <= 0 )
        bEnabled = true;
    else
        bEnabled = false;
	SinkingShip();
}

	then you can place here the maps you want to Disallow the script	*/ 

const array<string> DISALLOWED_MAPS = { 'map1', 'map2', 'campaign_*' };

void SinkingShip()
{
	if( !bEnabled ){
	}
	else
	g_Scheduler.SetInterval( "CheckPlayerSinking", 1.0 );
}

void CheckPlayerSinking(){
//	g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "Debug:- SinkingShip3 Loaded.\n");
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		
		if( pEntity !is null && pEntity.GetClassname() == "deadplayer" && pEntity.pev.speed < 10.0) {
			if(pEntity.pev.movetype != 5 && pEntity.pev.movetype != 8) {
				pEntity.pev.origin.z += 20.0;
				pEntity.pev.velocity.z -= 128.0;
				pEntity.pev.movetype = 5;
			}else if(pEntity.pev.movetype != 8){
				pEntity.pev.velocity = Vector(0,0,0);
				pEntity.pev.movetype = 8;
			}
		}
	}
}