
// Params 0
// Size: 0x2
function activate_punchcard()
{
    
}

// Params 0
// Size: 0x2
function activate_gas_trap()
{
    
}

// Params 0
// Size: 0x8a
function init()
{
    scripts\mp\gametypes\br_alt_mode_mxp::init();
    level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand();
    level thread scripts\mp\gametypes\br_gametype_rebirth::enable_traversals_for_bombers();
    level thread scripts\mp\gametypes\obj_dogtag::init();
    test_anim_ai();
    thread time_reduction_bonus();
    thread testaccessoryvfx();
    thread teamstarttime();
    thread toggleusbstickinhand();
    thread subtract_from_spawn_count_from_group();
    thread init_locations();
    level.ref_13364 = 1;
    level.ref_133d7 = 1;
    level.disable_back_light = 1;
    level.…S©ÄÛqõÈèã7°½ª£¢? Úo hç.©ï = level.ref_11bce.…S©ÄÛqõÈèã7°½ª£¢? Úo hç.©ï;
    level.ref_142d1 = "mp_wz_island_mendota";
    level.²(ÉgÈ— "c*C“°zQàGíµ× = "mp_wz_island_ap_mendota";
    level.train_hurt_damage_watcher = [];
}

// Params 0
// Size: 0x5e4
function test_anim_ai()
{
    level.ref_11bce = spawnstruct();
    level.ref_11bce.juggernaut_setupexecute = getdvarint( "scr_mendota_default_respawn_height" );
    
    if ( isdefined( level.ref_11bce.juggernaut_setupexecute ) && level.ref_11bce.juggernaut_setupexecute > 0 )
    {
        level.ref_12ca7 = level.ref_11bce.juggernaut_setupexecute;
    }
    
    level.ref_11bce.ref_127b6 = getdvarfloat( "scr_mendota_plunderDropPercent", 0.3 );
    level.ref_11bce.ref_127b5 = getdvarfloat( "scr_mendota_plunderDropAmount", 0 );
    level.ref_11bce.ref_127be = getdvarfloat( "scr_mendota_plunderKeepPercent", 0.6 );
    level.ref_11bce.ref_12c9a = getdvarfloat( "scr_mendota_respawn_time_default", 5 );
    level.ref_11bce.ref_12c99 = getdvarfloat( "scr_mendota_respawn_time_add_per_circle", 2 );
    level.ref_11bce.ref_1385a = getdvarint( "scr_mendota_starting_respawn_token_count", 0 );
    level.ref_11bce.ref_13857 = getdvar( "scr_mendota_starting_loadout_weapon_1", "iw8_fists_mp" );
    level.ref_11bce.ref_13858 = getdvar( "scr_mendota_starting_loadout_weapon_2", "iw8_sm_t9handling" );
    level.ref_11bce.ref_13856 = getdvar( "scr_mendota_starting_loadout_lethal", "frag_grenade_mp" );
    level.ref_11bce.triage_glass_break = getdvarint( "scr_mendota_intel_see_friendly_drops", 0 );
    level.ref_11bce.Šêös¾–¹£²Ø¯ZÖºÁõÃ = getdvarint( "scr_mendota_on_intel_pickup_xp", 25 );
    level.ref_11bce.ref_11fe8 = getdvarint( "scr_mendota_on_intel_pickup_health_refill", 1 );
    level.ref_11bce.ref_11fe7 = getdvarint( "scr_mendota_on_intel_pickup_armor_refill", 1 );
    level.ref_11bce.ref_11fe6 = getdvarint( "scr_mendota_on_intel_pickup_ammo_refill", 1 );
    level.ref_11bce.ref_11fea = getdvarint( "scr_mendota_on_intel_pickup_speed_increase", 1 );
    level.ref_11bce.ref_11fe9 = getdvarfloat( "scr_mendota_on_intel_pickup_overdrive_duration", 6 );
    level.ref_11bce.ref_14199 = getdvarvector( "scr_mendota_vehicle_impulse_vector", ( 0, 0, 0.5 ) );
    level.ref_11bce.ref_14198 = getdvarfloat( "scr_mendota_vehicle_impulse_magnitude", 150 );
    level.ref_11bce.train_lootcrates_save_offsets = getdvarint( "scr_mendota_intel_event", 1 );
    level.ref_11bce.ref_11bea = getdvarint( "scr_mendota_min_intel_circle_index", 2 );
    level.ref_11bce.ref_11b48 = getdvarint( "scr_mendota_max_intel_circle_index", 6 );
    level.ref_11bce.infil_light_dvars = getdvarint( "scr_mendota_crate_intel_count", 30 );
    level.ref_11bce.ref_11beb = getdvarint( "scr_mendota_intel_event_min", 20 );
    level.ref_11bce.ref_11b49 = getdvarint( "scr_mendota_intel_event_max", 30 );
    level.ref_11bce.ref_11f1e = getdvarint( "scr_mendota_intel_event_pairs", 1 );
    level.ref_11bce.train_get_num_of_anim_ents = [];
    level.ref_11bce.train_get_num_of_anim_ents[ "k" ] = getdvarint( "scr_mendota_k_intel_crate_dist", 2000 );
    level.ref_11bce.train_get_num_of_anim_ents[ "g" ] = getdvarint( "scr_mendota_g_intel_crate_dist", 6000 );
    level.ref_11bce.trial_fetch_mission_table = getdvarfloat( "scr_br_mxp_crate_min_time", 60 );
    level.ref_11bce.trial_explosive_clear = getdvarfloat( "scr_br_mxp_crate_max_time", 90 );
    level.ref_11bce.‘0ZÍ£²FZÂØ½ÎíÛcŒ½ÝÍ = getdvarfloat( "scr_mxp_intel_dialog_cooldown", 30 );
    level.ref_11bce.‹¼	›^ã™áeRˆ = getdvarint( "scr_mxp_intel_max", 150 );
    level.ref_11bce.º“Zæè+9¬ÜV: = getdvarfloat( "scr_mxp_intel_reset", 3 );
    level.ref_11bce.vo_while_reviving = getdvarint( "scr_mendota_killstreak_disable_circle", 8 );
    level.ref_11bce.…S©ÄÛqõÈèã7°½ª£¢? Úo hç.©ï = getdvarint( "scr_mendota_littlebird_overrideOOBSeconts", 30 );
    level.ref_11bce.«›ØÃé´ùÂ)Ès))ï¹©Ç¥…²U#x¢ = getdvarint( "scr_final_cir_dist_from_fresno_pt", 6000 );
    level.ref_11bce.—p3-É›:±¥Nl¬¶°á2ÒÍ£3'ÛÖl²7+' = getdvarint( "scr_first_cir_max_dist_from_center", 30000 );
    
    switch ( getdvarint( "scr_mendota_circle_speed", 1 ) )
    {
        case 0:
            level.ref_11bce.groundentity = [ 0, 120, 90, 75, 60, 45, 30, 0 ];
            level.ref_11bce.ground_spawners = [ 1, 150, 120, 120, 105, 105, 150, 10 ];
            break;
        case 2:
            level.ref_11bce.groundentity = [ 0, 120, 90, 60, 45, 45, 30, 0 ];
            level.ref_11bce.ground_spawners = [ 1, 150, 120, 90, 90, 90, 150, 10 ];
            break;
        case 3:
            level.ref_11bce.groundentity = [ 0, 30, 10, 10, 10, 10, 30, 0 ];
            level.ref_11bce.ground_spawners = [ 1, 20, 10, 10, 10, 10, 10, 10 ];
            break;
        case 4:
            level.ref_11bce.groundentity = [ 0, 90, 75, 60, 45, 30, 0 ];
            level.ref_11bce.ground_spawners = [ 1, 120, 120, 105, 90, 150, 10 ];
            break;
        case 5:
            level.ref_11bce.groundentity = [ 0, 30, 10, 10, 10, 30, 0 ];
            level.ref_11bce.ground_spawners = [ 1, 20, 10, 10, 10, 150, 10 ];
            break;
        case 1:
        default:
            level.ref_11bce.groundentity = [ 0, 120, 90, 75, 60, 45, 45, 0 ];
            level.ref_11bce.ground_spawners = [ 1, 150, 135, 135, 120, 105, 105, 10 ];
            break;
    }
    
    if ( getdvarint( "scr_mendota_heavyWeaponCrate_ultraLoot", 0 ) )
    {
        level.delaystreamtomovingplane = 1;
    }
    
    if ( getdvarint( "scr_mendota_dangerNotifyCustomization", 1 ) )
    {
        level.isbotpracticematch = getdvarfloat( "scr_mendota_dangerNotifyCooldown", 20 );
        level.isbrgametypefuncdefined = [];
    }
    
    setdvar( "scr_br_ending_enabled", 1 );
}

// Params 0
// Size: 0xa8
function time_reduction_bonus()
{
    level.tread_sfx = [];
    level.tread_sfx[ level.tread_sfx.size ] = tree_think( getdvarint( "scr_br_mxp_reward_mask", 20 ), &translate_and_rotate_from_level_overrides );
    level.tread_sfx[ level.tread_sfx.size ] = tree_think( getdvarint( "scr_br_mxp_reward_satchel", 40 ), &transitionac130tomovinganim );
    level.tread_sfx[ level.tread_sfx.size ] = tree_think( getdvarint( "scr_br_mxp_reward_heavy", 60 ), &trap_room_ents );
    level.tread_sfx[ level.tread_sfx.size ] = tree_think( getdvarint( "scr_br_mxp_reward_loadout", 80 ), &trap_timer_running );
    level.tread_sfx[ level.tread_sfx.size ] = tree_think( getdvarint( "scr_br_mxp_reward_strike", 100 ), &trap_door_nvg_reset );
}

// Params 0
// Size: 0x154
function teamstarttime()
{
    scripts\mp\gametypes\br_gametypes::ref_13f25( "circleTimer" );
    scripts\mp\gametypes\br_gametypes::ref_13f25( "dropOnPlayerDeath" );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "circleTimer", &circletimer );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerWelcomeSplashes", &ref_126f1 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "mapCenterFinalCircle", &ref_12181 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "getFinalCircleCenter", &ref_12181 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerGulagAutoWinWait", &ref_125bd );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "assignSpectatorToSpectatePlayer", &assignspectatortospectateplayer );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "markPlayerAsEliminatedOnKilled", &ref_11b16 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "dropOnPlayerDeath", &droponplayerdeath );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerDropPlunderOnDeath", &playerdropplunderondeath );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "pickupModifyCount", &ref_12356 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onUseCompleted", &onusecompleted );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "canTakePickupLoot", &get_chopper_minigun_start_node );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "skipPickupFeedback", &skippickupfeedback );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "takePickup", &ref_13a36 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "initCrateData", &initcratedata );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerRebirthDisable", &ref_12646 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "rebirthDisable", &ref_12a7c );
    
    if ( getdvarint( "scr_br_mxp_normal_circle", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::ref_12b11( "createC130PathStruct", &init_relic_aggressive_melee );
        scripts\mp\gametypes\br_gametypes::ref_12b11( "addToC130Infil", &being_hacked );
    }
    
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    thread ref_14148();
}

// Params 1
// Size: 0xd5
function ref_126f1( var0 )
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    wait 1;
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        self waittill( "joining_Infil" );
    }
    else
    {
        level waittill( "prematch_done" );
    }
    
    scripts\mp\hud_message::showsplash( "br_gametype_mendota_welcome" );
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "gametype", self, 0 );
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "primary_objective", self, 0 );
    
    if ( istrue( self.tutorial_usingparachute ) )
    {
        level scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "deploy_squad_leader", self, 1, 0, 4.5 );
    }
    
    if ( !istrue( level.br_infils_disabled ) )
    {
        self waittill( "br_jump" );
        
        if ( isdefined( game[ "dialog" ][ "match_desc" ] ) )
        {
            scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "match_desc", self, 0 );
        }
        
        while ( !self isonground() )
        {
            waitframe();
        }
    }
    else
    {
        level waittill( "prematch_done" );
    }
    
    scripts\mp\gametypes\br_analytics::detachriotshield( self );
    wait 1;
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "secondary_objective", self, 0 );
}

// Params 0
// Size: 0xc3
function iscarriablescriptable()
{
    self waittill( "game_ended" );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) )
        {
            onplayerdisconnect( var1 );
        }
    }
    
    foreach ( var4 in level.ref_13748 )
    {
        if ( isdefined( level.ref_13457 ) )
        {
            [[ level.ref_13457.ref_13738 ]]( var4.total, var4.bridge_tank_move_sfx, var4.nextplayertospectate );
            [[ level.ref_13457.ref_1373b ]]( var4.ref_12d24 );
        }
    }
    
    if ( istrue( level.ref_145c1 ) && isdefined( level.ref_13457 ) )
    {
        [[ level.ref_13457.ref_145c1 ]]();
        return;
    }
}

// Params 1
// Size: 0x4
function onplayerdisconnect( var0 )
{
    
}

// Params 2
// Size: 0x1f
function init_relic_gas_martyr( var0, var1 )
{
    var2 = init_relic_grounded( var1 );
    init_relic_gun_game( var2, var0 );
    init_relic_headbullets( var2, var0 );
    return var2;
}

// Params 1
// Size: 0x51
function init_relic_grounded( var0 )
{
    if ( isdefined( var0 ) )
    {
        return var0;
    }
    
    var1 = spawnstruct();
    var1.total = 0;
    var1.set_flag_after_vo = 0;
    var1.bridge_tank_move_sfx = 0;
    var1.nextplayertospectate = 0;
    var1.ref_12d24 = 0;
    var1.ref_122ef = 0;
    var1.openrightblimadoor = 0;
    return var1;
}

// Params 1
// Size: 0x3b
function init_relic_gun_game( var0 )
{
    self.total = train_play_anim( var0 );
    self.set_flag_after_vo = train_move_test_train_car_thread( var0 );
    self.bridge_tank_move_sfx = train_minimap_icon_attach( var0 );
    self.nextplayertospectate = train_minimap_icon_detach( var0 );
    self.ref_12d24 = trap_consoles( var0 );
}

// Params 1
// Size: 0x46
function init_relic_headbullets( var0 )
{
    if ( !isdefined( var0.spectatetestonprematchfadedone ) )
    {
        self.ref_122ef = 1;
    }
    else
    {
        self.ref_122ef = var0.spectatetestonprematchfadedone;
    }
    
    if ( !isdefined( var0.spawntimestamp ) )
    {
        self.openrightblimadoor = 0;
        return;
    }
    
    self.openrightblimadoor = var0.spawntimestamp;
}

// Params 2
// Size: 0x17
function init_relic_healthpacks( var0, var1 )
{
    var2 = init_relic_landlocked( var1 );
    init_relic_hideobjicons( var2, var0 );
    return var2;
}

// Params 1
// Size: 0x3f
function init_relic_landlocked( var0 )
{
    if ( isdefined( var0 ) )
    {
        return var0;
    }
    
    var1 = spawnstruct();
    var1.total = 0;
    var1.set_flag_after_vo = 0;
    var1.bridge_tank_move_sfx = 0;
    var1.nextplayertospectate = 0;
    var1.ref_12d24 = 0;
    return var1;
}

// Params 1
// Size: 0x69
function init_relic_hideobjicons( var0 )
{
    self.total += var0.total;
    self.set_flag_after_vo += var0.set_flag_after_vo;
    self.bridge_tank_move_sfx += var0.bridge_tank_move_sfx;
    self.nextplayertospectate += var0.nextplayertospectate;
    
    if ( var0.ref_12d24 > self.ref_12d24 )
    {
        self.ref_12d24 = var0.ref_12d24;
        return;
    }
}

// Params 2
// Size: 0x75
function setupkeybindings( var0, var1 )
{
    if ( isdefined( level.ref_13457 ) )
    {
        [[ level.ref_13457.ref_12540 ]]( var0, var1.total, var1.bridge_tank_move_sfx, var1.nextplayertospectate );
        [[ level.ref_13457.ref_12650 ]]( var0, var1.ref_12d24 );
        [[ level.ref_13457.ref_125d1 ]]( var0, var1.ref_122ef );
        [[ level.ref_13457.ref_12556 ]]( var0, var1.openrightblimadoor );
        return;
    }
}

// Params 2
// Size: 0x36, Type: bool
function ref_11bcf( var0, var1 )
{
    switch ( var0.type )
    {
        case "br_mendota_intel":
        case "brloot_mendota_intel_icon":
        case "brloot_mendota_intel":
            trainent( var0, var1 );
            return true;
    }
    
    return false;
}

// Params 0
// Size: 0xa4
function testaccessoryvfx()
{
    if ( getdvarint( "scr_mendota_playtest", 0 ) )
    {
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "allowLateJoiners" );
    }
    
    level.decoyassists = &groundz;
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "useTokenToReviveTeammate" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulagWinnerRestoreLoadoutUseGulag" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "drogBagLoadout" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "match_start_VO" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "firstCircleVo" );
    
    if ( getdvarint( "scr_br_mxp_rebirth_only", 1 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
    }
    
    if ( getdvarint( "scr_br_mxp_normal_circle", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "randomizeCircleCenter" );
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "planeUseCircleRadius" );
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "circleEarlyStart" );
        return;
    }
}

// Params 0
// Size: 0x2a
function toggleusbstickinhand()
{
    waittillframeend();
    thread superterrainlightbakelodoverride();
    thread ref_127f7();
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    scripts\mp\gametypes\br_pickups::ref_12b33( "brloot_mendota_intel", &trial_gethitmarkerpriority );
}

// Params 0
// Size: 0xb3
function ref_127f7()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "preOnPlayerKilled", &onplayerkilled );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "dangerCircleTick", &dangercircletick );
    level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
    level.ref_126c2 = [];
    level.ref_13748 = [];
    
    foreach ( var1 in level.players )
    {
        trial_dogtags( var1 );
        var2 = var1 getentitynumber();
        level.ref_126c2[ var2 ] = init_relic_grounded();
        level.ref_13748[ var1.team ] = init_relic_landlocked( level.ref_13748[ var1.team ] );
        ref_12604( var1 );
    }
    
    thread iscarriablescriptable();
}

// Params 0
// Size: 0x77
function subtract_from_spawn_count_from_group()
{
    wait 1;
    game[ "dialog" ][ "gametype" ] = "gametype_titan";
    game[ "dialog" ][ "primary_objective" ] = "gametype_desc_titan";
    game[ "dialog" ][ "secondary_objective" ] = "oshkosh_intel_available";
    game[ "dialog" ][ "circles_resurgence" ] = "oshkosh_circle_close_titan";
    game[ "dialog" ][ "circles_final" ] = "oshkosh_circle_close_laststand";
    game[ "dialog" ][ "collected_monarch_intel" ] = "oshkosh_intel_acquired";
}

// Params 0
// Size: 0x2
function achievementtrackerforkills()
{
    
}

// Params 2
// Size: 0x3e
function dangercircletick( var0, var1 )
{
    var2 = var0;
    var3 = var1;
    isbotmedicrole( var2, var3, level.dogtags, &train_associate_models_with_brushes );
    isbotmedicrole( var2, var3, level.train_hurt_damage_watcher, &train_get_anim_ents_index );
    isbotmedicrole( var2, var3, level.shutdownattractionicontrigger, &scripts\mp\gametypes\br_heavy_weapon_drop::shut_down_laser_trap );
}

// Params 4
// Size: 0x48
function isbotmedicrole( var0, var1, var2, var3 )
{
    var4 = var1 * var1;
    
    foreach ( var6 in var2 )
    {
        if ( isdefined( var6 ) && distance2dsquared( var6.origin, var0 ) > var4 )
        {
            var6 [[ var3 ]]();
        }
    }
}

// Params 0
// Size: 0x4, Type: bool
function ref_11b16()
{
    return false;
}

// Params 2
// Size: 0x61, Type: bool
function ref_125bd( var0, var1 )
{
    self endon( "disconnect" );
    
    if ( !isdefined( var0 ) )
    {
        if ( level.ref_11bce.ref_12c9a )
        {
            self.chopper_boss_combat_actions = 1;
            var2 = level.ref_11bce.ref_12c9a;
            wait 3;
            
            while ( istrue( self.killcam ) )
            {
                waitframe();
            }
            
            thread ref_1336e( var2 );
            thread scripts\mp\gametypes\br_spectate::spawnspectator( self, 0, 1 );
            wait var2;
            self.chopper_boss_combat_actions = undefined;
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x7, Type: bool
function ref_13dcb( var0 )
{
    return true;
}

// Params 2
// Size: 0x8a, Type: bool
function assignspectatortospectateplayer( var0, var1 )
{
    var0 notify( "assignSpectatorToSpectatePlayerWaitForTeam" );
    
    if ( istrue( level.endmatchcameratransitions ) )
    {
        return false;
    }
    
    if ( !isdefined( var1 ) || !isplayer( var1 ) || !isalive( var1 ) && !isdefined( var1.ref_1391a ) )
    {
        return false;
    }
    
    if ( var0.team == var1.team )
    {
        return false;
    }
    
    if ( !scripts\mp\utility\teams::getteamdata( var0.team, "aliveCount" ) )
    {
        return false;
    }
    
    var2 = scripts\mp\utility\teams::getfriendlyplayers( var0.team, 1 );
    
    if ( var2.size == 0 )
    {
        return false;
    }
    
    thread cargo_truck_mg_mp_init( var0 );
    return true;
}

// Params 1
// Size: 0x44
function cargo_truck_mg_mp_init( var0 )
{
    level endon( "brSpawnPlayersEnding" );
    var0 endon( "assignSpectatorToSpectatePlayerWaitForTeam" );
    var0 endon( "death_or_disconnect" );
    var0 scripts\mp\gametypes\br_spectate::ref_126ab();
    var0 setclientomnvar( "ui_show_spectateHud", var0 getentitynumber() );
    wait 1;
    var1 = scripts\mp\gametypes\br_spectate::regive_killstreak_after_use( var0 );
    thread scripts\mp\gametypes\br_spectate::assignspectatortospectateplayer( var0, var1 );
}

// Params 0
// Size: 0x21
function onplayerspawned()
{
    if ( isdefined( level.ref_142d1 ) )
    {
        self visionsetnakedforplayer( level.ref_142d1, 0 );
    }
    
    thread ref_14012();
    trial_dogtags();
}

// Params 1
// Size: 0xaa
function onplayerkilled( var0 )
{
    if ( !istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        thread juggerbear();
    }
    
    var1 = var0.inflictor;
    var2 = var0.attacker;
    
    if ( isdefined( var2 ) && ( !isdefined( var1 ) || var1.classname != "trigger_multiple" && var1.classname != "trigger_hurt" ) )
    {
        var3 = getdvarint( "scr_br_mxp_intel_dropped_on_death", 5 );
        thread train_initcollision( level, self, var2 );
    }
    
    if ( getdvarint( "scr_br_mxp_rebirth_only", 1 ) == 0 && !istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        scripts\mp\gametypes\br_gulag::trygulagspawn();
    }
    
    if ( istrue( level.disable_super_in_turret.brlootchoppercratedestroycallback ) )
    {
        scripts\mp\gametypes\br_alt_mode_mxp::playertransfertomahanger( var2, self );
        return;
    }
}

// Params 0
// Size: 0x70
function ref_14148()
{
    while ( !isdefined( level.vehicles ) || !isdefined( level.vehicles.damagecallbacks ) )
    {
        wait 0.1;
    }
    
    scripts\mp\vehicles\damage::set_post_mod_damage_callback( "atv", &ref_14202 );
    scripts\mp\vehicles\damage::set_post_mod_damage_callback( "cargo_truck", &ref_14202 );
    scripts\mp\vehicles\damage::set_post_mod_damage_callback( "jeep", &ref_14202 );
    scripts\mp\vehicles\damage::set_post_mod_damage_callback( "tac_rover", &ref_14202 );
    scripts\mp\vehicles\damage::set_post_mod_damage_callback( "little_bird", &ref_14202 );
}

// Params 1
// Size: 0x56, Type: bool
function ref_14202( var0 )
{
    if ( isdefined( var0.direction_vec ) && isdefined( var0.meansofdeath ) && isexplosivedamagemod( var0.meansofdeath ) )
    {
        var1 = level.ref_11bce.ref_14199;
        var2 = level.ref_11bce.ref_14198;
        self method_87c1( var0.direction_vec + var1, var2 );
    }
    
    return true;
}

// Params 0
// Size: 0xb7
function ref_12604()
{
    if ( !isdefined( self.ref_12eb0 ) )
    {
        var0 = getcompleteweaponname( level.ref_11bce.ref_13857 );
        var1 = scripts\mp\class::fixcollision( level.ref_11bce.ref_13858, "camo_01b", undefined, -1 );
        var2 = getcompleteweaponname( level.ref_11bce.ref_13856 );
        var3 = scripts\mp\equipment::getequipmentreffromweapon( var2 );
        self giveweapon( var0 );
        self giveweapon( var1 );
        self switchtoweaponimmediate( var1 );
        self assignweaponprimaryslot( var1 );
        scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
        scripts\mp\gametypes\br_weapons::br_ammo_give_type( self, "brloot_ammo_919", var1.clipsize * 2 );
        scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( self );
        self notify( "ammo_update" );
        scripts\mp\equipment::giveequipment( var3, "primary" );
        scripts\mp\weapons::fixupplayerweapons( self, var1 );
    }
    else
    {
        ref_125fb();
    }
    
    scripts\mp\gametypes\br_armor::scriptablescurid( 150 );
}

// Params 4
// Size: 0x39
function trial_active_fob( var0, var1, var2, var3 )
{
    if ( !isdefined( var3 ) )
    {
        var3 = 1;
    }
    
    if ( var3 == 0 )
    {
        return;
    }
    
    if ( isdefined( var0 ) && isdefined( var1 ) )
    {
        return trial_alternate_progression( var0, var1, var3 );
    }
    
    if ( isdefined( var2 ) )
    {
        return trial_ai_spawn_far( var2, var0, var3 );
    }
}

// Params 3
// Size: 0x2b
function trial_alternate_progression( var0, var1, var2 )
{
    if ( !train_array( var0 ) )
    {
        return;
    }
    
    var3 = trial_ai_spawn_far( var0.origin, var0, var2 );
    trial_callback_ai_damage( var3, var0, var1 );
    return var3;
}

// Params 1
// Size: 0x10, Type: bool
function train_array( var0 )
{
    if ( isagent( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x58
function trial_combo( var0 )
{
    if ( level.ref_11bce.triage_glass_break >= 1 )
    {
        return;
    }
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
    
    foreach ( var3 in var1 )
    {
        self disablescriptableplayeruse( var3 );
    }
}

// Params 2
// Size: 0x4e
function trial_callback_ai_damage( var0, var1 )
{
    var1 = train_sfx_init( var1 );
    self.team = var0.team;
    self.victim = var0;
    self.victimteam = var0.team;
    self.attacker = var1;
    self.attackerteam = var1.team;
    self.owner = var0;
    self.ownerteam = var0.team;
}

// Params 3
// Size: 0x32
function trial_ai_spawn_far( var0, var1, var2 )
{
    var3 = trial_active_ring( var0, var1, var2 );
    trial_celebration_flares( var3, var2 );
    trial_dlog_clear( var3, var2 );
    trial_combo( var3, var1 );
    trial_dlog_lava( var3, var1 );
    return var3;
}

// Params 0
// Size: 0x1d
function trial_gethitmarkerpriority()
{
    self.spawntime = gettime();
    var0 = train_elements_enable( self.count );
    trial_celebration_flares( var0 );
}

// Params 3
// Size: 0x27
function trial_active_ring( var0, var1, var2 )
{
    var0 += trial_callback_ai_killed( var1 );
    var3 = trial_ai( var0, var1, var2 );
    var3.spawntime = gettime();
    return var3;
}

// Params 3
// Size: 0x7a
function trial_ai( var0, var1, var2 )
{
    var3 = undefined;
    
    switch ( var2 )
    {
        case 10:
        case 9:
        case 8:
        case 7:
        case 6:
            var3 = trial_dlog_arm_course( var0, var1 );
            break;
        case 5:
        case 4:
        case 3:
        case 2:
        case 1:
        default:
            var3 = trial_ai_jugg( var0 );
            break;
    }
    
    return var3;
}

// Params 2
// Size: 0x29
function trial_dlog_arm_course( var0, var1 )
{
    var2 = undefined;
    
    if ( isdefined( var1 ) )
    {
        var2 = var1 getentitynumber();
    }
    
    var3 = easepower( "brloot_mendota_intel_icon", var0, undefined, undefined, var2 );
    scripts\mp\gametypes\br_pickups::ref_12b3a( var3 );
    return var3;
}

// Params 1
// Size: 0x1b
function trial_ai_jugg( var0 )
{
    var1 = spawn( "script_model", var0 );
    var1 setmodel( "military_intel_br_mendota" );
    return var1;
}

// Params 1
// Size: 0x68
function trial_callback_ai_killed( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return ( 0, 0, 14 );
    }
    
    var1 = ( 0, 0, 0 );
    var2 = var0.angles;
    
    if ( var0 scripts\mp\gameobjects::touchingarbitraryuptrigger() )
    {
        var2 = self getworldupreferenceangles();
        var1 = anglestoup( var2 );
        
        if ( var1[ 2 ] < 0 )
        {
            return ( 0, 0, -14 );
        }
    }
    
    return ( 0, 0, 14 );
}

// Params 1
// Size: 0x15
function trial_celebration_flares( var0 )
{
    trial_dlog_race( var0 );
    trial_civilians_killed();
    trial_delete_out_of_bounds();
}

// Params 1
// Size: 0x3a
function trial_dlog_race( var0 )
{
    var1 = undefined;
    
    if ( train_wzcircle_override() )
    {
        var1 = "" + self getentitynumber();
    }
    else
    {
        var1 = self.index;
    }
    
    self.start_reach_wind_room = var1;
    level.dogtags[ var1 ] = self;
    trial_dlog_sniper( var0 );
}

// Params 1
// Size: 0x17
function trial_dlog_sniper( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    self.count = trial_dogtag_setup( var0 );
}

// Params 1
// Size: 0x1b
function trial_dlog_clear( var0 )
{
    if ( train_wzcircle_override() )
    {
        trial_dlog_func( var0 );
        return;
    }
    
    trial_dlog_gun( var0 );
}

// Params 1
// Size: 0x8a
function trial_dlog_func( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    switch ( var0 )
    {
        case 2:
            self hudoutlineenable( "outline_depth_green" );
            break;
        case 3:
            self hudoutlineenable( "outline_depth_cyan" );
            break;
        case 4:
            self hudoutlineenable( "outline_depth_purple" );
            break;
        case 5:
            self hudoutlineenable( "outline_depth_orange" );
            break;
        case 1:
        default:
            self hudoutlineenable( "outline_depth_white" );
            break;
    }
}

// Params 1
// Size: 0xa3
function trial_dlog_gun( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 6;
    }
    
    switch ( var0 )
    {
        case 7:
            self setscriptablepartstate( "brloot_mendota_intel", "green" );
            break;
        case 8:
            self setscriptablepartstate( "brloot_mendota_intel", "cyan" );
            break;
        case 9:
            self setscriptablepartstate( "brloot_mendota_intel", "orange" );
            break;
        case 10:
            self setscriptablepartstate( "brloot_mendota_intel", "red" );
            break;
        case 6:
        default:
            self setscriptablepartstate( "brloot_mendota_intel", "white" );
            break;
    }
}

// Params 0
// Size: 0x86
function trial_civilians_killed()
{
    if ( level.dogtags.size > level.ref_11bce.‹¼	›^ã™áeRˆ )
    {
        level.dogtags = scripts\engine\utility::array_removeundefined( level.dogtags );
    }
    
    if ( level.dogtags.size > level.ref_11bce.‹¼	›^ã™áeRˆ )
    {
        var0 = undefined;
        
        foreach ( var2 in level.dogtags )
        {
            if ( !isdefined( var0 ) || var2.spawntime < var0.spawntime )
            {
                var0 = var2;
            }
        }
        
        train_associate_models_with_brushes( var0 );
        return;
    }
}

// Params 0
// Size: 0x14
function trial_delete_out_of_bounds()
{
    if ( !train_wzcircle_override() )
    {
        return;
    }
    
    self setasgametypeobjective();
    trial_dlog_jugg();
}

// Params 0
// Size: 0xd4
function trial_dlog_jugg()
{
    var0 = train_play_anim_init();
    
    if ( isdefined( level.dogtags[ var0 ].objidnum ) )
    {
        if ( level.dogtags[ var0 ].objidnum != -1 )
        {
            var1 = level.dogtags[ var0 ].objidnum;
            scripts\mp\objidpoolmanager::update_objective_state( var1, "current" );
            scripts\mp\objidpoolmanager::update_objective_onentity( var1, level.dogtags[ var0 ] );
            scripts\mp\objidpoolmanager::update_objective_setzoffset( var1, 22 );
            scripts\mp\objidpoolmanager::update_objective_setbackground( var1, 1 );
            scripts\mp\objidpoolmanager::objective_set_play_intro( level.dogtags[ var0 ].objidnum, 0 );
            scripts\mp\objidpoolmanager::objective_set_play_outro( level.dogtags[ var0 ].objidnum, 0 );
            level.dogtags[ var0 ] scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_dogtags_friendly", "waypoint_dogtags" );
            level.dogtags[ var0 ] scripts\mp\gameobjects::setvisibleteam( "any" );
            getbnetigrbattlepassxpmultiplier( var1, 8858, 9843 );
            getscriptcachecontents( var1, 0.5, 1 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x15
function trial_dlog_lava( var0, var1 )
{
    if ( !train_wzcircle_override() )
    {
        return;
    }
    
    thread trial_dlog_pitcher( var0, var1 );
}

// Params 2
// Size: 0xc9
function trial_dlog_pitcher( var0, var1 )
{
    self endon( "death" );
    
    if ( !isdefined( var1 ) )
    {
        var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    }
    
    var2 = self.origin;
    var3 = self.angles;
    
    if ( isdefined( var0 ) )
    {
        var2 = var0.origin;
        var3 = var0.angles;
    }
    
    var4 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var1, var2, var3, var0, undefined, undefined, undefined, 1 );
    var5 = var4.origin;
    var6 = abs( self.origin[ 2 ] - var5[ 2 ] );
    var7 = getdvarint( "NPOQPMP", 800 );
    var8 = sqrt( 2 * var6 / var7 ) + 0.5;
    var9 = trajectorycalculateinitialvelocity( self.origin, var5, ( 0, 0, -1 * var7 ), var8 );
    self movegravity( var9, var8 );
    wait var8;
    self.origin = var5;
    
    if ( isdefined( var4.set_force_aitype_armored ) )
    {
        self linkto( var4.set_force_aitype_armored );
        self.set_force_aitype_armored = var4.set_force_aitype_armored;
        return;
    }
}

// Params 0
// Size: 0x4c
function trial_dlog_gunslinger()
{
    self.offset3d = ( 0, 0, 16 );
    self.curorigin = self.origin;
    scripts\mp\gameobjects::requestid( 1, 1 );
    self.type = "useObject";
    self.numtouching[ "axis" ] = 0;
    self.numtouching[ "allies" ] = 0;
}

// Params 3
// Size: 0x3a
function train_initcollision( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = 1;
    }
    
    var2 = int( var2 );
    
    while ( var2 > 0 )
    {
        var3 = train_elements_enable( var2 );
        trial_active_fob( var0, var1, undefined, var3 );
        var2 -= trial_dogtag_setup( var3 );
        waitframe();
    }
}

// Params 1
// Size: 0x3d
function trainent( var0 )
{
    var0 = train_sfx_init( var0 );
    
    if ( intel_cancollect( var0 ) )
    {
        var1 = train_scriptable_attach_delay();
        var2 = intel_onuse_internal( var0, var1, "ground" );
        self.count = var2;
        
        if ( var2 <= 0 )
        {
            train_associate_models_with_brushes( var0 );
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x1a
function intel_collectedmisc( var0, var1, var2 )
{
    if ( intel_cancollect( var0 ) )
    {
        intel_onuse_internal( var0, var0, var1, var2 );
        return;
    }
}

// Params 1
// Size: 0x18, Type: bool
function intel_cancollect( var0 )
{
    var1 = train_mover_test( var0 );
    var2 = traincylestolink( var0 );
    return var1 < var2;
}

// Params 3
// Size: 0x83
function intel_onuse_internal( var0, var1, var2 )
{
    traintracefails( var0, var1 );
    traintracesuccesses( var0 );
    traintracerelpos( var0 );
    intel_onuse_handledialog( var0 );
    var3 = train_stopper( var0, var1 );
    transition_parachutestate( var0 );
    var0 playlocalsound( "mxp_intel_pickup" );
    scripts\mp\gametypes\br_analytics::branalytics_modespecificscore( var0, var1, var2 );
    
    if ( level.ref_11bce.º“Zæè+9¬ÜV: >= 0 )
    {
        var4 = train_mover_test( var0 );
        var5 = traincylestolink( var0 );
        
        if ( var4 >= var5 )
        {
            thread intel_reset( level, var0 );
        }
    }
    
    return var3;
}

// Params 1
// Size: 0x19
function train_sfx_init( var0 )
{
    if ( isdefined( var0.owner ) )
    {
        return var0.owner;
    }
    
    return var0;
}

// Params 1
// Size: 0x23
function intel_onuse_handledialog( var0 )
{
    if ( !isdefined( var0.©-nX#{pî@«Ë gƒïu¥<B¦6è·ŸXÙûu ) || !var0.©-nX#{pî@«Ë gƒïu¥<B¦6è·ŸXÙûu )
    {
        thread intel_pickupdialog();
        return;
    }
}

// Params 0
// Size: 0x1c
function intel_pickupdialog()
{
    self.©-nX#{pî@«Ë gƒïu¥<B¦6è·ŸXÙûu = 1;
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "collected_monarch_intel", self );
    thread intel_dialogcooldown();
}

// Params 0
// Size: 0x22
function intel_dialogcooldown()
{
    self endon( "disconnect" );
    self endon( "team_eliminated" );
    wait level.ref_11bce.‘0ZÍ£²FZÂØ½ÎíÛcŒ½ÝÍ;
    self.©-nX#{pî@«Ë gƒïu¥<B¦6è·ŸXÙûu = 0;
}

// Params 2
// Size: 0x23
function traintracefails( var0, var1 )
{
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_1301e( "mv_event_intel_3", var1 );
    
    if ( !train_vfx_init( var0 ) )
    {
        var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
        return;
    }
}

// Params 0
// Size: 0xd
function trainmove()
{
    transient_world_autolod_enabled( "mxp_intel_pickup" );
}

// Params 1
// Size: 0x11
function transient_world_autolod_enabled( var0 )
{
    var1 = self.origin;
    playsoundatpos( var1, var0 );
}

// Params 1
// Size: 0x12
function traintracesuccesses( var0 )
{
    transient_prefab_group( var0 );
    trainwaittime( var0 );
}

// Params 1
// Size: 0x6f
function transient_prefab_group( var0 )
{
    if ( train_vfx_init( var0 ) )
    {
        var0 scripts\mp\utility\stats::incpersstat( "confirmed", 1 );
        var0 scripts\mp\persistence::statsetchild( "round", "confirmed", var0.pers[ "confirmed" ] );
        return;
    }
    
    if ( train_wzcircle_time_subtractfrom() )
    {
        var0 scripts\mp\utility\stats::incpersstat( "denied", 1 );
        var0 scripts\mp\persistence::statsetchild( "round", "denied", var0.pers[ "denied" ] );
        return;
    }
}

// Params 1
// Size: 0x25
function trainwaittime( var0 )
{
    if ( train_vfx_init( var0 ) )
    {
        scripts\mp\gametypes\obj_dogtag::allyonuse( var0 );
        return;
    }
    
    if ( train_wzcircle_time_subtractfrom() )
    {
        scripts\mp\gametypes\obj_dogtag::enemyonuse( var0 );
        return;
    }
}

// Params 1
// Size: 0x55
function traintracerelpos( var0 )
{
    var0 thread scripts\mp\rank::scoreeventpopup( "br_mendota_intel" );
    
    if ( train_vfx_init( var0 ) )
    {
        if ( isdefined( level.dogtagallyonusecb ) && !level.gameended )
        {
            self thread [[ level.dogtagallyonusecb ]]( var0 );
            return;
        }
        
        return;
    }
    
    if ( isdefined( level.dogtagenemyonusecb ) && !level.gameended )
    {
        self thread [[ level.dogtagenemyonusecb ]]( var0 );
        return;
    }
}

// Params 0
// Size: 0x4f, Type: bool
function intel_isintel()
{
    var0 = self.scriptablename;
    
    if ( !isdefined( var0 ) && isdefined( self.tracknonoobplayerlocation ) )
    {
        var0 = self.tracknonoobplayerlocation.type;
    }
    
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( var0 == "brloot_mendota_intel_icon" || var0 == "brloot_mendota_intel" || var0 == "br_mendota_intel" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x9, Type: bool
function train_wzcircle_time_subtractfrom()
{
    return isdefined( self.victim );
}

// Params 1
// Size: 0x21, Type: bool
function train_vfx_init( var0 )
{
    if ( !train_wzcircle_time_subtractfrom() )
    {
        return false;
    }
    
    return var0.pers[ "team" ] == self.victimteam;
}

// Params 1
// Size: 0x15, Type: bool
function traincar_hurt( var0 )
{
    if ( !train_wzcircle_time_subtractfrom() )
    {
        return false;
    }
    
    return var0 == self.victim;
}

// Params 0
// Size: 0xe, Type: bool
function train_wzcircle_override()
{
    if ( isent( self ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x1d
function train_play_anim_init()
{
    if ( isdefined( self.entity ) )
    {
        return self.entity.start_reach_wind_room;
    }
    
    return self.start_reach_wind_room;
}

// Params 0
// Size: 0x3b
function train_scriptable_attach_delay()
{
    if ( isdefined( self.entity ) )
    {
        if ( !isdefined( self.entity.count ) )
        {
            return 1;
        }
        
        return self.entity.count;
    }
    
    if ( !isdefined( self.count ) )
    {
        return 1;
    }
    
    return self.count;
}

// Params 1
// Size: 0x53
function train_elements_enable( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    if ( var0 >= 20 )
    {
        return 10;
    }
    else if ( var0 >= 10 )
    {
        return 9;
    }
    else if ( var0 >= 5 )
    {
        return 8;
    }
    else if ( var0 >= 3 )
    {
        return 7;
    }
    else if ( var0 >= 1 )
    {
        return 6;
    }
    
    return 0;
}

// Params 1
// Size: 0x8e
function trial_dogtag_setup( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    var1 = 0;
    
    switch ( var0 )
    {
        case 7:
        case 2:
            var1 = 3;
            break;
        case 8:
        case 3:
            var1 = 5;
            break;
        case 9:
        case 4:
            var1 = 10;
            break;
        case 10:
        case 5:
            var1 = 20;
            break;
        case 6:
        case 1:
        default:
            var1 = 1;
            break;
    }
    
    return var1;
}

// Params 1
// Size: 0xb
function train_associate_models_with_brushes( var0 )
{
    thread train_attach_useable_ammorestocklocation( var0 );
}

// Params 1
// Size: 0x29
function train_attach_useable_ammorestocklocation( var0 )
{
    train_attach_models_to_assembly( var0 );
    train_car_audio();
    waitframe();
    
    if ( isdefined( self ) )
    {
        self notify( "death" );
        train_attach_brushes_to_models();
        train_attach_player_hurts();
        return;
    }
}

// Params 1
// Size: 0x24
function train_attach_models_to_assembly( var0 )
{
    if ( train_wzcircle_time_subtractfrom() )
    {
        thread scripts\mp\gametypes\obj_dogtag::removetags( self.victim.guid, undefined, var0 );
        train_collision_item_valid();
        return;
    }
}

// Params 0
// Size: 0xe
function train_collision_item_valid()
{
    self.victim notify( "tag_removed" );
}

// Params 0
// Size: 0x1e
function train_car_audio()
{
    playfx( level.conf_fx[ "vanish" ], self.origin );
    self notify( "reset" );
}

// Params 0
// Size: 0x47
function train_attach_brushes_to_models()
{
    var0 = train_play_anim_init();
    
    if ( isdefined( var0 ) && isdefined( level.dogtags[ var0 ] ) )
    {
        if ( !isdefined( level.dogtags[ var0 ].skipminimapids ) )
        {
            level.dogtags[ var0 ] scripts\mp\gameobjects::releaseid();
            self notify( "deleted" );
        }
        
        level.dogtags[ var0 ] = undefined;
        return;
    }
}

// Params 0
// Size: 0x28
function train_attach_player_hurts()
{
    if ( isdefined( self.entity ) )
    {
        self.entity delete();
        return;
    }
    
    if ( train_wzcircle_override() )
    {
        self delete();
        return;
    }
    
    self freescriptable();
}

// Params 2
// Size: 0x1e
function tree_think( var0, var1 )
{
    var2 = spawnstruct();
    var2.spotlight_sweep_to_loc_safe = var0;
    var2.playerwaittillstreamhintcomplete = var1;
    return var2;
}

// Params 2
// Size: 0x4d
function intel_reset( var0, var1 )
{
    var0 endon( "disconnect" );
    var0 scripts\engine\utility::waittill_notify_or_timeout( "death", var1 );
    var0.spawnvector = 0;
    var0.spawnselectionmarker = 0;
    var0.spawnpoint_setspawnpoint = 0;
    var0.spawntvfix = 0;
    var0.splashtime_helis = 0;
    trial_dogtags( var0 );
}

// Params 1
// Size: 0x1c
function transition_parachutestate( var0 )
{
    thread trap_toggle_logic( var0 );
    
    if ( !train_vfx_init( var0 ) )
    {
        trap_door_nvg_reset_catch( var0 );
        return;
    }
}

// Params 1
// Size: 0x27
function trap_toggle_logic( var0 )
{
    trenchdebug( var0 );
    triage_door_clip( var0 );
    traversenotvalid( var0 );
    traversal_disabled_by_management( var0 );
    thread ref_124ef();
}

// Params 1
// Size: 0x3a
function trap_door_nvg_reset_catch( var0 )
{
    for ( var1 = 0; var1 <= level.tread_sfx.size ; var1++ )
    {
        if ( trap_room_dogtag_revive( var0, var1 ) )
        {
            var0 [[ level.tread_sfx[ var1 ].playerwaittillstreamhintcomplete ]]();
            trap_room_turret_init( var0 );
        }
    }
}

// Params 2
// Size: 0x3f, Type: bool
function trap_room_dogtag_revive( var0, var1 )
{
    var2 = train_mover_test( var0 );
    var3 = trap_consoles( var0 );
    
    if ( !isdefined( level.tread_sfx[ var3 ] ) )
    {
        return false;
    }
    
    var4 = var2 >= level.tread_sfx[ var3 ].spotlight_sweep_to_loc_safe;
    var5 = var1 == var3;
    return var4 && var5;
}

// Params 1
// Size: 0x29
function trenchdebug( var0 )
{
    if ( isdefined( var0.vehicle ) )
    {
        return;
    }
    
    if ( level.ref_11bce.ref_11fea == 1 )
    {
        thread ref_124ee();
        return;
    }
}

// Params 1
// Size: 0x50
function triage_door_clip( var0 )
{
    var1 = self.count;
    
    if ( !isdefined( var1 ) )
    {
        var1 = 1;
    }
    
    if ( train_vfx_init( var0 ) )
    {
        var0 scripts\mp\rank::giverankxp( "tag_denied", level.ref_11bce.Šêös¾–¹£²Ø¯ZÖºÁõÃ * var1 );
        return;
    }
    
    var0 scripts\mp\rank::giverankxp( "tag_collected", level.ref_11bce.Šêös¾–¹£²Ø¯ZÖºÁõÃ * var1 );
}

// Params 1
// Size: 0x1d
function travelspeed( var0 )
{
    if ( level.ref_11bce.ref_11fe6 == 1 )
    {
        thread transition_to_airfield();
        return;
    }
}

// Params 1
// Size: 0x20
function traversenotvalid( var0 )
{
    if ( level.ref_11bce.ref_11fe8 == 1 )
    {
        self.health = self.maxhealth;
        return;
    }
}

// Params 1
// Size: 0x3f
function traversal_disabled_by_management( var0 )
{
    if ( level.ref_11bce.ref_11fe7 == 1 )
    {
        var0.br_armorhealth = var0.br_maxarmorhealth;
        var0 setclientomnvar( "ui_br_armor_damage", 1 );
        var0 scripts\mp\equipment\armor_plate::debug_state( var0.br_armorhealth );
        return;
    }
}

// Params 0
// Size: 0x1e
function transition_to_airfield()
{
    self endon( "death_or_disconnect" );
    thread scripts\mp\equipment::givescavengerammo();
    scripts\mp\weapons::scavengergiveammo( self );
    waitframe();
    scripts\mp\weapons::scavengergiveammo( self );
}

// Params 0
// Size: 0xd
function triage_ai_campers()
{
    trap_room_wave_settings( "uav" );
}

// Params 0
// Size: 0x1c
function trap_toggle_fx_logic()
{
    scripts\mp\gametypes\br_pickups::forcegivesuper( "super_ammo_drop", 1, 0, 0 );
    thread scripts\mp\hud_message::showsplash( "br_field_upgrade_purchased" );
}

// Params 0
// Size: 0x12
function intel_reward_selfrevive()
{
    intel_reward_item( "brloot_self_revive", "br_gametype_mendota_intel_self_revive" );
}

// Params 0
// Size: 0x12
function trap_room_ents()
{
    intel_reward_item( "brloot_offhand_advancedlootdrop", "br_gametype_mendota_intel_heavy_weapons" );
}

// Params 0
// Size: 0x1c
function transition_to_next_section()
{
    scripts\mp\gametypes\br_pickups::forcegivesuper( "super_armor_drop", 1, 0, 0 );
    thread scripts\mp\hud_message::showsplash( "br_field_upgrade_purchased" );
}

// Params 0
// Size: 0xd
function transitionplayersoutofac130cinematic()
{
    trap_room_wave_settings( "toma_strike" );
}

// Params 0
// Size: 0x12
function translate_and_rotate_from_level_overrides()
{
    intel_reward_item( "brloot_equip_gasmask", "br_gametype_mendota_intel_gas_mask" );
}

// Params 0
// Size: 0xa2
function transitionac130tomovinganim()
{
    thread scripts\mp\hud_message::showsplash( "br_gametype_mendota_intel_satchel" );
    
    if ( getdvarint( "scr_mendota_refill_armor", 1 ) )
    {
        var0 = scripts\mp\gametypes\br_pickups::br_createcustompickupitem( self, "brloot_plate_pouch" );
        var1 = scripts\mp\gametypes\br_pickups::cantakepickup( var0 );
        
        if ( var1 == 1 )
        {
            scripts\mp\gametypes\br_pickups::onusecompleted( var0, 1 );
            return;
        }
        
        if ( var1 == 15 )
        {
            var2 = scripts\engine\utility::ter_op( isdefined( self.equipment[ "health" ] ), scripts\mp\equipment::getequipmentslotammo( "health" ), 0 );
            var3 = scripts\mp\equipment::getequipmentmaxammo( level.br_pickups.br_equipname[ "brloot_armor_plate" ] );
            
            if ( var2 < var3 )
            {
                scripts\mp\equipment::setequipmentslotammo( "health", var3 );
                return;
            }
            
            return;
        }
        
        return;
    }
    
    intel_reward_item( "brloot_plate_pouch", undefined );
}

// Params 0
// Size: 0xe
function trap_trigger_logic()
{
    intel_reward_item( "brloot_offhand_kioskdrop", undefined );
}

// Params 0
// Size: 0xd
function traps_disabled()
{
    trap_room_wave_settings( "precision_airstrike" );
}

// Params 0
// Size: 0x12
function transitionplayerstoac130cinematic()
{
    thread scripts\mp\hud_message::showsplash( "br_body_count_rewarded_extra_life" );
    start_mine_caves();
}

// Params 0
// Size: 0x12
function trap_timer_running()
{
    intel_reward_item( "brloot_offhand_advancedsupplydrop", "br_gametype_mendota_intel_loadout_drop" );
}

// Params 0
// Size: 0x12
function treerootnodesizebitcount()
{
    thread scripts\mp\hud_message::showsplash( "br_body_count_rewarded_specialist" );
    scripts\mp\perks\perks::bears();
}

// Params 0
// Size: 0x1e
function transition_snd_org()
{
    trap_room_wave_settings( "directional_uav" );
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "intel_reward", self, undefined, undefined, 1 );
}

// Params 0
// Size: 0x2c
function trap_door_nvg_reset()
{
    thread scripts\mp\hud_message::showsplash( "br_gametype_mendota_intel_oshkosh" );
    var0 = isdefined( self.streakdata.streaks[ 1 ] );
    scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar( "greenbay_strike", var0, 1 );
}

// Params 3
// Size: 0x24
function intel_reward_item( var0, var1, var2 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    scripts\mp\gametypes\br_pickups::br_forcegivecustomreward( self, var0, 1, var2 );
    
    if ( isdefined( var1 ) )
    {
        thread scripts\mp\hud_message::showsplash( var1 );
        return;
    }
}

// Params 1
// Size: 0x2f
function trap_room_wave_settings( var0 )
{
    var1 = isdefined( self.streakdata.streaks[ 1 ] );
    scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar( var0, var1, 1 );
    
    if ( !level.gameended )
    {
        thread scripts\mp\hud_message::showkillstreaksplash( var0 );
        return;
    }
}

// Params 0
// Size: 0x1c
function train_play_anim()
{
    var0 = 0;
    var0 += train_move_test_train_car_thread();
    var0 += train_minimap_icon_attach();
    var0 += train_minimap_icon_detach();
    return var0;
}

// Params 0
// Size: 0x17
function train_mover_test()
{
    if ( !isdefined( self.splashtime_helis ) )
    {
        self.splashtime_helis = 0;
    }
    
    return self.splashtime_helis;
}

// Params 0
// Size: 0x17
function train_move_test_train_car_thread()
{
    if ( !isdefined( self.spawntvfix ) )
    {
        self.spawntvfix = 0;
    }
    
    return self.spawntvfix;
}

// Params 0
// Size: 0x17
function train_minimap_icon_attach()
{
    if ( !isdefined( self.spawnpoint_setspawnpoint ) )
    {
        self.spawnpoint_setspawnpoint = 0;
    }
    
    return self.spawnpoint_setspawnpoint;
}

// Params 0
// Size: 0x17
function train_minimap_icon_detach()
{
    if ( !isdefined( self.spawnselectionmarker ) )
    {
        self.spawnselectionmarker = 0;
    }
    
    return self.spawnselectionmarker;
}

// Params 1
// Size: 0x6d
function train_stopper( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    var0 = int( var0 );
    var1 = train_mover_test();
    var2 = traincylestolink();
    var3 = 0;
    
    if ( var1 + var0 > var2 )
    {
        var4 = var2 - var1;
        var3 = var0 - var4;
        var0 = var4;
    }
    
    if ( train_wzcircle_time_subtractfrom() )
    {
        if ( train_vfx_init( self ) )
        {
            train_stop( var0 );
        }
        else
        {
            train_tag_array( var0 );
        }
    }
    else
    {
        train_tagoffset_array( var0 );
    }
    
    trial_dogtags();
    return var3;
}

// Params 0
// Size: 0x1b
function traincylestolink()
{
    var0 = level.tread_sfx[ level.tread_sfx.size - 1 ];
    return var0.spotlight_sweep_to_loc_safe;
}

// Params 1
// Size: 0x27
function train_track_velocity( var0 )
{
    self.splashtime_helis = train_mover_test();
    
    if ( isdefined( var0 ) )
    {
        self.splashtime_helis += var0;
        return;
    }
    
    self.splashtime_helis++;
}

// Params 1
// Size: 0x31
function train_tagoffset_array( var0 )
{
    self.spawntvfix = train_move_test_train_car_thread();
    
    if ( isdefined( var0 ) )
    {
        self.spawntvfix += var0;
    }
    else
    {
        self.spawntvfix++;
    }
    
    train_track_velocity( var0 );
}

// Params 1
// Size: 0x27
function train_stop( var0 )
{
    self.spawnpoint_setspawnpoint = train_minimap_icon_attach();
    
    if ( isdefined( var0 ) )
    {
        self.spawnpoint_setspawnpoint += var0;
        return;
    }
    
    self.spawnpoint_setspawnpoint++;
}

// Params 1
// Size: 0x31
function train_tag_array( var0 )
{
    self.spawnselectionmarker = train_minimap_icon_detach();
    
    if ( isdefined( var0 ) )
    {
        self.spawnselectionmarker += var0;
    }
    else
    {
        self.spawnselectionmarker++;
    }
    
    train_track_velocity( var0 );
}

// Params 1
// Size: 0x2a
function train_init_as_vehicle( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 1;
    }
    
    var0 = int( var0 );
    
    for ( var1 = 0; var1 < var0 ; var1++ )
    {
        train_init_lootcrates_on_train();
    }
    
    trial_dogtags();
}

// Params 0
// Size: 0x23
function train_init_lootcrates_on_train()
{
    self.splashtime_helis = train_mover_test();
    self.splashtime_helis--;
    
    if ( self.splashtime_helis < 0 )
    {
        self.splashtime_helis = 0;
        return;
    }
}

// Params 0
// Size: 0x4e
function trial_dogtags()
{
    var0 = train_mover_test();
    var1 = trap_consoles();
    var2 = trap_array();
    var3 = propremovefromcircle();
    var4 = 0;
    var4 += var0 * 100000;
    var4 += var1 * 1000;
    var4 += int( floor( var2 * 100 ) ) * 10;
    var4 += var3;
    self setclientomnvar( "ui_br_bodycount_reward_data", var4 );
}

// Params 0
// Size: 0x17
function trap_room_turret_init()
{
    self.spawnvector = trap_consoles();
    self.spawnvector++;
    trial_dogtags();
}

// Params 0
// Size: 0x17
function trap_consoles()
{
    if ( !isdefined( self.spawnvector ) )
    {
        self.spawnvector = 0;
    }
    
    return self.spawnvector;
}

// Params 0
// Size: 0x4d
function trap_array()
{
    var0 = train_mover_test();
    var1 = 0;
    
    for ( var2 = 0; var2 < level.tread_sfx.size ; var2++ )
    {
        var3 = level.tread_sfx[ var2 ].spotlight_sweep_to_loc_safe;
        
        if ( var0 > var1 && var0 < var3 )
        {
            return ( ( var0 - var1 ) / ( var3 - var1 ) );
        }
        
        var1 = var3;
    }
    
    return 0;
}

// Params 0
// Size: 0x9e
function init_locations()
{
    if ( isdefined( level.ref_11e18.seq3_tanksettings ) )
    {
        var0 = 0;
        var1 = "gf";
        
        foreach ( var3 in level.ref_11e18.seq3_tanksettings )
        {
            var4 = var1 + scripts\engine\utility::string( var0 );
            ref_12aea( var4, 1, var3 );
            var0++;
        }
    }
    
    if ( !isdefined( level.ref_11bce.area_structs ) || level.ref_11bce.area_structs.size <= 0 )
    {
        ref_12aea( "default", 1, ( 0, 0, 0 ) );
        return;
    }
}

// Params 3
// Size: 0x66
function ref_12aea( var0, var1, var2 )
{
    if ( !isdefined( level.ref_11bce.area_structs ) )
    {
        level.ref_11bce.area_structs = [];
    }
    
    var1 = getdvarint( "scr_mendota_location_weight_" + var0, var1 );
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    var2.ref_13902 = var0;
    var2.spotlights = var1;
    var2.ref_140b7 = var2.origin;
    level.ref_11bce.area_structs[ var0 ] = var2;
}

// Params 0
// Size: 0x199
function groundz()
{
    ref_12fdc();
    thread bindingpc();
    
    if ( getdvarint( "scr_br_mxp_normal_circle", 0 ) == 0 )
    {
        if ( istrue( level.ref_11bce.ref_1409d ) )
        {
            level.grouptorewards = ( 0, 0, 0 );
        }
        
        level.br_level.br_circledelaytimes = level.ref_11bce.groundentity;
        level.br_level.br_circleclosetimes = level.ref_11bce.ground_spawners;
        
        if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
        {
            level.br_level.br_circleradii = [ 16000, 16000, 12500, 9500, 6500, 2000, 300, 0 ];
            level.br_level.br_circleminimapradii = [ 9000, 9000, 7750, 6500, 4500, 3500, 2500 ];
            level.br_level.default_player_connect_black_screen = [ 0, 0, 0, 0, 0, 0, 0 ];
            level.br_level.default_suicidebomber_combat = [ 0, 0, 0, 0, 0, 0, 0 ];
            return;
        }
        
        level.br_level.br_circleradii = [ 72500, 72500, 50000, 32500, 20000, 11500, 7000, 2000, 0 ];
        level.br_level.br_circleminimapradii = [ 10500, 10500, 10500, 9000, 8000, 6500, 5500, 5500 ];
        level.br_level.default_player_connect_black_screen = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
        level.br_level.default_suicidebomber_combat = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
        return;
    }
}

// Params 0
// Size: 0x41
function ref_12fdc()
{
    level.ref_11bce.ref_12e2c = ref_12d7f();
    var0 = level.ref_11bce.ref_12e2c.ref_140b7;
    level.grouptorewards = move_point_by_set_distance( var0, get_closest_k_fresno_point( var0 ), level.ref_11bce.«›ØÃé´ùÂ)Ès))ï¹©Ç¥…²U#x¢ );
}

// Params 0
// Size: 0x14e
function ref_12d7f()
{
    if ( isdefined( level.ref_11bce.ref_13903 ) && level.ref_11bce.ref_13903 != "random" )
    {
        foreach ( var1 in level.ref_11bce.area_structs )
        {
            if ( level.ref_11bce.ref_13903 == var2 )
            {
                return var1;
            }
        }
    }
    
    if ( level.ref_11bce.area_structs.size == 1 )
    {
        foreach ( var4 in level.ref_11bce.area_structs )
        {
            return var4;
        }
        
        var4 = undefined;
    }
    
    var6 = 0;
    
    foreach ( var1 in level.ref_11bce.area_structs )
    {
        var6 += var1.spotlights;
    }
    
    var9 = randomintrange( 0, var6 );
    
    foreach ( var1 in level.ref_11bce.area_structs )
    {
        if ( var9 < var1.spotlights )
        {
            return var1;
        }
        
        var9 -= var1.spotlights;
    }
    
    level.ref_11bce.area_structs = scripts\engine\utility::array_randomize( level.ref_11bce.area_structs );
    return level.ref_11bce.area_structs[ 0 ];
}

// Params 0
// Size: 0x1d7
function bindingpc()
{
    level endon( "game_ended" );
    level waittill( "calc_circle_centers" );
    var0 = ( 0, 0, 0 );
    
    foreach ( var2 in level.ref_11e18.wait_for_player_eliminated )
    {
        var0 += var2;
    }
    
    var0 /= level.ref_11e18.wait_for_player_eliminated.size;
    var4 = level.ref_11bce.—p3-É›:±¥Nl¬¶°á2ÒÍ£3'ÛÖl²7+';
    level.br_level.default_class_chosen[ 1 ] = check_dist_from_point_move_if_needed( level.br_level.default_class_chosen[ 1 ], var0, var4 );
    level.br_level.default_class_chosen[ 0 ] = level.br_level.default_class_chosen[ 1 ];
    level.br_level.default_class_chosen[ 2 ] = check_dist_from_point_move_if_needed( level.br_level.default_class_chosen[ 2 ], var0, var4 );
    check_fresno_points_move_if_needed( 3, 1, 1 );
    check_fresno_points_move_if_needed( 4, 1, 0 );
    check_fresno_points_move_if_needed( 5, 1, 0 );
    level.br_level.default_class_chosen[ 6 ] = level.br_level.default_class_chosen[ 8 ];
    level.br_level.default_class_chosen[ 6 ] = move_point_by_set_distance( level.br_level.default_class_chosen[ 6 ], level.ref_11bce.ref_12e2c.ref_140b7, 500 );
    level.br_level.default_class_chosen[ 7 ] = level.br_level.default_class_chosen[ 8 ];
    
    for ( var5 = 9; var5 < level.br_level.default_class_chosen.size ; var5++ )
    {
        if ( !scripts\mp\gametypes\br_circle::vandalize_minigun_speed( level.br_level.default_class_chosen[ var5 ], 1 ) )
        {
            var6 = distance2d( level.br_level.default_class_chosen[ var5 ], level.grouptorewards );
            level.br_level.default_class_chosen[ var5 ] = move_point_by_set_distance( level.br_level.default_class_chosen[ var5 ], level.grouptorewards, var6 / 2 );
        }
    }
}

// Params 3
// Size: 0xf0
function check_fresno_points_move_if_needed( var0, var1, var2 )
{
    var3 = level.br_level.default_class_chosen[ var0 ];
    var4 = level.br_level.br_circleradii[ var0 ];
    var5 = check_fresno_points_in_circle( var0 );
    var6 = var5[ "greenbay" ];
    var7 = var5[ "kenosha" ];
    
    if ( var1 && var2 )
    {
        if ( var6 && var7 )
        {
            return;
        }
    }
    
    if ( var1 && !var6 )
    {
        var8 = distance2d( var3, level.ref_11bce.ref_12e2c.ref_140b7 ) - var4;
        level.br_level.default_class_chosen[ var0 ] = move_point_by_set_distance( var3, level.ref_11bce.ref_12e2c.ref_140b7, var8 + 5000 );
    }
    
    if ( var2 && !var7 )
    {
        var8 = distance2d( var3, level.ref_11bce.ref_12e2c.ref_140b7 ) - var4;
        level.br_level.default_class_chosen[ var0 ] = move_point_by_set_distance( var3, level.ref_11bce.ref_12e2c.ref_140b7, var8 + 5000 );
        return;
    }
}

// Params 1
// Size: 0xbe
function check_fresno_points_in_circle( var0 )
{
    var1 = [];
    var2 = 0;
    var3 = 0;
    var4 = level.br_level.default_class_chosen[ var0 ];
    var5 = level.br_level.br_circleradii[ var0 ];
    
    foreach ( var7 in level.ref_11e18.seq3_tanksettings )
    {
        if ( scripts\engine\utility::updatescrapassistdata( var7.origin, var4, var5 ) )
        {
            var2++;
        }
    }
    
    foreach ( var10 in level.ref_11e18.wait_for_player_eliminated )
    {
        if ( scripts\engine\utility::updatescrapassistdata( var10, var4, var5 ) )
        {
            var3++;
        }
    }
    
    var1 = var2;
    var1 = var3;
    return var1;
}

// Params 3
// Size: 0x23
function check_dist_from_point_move_if_needed( var0, var1, var2 )
{
    var3 = distance2d( var0, var1 );
    
    if ( var3 > var2 )
    {
        var4 = var3 - var2;
        return move_point_by_set_distance( var0, var1, var4 );
    }
    
    return var1;
}

// Params 0
// Size: 0x13
function ref_12181()
{
    var0 = getdvarvector( "br_final_circle_override", level.grouptorewards );
    return var0;
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
// Size: 0xb4
function superterrainlightbakelodoverride()
{
    var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "intel_crate" );
    var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
    var0.dummymodel = "military_carepackage_02_br_s3";
    var0.friendlymodel = undefined;
    var0.enemymodel = undefined;
    var0.mountmantlemodel = undefined;
    var0.supportsownercapture = 0;
    var0.headicon = undefined;
    var0.minimapicon = undefined;
    var0.usepriority = -1;
    var0.usefov = 180;
    var0.timeout = undefined;
    var0.friendlyuseonly = 0;
    var0.ownerusetime = 0.5;
    var0.otherusetime = 0.5;
    var0.activatecallback = &trial_enemy_dont_drop_weapon;
    var0.capturecallback = &trial_enemy_quota;
    var0.destroyoncapture = 1;
}

// Params 1
// Size: 0x2b
function train_handle_collide_crate_br( var0 )
{
    level notify( "intel_crate_event_check" );
    level endon( "intel_crate_event_check" );
    
    if ( scripts\mp\gametypes\br_publicevent_fresno::isfresnoactive() )
    {
        var1 = scripts\mp\gametypes\br_publicevent_fresno::getfresnotimeremaining();
        wait var1;
    }
    
    thread ref_13571();
}

// Params 1
// Size: 0x2a1
function ref_13571( var0 )
{
    if ( !level.ref_11bce.train_lootcrates_save_offsets )
    {
        return;
    }
    
    if ( !istrue( var0 ) )
    {
        wait randomintrange( level.ref_11bce.ref_11beb, level.ref_11bce.ref_11b49 );
    }
    
    var1 = [];
    var2 = scripts\mp\gametypes\br_alt_mode_mxp::sappliedstages();
    level.ref_11e18.score_event_headshot = var2[ 0 ];
    var3 = var2[ 1 ];
    var2 = undefined;
    
    if ( isdefined( var3 ) )
    {
        var4 = spawnstruct();
        var4.origin = var3;
        var4.index = level.ref_11e18.score_event_headshot;
        var4.type = "g";
        var1 = var4;
    }
    
    var5 = scripts\mp\gametypes\br_alt_mode_mxp::vehicletrail();
    level.ref_11e18.wait_and_destroy = var5[ 0 ];
    var3 = var5[ 1 ];
    var5 = undefined;
    
    if ( isdefined( var3 ) )
    {
        var4 = spawnstruct();
        var4.origin = var3;
        var4.index = level.ref_11e18.wait_and_destroy;
        var4.type = "k";
        var1 = var4;
    }
    
    if ( var1.size > 0 )
    {
        foreach ( var7 in level.players )
        {
            var7 scripts\mp\hud_message::showsplash( "br_gametype_mendota_crate_event" );
        }
    }
    
    for ( var9 = 0; var9 < var1.size ; var9++ )
    {
        var10 = randomint( 360 );
        
        for ( var11 = 0; var11 < level.ref_11bce.ref_11f1e ; var11++ )
        {
            var12 = var10 + 90;
            var13 = 0;
            var14 = undefined;
            var15 = 0;
            
            while ( var15 < 360 )
            {
                var16 = ( 0, var12 + var15, 0 );
                var17 = anglestoforward( var16 );
                var4 = var1[ var9 ];
                var14 = var4.origin + var17 * level.ref_11bce.train_get_num_of_anim_ents[ var4.type ];
                
                if ( !scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var14 ) || updatesquadleaderpassstateforteam( var14 ) )
                {
                }
                else if ( !isdefined( level.br_circle.dangercircleent ) || scripts\mp\gametypes\br_circle::updateprestreamrespawn( var14 ) )
                {
                    var13 = 1;
                    break;
                }
                
                var15 += 10;
            }
            
            if ( !var13 )
            {
                break;
            }
            
            var10 = var12;
            var18 = scripts\mp\gametypes\br_public::modifyplayer_damage( var14 );
            var18 += ( 0, 0, 2000 );
            var19 = scripts\cp_mp\killstreaks\airdrop::dropcrate( undefined, undefined, "intel_crate", var18, ( 0, randomint( 360 ), 0 ) );
            var19.trial_flares = var1[ var9 ];
            var20 = randomfloatrange( level.ref_11bce.trial_fetch_mission_table, level.ref_11bce.trial_explosive_clear ) * 1000;
            var19.trial_flares.expiretime = gettime() + var20;
            level.train_hurt_damage_watcher[ level.train_hurt_damage_watcher.size ] = var19;
            thread train_handle_collide_mines();
            thread train_horn_sfx();
        }
    }
}

// Params 1
// Size: 0x7b, Type: bool
function updatesquadleaderpassstateforteam( var0 )
{
    var1 = getentarray( "trigger_hurt", "classname" );
    
    foreach ( var3 in var1 )
    {
        if ( ispointinvolume( var0, var3 ) )
        {
            return true;
        }
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( var3 in level.outofboundstriggers )
        {
            if ( ispointinvolume( var0, var3 ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 1
// Size: 0x30
function trial_enemy_dont_drop_weapon( var0 )
{
    if ( istrue( var0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x76
function trial_enemy_quota( var0 )
{
    thread trial_flare_destruct_missile( self );
    self notify( "captured" );
    var1 = train_elements_enable( level.ref_11bce.infil_light_dvars );
    var2 = trial_ai_spawn_far( self.origin + ( 0, 0, 16 ), undefined, var1 );
    
    if ( isdefined( self.objectiveiconid ) )
    {
        objective_delete( self.objectiveiconid );
    }
    
    playfx( level.conf_fx[ "vanish" ], self.molotov_delete_oldest_trigger.origin );
    self.molotov_delete_oldest_trigger delete();
}

// Params 1
// Size: 0xb0
function trial_flare_destruct_missile( var0 )
{
    var1 = var0.trial_flares;
    level.train_hurt_damage_watcher = scripts\engine\utility::array_remove( level.train_hurt_damage_watcher, var0 );
    var2 = 0;
    
    foreach ( var4 in level.train_hurt_damage_watcher )
    {
        if ( isdefined( var4 ) && var4.trial_flares.type == var1.type && var4.trial_flares.index == var1.index )
        {
            var2 = 1;
            break;
        }
    }
    
    if ( !var2 )
    {
        if ( var1.type == "k" )
        {
            level.ref_11e18.wait_and_destroy = undefined;
            return;
        }
        
        level.ref_11e18.score_event_headshot = undefined;
        return;
    }
}

// Params 0
// Size: 0x64
function train_handle_collide_mines()
{
    var0 = scripts\mp\gametypes\br_public::modifyplayer_damage( self.origin, 50, -3000 );
    self.molotov_delete_oldest_trigger = spawn( "script_model", var0 + ( 0, 0, 3 ) );
    self.molotov_delete_oldest_trigger setmodel( "scr_smoke_grenade" );
    wait 1;
    self.molotov_delete_oldest_trigger playloopsound( "mp_flare_burn_lp" );
    self.molotov_delete_oldest_trigger setscriptablepartstate( "smoke", "on" );
}

// Params 0
// Size: 0x11
function train_horn_sfx()
{
    self setscriptablepartstate( "objective", "intel" );
}

// Params 0
// Size: 0x18
function train_get_anim_ents_index()
{
    if ( isdefined( self ) && !istrue( self.isdestroyed ) )
    {
        thread train_get_anim_to_play();
        return;
    }
}

// Params 0
// Size: 0x2b
function train_get_anim_to_play()
{
    self.molotov_delete_oldest_trigger delete();
    playfx( level.conf_fx[ "vanish" ], self.origin );
    trial_flare_destruct_missile( self );
    scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

// Params 1
// Size: 0x99, Type: bool
function circletimer( var0 )
{
    if ( istrue( level.disable_super_in_turret.ref_12ca4 ) )
    {
        var1 = scripts\mp\gametypes\br_gametype_rebirth::rocket_attack_min_cooldown();
        
        if ( var0 >= var1 )
        {
            scripts\mp\gametypes\br_gametype_rebirth::loadoutcustomperkdiscount();
        }
    }
    
    if ( var0 >= 2 )
    {
        level.ref_11bce.ref_12c9a += level.ref_11bce.ref_12c99;
    }
    
    if ( var0 == level.ref_11bce.vo_while_reviving )
    {
        _getrandomlocations::vehicle_spawn_abandonedtimeoutcallback( 1 );
        _getrandomlocations::sequence_progression( 1 );
    }
    
    if ( var0 >= level.ref_11bce.ref_11bea && var0 <= level.ref_11bce.ref_11b48 )
    {
        thread train_handle_collide_crate_br( var0 );
    }
    
    return false;
}

// Params 0
// Size: 0x2e
function lb_dmg_factor_tail_stabilizer()
{
    foreach ( var1 in level.train_hurt_damage_watcher )
    {
        train_get_anim_ents_index( var1 );
    }
}

// Params 1
// Size: 0xb
function initcratedata( var0 )
{
    scripts\mp\gametypes\fresno\fresno_screamer::initcratedata( var0 );
}

// Params 0
// Size: 0x2
function active_fob_think()
{
    
}

// Params 3
// Size: 0x25
function move_point_by_set_percent( var0, var1, var2 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = ( 0, 0, 0 );
    }
    
    var3 = var1 - var0;
    return var0 + var3 * var2;
}

// Params 3
// Size: 0x28
function move_point_by_set_distance( var0, var1, var2 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = ( 0, 0, 0 );
    }
    
    var3 = vectornormalize( var1 - var0 );
    return var0 + var3 * var2;
}

// Params 1
// Size: 0x53
function get_closest_k_fresno_point( var0 )
{
    var1 = undefined;
    var2 = undefined;
    
    foreach ( var4 in level.ref_11e18.wait_for_player_eliminated )
    {
        var5 = distance2dsquared( var0, var4 );
        
        if ( !isdefined( var2 ) || var5 < var2 )
        {
            var2 = var5;
            var1 = var4;
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x6a
function ref_124ee()
{
    if ( !isdefined( self.operatorcustomization ) || !isdefined( self.operatorcustomization.suit ) )
    {
        return;
    }
    
    if ( self.operatorcustomization.suit == "actionhero_mp" )
    {
        thread ref_1247e();
        return;
    }
    
    self.ref_12147 = self.operatorcustomization.suit;
    self.operatorcustomization.suit = "actionhero_mp";
    scripts\mp\utility\player::_setsuit( "actionhero_mp" );
    thread ref_1247e();
}

// Params 0
// Size: 0x6e
function ref_1247e()
{
    self notify( "custom_suit_start" );
    self endon( "custom_suit_start" );
    self endon( "disconnect" );
    scripts\engine\utility::ref_143b9( level.ref_11bce.ref_11fe9, "death" );
    
    if ( isdefined( self.ref_12147 ) && self.operatorcustomization.suit != self.ref_12147 )
    {
        self.operatorcustomization.suit = self.ref_12147;
        scripts\mp\utility\player::_setsuit( self.ref_12147 );
        self.ref_12147 = undefined;
        return;
    }
}

// Params 0
// Size: 0xff
function ref_124ef()
{
    self notify( "player_set_infinate_super_sprint" );
    self endon( "player_set_infinate_super_sprint" );
    self endon( "death_or_disconnect" );
    self refreshsprinttime();
    var0 = 0;
    thread transient_world_proxy_collision_distance();
    self.movespeedscaler = 1.2;
    scripts\mp\weapons::updatemovespeedscale();
    self lerpfovbypreset( "zombiedefault" );
    
    if ( !scripts\mp\gametypes\br_public::shouldlink() )
    {
        scripts\mp\utility\perk::giveperk( "specialty_sprintmelee" );
        scripts\mp\utility\perk::giveperk( "specialty_sprintads" );
        scripts\mp\utility\perk::giveperk( "specialty_marathon" );
    }
    
    while ( var0 < level.ref_11bce.ref_11fe9 )
    {
        if ( self issupersprinting() )
        {
            self refreshsprinttime();
        }
        
        wait 0.1;
        var0 += 0.1;
    }
    
    if ( !scripts\mp\gametypes\br_public::shouldlink() )
    {
        if ( isdefined( self.perks[ "specialty_sprintmelee" ] ) )
        {
            scripts\mp\utility\perk::removeperk( "specialty_sprintmelee" );
        }
        
        if ( isdefined( self.perks[ "specialty_sprintads" ] ) )
        {
            scripts\mp\utility\perk::removeperk( "specialty_sprintads" );
        }
        
        if ( isdefined( self.perks[ "specialty_marathon" ] ) )
        {
            scripts\mp\utility\perk::removeperk( "specialty_marathon" );
        }
    }
    
    self.movespeedscaler = 1;
    scripts\mp\weapons::updatemovespeedscale();
    self lerpfovbypreset( "default_2seconds" );
}

// Params 0
// Size: 0x60
function transient_world_proxy_collision_distance()
{
    self notify( "reset_timer" );
    waitframe();
    self setclientomnvar( "ui_privateevent_timer_type", 4 );
    var0 = level.ref_11bce.ref_11fe9;
    var1 = gettime() + var0 * 1000;
    self setclientomnvar( "ui_privateevent_timer", var1 );
    scripts\engine\utility::ref_143ba( level.ref_11bce.ref_11fe9, "reset_timer", "death" );
    self setclientomnvar( "ui_privateevent_timer_type", 0 );
}

// Params 0
// Size: 0x14
function ref_12646()
{
    if ( isalive( self ) )
    {
        ref_14012();
        trial_dogtags();
        return;
    }
}

// Params 0
// Size: 0xd
function ref_12a7c()
{
    scripts\mp\gametypes\br_gametypes::ref_13f25( "mayConsiderPlayerDead" );
}

// Params 0
// Size: 0x47
function ref_14012()
{
    if ( !istrue( level.disable_super_in_turret.ref_12ca4 ) && scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        if ( propremovefromcircle() )
        {
            if ( !scripts\mp\gametypes\br_public::hasrespawntoken() )
            {
                scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
                return;
            }
            
            return;
        }
        
        if ( scripts\mp\gametypes\br_public::hasrespawntoken() )
        {
            scripts\mp\gametypes\br_pickups::removerespawntoken();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x28
function ref_1336e( var0 )
{
    waittillframeend();
    scripts\mp\utility\lower_message::setlowermessageomnvar( 9, int( gettime() + var0 * 1000 ) );
    scripts\mp\gametypes\br_gulag::ref_131a2( 1 );
    thread spawn_drones( var0 );
}

// Params 1
// Size: 0x20
function spawn_drones( var0 )
{
    self endon( "disconnect" );
    
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    scripts\mp\gametypes\br_gulag::ref_131a2( 0 );
    scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
}

// Params 0
// Size: 0x21
function propremovefromcircle()
{
    if ( !isdefined( self.spawnsystem_init ) )
    {
        self.spawnsystem_init = level.ref_11bce.ref_1385a;
    }
    
    return self.spawnsystem_init;
}

// Params 0
// Size: 0x4c
function start_mine_caves()
{
    self.spawnsystem_init = propremovefromcircle();
    self.spawnsystem_init++;
    
    if ( !isdefined( self.spectatetestonprematchfadedone ) )
    {
        self.spectatetestonprematchfadedone = self.spawnsystem_init;
    }
    else if ( self.spawnsystem_init > self.spectatetestonprematchfadedone )
    {
        self.spectatetestonprematchfadedone = self.spawnsystem_init;
    }
    
    ref_14012();
    trial_dogtags();
}

// Params 0
// Size: 0x3f
function juggerbear()
{
    self.spawnsystem_init = propremovefromcircle();
    self.spawnsystem_init--;
    
    if ( !isdefined( self.spawntimestamp ) )
    {
        self.spawntimestamp = 1;
    }
    else
    {
        self.spawntimestamp++;
    }
    
    if ( self.spawnsystem_init < 0 )
    {
        self.spawnsystem_init = 0;
        return;
    }
}

// Params 0
// Size: 0x2c5
function ref_125fc()
{
    var0 = spawnstruct();
    var0.ref_12889 = [];
    var0.brtdm_config = [];
    var0.brtruck_cleanupents = [];
    var0.brtruck_ontimelimit = [];
    var0.offhands = [];
    var0.nvidiaansel_overridecollisionradius = [];
    var0.should_use_velo_forward = self.should_use_velo_forward;
    var0.callprecisionairstrikeonlocation = scripts\mp\equipment::getequipmentslotammo( "health" );
    var1 = [];
    var2 = self getweaponslistprimaries();
    
    foreach ( var4 in var2 )
    {
        if ( !scripts\mp\utility\weapon::update_health_bar_to_player( var4 ) && !issubstr( var4.basename, "iw8_fists_mp" ) && !scripts\mp\utility\weapon::unset_relic_mythic( var4.basename ) )
        {
            var1 = var4;
        }
    }
    
    foreach ( var7 in var1 )
    {
        var8 = createheadicon( var7 );
        
        if ( var7.basename == "iw8_lm_dblmg_mp" || var7.basename == "iw8_la_mike32_mp" )
        {
            var0.brtdm_config[ var8 ] = self getweaponammoclip( var7 );
            var0.brtruck_ontimelimit[ var8 ] = self getweaponammostock( var7 );
        }
        else
        {
            var0.brtdm_config[ var8 ] = weaponclipsize( var7 );
            var0.brtruck_ontimelimit[ var8 ] = int( max( self getweaponammostock( var7 ), weaponclipsize( var7 ) ) );
        }
        
        if ( scripts\mp\utility\weapon::turnexfiltoside( var7 ) )
        {
            var0.brtruck_cleanupents[ var8 ] = weaponclipsize( var7 );
        }
        
        if ( getsubstr( var8, 0, 4 ) == "alt_" )
        {
            continue;
        }
        
        var0.ref_12889[ var0.ref_12889.size ] = var7;
    }
    
    var10 = self getweaponslistoffhands();
    
    foreach ( var12 in var10 )
    {
        if ( var12.basename == "bandage_br" )
        {
            continue;
        }
        
        var13 = self getweaponammoclip( var12 );
        
        if ( var13 <= 0 )
        {
            continue;
        }
        
        var0.offhands[ var0.offhands.size ] = var12;
        var14 = createheadicon( var12 );
        var0.brtdm_config[ var14 ] = var13;
    }
    
    foreach ( var17 in self.equipment )
    {
        var0.nvidiaansel_overridecollisionradius[ var17 ] = var18;
    }
    
    var0.super = undefined;
    
    if ( isdefined( self.super ) && !self.super.usepercent )
    {
        var0.super = self.equipment[ "super" ];
    }
    
    if ( isdefined( self.streakdata.streaks[ 1 ] ) )
    {
        var0.vo_one_remain = self.streakdata.streaks[ 1 ].streakname;
    }
    
    if ( scripts\cp_mp\gasmask::hasgasmask( self ) )
    {
        var0.gasmaskhealth = self.gasmaskhealth;
        var0.plunderpads = self.plunderpads;
        var0.plundersilentcountdownendtime = self.plundersilentcountdownendtime;
    }
    
    self.ref_12eb0 = var0;
}

// Params 0
// Size: 0x13
function ref_125fb()
{
    _unlinkcorpsefromvehicle::ref_125fb();
    thread ref_13fab();
    thread ref_12cc3();
}

// Params 0
// Size: 0x32
function ref_13fab()
{
    self endon( "death" );
    wait 1;
    trial_dogtags();
    self.spawnsystem_init = propremovefromcircle();
    
    if ( self.spawnsystem_init == 0 )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "no_respawns", self );
        return;
    }
}

// Params 0
// Size: 0x15
function ref_12cc3()
{
    var0 = train_mover_test();
    
    if ( var0 >= 80 )
    {
        scripts\mp\perks\perks::bears();
        return;
    }
}

// Params 1
// Size: 0x33, Type: bool
function droponplayerdeath( var0 )
{
    ref_125fc();
    var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    scripts\mp\gametypes\br_pickups::minplunderextractions( var1 );
    scripts\mp\gametypes\br_pickups::missiontime( var1 );
    scripts\mp\gametypes\br_pickups::mintokensdropondeath( var1 );
    scripts\mp\gametypes\br_pickups::missedinfilplayerhandler( var1 );
    scripts\mp\gametypes\br_pickups::hangar_doors_opening_quadrace();
    return true;
}

// Params 2
// Size: 0xb2
function playerdropplunderondeath( var0, var1 )
{
    if ( scripts\mp\utility\game::updatehistoryhud( self ) )
    {
        return 1;
    }
    
    if ( istrue( level.gameended ) )
    {
        return 1;
    }
    
    if ( isdefined( self.plundercount ) && self.plundercount > 0 )
    {
        var2 = self.plundercount;
    }
    else
    {
        var2 = 0;
    }
    
    if ( istrue( self.unicornpoints ) )
    {
        var3 = 0;
        var4 = level.endgametutorial_func.ref_127b5;
    }
    else
    {
        var3 = int( var4 * level.ref_11bce.ref_127be + 0.5 );
        var4 = int( level.ref_11bce.ref_127b5 + var4 * level.ref_11bce.ref_127b6 + 0.5 );
    }
    
    scripts\mp\gametypes\br_plunder::playersetplundercount( var3 );
    
    if ( var4 <= 0 )
    {
        return;
    }
    
    scripts\mp\gametypes\br_plunder::ml_p3_func( var4, var2 );
    return 1;
}

// Params 4
// Size: 0x4e
function ref_12356( var0, var1, var2, var3 )
{
    if ( var0 != "brloot_mendota_intel" )
    {
        return var2;
    }
    
    if ( istrue( var3.playersetattractiontype ) )
    {
        return getdvarint( "scr_br_mxp_intel_quest_count", 10 );
    }
    
    if ( istrue( var3.´ÿÛ¥ˆêJÃ~‚™râÝ ) )
    {
        return getdvarint( "scr_br_mxp_intel_fresno_count", 10 );
    }
    
    return getdvarint( "scr_br_mxp_intel_cache_count", 1 );
}

// Params 1
// Size: 0x1f, Type: bool
function onusecompleted( var0 )
{
    if ( !isdefined( var0.tracknonoobplayerlocation ) )
    {
        return false;
    }
    
    return ref_11bcf( var0.tracknonoobplayerlocation, self );
}

// Params 1
// Size: 0x27
function ref_13a36( var0 )
{
    var0.count = var0.tracknonoobplayerlocation.count;
    return var0.tracknonoobplayerlocation.count;
}

// Params 1
// Size: 0x32
function get_chopper_minigun_start_node( var0 )
{
    var1 = self;
    
    if ( scripts\mp\gametypes\br_pickups::isinteltype( var0.scriptablename ) || intel_isintel( var0 ) )
    {
        if ( intel_cancollect( var1 ) )
        {
            return 1;
        }
        
        return 2;
    }
}

// Params 4
// Size: 0x29
function skippickupfeedback( var0, var1, var2, var3 )
{
    if ( ( scripts\mp\gametypes\br_pickups::isinteltype( var0.scriptablename ) || intel_isintel( var0 ) ) && istrue( var1 ) )
    {
        return 1;
    }
}

