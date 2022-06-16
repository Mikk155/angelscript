
/*/
    4 : "Tar Explosion"
    10 : "Lava Splash"
    11 : "Teleport Splash"
    12 : "Explosion"
    122 : "Particle Burst"

    Default: 4
/*/

/* 
	env_quakefx entitie ported from SoHL to Angelscript for porting maps into Sven Co-op 
	
	Credits:
	Gaftherman Script
*/

enum envquakefxspawnflags
{
	SF_QUAKEFX_REPEATABLE = 1 << 0
};

namespace EnvQuakeFx
{
    class env_quakefx : ScriptBaseEntity
    {
        void Spawn()
        {
            self.pev.movetype = MOVETYPE_NONE;
            self.pev.solid = SOLID_NOT;
            g_EntityFuncs.SetOrigin( self, self.pev.origin );

            if( self.pev.health == 0.0f )
                self.pev.health = 10.0f; // duration

            if( self.pev.impulse == 0.0f )
                self.pev.impulse = 122.0f;

            if( self.pev.armortype == 0.0f )
                self.pev.armortype = 500.0f; // radius

            if( self.pev.frags == 0.0f )
                self.pev.frags = 12.0f; // particle colour
        }

        void Use(CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue)
        {
            NetworkMessage quakefx( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY, null );
            quakefx.WriteByte( self.pev.impulse);

            quakefx.WriteCoord(self.pev.origin.x);
            quakefx.WriteCoord(self.pev.origin.y);
            quakefx.WriteCoord(self.pev.origin.z);

            if(self.pev.impulse == TE_PARTICLEBURST)
            {
                quakefx.WriteShort( uint8( self.pev.armortype));  // radius
                quakefx.WriteByte( uint8( self.pev.frags)); // particle colour
                quakefx.WriteByte( uint8( self.pev.health) * 10); // duration
            }
            else if(self.pev.impulse == TE_EXPLOSION2)
            {
                // these fields seem to have no effect - except that it
                // crashes when I send "0" for the number of colours..
                quakefx.WriteByte(0); // colour
                quakefx.WriteByte(1); // number of colours
            }
            quakefx.End();

            if ( (self.pev.spawnflags & SF_QUAKEFX_REPEATABLE ) > 0)
            {
                self.pev.nextthink = g_Engine.time + (self.pev.health + 5.0f);
            }
            else
            {
                SetThink( ThinkFunction(this.SUB_Remove) );
                self.pev.nextthink = g_Engine.time + 0.0f;
            }

            // Trigger targets
            self.SUB_UseTargets( pActivator, USE_TOGGLE, 0 );
        }

        void SUB_Remove()
        {
            self.SUB_Remove();
        }
    }

    void Register()
    {
        g_CustomEntityFuncs.RegisterCustomEntity( "EnvQuakeFx::env_quakefx", "env_quakefx" );
    }
}
