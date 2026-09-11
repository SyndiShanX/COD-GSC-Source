
// Params 0
// Size: 0x658
function init()
{
    if ( !getdvarint( "scr_br_alt_mode_escape", 0 ) )
    {
        return;
    }
    
    ammorestock_customlocale6cleanup();
    level.obit_activation = spawnstruct();
    level.obit_activation.ref_14385 = getdvarfloat( "scr_br_escape_incoming_time", 240.9 );
    level.obit_activation.ref_1438f = getdvarfloat( "scr_br_escape_respawn_time", -1 );
    level.obit_activation.ref_129db = getdvarfloat( "scr_br_escape_radio_safe_time", 10 ) + level.obit_activation.ref_14385;
    level.obit_activation.ref_13b6e = getdvarfloat( "scr_br_escape_time_added_when_dropped", 20 );
    level.obit_activation.„òsÐÛÚ“©˜³þZ  = getdvarfloat( "scr_br_escape_time_bonus_gap", 30 );
    level.obit_activation.ref_129d7 = getdvarfloat( "scr_br_escape_radio_idle_time", 45 );
    level.obit_activation.unset_forced_aitype = getdvarint( "scr_br_alt_mode_escape_radio_reset_enable", 0 );
    level.obit_activation.ref_12c73 = getdvarint( "scr_br_alt_mode_escape_radio_reset_on_oob", 1 );
    level.obit_activation.½ª=RºK‹å³xHÇ7 Ÿý$4*²9 = getdvarint( "scr_br_alt_mode_escape_radio_oob_offset", -15 );
    level.obit_activation.unset_just_keep_moving = getdvarint( "scr_br_alt_mode_escape_extended_version", 1 );
    level.obit_activation.ref_129d6 = getdvarint( "scr_br_alt_mode_escape_radio_delete_loot_radius", 128 );
    level.obit_activation.onspawn_fastspeed = getdvarint( "scr_br_alt_mode_escape_radio_xp_pickup", 900 );
    level.obit_activation.onspawn_slowspeed = getdvarint( "scr_br_alt_mode_escape_radio_xp_win", 15000 );
    level.obit_activation.ref_129d5 = getdvarint( "scr_br_alt_mode_escape_radio_circle_peek", 1 );
    level.obit_activation.start_fly_over = getdvarint( "scr_br_alt_mode_escape_radio_incoming_respawn_time", 30 );
    level.obit_activation.personalscorecount = getdvarint( "scr_br_alt_mode_escape_radio_fast_respawn_time", 10 );
    level.obit_activation.ref_129d8 = getdvarint( "scr_br_alt_mode_escape_radio_max_time_in_gas", 15 );
    level.obit_activation.personalnukecostoverride = getdvarint( "scr_br_alt_mode_escape_radio_fast_respawn_index", 5 );
    level.obit_activation.obj_destroy_tanks = [];
    level.obit_activation.obj_fob1 = [];
    level.obit_activation.obj_cleanup = [];
    level.obit_activation.obj_a_covers = [];
    level.obit_activation.ref_12345 = 0;
    level.obit_activation.ref_129da = -1;
    game[ "dialog" ][ "last_man_standing" ] = "rsrg_squad_last_alive";
    game[ "dialog" ][ "rebirth_avenge_teammate" ] = "rebirth_avenge_teammate";
    game[ "dialog" ][ "rebirth_redeploy" ] = "rebirth_redeploy";
    game[ "dialog" ][ "rebirth_disabled" ] = "rebirth_reinforcement_disabled";
    game[ "dialog" ][ "rebirth_ending" ] = "rebirth_reinforcement_ending";
    game[ "dialog" ][ "rebirth_teammate_respawn" ] = "rebirth_teammate_respawn";
    game[ "dialog" ][ "exit_strategy_chopper_inbound" ] = "exit_strategy_chopper_inbound";
    game[ "dialog" ][ "escape_chopper_comms_online" ] = "cp1_escape_chopper_comms_online";
    game[ "dialog" ][ "exit_strategy_teammate_pickup" ] = "exit_strategy_teammate_pickup";
    game[ "dialog" ][ "escape_radio_picked_up_enemy" ] = "escape_radio_picked_up_enemy";
    game[ "dialog" ][ "exit_strategy_less_than_4_min" ] = "exit_strategy_less_than_4_min";
    game[ "dialog" ][ "exit_strategy_less_than_3_min" ] = "exit_strategy_less_than_3_min";
    game[ "dialog" ][ "exit_strategy_less_than_2_min" ] = "exit_strategy_less_than_2_min";
    game[ "dialog" ][ "exit_strategy_less_than_60_sec" ] = "exit_strategy_less_than_60_sec";
    game[ "dialog" ][ "exit_strategy_less_than_45_sec" ] = "exit_strategy_less_than_45_sec";
    game[ "dialog" ][ "exit_strategy_less_than_20_sec" ] = "exit_strategy_less_than_20_sec";
    game[ "dialog" ][ "exit_strategy_less_than_10_sec" ] = "exit_strategy_less_than_10_sec";
    game[ "dialog" ][ "exit_strategy_less_than_5_sec" ] = "exit_strategy_less_than_5_sec";
    game[ "dialog" ][ "escape_radio_incoming" ] = "escape_radio_incoming";
    game[ "dialog" ][ "escape_radio_spawned" ] = "escape_radio_spawned";
    game[ "dialog" ][ "exit_strategy_radio_down" ] = "exit_strategy_radio_down";
    game[ "dialog" ][ "exit_strategy_radio_strength" ] = "exit_strategy_radio_strength";
    game[ "dialog" ][ "exit_strategy_radio_fixing" ] = "exit_strategy_radio_fixing";
    game[ "dialog" ][ "gametype_exit_strategy" ] = "gametype_exit_strategy";
    game[ "dialog" ][ "gametype_exfiltration" ] = "gametype_exfiltration";
    game[ "dialog" ][ "exit_strategy_carrier_down" ] = "exit_strategy_carrier_down";
    game[ "dialog" ][ "exit_strategy_carrier_hit" ] = "exit_strategy_carrier_hit";
    game[ "dialog" ][ "exit_strategy_radio_carrier" ] = "exit_strategy_radio_carrier";
    game[ "dialog" ][ "exit_strategy_survive" ] = "exit_strategy_survive";
    game[ "dialog" ][ "exit_strategy_update_heading" ] = "exit_strategy_update_heading";
    level.obit_activation.ref_13bfd = getdvarint( "scr_br_alt_mode_escape_win_timer", 300.9 );
    level.obit_activation.ref_145cd = level.obit_activation.ref_13bfd;
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &ref_12069 );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "vehicle_spawn", "gameModeSupportsRespawn", &vehicle_spawn_mp_gamemodesupportsrespawn );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "preOnPlayerKilled", &onplayerkilled );
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "endGame", &obit_trigger_for_player );
    
    if ( getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "createC130PathStruct", &init_relic_aggressive_melee );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "addToC130Infil", &being_hacked );
    }
    
    scripts\mp\gametypes\br_gametypes::ref_12b10( "dropBagDelay", 180 );
    
    if ( getdvarint( "scr_br_escape_alt_respawn_system_enable", 0 ) == 0 )
    {
        if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "gulag" ) )
        {
            level scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
        }
        
        level.usegulag = 0;
        level.obit_activation.ref_121ad = 3;
        level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand();
    }
    else
    {
        level.disable_super_in_turret.ref_12ca4 = 1;
        level.disable_super_in_turret.fly_to_laser_trap_start_pos = 1;
        level.disable_super_in_turret.ref_14081 = 1;
        scripts\mp\gametypes\br_gametype_rebirth::end_reach_icbm_launch();
        var0 = 30;
        level.disable_super_in_turret.ref_12a7b = var0;
        level.playingtutorialdialogue[ "mayConsiderPlayerDead" ] = &scripts\mp\gametypes\br_gametype_rebirth::empty_function;
        level.playingtutorialdialogue[ "triggerRespawnOverlay" ] = &scripts\mp\gametypes\br_gametype_rebirth::end_silo_thrust;
        level.playingtutorialdialogue[ "playerNakedDropLoadout" ] = &scripts\mp\gametypes\br_gametype_rebirth::end_intro_obj;
        level.playingthrowingknifewickfx[ "mayConsiderPlayerDead" ] = &scripts\mp\gametypes\br::dynamic_door;
        level.playingthrowingknifewickfx[ "triggerRespawnOverlay" ] = &scripts\mp\gametypes\br_gulag::ref_13dcc;
        level.playingthrowingknifewickfx[ "playerNakedDropLoadout" ] = &scripts\mp\gametypes\br::ref_11e23;
        scripts\mp\gametypes\br_gametypes::ref_12b11( "mayConsiderPlayerDead", &add_pack_playeranim );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "triggerRespawnOverlay", &add_pilot_setup );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "playerNakedDropLoadout", &add_pack_startfunc );
    }
    
    level.nosuspensemusic = 1;
    level.ref_11e96 = 1;
    level.ref_1205e = &ref_131a9;
    thread ai_hold_wake_watch();
    thread anyone_can_see_spawner();
    thread ammoids();
    level.ref_13364 = 1;
    level.disable_super_in_turret.“Ô O¿Kx¨¸CÁƒ[Hs€ = getdvarint( "scr_br_loadout_restore_on_respawn", 1 );
    level.ref_133ea = getdvarint( "scr_bmo_skipWeaponDropOnDeath", 0 );
}

// Params 1
// Size: 0x46, Type: bool
function updatenukeprogress( var0 )
{
    if ( !isdefined( level.obit_activation.radio ) || !isdefined( level.obit_activation.radio.ownerteam ) )
    {
        return false;
    }
    
    return var0.team == level.obit_activation.radio.ownerteam;
}

// Params 1
// Size: 0x58
function addtodismembermentlist( var0 )
{
    foreach ( var2 in scripts\mp\utility\teams::getteamdata( var0.team, "players" ) )
    {
        var3 = !isalive( var2 );
        
        if ( var2 != var0 && var3 )
        {
            var2 notify( "force_stop_respawn" );
            var2 scripts\mp\gametypes\br_gametype_rebirth::end_ml_p3_exfil();
        }
    }
}

// Params 1
// Size: 0x75
function add_pack_playeranim( var0 )
{
    var1 = "mayConsiderPlayerDead";
    
    if ( updatenukeprogress( var0 ) && isdefined( level.playingtutorialdialogue[ var1 ] ) )
    {
        if ( level.obit_activation.radio.owner == var0 )
        {
            addtodismembermentlist( var0 );
            return [[ level.playingthrowingknifewickfx[ var1 ] ]]( var0 );
        }
        else
        {
            return [[ level.playingtutorialdialogue[ var1 ] ]]( var0 );
        }
    }
    else if ( isdefined( level.playingthrowingknifewickfx[ var1 ] ) )
    {
        return [[ level.playingthrowingknifewickfx[ var1 ] ]]( var0 );
    }
    
    return undefined;
}

// Params 0
// Size: 0xd
function add_pilot_setup()
{
    return ref_12182( "triggerRespawnOverlay" );
}

// Params 0
// Size: 0xd
function add_pack_startfunc()
{
    return ref_12182( "playerNakedDropLoadout" );
}

// Params 1
// Size: 0x56
function ref_12182( var0 )
{
    var1 = self;
    
    if ( updatenukeprogress( var1 ) && level.obit_activation.radio.owner != var1 && isdefined( level.playingtutorialdialogue[ var0 ] ) )
    {
        return [[ level.playingtutorialdialogue[ var0 ] ]]();
    }
    
    if ( isdefined( level.playingthrowingknifewickfx[ var0 ] ) )
    {
        return [[ level.playingthrowingknifewickfx[ var0 ] ]]();
    }
}

// Params 0
// Size: 0x55
function ai_hold_wake_watch()
{
    if ( level.obit_activation.ref_129da == -1 )
    {
        level waittill( "prematch_fade_done" );
        waitframe();
        
        if ( !istrue( level.br_circle_disabled ) )
        {
            while ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.safecircleent ) )
            {
                waitframe();
            }
        }
        
        _escaperadiologic( 1 );
        return;
    }
    
    _escaperadiologic( 4 );
}

// Params 1
// Size: 0x67
function _escaperadiologic( var0 )
{
    var1 = obj_a_post_behavior();
    level.obit_activation.radio = ai_goto_ascender_and_wait( var1 + ( 0, 0, 10 ), var0 );
    thread obj_fob1_juggs( level );
    ai_dropgren_override_hide();
    scripts\mp\flags::gameflagwait( "br_ready_to_jump" );
    ai_give_flashlight( var0 );
    thread obit_destroy_old_vehicles( level, level.obit_activation.radio );
}

// Params 0
// Size: 0x3b
function ammorestock_customlocale6cleanup()
{
    if ( !getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) )
    {
        return;
    }
    
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "randomizeCircleCenter" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "planeSnapToOOB" );
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "planeUseCircleRadius" );
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "circleEarlyStart" );
}

// Params 0
// Size: 0x42
function init_relic_aggressive_melee()
{
    var0 = ( level.br_level.default_class_chosen[ 1 ][ 0 ], level.br_level.default_class_chosen[ 1 ][ 1 ], 0 );
    var1 = level.br_level.br_circleradii[ 1 ];
    var2 = scripts\mp\gametypes\br_c130::createtestc130path( var0, var1 );
    return var2;
}

// Params 0
// Size: 0x8
function being_hacked()
{
    thread vehomn_getleveldata();
}

// Params 0
// Size: 0x9e
function vehomn_getleveldata()
{
    level endon( "game_ended" );
    self endon( "death" );
    var0 = distance( self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor );
    var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
    wait var1;
    
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3 ) && isdefined( var3.br_infil_type ) && var3.br_infil_type == "c130" && !isdefined( var3.jumptype ) )
        {
            var3.jumptype = "outOfBounds";
            var3 notify( "halo_kick_c130" );
        }
    }
}

// Params 0
// Size: 0x5c
function ammoids()
{
    if ( !getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) )
    {
        return;
    }
    
    waittillframeend();
    level.br_level.br_circledelaytimes[ 1 ] = level.br_level.br_circledelaytimes[ 0 ];
    level.br_level.br_circledelaytimes[ 0 ] = 1;
    level.br_level.br_circleclosetimes[ 0 ] = 1;
    level.br_level.default_player_connect_black_screen[ 0 ] = 1;
}

// Params 1
// Size: 0x2b
function obj_fob2( var0 )
{
    level endon( "game_ended" );
    scripts\mp\gametypes\br_public::brleaderdialog( "gametype_exfiltration", 0, var0 );
    wait 1.5;
    scripts\mp\gametypes\br_public::brleaderdialog( "gametype_exit_strategy", 0, var0 );
}

// Params 1
// Size: 0x1b6
function obj_fob1_juggs( var0 )
{
    level endon( "radio_debug_spawned" );
    
    if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
    {
        var1 = [ 1000, 3000, 5000, 7000, 13000 ];
        var2 = [ 0, 30, 90, 120, 180 ];
    }
    else
    {
        var1 = [ 3000, 7000, 10000, 13000, 17500 ];
        var2 = [ 0, 45, 90, 135, 180 ];
    }
    
    level.obit_activation.ref_129d4 = gettime() + level.obit_activation.ref_14385 * 1000;
    var3 = level.obit_activation.ref_14385;
    var4 = undefined;
    var5 = -1;
    
    if ( level.obit_activation.ref_14385 > var2[ 4 ] )
    {
        var5 = 4;
    }
    else if ( level.obit_activation.ref_14385 > var2[ 3 ] )
    {
        var5 = 3;
    }
    else if ( level.obit_activation.ref_14385 > var2[ 2 ] )
    {
        var5 = 2;
    }
    else if ( level.obit_activation.ref_14385 > var2[ 1 ] )
    {
        var5 = 1;
    }
    else if ( level.obit_activation.ref_14385 > var2[ 0 ] )
    {
        var5 = 0;
    }
    
    jumpiffalse(var5 < 0) LOC_00000122;
    wait 3;
    
    while ( var5 >= 0 )
    {
        var3 -= var2[ var5 ];
        ai_ascender_giveascender( var2, var1[ var5 ] );
        scripts\mp\flags::gameflagwait( "br_ready_to_jump" );
        
        if ( var5 == 0 )
        {
            ai_fire_at_chopper( var2[ 1 ] );
            var4 = scripts\engine\utility::play_loopsound_in_space( "iw8_nuke_alarm_lp", var2.origin );
        }
        
        var6 = ai_ascender_getclosestdescender( var3 );
        
        if ( !isdefined( var6 ) )
        {
            var5 = 0;
        }
        
        ai_ascender_getstartpos( var2 );
        var3 = var2[ var5 ];
        var5--;
    }
    
    ai_ascender_getstartpos( var2 );
    
    if ( isdefined( var4 ) )
    {
        var4 delete();
    }
    
    level.obit_activation.ref_129da = 1;
    level notify( "radio_landed" );
}

// Params 2
// Size: 0x141
function obit_destroy_old_vehicles( var0, var1 )
{
    level endon( "game_ended" );
    level endon( "radio_debug_spawned" );
    
    foreach ( var3 in level.players )
    {
        if ( !var3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            var3 scripts\mp\hud_message::showsplash( "br_escape_radio_incoming" );
        }
    }
    
    var5 = 255;
    var6 = level.obit_activation.ref_14385;
    var7 = level.obit_activation.ref_14385;
    ai_extra_think( var1, var5, var6, 0 );
    ai_fire_at_chopper( var7 );
    level waittill( "radio_landed" );
    
    foreach ( var3 in level.players )
    {
        if ( !var3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            var3 scripts\mp\hud_message::showsplash( "br_escape_radio_dropped" );
        }
    }
    
    obj_hvt_dead( "escape_radio_spawned", 0.75, 1 );
    ai_dropgren_override_hide();
    ai_hold_wake_behavior( var0, "on_ground" );
    ai_goal_distribution_debug( var0 );
    var1 = 2;
    var5 = 255;
    var6 = level.obit_activation.ref_13bfd;
    var7 = level.obit_activation.ref_145cd;
    level.obit_activation.radio.waittime = var7;
    ai_extra_think( var1, var5, var6 );
    ai_fire_at_chopper( var7, 1 );
    ai_deaf_event_active( level, var0.origin );
}

// Params 1
// Size: 0x15
function ai_ascender_getclosestdescender( var0 )
{
    return level.obit_activation scripts\engine\utility::waittill_notify_or_timeout_return( "force_incoming", var0 );
}

// Params 0
// Size: 0x75
function obj_a_roof_jugg()
{
    if ( !isdefined( level.br_level ) || !isdefined( level.br_level.br_circledelaytimes ) )
    {
        return 0;
    }
    
    var0 = level.br_level.delay_start_infiltrate_objective;
    
    if ( !isdefined( var0 ) )
    {
        var0 = 0;
    }
    
    var1 = 0;
    
    if ( level.obit_activation.unset_just_keep_moving )
    {
        var1 = getdvarint( "scr_br_escape_start_circles_remaining", 6 );
    }
    else
    {
        var1 = getdvarint( "scr_br_escape_start_circles_remaining", 3 );
    }
    
    var2 = level.br_level.br_circledelaytimes.size - 1 - var1 - var0;
    return var2;
}

// Params 1
// Size: 0x4c
function relic_amped_victim( var0 )
{
    var1 = 0;
    
    for ( var2 = 0; var2 < level.br_level.br_circledelaytimes.size && var2 < var0 ; var2++ )
    {
        var1 += level.br_level.br_circledelaytimes[ var2 ] + level.br_level.br_circleclosetimes[ var2 ];
    }
    
    return var1;
}

// Params 0
// Size: 0xf1
function obj_a_post_behavior()
{
    var0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
    var2 = ref_11a00( var0, var1 );
    var3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo( "escape", var2 );
    var4 = undefined;
    var5 = "none";
    
    if ( isdefined( var3 ) )
    {
        var4 = var3.origin;
        var5 = "chest";
    }
    else
    {
        var6 = 0;
        var7 = 1;
        var8 = 1;
        var9 = 1;
        var10 = 1;
        var11 = level.obit_activation.ref_129db;
        var4 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( var0, var1, var6, var7, var8, var9, var10, var11 );
        
        if ( var4 == var0 )
        {
            var12 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
            var4 = scripts\engine\utility::drop_to_ground( ( var4[ 0 ], var4[ 1 ], 4000 ), undefined, undefined, undefined, var12 );
            
            if ( var9 && isscriptabledefined() )
            {
                var4 = getclosestpointonnavmesh( var4 );
            }
        }
        
        var5 = "random";
    }
    
    logstring( "Escape Mode: Circle o:" + var0 + " r:" + var1 + " Radio o:" + var4 + " t:" + var5 );
    return var4;
}

// Params 1
// Size: 0x273
function obj_heli_assault3_fob( var0 )
{
    var1 = self.tracknonoobplayerlocation;
    level endon( "game_ended" );
    level endon( "force_end" );
    level notify( "radio_state_change" );
    var1 endon( "death" );
    var2 = 0;
    
    foreach ( var4 in level.players )
    {
        if ( var4.team == var0.team )
        {
            if ( var4 == var0 )
            {
                level thread scripts\mp\gametypes\br_quest_util::ref_140b1( var0.origin, "revive" );
                thread ai_dropgren_override_hint( var4, "escape_chopper_comms_online" );
                var4 scripts\mp\hud_message::showsplash( "br_escape_radio_picked_up_self" );
                thread ai_dropgren_weapontype( var4, "exit_strategy_survive", 0.75 );
            }
            else
            {
                if ( !var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
                {
                    thread ai_dropgren_override_hint( var4, "escape_chopper_comms_online" );
                }
                
                var4 scripts\mp\hud_message::showsplash( "br_escape_radio_picked_up_ally" );
                thread ai_dropgren_weapontype( var4, "exit_strategy_teammate_pickup", 0.75 );
                var5 = scripts\mp\gametypes\br_vip_quest::ref_142c5( var4, var0, "exfil_respawn" );
                
                if ( var5 && !var2 )
                {
                    var2 = 1;
                    var0 thread scripts\mp\hud_message::showsplash( "br_squadmate_revived" );
                }
            }
            
            continue;
        }
        
        if ( !var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            thread ai_dropgren_override_hint( var4, "escape_chopper_comms_online" );
            var4 scripts\mp\hud_message::showsplash( "br_escape_radio_picked_up_enemy" );
            thread ai_dropgren_weapontype( var4, "escape_radio_picked_up_enemy", 0.75 );
        }
    }
    
    ai_hold_positions_freed( var1 );
    ai_hold_wake_behavior( var1, "picked_up", var0 );
    ai_dismount_turret( var1 );
    var1.owner = var0;
    var1.ref_121ae = var1.ownerteam;
    var1.ownerteam = var1.owner.team;
    var7 = scripts\mp\utility\teams::getteamdata( var1.ownerteam, "players" );
    managekingflag( var7, 1 );
    var0 thread scripts\mp\utility\points::giveunifiedpoints( "br_escape_radio_looted" );
    
    if ( level.obit_activation.onspawn_fastspeed > 0 )
    {
        setteamscore( var1.ownerteam, getteamscore( var1.ownerteam ) + level.obit_activation.onspawn_fastspeed );
    }
    
    level.obit_activation.ref_12345 = gettime();
    ai_dropgren_override_hide();
    var8 = 3;
    var9 = var0 getentitynumber();
    var10 = level.obit_activation.ref_13bfd;
    var11 = level.obit_activation.ref_145cd;
    ai_extra_think( var8, var9, var10, 0 );
    ai_fire_at_chopper( var11 );
    thread obj_heli_assault2();
    thread ai_goal_update_population( var1.owner );
    level.obit_activation.ref_129d1 = var0.team;
    var1 notify( "escape_radio_picked_up" );
    ai_hold_free( var0, var1 );
}

// Params 2
// Size: 0x4e
function ai_dropgren_override_hint( var0, var1 )
{
    var2 = self;
    var2 endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "cancel_escapeRadioPlayChopperDialog" );
    
    if ( isdefined( var1 ) )
    {
        wait var1;
    }
    
    var3 = "dx_bra_" + game[ "dialog" ][ var0 ];
    var3 = tolower( var3 );
    var4 = lookupsoundlength( var3, 1 ) / 1000;
    var2 queuedialogforplayer( var3, var0, var4 );
}

// Params 3
// Size: 0x2e
function ai_dropgren_weapontype( var0, var1, var2 )
{
    var3 = self;
    var3 endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "radio_state_change" );
    
    if ( isdefined( var1 ) )
    {
        wait var1;
    }
    
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var0, var3, var2 );
}

// Params 3
// Size: 0xf
function obj_hvt_dead( var0, var1, var2 )
{
    thread ai_excluder( var0, var1, var2 );
}

// Params 3
// Size: 0x4a
function ai_excluder( var0, var1, var2 )
{
    level endon( "game_ended" );
    level endon( "radio_state_change" );
    
    if ( isdefined( var1 ) )
    {
        wait var1;
    }
    
    foreach ( var4 in level.players )
    {
        ai_dropgren_weapontype( var4, var0, undefined, var2 );
    }
}

// Params 1
// Size: 0x54
function ai_hold_free( var0 )
{
    var1 = self;
    var1 endon( "escape_radio_win_timer_wait" );
    level endon( "game_ended" );
    
    if ( isdefined( level.obit_activation.radio.waittime ) )
    {
        ai_hold_positions( level.obit_activation.radio.waittime );
        return;
    }
    
    ai_hold_positions( level.obit_activation.ref_145cd );
}

// Params 1
// Size: 0x278
function mlgmodifyheadshotdamage( var0 )
{
    var1 = self;
    level.obit_activation notify( "escape_radio_dropped" );
    level notify( "cancel_escapeRadioPlayChopperDialog" );
    level notify( "radio_state_change" );
    var1 notify( "escape_radio_win_timer_wait" );
    var1 endon( "escape_radio_win_timer_wait" );
    level endon( "game_ended" );
    thread obj_caches_threaded_nags_vo();
    thread obj_a_goals();
    ai_goal_distribution( 0 );
    var2 = _escaperadiogetremainingtime();
    
    if ( var2 <= 0 )
    {
        var2 = level.obit_activation.„òsÐÛÚ“©˜³þZ ;
    }
    
    var3 = ceil( var2 / level.obit_activation.„òsÐÛÚ“©˜³þZ  ) * level.obit_activation.„òsÐÛÚ“©˜³þZ ;
    var4 = min( level.obit_activation.ref_13bfd, var3 );
    level.obit_activation.radio.waittime = min( var4, var2 + level.obit_activation.ref_13b6e );
    level.obit_activation.ref_145cd = level.obit_activation.radio.waittime;
    ai_hold_positions_freed( level.obit_activation.radio );
    ai_dropgren_model();
    
    if ( getdvarint( "scr_br_escape_alt_respawn_system_enable", 0 ) != 0 )
    {
        ai_ground_set_goal_radii( var1 );
    }
    
    var5 = scripts\mp\utility\teams::getteamdata( var1.team, "players" );
    managekingflag( var5, 0 );
    var6 = 2;
    var7 = 255;
    var8 = level.obit_activation.ref_13bfd;
    var9 = level.obit_activation.radio.waittime;
    ai_extra_think( var6, var7, var8, 0 );
    ai_fire_at_chopper( var9, 1 );
    var10 = var9 - var2;
    setomnvar( "ui_br_exfil_radio_added_time", int( var10 ) );
    level.obit_activation.ref_129d1 = undefined;
    level.obit_activation.radio freescriptable();
    var11 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var0, var1.origin, var1.angles, self, 0, 0, 10, 1 );
    level.obit_activation.radio = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_escape_radio", var11, 0, 1 );
    level.obit_activation.radio.init_weapon_placements = 1;
    level.obit_activation.radio.keepinmap = 1;
    level.obit_activation.radio.hidden = 0;
    thread ai_deaf_event_active( level.obit_activation.radio );
    
    foreach ( var1 in level.players )
    {
        if ( !var1 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            var1 scripts\mp\hud_message::showsplash( "br_escape_radio_on_ground" );
        }
    }
    
    obj_hvt_dead( "exit_strategy_radio_down", 0.75, 1 );
    ai_hold_wake_behavior( level.obit_activation.radio, "on_ground" );
}

// Params 0
// Size: 0xff
function obj_caches_threaded_nags_vo()
{
    if ( level.obit_activation.ref_12c73 != 1 )
    {
        return;
    }
    
    level endon( "radio_state_change" );
    level endon( "radio_oob" );
    level endon( "game_ended" );
    var0 = undefined;
    var1 = ( 0, 0, level.obit_activation.½ª=RºK‹å³xHÇ7 Ÿý$4*²9 );
    var2 = getentarray( "trigger_hurt", "classname" );
    var3 = getentarray( "trigger_hurt_no_heli", "targetname" );
    var4 = scripts\engine\utility::array_combine( var2, var3 );
    
    for ( ;; )
    {
        if ( isdefined( level.obit_activation.radio ) )
        {
            if ( isdefined( var0 ) && var0 == level.obit_activation.radio.origin )
            {
                foreach ( var6 in var4 )
                {
                    if ( ispointinvolume( level.obit_activation.radio.origin + var1, var6 ) )
                    {
                        thread obj_a_behavior();
                        level notify( "radio_oob" );
                    }
                }
                
                break;
            }
            else
            {
                var0 = level.obit_activation.radio.origin;
            }
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x40
function obj_a_behavior()
{
    level endon( "radio_state_change" );
    level endon( "game_ended" );
    wait 2.5;
    obj_hvt_dead( "exit_strategy_radio_strength", 0, 1 );
    wait 2.5;
    thread ai_ascender_use( level.obit_activation.radio );
}

// Params 0
// Size: 0x71
function obj_a_goals()
{
    if ( level.obit_activation.unset_forced_aitype != 1 )
    {
        return;
    }
    
    level endon( "radio_state_change" );
    level endon( "radio_oob" );
    level endon( "game_ended" );
    wait level.obit_activation.ref_129d7 * 0.75;
    obj_hvt_dead( "exit_strategy_radio_strength", 0, 1 );
    wait level.obit_activation.ref_129d7 * 0.25;
    thread ai_ascender_use( level.obit_activation.radio );
}

// Params 1
// Size: 0x4f
function ai_ground_set_goal_radii( var0 )
{
    foreach ( var0 in scripts\mp\utility\teams::getteamdata( var0.team, "players" ) )
    {
        var0 notify( "force_stop_respawn" );
        var0 scripts\mp\gametypes\br_gametype_rebirth::brrebirth_hiderebirthrespawntimer();
        var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
    }
}

// Params 1
// Size: 0x7d
function ai_damage_monitor( var0 )
{
    if ( level.obit_activation.ref_129d6 <= 0 )
    {
        return;
    }
    
    var1 = canceljoins( undefined, undefined, var0, level.obit_activation.ref_129d6 );
    
    if ( isdefined( var1 ) )
    {
        foreach ( var3 in var1 )
        {
            if ( !scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc( var3, 0 ) )
            {
                continue;
            }
            
            if ( var3 getscriptableisreserved() && !isdefined( var3.embassy_main ) )
            {
                continue;
            }
            
            scripts\mp\gametypes\br_pickups::ref_11a21( var3 );
        }
        
        return;
    }
}

// Params 1
// Size: 0x33
function ai_deaf_event_active( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "escape_radio_picked_up" );
    
    if ( level.obit_activation.ref_129d6 <= 0 )
    {
        return;
    }
    
    for ( ;; )
    {
        ai_damage_monitor( var0 );
        wait 2;
    }
}

// Params 1
// Size: 0x53
function ai_hold_positions( var0 )
{
    var1 = self;
    var1 endon( "escape_radio_win_timer_wait" );
    var1 endon( "disconnect" );
    thread ai_ascender_takeascender( var1 );
    thread ai_ground_think( var1 );
    ai_flash_swap( level.obit_activation.ref_13bfd );
    ai_fire_at_chopper( var0 );
    wait var0;
    ai_dropgren_override_hide();
    ai_delete_after_level_notify( var1.team, 1 );
}

// Params 0
// Size: 0x71
function _escaperadiogetremainingtime()
{
    var0 = gettime() - level.obit_activation.ref_12345;
    var1 = level.obit_activation.ref_145cd - var0 / 1000;
    
    if ( isdefined( level.obit_activation.radio.²æPóMkãÚ5³¥¢Óµ{ õ“ ) && level.obit_activation.radio.²æPóMkãÚ5³¥¢Óµ{ õ“ > 0 )
    {
        var2 = level.obit_activation.radio.²æPóMkãÚ5³¥¢Óµ{ õ“ / 1000;
        var1 += var2;
    }
    
    return var1;
}

// Params 1
// Size: 0x88
function ai_ascender_takeascender( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    level endon( "force_end" );
    level.obit_activation endon( "escape_radio_dropped" );
    var1 endon( "escape_radio_win_timer_wait" );
    var1 endon( "disconnect" );
    var2 = 10;
    var3 = max( 0, var0 - var2 );
    wait var3;
    
    while ( var2 > 1 )
    {
        var4 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc( var2 );
        
        foreach ( var6 in level.players )
        {
            var6 playlocalsound( var4 );
        }
        
        var2 -= 1;
        wait 1;
    }
}

// Params 1
// Size: 0x163
function ai_ground_think( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    level endon( "force_end" );
    level.obit_activation endon( "escape_radio_dropped" );
    var1 endon( "escape_radio_win_timer_wait" );
    var1 endon( "disconnect" );
    var2 = [];
    
    if ( var0 >= 240 )
    {
        var2 = [ 240, 180, 120, 60, 45, 20, 10, 5 ];
    }
    else if ( var0 >= 180 )
    {
        var2 = [ 180, 120, 60, 45, 20, 10, 5 ];
    }
    else if ( var0 >= 120 )
    {
        var2 = [ 120, 60, 45, 20, 10, 5 ];
    }
    else if ( var0 >= 60 )
    {
        var2 = [ 60, 45, 20, 10, 5 ];
    }
    else if ( var0 >= 45 )
    {
        var2 = [ 45, 20, 10, 5 ];
    }
    else if ( var0 >= 20 )
    {
        var2 = [ 20, 10, 5 ];
    }
    else if ( var0 >= 10 )
    {
        var2 = [ 10, 5 ];
    }
    else if ( var0 >= 5 )
    {
        var2 = [ 5 ];
    }
    
    for ( var3 = 0; var3 < var2.size ; var3++ )
    {
        var4 = var0 - var2[ var3 ];
        var0 -= var4;
        wait var4;
        
        if ( var2[ var3 ] <= 60 )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "exit_strategy_less_than_" + var2[ var3 ] + "_sec" );
            continue;
        }
        
        scripts\mp\gametypes\br_public::brleaderdialog( "exit_strategy_less_than_" + var2[ var3 ] / 60 + "_min" );
    }
}

// Params 2
// Size: 0x5f
function ai_goto_ascender_and_wait( var0, var1 )
{
    var2 = easepower( "brloot_escape_radio", var0 );
    var2.keepinmap = 1;
    var3 = 255;
    var4 = level.obit_activation.ref_14385;
    var5 = level.obit_activation.ref_14385;
    ai_extra_think( var1, var3, var4, 0 );
    ai_fire_at_chopper( var5 );
    ai_dismount_turret( var2 );
    level.obit_activation.radio = var2;
    return var2;
}

// Params 0
// Size: 0x41
function ai_hold_debug()
{
    self notify( "_escapeRadioUpdateIconPosition" );
    self endon( "_escapeRadioUpdateIconPosition" );
    self endon( "escape_radio_icon_hide" );
    self endon( "death" );
    
    for ( ;; )
    {
        scripts\mp\objidpoolmanager::update_objective_position( self.icon, self.origin + ( 0, 0, 50 ) );
        waitframe();
    }
}

// Params 2
// Size: 0xbd
function ai_hold_wake_behavior( var0, var1 )
{
    var2 = self;
    
    if ( var0 == "picked_up" )
    {
        ammobox_giverandomattachment( var2, var1, "ui_mp_br_mapmenu_icon_escape_objective_friendly", "ui_mp_br_mapmenu_icon_escape_objective_enemy" );
        return;
    }
    
    if ( var0 == "on_ground" )
    {
        var3 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
        
        if ( var3 != -1 )
        {
            scripts\mp\objidpoolmanager::objective_add_objective( var3, "current", var2.origin + ( 0, 0, 50 ), "ui_mp_br_mapmenu_icon_escape_objective" );
            scripts\mp\objidpoolmanager::update_objective_setbackground( var3, 1 );
            
            foreach ( var5 in level.players )
            {
                if ( !var5 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
                {
                    objective_addclienttomask( var3, var5 );
                }
            }
            
            objective_showtoplayersinmask( var3 );
            var2.icon = var3;
            thread ai_hold_debug();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x6b
function ai_hold_positions_freed()
{
    var0 = self;
    var0 notify( "escape_radio_icon_hide" );
    
    if ( isdefined( var0.icon ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var0.icon );
        var0.icon = undefined;
    }
    
    if ( isdefined( var0.playersetattractionstateindex ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var0.playersetattractionstateindex );
        var0.playersetattractionstateindex = undefined;
    }
    
    if ( isdefined( var0.nuke_cancel ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var0.nuke_cancel );
        var0.nuke_cancel = undefined;
        return;
    }
}

// Params 1
// Size: 0x65
function ai_ascender_giveascender( var0 )
{
    var1 = self;
    var2 = scripts\mp\gametypes\br_circle::getrandompointincircle( var1.origin, var0, 0, 0.4, 0, 0 );
    var1 scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 4, 8, 4, var2 );
    var1 scripts\mp\gametypes\br_quest_util::ref_1316f( var0 );
    
    foreach ( var4 in level.players )
    {
        var1 scripts\mp\gametypes\br_quest_util::ref_1336a( var4 );
    }
}

// Params 0
// Size: 0x32
function ai_ascender_getstartpos()
{
    var0 = self;
    
    foreach ( var2 in level.players )
    {
        var0 scripts\mp\gametypes\br_quest_util::spawn_dogtags( var2 );
    }
}

// Params 1
// Size: 0xc6
function ai_goal_update_population( var0 )
{
    if ( level.obit_activation.ref_129d5 != 1 )
    {
        return;
    }
    
    level endon( "game_ended" );
    level.obit_activation notify( "escape_circle_peek" );
    level.obit_activation endon( "escape_circle_peek" );
    jumpiffalse(!isdefined( level.ref_13aca ) || !isdefined( level.ref_13aca[ var0.team ] ) || level.ref_13aca[ var0.team ] == 0) LOC_0000006e;
    scripts\mp\gametypes\br_quest_util::ref_12972( var0.team );
    
    for ( ;; )
    {
        level waittill( "br_circle_set", var1 );
        var2 = level.br_circle.circleindex + 1;
        
        if ( var1 >= var2 )
        {
            if ( level.ref_13aca[ var0.team ] + var2 <= var1 + 1 )
            {
                level.ref_13aca[ var0.team ] = undefined;
                scripts\mp\gametypes\br_quest_util::ref_12972( var0.team );
            }
        }
    }
}

// Params 0
// Size: 0xe
function ai_dropgren_model()
{
    level.obit_activation notify( "escape_circle_peek" );
}

// Params 0
// Size: 0x1e
function ai_dismount_turret()
{
    var0 = self;
    var0.hidden = 1;
    var0 setscriptablepartstate( "brloot_escape_radio", "hidden" );
}

// Params 0
// Size: 0x1d
function ai_goal_distribution_debug()
{
    var0 = self;
    var0.hidden = 0;
    var0 setscriptablepartstate( "brloot_escape_radio", "visible" );
}

// Params 1
// Size: 0x12
function obit_trigger_for_player( var0 )
{
    thread ai_dropgren_override_hide();
    ai_delete_after_level_notify( var0 );
}

// Params 2
// Size: 0x169
function ai_delete_after_level_notify( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = level.obit_activation.radio.ownerteam;
    }
    
    if ( istrue( var1 ) )
    {
        thread scripts\mp\gamelogic::endgame( var0, game[ "end_reason" ][ "enemies_eliminated" ], undefined, undefined, undefined, 1 );
        return;
    }
    
    var2 = getarraykeys( level.teamdata );
    var3 = [];
    
    foreach ( var5 in var2 )
    {
        if ( var5 == var0 )
        {
            setteamscore( var5, getteamscore( var5 ) + level.obit_activation.onspawn_slowspeed );
        }
        
        if ( level.teamdata[ var5 ][ "aliveCount" ] > 0 )
        {
            var3 = var5;
        }
    }
    
    var7 = scripts\mp\utility\script::quicksort( var3, &ammorestock_disableusefortime );
    
    for ( var8 = 0; var8 < var7.size ; var8++ )
    {
        var5 = var7[ var8 ];
        var9 = var8 + 1;
        thread scripts\mp\gametypes\br::ref_1209b( var5, var9, 0, 1, undefined, var5 == var0 );
    }
    
    foreach ( var5, var11 in level.teamdata )
    {
        if ( var5 == var0 )
        {
            var12 = scripts\mp\utility\teams::getteamdata( var5, "players" );
            managekingflag( var12, 0 );
            continue;
        }
        
        var13 = scripts\mp\utility\teams::getteamdata( var5, "alivePlayers" );
        
        if ( var13.size > 0 )
        {
            foreach ( var15 in var13 )
            {
                var15 freezecontrols( 1 );
                var15 playerhide();
            }
        }
    }
}

// Params 2
// Size: 0x15, Type: bool
function ammorestock_disableusefortime( var0, var1 )
{
    var2 = getteamscore( var0 );
    var3 = getteamscore( var1 );
    return var2 >= var3;
}

// Params 2
// Size: 0x51
function ref_11a00( var0, var1 )
{
    var2 = spawnstruct();
    var2.ref_12fa3 = "getUnusedLootCacheArray";
    var2.ref_12f9f = var0;
    var2.ref_12fa6 = var1;
    var2.ref_12fa7 = 0;
    var2.ref_12fa1 = 1;
    var2.mintime = level.obit_activation.ref_129db;
    return var2;
}

// Params 3
// Size: 0x148
function ammobox_giverandomattachment( var0, var1, var2 )
{
    var3 = self;
    var4 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( var4 != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var4, "current", var3.origin, var1 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var4, 1 );
        var5 = getdvarfloat( "scr_br_escape_friendly_icon_ping_rate", 0 );
        thread anyoneisinmarkingrange( var3, var0, var4 );
        objective_removeallfrommask( var4 );
        var6 = scripts\mp\utility\teams::getteamdata( var0.team, "players" );
        
        foreach ( var8 in var6 )
        {
            if ( !var8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
            {
                objective_addclienttomask( var4, var8 );
            }
        }
        
        objective_showtoplayersinmask( var4 );
        var3.playersetattractionstateindex = var4;
    }
    
    var10 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( var10 != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var10, "current", var3.origin, var2 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var10, 1 );
        var5 = getdvarfloat( "scr_br_escape_enemy_icon_ping_rate", 0 );
        thread anyoneisinmarkingrange( var3, var0, var10 );
        objective_removeallfrommask( var10 );
        
        foreach ( var8 in level.players )
        {
            if ( var8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || var8.team == var0.team )
            {
                objective_addclienttomask( var10, var8 );
            }
        }
        
        objective_hidefromplayersinmask( var10 );
        var3.nuke_cancel = var10;
        return;
    }
}

// Params 3
// Size: 0x6b
function anyoneisinmarkingrange( var0, var1, var2 )
{
    var3 = self;
    level.obit_activation endon( "escape_radio_dropped" );
    
    if ( var2 <= 0 )
    {
        scripts\mp\objidpoolmanager::update_objective_setzoffset( var1, 50 );
        scripts\mp\objidpoolmanager::update_objective_onentity( var1, var0 );
        return;
    }
    
    for ( ;; )
    {
        if ( isdefined( var0 ) )
        {
            scripts\mp\objidpoolmanager::update_objective_position( var1, var0.origin + ( 0, 0, 50 ) );
            
            if ( var0 scripts\cp_mp\utility\player_utility::isinvehicle() )
            {
                wait 0.1;
                continue;
            }
            
            wait var2;
        }
    }
}

// Params 3
// Size: 0x13e
function dangercircletick( var0, var1, var2 )
{
    if ( !isdefined( level.obit_activation ) )
    {
        return;
    }
    
    if ( !isdefined( level.obit_activation.radio ) )
    {
        level.obit_activation.plundereventamount = undefined;
        return;
    }
    
    if ( istrue( level.obit_activation.radio.hidden ) )
    {
        level.obit_activation.plundereventamount = undefined;
        return;
    }
    
    var3 = var1 * var1;
    var4 = var2 * var2;
    var5 = distance2dsquared( level.obit_activation.radio.origin, var0 );
    
    if ( var5 > var3 )
    {
        thread ai_ascender_use( level.obit_activation.radio );
        level.obit_activation.plundereventamount = undefined;
        return;
    }
    
    if ( var5 > var4 )
    {
        if ( !isdefined( level.obit_activation.plundereventamount ) )
        {
            level.obit_activation.plundereventamount = 1;
        }
        else
        {
            level.obit_activation.plundereventamount += 1;
        }
        
        if ( level.obit_activation.plundereventamount == 5 )
        {
            obj_hvt_dead( "exit_strategy_radio_strength", 0, 1 );
        }
        
        if ( level.obit_activation.plundereventamount >= level.obit_activation.ref_129d8 )
        {
            thread ai_ascender_use( level.obit_activation.radio );
            level.obit_activation.plundereventamount = undefined;
            return;
        }
        
        return;
    }
    
    level.obit_activation.plundereventamount = undefined;
}

// Params 1
// Size: 0x106
function ai_ascender_use( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "escape_radio_picked_up" );
    level notify( "radio_state_change" );
    
    foreach ( var3 in level.players )
    {
        if ( !var3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            if ( var0 )
            {
                var3 scripts\mp\hud_message::showsplash( "br_escape_radio_lost_in_gas" );
                continue;
            }
            
            var3 scripts\mp\hud_message::showsplash( "br_escape_radio_expired" );
        }
    }
    
    obj_hvt_dead( "exit_strategy_radio_fixing", 0.75, 1 );
    ai_dropgren_override_hide();
    ai_hold_positions_freed( var1 );
    var1 freescriptable();
    level.obit_activation.radio = undefined;
    wait 5;
    var5 = level.obit_activation.personalscorecount;
    
    if ( level.obit_activation.ref_1438f != -1 )
    {
        var5 = level.obit_activation.ref_1438f;
    }
    else if ( level.br_circle.circleindex < level.obit_activation.personalnukecostoverride )
    {
        var5 = level.obit_activation.start_fly_over;
    }
    
    level.obit_activation.ref_14385 = var5;
    thread ai_hold_wake_watch();
}

// Params 0
// Size: 0x132
function obj_hangar_bombs()
{
    var0 = self;
    
    if ( !isdefined( level.obit_activation ) || !isdefined( level.obit_activation.radio ) )
    {
        return;
    }
    
    if ( isdefined( level.obit_activation.radio.icon ) )
    {
        objective_removeclientfrommask( level.obit_activation.radio.icon, var0 );
        objective_showtoplayersinmask( level.obit_activation.radio.icon );
        return;
    }
    
    if ( isdefined( level.obit_activation.radio.ownerteam ) )
    {
        if ( var0.team == level.obit_activation.radio.ownerteam && isdefined( level.obit_activation.radio.playersetattractionstateindex ) )
        {
            objective_removeclientfrommask( level.obit_activation.radio.playersetattractionstateindex, var0 );
            objective_showtoplayersinmask( level.obit_activation.radio.playersetattractionstateindex );
        }
        
        if ( var0.team != level.obit_activation.radio.ownerteam && isdefined( level.obit_activation.radio.nuke_cancel ) )
        {
            objective_addclienttomask( level.obit_activation.radio.nuke_cancel, var0 );
            objective_hidefromplayersinmask( level.obit_activation.radio.nuke_cancel );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x132
function obj_hangar_juggs()
{
    var0 = self;
    
    if ( !isdefined( level.obit_activation ) || !isdefined( level.obit_activation.radio ) )
    {
        return;
    }
    
    if ( isdefined( level.obit_activation.radio.icon ) )
    {
        objective_addclienttomask( level.obit_activation.radio.icon, var0 );
        objective_showtoplayersinmask( level.obit_activation.radio.icon );
        return;
    }
    
    if ( isdefined( level.obit_activation.radio.ownerteam ) )
    {
        if ( var0.team == level.obit_activation.radio.ownerteam && isdefined( level.obit_activation.radio.playersetattractionstateindex ) )
        {
            objective_addclienttomask( level.obit_activation.radio.playersetattractionstateindex, var0 );
            objective_showtoplayersinmask( level.obit_activation.radio.playersetattractionstateindex );
        }
        
        if ( var0.team != level.obit_activation.radio.ownerteam && isdefined( level.obit_activation.radio.nuke_cancel ) )
        {
            objective_removeclientfrommask( level.obit_activation.radio.nuke_cancel, var0 );
            objective_hidefromplayersinmask( level.obit_activation.radio.nuke_cancel );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x65
function ref_12069( var0 )
{
    var0.locationtriggerupdate = var0.origin;
    
    if ( isdefined( level.obit_activation ) && isdefined( level.obit_activation.radio ) && isdefined( level.obit_activation.radio.owner ) && level.obit_activation.radio.owner == var0 )
    {
        var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
        mlgmodifyheadshotdamage( var0, var1 );
        return;
    }
}

// Params 0
// Size: 0x21
function onplayerspawned()
{
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    if ( updatenukeprogress( self ) )
    {
        scripts\mp\gametypes\br_gametype_kingslayer::carriabletype();
        thread managekingflagxp();
        return;
    }
}

// Params 1
// Size: 0x2c
function onplayerkilled( var0 )
{
    if ( isdefined( var0.victim.carryflag ) )
    {
        var0.attacker thread scripts\mp\utility\points::giveunifiedpoints( "radiosquadkill" );
    }
    
    scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
}

// Params 2
// Size: 0x57
function managekingflag( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    foreach ( var3 in var0 )
    {
        if ( isdefined( var3 ) && isalive( var3 ) )
        {
            if ( var1 )
            {
                var3 scripts\mp\gametypes\br_gametype_kingslayer::carriabletype();
                thread managekingflagxp();
                continue;
            }
            
            var3 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
        }
    }
}

// Params 0
// Size: 0x35
function managekingflagxp()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    level.obit_activation endon( "escape_radio_dropped" );
    
    while ( isdefined( self.carryflag ) )
    {
        wait 5;
        thread scripts\mp\utility\points::giveunifiedpoints( "radiosquadsurvive" );
    }
}

// Params 2
// Size: 0x41
function ai_fire_at_chopper( var0, var1 )
{
    var2 = int( var0 * 1000 );
    var3 = undefined;
    
    if ( istrue( var1 ) )
    {
        var3 = var2 | 1073741824;
    }
    else
    {
        var4 = gettime() + var2;
        var3 = var4 & ~1073741824;
    }
    
    setomnvar( "ui_br_exfil_radio_end_time", var3 );
}

// Params 1
// Size: 0xb
function ai_give_flashlight( var0 )
{
    ai_extra_think( var0 );
}

// Params 1
// Size: 0xc
function ai_force_damage_hit( var0 )
{
    ai_extra_think( undefined, var0 );
}

// Params 1
// Size: 0xd
function ai_flash_swap( var0 )
{
    ai_extra_think( undefined, undefined, var0 );
}

// Params 4
// Size: 0xf8
function ai_extra_think( var0, var1, var2, var3 )
{
    if ( !isdefined( level.onmatchstartbr ) )
    {
        level.onmatchstartbr = spawnstruct();
        level.onmatchstartbr.ref_129de = 0;
        level.onmatchstartbr.ref_129dd = 0;
        level.onmatchstartbr.ref_129d9 = 255;
        level.onmatchstartbr.ref_11b6f = 0;
    }
    
    if ( isdefined( var3 ) )
    {
        level.onmatchstartbr.ref_129de = var3;
    }
    
    if ( isdefined( var0 ) )
    {
        level.onmatchstartbr.ref_129dd = var0;
    }
    
    if ( isdefined( var1 ) )
    {
        level.onmatchstartbr.ref_129d9 = var1;
    }
    
    if ( isdefined( var2 ) )
    {
        level.onmatchstartbr.ref_11b6f = var2;
    }
    
    var4 = ( int( level.onmatchstartbr.ref_129de ) & 1 ) << 22;
    var4 += ( int( level.onmatchstartbr.ref_129dd ) & 7 ) << 19;
    var4 += ( int( level.onmatchstartbr.ref_129d9 ) & 255 ) << 11;
    var4 += int( level.onmatchstartbr.ref_11b6f ) & 2047;
    setomnvar( "ui_br_exfil_radio_state", var4 );
}

// Params 0
// Size: 0x9
function ai_dropgren_override_hide()
{
    ai_give_flashlight( 0 );
}

// Params 1
// Size: 0x9f
function ai_goal_distribution( var0 )
{
    if ( var0 && !istrue( level.onmatchstartbr.ref_129de ) )
    {
        level.obit_activation.radio.±!O ñJR‰ó¿è#="—EÖƒ)B…Q = gettime();
    }
    else if ( !var0 && istrue( level.onmatchstartbr.ref_129de ) && isdefined( level.obit_activation.radio.±!O ñJR‰ó¿è#="—EÖƒ)B…Q ) )
    {
        level.obit_activation.radio.²æPóMkãÚ5³¥¢Óµ{ õ“ += gettime() - level.obit_activation.radio.±!O ñJR‰ó¿è#="—EÖƒ)B…Q;
    }
    
    ai_extra_think( undefined, undefined, undefined, var0 );
}

// Params 0
// Size: 0x124
function obj_heli_assault2()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    level.obit_activation endon( "escape_radio_dropped" );
    var1 = 0;
    level.obit_activation.radio.²æPóMkãÚ5³¥¢Óµ{ õ“ = 0;
    
    for ( ;; )
    {
        var2 = istrue( var0.unset_relic_shieldsonly ) && !istrue( var0.start_death_from_above_sequence ) || scripts\mp\utility\player::unset_relic_trex( var0 );
        
        if ( var2 && !var1 )
        {
            var1 = 1;
            var3 = gettime();
            
            if ( getdvarint( "scr_br_alt_mode_escape_reset_timer_when_invalid_state", 0 ) )
            {
                level.obit_activation.radio.waittime = level.obit_activation.ref_145cd;
                ai_goal_distribution( 1 );
            }
            else
            {
                var0 notify( "escape_radio_win_timer_wait" );
                ai_goal_distribution( 1 );
                level.obit_activation.radio.waittime = _escaperadiogetremainingtime();
            }
            
            ai_fire_at_chopper( level.obit_activation.radio.waittime, 1 );
        }
        else if ( !var2 && var1 )
        {
            var1 = 0;
            thread ai_hold_free( var0 );
            ai_goal_distribution( 0 );
            ai_fire_at_chopper( level.obit_activation.radio.waittime );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x5, Type: bool
function vehicle_spawn_mp_gamemodesupportsrespawn()
{
    return true;
}

// Params 0
// Size: 0x93
function adjustzoneactivationdelayforlargemaps()
{
    if ( !isdefined( level.onmatchstartbr ) || !isdefined( level.onmatchstartbr.ref_129dd ) )
    {
        return -1;
    }
    
    var0 = level.onmatchstartbr.ref_129dd;
    
    if ( ( var0 == 1 || var0 == 4 ) && isdefined( level.obit_activation.ref_129d4 ) )
    {
        var1 = max( 0, level.obit_activation.ref_129d4 - gettime() );
        var2 = var1 / 1000;
        return var2;
    }
    
    if ( var2 == 3 )
    {
        var2 = _escaperadiogetremainingtime();
        return var2;
    }
    
    if ( var2 == 2 )
    {
        return level.obit_activation.ref_145cd;
    }
    
    return -1;
}

// Params 0
// Size: 0x185
function anyone_can_see_spawner()
{
    level endon( "game_ended" );
    level endon( "force_end" );
    level.initial_allies = undefined;
    level.initial_angles = -1;
    var0 = 0;
    var1 = level.obit_activation.ref_13bfd;
    
    for ( ;; )
    {
        var2 = 1;
        
        if ( !isdefined( level.obit_activation ) )
        {
            var2 = 0;
        }
        else if ( !isdefined( level.onmatchstartbr ) || !isdefined( level.onmatchstartbr.ref_129dd ) )
        {
            var2 = 0;
        }
        
        if ( var2 )
        {
            var3 = adjustzoneactivationdelayforlargemaps();
            var4 = level.onmatchstartbr.ref_129dd;
            
            if ( var3 == -1 || var4 == 0 )
            {
            }
            else if ( ( var4 == 1 || var4 == 4 ) && !var0 )
            {
                if ( getdvarint( "scr_br_override_remaining_time", 0 ) != 0 )
                {
                    var3 = getdvarint( "scr_br_override_remaining_time", 0 );
                }
                
                if ( var3 < 80 )
                {
                    ammobox_getbufferedattachmentweapon( "br_escape_tenpercent" );
                }
            }
            else if ( var4 == 3 || var4 == 2 || var0 )
            {
                if ( var4 == 1 || var4 == 4 )
                {
                    var3 = var1;
                }
                
                var0 = 1;
                var5 = min( var1, var3 );
                var1 = var5;
                
                if ( getdvarint( "scr_br_override_remaining_time", 0 ) != 0 )
                {
                    var5 = getdvarint( "scr_br_override_remaining_time", 0 );
                }
                
                if ( var5 <= 60 )
                {
                    ammobox_getbufferedattachmentweapon( "br_escape_ninetypercent" );
                }
                else if ( var5 < 125 )
                {
                    ammobox_getbufferedattachmentweapon( "br_escape_eightypercent" );
                }
                else if ( var5 < 185 )
                {
                    ammobox_getbufferedattachmentweapon( "br_escape_seventypercent" );
                }
                else if ( var5 < 250 )
                {
                    ammobox_getbufferedattachmentweapon( "br_escape_fiftypercent" );
                }
                else
                {
                    ammobox_getbufferedattachmentweapon( "br_escape_thirtypercent" );
                }
            }
        }
        
        wait 1;
    }
}

// Params 1
// Size: 0x74
function ammobox_getbufferedattachmentweapon( var0 )
{
    if ( isdefined( level.initial_allies ) && level.initial_allies == var0 )
    {
        return;
    }
    
    var1 = game[ "music" ][ var0 ].size;
    var2 = randomint( var1 );
    setmusicstate( "" );
    level.initial_allies = var0;
    level.initial_angles = var2;
    
    foreach ( var4 in level.players )
    {
        if ( !var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
        {
            ref_131a9( var4 );
        }
    }
}

// Params 0
// Size: 0x27
function ref_131a9()
{
    var0 = self;
    
    if ( isdefined( level.initial_allies ) )
    {
        var0 setplayermusicstate( game[ "music" ][ level.initial_allies ][ level.initial_angles ] );
        return;
    }
}

