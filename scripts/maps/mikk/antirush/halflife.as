#include "entities"

void MapActivate()
{//	Name of the map this next entities will be created.
    if( string(g_Engine.mapname) == "hl_c07_a1" )
    {	// Start game Relay Init Blocker
		AntiRushRelayInit( "140 216 598", "5", "30" );
		// Percent Lock 1 ( KEY / PADLOCK EXAMPLE )
		// beams on padlock ( this fuck the idea of this script but well. there are if you need. )
		AntiRushRender( "1" );
		AntiRushBeams( "1", "-1064 -923 -1549", "-1064 -923 -1679" );
		AntiRushBeams( "1", "-1064 -923 -1549", "-1064 -717 -1549" );
		AntiRushBeams( "1", "-1064 -717 -1679", "-1064 -717 -1549" );
		AntiRushBeams( "1", "-1064 -717 -1679", "-1064 -741 -1679" );
		AntiRushBeams( "1", "-1064 -757 -1711", "-1064 -741 -1679" );
		AntiRushBeams( "1", "-1064 -757 -1711", "-1064 -803 -1711" );
		AntiRushBeams( "1", "-1064 -803 -1695", "-1064 -803 -1711" );
		AntiRushBeams( "1", "-1064 -803 -1695", "-1064 -837 -1695" );
		AntiRushBeams( "1", "-1064 -837 -1711", "-1064 -837 -1695" );
		AntiRushBeams( "1", "-1064 -837 -1711", "-1064 -883 -1711" );
		AntiRushBeams( "1", "-1064 -899 -1679", "-1064 -883 -1711" );
		AntiRushBeams( "1", "-1064 -899 -1679", "-1064 -923 -1679" );
		// Percent Lock 1
		AntiRushPercent( "66", "-520 -328 -1459", "-1124 -1169 -1716", "1" );
		AntiRushBlocker( "1", "182", "792 984 -261" );
		AntiRushBlocker( "1", "182", "792 856 -261" );
		AntiRushBlocker( "1", "182", "792 727 -261" );
		// lock the above percentage
		AntiRushAlt( "Complete the task first \n find the required key", "-492 -552 -1446", "-1068 -1116 -1684", "1" );
		// padlock
		AntiRushKeyPadlock( "1", "-1063 -939 -1616", "0 0 0", "3200 -2633 -1535", "0 0 0", "164" );
		// make train move
		TriggerOnce( "144 141 21", "53", "antirush_train_1", "" );
		// path-by-path zzzzzz
		PathTrack( "1", "2", "", "", "", "", "3200 -2633 -1535" );
		PathTrack( "2", "3", "", "", "", "", "3201 -2727 -1506" );
		PathTrack( "3", "4", "", "", "", "", "3044 -2788 -1516" );
		PathTrack( "4", "5", "", "", "", "", "2875 -2791 -1564" );
		PathTrack( "5", "6", "", "", "", "", "2751 -2635 -1574" );
		PathTrack( "6", "7", "", "", "", "", "2724 -1451 -1574" );
		PathTrack( "7", "8", "", "", "", "", "2356 -1415 -1590" );
		PathTrack( "8", "9", "", "", "", "", "2361 -906 -1702" );
		PathTrack( "9", "10", "", "", "", "", "2334 -307 -1702" );
		PathTrack( "10", "11", "", "", "", "", "2154 -316 -1702" );
		PathTrack( "11", "12", "", "", "", "", "2125 -499 -1702" );
		PathTrack( "12", "13", "", "", "", "", "1877 -485 -1718" );
		PathTrack( "13", "14", "", "", "", "", "1822 7 -1708" );
		PathTrack( "14", "15", "", "", "", "", "940 3 -1620" );
		PathTrack( "15", "16", "", "", "", "", "-416 3 -1610" );
		PathTrack( "16", "17", "", "", "", "", "-597 -189 -1610" );
		PathTrack( "17", "18", "", "", "", "", "-598 -555 -1610" );
		PathTrack( "18", "end", "", "", "", "", "-963 -939 -1616" );
		// Skull Lock 2 ( SKULL EXAMPLE )
		AntiRushNpcEnts( "2", "4" );
		// Tell the monsters to have TriggerTarget.
		AntiRushNpcRequired( "2", "-2020 -2604 -752", "30" );
		AntiRushNpcRequired( "2", "-1920 -1936 -1436", "30" );
		AntiRushNpcRequired( "2", "-2252 -1711 -1435", "30" );
		AntiRushNpcRequired( "2", "-2288 -1811 -1435", "30" );
		// Percent Lock 2
		AntiRushPercent( "66", "-1824 -1584 -361", "-2515 -2603 -872", "2" );
		AntiRushBlocker( "2", "60", "36 -816 -204" );
		AntiRushBlocker( "2", "60", "36 -816 -136" );
		AntiRushBlocker( "2", "60", "36 -816 -68" );
		// lock the above percentage ( unlock with AntiRushNpcEnts() )
		AntiRushAlt( "Kill the remain enemies to continue", "-1824 -1584 -361", "-2515 -2603 -872", "2" );
		// beams on percent
		AntiRushRender( "2" );
		AntiRushBeams( "2", "-2123 -2644 -759", "-2123 -2644 -641" );
		AntiRushBeams( "2", "-2115 -2644 -641", "-2123 -2644 -641" );
		AntiRushBeams( "2", "-2115 -2644 -641", "-2115 -2644 -631" );
		AntiRushBeams( "2", "-2122 -2644 -631", "-2115 -2644 -631" );
		AntiRushBeams( "2", "-2122 -2644 -631", "-2076 -2644 -585" );
		AntiRushBeams( "2", "-1906 -2644 -585", "-2076 -2644 -585" );
		AntiRushBeams( "2", "-1906 -2644 -585", "-1861 -2644 -633" );
		AntiRushBeams( "2", "-1861 -2644 -759", "-1861 -2644 -633" );
		AntiRushBeams( "2", "-1861 -2644 -759", "-1918 -2644 -759" );
		AntiRushBeams( "2", "-1938 -2644 -791", "-1918 -2644 -759" );
		AntiRushBeams( "2", "-1938 -2644 -791", "-1985 -2644 -791" );
		AntiRushBeams( "2", "-1985 -2644 -775", "-1985 -2644 -791" );
		AntiRushBeams( "2", "-1985 -2644 -775", "-2037 -2644 -775" );
		AntiRushBeams( "2", "-2037 -2644 -791", "-2037 -2644 -775" );
		AntiRushBeams( "2", "-2037 -2644 -791", "-2084 -2644 -791" );
		AntiRushBeams( "2", "-2100 -2644 -759", "-2084 -2644 -791" );
		AntiRushBeams( "2", "-2100 -2644 -759", "-2123 -2644 -759" );
		// Skull Lock 3 ( SKULL EXAMPLE )
		AntiRushNpcEnts( "3", "3" );
		// Tell the monsters to have TriggerTarget.
		AntiRushNpcRequired( "3", "-120 -1812 -688", "500" );
		// Percent Lock 3
		AntiRushPercent( "66", "96 -1200 -512", "-471 -1920 -756", "3" );
		// lock the above percentage ( unlock with AntiRushNpcEnts() )
		AntiRushAlt( "Kill the remain enemies to continue", "96 -1200 -512", "-471 -1920 -756", "3" );
		AntiRushBlocker( "3", "237", "0 1 0" );
    }
}