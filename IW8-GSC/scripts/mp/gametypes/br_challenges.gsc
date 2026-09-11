
// Params 0
// Size: 0x82
function init()
{
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        return;
    }
    
    level.£§˜N}4±•›;VVìX±º,:{äÌêÜØ = &getallspawninstances;
    ref_12b14( "br_mastery_fiveContracts", &player_equipment_init );
    ref_12b14( "br_mastery_pointBlank_airstrike", &ref_127db );
    ref_12b14( "br_mastery_pointBlank_tomahawk", &ref_127dc );
    ref_12b14( "br_mastery_c4VehicleMultKill", &force_dismount );
    ref_12b14( "br_mastery_ghostRideWhip", &scavenger_vo_when_close );
    ref_12b14( "br_mastery_roundKillExecute", &ref_12db8 );
    ref_12b14( "br_mastery_travelogue", &ref_13d08 );
}

// Params 2
// Size: 0x1d
function ref_12b14( var0, var1 )
{
    if ( !isdefined( level.debugprintteams ) )
    {
        level.debugprintteams = [];
    }
    
    level.debugprintteams[ var0 ] = var1;
}

// Params 2
// Size: 0x2f
function getallspawninstances( var0, var1 )
{
    if ( !isdefined( level.debugprintteams ) )
    {
        return;
    }
    
    if ( istrue( level.getarenapickupattachmentoverrides ) )
    {
        return;
    }
    
    var2 = level.debugprintteams[ var0 ];
    
    if ( isdefined( var2 ) )
    {
        self thread [[ var2 ]]( var0, var1 );
        return;
    }
}

// Params 1
// Size: 0x28
function cheesewedgeprompt( var0 )
{
    if ( getdvarint( "scr_br_challenge_debug", 0 ) )
    {
        iprintlnbold( "Mastery Challenge: " + var0 + " completed!" );
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_12004( var0 );
}

// Params 1
// Size: 0x5f
function ref_11b1d( var0 )
{
    if ( !isdefined( level.teamdata[ var0 ] ) )
    {
        return;
    }
    
    foreach ( var2 in level.teamdata[ var0 ][ "players" ] )
    {
        ref_13d07( var2 );
    }
    
    if ( getdvarint( "scr_br_core_trios_or_quads", 0 ) )
    {
        ref_13f74( var0 );
        ref_11e54( var0 );
        return;
    }
}

// Params 1
// Size: 0xb6
function ref_13f74( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = 0;
    var2 = 0;
    var3 = max( 1, level.maxteamsize );
    
    foreach ( var5 in level.teamdata[ var0 ][ "players" ] )
    {
        var1 += var5.deaths;
        
        if ( isdefined( var5.ref_11be1 ) )
        {
            var1 += var5.ref_11be1;
        }
        
        if ( scripts\mp\utility\player::isreallyalive( var5 ) )
        {
            var2++;
        }
    }
    
    if ( var1 == 0 )
    {
        foreach ( var5 in level.teamdata[ var0 ][ "players" ] )
        {
            cheesewedgeprompt( var5, "br_mastery_untouchable" );
        }
        
        return;
    }
}

// Params 0
// Size: 0x81
function ref_11e53()
{
    if ( !isdefined( self ) || !isdefined( self.team ) )
    {
        return;
    }
    
    var0 = self.deaths;
    var1 = self.team;
    
    foreach ( var3 in level.teamdata[ var1 ][ "players" ] )
    {
        if ( scripts\mp\utility\player::isreallyalive( var3 ) )
        {
            if ( !isdefined( var3.ref_11be1 ) )
            {
                var3.ref_11be1 = 0;
            }
            
            var3.ref_11be1 += var0;
            break;
        }
    }
}

// Params 1
// Size: 0xa5
function ref_11e54( var0 )
{
    var1 = 7;
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( scripts\mp\gametypes\br::usingtacmap() )
    {
        return;
    }
    
    var2 = 0;
    
    foreach ( var4 in level.teamdata[ var0 ][ "players" ] )
    {
        var2 += var4.deaths;
        
        if ( isdefined( var4.ref_11be1 ) )
        {
            var2 += var4.ref_11be1;
        }
    }
    
    if ( var2 >= var1 )
    {
        foreach ( var4 in level.teamdata[ var0 ][ "players" ] )
        {
            cheesewedgeprompt( var4, "br_mastery_neverSayDie" );
        }
        
        return;
    }
}

// Params 2
// Size: 0x89
function player_equipment_init( var0, var1 )
{
    if ( !isdefined( self.team ) )
    {
        return;
    }
    
    if ( scripts\mp\gametypes\br::get_int_or_0( self.egress_landlord_vo ) < 5 )
    {
        return;
    }
    
    var2 = isdefined( level.gulag ) && !istrue( level.gulag.shutdown );
    
    foreach ( var4 in level.teamdata[ self.team ][ "players" ] )
    {
        if ( !scripts\mp\utility\player::isreallyalive( var4 ) )
        {
            return;
        }
        
        if ( var2 && var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            return;
        }
    }
    
    cheesewedgeprompt( var0 );
}

// Params 2
// Size: 0xaa
function ref_127db( var0, var1 )
{
    var2 = var1.ref_123a1;
    var3 = var1.ref_13a8a;
    
    if ( !isdefined( var2 ) || !isdefined( var2.brbonusxpallowed ) || !isdefined( var2.streakinfo ) || !isdefined( var3 ) )
    {
        return;
    }
    
    var4 = var2.streakinfo;
    
    if ( distancesquared( self.origin, var3 ) > squared( 432 ) )
    {
        return;
    }
    
    self endon( "death_or_disconnect" );
    self notify( "pointBlank_airstrike_killtracker" );
    self endon( "pointBlank_airstrike_killtracker" );
    scripts\engine\utility::ref_143b9( 10, "airstrike_finished_" + var2.brbonusxpallowed );
    
    if ( !scripts\mp\utility\player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( var4.kills >= 3 )
    {
        cheesewedgeprompt( "br_mastery_pointBlankStreakKill" );
        return;
    }
}

// Params 2
// Size: 0x7d
function ref_127dc( var0, var1 )
{
    var2 = var1.streakinfo;
    var3 = var1.ref_13a8a;
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    if ( distancesquared( self.origin, var3 ) > squared( 432 ) )
    {
        return;
    }
    
    self endon( "death_or_disconnect" );
    self notify( "pointBlank_tomahawk_killtracker" );
    self endon( "pointBlank_tomahawk_killtracker" );
    scripts\engine\utility::ref_143ba( 20, "cluster_strike_finished" );
    
    if ( !scripts\mp\utility\player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( var2.kills >= 3 )
    {
        cheesewedgeprompt( "br_mastery_pointBlankStreakKill" );
    }
}

// Params 2
// Size: 0xca
function force_dismount( var0, var1 )
{
    var2 = var1.meansofdeath;
    var3 = var1.inflictor;
    
    if ( !isdefined( var2 ) || var2 != "MOD_EXPLOSIVE" )
    {
        return;
    }
    
    if ( !vandalize_attack_nodes( var3 ) )
    {
        return;
    }
    
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "updateC4VehicleMultKill" );
    self endon( "updateC4VehicleMultKill" );
    
    if ( !isdefined( self.ref_12a83 ) )
    {
        self.ref_12a83 = 0;
    }
    
    self.ref_12a83++;
    wait 4;
    
    if ( isdefined( self.ref_12a83 ) && self.ref_12a83 >= 3 )
    {
        cheesewedgeprompt( var0 );
        var4 = force_call_lz( var3 );
        var5 = isdefined( var4 ) && isdefined( var4.team ) && isdefined( self.team ) && var4.team == self.team;
        
        if ( var5 )
        {
            cheesewedgeprompt( var4, var0 );
        }
    }
    
    self.ref_12a83 = undefined;
}

// Params 1
// Size: 0xae, Type: bool
function vandalize_attack_nodes( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( isdefined( var0.vehiclename ) && !var0 scripts\common\vehicle_code::vehicle_is_stopped() )
    {
        var1 = var0 getlinkedchildren();
        
        foreach ( var3 in var1 )
        {
            if ( isdefined( var3.weapon_name ) && var3.weapon_name == "c4_mp_p" )
            {
                return true;
            }
        }
    }
    else if ( isdefined( var0.weapon_name ) && var0.weapon_name == "c4_mp_p" )
    {
        var5 = var0 getlinkedparent();
        
        if ( isdefined( var5 ) && isdefined( var5.vehiclename ) && !var5 scripts\common\vehicle_code::vehicle_is_stopped() )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x3b
function force_call_lz( var0 )
{
    if ( isdefined( var0 ) && isdefined( var0.weapon_name ) && var0.weapon_name == "c4_mp_p" )
    {
        var1 = var0 getlinkedparent();
        
        if ( isdefined( var1 ) )
        {
            return var1.owner;
        }
    }
    
    return undefined;
}

// Params 2
// Size: 0x45
function ref_12db8( var0, var1 )
{
    var2 = var1.player;
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    if ( isdefined( var2.modifiers[ "execution" ] ) && var2.modifiers[ "execution" ] == 1 )
    {
        cheesewedgeprompt( var2, "br_mastery_roundKillExecute" );
        return;
    }
}

// Params 2
// Size: 0xb2
function scavenger_vo_when_close( var0, var1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var2 = var1.onplayerkillednew;
    var3 = var1.ref_11a6c;
    
    if ( istrue( var2 ) )
    {
        if ( istrue( self.should_run_sp_stealth ) && self.ref_12a84 != 0 )
        {
            return;
        }
        
        self.should_run_sp_stealth = 1;
    }
    
    if ( !istrue( self.should_run_sp_stealth ) )
    {
        return;
    }
    
    self notify( "ghostRideWhip" );
    self endon( "ghostRideWhip" );
    
    if ( !isdefined( self.ref_12a84 ) )
    {
        self.ref_12a84 = 0;
    }
    
    if ( istrue( var3 ) )
    {
        self.ref_12a84++;
    }
    
    wait 4;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.ref_12a84 ) && self.ref_12a84 >= 3 )
    {
        cheesewedgeprompt( var0 );
    }
    
    self.ref_12a84 = undefined;
    self.should_run_sp_stealth = undefined;
}

// Params 2
// Size: 0xfc
function ref_13d08( var0, var1 )
{
    var2 = -1;
    
    if ( getdvarint( "scr_br_core_trios_or_quads", 0 ) == 0 )
    {
        return;
    }
    
    var3 = var1.inflictor;
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    if ( !isplayer( var3 ) )
    {
        if ( isdefined( var3.owner ) && isplayer( var3.owner ) )
        {
            var3 = var3.owner;
        }
        else
        {
            return;
        }
    }
    
    var4 = var1.victim;
    
    if ( !isdefined( var4 ) || !isplayer( var4 ) )
    {
        return;
    }
    
    var5 = 0;
    var6 = var3 scripts\mp\gametypes\br_callouts::removematchingents_bymodel( var3 );
    
    if ( var6 != var2 )
    {
        var5 |= 1 << var6;
    }
    
    var6 = var4 scripts\mp\gametypes\br_callouts::removematchingents_bymodel( var4 );
    
    if ( var6 != var2 )
    {
        var5 |= 1 << var6;
    }
    
    if ( var5 == 0 )
    {
        return;
    }
    
    foreach ( var8 in level.teamdata[ var3.team ][ "players" ] )
    {
        if ( !isdefined( var8.ref_14727 ) )
        {
            var8.ref_14727 = 0;
        }
        
        var8.ref_14727 |= var5;
    }
}

// Params 1
// Size: 0x69
function ref_13d07( var0 )
{
    var1 = 12;
    
    if ( !isdefined( var0.ref_14727 ) || var0.ref_14727 == 0 )
    {
        return;
    }
    
    var2 = 0;
    
    for ( var3 = 0; var3 < level.calloutglobals.ref_11e29.size ; var3++ )
    {
        var4 = var0.ref_14727 & 1 << var3;
        
        if ( var4 )
        {
            var2++;
        }
    }
    
    if ( var2 >= var1 )
    {
        cheesewedgeprompt( var0, "br_mastery_travelogue" );
    }
}

