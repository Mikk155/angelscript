/*/ Spirit Of Half Life env_quakefx ported by Gaftherman for map conversion

Particle Styles.
    4 : "Tar Explosion"
    10 : "Lava Splash"
    11 : "Teleport Splash"
    12 : "Explosion"
    122 : "Particle Burst"

    Default: 4
/*/

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

            if( self.pev.health == 0.0f )
                self.pev.health = 10.0f; // duration

            if( self.pev.impulse == 0.0f )
                self.pev.impulse = 122.0f;

            if( self.pev.armortype == 0.0f )
                self.pev.armortype = 300.0f; // radius

            if( self.pev.frags == 0.0f )
                self.pev.frags = 12.0f; // particle colour
        }

        void Use(CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue)
        {
            if( ( self.pev.spawnflags & SF_QUAKEFX_REPEATABLE ) > 0 )
            {
                // We're toggled so determine what to do based on the use type.
                switch( useType )
                {
                    case USE_OFF:
                        self.pev.nextthink = 0.0f;
                        break;

                    case USE_ON:
                        self.pev.nextthink = g_Engine.time;
                        break;

                    case USE_TOGGLE:
                        if( self.pev.nextthink > 0.0f )
                            self.pev.nextthink = 0.0f;
                        else
                            self.pev.nextthink = g_Engine.time;
                }
            }
            else
                self.pev.nextthink = g_Engine.time; // If we don't toggle, just kickstart the thinking to run it once.
        }

        void Think()
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

            // When toggled, think with a 0.1 second delay.
            // Experiment with different timings and life/decay rate for better results.
            if ((self.pev.spawnflags & SF_QUAKEFX_REPEATABLE ) > 0)
            {
                self.pev.nextthink = g_Engine.time + ( self.pev.health / 10 );
            }
            else
            {
                SetThink( ThinkFunction(this.SUB_Remove) );
                self.pev.nextthink = g_Engine.time;
            }
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