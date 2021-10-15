/*
*	Original anti-rush entity by outerbeast.
*	https://github.com/Outerbeast/anti_rush
*
*	just removed some lines from the old script version.
*	used this instead because i dont like when players get spoiled by the anti-rush. and i am kinda lazy to make the entities one-by-one.
* 	Special thanks to:
*	Gaftherman
*	Outerbeast
*	Cubemath
*	Sparks
*/
#include "trigger_once_mp"
#include "trigger_multiple_mp"
#include "trigger_entity_volume"
class anti_rush : ScriptBaseEntity
{
    private EHandle hAntiRushLock;
    private string strSoundName             = "buttons/bell1.wav";
    private string strPercentTriggerType    = "trigger_once_mp";
    private string strMasterName, strKillTarget;
    private Vector vZoneCornerMin, vZoneCornerMax;
    private float flPercentRequired, flTargetDelay, flTriggerWait;
    bool KeyValue(const string& in szKey, const string& in szValue)
    {
        if( szKey == "sound" ) 
        {
            strSoundName = szValue;
            return true;
        }
        else if( szKey == "master" ) 
        {
            strMasterName = szValue;
            return true;
        }
        else if( szKey == "killtarget" ) 
        {
            strKillTarget = szValue;
            return true;
        }
        else if( szKey == "zonecornermin" ) 
        {
            g_Utility.StringToVector( vZoneCornerMin, szValue );
            return true;
        }
        else if( szKey == "zonecornermax" ) 
        {
            g_Utility.StringToVector( vZoneCornerMax, szValue );
            return true;
        }
        else if( szKey == "percentage" ) 
        {
            flPercentRequired = atof( szValue );
            return true;
        }
        else if( szKey == "wait" )
        {
            flTriggerWait = atof( szValue );
            return true;
        }
        else if( szKey == "delay" )
        {
            flTargetDelay = atof( szValue );
            return true;
        }
        else
            return BaseClass.KeyValue( szKey, szValue );
    }
    void Precache()
    {
        g_SoundSystem.PrecacheSound( "" + strSoundName );
    }
    void Spawn()
    {
        self.Precache();
        self.pev.movetype 	= MOVETYPE_NONE;
        self.pev.solid 		= SOLID_NOT;
        g_EntityFuncs.SetOrigin( self, self.pev.origin );
        if( self.GetTargetname() == "" )
            self.pev.targetname = "" + self.GetClassname() + "_ent" + self.entindex();

        if( flTriggerWait > 0.0f )
            strPercentTriggerType = "trigger_multiple_mp";
        else
            strPercentTriggerType = "trigger_once_mp";

        if( flPercentRequired > 0.01f )
        {   
            if( vZoneCornerMin != g_vecZero && vZoneCornerMax != g_vecZero )
            {
                if( vZoneCornerMin != vZoneCornerMax )
                    CreatePercentPlayerTrigger();
            }
        }

        if( self.pev.target != "" || self.pev.target != self.GetTargetname() )
            CreateLock();
    }
    void CreatePercentPlayerTrigger()
    {
        dictionary trgr;
        trgr ["minhullsize"]        = "" + vZoneCornerMin.ToString();
        trgr ["maxhullsize"]        = "" + vZoneCornerMax.ToString();
        trgr ["m_flPercentage"]     = "" + flPercentRequired/100;
        trgr ["target"]             = "" + self.GetTargetname();
        if( strMasterName != "" || strMasterName != "" + self.GetTargetname() ) trgr ["master"] = "" + strMasterName;
        if( strPercentTriggerType == "trigger_multiple_mp" ) trgr ["m_flDelay"] = "" + flTriggerWait;
        CBaseEntity@ pPercentPlayerTrigger = g_EntityFuncs.CreateEntity( "" + strPercentTriggerType, trgr, true );
    }
    void CreateLock()
    {
        dictionary ms = { { "targetname", "" + self.pev.target } };
        hAntiRushLock = EHandle( g_EntityFuncs.CreateEntity( "multisource", ms, true ) );
    }
    void Use(CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float value)
    {
        g_Scheduler.SetTimeout( this, "TargetFuncs", flTargetDelay );
    }
    void TargetFuncs()
    {
        self.SUB_UseTargets( @self, USE_TOGGLE, 0 );
        CBaseEntity@ pKillTargetEnt;
        if( strKillTarget != "" || strKillTarget != self.GetTargetname() )
        {
            while( ( @pKillTargetEnt = g_EntityFuncs.FindEntityByTargetname( pKillTargetEnt, "" + strKillTarget ) ) !is null )
                g_EntityFuncs.Remove( pKillTargetEnt );
        }
    }
    void UpdateOnRemove()
    {
        if( hAntiRushLock )
            g_EntityFuncs.Remove( hAntiRushLock.GetEntity() );
    }
}
void RegisterAntiRushEntity()
{
    g_CustomEntityFuncs.RegisterCustomEntity( "anti_rush", "anti_rush" );
    g_CustomEntityFuncs.RegisterCustomEntity( "trigger_once_mp", "trigger_once_mp" );
    g_CustomEntityFuncs.RegisterCustomEntity( "trigger_multiple_mp", "trigger_multiple_mp" );
	g_CustomEntityFuncs.RegisterCustomEntity( "trigger_entity_volume", "trigger_entity_volume" );
}