
// Params 0
// Size: 0x25
function init()
{
    scripts\mp\flags::gameflaginit( "br_ready_to_jump", 0 );
    setdvarifuninitialized( "scr_br_c130_parachuteEnableDelay", 2 );
    level.ç®õi´øcËúW0ÕÕs@`cˇì@/ = &ispointinbounds;
}

// Params 2
// Size: 0x18
function spawnc130pathstruct( var0, var1 )
{
    var2 = makepathparamsstruct( var0, var1 );
    var3 = scripts\mp\gametypes\br_public::makepathstruct( var2 );
    return var3;
}

// Params 2
// Size: 0xad
function makepathparamsstruct( var0, var1 )
{
    var2 = 160;
    var3 = 200;
    
    if ( isdefined( var0 ) )
    {
        var4 = var0;
    }
    else
    {
        var4 = ( 0, 0, 0 );
    }
    
    if ( level.mapname == "mp_torez" )
    {
        var3 = 165;
        var4 = 195;
        var4 = ( 3000, -2000, 0 );
    }
    
    var5 = 6.28318;
    var6 = randomfloatrange( 0, 360 );
    var7 = randomfloatrange( var3, var4 );
    
    if ( isdefined( var2 ) )
    {
        var8 = var2;
    }
    else
    {
        var8 = level.br_level.br_circleradii[ 0 ];
    }
    
    var9 = spawnstruct();
    var9.r = var8;
    var9.randomangle = var7;
    var9.endangleoffset = var8;
    var9.centerpt = var5;
    return var9;
}

// Params 1
// Size: 0x95
function snappointtomapbounds2d( var0 )
{
    var1 = level.br_level.br_mapbounds;
    
    if ( var0[ 0 ] < var1[ 1 ][ 0 ] )
    {
        var0 = ( var1[ 1 ][ 0 ], var0[ 1 ], var0[ 2 ] );
    }
    else if ( var0[ 0 ] > var1[ 0 ][ 0 ] )
    {
        var0 = ( var1[ 0 ][ 0 ], var0[ 1 ], var0[ 2 ] );
    }
    
    if ( var0[ 1 ] < var1[ 1 ][ 1 ] )
    {
        var0 = ( var0[ 0 ], var1[ 1 ][ 1 ], var0[ 2 ] );
    }
    else if ( var0[ 1 ] > var1[ 0 ][ 1 ] )
    {
        var0 = ( var0[ 0 ], var1[ 0 ][ 1 ], var0[ 2 ] );
    }
    
    return var0;
}

// Params 3
// Size: 0xed
function ref_1342e( var0, var1, var2 )
{
    if ( !isdefined( level.outofboundstriggers ) || level.outofboundstriggers.size == 0 )
    {
        return snappointtomapbounds2d( var1 );
    }
    
    if ( !isdefined( level.ref_12165 ) )
    {
        level.ref_12165 = level.outofboundstriggers;
    }
    
    var3 = physics_createcontents( [ "physicscontents_playertrigger" ] );
    var4 = scripts\engine\trace::ray_trace_ents( var0, var1, level.ref_12165, var3 );
    var5 = 0;
    
    if ( var4[ "fraction" ] < 1 )
    {
        var1 = var4[ "position" ];
        var5 = 1;
    }
    
    if ( isdefined( level.ref_12166 ) && level.ref_12166.size > 0 && getdvarint( "scr_br_spawnOOBKillswitch", 0 ) == 0 )
    {
        var6 = scripts\mp\gametypes\br_public::ref_12a18( var0, var1, level.ref_12166 );
        
        if ( isdefined( var6 ) )
        {
            var7 = distance2dsquared( var0, var1 );
            var8 = distance2dsquared( var0, var6 );
            
            if ( var8 < var7 )
            {
                var1 = ( var6[ 0 ], var6[ 1 ], var1[ 2 ] );
                var5 = 1;
            }
        }
    }
    
    if ( var5 && isdefined( var2 ) )
    {
        var9 = vectornormalize( var0 - var1 );
        var1 += var9 * var2;
    }
    
    return var1;
}

// Params 1
// Size: 0x48
function respawns_on_failed_unload( var0 )
{
    var1 = getdvarfloat( "scr_br_c130MaxRadiusPerc", 0.7 );
    var2 = ( level.br_level.br_mapsize[ 0 ] / 2 + level.br_level.br_mapsize[ 1 ] / 2 ) / 2;
    
    if ( isdefined( var0 ) )
    {
        var2 = var0;
    }
    
    var3 = var1 * var2;
    return var3;
}

// Params 1
// Size: 0x2e, Type: bool
function vehicle_collision_getdamagefactor( var0 )
{
    if ( !isdefined( level.br_level ) )
    {
        return true;
    }
    
    var1 = level.br_level.br_mapcenter;
    var2 = respawns_on_failed_unload();
    var3 = distance2d( var1, var0 );
    return var3 < var2;
}

// Params 2
// Size: 0x1c3
function spawnc130pathstructnew( var0, var1 )
{
    var2 = level.br_level.br_mapcenter;
    
    if ( isdefined( var0 ) )
    {
        var2 = var0;
    }
    
    var3 = respawns_on_failed_unload( var1 );
    var4 = randomfloat( 360 );
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        if ( isdefined( level.stop_rpg_guys ) )
        {
            var4 = level.stop_rpg_guys;
        }
        else
        {
            var4 = 75;
        }
    }
    
    var5 = anglestoforward( ( 0, var4, 0 ) );
    var5 *= var3 * randomfloatrange( -1, 1 );
    var5 += ( 0, 0, relic_ammo_drain_take_ammo() );
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "randomizeCircleCenter" ) )
    {
        var2 += var5;
    }
    
    if ( !scripts\mp\gametypes\br_public::tutorial_playsound() && !scripts\mp\gametypes\br_public::uniquelootcallbacks() )
    {
        var2 = getdvarvector( "scr_br_c130PathCenter", var2 );
    }
    
    if ( isdefined( level.delay_show_backpack ) )
    {
        var2 = level.delay_show_backpack;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "planeConstrainedFromMapCenter" ) )
    {
        var2 = hostdamagepercentmedium( var2 );
    }
    
    var6 = ( 0, randomfloatrange( 0, 360 ), 0 );
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "randomizeCircleCenter" ) )
    {
        var7 = level.br_level.br_mapcenter + var5;
        var8 = var2 - var7;
        
        if ( scripts\engine\utility::cointoss() && getdvarint( "scr_br_circlePlaneDirFlipDisabled", 0 ) == 0 )
        {
            var8 *= -1;
        }
        
        var9 = vectortoyaw( var8 );
        var6 = ( 0, var9, 0 );
    }
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        var6 = ( 0, 75, 0 );
    }
    else
    {
        var10 = getdvarfloat( "scr_br_c130PathAngle", -1 );
        
        if ( var10 < 0 )
        {
            var10 = var6[ 1 ];
        }
        
        var6 = ( 0, var10, 0 );
    }
    
    var11 = level.br_level.br_circleradii[ 0 ];
    
    if ( isdefined( var1 ) )
    {
        var11 = var1;
    }
    
    var12 = var11 * 2;
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "planeUseCircleRadius" ) )
    {
        var12 = var11;
    }
    
    var13 = ref_1361a( var2, var6, var12 );
    var14 = scripts\cp_mp\parachute::getc130height();
    var13.startpt = ( var13.startpt[ 0 ], var13.startpt[ 1 ], var14 );
    var13.endpt = ( var13.endpt[ 0 ], var13.endpt[ 1 ], var14 );
    return var13;
}

// Params 1
// Size: 0x76
function hostdamagepercentmedium( var0 )
{
    var1 = physics_createcontents( [ "physicscontents_playertrigger" ] );
    var2 = scripts\engine\trace::ray_trace_ents( level.br_level.br_mapcenter, var0, level.ref_12165, var1 );
    
    if ( var2[ "fraction" ] < 1 )
    {
        var3 = var0[ 2 ];
        var0 = var2[ "position" ] - level.br_level.br_mapcenter;
        var4 = var2[ "fraction" ] - 0.01;
        var0 = ( var0[ 0 ] * var4, var0[ 1 ] * var4, var3 );
    }
    
    return var0;
}

// Params 3
// Size: 0x1ed
function ref_1361a( var0, var1, var2 )
{
    var3 = anglestoforward( var1 );
    
    if ( !isdefined( var2 ) )
    {
        var2 = level.br_level.br_circleradii[ 0 ] * 2;
        
        if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
        {
            var2 = level.br_level.br_circleradii[ 2 ] * 2;
        }
    }
    
    var4 = var0 - var3 * var2;
    var5 = var0 + var3 * var2;
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "planeSnapToOOB" ) )
    {
        var4 = ref_1342e( var0, var4 );
        var5 = ref_1342e( var0, var5 );
    }
    
    var6 = var4;
    var7 = var5;
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "planeSnapToOOB" ) )
    {
        if ( !add_to_spotlight_array( var4 ) )
        {
            var6 = ref_1342e( var0, var4 );
        }
        
        if ( !add_to_spotlight_array( var5 ) )
        {
            var7 = ref_1342e( var0, var5 );
        }
    }
    
    var3 = vectornormalize( var5 - var4 );
    var8 = scripts\mp\utility\game::round_vehicle_logic();
    var9 = 10;
    
    if ( var8 == "mini" || var8 == "zxp" && getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) || getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) || var8 == "reveal" || isdefined( level.disable_heli_lights ) && level.disable_heli_lights.ref_14291 == 3 )
    {
        if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
        {
            var9 = 5;
        }
        else
        {
            var9 = 2;
        }
    }
    
    if ( var8 == "rebirth" || var8 == "rebirth_reverse" || var8 == "treasure_hunt" || var8 == "mendota" || var8 == "olaride" || var8 == "rebirth_dbd" || var8 == "rebirth_dbd_reverse" )
    {
        if ( scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent() )
        {
            var9 = 8;
        }
        else
        {
            var9 = 7;
        }
    }
    
    var4 -= var3 * getc130speed() * var9;
    var5 += var3 * 100000;
    
    if ( scripts\mp\gametypes\br_public::tutorial_playsound() )
    {
        var4 -= var3 * getc130speed() * 20;
    }
    
    var10 = spawnstruct();
    var10.startpt = var4;
    var10.endpt = var5;
    var10.ref_1386e = var6;
    var10.neurotoxin_damage_monitor = var7;
    var10.angle = var1;
    var10.pathdir = var3;
    var10.centerpt = var0;
    return var10;
}

// Params 0
// Size: 0x2b
function getc130speed()
{
    if ( isdefined( level.br_level ) && isdefined( level.br_level.c130_speedoverride ) )
    {
        return level.br_level.c130_speedoverride;
    }
    
    return 3044;
}

// Params 0
// Size: 0x6
function relic_ammo_drain_take_ammo()
{
    return 8000;
}

// Params 2
// Size: 0x43
function setc130heightoverrides( var0, var1 )
{
    if ( isdefined( var0 ) )
    {
        level.br_level.c130_heightoverride = var0;
    }
    
    if ( isdefined( var1 ) )
    {
        level.br_level.c130_sealeveloverride = var1;
    }
    
    setomnvar( "ui_br_altimeter_c130_height", scripts\cp_mp\parachute::getc130height() );
    setomnvar( "ui_br_altimeter_sea_height", scripts\cp_mp\parachute::getc130sealevel() );
}

// Params 1
// Size: 0x93
function updatec130pathomnvars( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( !isdefined( var0.startpt ) || !isdefined( var0.endpt ) || !isdefined( var0.angle ) )
    {
        return;
    }
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "c130PlaneLine" ) )
    {
        return;
    }
    
    setomnvar( "ui_br_c130_path_start_x", int( var0.ref_1386e[ 0 ] ) );
    setomnvar( "ui_br_c130_path_start_y", int( var0.ref_1386e[ 1 ] ) );
    setomnvar( "ui_br_c130_path_end_x", int( var0.neurotoxin_damage_monitor[ 0 ] ) );
    setomnvar( "ui_br_c130_path_end_y", int( var0.neurotoxin_damage_monitor[ 1 ] ) );
}

// Params 2
// Size: 0x72
function createtestc130path( var0, var1 )
{
    self notify( "debug130Line" );
    
    if ( isdefined( level.br_level.br_mapcenter ) && isdefined( level.br_level.br_mapsize ) )
    {
        var2 = spawnc130pathstructnew( var0, var1 );
        level thread scripts\mp\gametypes\br_analytics::determinewinnertype( var2.centerpt, var2.angle[ 1 ], var2.ref_1386e, var2.neurotoxin_damage_monitor );
    }
    else
    {
        var2 = spawnc130pathstruct( var1, var2 );
    }
    
    updatec130pathomnvars( var2 );
    return var2;
}

// Params 3
// Size: 0x50
function spawnc130( var0, var1, var2 )
{
    var3 = distance( var0.startpt, var0.endpt );
    var4 = var3 / getc130speed();
    var5 = 1;
    level.br_ac130 = gunship_spawn( var0.startpt, var0.endpt, var4, var5, var1, var2 );
    level.br_ac130.ref_12205 = var0;
    return var4;
}

// Params 0
// Size: 0xd3
function spawnplayertoc130()
{
    if ( isdefined( level.infil_vignette_anim_type ) && level.infil_vignette_anim_type == "script_model" )
    {
        self unlink();
    }
    
    scripts\mp\gametypes\br_infils::neurotoxin_damage_loop();
    thread playerputinc130( level.br_ac130 );
    self.elevator_manager = 1;
    
    if ( istrue( self.tutorial_usingparachute ) && getdvar( "scr_br_gametype", "" ) != "dmz" && getdvar( "scr_br_gametype", "" ) != "rat_race" && getdvar( "scr_br_gametype", "" ) != "risk" && getdvar( "scr_br_gametype", "" ) != "bodycount" && getdvar( "scr_br_gametype", "" ) != "gold_war" && getdvar( "scr_br_gametype", "" ) != "olaride" )
    {
        level scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "deploy_squad_leader", self, 1, 0 );
        return;
    }
}

// Params 1
// Size: 0x49
function playerputinc130( var0 )
{
    self.angles = var0.angles;
    self allowcrouch( 0 );
    self allowprone( 0 );
    thread listenjump( var0, 0 );
    thread listenkick( var0, 0 );
    self.br_infil_type = "c130";
    thread scripts\mp\gametypes\br_public::orbitcam( var0 );
    self setclientomnvar( "ui_hide_nameplate_strings", 1 );
}

// Params 6
// Size: 0x17d
function gunship_spawn( var0, var1, var2, var3, var4, var5 )
{
    if ( !isdefined( var3 ) )
    {
        var3 = 1;
    }
    
    var6 = spawn( "script_model", var0 );
    var6 setmodel( "veh8_mil_air_acharlie130_magma_animated" );
    var6 setcandamage( 0 );
    var6.maxhealth = 100000;
    var6.health = var6.maxhealth;
    var6.cleanme = 1;
    var6.startpt = var0;
    var6.dir = vectornormalize( var1 - var0 );
    var6.angles = vectortoangles( var6.dir );
    var7 = "veh8_mil_air_acharlie130_magma_rigid";
    
    if ( isdefined( level.debugforcesre1 ) )
    {
        var7 = level.debugforcesre1;
    }
    
    var6.innards = spawn( "script_model", var0 );
    var6.innards setmodel( var7 );
    var6.innards.cleanme = 1;
    var6.innards linkto( var6, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var6.playeroffsets = [ ( 32, 30, -500 ), ( -32, 30, -500 ), ( 0, 30, -500 ), ( 16, 30, -500 ), ( -16, 30, -500 ) ];
    var6.currentplayeroffset = 0;
    
    if ( isdefined( var5 ) )
    {
        var6 [[ var5 ]]();
    }
    
    if ( var3 )
    {
        thread kickwhenoutofbounds( var6 );
    }
    
    if ( isdefined( var4 ) )
    {
        var6 thread [[ var4 ]]( var1, var2 );
    }
    else
    {
        thread gunship_handlemovement( var6, var1 );
    }
    
    return var6;
}

// Params 2
// Size: 0x6c
function gunship_handlemovement( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self hide();
    
    if ( isdefined( self.innards ) )
    {
        self.innards hide();
    }
    
    self waittill( "start_moving" );
    self show();
    
    if ( isdefined( self.innards ) )
    {
        self.innards show();
    }
    
    self moveto( var0, var1 );
    thread killaftertime( var1, "c130" );
    thread scripts\mp\gametypes\br_public::gunship_spawnvfx();
    self playloopsound( "br_ac130_lp" );
}

// Params 1
// Size: 0x14
function add_to_spotlight_array( var0 )
{
    var1 = 0;
    var2 = 1;
    return ispointinbounds( var0, var1, var2 );
}

// Params 3
// Size: 0x76
function ispointinbounds( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var3 = scripts\mp\utility\game_utility_mp::track_get_reward_time( var0, var2 );
    
    if ( !var3 )
    {
        return 0;
    }
    
    var4 = scripts\mp\gametypes\br_public::uniquelootcallbacks() || scripts\mp\gametypes\br_public::tutorial_playsound();
    
    if ( var4 && isdefined( level.br_ac130 ) )
    {
        return var3;
    }
    
    var5 = ispointincustomoutofbounds( var0 );
    
    if ( var5 )
    {
        return 0;
    }
    
    if ( vehicle_collision_getdamagefactor( var0 ) )
    {
        return 1;
    }
    
    var6 = scripts\mp\outofbounds::ispointinoutofbounds( var0 );
    
    if ( var6 )
    {
        return 0;
    }
    
    if ( istrue( var1 ) )
    {
        if ( scripts\mp\outofbounds::useshouldsucceedcallback( var0 ) )
        {
            return 0;
        }
    }
    
    return 1;
}

// Params 1
// Size: 0x47, Type: bool
function ispointincustomoutofbounds( var0 )
{
    if ( !isdefined( level.¥Sã€Â™ªÄ’gµ-}ÜH'DPS7wˇ€ ) )
    {
        return false;
    }
    
    foreach ( var2 in level.¥Sã€Â™ªÄ’gµ-}ÜH'DPS7wˇ€ )
    {
        if ( isdefined( var2 ) && ispointinvolume( var0, var2 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x3b
function ref_123af()
{
    var0 = anglestoforward( self.angles );
    
    for ( ;; )
    {
        var1 = vectornormalize( self.ref_12205.ref_1386e - self.origin );
        var2 = vectordot( var0, var1 ) < 0;
        
        if ( var2 )
        {
            break;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x274
function kickwhenoutofbounds( var0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( !scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        setomnvarforallclients( "ui_hide_minimap", 1 );
    }
    
    waitframe();
    ref_123af();
    var1 = relic_ammo_drain_take_ammo();
    
    while ( !add_to_spotlight_array( ( self.origin[ 0 ], self.origin[ 1 ], var1 ) ) )
    {
        waitframe();
    }
    
    if ( !scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        setomnvarforallclients( "ui_hide_minimap", 0 );
    }
    
    var2 = getdvarint( "scr_br_project_kick_for_gas", 1 );
    
    if ( var2 )
    {
        for ( ;; )
        {
            var3 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
            var4 = scripts\mp\gametypes\br_circle::getdangercircleradius();
            
            if ( var4 > 0 )
            {
                var5 = var4 * var4;
                
                if ( distance2dsquared( self.origin, var3 ) <= var5 )
                {
                    break;
                }
            }
            else
            {
                break;
            }
            
            waitframe();
        }
    }
    
    level.delay_music_reinforcements = 1;
    level.c130inbounds = 1;
    level notify( "br_c130_in_bounds" );
    
    for ( ;; )
    {
        var6 = anglestoforward( self.angles );
        var7 = vectornormalize( self.ref_12205.centerpt - self.origin );
        var8 = vectordot( var6, var7 ) < 0;
        
        if ( var8 )
        {
            break;
        }
        
        waitframe();
    }
    
    var9 = getdvarint( "scr_br_project_kick", 3500 );
    
    for ( ;; )
    {
        var6 = anglestoforward( self.angles );
        var10 = self.origin + var6 * var9;
        var10 = ( var10[ 0 ], var10[ 1 ], var1 );
        
        if ( !add_to_spotlight_array( var10 ) )
        {
            level.debugnextpropindex = 1;
            
            foreach ( var12 in level.players )
            {
                if ( isdefined( var12 ) && isdefined( var12.br_infil_type ) && var12.br_infil_type == var0 && !isdefined( var12.jumptype ) )
                {
                    var12.jumptype = "outOfBounds";
                    var12 notify( "halo_kick_c130" );
                }
            }
            
            break;
        }
        
        if ( var2 )
        {
            var3 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
            var4 = scripts\mp\gametypes\br_circle::getdangercircleradius();
            
            if ( var4 > 0 )
            {
                var5 = var4 * var4;
                
                if ( distance2dsquared( var10, var3 ) > var5 )
                {
                    level.debugnextpropindex = 1;
                    
                    foreach ( var12 in level.players )
                    {
                        if ( isdefined( var12 ) && isdefined( var12.br_infil_type ) && var12.br_infil_type == var0 && !isdefined( var12.jumptype ) )
                        {
                            var12.jumptype = "outOfBounds";
                            var12 notify( "halo_kick_c130" );
                        }
                    }
                    
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    level.c130inbounds = undefined;
    level notify( "br_c130_left_bounds" );
    level.infilstruct.playersinc130 = 0;
    setomnvar( "ui_br_players_left_in_plane", level.infilstruct.playersinc130 );
}

// Params 2
// Size: 0x17e
function killaftertime( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    wait var0;
    jumpiffalse(isdefined( self.players )) LOC_00000086;
    
    foreach ( var3 in self.players )
    {
        if ( isdefined( var3 ) && isdefined( var3.br_infil_type ) && var3.br_infil_type == var1 && !isdefined( var3.jumptype ) )
        {
            var3.jumptype = "outOfBounds";
            var3 notify( "halo_kick_c130" );
        }
    }
    
    goto LOC_000000ea;
}

// Params 2
// Size: 0x54
function listenkick( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_c130" );
    self endon( "br_jump" );
    self waittill( "halo_kick_c130", var2 );
    
    if ( !isdefined( var2 ) )
    {
        var2 = ( 0, var0.angles[ 1 ] + 180, 0 );
    }
    
    self.display_hint_for_player_single = 1;
    thread leaveplane( var0, var1, var2, 0 );
}

// Params 2
// Size: 0x289
function listenjump( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_c130" );
    self endon( "br_jump" );
    var2 = undefined;
    self.redeployenabled = 0;
    var3 = getdvarint( "scr_br_squadLeaderForceJump", 0 );
    ref_123af( var0 );
    
    for ( ;; )
    {
        var4 = scripts\engine\utility::waittill_either( "halo_jump_c130", "halo_jump_solo_c130" );
        
        if ( !isdefined( var4 ) )
        {
            var4 = "halo_jump_c130";
        }
        
        var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
        
        if ( !var3 )
        {
            var2 = var0 scripts\mp\gametypes\br_public::calctrailpoint();
            
            if ( add_to_spotlight_array( var2 ) )
            {
                self.jumptype = "solo";
                self notify( "halo_kick_c130" );
                scripts\engine\utility::thread_on_notify( "infil_jump_done", &scripts\mp\gametypes\br_public::updatebrscoreboardstat, "jumpMasterState", 0 );
                break;
            }
            else
            {
                self iprintlnbold( &"MP_BR_INGAME/NOT_PLAYABLE" );
            }
            
            continue;
        }
        
        var6 = scripts\mp\gametypes\br_public::updatedragonsbreath() || isdefined( self.pers[ "squadMemberIndex" ] ) && self.pers[ "squadMemberIndex" ] == 0;
        
        if ( !var6 && var5.size > 1 )
        {
            if ( var4 == "halo_jump_solo_c130" )
            {
                var2 = var0 scripts\mp\gametypes\br_public::calctrailpoint();
                
                if ( add_to_spotlight_array( var2 ) )
                {
                    self.jumptype = "solo";
                    self notify( "halo_kick_c130" );
                    scripts\engine\utility::thread_on_notify( "infil_jump_done", &scripts\mp\gametypes\br_public::updatebrscoreboardstat, "jumpMasterState", 0 );
                    break;
                }
                else
                {
                    self iprintlnbold( &"MP_BR_INGAME/NOT_PLAYABLE" );
                }
            }
            
            continue;
        }
        
        var2 = var0 scripts\mp\gametypes\br_public::calctrailpoint();
        
        if ( add_to_spotlight_array( var2 ) )
        {
            if ( var6 )
            {
                self.jumptype = "leader";
                var7 = isdefined( level.squaddata );
                
                if ( var7 )
                {
                    var8 = level.squaddata[ self.team ][ self.squadindex ];
                    var5 = var8.players;
                }
                
                foreach ( var10 in var5 )
                {
                    if ( var10 != self && isdefined( var10.br_infil_type ) && !isdefined( var10.jumptype ) )
                    {
                        var10.jumptype = "follower";
                        var10 notify( "halo_kick_c130", self getplayerangles() );
                    }
                    
                    var10 playlocalsound( "tmp_br_infil_ac130_jumpmaster_go" );
                }
                
                if ( var4 != "halo_jump_solo_c130" && getdvarint( "scr_br_holdteamtojumpmaster", 0 ) )
                {
                    thread holdteammatestosquadleader( var5 );
                }
                else
                {
                    foreach ( var10 in var5 )
                    {
                        if ( isdefined( var10.br_infil_type ) )
                        {
                            setteammateomnvarsforplayer( var10, var5, 0 );
                        }
                    }
                }
            }
            
            break;
        }
        else
        {
            self iprintlnbold( &"MP_BR_INGAME/NOT_PLAYABLE" );
        }
        
        var2 = var0 scripts\mp\gametypes\br_public::calctrailpoint();
        waitframe();
    }
    
    thread leaveplane( var0, var1, self getplayerangles(), 0 );
}

// Params 4
// Size: 0x147
function leaveplane( var0, var1, var2, var3 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "cancel_c130" );
    setdvarifuninitialized( "scr_br_infil_hudoutline", 1 );
    self notify( "br_jump" );
    self allowcrouch( 1 );
    self allowprone( 1 );
    self.plotarmor = undefined;
    scripts\mp\utility\game::ref_131a3( self, 0 );
    scripts\mp\gametypes\br_public::updatebrscoreboardstat( "isInInfilPlane", 0 );
    
    if ( isdefined( level.infilstruct ) && isdefined( level.infilstruct.playersinc130 ) && level.infilstruct.playersinc130 > 0 )
    {
        level.infilstruct.playersinc130--;
    }
    
    self notifyonplayercommandremove( "halo_jump_c130", "+gostand" );
    self notifyonplayercommandremove( "halo_jump_solo_c130", "+gostand" );
    self notifyonplayercommandremove( "abandon_fireteam_leader", "+frag" );
    self notifyonplayercommandremove( "br_pass_squad_leader", "+usereload" );
    self notifyonplayercommandremove( "br_pass_squad_leader", "+activate" );
    self waittill( "infil_jump_done" );
    
    if ( isdefined( self.br_infil_type ) )
    {
        thread stop_players_inside_death_or_disconnect_monitor( var0 );
    }
    
    self cameradefault();
    self.br_infil_type = undefined;
    thread parachute( var0, var1, var2, var3 );
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "onLeaveAC130" );
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "truckwar" )
    {
        scripts\mp\gametypes\br_gametype_truckwar::getspawnpoint( 1 );
        self setorigin( self.ref_12ab3.origin, 1 );
        self setplayerangles( self.ref_12ab3.angles );
        return;
    }
}

// Params 1
// Size: 0x178
function holdteammatestosquadleader( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    thread ref_144d3( var0 );
    var1 = self;
    wait 0.2;
    var2 = [ ( -250, 0, 0 ), ( -150, -150, 0 ), ( -150, 150, 0 ) ];
    var3 = 0;
    
    foreach ( var5 in var0 )
    {
        if ( !isdefined( var5 ) || !isalive( var5 ) )
        {
            continue;
        }
        
        if ( var5 != var1 )
        {
            if ( isdefined( var5.jumptype ) && var5.jumptype != "solo" )
            {
                thread pushplayertoplayeroffset( var5, var1 );
                var3++;
                continue;
            }
            
            setteammateomnvarsforplayer( var5, var0, 0 );
        }
    }
    
    var7 = 2700;
    var8 = 999999999;
    
    while ( !self usebuttonpressed() && var8 > var7 )
    {
        var9 = scripts\common\utility::groundpos( var1.origin );
        var8 = var1.origin[ 2 ] - var9[ 2 ];
        waitframe();
    }
    
LOC_0000010f:
    foreach ( var11 in var0 )
    {
        if ( var11 != self && istrue( var11.beingpushed ) )
        {
            var11 notify( "stop_push" );
            var11.beingpushed = undefined;
        }
        
        setteammateomnvarsforplayer( var11, var0, 0 );
    LOC_00000163:
    }
    
    self notify( "hold_teammates_complete" );
}

// Params 1
// Size: 0x77
function ref_144d3( var0 )
{
    level endon( "game_ended" );
    self endon( "hold_teammates_complete" );
    scripts\engine\utility::ref_143a5( "death", "disconnect" );
    
    foreach ( var2 in var0 )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        if ( var2 != self && istrue( var2.beingpushed ) )
        {
            var2 notify( "stop_push" );
            var2.beingpushed = undefined;
        }
        
        setteammateomnvarsforplayer( var2, var0, 0 );
    }
}

// Params 3
// Size: 0x23
function setteammateomnvarsforplayer( var0, var1, var2 )
{
    var3 = scripts\engine\utility::ter_op( var0 scripts\mp\gametypes\br_public::updatedragonsbreath(), 2, var2 );
    var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", var3 );
}

// Params 0
// Size: 0x39
function ref_12611()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "stop_push" );
    self waittill( "skydive_deployparachute" );
    var0 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    setteammateomnvarsforplayer( self, var0, 0 );
}

// Params 2
// Size: 0xdb
function pushplayertoplayeroffset( var0, var1 )
{
    level endon( "game_ended" );
    self.beingpushed = 1;
    var2 = self;
    var2 endon( "death_or_disconnect" );
    var2 endon( "stop_push" );
    thread ref_12611();
    var3 = length( var1 );
    
    while ( !var2 isonground() && !var2 usebuttonpressed() && isdefined( var0 ) && !var2 isparachuting() )
    {
        var4 = var0 getplayerangles();
        var5 = rotatepointaroundvector( ( 0, 0, 1 ), var1, var4[ 1 ] );
        var6 = var0.origin + var5 - var2.origin;
        var7 = length( var6 );
        
        if ( var7 > var3 )
        {
            var8 = var2 getvelocity();
            var2 setvelocity( var6 + var8 * 0.9 );
        }
        
        waitframe();
    }
    
    var2 notify( "stop_push" );
    var2.beingpushed = undefined;
    var9 = scripts\mp\utility\teams::getteamdata( var2.team, "players" );
    setteammateomnvarsforplayer( var2, var9, 0 );
}

// Params 4
// Size: 0xb0
function parachute( var0, var1, var2, var3 )
{
    self setclientomnvar( "ui_br_infiled", 1 );
    self setclientomnvar( "ui_hide_nameplate_strings", 0 );
    self unlink();
    
    if ( isdefined( self.br_orbitcam ) )
    {
        self.br_orbitcam delete();
    }
    
    waitframe();
    self playershow( 1 );
    
    if ( isdefined( var2 ) )
    {
        self setplayerangles( var2 );
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        self.delay_give_tactical_grenade = undefined;
        scripts\mp\gametypes\br_analytics::branalytics_deploytriggered( self );
    }
    
    var4 = ( 0, 0, 0 );
    
    if ( var3 )
    {
        var4 = anglestoforward( var0.angles ) * getc130speed();
    }
    
    self.ignorefalldamagetime = gettime() + 5000;
    self skydive_setdeploymentstatus( 0 );
    var5 = getdvarfloat( "scr_br_c130_parachuteEnableDelay", 2 );
    thread scripts\cp_mp\parachute::startfreefall( var5, var1, undefined, var4 );
}

// Params 1
// Size: 0xd7
function stop_players_inside_death_or_disconnect_monitor( var0 )
{
    self endon( "disconnect" );
    var1 = self;
    
    if ( isdefined( var0 ) )
    {
        var0 playsoundtoplayer( "br_ac130_flyby", var1 );
    }
    
    if ( scripts\mp\utility\game::round_vehicle_logic() != "truckwar" && scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "brdov" )
    {
        var1 setsoundsubmix( "mp_br_infil_music", 0 );
        var2 = scripts\mp\music_and_dialog::risk_flagspawnshiftingcenter( "br_infil_jump" );
        var1 setplayermusicstate( var2 );
        var1.stickers = 1;
    }
    
    wait 1;
    var1 clearclienttriggeraudiozone( 3 );
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "reveal" || scripts\mp\utility\game::round_vehicle_logic() == "brdov" )
    {
        wait 3;
        var1 clearsoundsubmix( "mp_br_infil_music", 15 );
        var1 clearsoundsubmix( "mp_br_event_dovp1_infil", 12 );
        return;
    }
    
    wait 5;
    var1 clearsoundsubmix( "mp_br_infil_music", 15 );
}

// Params 1
// Size: 0x26
function setplayervarinrespawnc130( var0 )
{
    if ( isdefined( self.inrespawnc130 ) && self.inrespawnc130 == var0 )
    {
        return;
    }
    
    self.inrespawnc130 = var0;
    level notify( "update_circle_hide" );
}

// Params 0
// Size: 0x95
function waittoplayinfildialog()
{
    level endon( "game_ended" );
    level.br_ac130 endon( "death" );
    ref_123af( level.br_ac130 );
    
    for ( ;; )
    {
        var0 = level.br_ac130 scripts\mp\gametypes\br_public::calctrailpoint();
        
        if ( add_to_spotlight_array( var0 ) )
        {
            foreach ( var2 in level.players )
            {
                if ( isplayer( var2 ) )
                {
                    var2 playlocalsound( "scr_br_infil_ac130_klaxon" );
                }
            }
            
            wait 1;
            scripts\mp\flags::gameflagset( "br_ready_to_jump" );
            scripts\mp\gametypes\br_analytics::branalytics_deployallowed();
            level notify( "stop_suspense_music" );
            level thread scripts\mp\music_and_dialog::suspensemusic();
            return;
        }
        
        waitframe();
    }
}

