
// Params 0
// Size: 0x8a4
function init()
{
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "circle" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "gulag" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "oneLife" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "waitLoadoutDone" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "drogBagLoadout" );
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "playerCountLandmarks" );
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "tabletReplace" );
    
    if ( getdvarint( "scr_br_payload_latejoin", 1 ) != 0 )
    {
        scripts\mp\gametypes\br_gametypes::move_molotov_mortar( "allowLateJoiners" );
    }
    
    scripts\mp\gametypes\br_gametypes::ref_12b11( "spawnHandled", &ref_1365d );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerKilledSpawn", &playerrespawn );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerWelcomeSplashes", &ref_126f1 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "infilSequence", &manage_fakebody_hides );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "skipInfilSequence", &ref_133d6 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "modifyPlayerDamage", &modifyplayerdamage );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerHandleRedeploy", &ref_125c4 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerDropPlunderOnDeath", &playerdropplunderondeath );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "spawnInitialVehicles", &spawninitialvehicles );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerConnect", &onplayerconnect );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "skipPrimaryWeaponDrop", &ref_133e1 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "skipLootPickupAnim", &ref_133db );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerKilled", &onplayerkilled );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "activateKillstreakOnPurchase", &attempted_to_use_gunship );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "createC130PathStruct", &scripts\engine\utility::void );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "postPlunder", &ref_12804 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onConnectSpawnPoint", &ref_12006 );
    
    if ( istrue( game[ "switchedsides" ] ) )
    {
        level.ref_133e0 = 1;
    }
    
    scripts\mp\gametypes\br_gametypes::ref_12b10( "allowedEntities", [ "br", "br_payload" ] );
    var0 = "downtown2";
    
    if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
    {
        var0 = "livingquarters";
    }
    
    level.disable_super_in_turret.ref_1226a = getdvar( "scr_br_payload_path", var0 );
    level.disable_super_in_turret.getquestscalervalue = getdvarint( "scr_br_payload_checkpoint_time", 240 );
    level.disable_super_in_turret.maxtime = getdvarint( "scr_br_payload_max_time", 300 );
    level.disable_super_in_turret.getpropspawnlocation = getdvarint( "scr_br_payload_checkpoint_remain", 60 );
    level.disable_super_in_turret.ref_14242 = getdvarfloat( "scr_br_payload_vehicle_mph", 6 );
    level.disable_super_in_turret.ref_14243 = getdvarfloat( "scr_br_payload_vehicle_mph_slow", 1 );
    level.disable_super_in_turret.ref_14240 = getdvarfloat( "scr_br_payload_vehicle_auto_mph", 12 );
    level.disable_super_in_turret.ref_14241 = getdvarfloat( "scr_br_payload_vehicle_mph_fast", 8 );
    level.disable_super_in_turret.ref_1422d = getdvarfloat( "scr_br_payload_vehicle_back_mph", 2 );
    level.disable_super_in_turret.ref_1422e = getdvarfloat( "scr_br_payload_vehicle_back_mph_slow", 1 );
    level.disable_super_in_turret.ref_13633 = getdvarfloat( "scr_br_payload_spawn_dist_defend", 7500 );
    level.disable_super_in_turret.ref_13632 = getdvarfloat( "scr_br_payload_spawn_dist_attack", 5500 );
    level.disable_super_in_turret.ref_13660 = getdvarfloat( "scr_br_payload_spawn_height_defend", 1500 );
    level.disable_super_in_turret.ref_1365f = getdvarfloat( "scr_br_payload_spawn_height_attack", 1000 );
    level.disable_super_in_turret.ref_1368f = getdvarfloat( "scr_br_payload_spawn_radius_defend", 500 );
    level.disable_super_in_turret.ref_1368e = getdvarfloat( "scr_br_payload_spawn_radius_attack", 500 );
    level.disable_super_in_turret.ref_11b58 = getdvarint( "scr_br_payload_max_damage_collision", 25 );
    level.disable_super_in_turret.ref_1225f = getdvarint( "scr_br_payload_econ", 1 );
    level.disable_super_in_turret.ref_129cb = getdvarint( "scr_br_payload_radial_spawn", 1 );
    level.disable_super_in_turret.set_force_aitype_sniper = getdvarint( "scr_br_payload_ground_spawn", 1 );
    level.disable_super_in_turret.set_force_aitype_shotgun = getdvarint( "scr_br_payload_ground_spawn_max", 20 );
    level.disable_super_in_turret.ref_13746 = getdvarint( "scr_br_payload_squad_spawn", 0 );
    level.disable_super_in_turret.ref_13601 = getdvarint( "scr_br_payload_attacker_air", 0 );
    level.disable_super_in_turret.ref_13602 = getdvarint( "scr_br_payload_attacker_air_max", 0 );
    level.disable_super_in_turret.ref_13604 = getdvarint( "scr_br_payload_spawn_protect_air_time", 5 );
    level.disable_super_in_turret.ref_1365c = getdvarint( "scr_br_payload_spawn_protect_ground_time", 10 );
    level.juggheli_spawner_jammer5_3 = getdvarint( "scr_br_payload_tacmap_zoom", 12000 );
    level.disable_super_in_turret.checkpoint_objective = getdvarint( "scr_br_payload_auto_kiosks", 1 );
    level.disable_super_in_turret.getquestscaledvalue = getdvarint( "scr_br_payload_checkpoint_models", 1 );
    level.disable_super_in_turret.getpropsize = getdvarint( "scr_br_payload_bunker_price", 5000 );
    level.disable_super_in_turret.getquesttimefrac = getdvarint( "scr_br_payload_tower_price", 2500 );
    level.disable_super_in_turret.mine_caves_turret_1_support = getdvarint( "scr_br_payload_vehicles", 0 );
    level.disable_super_in_turret.ref_136ab = getdvarfloat( "scr_br_payload_spawn_vehicle_time", 10 );
    level.disable_super_in_turret.ref_142f8 = getdvarfloat( "scr_br_payload_vo_help", 20000 );
    level.disable_super_in_turret.ref_14305 = getdvarfloat( "scr_br_payload_vo_same", 20000 );
    level.disable_super_in_turret.ref_142f6 = getdvarfloat( "scr_br_payload_vo_help", 5000 );
    level.disable_super_in_turret.ref_142ff = getdvarfloat( "scr_br_payload_vo_next", 10000 );
    level.disable_super_in_turret.brking_oncrateuse = getdvarint( "scr_br_payload_all_paths", 1 );
    level.disable_super_in_turret.convoy = getdvarint( "scr_br_payload_convoy", 1 );
    level.disable_super_in_turret.idflags_hyper_burst_round = getdvarint( "scr_br_payload_convoy_dist", 750 );
    level.disable_super_in_turret.idflags_no_dismemberment = level.disable_super_in_turret.idflags_hyper_burst_round * level.disable_super_in_turret.idflags_hyper_burst_round;
    level.disable_super_in_turret.little_bird_mg_mp_spawncallback = getdvarint( "scr_br_payload_disable_ascenders", 1 );
    var1 = getdvarfloat( "scr_br_payload_vo_near_check", 1500 );
    level.disable_super_in_turret.ref_142fe = var1 * var1;
    var2 = getdvarfloat( "scr_br_payload_vo_obs", 700 );
    level.disable_super_in_turret.ref_14300 = var2 * var2;
    level.disable_super_in_turret.brmini_kickplayersatcircleedge = getdvarint( "scr_br_payload_time_per_checkpoint", 120 );
    level.disable_super_in_turret.ref_136c4 = getdvarint( "scr_br_spawn_zones", 1 );
    level.disable_super_in_turret.ref_136c2 = getdvarint( "scr_br_spawn_zone_radius", 1700 );
    level.disable_super_in_turret.ref_136be = getdvarint( "scr_br_spawn_zones_hide", 1 );
    level.disable_super_in_turret.ref_136c1 = getdvarfloat( "scr_br_spawn_zones_outline_dur", 3 );
    level.disable_super_in_turret.ref_136c5 = getdvarint( "scr_br_spawn_zone_warning", 1 );
    level.disable_super_in_turret.ref_136c9 = getdvarint( "scr_br_spawn_zone_warning_rad", 300 );
    level.disable_super_in_turret.ref_136c0 = getdvarint( "scr_br_spawn_zone_oob_forgive_time", 1000 );
    level.disable_super_in_turret.ref_136bf = getdvarint( "scr_br_spawn_zone_oob_forgive_scale", 2 );
    level.disable_super_in_turret.start_drones_event = getdvarint( "scr_br_in_bounds_trigger", 1 );
    level.disable_super_in_turret.ref_13ded = getdvarint( "scr_br_truck_armor_box", 1 );
    level.disable_super_in_turret.playerplunderdeposit = getdvarint( "scr_br_payload_force_tiebreaker", 0 );
    level.disable_super_in_turret.ref_12caa = getdvarint( "scr_br_payload_respawn_overview", 1 );
    level.disable_super_in_turret.ref_11f9d = getdvarint( "scr_br_payload_obstacle_pay_scale", 40 );
    level.disable_super_in_turret.ref_121fc = getdvarint( "scr_br_payload_path_redeploy", 5 );
    level.disable_super_in_turret.ref_12199 = getdvarint( "scr_br_payload_overtime_max", 120 );
    level.disable_super_in_turret.ref_1219e = getdvarint( "scr_br_payload_overtime_s1", 60 );
    level.disable_super_in_turret.ref_1219f = getdvarint( "scr_br_payload_overtime_s2", 70 );
    level.disable_super_in_turret.ref_121a0 = getdvarint( "scr_br_payload_overtime_s3", 80 );
    level.disable_super_in_turret.ref_121a1 = getdvarint( "scr_br_payload_overtime_s4", 90 );
    level.ref_127cd = 11;
    level.ref_13c56 = 1;
    level.playerlocationtriggerexit = 1;
    level.debug_silo_thrust = spawnstruct();
    level.debug_silo_thrust.disabled = 0;
    level.debug_silo_thrust.minigameapplyplayernamesettings = getdvarint( "scr_br_alt_mode_payload_drop_max", -1 );
    level.debug_silo_thrust.minigamewinnersettings = getdvarfloat( "scr_br_alt_mode_payload_drop_percent", 0.33 );
    
    if ( level.disable_super_in_turret.checkpoint_objective )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "placedKiosks" );
    }
    
    if ( level.mapname == "mp_br_mechanics" && level.disable_super_in_turret.ref_1226a != "all" )
    {
        level.disable_super_in_turret.ref_1226a = "standard";
    }
    
    level.dialog_wait_ready_civ = 4;
    level.debug_safehouse_gunshop_start = 1;
    level.disable_super_in_turret.paths = [];
    level.playerzombieupdatetagobjectives = [ "apc_russian", "atv", "big_bird", "cargo_truck", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "little_bird_mg", "medium_transport", "pickup_truck", "tac_rover", "technical", "van", "loot_chopper" ];
    setdvar( "LKTPRPKPMR", 1 );
    setdvar( "LOSOOOTNMS", 0 );
    setdvar( "NNMLSMNTOQ", 0 );
    thread toggleusbstickinhand();
    thread delay_start_escort_enter_vehicle_objective();
}

// Params 0
// Size: 0x51d
function toggleusbstickinhand()
{
    waittillframeend();
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        var0 = game[ "attackers" ];
        var1 = game[ "defenders" ];
        game[ "attackers" ] = var1;
        game[ "defenders" ] = var0;
    }
    
    scripts\mp\utility\dvars::setoverridewatchdvar( "roundlimit", 2 );
    level.roundlimit = scripts\mp\utility\dvars::getwatcheddvar( "roundlimit" );
    scripts\mp\utility\game::registerroundswitchdvar( scripts\mp\utility\game::getgametype(), 1, 0, 1 );
    scripts\mp\utility\dvars::setoverridewatchdvar( "roundswitch", 1 );
    level.roundswitch = scripts\mp\utility\dvars::getwatcheddvar( "roundswitch" );
    level.ref_12888 = &emp_drone_proximity_explode;
    level.ref_11c76 = &dyn_door;
    level.defenderflagreset = &eliminatedhudmonitor;
    level.ref_12db7 = &endgame_stars;
    level.ontimelimit = &ontimelimit;
    level.ref_11c7b = &ref_12607;
    level.ref_11c7c = &ref_12608;
    level.ref_13b7e = &timelimitclock;
    level.ref_11c68 = &ref_11c68;
    level.ref_12059 = &munition_source_getridof;
    level.modeonspawnplayer = &embassy_level_init;
    level.ref_11c73 = &ref_12054;
    level.forcegivesuper = &eliminateplayer;
    
    if ( level.disable_super_in_turret.ref_1225f )
    {
        level.ref_11c7a = &ref_1226b;
    }
    
    scripts\mp\flags::gameflaginit( "infil_complete", 0 );
    scripts\mp\flags::gameflaginit( "infil_anim_started", 0 );
    level.disable_back_light = 1;
    level.roundenddelay = 5;
    level.checkforlaststandfinish = 1;
    level.ref_133e6 = 1;
    level.ref_133cd = 1;
    level.ref_133d7 = 1;
    level.set_tier_lights = getdvarfloat( "scr_br_payload_gunner_dmg_reduction", 0.4 );
    level.set_total_successful_vehicle_spawns_from_module = getdvarfloat( "scr_br_payload_gunner_dmg_pen", 0.4 );
    level.ref_12281 = "cargo_truck_mg";
    level.ref_12283 = "mkilo_physics_mg_payload";
    level.disable_super_in_turret.ref_1426e = 250;
    level.disable_super_in_turret.ref_1426d = 200;
    level.disable_super_in_turret.ref_14249 = ( 0, 0, 200 );
    level.disable_super_in_turret.ref_1226e = getdvarint( "scr_br_payload_quests", 1 );
    level.disable_super_in_turret.ref_12275 = getdvarint( "scr_br_payload_reset_quest_tracking", 0 );
    level.disable_super_in_turret.ref_12271 = getdvarint( "scr_br_payload_quests_num_squads", 1 );
    level.disable_super_in_turret.ref_12272 = getdvarint( "scr_br_payload_quests_tablets", 1 );
    level.disable_super_in_turret.ref_12273 = getdvarint( "scr_br_payload_versus_tablets", 1 );
    level.disable_super_in_turret.ref_1226f = getdvarint( "scr_br_payload_quests_give_att", 1 );
    level.disable_super_in_turret.ref_12270 = getdvarint( "scr_br_payload_quests_give_def", 0 );
    level.disable_super_in_turret.ref_1227c = getdvarint( "scr_br_payload_speed_reward_time", 45 );
    level.disable_super_in_turret.ref_12288 = getdvarint( "scr_br_payload_xp_checkpoint", 2000 );
    scripts\mp\rank::ref_12189( "kill", 100 );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "vehicle_spawn", "gameModeSupportsRespawn", &vehicle_spawn_mp_gamemodesupportsrespawn );
    level.vehicle.spawn.ref_12ca2 = getdvarint( "scr_br_payload_vehicle_respawn", 30 );
    scripts\cp_mp\vehicles\vehicle_damage::ref_14176( level.ref_12281, &ref_14259 );
    var2 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "cargo_truck_mg" );
    var2.ref_13e92 = "tur_gun_payload_truck_mp";
    scripts\cp_mp\vehicles\vehicle_interact::ref_1419d( level.ref_12281, "single", [ "gunner" ] );
    var3 = "driver";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( level.ref_12281, var3 );
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, [ var3 ] );
    var3 = "gunner";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( level.ref_12281, var3 );
    var4.exitids = [ "back", "back_left", "back_right", "front", "side_right" ];
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, [ var3 ] );
    var4.ref_13e8a = getcompleteweaponname( "tur_gun_payload_truck_mp" );
    var4.ref_13e92 = "tur_gun_payload_truck_mp";
    scripts\cp_mp\vehicles\vehicle_interact::ref_141a7( "upgrade", &ref_1418d, &ref_141ae, &ref_1418d, &ref_1418d );
    scripts\cp_mp\vehicles\vehicle_interact::ref_141a7( "copyofupgrade", &ref_1418d, &ref_141ae, &ref_1418d, &ref_1418d );
    scripts\cp_mp\vehicles\vehicle_interact::ref_1419d( level.ref_12281, "upgrade", [ "tag_screen_left", 0, &ref_1418c ] );
    scripts\cp_mp\vehicles\vehicle_interact::ref_1419d( level.ref_12281, "copyofupgrade", [ "tag_screen_right", 0, &ref_1418c ] );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "specialCase_canUseCrate", &eliminate_drone_spotlight_speed );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "killstreak", "createCustomStreakData", &init_relic_fastbleedout );
    level.headiconbox = undefined;
    timetonextcheckpoint();
    toggle_fx_trap();
    time_between_rocket_fire();
    timed_laser_trap_trigger();
    thankyou_photo();
    totalcollecteditems();
    timed_death();
    tracegroundheightexfil();
    technical_initdamage();
    terminal_pusher_approach_array_counter();
    time_on_floor();
    thread toggle_player_settings();
    tmtyl_vip_interactions();
    thread totalmuncurrencyearned();
    tomastrike_isflyingvehicle();
    hideinvisiblecollisions();
    level.teamdata[ game[ "attackers" ] ][ "respawnDelay" ] = getdvarint( "scr_br_payload_spawn_delay_attack", 0 );
    level.teamdata[ game[ "defenders" ] ][ "respawnDelay" ] = getdvarint( "scr_br_payload_spawn_delay_defend", 15 );
    thread ref_1452d( game[ "attackers" ] );
    thread ref_1452d( game[ "defenders" ] );
    
    if ( istrue( level.disable_super_in_turret.ref_1226e ) )
    {
        scripts\mp\gametypes\br_capshoot_quest::init();
        thread ref_1226d();
    }
    
    thread ref_1225e();
    thread ref_1226c();
    thread ref_12258();
    thread ref_131d6();
    level.isoutside = 0;
    level.isopenable = 0;
}

// Params 0
// Size: 0x41
function hideinvisiblecollisions()
{
    var0 = getent( "buildable_checkpoint_clipbrush", "targetname" );
    var1 = getent( "buildable_guardtower_clipbrush", "targetname" );
    var2 = ( 0, 0, 0 );
    var0.origin = var2;
    var1.origin = var2;
}

// Params 4
// Size: 0x11
function ref_141ae( var0, var1, var2, var3 )
{
    var1.disabled = 1;
}

// Params 1
// Size: 0x3c
function player_get_primary_weapon_object( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return "super_ammo_drop";
    }
    
    switch ( var0 )
    {
        case "super_tac_insert":
        case "super_emp_drone":
        case "none":
            return "super_ammo_drop";
        default:
            return var0;
    }
}

// Params 4
// Size: 0x19
function eliminateplayer( var0, var1, var2, var3 )
{
    var0 = player_get_primary_weapon_object( var0 );
    scripts\mp\gametypes\br_pickups::forcegivesuper( var0, var1, var2, var3 );
}

// Params 0
// Size: 0x84
function ref_1226c()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    setomnvar( "ui_hardpoint_timer", gettime() );
    thread ref_13277( game[ "attackers" ] );
    thread ref_13277( game[ "defenders" ] );
    scripts\mp\flags::gameflagwait( "infil_complete" );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 scripts\mp\supers::getcurrentsuper() ) )
        {
            var1 scripts\mp\supers::setsuperbasepoints( 0 );
            var1 scripts\mp\supers::setsuperextrapoints( 0 );
        }
    }
}

// Params 1
// Size: 0x44
function ref_13277( var0 )
{
    var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    foreach ( var3 in var1 )
    {
        scripts\mp\utility\outline::outlineenableforteam( var3, var0, "outline_depth_payload", "level_script" );
    }
}

// Params 0
// Size: 0x69
function ref_11c68()
{
    setomnvar( "ui_current_round", 1 );
    setomnvarforallclients( "post_game_state", 2 );
    scripts\mp\gametypes\br_public::brleaderdialog( "halftime", 0, undefined, 1, 2 );
    wait 10;
    
    foreach ( var1 in level.players )
    {
        var1 setclientomnvar( "ui_br_extended_load_screen", 1 );
        var1 setsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 2 );
    }
}

// Params 1
// Size: 0x8c
function onplayerconnect( var0 )
{
    var0 waittill( "spawned_player" );
    
    if ( var0.team == game[ "attackers" ] )
    {
        ref_13184( var0, 0 );
    }
    else
    {
        ref_13184( var0, 1 );
    }
    
    thread ref_13277( game[ "attackers" ] );
    thread ref_13277( game[ "defenders" ] );
    
    if ( scripts\mp\flags::gameflag( "infil_complete" ) )
    {
        thread ref_1268d();
        thread ref_126e0();
        
        if ( isdefined( var0 scripts\mp\supers::getcurrentsuper() ) )
        {
            var0 scripts\mp\supers::setsuperbasepoints( 0 );
            var0 scripts\mp\supers::setsuperextrapoints( 0 );
        }
    }
    
    var0.heli_landing_volumes = [];
}

// Params 0
// Size: 0x1b
function onplayerspawned()
{
    level endon( "prematch_done" );
    
    for ( ;; )
    {
        play_smoke_fx( self );
        self waittill( "spawned_player" );
    }
}

// Params 1
// Size: 0x11e
function onplayerkilled( var0 )
{
    var1 = var0.victim;
    var2 = var0.attacker;
    
    if ( isdefined( var2.vehicle ) && isdefined( var2.vehicle.occupants ) && isdefined( var2.vehicle.occupants[ "gunner" ] ) )
    {
        if ( var2 == var2.vehicle.occupants[ "gunner" ] )
        {
            var2 thread scripts\mp\rank::giverankxp( "br_payload_kill_as_gunner", 50 );
            var2 thread scripts\mp\rank::scoreeventpopup( "br_payload_kill_as_gunner" );
            var2 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance( 50, "br_payload_kill_as_gunner" );
        }
    }
    
    if ( isdefined( var1.vehicle ) && isdefined( var1.vehicle.occupants ) && isdefined( var1.vehicle.occupants[ "gunner" ] ) )
    {
        if ( var1 == var1.vehicle.occupants[ "gunner" ] )
        {
            var2 thread scripts\mp\rank::giverankxp( "br_payload_killed_gunner", 100, undefined );
            var2 thread scripts\mp\gametypes\br::scriptableusestate( "br_payload_killed_gunner", int( 50 ), var2.currentweapon, 1 );
            var2 thread scripts\mp\rank::scoreeventpopup( "br_payload_killed_gunner" );
            var2 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance( 100, "br_payload_killed_gunner" );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x1e
function ref_12054( var0 )
{
    scripts\mp\gametypes\br_weapons::droptogroundmultitrace( var0 );
    
    if ( scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        ref_12508();
        return;
    }
}

// Params 0
// Size: 0xc2
function ref_12508()
{
    var0 = getdvarint( "scr_br_payload_start_ammo", 2 );
    
    if ( var0 == -2 )
    {
        foreach ( var2 in [ self.primaryweapon, self.secondaryweapon ] )
        {
            if ( isdefined( var2 ) )
            {
                var3 = weaponclipsize( var2 );
                self setweaponammoclip( var2, var3 );
                self givemaxammo( var2 );
            }
        }
    }
    else if ( var0 == -1 )
    {
        scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
    }
    else if ( var0 > 0 )
    {
        scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
        
        foreach ( var6 in [ self.primaryweapon, self.secondaryweapon ] )
        {
            ref_13197( var6, var0 );
        }
        
        ref_13141();
    }
    
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( self );
}

// Params 0
// Size: 0x88
function ref_13141()
{
    foreach ( var1 in [ self.primaryweapon, self.secondaryweapon ] )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        if ( scripts\engine\utility::string_starts_with( var1, "iw8_sn_crossbow" ) || scripts\engine\utility::string_starts_with( var1, "iw8_sn_t9crossbow" ) )
        {
            var2 = asmdevgetallstates( var1 );
            var3 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var2 );
            
            if ( isdefined( var3 ) )
            {
                var4 = getdvarint( "scr_br_crossbow_ammo_override", 20 );
                scripts\mp\gametypes\br_weapons::br_ammo_give_type( self, var3, var4, 0 );
            }
            
            break;
        }
    }
}

// Params 2
// Size: 0x71
function ref_13197( var0, var1 )
{
    var2 = asmdevgetallstates( var0 );
    var3 = scripts\mp\utility\weapon::getweaponbasenamescript( var2 );
    var4 = weaponclass( var3 );
    var5 = "scr_br_payload_ammoscale_" + var4;
    var6 = int( max( 0, getdvarint( var5, var1 ) ) );
    var7 = weaponclipsize( var0 );
    var8 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var2 );
    
    if ( isdefined( var8 ) )
    {
        self.br_ammo[ var8 ] = 0;
        
        if ( istrue( var2.should_spawn_boss_one ) )
        {
            scripts\mp\gametypes\br_weapons::zone_bounds( var2, 1 );
            return;
        }
        
        scripts\mp\gametypes\br_weapons::br_ammo_give_type( self, var8, var7 * var6, 0 );
        return;
    }
}

// Params 1
// Size: 0x20
function attempted_to_use_gunship( var0 )
{
    switch ( var0 )
    {
        case "juggernaut":
            return 1;
        default:
            return undefined;
    }
}

// Params 0
// Size: 0x21c
function totalmuncurrencyearned()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "infil_complete" );
    
    foreach ( var1 in level.players )
    {
        var1.shouldfinishshootinglongdeath = 0;
    }
    
    for ( ;; )
    {
        foreach ( var4 in level.disable_super_in_turret.paths )
        {
            if ( istrue( var4.hidesmokinggunhudfromplayer ) )
            {
                continue;
            }
            
            if ( !isdefined( var4.obj_payload_stage ) )
            {
                continue;
            }
            
            foreach ( var6 in var4.obj_payload_stage.touchlist )
            {
                foreach ( var8 in var6 )
                {
                    foreach ( var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var8.player.team, var8.player.squadindex ) )
                    {
                        if ( !isdefined( var1.ref_1227e ) )
                        {
                            var1.ref_1227e = 0;
                        }
                        
                        var1.ref_1227e += 5;
                        
                        if ( var1.ref_1227e >= 20 )
                        {
                            if ( !var1.shouldfinishshootinglongdeath )
                            {
                                var1 thread scripts\mp\rank::scoreeventpopup( "br_payload_squad_on_payload" );
                            }
                            
                            var1.shouldfinishshootinglongdeath = 1;
                            var10 = getdvarint( "scr_br_timeOnPayload_xpOverride", 18 );
                            var11 = int( var10 ) * var1.ref_1227e;
                            var1 thread scripts\mp\rank::giverankxp( "br_payload_squad_on_payload", var11, undefined );
                            var1 thread scripts\mp\gametypes\br::searchradiusidealmax( min( 40, var1.ref_1227e ) * 1000 );
                            var1 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance( var11, "br_payload_squad_on_payload" );
                            var1.ref_1227e = 0;
                        }
                    }
                }
            }
        }
        
        foreach ( var1 in level.players )
        {
            var1.shouldfinishshootinglongdeath = 0;
        }
        
        wait 5;
    }
}

// Params 2
// Size: 0x5
function ref_1418c( var0, var1 )
{
    
}

// Params 4
// Size: 0x7
function ref_1418d( var0, var1, var2, var3 )
{
    
}

// Params 0
// Size: 0x5, Type: bool
function vehicle_spawn_mp_gamemodesupportsrespawn()
{
    return true;
}

// Params 1
// Size: 0x3a
function ref_126f1( var0 )
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    wait 1;
    
    if ( !istrue( game[ "liveLobbyCompleted" ] ) && !istrue( game[ "switchedsides" ] ) )
    {
        scripts\mp\hud_message::showsplash( "br_prematch_welcome" );
        return;
    }
}

// Params 1
// Size: 0x89, Type: bool
function ref_1365d( var0 )
{
    if ( istrue( level.dmztut_endgametransition ) && isdefined( self.thrust_fx_model ) && !istrue( var0.br_infilstarted ) )
    {
        var1 = spawnstruct();
        var0.br_infilstarted = 1;
        var0.ref_1286f = var0.thrust_fx_model;
        var0.ref_1286f.index = -1;
        thread ref_126a4( var0 );
    }
    
    if ( istrue( game[ "switchedsides" ] ) && isdefined( self.thrust_fx_model ) )
    {
        return true;
    }
    
    return istrue( var0.br_infilstarted ) && scripts\mp\flags::gameflag( "prematch_done" );
}

// Params 0
// Size: 0x117
function manage_fakebody_hides()
{
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "oneLife" ) )
    {
        level.disablespawning = 1;
        setdynamicdvar( "scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1 );
    }
    
    level.disable_super_in_turret.ref_13916 = 0;
    
    if ( !istrue( game[ "switchedsides" ] ) )
    {
        scripts\mp\deathicons::ref_12bfd();
    }
    else
    {
        ref_143f7();
    }
    
    ref_1361b();
    level.dmztut_endgametransition = 1;
    scripts\mp\gametypes\br_vehicles::emptyallvehicles();
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) )
        {
            thread ref_1255f();
        }
    }
    
    thread maxnumsites();
    
    if ( !istrue( game[ "switchedsides" ] ) )
    {
        wait 2;
    }
    
    scripts\mp\flags::gameflagset( "prematch_fade_done" );
    ref_143f8( getdvarfloat( "scr_br_payload_infil_wait", 9 ) );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) )
        {
            thread ref_1255d();
        }
    }
    
    scripts\mp\flags::gameflagset( "infil_anim_started" );
    wait 6.66667;
    waitframe();
    scripts\mp\flags::gameflagset( "infil_complete" );
    waitframe();
    last_unresolved_collision_time();
}

// Params 0
// Size: 0x3a
function maxnumsites()
{
    level endon( "infil_complete" );
    
    for ( ;; )
    {
        level waittill( "connected", var0 );
        
        if ( !scripts\mp\flags::gameflag( "infil_anim_started" ) )
        {
            thread ref_1255f( var0 );
            continue;
        }
        
        thread ref_1255d();
    }
}

// Params 0
// Size: 0x24
function ref_143f7()
{
    var0 = gettime() + 10000;
    
    while ( gettime() < var0 && getactiveclientcount() != level.players.size )
    {
        waitframe();
    }
}

// Params 0
// Size: 0xd
function ref_133d6()
{
    scripts\mp\flags::gameflagset( "infil_complete" );
}

// Params 0
// Size: 0x7c
function ref_1361b()
{
    var0 = 8;
    level.disable_super_in_turret.gas_trigger_player_think = [];
    var1 = int( max( getactiveclientcount(), level.players.size ) );
    
    for ( var2 = 0; var2 < var1 ; var2++ )
    {
        var3 = spawn( "script_model", ( 0, 0, 0 ) );
        var3 setmodel( "generic_prop_x3" );
        level.disable_super_in_turret.gas_trigger_player_think[ level.disable_super_in_turret.gas_trigger_player_think.size ] = var3;
        
        if ( ( var2 + 1 ) % var0 == 0 )
        {
            waitframe();
        }
    }
}

// Params 0
// Size: 0x4e
function last_unresolved_collision_time()
{
    foreach ( var1 in level.disable_super_in_turret.gas_trigger_player_think )
    {
        if ( isdefined( var1 ) && !istrue( var1.inuse ) )
        {
            var1 delete();
        }
    }
    
    level.disable_super_in_turret.gas_trigger_player_think = undefined;
}

// Params 1
// Size: 0x1cf
function ref_1255f( var0 )
{
    self endon( "disconnect" );
    
    if ( isdefined( self.cameraent ) )
    {
        return;
    }
    
    self.br_infilstarted = 1;
    
    if ( istrue( var0 ) )
    {
        waitframe();
    }
    
    if ( !isdefined( level.disable_super_in_turret.gas_trigger_player_think[ self getentitynumber() ] ) )
    {
        var1 = spawn( "script_model", ( 0, 0, 0 ) );
        var1 setmodel( "generic_prop_x3" );
        level.disable_super_in_turret.gas_trigger_player_think[ self getentitynumber() ] = var1;
    }
    
    self.cameraent = level.disable_super_in_turret.gas_trigger_player_think[ self getentitynumber() ];
    self.cameraent.inuse = 1;
    
    if ( !istrue( game[ "switchedsides" ] ) )
    {
        scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    }
    
    var2 = round_enemies_push_logic( self.team, self.squadindex );
    var3 = level.disable_super_in_turret.paths[ var2 ];
    
    if ( !isdefined( self.ref_13689 ) )
    {
        ref_12689( var3 );
        self.ref_13689 = ref_1257c( var3 );
    }
    
    self.cameraent.origin = self.ref_13689.origin;
    self.cameraent.angles = ref_1257a( var3, self.cameraent.origin );
    var4 = ref_1257b();
    self.cameraent scriptmodelplayanim( var4, "spawn_camera_anim" );
    self.cameraent scriptmodelpauseanim( 1 );
    waittillframeend();
    var5 = self.cameraent gettagorigin( "j_prop_1" );
    var6 = getdvarint( "scr_br_initial_stream_timeout_pl_ms", 12000 );
    scripts\mp\gametypes\br_public::ref_126b9( var5, var6, 1 );
    
    if ( !istrue( var0 ) && !istrue( game[ "switchedsides" ] ) )
    {
        wait 2;
    }
    
    if ( istrue( self.delay_enter_combat_after_investigating_grenade ) )
    {
        scripts\mp\gametypes\br::ref_13f21( self );
    }
    
    self setclientomnvar( "ui_br_infil_started", 1 );
    self setclientomnvar( "ui_br_infiled", 1 );
    scripts\mp\gametypes\br::spawnintermission( var5, self.cameraent.angles );
    
    if ( !istrue( game[ "switchedsides" ] ) )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 5 );
    }
    
    scripts\mp\gametypes\br_public::ref_126ed();
    level.disable_super_in_turret.ref_13916++;
}

// Params 2
// Size: 0x7e
function ref_1257a( var0, var1 )
{
    if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
    {
        var2 = var0.nodes[ 0 ].origin - var1;
    }
    else if ( self.team == game[ "attackers" ] )
    {
        var2 = var1.nodes[ var1.nodes.size - 1 ].origin - var2;
    }
    else
    {
        var2 = var2.nodes[ 0 ].origin - var2;
    }
    
    var3 = vectortoangles( var2 );
    return ( 0, var3[ 1 ], 0 );
}

// Params 0
// Size: 0xc9
function ref_1257b()
{
    switch ( level.disable_super_in_turret.ref_1226a )
    {
        case "livingquarters":
            if ( self.team == game[ "attackers" ] )
            {
                return "iw8_br_payload_escape4_intro_camera_swoop_LQ_Atck";
            }
            else
            {
                return "iw8_br_payload_escape4_intro_camera_swoop_LQ_Dfnd";
            }
            
            break;
        case "chemicaleng":
            if ( self.team == game[ "attackers" ] )
            {
                return "iw8_br_payload_escape4_intro_camera_swoop_CE_Atck";
            }
            else
            {
                return "iw8_br_payload_escape4_intro_camera_swoop_CE_Dfnd";
            }
            
            break;
        case "shore":
            if ( self.team == game[ "attackers" ] )
            {
                return "iw8_br_payload_escape4_intro_camera_swoop_S_Atck";
            }
            else
            {
                return "iw8_br_payload_escape4_intro_camera_swoop_S_Dfnd";
            }
            
            break;
        default:
            if ( self.team == game[ "attackers" ] )
            {
                return "iw8_br_payload_intro_camera_swoop_attackers";
            }
            else
            {
                return "iw8_br_payload_intro_camera_swoop_defenders";
            }
            
            break;
    }
}

// Params 2
// Size: 0xf9
function round_enemies_push_logic( var0, var1 )
{
    if ( isdefined( level.squaddata[ var0 ][ var1 ].time_after_shoot ) )
    {
        return level.squaddata[ var0 ][ var1 ].time_after_shoot;
    }
    
    if ( !isdefined( level.teamdata[ var0 ][ "nextSpawnIndex" ] ) )
    {
        var2 = relic_squadlink_outline_monitor( var0 );
        
        if ( isdefined( level.teamdata[ var2 ][ "nextSpawnIndex" ] ) )
        {
            level.teamdata[ var0 ][ "nextSpawnIndex" ] = level.teamdata[ var2 ][ "nextSpawnIndex" ];
        }
        else
        {
            level.teamdata[ var0 ][ "nextSpawnIndex" ] = randomint( level.disable_super_in_turret.paths.size );
        }
    }
    
    level.squaddata[ var0 ][ var1 ].time_after_shoot = level.teamdata[ var0 ][ "nextSpawnIndex" ];
    level.teamdata[ var0 ][ "nextSpawnIndex" ]++;
    
    if ( level.teamdata[ var0 ][ "nextSpawnIndex" ] >= level.disable_super_in_turret.paths.size )
    {
        level.teamdata[ var0 ][ "nextSpawnIndex" ] = 0;
    }
    
    return level.squaddata[ var0 ][ var1 ].time_after_shoot;
}

// Params 0
// Size: 0x120
function ref_1255d()
{
    self endon( "disconnect" );
    
    if ( self.sessionstate != "intermission" )
    {
        ref_1255f( 1 );
    }
    else
    {
        scripts\mp\gametypes\br_public::ref_126ed();
    }
    
    ref_1255c();
    
    if ( !istrue( game[ "switchedsides" ] ) )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 5 );
    }
    
    ref_13185( 1 );
    var0 = 1;
    var1 = 6.66667 - var0;
    scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    self clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
    self clearsoundsubmix( "deaths_door_mp", 1 );
    self clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 1 );
    self clearsoundsubmix( "mp_br_mode_payload_completed", 0.5 );
    self clearpredictedstreampos();
    self setclientomnvar( "ui_br_transition_type", 0 );
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
    self cameralinkto( self.cameraent, "j_prop_1", 1, 1 );
    self.cameraent scriptmodelpauseanim( 0 );
    thread ref_12560();
    wait var1;
    var2 = angleclamp180( angleclamp180( self.angles[ 1 ] ) - angleclamp180( self.cameraent.angles[ 1 ] ) );
    self.cameraent rotateyaw( var2, var0, 0.1, 0.1 );
    wait var0;
    thread ref_1255e();
    wait 1;
    self.cameraent delete();
}

// Params 0
// Size: 0xc5
function ref_12560()
{
    self endon( "disconnect" );
    var0 = 0.5;
    var1 = 1;
    var2 = 6.66667 - var0 - var1;
    self setsoundsubmix( "iw8_br_payload_infil_camera" );
    wait var0;
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "payload_welcome", self );
    
    if ( self.team == game[ "defenders" ] )
    {
        var3 = "br_payload_welcome_defenders";
        
        if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
        {
            var3 = "br_payload_welcome_defenders_mini";
        }
        
        scripts\mp\hud_message::showsplash( var3 );
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "defend_intro1", self );
    }
    else
    {
        var3 = "br_payload_welcome_attackers";
        
        if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
        {
            var3 = "br_payload_welcome_attackers_mini";
        }
        
        scripts\mp\hud_message::showsplash( var3 );
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "attack_intro1", self );
    }
    
    wait var2;
    self setplayermusicstate( "br3_payload_round_start" );
    wait var3;
    self clearsoundsubmix( "iw8_br_payload_infil_camera", 6 );
}

// Params 1
// Size: 0x9d
function ref_1255c( var0 )
{
    self endon( "disconnect" );
    self notify( "playerPayloadFirstSpawn" );
    self endon( "playerPayloadFirstSpawn" );
    scripts\mp\gametypes\br_public::ref_1264c();
    self.forcespawnorigin = self.ref_13689.origin;
    self.forcespawnangles = self.ref_13689.angles;
    self.ref_12ca8 = !game[ "switchedsides" ];
    
    if ( !isalive( self ) )
    {
        self.“›³9€›ã©»Gxu«z1šOëh² = 1;
    }
    
    self.plotarmor = 1;
    scripts\mp\playerlogic::spawnplayer( 0 );
    
    if ( istrue( self.delay_enter_combat_after_investigating_grenade ) )
    {
        scripts\mp\gametypes\br::ref_13f21( self );
    }
    
    waitframe();
    self.ref_13689 = undefined;
    self.plotarmor = undefined;
    self.ref_12ca8 = undefined;
    self.thrust_fx_model = undefined;
    self freezecontrols( 1 );
    self playerhide();
}

// Params 0
// Size: 0x6d
function ref_1255e()
{
    self cameraunlink();
    self freezecontrols( 0 );
    self playershow();
    
    if ( scripts\mp\gametypes\br_gulag::set_relic_punchbullets() )
    {
        scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    }
    
    self setclientomnvar( "ui_br_transition_type", 0 );
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
    
    if ( level.disable_super_in_turret.ref_13602 > -1 )
    {
        thread ref_1253a();
    }
    
    ref_13185( 0 );
    
    if ( isdefined( scripts\mp\supers::getcurrentsuper() ) )
    {
        scripts\mp\supers::setsuperbasepoints( 0 );
        scripts\mp\supers::setsuperextrapoints( 0 );
    }
    
    ref_1255b();
}

// Params 1
// Size: 0x30
function ref_143f8( var0 )
{
    var1 = gettime() + var0 * 1000;
    
    while ( gettime() < var1 && level.disable_super_in_turret.ref_13916 < level.players.size )
    {
        waitframe();
    }
}

// Params 1
// Size: 0x80
function ref_136aa( var0 )
{
    ref_13230();
    
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        ref_1367a( var2, game[ "attackers" ], var0 );
        
        if ( level.disable_super_in_turret.convoy )
        {
            ref_1367b( var2, game[ "attackers" ], var0 );
        }
    }
    
    init_relic_doubletap( game[ "attackers" ] );
    init_relic_doubletap( game[ "defenders" ] );
    thread ref_13c54();
}

// Params 3
// Size: 0x21f
function ref_1367a( var0, var1, var2 )
{
    var3 = ( 0, 0, 0 );
    var4 = var0;
    var5 = undefined;
    var6 = 0;
    
    if ( level.disable_super_in_turret.convoy )
    {
        var6 = 1;
    }
    
    if ( isdefined( var0.nodes ) && isdefined( var0.nodes[ var6 ] ) && isdefined( var0.nodes[ var6 + 1 ] ) )
    {
        var4 = var0.nodes[ var6 ];
        var5 = var0.nodes[ var6 + 1 ];
        var3 = vectortoangles( var5.origin - var4.origin );
    }
    else if ( isdefined( var0.target ) )
    {
        if ( level.disable_super_in_turret.convoy )
        {
            var4 = scripts\engine\utility::getstruct( var0.target, "targetname" );
        }
        else
        {
            var4 = var0;
        }
        
        if ( isdefined( var4 ) && isdefined( var4.target ) )
        {
            var5 = scripts\engine\utility::getstruct( var4.target, "targetname" );
            var3 = vectortoangles( var5.origin - var4.origin );
        }
    }
    
    var7 = spawnstruct();
    var7.origin = var4.origin;
    var7.angles = var3;
    var7.spawntype = "GAME_MODE";
    var7.spawnmethod = "place_at_position_unsafe";
    var7.team = var1;
    var7.player_rig_create = &ref_1423f;
    var7.vehicletype = level.ref_12283;
    var7.modelname = "veh8_mil_lnd_mkilo23_payload";
    var7.turretmodel = "veh8_mil_lnd_mkilo23_turret_payload";
    var8 = spawnstruct();
    var9 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( level.ref_12281, var7, var8 );
    var9.ondeathrespawn = undefined;
    var9 unmarkkeyframedmover( 1 );
    var9 method_87c2( 1 );
    
    foreach ( var11 in var9.turrets )
    {
        var11 setscriptablepartstate( "barrel", "show" );
        ref_136a4( var11 );
    }
    
    if ( istrue( var2 ) && level.disable_super_in_turret.ref_13ded )
    {
        ref_1360a( var9 );
    }
    
    if ( isdefined( var5 ) )
    {
        var0.vehicle = var9;
        var9.path = var0;
    }
    
    ref_14260( var9, var0 );
    
    if ( isdefined( var5 ) )
    {
        thread ref_1422f( var9 );
    }
    
    return var9;
}

// Params 1
// Size: 0x63
function ref_136a4( var0 )
{
    if ( getdvarint( "scr_br_payload_tcol", 1 ) == 0 )
    {
        return;
    }
    
    var1 = spawn( "script_model", ( 0, 0, 0 ) );
    var1 setmodel( "veh8_mil_lnd_mkilo23_turret_payload_nomesh" );
    var1 linkto( var0, "tag_aim_pivot", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var0.ref_13e84 = var1;
}

// Params 1
// Size: 0xe2
function ref_1360a( var0 )
{
    var1 = ( -158, -43, 67 );
    var2 = ( 0, 0, 0 );
    var3 = 80;
    var4 = "ui_mp_br_loot_icon_health_armor_box";
    var5 = &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
    var6 = "equip_armorBox";
    var7 = spawn( "script_model", var0.origin );
    var7 setmodel( "offhand_wm_supportbox_armor_br" );
    var7 linkto( var0, "tag_origin", var1, var2 );
    var7 setscriptablepartstate( "beacon", "active", 0 );
    var7 setscriptablepartstate( "anims", "openIdle", 0 );
    var7.ref_13f0f = 1;
    var7.team = game[ "attackers" ];
    var7 scripts\mp\equipment\support_box::supportbox_addheadicon( var4 );
    var7 thread scripts\mp\equipment\support_box::supportbox_makeusable( var6, var5 );
    var7 setuserange( var3 );
    var7 setusefov( 90 );
    var7 notsolid();
    setheadiconsnaptoedges( var7.showdroplocations, var3 );
    setheadiconsnaptoedges( var7.showemergencyhint, var3 );
    var0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel = var7;
}

// Params 0
// Size: 0x80
function ref_14234()
{
    level endon( "game_ended" );
    self notify( "vehicleCleanupLoot" );
    self endon( "vehicleCleanupLoot" );
    self endon( "pathComplete" );
    self endon( "death" );
    
    for ( ;; )
    {
        var0 = canceljoins( undefined, undefined, self.origin, level.disable_super_in_turret.ref_1426e );
        
        foreach ( var2 in var0 )
        {
            if ( issubstr( var2.type, "_weapon_" ) )
            {
                var2 scripts\mp\gametypes\br_pickups::lastgoodjobplayer();
            }
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x9f, Type: bool
function ref_133e1( var0 )
{
    var1 = self;
    
    foreach ( var3 in level.disable_super_in_turret.paths )
    {
        if ( isdefined( var3.vehicle ) && ref_11a3e( var3.vehicle, var1.origin ) )
        {
            return true;
        }
        
        foreach ( var5 in var3.ref_11f9e )
        {
            if ( isdefined( var5 ) && ref_11a3d( var5, var1.origin ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 2
// Size: 0x2f, Type: bool
function ref_11a3e( var0, var1 )
{
    var2 = level.disable_super_in_turret.ref_1426e * level.disable_super_in_turret.ref_1426e;
    var3 = distance2dsquared( var1, var0.origin );
    return var3 < var2;
}

// Params 2
// Size: 0x1f, Type: bool
function ref_11a3d( var0, var1 )
{
    var2 = 10000;
    var3 = distance2dsquared( self.origin, var0.origin );
    return var3 < var2;
}

// Params 1
// Size: 0x96, Type: bool
function ref_133db( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        if ( isdefined( var2.vehicle ) && ref_11a3e( var2.vehicle, var0.origin ) )
        {
            return true;
        }
        
        foreach ( var4 in var2.ref_11f9e )
        {
            if ( ref_11a3d( var4, var0.origin ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 3
// Size: 0x1ac
function ref_1367b( var0, var1, var2 )
{
    var3 = ( 0, 0, 0 );
    var4 = undefined;
    
    if ( isdefined( var0.nodes ) && isdefined( var0.nodes[ 1 ] ) )
    {
        var4 = var0.nodes[ 1 ];
        var3 = vectortoangles( var4.origin - var0.origin );
    }
    
    var5 = spawnstruct();
    var5.origin = var0.origin;
    var5.angles = var3;
    var5.spawntype = "GAME_MODE";
    var5.spawnmethod = "place_at_position_unsafe";
    var5.team = var1;
    var5.player_rig_create = &ref_1423f;
    var5.vehicletype = level.ref_12283;
    var5.modelname = "veh8_mil_lnd_mkilo23_payload_convoy";
    var5.turretmodel = "veh8_mil_lnd_mkilo23_turret_payload";
    var6 = spawnstruct();
    var7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( level.ref_12281, var5, var6 );
    var7.ondeathrespawn = undefined;
    var7 method_87c2( 1 );
    
    foreach ( var9 in var7.turrets )
    {
        var9 setscriptablepartstate( "barrel", "show" );
        ref_136a4( var9 );
    }
    
    if ( istrue( var2 ) )
    {
        ref_13dec( var7, var0.ref_12358, 0 );
        
        if ( level.disable_super_in_turret.ref_13ded )
        {
            ref_1360a( var7 );
        }
    }
    
    if ( isdefined( var4 ) )
    {
        var0.idle_sfx = var7;
        var7.path = var0;
    }
    
    if ( level.ref_12281 == "cargo_truck_mg" )
    {
        var7 setscriptablepartstate( "upgrade", "vehicle_unusable" );
        var7 setscriptablepartstate( "copyofupgrade", "vehicle_unusable" );
    }
    
    var7.uav_getenemyplayersinrange = 1;
    
    if ( isdefined( var4 ) )
    {
        thread ref_14236( var7 );
    }
    
    return var7;
}

// Params 2
// Size: 0x5
function ref_1423f( var0, var1 )
{
    
}

// Params 1
// Size: 0xc, Type: bool
function ref_14259( var0 )
{
    return !isdefined( self.path );
}

// Params 1
// Size: 0x220
function ref_14260( var0 )
{
    if ( !isdefined( var0.trigger ) )
    {
        var0.trigger = spawn( "trigger_radius", self.origin, 0, level.disable_super_in_turret.ref_1426e, level.disable_super_in_turret.ref_1426d );
    }
    
    if ( !istrue( var0.trigger.x1loadout ) )
    {
        var0.trigger enablelinkto();
        var0.trigger.x1loadout = 1;
    }
    
    var0.trigger linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var0.trigger.brkillstreakbeginusefunc = 1;
    
    if ( !isdefined( var0.obj_payload_stage ) )
    {
        var0.obj_payload_stage = scripts\mp\gameobjects::createuseobject( self.team, var0.trigger, [], level.disable_super_in_turret.ref_14249 );
    }
    
    var0.obj_payload_stage.usecondition = &getlocationnameforpoint;
    var0.obj_payload_stage.getrandompointincirclewithindistance = 1;
    var0.obj_payload_stage.nousebar = 1;
    var0.obj_payload_stage scripts\mp\gameobjects::allowuse( "any" );
    var0.obj_payload_stage scripts\mp\gameobjects::setvisibleteam( "any" );
    var0.obj_payload_stage scripts\mp\gameobjects::pinobjiconontriggertouch();
    var0.obj_payload_stage.iconname = self.path.iconname;
    var0.obj_payload_stage scripts\mp\gameobjects::setownerteam( self.team );
    var0.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_escort_neutral", "waypoint_halt_neutral" );
    function_042c( var0.obj_payload_stage.objidnum, 1 );
    playencryptedcinematicforall( var0.obj_payload_stage.objidnum, 1 );
    scripts\mp\objidpoolmanager::update_objective_onentity( var0.obj_payload_stage.objidnum, self );
    scripts\mp\objidpoolmanager::update_objective_setzoffset( var0.obj_payload_stage.objidnum, var0.obj_payload_stage.offset3d[ 2 ] );
    scripts\mp\objidpoolmanager::objective_set_play_intro( var0.obj_payload_stage.objidnum, 0 );
    
    if ( level.ref_12281 == "cargo_truck_mg" )
    {
        self setscriptablepartstate( "upgrade", "vehicle_unusable" );
        self setscriptablepartstate( "copyofupgrade", "vehicle_unusable" );
    }
    
    self.obj_payload_stage = var0.obj_payload_stage;
}

// Params 1
// Size: 0x1c
function relic_squadlink_outline_monitor( var0 )
{
    if ( var0 == "axis" )
    {
        return "allies";
    }
    
    return "axis";
}

// Params 0
// Size: 0x345
function ref_14251()
{
    level endon( "game_ended" );
    level endon( "payloadComplete" );
    self notify( "vehicleMoveUpdate" );
    self endon( "vehicleMoveUpdate" );
    self endon( "pathComplete" );
    self endon( "death" );
    waittillframeend();
    var0 = getdvarint( "scr_br_payload_vehicle_pay_time_tick", 6000 );
    var1 = getdvarint( "scr_br_payload_vehicle_pay_scale", 4 );
    var2 = getdvarint( "scr_br_payload_vehicle_defender_pay_scale", 7 );
    var3 = gettime() + var0;
    var4 = self.path;
    var5 = var4.idle_sfx;
    ref_14247( var5 );
    var6 = gettime() + 1000;
    
    for ( ;; )
    {
        var7 = ref_14245( self.team );
        var8 = ref_14245( relic_squadlink_outline_monitor( self.team ) );
        ref_14274( var7, var8 );
        ref_14272();
        
        if ( var3 < gettime() )
        {
            var3 = gettime() + var0;
            ref_12284( var7, var8, var1, var2 );
        }
        
        if ( gettime() >= var6 )
        {
            ref_1422c();
            var6 = gettime() + 1000;
        }
        
        var9 = undefined;
        
        if ( istrue( level.disable_super_in_turret.ref_1227b ) )
        {
            var10 = level.disable_super_in_turret.ref_14241;
        }
        else
        {
            var10 = level.disable_super_in_turret.ref_14242;
        }
        
        var11 = var10;
        var12 = level.disable_super_in_turret.ref_1422d;
        
        if ( isdefined( var5 ) )
        {
            var13 = distance2dsquared( self.origin, var5.origin );
            
            if ( var13 < level.disable_super_in_turret.idflags_no_dismemberment )
            {
                var11 = level.disable_super_in_turret.ref_14243;
                var12 = level.disable_super_in_turret.ref_1422e;
            }
        }
        
        if ( !var7 && var8 && !self.carriable_explode )
        {
            self vehicle_setspeed( var12 );
            self.veh_transmission = "reverse";
            
            if ( isdefined( var5 ) )
            {
                if ( !istrue( var5.carriable_fuse_light_watch ) )
                {
                    var5 vehicle_setspeed( level.disable_super_in_turret.ref_1422d );
                    var5.veh_transmission = "reverse";
                }
                else
                {
                    var5 vehicle_setspeed( 0 );
                }
            }
            
            var9 = "reverse";
            
            if ( isdefined( self.tutonplayerkilled ) && isdefined( self.cone ) )
            {
                var14 = anglestoforward( self.angles ) * -1;
                var15 = vectornormalize( self.origin - self.cone );
                var16 = vectordot( var14, var15 );
                
                if ( var16 > 0 )
                {
                    var17 = distance( self.cone, self.origin );
                    
                    if ( var17 > getdvarfloat( "scr_payload_unblock_distance", 2 ) )
                    {
                        self.tutonplayerkilled = undefined;
                        self.carriable_physics_launch = undefined;
                        self.cone = undefined;
                    }
                }
            }
        }
        else if ( isdefined( self.tutonplayerkilled ) )
        {
            var9 = "blocked";
            self vehicle_setspeed( 0 );
            
            if ( isdefined( var5 ) )
            {
                var5 vehicle_setspeed( 0 );
            }
        }
        else if ( var7 && !var8 )
        {
            self vehicle_setspeed( var10 );
            self.veh_transmission = "forward";
            self.carriable_explode = 0;
            ref_14273();
            
            if ( isdefined( self.carriable_physics_launch ) )
            {
                ref_11f9b( self.carriable_physics_launch );
                self.carriable_physics_launch = undefined;
            }
            
            if ( isdefined( var5 ) )
            {
                var5 vehicle_setspeed( var11 );
                var5.veh_transmission = "forward";
                var5.carriable_fuse_light_watch = 0;
            }
            
            var9 = "forward";
        }
        else
        {
            if ( var7 && var8 )
            {
                var9 = "contested";
            }
            
            self vehicle_setspeed( 0 );
            
            if ( isdefined( var5 ) )
            {
                var5 vehicle_setspeed( 0 );
            }
        }
        
        if ( !var7 )
        {
            ref_1425b();
        }
        
        var18 = ref_14252( var9 );
        var9 = var18[ 0 ];
        var19 = var18[ 1 ];
        var18 = undefined;
        var20 = var7 > 0;
        ref_11f92( self.path, var20, var9, var19 );
        waitframe();
    }
}

// Params 1
// Size: 0x2f
function ref_14247( var0 )
{
    self vehicle_setspeed( level.disable_super_in_turret.ref_14242 );
    
    if ( isdefined( var0 ) )
    {
        var0 vehicle_setspeed( level.disable_super_in_turret.ref_14242 );
    }
    
    wait 0.5;
}

// Params 1
// Size: 0x83
function ref_14252( var0 )
{
    var1 = relic_amped_last_kill_time( self.path );
    
    if ( var1 < 0 || !isdefined( var0 ) || var0 != "forward" )
    {
        return [ var0, undefined ];
    }
    
    var2 = self.path;
    var3 = var2.getquestreward_checkforvalueoverride[ var1 ].ref_11ea5;
    var4 = var2.nodes[ var3 ].origin;
    var5 = distance2dsquared( self.origin, var4 );
    
    if ( var5 < level.disable_super_in_turret.ref_142fe )
    {
        return [ "near", var1 + 1 ];
    }
    
    return [ var0, undefined ];
}

// Params 0
// Size: 0x9a
function ref_1423a()
{
    level endon( "game_ended" );
    self notify( "vehicleDamageVehicles" );
    self endon( "vehicleDamageVehicles" );
    self endon( "death" );
    self vehphys_enablecollisioncallback( 1 );
    
    for ( ;; )
    {
        self waittill( "collision", var0, var1, var2, var3, var4, var5, var6, var7, var8 );
        
        if ( !isdefined( var7 ) )
        {
            continue;
        }
        
        if ( var7 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers() )
        {
            ref_1423e( var7, self );
            continue;
        }
        
        if ( isdefined( var7.equipmentref ) && var7.equipmentref == "equip_tac_cover" )
        {
            var7 scripts\mp\equipment\tactical_cover::tac_cover_destroy( undefined, 1 );
        }
    }
}

// Params 1
// Size: 0x2a
function ref_1423e( var0 )
{
    self.ref_12282 = 1;
    self dodamage( self.health, var0.origin, var0, var0 );
    
    if ( isdefined( self ) )
    {
        self.ref_12282 = undefined;
        return;
    }
}

// Params 2
// Size: 0x33c
function ref_14274( var0, var1 )
{
    if ( !var0 && var1 )
    {
        self.obj_payload_stage scripts\mp\gameobjects::setownerteam( relic_squadlink_outline_monitor( self.team ) );
        self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_halting", "waypoint_escort" );
        ref_12206( self.path, game[ "attackers" ], "red" );
        ref_12206( self.path, game[ "defenders" ], "blue" );
        var2 = scripts\engine\utility::ter_op( !game[ "switchedsides" ], "halt0", "halt1" );
        self setscriptablepartstate( "radiusEffect", var2, 0 );
        function_042c( self.obj_payload_stage.objidnum, 0 );
        self.status = "back";
        ref_13190( self.path.script_index, 2 );
    }
    else if ( isdefined( self.tutonplayerkilled ) )
    {
        self.obj_payload_stage scripts\mp\gameobjects::setownerteam( "neutral" );
        self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_blocked" );
        ref_12206( self.path, game[ "attackers" ], "yellow" );
        ref_12206( self.path, game[ "defenders" ], "yellow" );
        self setscriptablepartstate( "radiusEffect", "contest", 0 );
        function_042c( self.obj_payload_stage.objidnum, 0 );
        self.status = "blocked";
        ref_13190( self.path.script_index, 0 );
    }
    else if ( var0 && !var1 )
    {
        self.obj_payload_stage scripts\mp\gameobjects::setownerteam( self.team );
        self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_escorting", "waypoint_halt" );
        ref_12206( self.path, game[ "attackers" ], "blue" );
        ref_12206( self.path, game[ "defenders" ], "red" );
        var2 = scripts\engine\utility::ter_op( !game[ "switchedsides" ], "escort0", "escort1" );
        self setscriptablepartstate( "radiusEffect", var2, 0 );
        function_042c( self.obj_payload_stage.objidnum, 0 );
        self.status = "forward";
        ref_13190( self.path.script_index, 1 );
    }
    else if ( var0 && var1 )
    {
        self.obj_payload_stage scripts\mp\gameobjects::setownerteam( "neutral" );
        self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_contested" );
        ref_12206( self.path, game[ "attackers" ], "yellow" );
        ref_12206( self.path, game[ "defenders" ], "yellow" );
        self setscriptablepartstate( "radiusEffect", "contest", 0 );
        function_042c( self.obj_payload_stage.objidnum, 0 );
        self.status = "contested";
        ref_13190( self.path.script_index, 3 );
    }
    else
    {
        self.obj_payload_stage scripts\mp\gameobjects::setownerteam( self.team );
        self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_escort_neutral", "waypoint_halt_neutral" );
        ref_12206( self.path, game[ "attackers" ], "white" );
        ref_12206( self.path, game[ "defenders" ], "white" );
        self setscriptablepartstate( "radiusEffect", "idle", 0 );
        function_042c( self.obj_payload_stage.objidnum, 1 );
        self.status = "idle";
        ref_13190( self.path.script_index, 4 );
    }
    
    ref_14272();
}

// Params 0
// Size: 0x14b
function ref_14272()
{
    var0 = self.path;
    var1 = ref_14244();
    var2 = var1 / var0.ref_13bf1;
    
    if ( var0.getquestplunderrewardinstance >= 0 )
    {
        var3 = 0;
        
        if ( var0.getquestplunderrewardinstance > 0 )
        {
            var3 = var0.getquestreward_checkforvalueoverride[ var0.getquestplunderrewardinstance - 1 ].loot_choppers;
        }
        
        var4 = var0.getquestreward_checkforvalueoverride[ var0.getquestplunderrewardinstance ].loot_choppers - var3;
        var1 -= var3;
        var5 = var1 / var4;
    }
    else
    {
        var5 = 0;
    }
    
    ref_1318f( var1.script_index, var5 );
    
    if ( isdefined( level.teamdata[ game[ "attackers" ] ][ "checkpoint" ].choppersupport_modifydamage_trial[ var1.script_index ] ) )
    {
        level.teamdata[ game[ "attackers" ] ][ "checkpoint" ].choppersupport_modifydamage_trial[ var1.script_index ].choppergunner_refillmissiles scripts\mp\hud_util::updatebar( var5, 0 );
    }
    
    if ( isdefined( level.teamdata[ game[ "defenders" ] ][ "checkpoint" ].choppersupport_modifydamage_trial[ var1.script_index ] ) )
    {
        level.teamdata[ game[ "defenders" ] ][ "checkpoint" ].choppersupport_modifydamage_trial[ var1.script_index ].choppergunner_refillmissiles scripts\mp\hud_util::updatebar( var5, 0 );
    }
    
    var5 = clamp( var5, 0, 1 );
    objective_setprogress( self.obj_payload_stage.objidnum, var5 );
}

// Params 0
// Size: 0x9c
function ref_14244()
{
    var0 = self;
    var1 = var0.path;
    
    if ( istrue( var1.hidesmokinggunhudfromplayer ) )
    {
        return var1.ref_13bf1;
    }
    
    var2 = var1.ref_136fc[ var1.ref_136fb ].points[ var1.initial_enemy_spawner ];
    var3 = var1.ref_136fc[ var1.ref_136fb ].points[ var1.initial_enemy_spawner + 1 ];
    var4 = pointonsegmentnearesttopoint( var2, var3, var0.origin );
    var5 = distance( var4, var2 );
    var6 = var1.ref_136fc[ var1.ref_136fb ].armsrace_c4_planter_internal[ var1.initial_enemy_spawner ];
    var6 += var5;
    return var6;
}

// Params 0
// Size: 0x4f
function ref_14273()
{
    var0 = self;
    
    if ( isdefined( var0.ref_12945 ) || !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    var0.ref_12945 = spawnstruct();
    var0.ref_12945.starttime = gettime();
    var0.ref_12945.ref_13842 = ref_14244( var0 );
}

// Params 0
// Size: 0x82
function ref_1425b()
{
    var0 = self;
    
    if ( !isdefined( var0.ref_12945 ) || !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    var1 = ref_14244( var0 );
    var2 = var1 - var0.ref_12945.ref_13842;
    var3 = var0.path;
    
    if ( var3.ref_119d6 < var2 )
    {
        var3.ref_119d6 = var2;
    }
    
    var4 = gettime() - var0.ref_12945.starttime;
    var3.ref_13bf5 += var4;
    var0.ref_12945 = undefined;
}

// Params 0
// Size: 0xe6
function ref_1422c()
{
    foreach ( var1 in self.obj_payload_stage.touchlist[ game[ "attackers" ] ] )
    {
        var2 = var1.player;
        var2 scripts\mp\utility\stats::incpersstat( "objTime", 1 );
        var2 scripts\mp\persistence::statsetchild( "round", "objTime", var2.pers[ "objTime" ] );
        var2 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "objTime", var2.pers[ "objTime" ] );
    }
    
    foreach ( var1 in self.obj_payload_stage.touchlist[ game[ "defenders" ] ] )
    {
        var2 = var1.player;
        var2 scripts\mp\utility\stats::incpersstat( "objTime", 1 );
        var2 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "objTime", var2.pers[ "objTime" ] );
    }
}

// Params 2
// Size: 0x38
function freight_lift_build( var0, var1 )
{
    var2 = 1.57828e-05;
    var3 = 3600;
    var4 = 10;
    var5 = distance( var0, var1 );
    var6 = var5 * var2;
    var7 = max( var6 / level.disable_super_in_turret.ref_14242 * var3, var4 );
    return var7;
}

// Params 2
// Size: 0x5fa
function freeze_timer_at_max_time_bomb_vest( var0, var1 )
{
    var0.ref_136fc = [];
    var0.getquestreward_checkforvalueoverride = [];
    var0.ref_11f9e = [];
    var0.initial_enemy_spawner = 0;
    var0.ref_136fb = 0;
    
    if ( level.disable_super_in_turret.checkpoint_objective )
    {
        var0.wait_for_at_least_one_player_spawns_in = [];
    }
    
    if ( level.disable_super_in_turret.convoy )
    {
        var0.idflags_penetration_player_only = spawnstruct();
        var0.idflags_penetration_player_only.points = [];
        var0.idflags_penetration_player_only.times = [];
    }
    
    var2 = var0.nodes;
    
    if ( !isdefined( var2 ) || istrue( var1 ) )
    {
        if ( isdefined( var0.target ) )
        {
            var3 = var0;
            var2 = [ var0 ];
            
            for ( ;; )
            {
                var3 = scripts\engine\utility::getstruct( var3.target, "targetname" );
                var2 = var3;
                
                if ( !isdefined( var3.target ) )
                {
                    break;
                }
            }
            
            var0.nodes = var2;
        }
    }
    
    var9 = int( var2.size / 31 );
    var10 = var2.size - var9 * 31;
    
    if ( var10 != 0 )
    {
        var9++;
    }
    
    var11 = var10 > 0 && var10 < 4;
    var12 = var9 - 2;
    var13 = var9 - 1;
    var14 = undefined;
    
    if ( level.disable_super_in_turret.checkpoint_objective )
    {
        var0.wait_for_at_least_one_player_spawns_in[ 0 ] = 0;
    }
    
    var15 = 0;
    var16 = 0;
    var17 = 0;
    var18 = 0;
    var19 = 0;
    var20 = 0;
    
    for ( var21 = 0; var21 < var9 ; var21++ )
    {
        var0.ref_136fc[ var21 ] = spawnstruct();
        var0.ref_136fc[ var21 ].points = [];
        var0.ref_136fc[ var21 ].times = [];
        var0.ref_136fc[ var21 ].tv_station_interior_enemy_should_break_stealth_immediately = [];
        var0.ref_136fc[ var21 ].update_player_enemy_on_death = [];
        var0.ref_136fc[ var21 ].armsrace_c4_planter_internal = [];
        var22 = 31;
        
        if ( var21 == var12 && var11 )
        {
            var22 = 27 + var10;
        }
        else if ( var21 == var13 && var10 > 0 )
        {
            if ( var10 >= 4 )
            {
                var22 = var10;
            }
            else
            {
                var22 = 4;
            }
        }
        
        var23 = 0;
        
        if ( var21 > 0 )
        {
            var0.ref_136fc[ var21 ].points[ var23 ] = var2[ var16 ].origin;
            var0.ref_136fc[ var21 ].times[ var23 ] = freight_lift_build( var2[ var16 ].origin, var2[ var16 ].origin );
            var0.ref_136fc[ var21 ].armsrace_c4_planter_internal[ var23 ] = var19;
            var23++;
            var22++;
            var2[ var16 ].ref_136fb = var21;
        }
        else
        {
            var2[ var21 ].ref_136fb = var21;
        }
        
        for ( var24 = var23; var24 < var22 ; var24++ )
        {
            var25 = var24;
            
            if ( level.disable_super_in_turret.convoy && var21 == 0 )
            {
                var0.idflags_penetration_player_only.points[ var25 ] = var2[ var15 ].origin;
                var0.idflags_penetration_player_only.times[ var25 ] = freight_lift_build( var2[ var16 ].origin, var2[ var15 ].origin );
                var25 -= 1;
                
                if ( var25 == 0 )
                {
                    var16 = 1;
                }
            }
            
            if ( !level.disable_super_in_turret.convoy || var21 > 0 || var25 >= 0 )
            {
                var0.ref_136fc[ var21 ].points[ var25 ] = var2[ var15 ].origin;
                var0.ref_136fc[ var21 ].times[ var25 ] = freight_lift_build( var2[ var16 ].origin, var2[ var15 ].origin );
                var26 = distance( var2[ var16 ].origin, var2[ var15 ].origin );
                var19 += var26;
                var0.ref_136fc[ var21 ].armsrace_c4_planter_internal[ var25 ] = var19;
                
                if ( isdefined( var2[ var15 ].checkpoint ) )
                {
                    var0.ref_136fc[ var21 ].tv_station_interior_enemy_should_break_stealth_immediately[ var25 ] = var17;
                    var0.getquestreward_checkforvalueoverride[ var17 ] = spawnstruct();
                    var0.getquestreward_checkforvalueoverride[ var17 ].loot_choppers = var19;
                    var0.getquestreward_checkforvalueoverride[ var17 ].ref_11ea5 = var15;
                    var2[ var15 ].checkpoint = var0.getquestreward_checkforvalueoverride[ var17 ];
                    
                    if ( level.disable_super_in_turret.checkpoint_objective )
                    {
                        var27 = var15 - var20;
                        var28 = int( var27 * 0.33 ) + var20;
                        var0.wait_for_at_least_one_player_spawns_in[ var0.wait_for_at_least_one_player_spawns_in.size ] = var28;
                        var29 = int( var27 * 0.66 ) + var20;
                        var0.wait_for_at_least_one_player_spawns_in[ var0.wait_for_at_least_one_player_spawns_in.size ] = var29;
                        var0.wait_for_at_least_one_player_spawns_in[ var0.wait_for_at_least_one_player_spawns_in.size ] = var15;
                        var20 = var15;
                    }
                    
                    var17++;
                }
                
                if ( isdefined( var2[ var15 ].obstacle ) )
                {
                    var0.ref_136fc[ var21 ].update_player_enemy_on_death[ var25 ] = var18;
                    
                    if ( !isent( var2[ var15 ].obstacle ) )
                    {
                        var2[ var15 ].obstacle = init_structs( var2[ var15 ].obstacle.origin, var2[ var15 ].obstacle.angles );
                    }
                    
                    var0.ref_11f9e[ var18 ] = var2[ var15 ].obstacle;
                    var0.ref_11f9e[ var18 ].path = var0;
                    var0.ref_11f9e[ var18 ].dist = var19;
                    var0.ref_11f9e[ var18 ].index = var18;
                    var0.ref_11f9e[ var18 ].getquestplunderrewardinstance = var17;
                    var18++;
                }
                
                var16 = var15;
            }
            
            var15++;
        }
    }
    
    var30 = var15 - 1;
    
    if ( level.disable_super_in_turret.checkpoint_objective )
    {
        var27 = var15 - var20;
        var28 = int( var27 * 0.33 ) + var20;
        var0.wait_for_at_least_one_player_spawns_in[ var0.wait_for_at_least_one_player_spawns_in.size ] = var28;
        var29 = int( var27 * 0.66 ) + var20;
        var0.wait_for_at_least_one_player_spawns_in[ var0.wait_for_at_least_one_player_spawns_in.size ] = var29;
        var0.wait_for_at_least_one_player_spawns_in[ var0.wait_for_at_least_one_player_spawns_in.size ] = var30;
    }
    
    var0.getquestreward_checkforvalueoverride[ var17 ] = spawnstruct();
    var0.getquestreward_checkforvalueoverride[ var17 ].loot_choppers = var19;
    var0.getquestreward_checkforvalueoverride[ var17 ].ref_11ea5 = var30;
    var0.ref_13bf1 = var19;
}

// Params 2
// Size: 0x208
function ref_1422f( var0, var1 )
{
    self notify( "vehicleBeginPath" );
    self endon( "vehicleBeginPath" );
    self endon( "death" );
    var2 = 1;
    self.carriable_explode = 1;
    self.tutonplayerkilled = undefined;
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var0.initial_enemy_spawner = 0;
    var0.ref_136fb = var1;
    
    foreach ( var4 in var0.ref_11f9e )
    {
        ref_11f9c( var4, 0 );
    }
    
    thread ref_14251();
    thread ref_1423a();
    thread ref_14234();
    var6 = 1;
    
    while ( var0.ref_136fb < var0.ref_136fc.size )
    {
        self startpathnodes( var0.ref_136fc[ var0.ref_136fb ].points, var0.ref_136fc[ var0.ref_136fb ].times, 0, 0.5, 0.5, 0, 0, var2, 1, !var6, 1, 1 );
        var2 = 0;
        var6 = ref_14275( var0, var6 );
        
        if ( unset_relic_gas_martyr() )
        {
            break;
        }
    }
    
    self vehicle_setspeed( 0 );
    
    if ( isdefined( var0.idle_sfx ) )
    {
        var0.idle_sfx vehicle_setspeed( 0 );
    }
    
    self notify( "pathComplete" );
    var0.hidesmokinggunhudfromplayer = 1;
    var0 notify( "pathComplete" );
    
    if ( level.disable_super_in_turret.ref_13601 )
    {
        var0.ref_13620.hidesmokinggunhudfromplayer = 1;
    }
    
    ref_1425b();
    loadoutexecutionquip( var0 );
    
    if ( !unset_relic_gas_martyr() && ref_132fd( var0 ) )
    {
        ref_12aa3( var0 );
        var0.getquestplunderrewardinstance++;
        start_pipe_room_menu();
        
        if ( isdefined( level.disable_super_in_turret.getquestrewardscalerstablescaleinfo ) )
        {
            var7 = relic_amped_monitor();
            
            foreach ( var9 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo )
            {
                var9 setvalue( var7 );
            }
        }
        
        var0 notify( "checkPointUpdate" );
        scripts\mp\gametypes\br_vehicles::emptyallvehicles();
        getquestrewardgroupstablerewards();
        return;
    }
    
    if ( !unset_relic_gas_martyr() && level.disable_super_in_turret.brking_oncrateuse )
    {
        player_death( var0 );
        return;
    }
}

// Params 1
// Size: 0x11a
function player_death( var0 )
{
    scripts\mp\gametypes\br::ref_13ac7( "br_payload_all_to_end", undefined, game[ "attackers" ] );
    scripts\mp\gametypes\br::ref_13ac7( "br_payload_all_to_end_enemy", undefined, game[ "defenders" ] );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var0.vehicle.obj_payload_stage.objidnum );
    ref_12206( var0, game[ "attackers" ], "white" );
    ref_12206( var0, game[ "defenders" ], "white" );
    var1 = relic_amped_last_kill_time( var0 );
    thread ref_11f92( var0, 1, "checkpoint", var1 + 1 );
    ref_12aa3( var0 );
    var0.getquestplunderrewardinstance++;
    start_pipe_room_menu();
    ref_1322f( var0 );
    ref_1326a( var0, var0.getquestplunderrewardinstance );
    var0 notify( "checkPointUpdate" );
    
    if ( isdefined( level.disable_super_in_turret.getquestrewardscalerstablescaleinfo ) )
    {
        var2 = relic_amped_monitor();
        
        foreach ( var4 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo )
        {
            var4 setvalue( var2 );
        }
    }
    
    thread ref_12cb8( var0 );
    
    if ( level.disable_super_in_turret.ref_121fc )
    {
        thread ref_121fc( var0 );
        return;
    }
}

// Params 2
// Size: 0xed
function ref_14236( var0, var1 )
{
    self notify( "vehicleBeginPath" );
    self endon( "vehicleBeginPath" );
    var0 endon( "pathComplete" );
    self endon( "death" );
    var2 = 1;
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    self.initial_enemy_spawner = 0;
    self.ref_136fb = var1;
    thread ref_1423a();
    var3 = 1;
    
    while ( self.ref_136fb < var0.ref_136fc.size )
    {
        if ( self.ref_136fb == 0 )
        {
            var4 = var0.idflags_penetration_player_only.points;
            var5 = var0.idflags_penetration_player_only.times;
        }
        else
        {
            var4 = var0.ref_136fc[ self.ref_136fb ].points;
            var5 = var0.ref_136fc[ self.ref_136fb ].times;
        }
        
        self startpathnodes( var4, var5, 0, 0.5, 0.5, 0, 0, var2, 1, !var3, 1, 1 );
        var2 = 0;
        var3 = ref_14237( var0, var4 );
        
        if ( unset_relic_gas_martyr() )
        {
            break;
        }
    }
    
    self vehicle_setspeed( 0 );
}

// Params 2
// Size: 0x8a
function ref_14237( var0, var1 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "death" );
    var2 = var1.size - 1;
    
    for ( ;; )
    {
        self waittill( "trigger", var3 );
        var4 = self.ref_136fb == 0 && var3 == 0;
        self.initial_enemy_spawner = var3;
        
        if ( var4 )
        {
            self.carriable_fuse_light_watch = 1;
            continue;
        }
        
        if ( var3 <= 0 )
        {
            self.ref_136fb--;
            self.initial_enemy_spawner = var1.size - 2;
            return 0;
        }
        
        if ( var3 >= var2 )
        {
            self.ref_136fb++;
            self.initial_enemy_spawner = 0;
            return 1;
        }
    }
}

// Params 1
// Size: 0x4d, Type: bool
function ref_132fd( var0 )
{
    if ( level.disable_super_in_turret.brking_oncrateuse )
    {
        foreach ( var0 in level.disable_super_in_turret.paths )
        {
            if ( !istrue( var0.hidesmokinggunhudfromplayer ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Params 2
// Size: 0x1dc
function ref_14275( var0, var1 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "death" );
    var2 = var0.ref_136fc[ var0.ref_136fb ];
    var3 = var2.points.size - 1;
    
    if ( var1 )
    {
        var4 = 0;
    }
    else
    {
        var4 = var4;
    }
    
    var5 = var2;
    
    for ( ;; )
    {
        self waittill( "trigger", var6 );
        var7 = var1.ref_136fb == 0 && var6 == 0;
        
        if ( !var7 && var6 == var1.initial_enemy_spawner )
        {
            var5 = !var5;
            var1.initial_enemy_spawner = var6 - 1;
        }
        else
        {
            var5 = var7 || var6 > var1.initial_enemy_spawner;
            var1.initial_enemy_spawner = var6;
        }
        
        if ( isdefined( var3.update_player_enemy_on_death[ var6 ] ) )
        {
            var8 = var3.update_player_enemy_on_death[ var6 ];
            var9 = var1.ref_11f9e[ var8 ];
            
            if ( istrue( var9.hostdefensefactormod ) && var5 )
            {
                self.tutonplayerkilled = var9;
                self.cone = var3.points[ var6 ];
            }
            else if ( !istrue( var9.hostdefensefactormod ) && var5 )
            {
                ref_11f9b( var9 );
            }
            else if ( !istrue( var9.hostdefensefactormod ) && !var5 )
            {
                ref_11f9c( var9, 1 );
            }
        }
        
        if ( var7 || isdefined( var3.tv_station_interior_enemy_should_break_stealth_immediately[ var6 ] ) && var6 < var4 )
        {
            self.carriable_explode = 1;
            
            if ( var6 > var4 && isdefined( var3.tv_station_interior_enemy_should_break_stealth_immediately[ var6 ] ) )
            {
                level thread scripts\mp\gametypes\br_quest_util::ref_140b1( self.origin, "dom" );
                ref_11e6f( var3.tv_station_interior_enemy_should_break_stealth_immediately[ var6 ], var1 );
            }
        }
        else if ( var6 <= 0 )
        {
            var1.ref_136fb--;
            var1.initial_enemy_spawner = var1.ref_136fc[ var1.ref_136fb ].points.size - 2;
            return 0;
        }
        else if ( var6 >= var4 )
        {
            var1.ref_136fb++;
            var1.initial_enemy_spawner = 0;
            return 1;
        }
        
        var4 = var6;
    }
}

// Params 1
// Size: 0x1d
function ref_14245( var0 )
{
    if ( !isdefined( self.obj_payload_stage ) )
    {
        return 0;
    }
    
    return self.obj_payload_stage.numtouching[ var0 ];
}

// Params 1
// Size: 0x55, Type: bool
function ref_125f2( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        if ( isdefined( var2.trigger ) && var0 istouching( var2.trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x146
function ref_13c54()
{
    level endon( "game_ended" );
    level notify( "trackPlayersPerPath" );
    level endon( "trackPlayersPerPath" );
    
    foreach ( var1 in level.disable_super_in_turret.paths )
    {
        var1.numplayers = [];
    }
    
    var3 = game[ "attackers" ];
    
    for ( ;; )
    {
        foreach ( var1 in level.disable_super_in_turret.paths )
        {
            var1.numplayers[ var3 ] = 0;
        }
        
        foreach ( var7 in level.players )
        {
            if ( !isdefined( var7 ) || !isalive( var7 ) || var7.team != var3 )
            {
                continue;
            }
            
            var8 = ref_12575( var7 );
            var9 = ref_12576( var7 );
            
            if ( isdefined( var8 ) && var9 > gettime() )
            {
                var8.numplayers[ var3 ]++;
                continue;
            }
            
            var10 = ref_1255a( var7 );
            
            if ( isdefined( var10 ) )
            {
                var10.numplayers[ var3 ]++;
                ref_12689( var7, var10 );
                ref_12679( var7 );
            }
        }
        
        var3 = relic_squadlink_outline_monitor( var3 );
        waitframe();
    }
}

// Params 0
// Size: 0x157
function ref_1255a()
{
    var0 = undefined;
    var1 = undefined;
    
    if ( !isdefined( self.heli_landing_volumes ) || self.heli_landing_volumes.size == 0 )
    {
        return;
    }
    
    foreach ( var3 in level.disable_super_in_turret.paths )
    {
        var4 = self.heli_landing_volumes[ var3.label ];
        var5 = var3.nodes[ var4 ];
        var6 = distance2dsquared( var5.origin, self.origin );
        var7 = var4;
        var8 = var6;
        var9 = var6;
        
        for ( var10 = var4 + 1; var10 < var3.nodes.size ; var10++ )
        {
            var11 = var3.nodes[ var10 ];
            var12 = distance2dsquared( var11.origin, self.origin );
            
            if ( var12 < var8 )
            {
                var7 = var10;
                var8 = var12;
            }
            
            if ( var12 > var9 )
            {
                break;
            }
            
            var9 = var12;
        }
        
        for ( var10 = var4 - 1; var10 >= 0 ; var10-- )
        {
            var11 = var3.nodes[ var10 ];
            var12 = distance2dsquared( var11.origin, self.origin );
            
            if ( var12 < var8 )
            {
                var7 = var10;
                var8 = var12;
            }
            
            if ( var12 > var9 )
            {
                break;
            }
            
            var9 = var12;
        }
        
        self.heli_landing_volumes[ var3.label ] = var7;
        
        if ( !isdefined( var0 ) || var8 < var1 )
        {
            var0 = var3;
            var1 = var8;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x1e0
function ref_12679()
{
    var0 = 3500;
    
    if ( getdvarint( "scr_br_payload_oob_far", 0 ) == 0 )
    {
        return;
    }
    
    if ( !scripts\mp\flags::gameflag( "infil_complete" ) )
    {
        return;
    }
    
    var1 = ref_12575();
    var2 = self.heli_landing_volumes[ var1.label ];
    var3 = var1.nodes[ var2 ];
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;
    
    if ( var2 + 1 >= var1.nodes.size )
    {
        var6 = var2 - 1;
        var4 = pointonsegmentnearesttopoint( var1.nodes[ var2 ].origin, var1.nodes[ var6 ].origin, self.origin );
    }
    else if ( var2 - 1 < 0 )
    {
        var6 = var2 + 1;
        var4 = pointonsegmentnearesttopoint( var1.nodes[ var2 ].origin, var1.nodes[ var6 ].origin, self.origin );
    }
    else
    {
        var7 = pointonsegmentnearesttopoint( var1.nodes[ var2 ].origin, var1.nodes[ var2 + 1 ].origin, self.origin );
        var8 = pointonsegmentnearesttopoint( var1.nodes[ var2 ].origin, var1.nodes[ var2 - 1 ].origin, self.origin );
        var9 = distance2dsquared( self.origin, var7 );
        var10 = distance2dsquared( self.origin, var8 );
        
        if ( var10 < var9 )
        {
            var4 = var8;
            var5 = var10;
            var6 = var2 - 1;
        }
        else
        {
            var4 = var7;
            var5 = var9;
            var6 = var2 + 1;
        }
    }
    
    if ( !isdefined( var5 ) )
    {
        var5 = distance2dsquared( self.origin, var4 );
    }
    
    var11 = getdvarint( "scr_br_payload_max_dist_away", var0 );
    var12 = var11 * var11;
    var13 = 0;
    
    if ( var5 > var12 )
    {
        var13 = 1;
    }
    
    if ( var13 && !isdefined( self.ref_12268 ) )
    {
        var14 = relic_squadlink_outline_monitor( self.team );
        self.ref_12268 = scripts\mp\utility\outline::outlineenableforteam( self, var14, "outline_nodepth_red", "level_script" );
        return;
    }
    
    if ( !var13 && isdefined( self.ref_12268 ) )
    {
        scripts\mp\utility\outline::outlinedisable( self.ref_12268, self );
        self.ref_12268 = undefined;
        return;
    }
}

// Params 0
// Size: 0x1e
function ref_12559()
{
    self endon( "endOOBFar" );
    self endon( "disconnect" );
    self waittill( "death" );
    self.ref_12268 = undefined;
}

// Params 0
// Size: 0xba
function thankyou_photo()
{
    if ( !istrue( level.disable_super_in_turret.set_force_aitype_sniper ) )
    {
        return;
    }
    
    switch ( level.mapname )
    {
        case "mp_br_mechanics":
            scripts\mp\gametypes\br_payload_spawns_mp_br_mechanics::initspawns();
            break;
        case "mp_don4":
            scripts\mp\gametypes\br_payload_spawns_mp_don4::initspawns();
            break;
        case "mp_escape4":
            scripts\mp\gametypes\br_payload_spawns_mp_escape4::initspawns();
            break;
    }
    
    if ( level.disable_super_in_turret.ref_13695[ game[ "attackers" ] ].size == 0 || level.disable_super_in_turret.ref_13695[ game[ "defenders" ] ].size == 0 )
    {
        level.disable_super_in_turret.set_force_aitype_sniper = 0;
    }
    
    if ( level.disable_super_in_turret.set_force_aitype_sniper )
    {
        ref_1326f( game[ "attackers" ] );
        ref_1326f( game[ "defenders" ] );
        return;
    }
}

// Params 1
// Size: 0x4f
function play_spotrep_capture_sfx( var0 )
{
    if ( !isdefined( var0.angles ) )
    {
        var0.angles = ( 0, 0, 0 );
    }
    
    var1 = var0.radius + 50;
    var2 = anglestoforward( var0.angles );
    var0.playergetplunderomnvarbitpackinginfo = var0.origin + var2 * var1;
}

// Params 1
// Size: 0x65
function ref_1326f( var0 )
{
    var1 = level.disable_super_in_turret.ref_13695[ var0 ];
    
    if ( isdefined( level.disable_super_in_turret.ref_13876 ) )
    {
        var1 = scripts\engine\utility::array_combine( var1, level.disable_super_in_turret.ref_13876[ var0 ] );
    }
    
    foreach ( var3 in var1 )
    {
        play_smoke_fx( var3 );
        play_spotrep_capture_sfx( var3 );
    }
}

// Params 1
// Size: 0xc0
function play_smoke_fx( var0 )
{
    var0.heli_landing_volumes = [];
    
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        var3 = undefined;
        var4 = undefined;
        var5 = undefined;
        
        for ( var6 = 0; var6 < var2.nodes.size ; var6++ )
        {
            var7 = var2.nodes[ var6 ];
            var8 = distance2dsquared( var7.origin, var0.origin );
            
            if ( !isdefined( var3 ) || var8 < var4 )
            {
                var3 = var6;
                var4 = var8;
            }
            
            if ( !isdefined( var5 ) )
            {
                var5 = var8;
                continue;
            }
            
            if ( var8 > var5 )
            {
                break;
            }
        }
        
        var0.heli_landing_volumes[ var2.label ] = var3;
    }
}

// Params 1
// Size: 0x6c
function ref_1452d( var0 )
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "infil_complete" );
    level.teamdata[ var0 ][ "nextRespawn" ] = 0;
    
    if ( level.teamdata[ var0 ][ "respawnDelay" ] == 0 )
    {
        return;
    }
    
    for ( ;; )
    {
        level.teamdata[ var0 ][ "nextRespawn" ] = gettime() + level.teamdata[ var0 ][ "respawnDelay" ] * 1000;
        wait level.teamdata[ var0 ][ "respawnDelay" ];
    }
}

// Params 2
// Size: 0x43
function runkilltriger( var0, var1 )
{
    if ( level.teamdata[ var0 ][ "respawnDelay" ] == 0 )
    {
        return 0;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = level.teamdata[ var0 ][ "nextRespawn" ];
    }
    
    var2 = max( var1 - gettime(), 0 );
    var3 = int( var2 / 1000 );
    return var3;
}

// Params 1
// Size: 0x29, Type: bool
function dyn_door( var0 )
{
    if ( scripts\mp\flags::gameflag( "prematch_done" ) && istrue( level.disable_super_in_turret.ref_12caa ) )
    {
        ref_126bb();
    }
    
    return true;
}

// Params 2
// Size: 0x33, Type: bool
function playerrespawn( var0, var1 )
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) || !istrue( self.br_infilstarted ) || isdefined( self.cameraent ) )
    {
        return false;
    }
    
    thread ref_126a4( var0 );
    return true;
}

// Params 1
// Size: 0x12f
function ref_126a4( var0 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !istrue( level.debug_safehouse_regroup_start ) )
    {
        self.class = scripts\mp\gametypes\br::ref_1234a();
    }
    
    var1 = level.teamdata[ self.team ][ "nextRespawn" ];
    var2 = scripts\mp\utility\teams::getteamdata( self.team, "teamCount" );
    
    if ( var2 > 1 && !unset_relic_gas_martyr() )
    {
        thread scripts\mp\gametypes\br_spectate::spawnspectator( var0, undefined, 1 );
    }
    
    headlightright();
    
    if ( unset_relic_gas_martyr() )
    {
        level waittill( "forever" );
    }
    
    self.waitingtospawn = 1;
    emp_drone_proximity_explode( 0, var1 );
    self.waitingtospawn = 0;
    thread scripts\mp\playerlogic::spawnplayer( undefined, 0 );
    self freezecontrols( 1 );
    thread ref_1253a();
    
    while ( !isalive( self ) )
    {
        waitframe();
    }
    
    waitframe();
    ref_1255b();
    scripts\mp\utility\outline::outlineenableforteam( self, self.team, "outline_depth_payload", "level_script" );
    var3 = !self calloutmarkerping_getent();
    var4 = gettime();
    
    if ( var3 )
    {
        while ( isalive( self ) && isdefined( self.weaponlist ) && !self hasloadedviewweapons( self.weaponlist ) )
        {
            if ( var4 + 3000 < gettime() )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    self notify( "brWaitAndSpawnClientComplete" );
    self.waitingtospawn = 0;
    self freezecontrols( 0 );
    scripts\mp\gametypes\br::ref_13f21( self );
    scripts\mp\damage::resetplayervariables();
}

// Params 0
// Size: 0x3b
function ref_1255b()
{
    if ( getdvarint( "scr_br_payload_last_stand", 0 ) != 0 )
    {
        scripts\mp\gametypes\br::scriptednode( self );
    }
    
    scripts\mp\gametypes\br_armor::searchcirclesize( 1 );
    ref_12508();
    scripts\mp\gametypes\br_public::ref_1252b();
    thread ref_126ac();
    thread ref_126ad();
    self.warroomtvs = undefined;
}

// Params 1
// Size: 0x55
function ref_1369e( var0 )
{
    self endon( "disconnect" );
    self notify( "reset_timer" );
    waitframe();
    self setclientomnvar( "ui_privateevent_timer_type", 4 );
    var1 = var0;
    var2 = gettime() + var1 * 1000;
    self setclientomnvar( "ui_privateevent_timer", var2 );
    scripts\engine\utility::ref_143ba( var0, "reset_timer", "death" );
    self setclientomnvar( "ui_privateevent_timer_type", 0 );
}

// Params 0
// Size: 0x196
function ref_126ac()
{
    self endon( "disconnect" );
    
    if ( !isdefined( self.warroomtvs ) )
    {
        return;
    }
    
    if ( getdvarint( "scr_br_payload_spawn_speed", 1 ) == 0 )
    {
        return;
    }
    
    if ( isbot( self ) )
    {
        return;
    }
    
    if ( self.team == game[ "defenders" ] )
    {
        return;
    }
    
    var0 = self.warroomtvs;
    
    if ( isplayer( var0 ) || istrue( var0.bot_gametype_attacker_limit_for_team ) )
    {
        return;
    }
    
    var1 = var0;
    
    if ( get_bomb_vest_id_vfx( var1 ) )
    {
        while ( isalive( self ) && !self isonground() )
        {
            waitframe();
        }
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var2 = 0;
    var3 = getdvarint( "scr_br_payload_spawn_speed_time", 0 );
    
    if ( var3 == 0 )
    {
        var4 = getdvarint( "scr_br_payload_spawn_speed_boost", 290 );
        var5 = var1.vehicle;
        var6 = distance( self.origin, var5.origin );
        var3 = var6 / var4 - getdvarfloat( "scr_br_payload_spawn_speed_boost_adj", 5 );
        
        if ( var3 < 0 )
        {
            var3 = 0;
        }
    }
    
    var7 = getdvarfloat( "scr_br_payload_speed_mult", 0.4 );
    thread ref_1369e( var3 );
    var8 = self.fastcrouchspeedmod;
    self.fastcrouchspeedmod = var7;
    scripts\mp\weapons::updatemovespeedscale();
    self lerpfovbypreset( "zombiedefault" );
    
    if ( !scripts\mp\gametypes\br_public::shouldlink() )
    {
        scripts\mp\utility\perk::giveperk( "specialty_sprintmelee" );
        scripts\mp\utility\perk::giveperk( "specialty_sprintads" );
        scripts\mp\utility\perk::giveperk( "specialty_marathon" );
    }
    
    while ( isalive( self ) && var2 < var3 )
    {
        if ( self issupersprinting() )
        {
            self refreshsprinttime();
        }
        
        wait 0.1;
        var2 += 0.1;
    }
    
    if ( !scripts\mp\gametypes\br_public::shouldlink() )
    {
        ref_12e60( "specialty_sprintmelee" );
        ref_12e60( "specialty_sprintads" );
        ref_12e60( "specialty_marathon" );
    }
    
    self.fastcrouchspeedmod = var8;
    scripts\mp\weapons::updatemovespeedscale();
    self lerpfovbypreset( "default_2seconds" );
}

// Params 1
// Size: 0x15
function ref_12e60( var0 )
{
    if ( scripts\mp\utility\perk::_hasperk( var0 ) )
    {
        scripts\mp\utility\perk::removeperk( var0 );
        return;
    }
}

// Params 0
// Size: 0x6e5
function ref_12695()
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    var0 = self.ref_12204;
    
    if ( isbot( self ) )
    {
        if ( !isdefined( var0 ) )
        {
            var0 = respawnfade( "A" );
            ref_12689( var0 );
        }
        
        return var0;
    }
    
    if ( getdvarint( "debug_gsc_spawn_choice_enabled", 0 ) == 1 )
    {
        var1 = scripts\mp\hud_util::createicon( "progress_bar_fill", 400, 35 );
        var1.sort = 0;
        var1.color = relic_doubletap_helper( "lightblue" );
        var1.archived = 0;
        var1.alpha = 0.5;
        var2 = [];
        var3 = respawnfade( "A" );
        var4 = undefined;
        var5 = undefined;
        
        if ( isdefined( var3 ) )
        {
            var4 = scripts\mp\hud_util::createfontstring( "default", 2 );
            var4.archived = 0;
            var4.label = &"BR_PAYLOAD/SPAWN_A";
            var4.path = var3;
            thread spawndogtagtoken( var4, self );
            
            if ( isdefined( var0 ) && !isplayer( var0 ) && var3 == var0 )
            {
                var1.getteamtokenshud = var4;
            }
            
            var2 = var4;
            
            if ( level.disable_super_in_turret.ref_13601 && self.team == game[ "attackers" ] )
            {
                var5 = scripts\mp\hud_util::createfontstring( "default", 2 );
                var5.archived = 0;
                var5.label = &"BR_PAYLOAD/SPAWN_B_AIR";
                var5.path = var3.ref_13620;
                
                if ( isdefined( var0 ) && !isplayer( var0 ) && var3.ref_13620 == var0 )
                {
                    var1.getteamtokenshud = var5;
                }
                
                var2 = var5;
            }
        }
        
        var6 = respawnfade( "B" );
        var7 = undefined;
        var8 = undefined;
        
        if ( isdefined( var6 ) )
        {
            var7 = scripts\mp\hud_util::createfontstring( "default", 2 );
            var7.archived = 0;
            var7.label = &"BR_PAYLOAD/SPAWN_B";
            var7.path = var6;
            thread spawndogtagtoken( var7, self );
            
            if ( isdefined( var0 ) && !isplayer( var0 ) && var6 == var0 )
            {
                var1.getteamtokenshud = var7;
            }
            
            var2 = var7;
            
            if ( level.disable_super_in_turret.ref_13601 && self.team == game[ "attackers" ] )
            {
                var8 = scripts\mp\hud_util::createfontstring( "default", 2 );
                var8.archived = 0;
                var8.label = &"BR_PAYLOAD/SPAWN_B_AIR";
                var8.path = var6.ref_13620;
                
                if ( isdefined( var0 ) && !isplayer( var0 ) && var6.ref_13620 == var0 )
                {
                    var1.getteamtokenshud = var8;
                }
                
                var2 = var8;
            }
        }
        
        var9 = [];
        
        if ( level.disable_super_in_turret.ref_13746 )
        {
            var10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
            
            foreach ( var12 in var10 )
            {
                var13 = scripts\mp\hud_util::createfontstring( "default", 1.5 );
                var13.archived = 0;
                var13 setplayernamestring( var12 );
                var13.player = var12;
                var13.ref_1284f = scripts\mp\hud_util::createfontstring( "default", 1.5 );
                var13.ref_1284f.archived = 0;
                var9 = var13;
            LOC_0000030c:
            }
        }
        
        if ( !isdefined( var1.getteamtokenshud ) )
        {
            var1.getteamtokenshud = var2[ 0 ];
        }
        
        var15 = undefined;
        scripts\mp\utility\player::_freezecontrols( 0, 1, "payload_choice" );
        var16 = 250;
        var17 = 300;
        var18 = undefined;
        var19 = undefined;
        var20 = undefined;
        
        while ( !isdefined( var15 ) )
        {
            var21 = ref_134d7( var2, var9 );
            var22 = self getnormalizedmovement();
            var23 = var22[ 0 ] > 0;
            var24 = var22[ 0 ] < 0;
            
            if ( isdefined( var19 ) )
            {
                if ( gettime() >= var19 || !var23 && !var24 )
                {
                    var19 = undefined;
                }
            }
            else if ( var23 )
            {
                var20 = -1;
            }
            else if ( var24 )
            {
                var20 = 1;
            }
            
            for ( var25 = 0; var25 < var21.size ; var25++ )
            {
                var26 = var21[ var25 ];
                
                if ( var1.getteamtokenshud == var26 )
                {
                    if ( !isdefined( var26.path ) && !isdefined( var26.player ) )
                    {
                        var1.getteamtokenshud = var2[ 0 ];
                        var27 = undefined;
                        var28 = undefined;
                        var18 = undefined;
                        var20 = undefined;
                    }
                    else if ( isdefined( var20 ) )
                    {
                        var29 = var25 + var20;
                        
                        if ( var29 < 0 )
                        {
                            var29 = var21.size - 1;
                        }
                        else if ( var29 >= var21.size )
                        {
                            var29 = 0;
                        }
                        
                        var30 = var21[ var29 ];
                        var1.getteamtokenshud = var30;
                        var1 scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, var30.yoffset );
                        var20 = undefined;
                        var27 = undefined;
                        var28 = undefined;
                        var19 = gettime() + var17;
                    }
                    else
                    {
                        var1 scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, var26.yoffset );
                    }
                    
                    break;
                }
            }
            
            ref_13fe1( var2, var9, var1 );
            ref_139d8( var1.getteamtokenshud.path );
            var20 = undefined;
            
            if ( self usebuttonpressed() )
            {
                if ( isdefined( var18 ) && gettime() >= var18 )
                {
                    var31 = var1.getteamtokenshud;
                    
                    if ( isdefined( var31.path ) && !istrue( var31.path.hidesmokinggunhudfromplayer ) )
                    {
                        var15 = var31.path;
                    }
                    else if ( isdefined( var31.player ) && isalive( var31.player ) && !issquadmateindanger( var31.player ) )
                    {
                        var15 = var31.player;
                    }
                }
                else if ( !isdefined( var18 ) )
                {
                    var18 = gettime() + var16;
                }
            }
            else
            {
                var18 = undefined;
            }
            
            waitframe();
        }
        
        self notify( "spawnChoice" );
        var1 destroy();
        
        foreach ( var33 in var2 )
        {
            var33 destroy();
        }
        
        foreach ( var36, var33 in var9 )
        {
            var33.ref_1284f destroy();
            var33 destroy();
        }
        
        return var15;
    }
    
    if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
    {
        ref_13182( 0 );
        self notify( "spawnChoice" );
        return respawnfade( "A" );
    }
    
    if ( istrue( level.disable_super_in_turret.ref_12caa ) )
    {
        thread startspectatorview();
    }
    
    var15 = undefined;
    
    while ( !isdefined( var15 ) )
    {
        var3 = respawnfade( "A" );
        thread ref_13621( self, var3 );
        var6 = respawnfade( "B" );
        thread ref_13621( self, var6 );
        self waittill( "luinotifyserver", var37, var38 );
        
        if ( var37 == "spawn_choice_path" )
        {
            if ( 0 == var38 )
            {
                var36 = respawnfade( "A" );
            }
            else
            {
                var36 = respawnfade( "B" );
            }
            
            var15 = var36;
            ref_13182( 0 );
        }
        else if ( var37 == "spawn_hover_path" )
        {
            if ( 0 == var38 )
            {
                var36 = respawnfade( "A" );
            }
            else
            {
                var36 = respawnfade( "B" );
            }
            
            thread playergulaggetrespawnpoint( var36 );
        }
        else if ( var37 == "spawn_choice_player" )
        {
            var15 = scripts\mp\playerlogic::getplayerfromclientnum( var38 );
            ref_13182( 0 );
        }
        
        if ( isdefined( var15 ) )
        {
            self notify( "spawnChoice" );
            return var15;
        }
    }
}

// Params 1
// Size: 0x4a
function playergulaggetrespawnpoint( var0 )
{
    self notify( "followTrackCamThink" );
    self endon( "followTrackCamThink" );
    self endon( "spawnChoice" );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = scripts\mp\gametypes\br::get_int_or_0( self.playergulagvictorysetcontrols ) - gettime();
    
    if ( var1 > 0 )
    {
        wait var1;
    }
    
    self.playergulagvictorysetcontrols = gettime() + 250;
    ref_139d8( var0 );
}

// Params 2
// Size: 0xea
function ref_134d7( var0, var1 )
{
    var2 = -60;
    var3 = 30;
    var4 = var2;
    var5 = [];
    
    foreach ( var7 in var0 )
    {
        var7 scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, var4 );
        var5 = var7;
        var4 += var3;
        
        foreach ( var9 in var1 )
        {
            if ( !isdefined( var9.player ) )
            {
                continue;
            }
            
            var10 = ref_12575( var9.player );
            
            if ( var10 == var7.path )
            {
                var9 scripts\mp\hud_util::setpoint( "LEFT", "CENTER", 0, var4 );
                var9.ref_1284f scripts\mp\hud_util::setpoint( "RIGHT", "CENTER", 0, var4 );
                var5 = var9;
                var4 += var3;
            }
        }
    }
    
    return var5;
}

// Params 3
// Size: 0x314
function ref_13fe1( var0, var1, var2 )
{
    var3 = -60;
    var4 = 30;
    var5 = 0;
    
    foreach ( var7 in var1 )
    {
        if ( !isdefined( var7.player ) )
        {
            var7.alpha = 0;
            var7.ref_1284f.alpha = 0;
            continue;
        }
        
        if ( !isalive( var7.player ) )
        {
            var7.color = ( 1, 0, 0 );
            var7.ref_1284f.color = ( 1, 0, 0 );
            var7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_DEAD";
            continue;
        }
        
        if ( issquadmateindanger( var7.player ) )
        {
            var7.color = ( 1, 0, 0 );
            var7.ref_1284f.color = ( 1, 0, 0 );
            var7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_COMBAT";
            continue;
        }
        
        var7.color = ( 0, 1, 1 );
        var7.ref_1284f.color = ( 1, 1, 1 );
        
        if ( var2.getteamtokenshud == var7 )
        {
            var7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_VALID_HOLD";
            var5 = 1;
            continue;
        }
        
        var7.ref_1284f.label = &"BR_PAYLOAD/SPAWN_VALID";
    }
    
    foreach ( var10 in var0 )
    {
        var11 = !istrue( var10.path.hidesmokinggunhudfromplayer );
        
        if ( !var11 )
        {
            var10.color = ( 1, 0, 0 );
        }
        
        if ( istrue( var10.path.bot_gametype_attacker_limit_for_team ) && var10.path.path.label == "A" )
        {
            if ( var2.getteamtokenshud == var10 && var11 )
            {
                var10.label = &"BR_PAYLOAD/SPAWN_A_AIR_HOLD";
            }
            else
            {
                var10.label = &"BR_PAYLOAD/SPAWN_A_AIR";
            }
            
            continue;
        }
        
        if ( istrue( var10.path.bot_gametype_attacker_limit_for_team ) && var10.path.path.label == "B" )
        {
            if ( var2.getteamtokenshud == var10 && var11 )
            {
                var10.label = &"BR_PAYLOAD/SPAWN_B_AIR_HOLD";
            }
            else
            {
                var10.label = &"BR_PAYLOAD/SPAWN_B_AIR";
            }
            
            continue;
        }
        
        if ( var10.path.label == "A" )
        {
            if ( var2.getteamtokenshud == var10 && var11 )
            {
                var10.label = &"BR_PAYLOAD/SPAWN_A_HOLD";
            }
            else
            {
                var10.label = &"BR_PAYLOAD/SPAWN_A";
            }
            
            continue;
        }
        
        if ( var10.path.label == "B" )
        {
            if ( var2.getteamtokenshud == var10 && var11 )
            {
                var10.label = &"BR_PAYLOAD/SPAWN_B_HOLD";
                continue;
            }
            
            var10.label = &"BR_PAYLOAD/SPAWN_B";
        }
    }
}

// Params 1
// Size: 0x176, Type: bool
function issquadmateindanger( var0 )
{
    var1 = 5000;
    var2 = 3000;
    var3 = 450;
    var4 = 200;
    var5 = gettime();
    
    if ( isdefined( var0 ) && isdefined( var0.lastdamagetime ) && var0.lastdamagetime + var1 > var5 || isdefined( var0.lasttimedamaged ) && var0.lasttimedamaged + var1 > var5 )
    {
        return true;
    }
    
    if ( var0 isonladder() )
    {
        return true;
    }
    
    var0 scripts\mp\battlechatter_mp::validaterecentattackers();
    
    if ( isdefined( var0.recentattackers ) && var0.recentattackers.size > 0 )
    {
        return true;
    }
    
    if ( isdefined( var0.watch_for_players_touching_ground ) && var0.watch_for_players_touching_ground + var2 > var5 )
    {
        return true;
    }
    
    if ( isdefined( var0.watch_for_players_touching_ground ) && isdefined( var0.watch_for_players_regrouping_to_plane ) && var0.watch_for_players_touching_ground > var0.watch_for_players_regrouping_to_plane || isdefined( var0.watch_for_players_touching_ground ) && !isdefined( var0.watch_for_players_regrouping_to_plane ) )
    {
        return true;
    }
    
    var6 = var0 getspawnbucketforplayer( var3, var4, 1 );
    
    if ( isdefined( var6 ) )
    {
        return true;
    }
    
    if ( isdefined( var0.vehicle ) )
    {
        return true;
    }
    
    if ( var0 scripts\mp\outofbounds::istouchingoobtrigger() )
    {
        return true;
    }
    
    var7 = ref_12575( var0 );
    
    if ( isdefined( var7 ) )
    {
        var8 = var7.vehicle;
        
        if ( var0 istouching( var7.trigger ) && var8.status == "contested" )
        {
            return true;
        }
    }
    
    if ( !var0 isonground() )
    {
        var9 = scripts\mp\gametypes\br_public::modifytriggerlocation( var0.origin, 0, -200 );
        
        if ( var9[ "fraction" ] == 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x3f
function respawnfade( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        if ( var2.label == var0 )
        {
            return var2;
        }
    }
    
    return undefined;
}

// Params 1
// Size: 0x39
function respawn_enemies( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        if ( var0 != var2 )
        {
            return var2;
        }
    }
    
    return undefined;
}

// Params 1
// Size: 0x77
function ref_121fc( var0 )
{
    var1 = respawn_enemies( var0 );
    
    if ( var1.getquestplunderrewardinstance + 1 < var0.getquestplunderrewardinstance )
    {
        foreach ( var3 in level.players )
        {
            if ( !isalive( var3 ) )
            {
                continue;
            }
            
            var4 = ref_12575( var3 );
            
            if ( var4 == var0 && !isdefined( var3.ref_12276 ) )
            {
                thread ref_125c5( var3 );
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x32
function ref_125c5( var0 )
{
    var1 = level.disable_super_in_turret.ref_121fc;
    var2 = gettime() + var1 * 1000;
    scripts\mp\utility\lower_message::ref_1316e( "br_payload_redeploy", var2, var1 );
    wait var1;
    ref_125c4( var0 );
}

// Params 1
// Size: 0xb0
function ref_125c4( var0 )
{
    var1 = "ui_br_open_purchase_killstreak";
    var2 = 0;
    var3 = "ui_br_purchase_killstreak_response";
    var4 = 1;
    self setclientomnvar( var3, var4 );
    self setclientomnvar( var1, var2 );
    scripts\cp_mp\utility\player_utility::_freezecontrols( 1, undefined, "kiosk" );
    var5 = var0;
    
    if ( !isdefined( var5 ) )
    {
        var5 = ref_12695();
    }
    
    if ( isplayer( var5 ) )
    {
        var6 = ref_12575( var5 );
    }
    else if ( istrue( var6.bot_gametype_attacker_limit_for_team ) )
    {
        var6 = var6.path;
    }
    else
    {
        var6 = var6;
    }
    
    self.warroomtvs = var6;
    ref_12689( var6 );
    
    if ( isdefined( self ) )
    {
        var7 = ref_1257c( var6 );
        self notify( "_watchToAutoCloseMenu_end" );
        ref_12648( var7 );
        scripts\cp_mp\utility\player_utility::_freezecontrols( 0, 1, "kiosk" );
        return 1;
    }
    
    return 0;
}

// Params 1
// Size: 0xda
function ref_12648( var0 )
{
    var1 = self;
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    var1 endon( "disconnect" );
    var2 = var1 scripts\mp\gametypes\br_gulag::ref_1263e( var0 );
    var3 = 1;
    scripts\mp\gametypes\br::ending_fade_in( var0.origin[ 0 ], var0.origin[ 1 ], level.juggheli_spawner_jammer5_3 );
    self setclientomnvar( "ui_br_transition_type", 2 );
    var1 playerhide();
    wait var3;
    scripts\mp\gametypes\br_public::ref_1264c();
    var1 scripts\mp\gametypes\br_gulag::ref_126c3( var0.origin, var0.angles );
    scripts\cp_mp\utility\player_utility::_freezecontrols( 1, undefined, "redeploy" );
    waitframe();
    var1 scripts\mp\gametypes\br_public::ref_126ed();
    var1 scripts\mp\gametypes\br_public::ref_1252b();
    scripts\cp_mp\utility\player_utility::_freezecontrols( 0, 1, "redeploy" );
    var1 playershow();
    var1 setclientomnvar( "ui_br_transition_type", 0 );
    var1 setclientomnvar( "ui_show_spectateHud", -1 );
    
    if ( level.disable_super_in_turret.ref_13602 > -1 )
    {
        thread ref_1253a();
    }
    
    ref_1255b();
}

// Params 2
// Size: 0x7c
function spawndogtagtoken( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "spawnChoice" );
    var0 endon( "disconnect" );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = -1;
    
    for ( ;; )
    {
        if ( var2 != var1.numplayers[ var0.team ] )
        {
            self setvalue( var1.numplayers[ var0.team ] );
            var2 = var1.numplayers[ var0.team ];
            ref_1318b( var1.script_index, var1.numplayers[ var0.team ] );
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x68
function ref_13621( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "spawnChoice" );
    var0 endon( "disconnect" );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = -1;
    
    for ( ;; )
    {
        if ( var2 != var1.numplayers[ var0.team ] )
        {
            var2 = var1.numplayers[ var0.team ];
            ref_1318b( var1.script_index, var1.numplayers[ var0.team ] );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0xc6
function ref_1253a()
{
    self endon( "disconnect" );
    self endon( "payload_remove_spawn_protection_flying" );
    
    while ( self.sessionstate != "playing" )
    {
        waitframe();
    }
    
    if ( self.spawnpos[ 2 ] <= 1100 )
    {
        thread scripts\cp_mp\parachute::startfreefall( undefined, 0, undefined, undefined, 1, 0, 1 );
    }
    else
    {
        thread scripts\cp_mp\parachute::startfreefall( 0, 1, undefined, undefined, 1, 0 );
        self skydive_deployparachute();
    }
    
    if ( scripts\mp\flags::gameflag( "prematch_done" ) && level.disable_super_in_turret.ref_13604 )
    {
        self.ref_12278 = 1;
        thread ref_126a9();
        var0 = gettime() + level.disable_super_in_turret.ref_13604 * 1000;
        
        while ( !self isonground() && self playerads() < 0.5 && gettime() < var0 )
        {
            waitframe();
        }
        
        self.ref_12278 = undefined;
        self notify( "payload_remove_spawn_protection_flying" );
        return;
    }
}

// Params 0
// Size: 0x26
function ref_126a9()
{
    self endon( "death_or_disconnect" );
    self endon( "payload_remove_spawn_protection_flying" );
    self waittill( "weapon_fired" );
    self.ref_12278 = undefined;
    self notify( "payload_remove_spawn_protection_flying" );
}

// Params 0
// Size: 0x1d
function embassy_level_init()
{
    scripts\mp\gametypes\br::onspawnplayer();
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        scripts\mp\gametypes\br_armor::searchcirclesize( 1 );
        return;
    }
}

// Params 0
// Size: 0x47
function emp_drone_should_take_damage()
{
    self endon( "disconnect" );
    self waittill( "brWaitAndSpawnClientComplete" );
    self clearpredictedstreampos();
    self setclientomnvar( "ui_br_transition_type", 0 );
    
    if ( !istrue( game[ "switchedsides" ] ) || scripts\mp\flags::gameflag( "infil_complete" ) )
    {
        self setclientomnvar( "ui_br_extended_load_screen", 0 );
        return;
    }
}

// Params 2
// Size: 0x1d1
function emp_drone_proximity_explode( var0, var1 )
{
    var2 = 4;
    var3 = 3;
    var4 = var2 + var3;
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        scripts\mp\gametypes\br::emp_drone_proximity_explode( var0 );
        return;
    }
    
    if ( self calloutmarkerping_getent() )
    {
        self setclientomnvar( "ui_br_extended_load_screen", 0 );
        return;
    }
    
    self clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 1 );
    
    if ( unset_relic_gas_martyr() )
    {
        level waittill( "forever" );
    }
    
    thread emp_drone_should_take_damage();
    
    if ( !isdefined( self.thrust_fx_model ) )
    {
        if ( !isdefined( var1 ) )
        {
            var1 = 0;
        }
        
        var5 = runkilltriger( self.team, var1 );
        var6 = var5 > 0;
        var7 = undefined;
        var8 = max( var5 - var4, 0 );
        
        if ( var6 )
        {
            var7 = var5 * 1000;
            var9 = scripts\mp\utility\teams::getteamdata( self.team, "teamCount" );
            
            if ( var9 == 1 )
            {
                self setclientomnvar( "ui_show_spectateHud", self getentitynumber() );
                scripts\mp\gametypes\br_spectate::ref_1252a();
                scripts\mp\gametypes\br::spawnintermission( self.origin + ( 0, 0, 100 ), self.angles );
                scripts\mp\spectating::setdisabled();
                scripts\mp\utility\lower_message::setlowermessageomnvar( 9, int( gettime() + var7 ) );
            }
            
            scripts\mp\utility\lower_message::setlowermessageomnvar( 9, int( gettime() + var7 ) );
            wait var8;
        }
        
        var10 = gettime();
        var11 = ref_12695();
        
        if ( isplayer( var11 ) )
        {
            var12 = ref_12575( var11 );
            var11 thread scripts\mp\rank::giverankxp( "br_payload_squadmate_redeploy", 20 );
            var11 thread scripts\mp\rank::scoreeventpopup( "br_payload_squadmate_redeploy" );
        }
        else if ( istrue( var12.bot_gametype_attacker_limit_for_team ) )
        {
            var12 = var12.path;
        }
        else
        {
            var12 = var12;
        }
        
        if ( istrue( var12.hidesmokinggunhudfromplayer ) )
        {
            var12 = respawn_enemies( var12 );
            var12 = var12;
            
            if ( istrue( var12.hidesmokinggunhudfromplayer ) )
            {
                level waittill( "forever" );
            }
        }
        
        self.warroomtvs = var12;
        ref_12689( var12 );
        var13 = ( gettime() - var12 ) / 1000;
        ref_126bc( var12, var11, var13, var7, var8, var10 );
    }
    else
    {
        self.thrust_fx_model = undefined;
        scripts\mp\gametypes\br_public::ref_126ed();
    }
    
    scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    self freezecontrols( 0 );
}

// Params 6
// Size: 0x12a
function ref_126bc( var0, var1, var2, var3, var4, var5 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self notify( "playerStreamRespawn" );
    self endon( "playerStreamRespawn" );
    self.ref_12276 = 1;
    self.ref_1286f = ref_1257c( var0 );
    
    if ( isdefined( self.ref_1286f ) )
    {
        self.ref_1286f.index = -1;
    }
    
    var6 = getdvarint( "scr_br_drop_prespawn_timeout_ms", 9000 );
    var7 = self.ref_1286f.origin;
    scripts\mp\gametypes\br_public::ref_126b9( var7, var6, 1, 0, var5 );
    var8 = 1;
    var9 = 0.25;
    var10 = var8 - var9;
    thread scripts\mp\gametypes\br_gulag::fadeoutin( var8 );
    wait var10;
    scripts\mp\gametypes\br_spectate::ref_1252a();
    scripts\mp\gametypes\br::spawnintermission( var7, self.ref_1286f.angles );
    scripts\mp\spectating::setdisabled();
    
    if ( getdvarint( "scr_br_alt_mode_mini", 0 ) == 0 )
    {
        scripts\mp\gametypes\br::ending_fade_in( var7[ 0 ], var7[ 1 ], level.juggheli_spawner_jammer5_3 );
    }
    
    self setclientomnvar( "ui_br_transition_type", 2 );
    wait var9;
    
    if ( var4 )
    {
        var11 = max( var3 - var1 - var2 - var8, 0 );
        wait var11;
        
        if ( self.ref_12276 > 1 )
        {
            scripts\mp\gametypes\br_public::ref_126ed();
        }
        else
        {
            scripts\mp\gametypes\br_public::ref_1252b();
        }
    }
    else
    {
        scripts\mp\gametypes\br_public::ref_126ed();
    }
    
    self setclientomnvar( "ui_show_spectateHud", -1 );
    self.ref_12276 = undefined;
}

// Params 0
// Size: 0x54
function ref_12006()
{
    if ( istrue( game[ "switchedsides" ] ) || scripts\mp\flags::gameflag( "infil_complete" ) )
    {
        var0 = round_enemies_push_logic( self.team, self.squadindex );
        var1 = level.disable_super_in_turret.paths[ var0 ];
        ref_12689( var1 );
        self.ref_13689 = ref_1257c( var1 );
        return self.ref_13689;
    }
}

// Params 1
// Size: 0x38, Type: bool
function get_bomb_vest_id_vfx( var0 )
{
    if ( level.disable_super_in_turret.ref_13602 < 0 )
    {
        return false;
    }
    
    if ( !isdefined( var0.getquestplunderrewardinstance ) )
    {
        return true;
    }
    
    return var0.getquestplunderrewardinstance <= level.disable_super_in_turret.ref_13602;
}

// Params 1
// Size: 0x288
function ref_1257c( var0 )
{
    var1 = var0;
    
    if ( isplayer( var0 ) )
    {
        var1 = ref_12575( var0 );
    }
    else if ( istrue( var0.bot_gametype_attacker_limit_for_team ) )
    {
        var1 = var0.path;
    }
    
    var2 = self.team == game[ "attackers" ] && get_bomb_vest_id_vfx( var1 ) || istrue( var0.bot_gametype_attacker_limit_for_team );
    
    if ( level.disable_super_in_turret.set_force_aitype_sniper && !var2 )
    {
        if ( isplayer( var0 ) )
        {
            ref_1252e( var0 );
            var3 = ref_1256c( var0, var0.origin, var0.angles );
            var4 = var3[ 0 ];
            var5 = var3[ 1 ];
            var3 = undefined;
        }
        else
        {
            var4 = ref_1256a( var2 );
        }
        
        if ( isdefined( var4 ) )
        {
            return var4;
        }
    }
    
    var6 = var2.ref_136fc[ var2.ref_136fb ].points[ var2.initial_enemy_spawner ];
    
    if ( var4 )
    {
        var7 = ref_1257f( var2 );
        var8 = var7[ 0 ];
        var9 = var7[ 1 ];
        var7 = undefined;
    }
    else
    {
        jumpiffalse(level.disable_super_in_turret.ref_129cb) LOC_0000011d;
        var10 = ref_12578( var6 );
        var8 = var10[ 0 ];
        var9 = var10[ 1 ];
        var10 = undefined;
        goto LOC_000001e3;
    }
    
LOC_000001e3:
    if ( !scripts\mp\gametypes\br_circle::vandalize_minigun_speed( var11, 0 ) )
    {
        var11 = scripts\mp\gametypes\br_c130::ref_1342e( var9, var11 );
        var20 = vectornormalize( var9 - var11 );
        var11 += var20 * 100;
    }
    
    if ( level.disable_super_in_turret.start_drones_event )
    {
        var21 = physics_createcontents( [ "physicscontents_playertrigger" ] );
        var22 = scripts\engine\trace::ray_trace_ents( var11, var9, [ var9.start_drones_event ], var21 );
        
        if ( var22[ "fraction" ] < 1 )
        {
            var11 = var22[ "position" ];
        }
    }
    
    var11 = scripts\mp\gametypes\br_public::modifyplayer_damage( var11 );
    var16 = vectortoangles( var9 - var11 );
    var4 = spawnstruct();
    var4.origin = var11 + ( 0, 0, var12 );
    var4.angles = var16;
    var4.height = var12;
    return var4;
}

// Params 1
// Size: 0xc2
function ref_1257f( var0 )
{
    var1 = 21;
    var2 = 11;
    var3 = 50;
    var4 = isdefined( level.disable_super_in_turret.ref_13876 ) && isdefined( self.cameraent );
    var5 = var2;
    
    if ( var4 )
    {
        var5 = var1;
    }
    
    var6 = ref_1256a( var0, 1, var5 );
    var7 = var0.spawncount[ self.team ];
    var8 = var7 % 2 == 0;
    var9 = int( var7 / 2 );
    var10 = var9 * var3;
    var11 = var6.origin;
    
    if ( var8 )
    {
        var12 = anglestoright( var6.angles );
        var11 = var6.origin + var12 * var10;
    }
    else
    {
        var13 = anglestoleft( var6.angles );
        var11 = var6.origin + var13 * var10;
    }
    
    return [ ( var11[ 0 ], var11[ 1 ], 0 ), level.disable_super_in_turret.ref_1365f ];
}

// Params 1
// Size: 0x1ca
function ref_12578( var0 )
{
    var1 = 20;
    var2 = 1;
    var3 = getdvarfloat( "scr_br_payload_spawn_degrees", var1 );
    var4 = getdvarfloat( "scr_br_payload_spawn_degrees", var2 );
    var5 = var0.ref_136fc[ var0.ref_136fb ].points[ var0.initial_enemy_spawner ];
    
    if ( !isdefined( var0.ref_13603 ) || var0.ref_13603 != var0.initial_enemy_spawner )
    {
        var6 = var0.ref_136fc[ var0.ref_136fb ].points[ var0.initial_enemy_spawner + 1 ];
        var7 = vectornormalize( var6 - var5 );
        var0.ref_13603 = var0.initial_enemy_spawner;
        var0.ref_136b6 = vectortoyaw( var7 );
        var0.ref_136b5 = vectortoyaw( -1 * var7 );
        var0.ref_136b8 = -1 * var3;
        var0.ref_136b7 = -1 * var3;
    }
    
    if ( self.team == game[ "defenders" ] )
    {
        var8 = level.disable_super_in_turret.ref_13633;
        var9 = level.disable_super_in_turret.ref_13660;
        var10 = level.disable_super_in_turret.ref_1368f;
        var11 = var0.ref_136b6 + var0.ref_136b8;
        var0.ref_136b8 += var4;
        
        if ( var0.ref_136b8 > var3 )
        {
            var0.ref_136b8 = -1 * var3;
        }
    }
    else
    {
        var8 = level.disable_super_in_turret.ref_13632;
        var9 = level.disable_super_in_turret.ref_1365f;
        var10 = level.disable_super_in_turret.ref_1368e;
        var11 = var4.ref_136b5 + var4.ref_136b7;
        var4.ref_136b7 += var10;
        
        if ( var4.ref_136b7 > var9 )
        {
            var4.ref_136b7 = -1 * var9;
        }
    }
    
    var12 = var11[ 0 ] + var8 * cos( var11 );
    var13 = var11[ 1 ] + var8 * sin( var11 );
    return [ ( var12, var13, 0 ), var9 ];
}

// Params 3
// Size: 0x2a1
function ref_1256a( var0, var1, var2 )
{
    var3 = self.team;
    var4 = isdefined( level.disable_super_in_turret.ref_13876 ) && isdefined( self.cameraent );
    
    if ( isdefined( var0.getquestplunderrewardinstance ) )
    {
        var5 = var0.getquestplunderrewardinstance;
    }
    else
    {
        var5 = 0;
    }
    
    var6 = var1.initchallengeandeventglobals;
    
    if ( !isdefined( var1.ref_13695[ var4 ] ) || var5 != var1.ref_1361e[ var4 ] || !var5 && istrue( var1.ref_13874 ) )
    {
        if ( var5 )
        {
            var1.ref_13695[ var4 ] = scripts\engine\utility::array_randomize( remove_dko_spawnflags( var4, var6 ) );
            var1.ref_13874 = 1;
        }
        else
        {
            var1.ref_13695[ var4 ] = scripts\engine\utility::array_randomize( remove_crusader_class( var4, var6, var5 ) );
            var1.ref_13874 = 0;
        }
        
        if ( var1.ref_13695[ var4 ].size == 0 )
        {
            iprintlnbold( "Spawns not setup for this path" );
            return;
        }
        
        var1.ref_13663[ var4 ] = randomint( var1.ref_13695[ var4 ].size );
        var1.spawncount[ var4 ] = 0;
        var1.spawntime[ var4 ] = gettime();
        var1.ref_1361e[ var4 ] = var5;
    }
    
    if ( var1.ref_13695[ var4 ].size == 0 )
    {
        iprintlnbold( "Spawns not setup for this path" );
        return;
    }
    
    var7 = var1.ref_13663[ var4 ];
    var8 = var1.ref_13695[ var4 ][ var7 ];
    
    if ( !isdefined( var3 ) )
    {
        var3 = level.disable_super_in_turret.set_force_aitype_shotgun;
        
        if ( isdefined( var8.radius ) && var8.radius < 200 )
        {
            var3 /= 2;
        }
    }
    
    if ( var1.spawntime[ var4 ] + 3000 < gettime() || var1.spawncount[ var4 ] >= var3 )
    {
        var1.spawncount[ var4 ] = 0;
        var1.ref_13663[ var4 ]++;
        
        if ( var1.ref_13663[ var4 ] >= var1.ref_13695[ var4 ].size )
        {
            var1.ref_13663[ var4 ] = 0;
        }
        
        var7 = var1.ref_13663[ var4 ];
        var8 = var1.ref_13695[ var4 ][ var7 ];
    }
    
    if ( !isdefined( var8.angles ) )
    {
        var8.angles = ( 0, 0, 0 );
    }
    
    ref_1252e( var8 );
    
    if ( istrue( var2 ) )
    {
        var1.spawntime[ var4 ] = gettime();
        var1.spawncount[ var4 ] += 1;
        return var8;
    }
    
    var9 = ref_1256c( var8.origin, var8.angles, var1.spawncount[ var4 ] );
    var10 = var9[ 0 ];
    var11 = var9[ 1 ];
    var9 = undefined;
    var12 = var8.playergetplunderomnvarbitpackinginfo - var10.origin;
    var10.angles = vectortoangles( var12 );
    var1.spawntime[ var4 ] = gettime();
    var1.spawncount[ var4 ] = var11 + 1;
    return var10;
}

// Params 4
// Size: 0x287
function ref_1256c( var0, var1, var2, var3 )
{
    var4 = 32;
    var5 = 8;
    var6 = 50;
    var7 = 20;
    var8 = 5;
    var9 = -200;
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var10 = scripts\engine\trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    var11 = isscriptabledefined() && getdvarint( "scr_br_payload_spawn_navmesh", 1 );
    var12 = 0;
    var13 = 0;
    var14 = var2;
    
    for ( ;; )
    {
        var15 = remove_closest_chopper_boss_vandalize_node_down( var0, var1[ 1 ], var14 );
        
        if ( var11 && !ispointonnavmesh( var15 ) )
        {
            var15 = getclosestpointonnavmesh( var15 );
        }
        
        var16 = var15 + ( 0, 0, var7 );
        var17 = var15 + ( 0, 0, var9 );
        var18 = scripts\engine\trace::player_trace( var16, var17, var1, self, var10 );
        var12++;
        
        if ( var18[ "fraction" ] == 0 )
        {
            if ( !istrue( var3 ) && var12 >= var5 )
            {
                var12 = 0;
                waitframe();
            }
            
            var16 = var15 + ( 0, 0, var6 );
            var17 = var15 + ( 0, 0, var9 );
            var18 = scripts\engine\trace::player_trace( var16, var17, var1, self, var10 );
            var12++;
        }
        
        if ( var18[ "fraction" ] == 0 )
        {
            if ( !istrue( var3 ) && var12 >= var5 )
            {
                var12 = 0;
                waitframe();
            }
            
            var16 = var15 + ( 0, 0, var8 );
            var17 = var15 + ( 0, 0, var9 );
            var18 = scripts\engine\trace::player_trace( var16, var17, var1, self, var10 );
            var12++;
        }
        
        if ( var18[ "fraction" ] > 0 && var18[ "fraction" ] != 1 )
        {
            if ( !istrue( var3 ) && var12 >= var5 )
            {
                var12 = 0;
                waitframe();
            }
            
            var19 = var0 + ( 0, 0, 60 );
            var20 = var18[ "position" ] + ( 0, 0, 60 );
            var21 = scripts\engine\trace::ray_trace( var19, var20, self, var10 );
            var12++;
            
            if ( var21[ "fraction" ] != 1 )
            {
                if ( !istrue( var3 ) && var12 >= var5 )
                {
                    var12 = 0;
                    waitframe();
                }
                
                var19 = var0 + ( 0, 0, 25 );
                var20 = var18[ "position" ] + ( 0, 0, 60 );
                var21 = scripts\engine\trace::ray_trace( var19, var20, self, var10 );
                var12++;
            }
            
            if ( var21[ "fraction" ] == 1 )
            {
                var22 = spawnstruct();
                var22.origin = var18[ "position" ];
                var22.angles = var1;
                var22.height = 0;
                return [ var22, var14 ];
            }
        }
        
        var15++;
        var14++;
        
        if ( var14 >= var5 )
        {
            var16 = var1;
            
            if ( var12 && !ispointonnavmesh( var16 ) )
            {
                var16 = getclosestpointonnavmesh( var16 );
            }
            
            var22 = spawnstruct();
            var22.origin = var16;
            var22.angles = var2;
            var22.height = 0;
            return [ var22, var3 ];
        }
        
        if ( !istrue( var5 ) && var14 >= var7 )
        {
            var14 = 0;
            waitframe();
        }
    }
}

// Params 1
// Size: 0x4c
function ref_1252e( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        self.heli_landing_volumes[ var2.label ] = var0.heli_landing_volumes[ var2.label ];
    }
}

// Params 2
// Size: 0x4c
function remove_dko_spawnflags( var0, var1 )
{
    var2 = level.disable_super_in_turret.ref_13876[ var0 ];
    var3 = [];
    
    foreach ( var5 in var2 )
    {
        if ( var5.script_group == var1 )
        {
            var3 = var5;
        }
    }
    
    return var3;
}

// Params 3
// Size: 0x5a
function remove_crusader_class( var0, var1, var2 )
{
    var3 = level.disable_super_in_turret.ref_13695[ var0 ];
    var4 = [];
    
    foreach ( var6 in var3 )
    {
        if ( var6.script_group == var1 && var6.script_index == var2 )
        {
            var4 = var6;
        }
    }
    
    return var4;
}

// Params 3
// Size: 0x73
function remove_closest_chopper_boss_vandalize_node_down( var0, var1, var2 )
{
    var3 = 10;
    var4 = 100;
    var5 = 100;
    var6 = 90;
    var7 = 10;
    var8 = 360 / var3;
    var9 = int( var2 / var3 );
    var10 = var2 - var9 * var3;
    var11 = var1 + var6 + var10 * var8 + var9 * var7;
    var12 = var4 + var9 * var5;
    var13 = ( 0, var11, 0 );
    var14 = anglestoforward( var13 );
    var15 = var0 + var14 * var12;
    return var15;
}

// Params 1
// Size: 0x3d
function respawnheightoverride( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        if ( var2.script_index == var0 )
        {
            return var2;
        }
    }
}

// Params 1
// Size: 0x3d
function respawndelayoverride( var0 )
{
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        if ( var2.initchallengeandeventglobals == var0 )
        {
            return var2;
        }
    }
}

// Params 2
// Size: 0x18
function isused( var0, var1 )
{
    level notify( "debugSpawnOrigin" );
    level endon( "debugSpawnOrigin" );
    
    for ( ;; )
    {
        waitframe();
    }
}

// Params 1
// Size: 0x47
function ref_12689( var0 )
{
    var1 = 500;
    
    if ( isdefined( self.ref_12204 ) && self.ref_12204 == var0 )
    {
        return;
    }
    
    var2 = self.ref_12204;
    self.ref_12204 = var0;
    self.ref_12202 = gettime() + var1;
    ref_13181( var0.label != "A" );
}

// Params 0
// Size: 0x8
function ref_12575()
{
    return self.ref_12204;
}

// Params 0
// Size: 0x8
function ref_12576()
{
    return self.ref_12202;
}

// Params 1
// Size: 0x178
function modifyplayerdamage( var0 )
{
    var1 = var0.damage;
    
    if ( istrue( self.ref_12279 ) || istrue( self.ref_12278 ) )
    {
        var1 = 0;
        
        if ( isdefined( var0.attacker ) && isplayer( var0.attacker ) )
        {
            var0.attacker scripts\mp\damagefeedback::updatedamagefeedback( "hitspawnprotect" );
        }
    }
    
    if ( self.team == game[ "attackers" ] )
    {
        var2 = isdefined( var0.attacker ) && var0.attacker scripts\mp\gametypes\br_public::nuke_vault_suicidebombers() && istrue( var0.attacker.ref_12282 );
        
        if ( var2 )
        {
            var1 = int( min( var1, level.disable_super_in_turret.ref_11b58 ) );
        }
    }
    
    if ( isdefined( var0.attacker ) && var0.attacker scripts\mp\gametypes\br_public::nuke_vault_suicidebombers() && isdefined( var0.attacker.path ) )
    {
        var1 = 0;
    }
    
    if ( getdvarint( "scr_br_payload_mod_gunner_dmg", 1 ) && isdefined( var0.victim.set_thirdperson ) )
    {
        if ( isplayer( var0.attacker ) && scripts\engine\utility::isbulletdamage( var0.meansofdeath ) && var1 < 100 )
        {
            var3 = var0.idflags & level.idflags_penetration;
            var4 = scripts\mp\utility\damage::isheadshot( var0.shitloc, var0.meansofdeath, var0.attacker );
            var5 = weaponclass( var0.objweapon ) == "spread";
            
            if ( var3 )
            {
                var1 *= level.set_total_successful_vehicle_spawns_from_module;
            }
            else if ( !var4 || !var5 )
            {
                var1 *= level.set_tier_lights;
            }
        }
    }
    
    return var1;
}

// Params 2
// Size: 0x139
function ref_1226b( var0, var1 )
{
    if ( scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        var2 = var0.attacker;
        
        if ( !isdefined( var2 ) || !isplayer( var2 ) )
        {
            if ( isdefined( var0.attacker ) && isdefined( var0.attacker.owner ) && isplayer( var0.attacker.owner ) )
            {
                var2 = var0.attacker.owner;
            }
            else if ( isdefined( var0.inflictor ) && isplayer( var0.inflictor ) )
            {
                var2 = var0.inflictor;
            }
            else if ( isdefined( var0.inflictor ) && isdefined( var0.inflictor.owner ) && isplayer( var0.inflictor.owner ) )
            {
                var2 = var0.inflictor.owner;
            }
            else
            {
                var2 = undefined;
            }
        }
        
        if ( isdefined( var2 ) && var2 != self )
        {
            var3 = 0;
            
            if ( var2.team == game[ "attackers" ] )
            {
                var3 = getdvarint( "scr_br_payload_attacker_kill_pay_scale", 4 );
            }
            else
            {
                var3 = getdvarint( "scr_br_payload_defender_kill_pay_scale", 3 );
            }
            
            if ( ref_125f2( var2 ) )
            {
                var3 += 4;
            }
            
            ref_12261( var2, var3, "payload_kill" );
        }
    }
    
    return scripts\mp\gametypes\br::emp_drone_damage_monitor( var0, var1 );
}

// Params 2
// Size: 0x153, Type: bool
function playerdropplunderondeath( var0, var1 )
{
    if ( self.team == game[ "attackers" ] )
    {
        if ( getdvarint( "scr_br_payload_attacker_plunderdrop", 1 ) == 0 )
        {
            return true;
        }
        
        var2 = getdvarint( "scr_br_payload_attacker_saveshare", 7 );
        var3 = getdvarint( "scr_br_payload_attacker_taxshare", 0 );
        var4 = getdvarint( "scr_br_payload_attacker_dropshare", 0 );
    }
    else
    {
        if ( getdvarint( "scr_br_payload_defender_plunderdrop", 1 ) == 0 )
        {
            return true;
        }
        
        var2 = getdvarint( "scr_br_payload_defender_saveshare", 7 );
        var3 = getdvarint( "scr_br_payload_defender_taxshare", 0 );
        var4 = getdvarint( "scr_br_payload_defender_dropshare", 0 );
    }
    
    if ( isdefined( self.plundercount ) && self.plundercount > 0 )
    {
        var5 = self.plundercount;
    }
    else
    {
        scripts\mp\gametypes\br_plunder::ml_p3_func( 0, var4 );
        return true;
    }
    
    var6 = var2 + var3 + var4;
    var7 = var2 / var6;
    var8 = int( max( var5 - 5, int( min( var5, max( 2, int( var5 * var7 ) ) ) + 0.5 ) ) );
    var9 = int( var5 - var8 );
    var10 = max( 1, var3 + var4 );
    var11 = var3 / var10;
    var12 = var4 / var10;
    var13 = int( max( 0, int( var9 * var12 ) ) );
    self.plundercountondeath = var8;
    var14 = spawnstruct();
    var14.ref_133e4 = 1;
    scripts\mp\gametypes\br_plunder::playersetplundercount( var8, var14 );
    
    if ( var13 <= 0 )
    {
        return true;
    }
    
    scripts\mp\gametypes\br_plunder::ml_p3_func( var13, var3 );
    return true;
}

// Params 4
// Size: 0x6d
function ref_12284( var0, var1, var2, var3 )
{
    if ( !level.disable_super_in_turret.ref_1225f )
    {
        return;
    }
    
    if ( var0 )
    {
        var4 = self.obj_payload_stage.touchlist[ self.team ];
        ref_12262( var4, var2, "vehicle_tick_att" );
    }
    
    if ( var1 || isdefined( self.tutonplayerkilled ) )
    {
        var4 = self.obj_payload_stage.touchlist[ game[ "defenders" ] ];
        ref_12262( var4, var3, "vehicle_tick_def" );
        return;
    }
}

// Params 3
// Size: 0xd4
function ref_12262( var0, var1, var2 )
{
    var3 = getdvarfloat( "scr_br_plunder_while_spectating", 0.4 );
    var4 = 0;
    
    foreach ( var6 in var0 )
    {
        if ( isbot( var6.player ) && scripts\mp\gametypes\br_public::validtousesticker() )
        {
            continue;
        }
        
        var7 = var1;
        
        if ( !scripts\mp\utility\player::isreallyalive( var6.player ) )
        {
            var7 = int( max( var1 * var3, 1 ) );
        }
        
        if ( !isdefined( var6.player.plundercount ) )
        {
            var6.player.plundercount = 0;
        }
        
        var6.player scripts\mp\gametypes\br_plunder::ref_12627( var7 );
        level.br_plunder.ref_12784 += var7;
        var6.player scripts\mp\gametypes\br_analytics::ref_13c44( var6.player, var2, var7 );
    }
}

// Params 3
// Size: 0x7a
function ref_12261( var0, var1, var2 )
{
    var3 = getdvarfloat( "scr_br_plunder_while_spectating", 0.5 );
    var4 = 0;
    
    if ( isbot( var0 ) && scripts\mp\gametypes\br_public::validtousesticker() )
    {
        return;
    }
    
    var5 = var1;
    
    if ( !scripts\mp\utility\player::isreallyalive( var0 ) )
    {
        var5 = int( var1 * var3 );
    }
    
    if ( !isdefined( var0.plundercount ) )
    {
        var0.plundercount = 0;
    }
    
    var0 scripts\mp\gametypes\br_plunder::ref_12627( var5 );
    level.br_plunder.ref_12784 += var5;
    var0 scripts\mp\gametypes\br_analytics::ref_13c44( var0, var2, var5 );
}

// Params 0
// Size: 0x1a5
function totalcollecteditems()
{
    if ( !level.disable_super_in_turret.ref_136c4 )
    {
        return;
    }
    
    foreach ( var1 in level.disable_super_in_turret.paths )
    {
        var2 = ref_11f46( var1 );
        var3 = var2[ 0 ];
        var4 = var2[ 1 ];
        var2 = undefined;
        var1.ref_136c3 = [];
        var1.ref_136c3[ game[ "attackers" ] ] = [];
        var1.ref_136c3[ game[ "defenders" ] ] = [];
        
        for ( var5 = 0; var5 < var3 ; var5++ )
        {
            var6 = init_trap_room_wave( var1 );
            var1.ref_136c3[ game[ "attackers" ] ][ var5 ] = var6;
        }
        
        for ( var5 = 0; var5 < var4 ; var5++ )
        {
            var6 = init_trap_room_wave( var1 );
            var1.ref_136c3[ game[ "defenders" ] ][ var5 ] = var6;
        }
    }
    
    if ( istrue( level.disable_super_in_turret.ref_136c5 ) )
    {
        level.disable_super_in_turret.ref_136ae = [ 1500, 2000, 2500, 2800, 3000, 3200, 3500 ];
        level._effect[ "payload_oob_1500" ] = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_1500" );
        level._effect[ "payload_oob_2000" ] = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_2000" );
        level._effect[ "payload_oob_2500" ] = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_2500" );
        level._effect[ "payload_oob_2800" ] = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_2800" );
        level._effect[ "payload_oob_3000" ] = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_3000" );
        level._effect[ "payload_oob_3200" ] = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_3200" );
        level._effect[ "payload_oob_3500" ] = loadfx( "vfx/iw8_br/gameplay/payload/vfx_br_payload_oob_circle_3500" );
        return;
    }
}

// Params 0
// Size: 0x2d
function ref_140d5()
{
    foreach ( var1 in level.disable_super_in_turret.ref_136c3 )
    {
    }
}

// Params 1
// Size: 0x35
function init_trap_room_wave( var0 )
{
    var1 = getmaxobjectivecount( 0, 0, level.disable_super_in_turret.ref_136c2 );
    var1 setmapcirclecolorindex( 0 );
    var1 hide();
    var1.enabled = 0;
    var1.path = var0;
    return var1;
}

// Params 1
// Size: 0x11f
function ref_11f46( var0 )
{
    var1 = [];
    GscBinSkip0( 0x2e, game[ "attackers" ], [] );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 5
// Size: 0x59
function init_trigger_spawn( var0, var1, var2, var3, var4 )
{
    var5 = spawn( "trigger_radius", var0, 0, var1, 2000 );
    var5.targetname = "OutOfBounds";
    var5.radius = var1;
    var5.script_team = var2;
    var5.ref_136bc = var3;
    var5.spawntime = gettime();
    
    if ( !istrue( var4 ) )
    {
        thread scripts\mp\outofbounds::watchoobtrigger( var5 );
    }
    
    return var5;
}

// Params 2
// Size: 0x4f
function ref_13270( var0, var1 )
{
    if ( !level.disable_super_in_turret.ref_136c4 )
    {
        return;
    }
    
    scripts\mp\flags::gameflagwait( "infil_complete" );
    ref_13271( var0, var1, game[ "attackers" ] );
    ref_13271( var0, var1, game[ "defenders" ] );
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
}

// Params 3
// Size: 0x19a
function ref_13271( var0, var1, var2 )
{
    var3 = relic_squadlink_outline_monitor( var2 );
    var4 = remove_crusader_class( var2, var0.initchallengeandeventglobals, var1 );
    var5 = rootweapon( var4, var0, var1, var2 );
    var6 = removeplayeraslootleader( var4 );
    var7 = var6[ 0 ];
    var8 = var6[ 1 ];
    var6 = undefined;
    
    for ( var9 = 0; var9 < var0.ref_136c3[ var2 ].size ; var9++ )
    {
        var10 = var0.ref_136c3[ var2 ][ var9 ];
        
        if ( isdefined( var10.trigger ) )
        {
            lastdialogfinishedtime( var10.trigger );
        }
        
        has_relic_amped_victim_filled_bar( var10 );
        
        if ( var9 < var5.size )
        {
            var11 = var5[ var9 ];
            var10.origin = ( var11.origin[ 0 ], var11.origin[ 1 ], var11.radius );
            var12 = ( var11.origin[ 0 ], var11.origin[ 1 ], var7 + -1000 );
            var10.trigger = init_trigger_spawn( var12, var11.radius, var3, var10 );
            
            if ( istrue( level.disable_super_in_turret.ref_136c5 ) )
            {
                var13 = init_trigger_spawn( var12, int( var11.radius + level.disable_super_in_turret.ref_136c9 ), var3, var10, 1 );
                var13.targetname = "OobWarning";
                scripts\mp\utility\trigger::makeenterexittrigger( var13, &ref_136c6, &ref_136c7 );
                var10.ref_14427 = var13;
                var10.radius = var11.radius;
            }
            
            if ( !var10.enabled )
            {
                if ( !level.disable_super_in_turret.ref_136be )
                {
                    showtoteam( var10, var3 );
                }
                
                var10.enabled = 1;
            }
            
            var10.enabled = 1;
            continue;
        }
        
        var10 hide();
        var10.enabled = 0;
    }
}

// Params 1
// Size: 0x7f
function lastdialogfinishedtime( var0 )
{
    foreach ( var2 in var0.entstouching )
    {
        if ( isdefined( var2.oob ) && var2.oob > 0 )
        {
            scripts\mp\outofbounds::disableoob( var2 );
        }
        
        var2.oobtriggers = scripts\engine\utility::array_remove( var2.oobtriggers, var0 );
        
        if ( var2.oobtriggers.size == 0 )
        {
            var2.oobtriggers = undefined;
        }
    }
    
    var0 notify( "clearOOB" );
    var0 delete();
}

// Params 1
// Size: 0xc9
function loadoutexecutionquip( var0 )
{
    if ( !level.disable_super_in_turret.ref_136c4 )
    {
        return;
    }
    
    foreach ( var2 in var0.ref_136c3[ game[ "attackers" ] ] )
    {
        if ( isdefined( var2.trigger ) )
        {
            lastdialogfinishedtime( var2.trigger );
        }
        
        has_relic_amped_victim_filled_bar( var2 );
        var2.enabled = 0;
        var2 hide();
    }
    
    foreach ( var2 in var0.ref_136c3[ game[ "defenders" ] ] )
    {
        if ( isdefined( var2.trigger ) )
        {
            lastdialogfinishedtime( var2.trigger );
        }
        
        has_relic_amped_victim_filled_bar( var2 );
        var2.enabled = 0;
        var2 hide();
    }
}

// Params 3
// Size: 0xbe
function ropeguy( var0, var1, var2 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var3 = [];
    
    if ( isdefined( level.disable_super_in_turret.ref_136c3 ) && level.disable_super_in_turret.ref_136c3.size > 0 )
    {
        foreach ( var5 in level.disable_super_in_turret.ref_136c3 )
        {
            if ( var5.script_group != var0.initchallengeandeventglobals )
            {
                continue;
            }
            
            if ( var5.script_index != var1 )
            {
                continue;
            }
            
            var6 = scripts\engine\utility::ter_op( var5.team == "allies", game[ "attackers" ], game[ "defenders" ] );
            
            if ( var6 != var2 )
            {
                continue;
            }
            
            var3 = var5;
        }
    }
    
    return var3;
}

// Params 4
// Size: 0x63
function rootweapon( var0, var1, var2, var3 )
{
    var4 = ropeguy( var1, var2, var3 );
    
    if ( var4.size == 0 )
    {
        var5 = removeplayeraslootleader( var0 );
        var6 = var5[ 0 ];
        var7 = var5[ 1 ];
        var5 = undefined;
        var8 = ( var7[ 0 ], var7[ 1 ], var6 );
        var4 = spawnstruct();
        var4[ 0 ].origin = var8;
        var4[ 0 ].radius = level.disable_super_in_turret.ref_136c2;
    }
    
    return var4;
}

// Params 1
// Size: 0x7a
function removeplayeraslootleader( var0 )
{
    var1 = ( 0, 0, 0 );
    var2 = undefined;
    
    foreach ( var4 in var0 )
    {
        var1 += var4.origin;
        
        if ( !isdefined( var2 ) || var4.origin[ 2 ] < var2 )
        {
            var2 = var4.origin[ 2 ];
        }
    }
    
    var6 = var1;
    
    if ( var0.size > 0 )
    {
        var6 /= var0.size;
    }
    
    return [ var2, var6 ];
}

// Params 1
// Size: 0x3d
function showtoteam( var0 )
{
    self hide();
    var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    foreach ( var3 in var1 )
    {
        self showtoplayer( var3 );
    }
}

// Params 0
// Size: 0xc9
function ref_126ad()
{
    self endon( "death_or_disconnect" );
    self endon( "payload_remove_spawn_protection" );
    
    if ( isdefined( self.warroomtvs ) && ( isplayer( self.warroomtvs ) || istrue( self.warroomtvs.bot_gametype_attacker_limit_for_team ) ) )
    {
        return;
    }
    
    if ( isdefined( self.warroomtvs ) )
    {
        var0 = self.warroomtvs;
    }
    else
    {
        var0 = ref_12575();
    }
    
    if ( get_bomb_vest_id_vfx( var0 ) )
    {
        return;
    }
    
    self.ref_12279 = 1;
    thread ref_126ae();
    var1 = gettime() + level.disable_super_in_turret.ref_1365c * 1000;
    var2 = ref_1257e( var0 );
    
    while ( isdefined( var2 ) && isdefined( var2.trigger ) && self istouching( var2.trigger ) && self playerads() < 0.5 && gettime() < var1 )
    {
        waitframe();
    }
    
    self.ref_12279 = undefined;
    self notify( "payload_remove_spawn_protection" );
}

// Params 1
// Size: 0x6b
function ref_1257e( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = ref_12575();
    }
    
    var1 = var0.ref_136c3[ self.team ];
    
    if ( isdefined( var1 ) && var1.size > 0 )
    {
        foreach ( var3 in var1 )
        {
            if ( !istrue( var3.enabled ) )
            {
                continue;
            }
            
            if ( self istouching( var3.trigger ) )
            {
                return var3;
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x26
function ref_126ae()
{
    self endon( "death_or_disconnect" );
    self endon( "payload_remove_spawn_protection" );
    self waittill( "weapon_fired" );
    self.ref_12279 = undefined;
    self notify( "payload_remove_spawn_protection" );
}

// Params 1
// Size: 0xf
function room_doors( var0 )
{
    var1 = "payload_oob_" + var0;
    return var1;
}

// Params 2
// Size: 0xc8
function ref_136c6( var0, var1 )
{
    if ( !isplayer( var0 ) || var0.team != var1.script_team )
    {
        return;
    }
    
    var2 = var1.ref_136bc;
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    if ( !isdefined( var2.ref_14425 ) )
    {
        var2.ref_14425 = [];
    }
    
    var3 = var0 getentitynumber();
    var4 = room_doors( var2.radius );
    var5 = ( var1.origin[ 0 ], var1.origin[ 1 ], var0.origin[ 2 ] );
    var2.ref_14425[ var3 ] = spawn( "script_model", var5 );
    var2.ref_14425[ var3 ] setmodel( "tag_origin" );
    var2.ref_14425[ var3 ] hide();
    var2.ref_14425[ var3 ] showtoplayer( var0 );
    thread ref_136c8( var0, var2.ref_14425[ var3 ], var4 );
}

// Params 3
// Size: 0x5c
function ref_136c8( var0, var1, var2 )
{
    var1 endon( "death" );
    var0 endon( "disconnect" );
    waitframe();
    var1 unmarkkeyframedmover( 1 );
    playfxontag( scripts\engine\utility::getfx( var2 ), var1, "tag_origin" );
    var3 = var1.origin[ 0 ];
    var4 = var1.origin[ 1 ];
    
    for ( ;; )
    {
        var1.origin = ( var3, var4, var0.origin[ 2 ] );
        waitframe();
    }
}

// Params 2
// Size: 0x66
function ref_136c7( var0, var1 )
{
    if ( !isplayer( var0 ) || var0.team != var1.script_team )
    {
        return;
    }
    
    var2 = var0 getentitynumber();
    var3 = var1.ref_136bc;
    
    if ( !isdefined( var3 ) || !isdefined( var3.ref_14425 ) || !isdefined( var3.ref_14425[ var2 ] ) )
    {
        return;
    }
    
    var3.ref_14425[ var2 ] delete();
    var3.ref_14425[ var2 ] = undefined;
}

// Params 0
// Size: 0x6c
function has_relic_amped_victim_filled_bar()
{
    var0 = self;
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( isdefined( var0.ref_14427 ) )
    {
        var0.ref_14427 delete();
        var0.ref_14427 = undefined;
    }
    
    if ( isdefined( var0.ref_14425 ) )
    {
        foreach ( var2 in var0.ref_14425 )
        {
            if ( isdefined( var2 ) )
            {
                var2 delete();
            }
        }
        
        var0.ref_14425 = undefined;
        return;
    }
}

// Params 1
// Size: 0x57
function ref_131d4( var0 )
{
    if ( var0 <= 0 )
    {
        setomnvar( "ui_hardpoint_timer", gettime() );
        return;
    }
    
    var1 = scripts\mp\utility\game::gettimepassed();
    setomnvar( "ui_hardpoint_timer", gettime() + int( var0 * 1000 ) );
    var2 = int( var1 / 1000 );
    var3 = var2 + var0;
    scripts\mp\utility\dvars::setoverridewatchdvar( "timelimit", var3 );
    setdvar( "scr_br_timelimit", var3 );
}

// Params 0
// Size: 0x13, Type: bool
function unset_relic_gas_martyr()
{
    return istrue( level.ref_1225c ) || istrue( level.gameended );
}

// Params 0
// Size: 0x93
function ontimelimit()
{
    if ( unset_relic_gas_martyr() )
    {
        return;
    }
    
    if ( waittill_player_uses_munition() )
    {
        return;
    }
    
    if ( istrue( level.ref_1227f ) || unset_relic_gas_martyr() )
    {
        return;
    }
    
    level.ref_1227f = 1;
    ref_12aa3();
    ref_12aa5();
    var0 = game[ "attackers" ];
    var1 = game[ "defenders" ];
    var2 = "time_limit_reached";
    thread ref_14301( "stopped", undefined, undefined, 2 );
    thread scripts\mp\gametypes\br::ref_1209b( var0, 2, undefined, 1, 1, 1 );
    munition_slot_gunship_emptied_message();
    ref_1225d( 1, var1 );
    ref_11ecc( var1 );
    thread scripts\mp\gametypes\br::brendgame( var1, game[ "end_reason" ][ var2 ], 0 );
}

// Params 1
// Size: 0x41
function ref_11ecc( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) && var2.team == var0 )
        {
            var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
        }
    }
}

// Params 0
// Size: 0x1a7
function munition_slot_gunship_emptied_message()
{
    if ( !istrue( game[ "switchedsides" ] ) )
    {
        return;
    }
    
    foreach ( var1 in level.players )
    {
        var2 = var1.pers[ "score" ] + scripts\engine\utility::ter_op( isdefined( var1.pers[ "round1_score" ] ), var1.pers[ "round1_score" ], 0 );
        var1.score = var2;
        var3 = var1.pers[ "kills" ] + scripts\engine\utility::ter_op( isdefined( var1.pers[ "round1_kills" ] ), var1.pers[ "round1_kills" ], 0 );
        var1.kills = var3;
        var4 = var1.pers[ "deaths" ] + scripts\engine\utility::ter_op( isdefined( var1.pers[ "round1_deaths" ] ), var1.pers[ "round1_deaths" ], 0 );
        var1.deaths = var4;
        var5 = var1.pers[ "assists" ] + scripts\engine\utility::ter_op( isdefined( var1.pers[ "round1_assists" ] ), var1.pers[ "round1_assists" ], 0 );
        var1.assists = var5;
        var6 = var1.pers[ "damage" ] + scripts\engine\utility::ter_op( isdefined( var1.pers[ "round1_damage" ] ), var1.pers[ "round1_damage" ], 0 );
        var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "damageDealt", var6 );
        var7 = var1.pers[ "objTime" ] + scripts\engine\utility::ter_op( isdefined( var1.pers[ "round1_objTime" ] ), var1.pers[ "round1_objTime" ], 0 );
        var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "objTime", var7 );
    }
}

// Params 0
// Size: 0x1fe
function munition_source_getridof()
{
    foreach ( var1 in level.players )
    {
        function_0435( var1 );
    }
    
    foreach ( var1 in level.players )
    {
        var1.force_remove_stim = var1.pers[ "team" ];
        var1.force_var_to_array = var1.pers[ "recordedLoss" ];
        var1.forced_aitypes = var1.pers[ "score" ];
        var1.force_teleport_player_into_plane = var1.pers[ "kills" ];
        var1.ª£€áøÂQ-þ³ƒ' = var1.pers[ "deaths" ];
        var1.JÁ›Ž5š“(É(s = var1.pers[ "assists" ];
        var1.force_maze_ai_state = var1.pers[ "damage" ];
        var1.forceabshotfoot = var1.pers[ "objTime" ];
        var1.forcearmordropondeath = var1.pers[ "roundsAFK" ];
    }
    
    function_0436();
    
    foreach ( var1 in level.players )
    {
        var1.pers[ "team" ] = var1.force_remove_stim;
        var1.pers[ "recordedLoss" ] = var1.force_var_to_array;
        var1.pers[ "round1_score" ] = var1.forced_aitypes;
        var1.pers[ "round1_kills" ] = var1.force_teleport_player_into_plane;
        var1.pers[ "round1_deaths" ] = var1.ª£€áøÂQ-þ³ƒ';
        var1.pers[ "round1_assists" ] = var1.JÁ›Ž5š“(É(s;
        var1.pers[ "round1_damage" ] = var1.force_maze_ai_state;
        var1.pers[ "round1_objTime" ] = var1.forceabshotfoot;
        var1.pers[ "roundsAFK" ] = var1.forcearmordropondeath;
    }
    
    game[ "gamestarted" ] = undefined;
    game[ "clientMatchDataDef" ] = undefined;
}

// Params 0
// Size: 0x66
function ref_13230()
{
    level.disable_super_in_turret.initsharedomnvars = 0;
    level.disable_super_in_turret.waittill_scout_drone_defined = 0;
    ref_1313a( 0 );
    
    foreach ( var1 in level.disable_super_in_turret.paths )
    {
        var1.getquestplunderrewardinstance = -1;
        ref_11e6f( var1.getquestplunderrewardinstance, var1 );
    }
}

// Params 1
// Size: 0xc
function relic_amped_last_kill_time( var0 )
{
    return var0.getquestplunderrewardinstance;
}

// Params 2
// Size: 0x22b
function ref_11e6f( var0, var1 )
{
    if ( !getquesttablerewardgroup() )
    {
        return;
    }
    
    if ( var1.getquestplunderrewardinstance >= 0 )
    {
        level notify( "checkPointUpdate", var1 );
    }
    
    if ( var1.getquestplunderrewardinstance >= 0 )
    {
        ref_12aa3( var1 );
        start_pipe_room_menu();
    }
    
    var2 = var1.getquestplunderrewardinstance;
    var1.getquestplunderrewardinstance++;
    level.disable_super_in_turret.initsharedomnvars = gettime();
    
    if ( isdefined( level.disable_super_in_turret.getquestrewardscalerstablescaleinfo ) )
    {
        var3 = relic_amped_monitor();
        
        foreach ( var5 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo )
        {
            var5 setvalue( var3 );
        }
    }
    
    if ( var1.getquestplunderrewardinstance > 0 )
    {
        ref_1318a( var1.script_index, var1.getquestplunderrewardinstance );
        var7 = "br_payload_checkpoint";
        var8 = "br_payload_checkpoint_enemy";
        scripts\mp\gametypes\br::ref_13ac7( var7, undefined, game[ "attackers" ] );
        scripts\mp\gametypes\br::ref_13ac7( var8, undefined, game[ "defenders" ] );
        
        foreach ( var10 in level.teamdata[ game[ "attackers" ] ][ "players" ] )
        {
            var10 thread scripts\mp\rank::giverankxp( "br_payload_reached_checkpoint", level.disable_super_in_turret.ref_12288, undefined );
            var10 thread scripts\mp\gametypes\br::scriptableusestate( "br_payload_reached_checkpoint", int( level.disable_super_in_turret.ref_12288 / 2 ), var10.currentweapon, 1 );
            var10 thread scripts\mp\rank::scoreeventpopup( "br_payload_reached_checkpoint" );
        }
        
        ref_11f92( var1, 1, "checkpoint", var1.getquestplunderrewardinstance );
        thread ref_13639( game[ "attackers" ] );
        thread ref_13639( game[ "defenders" ] );
    }
    
    if ( game[ "switchedsides" ] && isfinalpush() )
    {
        setnojiptime( 1, 1 );
        setnojipscore( 1, 1 );
        level.nojip = 1;
    }
    
    var1 notify( "checkPointUpdate" );
    thread getquestperkbonus( level );
    thread ref_1322f( var1 );
    thread ref_13270( var1, var1.getquestplunderrewardinstance );
    thread ref_13260( var1, var1.getquestplunderrewardinstance );
    thread ref_1286a( var1.getquestplunderrewardinstance, var1 );
    thread ref_1326a( var1, var1.getquestplunderrewardinstance );
    thread ref_13257( var1, var1.getquestplunderrewardinstance );
    thread ref_12cb8( var1 );
}

// Params 1
// Size: 0x104
function ref_12cb8( var0 )
{
    var1 = var0;
    
    if ( istrue( var0.hidesmokinggunhudfromplayer ) )
    {
        var1 = respawn_enemies( var0 );
    }
    
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3.ref_12276 ) && var3.ref_12276 > 0 )
        {
            var4 = ref_12575( var3 );
            
            if ( var4 == var0 )
            {
                var3.ref_12276++;
                var3.ref_1286f = ref_1257c( var3, var1 );
                
                if ( isdefined( var3.ref_1286f ) )
                {
                    var3.ref_1286f.index = -1;
                }
                
                var5 = var3.ref_1286f.origin;
                var6 = getdvarint( "scr_br_drop_prespawn_timeout_ms", 9000 );
                var3 scripts\mp\gametypes\br_public::ref_126b9( var5, var6, 1, 0 );
                var3 scripts\mp\gametypes\br_spectate::ref_1252a();
                var3 scripts\mp\gametypes\br::spawnintermission( var5, var3.ref_1286f.angles );
                var3 scripts\mp\spectating::setdisabled();
                var3 scripts\mp\gametypes\br::ending_fade_in( var5[ 0 ], var5[ 1 ], level.juggheli_spawner_jammer5_3 );
                var3 setclientomnvar( "ui_br_transition_type", 2 );
            }
        }
    }
}

// Params 0
// Size: 0x50
function relic_amped_monitor()
{
    var0 = 0;
    
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        var3 = 0;
        
        if ( isdefined( var2.getquestplunderrewardinstance ) )
        {
            var3 = var2.getquestplunderrewardinstance;
        }
        
        var0 += var3;
    }
    
    return var0;
}

// Params 0
// Size: 0x54, Type: bool
function isfinalpush()
{
    foreach ( var1 in level.disable_super_in_turret.paths )
    {
        if ( !isdefined( var1.getquestplunderrewardinstance ) || var1.getquestplunderrewardinstance + 1 < var1.getquestreward_checkforvalueoverride.size )
        {
            return false;
        }
    }
    
    return true;
}

// Params 1
// Size: 0xa4
function ref_1322f( var0 )
{
    level notify( "setupCheckpoint" );
    level endon( "setupCheckpoint" );
    
    if ( var0.getquestplunderrewardinstance == 0 )
    {
        var1 = level.disable_super_in_turret.getquestscalervalue;
    }
    else
    {
        var1 = int( level.disable_super_in_turret.waittill_scout_drone_defined / 1000 ) + level.disable_super_in_turret.brmini_kickplayersatcircleedge;
        setmusicstate( "br3_payload_time_added_outro" );
        
        if ( level.disable_super_in_turret.maxtime > 0 )
        {
            var1 = int( min( var1, level.disable_super_in_turret.maxtime ) );
        }
        
        level notify( "cancel_announcer_dialog" );
        thread timelimitclock();
    }
    
    scripts\mp\flags::gameflagwait( "infil_complete" );
    ref_131d4( var1 );
    ref_1313b( var1 );
}

// Params 0
// Size: 0x1f
function ref_131d6()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "infil_complete" );
    wait 1;
    ref_1318e( 1 );
}

// Params 1
// Size: 0x4d
function ref_12aa3( var0 )
{
    if ( !getquesttablerewardgroup() )
    {
        return;
    }
    
    var1 = gettime() - level.disable_super_in_turret.initsharedomnvars;
    
    if ( isdefined( var0 ) )
    {
        level.disable_super_in_turret.waittill_scout_drone_timeout = var0;
    }
    
    var2 = relic_amped_on_ai_kill();
    
    if ( var1 > var2 )
    {
        var1 = var2;
    }
    
    level.disable_super_in_turret.waittill_scout_drone_defined = var2 - var1;
}

// Params 3
// Size: 0x1c
function ref_1313c( var0, var1, var2 )
{
    var3 = "time_split_" + var1;
    game[ var0 + "_payload" ][ var3 ] = var2;
}

// Params 2
// Size: 0x1d
function relic_amped_pause( var0, var1 )
{
    var2 = "time_split_" + var1;
    var3 = game[ var0 + "_payload" ][ var2 ];
    return var3;
}

// Params 2
// Size: 0x18
function ref_1313b( var0, var1 )
{
    var2 = "time_limit_objective";
    game[ var2 ] = int( var0 * 1000 );
}

// Params 1
// Size: 0xf
function relic_amped_on_ai_kill( var0 )
{
    var1 = "time_limit_objective";
    return game[ var1 ];
}

// Params 1
// Size: 0x18
function ref_1313a( var0 )
{
    if ( !game[ "switchedsides" ] )
    {
        game[ "num_checkpoints_objective" ] = var0;
        return;
    }
}

// Params 0
// Size: 0x1f
function start_pipe_room_menu()
{
    if ( !game[ "switchedsides" ] )
    {
        game[ "num_checkpoints_objective" ] = game[ "num_checkpoints_objective" ] + 1;
        return;
    }
}

// Params 0
// Size: 0xa
function relic_amped_monitor_beeps()
{
    return game[ "num_checkpoints_objective" ];
}

// Params 0
// Size: 0x8
function getquesttablerewardgroup()
{
    var0 = 1;
    return var0;
}

// Params 0
// Size: 0x86
function getquestrewardgroupstablerewards()
{
    if ( unset_relic_gas_martyr() )
    {
        return;
    }
    
    level.ontimelimit = &scripts\engine\utility::void;
    ref_12aa5();
    setomnvar( "ui_hardpoint_timer", 0 );
    ref_1318e( 0 );
    var0 = game[ "defenders" ];
    var1 = game[ "attackers" ];
    var2 = "objective_completed";
    thread ref_14301( "finished", undefined, undefined, 2 );
    thread scripts\mp\gametypes\br::ref_1209b( var0, 2, undefined, 1, 1, 1 );
    munition_slot_gunship_emptied_message();
    ref_1225d( 0, var1 );
    ref_11ecc( var1 );
    thread scripts\mp\gametypes\br::brendgame( var1, game[ "end_reason" ][ var2 ], 0 );
}

// Params 1
// Size: 0x59
function eliminatedhudmonitor( var0 )
{
    if ( game[ "switchedsides" ] )
    {
        level thread scripts\mp\gametypes\br::handleendgamesplash( var0 );
        level thread scripts\mp\gametypes\br::setup_player_stealth( var0 );
        
        if ( istrue( level.ref_13364 ) )
        {
            level thread scripts\mp\gametypes\br::setup_player_marks( var0 );
        }
        
        if ( isdefined( level.defensefactormod ) )
        {
            wait level.defensefactormod;
        }
        
        level thread scripts\mp\gametypes\br::setup_player_stealth( var0 );
        
        if ( istrue( level.ref_13364 ) )
        {
            level thread scripts\mp\gametypes\br::setup_player_marks( var0 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x5b
function endgame_stars( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        var3 thread scripts\mp\utility\game::setuipostgamefade( 0 );
    }
    
    if ( !var1 )
    {
        wait var0;
    }
    else
    {
        wait var0 / 2;
        level notify( "give_match_bonus" );
        wait var0 / 2;
    }
    
    level notify( "round_end_finished" );
}

// Params 2
// Size: 0xcf
function relic_squadlink_onsteppedfar( var0, var1 )
{
    var2 = undefined;
    
    if ( isdefined( level.disable_super_in_turret.waittill_scout_drone_timeout ) && isdefined( level.disable_super_in_turret.waittill_scout_drone_timeout.vehicle ) && ( !var0 || var1 == "tie" ) )
    {
        var2 = level.disable_super_in_turret.waittill_scout_drone_timeout.vehicle;
    }
    else
    {
        var3 = undefined;
        
        foreach ( var5 in level.disable_super_in_turret.paths )
        {
            if ( istrue( var5.hidesmokinggunhudfromplayer ) || !isdefined( var5.vehicle ) )
            {
                continue;
            }
            
            if ( !isdefined( var3 ) || var5.getquestplunderrewardinstance > var3.getquestplunderrewardinstance )
            {
                var3 = var5;
                var6 = var5.getquestplunderrewardinstance;
            }
        }
        
        var2 = var3.vehicle;
    }
    
    return var2;
}

// Params 0
// Size: 0xa7
function ref_1426b()
{
    var0 = self.path;
    var1 = var0.idle_sfx;
    
    if ( var0.getquestplunderrewardinstance == 0 )
    {
        var2 = 1;
        var3 = 0;
    }
    else
    {
        var2 = var2.getquestreward_checkforvalueoverride[ var2.getquestplunderrewardinstance - 1 ].ref_11ea5;
        var3 = var2 - 2;
    }
    
    var4 = var2.nodes[ var2 ];
    var5 = var4.origin;
    var6 = respawningbr( var2, var2 );
    var7 = vectortoangles( var6 );
    self vehicle_teleport( var5, var7 );
    var8 = var2.nodes[ var3 ];
    var9 = var8.origin;
    var6 = respawningbr( var2, var3 );
    var10 = vectortoangles( var6 );
    var3 vehicle_teleport( var9, var10 );
    return [ var5, var7 ];
}

// Params 2
// Size: 0x80
function relic_squadlink_onbecameinvalidplayer( var0, var1 )
{
    var2 = undefined;
    
    if ( var0 == game[ "attackers" ] )
    {
        var3 = var1.nodes[ var1.nodes.size - 1 ];
        var2 = var3.origin;
    }
    else
    {
        if ( var1.getquestplunderrewardinstance == 0 )
        {
            var4 = 1;
        }
        else
        {
            var4 = var2.getquestreward_checkforvalueoverride[ var2.getquestplunderrewardinstance - 1 ].ref_11ea5;
        }
        
        var5 = var2.nodes[ var4 ];
        var4 = var5.origin;
    }
    
    return var4;
}

// Params 2
// Size: 0x146
function registerbrsquadleaderjumpcommands( var0, var1 )
{
    var3 = ( 0, 0, 0 );
    var4 = ( 0, 0, 0 );
    
    if ( var1 == game[ "defenders" ] && level.disable_super_in_turret.ref_1226a == "port" && var0.label == "A" && var0.getquestplunderrewardinstance == 1 )
    {
        var3 = ( 0, -10, 0 );
        var4 = var3;
    }
    else if ( var1 == game[ "attackers" ] && level.disable_super_in_turret.ref_1226a == "trainstation2" && var0.label == "A" )
    {
        var3 = ( 0, -10, 0 );
        var4 = var3;
    }
    else if ( var1 == game[ "attackers" ] && level.disable_super_in_turret.ref_1226a == "downtown2" && var0.label == "B" )
    {
        var3 = ( 0, -10, 0 );
        var4 = var3;
    }
    else if ( var1 == game[ "attackers" ] && level.disable_super_in_turret.ref_1226a == "downtown2" && var0.label == "A" )
    {
        var4 = ( 0, 25, 0 );
    }
    
    return [ var3, var4 ];
}

// Params 4
// Size: 0x49f
function ref_1225d( var0, var1, var2, var3 )
{
    level.ref_1225c = 1;
    level notify( "payloadComplete" );
    level notify( "ending_sequence" );
    var4 = relic_squadlink_onsteppedfar( var0, var1 );
    var5 = var4.path;
    var6 = relic_squadlink_onbecameinvalidplayer( var1, var5 );
    
    foreach ( var9, var8 in level.players )
    {
        var8 notify( "abort_killcam" );
        var8.cancelkillcam = 1;
        
        if ( var8.team == var1 )
        {
            var8 setclientomnvar( "ui_br_player_position", 1 );
        }
        
        ref_13182( var8, 0 );
        var8 freezecontrols( 1 );
        var8 clearsoundsubmix( "iw8_mp_spawn_camera" );
        var8 clearsoundsubmix( "deaths_door_mp" );
        var8 setclientomnvar( "ui_br_transition_type", 0 );
        var8 setclientomnvar( "ui_br_extended_load_screen", 0 );
        
        if ( isdefined( var8.ref_12135 ) )
        {
            var8.ref_12135 stoploopsound( self.ref_12136 );
            var8.ref_12135 delete();
            var8.ref_12135 = undefined;
            var8.ref_12136 = undefined;
        }
        
        var8 scripts\mp\gametypes\br_public::ref_126b9( var6 );
    }
    
    setomnvarforallclients( "post_game_state", 9 );
    wait 3;
    setomnvar( "scriptable_loot_hide", 1 );
    removeallcorpses();
    
    if ( level.disable_super_in_turret.getquestscaledvalue )
    {
        foreach ( var11 in level.disable_super_in_turret.getquestrewardstabletype )
        {
            var11.getquestrewardstablevaluecolumnindex hide();
            
            if ( isdefined( var11.getquestrewardstablevaluecolumnindex.turret ) )
            {
                var11.getquestrewardstablevaluecolumnindex.turret hide();
            }
        }
        
        foreach ( var11 in level.disable_super_in_turret.ref_13c1a )
        {
            var11.getquestrewardstablevaluecolumnindex hide();
        }
    }
    
    var15 = undefined;
    
    if ( var1 == game[ "attackers" ] )
    {
        var15 = spawn( "script_model", var4.origin );
        var15.angles = ( 0, var4.angles[ 1 ], 0 );
        var15 setmodel( "vfx_br_payload_checkpoint" );
        var15 unmarkkeyframedmover( 1 );
        var15 setscriptablepartstate( "checkpoint", "finish" );
    }
    else
    {
        thread contestedtime( var4 );
    }
    
    if ( var1 == game[ "attackers" ] )
    {
        if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
        {
            var16 = "mp_payload_escape4_victory_cam";
            var17 = "mp_payload_escape4_loss_cam";
            goto LOC_00000254;
        }
        
        var16 = "mp_payload_victory_cam";
        var17 = "mp_payload_loss_cam";
        var18 = var7.nodes[ var7.nodes.size - 1 ];
        var19 = var18.origin;
        var20 = respawningbr( var7, var7.nodes.size - 1 );
        var21 = vectortoangles( var20 );
    }
    else
    {
        if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
        {
            var16 = "mp_payload_escape4_loss_cam";
            var17 = "mp_payload_escape4_victory_cam";
        }
        else
        {
            var16 = "mp_payload_loss_cam";
            var17 = "mp_payload_victory_cam";
        }
        
        var19 = var17.origin;
        var21 = var17.angles;
    }
    
    var22 = registerbrsquadleaderjumpcommands( var16, var9 );
    var23 = var22[ 0 ];
    var24 = var22[ 1 ];
    var22 = undefined;
    var25 = var21 + var23;
    var26 = var21 + var24;
    var27 = spawn( "script_model", var19 );
    var27.angles = var25;
    var27 setmodel( "generic_prop_x3" );
    var27 unmarkkeyframedmover( 1 );
    var28 = spawn( "script_model", var19 );
    var28.angles = var26;
    var28 setmodel( "generic_prop_x3" );
    var28 unmarkkeyframedmover( 1 );
    var27 scriptmodelplayanim( var16, "payload_complete" );
    var28 scriptmodelplayanim( var17, "payload_complete" );
    var29 = scripts\mp\utility\teams::getteamdata( game[ "attackers" ], "players" );
    
    foreach ( var21 in var29 )
    {
        var21 thread scripts\mp\playerlogic::respawn_asspectator( var19 + ( 0, 0, 60 ), ( 0, 0, 0 ) );
        var21 scripts\mp\spectating::setdisabled();
        var21 cameralinkto( var27, "j_prop_1", 1, 1 );
    }
    
    var32 = scripts\mp\utility\teams::getteamdata( game[ "defenders" ], "players" );
    
    foreach ( var21 in var32 )
    {
        var21 thread scripts\mp\playerlogic::respawn_asspectator( var19 + ( 0, 0, 60 ), ( 0, 0, 0 ) );
        var21 scripts\mp\spectating::setdisabled();
        var21 cameralinkto( var28, "j_prop_1", 1, 1 );
    }
    
    foreach ( var21 in level.players )
    {
        if ( var21.team == var9 )
        {
            var21 setplayermusicstate( "br3_payload_completed_win" );
        }
        else
        {
            var21 setplayermusicstate( "br3_payload_completed_lose" );
        }
        
        var21 thermalvisionoff();
        var21 setsoundsubmix( "mp_br_mode_payload_completed", 0.5 );
    }
}

// Params 1
// Size: 0xa0
function contestedtime( var0 )
{
    wait 1.5;
    var1 = var0.path;
    var2 = var1.idle_sfx;
    
    if ( isdefined( var1.ref_12358 ) )
    {
        var1.ref_12358 delete();
    }
    
    foreach ( var4 in var1.pieces )
    {
        if ( isdefined( var4 ) )
        {
            var4 delete();
        }
    }
    
    if ( isdefined( var2.calloutmarkerpingvo_playpredictivepingacknowledgedcancel ) )
    {
        var2.calloutmarkerpingvo_playpredictivepingacknowledgedcancel delete();
    }
    
    var2 scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode();
    wait 1;
    
    if ( isdefined( var0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel ) )
    {
        var0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel delete();
    }
    
    var0 scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode();
}

// Params 0
// Size: 0x2b0
function toggle_fx_trap()
{
    var0 = scripts\engine\utility::getstructarray( "payloadPath", "targetname" );
    
    foreach ( var2 in var0 )
    {
        if ( !isdefined( level.disable_super_in_turret.paths ) )
        {
            level.disable_super_in_turret.paths = [];
        }
        
        var3 = level.disable_super_in_turret.paths.size;
        level.disable_super_in_turret.paths[ var3 ] = var2;
    }
    
    for ( var5 = 0; var5 < level.disable_super_in_turret.paths.size ; var5++ )
    {
        var2 = level.disable_super_in_turret.paths[ var5 ];
        var6 = "E";
        var7 = "_e";
        var8 = &"BR_PAYLOAD/PATH_E";
        
        switch ( var2.script_index )
        {
            case 0:
                var6 = "A";
                var7 = "_a";
                var8 = &"BR_PAYLOAD/PATH_A";
                break;
            case 1:
                var6 = "B";
                var7 = "_b";
                var8 = &"BR_PAYLOAD/PATH_B";
                break;
            case 2:
                var6 = "C";
                var7 = "_c";
                var8 = &"BR_PAYLOAD/PATH_C";
                break;
            case 3:
                var6 = "D";
                var7 = "_d";
                var8 = &"BR_PAYLOAD/PATH_D";
                break;
            default:
                break;
        }
        
        var2.label = var6;
        var2.iconname = var7;
        var2.ref_12201 = var8;
        var2.ref_13695 = [];
        var2.ref_13663 = [];
        var2.spawncount = [];
        var2.ref_1361e = [];
        var2.spawntime = [];
        var2.numplayers = [];
        var2.numplayers[ game[ "attackers" ] ] = 0;
        var2.numplayers[ game[ "defenders" ] ] = 0;
        var2.ref_14307 = "none";
        var2.ref_14306 = 0;
        var2.ref_142f7 = 0;
        var2.ref_142f9 = 0;
        var2.objidnum = [];
        var2.ref_12cd5 = [];
        var2.ref_11f48 = [];
        var2.pieces = [];
        var2.wait_for_computer_power = [];
        var2.ref_11f9f = 0;
        var2.ref_119d6 = 0;
        var2.ref_13bf5 = 0;
        
        if ( level.disable_super_in_turret.ref_13601 )
        {
            var2.ref_136bd = 0;
            var2.ref_13620 = spawnstruct();
            var2.ref_13620.bot_gametype_attacker_limit_for_team = 1;
            var2.ref_13620.path = var2;
        }
        
        if ( level.disable_super_in_turret.ref_13602 > -1 )
        {
            var2.ref_136bd = 0;
        }
        
        if ( level.disable_super_in_turret.getquestscaledvalue )
        {
            var2.getquestscaledvalue = [];
        }
        
        freeze_timer_at_max_time_bomb_vest( var2 );
    }
}

// Params 0
// Size: 0x17
function time_on_floor()
{
    if ( !level.disable_super_in_turret.start_drones_event )
    {
        return;
    }
    
    thread time_passed_no_target_threshold();
}

// Params 0
// Size: 0xe3
function time_passed_no_target_threshold()
{
    var0 = getentarray( "payload_oob", "targetname" );
    
    if ( var0.size == 0 )
    {
        return;
    }
    
    var1 = undefined;
    
    foreach ( var3 in level.disable_super_in_turret.paths )
    {
        foreach ( var5 in var0 )
        {
            if ( var3.initchallengeandeventglobals == var5.script_group )
            {
                var1 = var5;
                var1.index = 0;
                break;
            }
        }
        
        if ( isdefined( var1 ) )
        {
            break;
        }
    }
    
    foreach ( var3 in level.disable_super_in_turret.paths )
    {
        var3.start_drones_event = var1;
    }
    
    scripts\mp\flags::gameflagwait( "infil_complete" );
    thread ref_12285( var1 );
}

// Params 1
// Size: 0x1b
function ref_12285( var0 )
{
    var0.entstouching = [];
    thread ref_12287( var0 );
    thread ref_12286( var0 );
}

// Params 1
// Size: 0x4c
function ref_12286( var0 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    var0 endon( "IBTrigger" );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        
        if ( isdefined( var1.sq_entergulag ) && var1.sq_entergulag > 0 )
        {
            continue;
        }
        
        ref_12265( var0, var1 );
    }
}

// Params 1
// Size: 0x6f
function ref_12287( var0 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    var0 endon( "IBTrigger" );
    
    for ( ;; )
    {
        var1 = var0.entstouching;
        
        foreach ( var3 in var1 )
        {
            if ( !isdefined( var3 ) )
            {
                var0.entstouching[ var4 ] = undefined;
            }
            
            if ( isdefined( var3 ) && !var0 istouching( var3 ) )
            {
                ref_12266( var0, var3 );
            }
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x15f
function ref_12265( var0, var1 )
{
    var2 = var1 getentitynumber();
    
    if ( isdefined( var1.ref_12cce ) )
    {
        var1.ref_12cce = undefined;
    }
    
    if ( isdefined( var0.ref_13ab7 ) && isdefined( var1.owner ) && var0.ref_13ab7 != var1.owner.team )
    {
        return;
    }
    
    if ( isdefined( var0.ref_13ab7 ) && !isdefined( var1.owner ) && var0.ref_13ab7 != var1.team )
    {
        return;
    }
    
    if ( !isdefined( var1.sq_movequestlocale ) )
    {
        var1.sq_movequestlocale = [];
        
        for ( var3 = 0; var3 < level.disable_super_in_turret.paths.size ; var3++ )
        {
            var1.sq_movequestlocale[ var3 ] = 0;
        }
    }
    
    var1.sq_movequestlocale[ var0.index ] = 1;
    var0.entstouching[ var2 ] = var1;
    
    if ( !isdefined( var1.oobtriggers ) )
    {
        var1.oobtriggers = [];
    }
    
    var4 = [ var0 ];
    
    foreach ( var6 in var1.oobtriggers )
    {
        var4 = var6;
    }
    
    var1.oobtriggers = var4;
    
    if ( isdefined( var1.sq_entergulag ) )
    {
        var1.sq_entergulag++;
    }
    else
    {
        var1.sq_entergulag = 1;
    }
    
    if ( isdefined( var1.oob ) && var1.oob > 0 )
    {
        scripts\mp\outofbounds::disableoob( var1 );
        return;
    }
}

// Params 2
// Size: 0x114
function ref_12266( var0, var1 )
{
    var2 = var1 getentitynumber();
    
    if ( isdefined( var0.ref_13ab7 ) && isdefined( var1.owner ) && var0.ref_13ab7 != var1.owner.team )
    {
        return;
    }
    
    if ( isdefined( var0.ref_13ab7 ) && !isdefined( var1.owner ) && var0.ref_13ab7 != var1.team )
    {
        return;
    }
    
    if ( isdefined( var1.sq_entergulag ) && var1.sq_entergulag > 0 && var1.sq_movequestlocale[ var0.index ] )
    {
        var1.sq_movequestlocale[ var0.index ] = 0;
        var1.sq_entergulag--;
        
        foreach ( var4 in var1.sq_movequestlocale )
        {
            if ( istrue( var4 ) )
            {
                return;
            }
        }
        
        scripts\mp\outofbounds::enableoob( var1 );
    }
    
    if ( isdefined( var1.oobtriggers ) )
    {
        var1.oobtriggers = scripts\engine\utility::array_remove( var1.oobtriggers, var0 );
        
        if ( var1.oobtriggers.size == 0 )
        {
            var1.oobtriggers = undefined;
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x11e
function ref_12607( var0, var1, var2 )
{
    var3 = scripts\mp\outofbounds::getlastoobtrigger( self );
    
    if ( isdefined( var3 ) && isdefined( var3.spawntime ) )
    {
        if ( gettime() - var3.spawntime < level.disable_super_in_turret.ref_136c0 )
        {
            var4 = scripts\mp\outofbounds::getoutofboundstime( var2, self );
            var4 *= level.disable_super_in_turret.ref_136bf;
            self.oobendtime = int( gettime() + var4 * 1000 );
            thread scripts\mp\outofbounds::watchooboutoftime( self, var4 );
        }
    }
    
    scripts\mp\outofbounds::playerentercallback( var0, var1, var2 );
    self notify( "playerDelayDisableOOBOutline" );
    
    if ( !isdefined( self.ref_12269 ) )
    {
        var5 = relic_squadlink_outline_monitor( self.team );
        self.ref_12269 = scripts\mp\utility\outline::outlineenableforteam( self, var5, "outline_nodepth_red", "level_script" );
    }
    
    if ( level.disable_super_in_turret.ref_136be )
    {
        if ( isdefined( self.ref_12267 ) )
        {
            self.ref_12267 hidefromplayer( self );
            self.ref_12267 = undefined;
        }
        
        foreach ( var3 in self.oobtriggers )
        {
            if ( isdefined( var3.ref_136bc ) )
            {
                var3.ref_136bc showtoplayer( self );
                self.ref_12267 = var3.ref_136bc;
            }
        }
    }
    
    thread ref_1260a();
}

// Params 3
// Size: 0x35
function ref_12608( var0, var1, var2 )
{
    scripts\mp\outofbounds::playerexitcallback( var0, var1, var2 );
    
    if ( isdefined( self.ref_12cd3 ) )
    {
        self.ref_12cd3.alpha = 0;
    }
    
    if ( isdefined( self.ref_12269 ) )
    {
        thread ref_12537();
        return;
    }
}

// Params 0
// Size: 0x50
function ref_12537()
{
    self endon( "disconnect" );
    self notify( "playerDelayDisableOOBOutline" );
    self endon( "playerDelayDisableOOBOutline" );
    wait level.disable_super_in_turret.ref_136c1;
    scripts\mp\utility\outline::outlinedisable( self.ref_12269, self );
    self.ref_12269 = undefined;
    
    if ( isdefined( self.ref_12267 ) )
    {
        self.ref_12267 hidefromplayer( self );
        self.ref_12267 = undefined;
        return;
    }
}

// Params 0
// Size: 0x13
function headlightright()
{
    var0 = self;
    var0.sq_movequestlocale = undefined;
    var0.sq_entergulag = undefined;
}

// Params 0
// Size: 0x68
function toggle_player_settings()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "infil_complete" );
    
    foreach ( var1 in level.disable_super_in_turret.paths )
    {
        var1.trigger.playersintrigger = [];
        thread ref_144ec();
        thread ref_144ed();
    }
}

// Params 0
// Size: 0x59
function ref_144ec()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "trigger", var0 );
        
        if ( !isplayer( var0 ) )
        {
            continue;
        }
        
        if ( !var0 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        var1 = var0 getentitynumber();
        
        if ( isdefined( self.playersintrigger[ var1 ] ) )
        {
            continue;
        }
        
        self.playersintrigger[ var1 ] = var0;
        ref_12026( var0 );
    }
}

// Params 0
// Size: 0x59
function ref_144ed()
{
    for ( ;; )
    {
        foreach ( var1 in self.playersintrigger )
        {
            if ( isdefined( var1 ) && var1 scripts\cp_mp\utility\player_utility::_isalive() && var1 istouching( self ) )
            {
                continue;
            }
            
            ref_1202f( var1 );
            self.playersintrigger[ var2 ] = undefined;
        }
        
        wait 1;
    }
}

// Params 1
// Size: 0xb
function ref_12026( var0 )
{
    thread ref_12609();
}

// Params 1
// Size: 0xc
function ref_1202f( var0 )
{
    var0 notify( "left_payload_trigger" );
}

// Params 0
// Size: 0x4a
function ref_12609()
{
    level endon( "game_ended" );
    self endon( "left_payload_trigger" );
    
    for ( ;; )
    {
        wait 1;
        
        if ( !isdefined( self.ref_13bf4 ) )
        {
            self.ref_13bf4 = 0;
        }
        
        self.ref_13bf4 += 1;
        
        if ( self.ref_13bf4 % 5 == 0 )
        {
            scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "pay_5" );
        }
    }
}

// Params 0
// Size: 0xb31
function tmtyl_vip_interactions()
{
    level.disable_super_in_turret.ref_11e97 = [];
    battle_tracks_toggleoffstate( "mp_don4", "downtown2", ( 18755, -21000, -160 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "downtown2", ( 21415, -17040, -170 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "downtown2", ( 21900, -16675, -195 ), 180, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "downtown2", ( 20890, -23335, -170 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "downtown2", ( 24850, -19405, -190 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "downtown2", ( 25935, -14950, -240 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "port", ( 37075, -26140, -550 ), 150, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "port", ( 35945, -27130, -550 ), 180, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "port", ( 36375, -25765, -550 ), 180, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "port", ( 38735, -23415, -540 ), 180, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "port", ( 38530, -23595, -540 ), 180, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "port", ( 38400, -23735, -540 ), 180, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "port", ( 34305, -25675, -550 ), 180, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "trainstation2", ( -22730, -27155, -120 ), 150, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "trainstation2", ( -19540, -25000, -180 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "trainstation2", ( -13500, -21525, -320 ), 180, 120 );
    battle_tracks_toggleoffstate( "mp_don4", "trainstation2", ( -22445, -28805, -105 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "trainstation2", ( -15630, -24035, -260 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_don4", "trainstation2", ( -8735, -21455, -270 ), 275, 90 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( 1930, -7157.5, 712.5 ), 80, 160 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -253.5, -7015.5, 712.5 ), 60, 150 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -346, -6995, 712.5 ), 60, 150 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -1109.5, -6707, 712.5 ), 60, 150 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -1202.5, -6662, 712.5 ), 60, 150 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -1714, -6184, 707.5 ), 40, 128 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -1822.5, -6050, 707.5 ), 40, 128 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -4613, -977, 708.5 ), 50, 128 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -4631.5, -894.5, 708.5 ), 50, 128 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -4066, 4178, 620 ), 75, 120 );
    battle_tracks_toggleoffstate( "mp_escape4", "livingquarters", ( -3628.5, 5052, 610.5 ), 75, 120 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1217, 4405.5, 864.5 ), 85, 110 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 708, 4182, 952 ), 80, 60 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1018, 4570, 855 ), 200, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1268, 4270, 862 ), 50, 120 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1286, 4124, 866 ), 200, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1388, 3932, 862 ), 60, 120 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1402, 3744, 866 ), 200, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1492, 3364, 866 ), 200, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1592, 2974, 866 ), 200, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1648, 2812, 830 ), 60, 120 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1656, 2618, 858 ), 200, 70 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1710, 2252, 849 ), 200, 55 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1797, 2009, 853 ), 75, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1809, 1897, 853 ), 75, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1822, 1787, 853 ), 75, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1834, 1672, 853 ), 75, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1849, 1544, 853 ), 75, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1858, 1436, 853 ), 75, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1888, 1318, 853 ), 82, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1910, 1206, 853 ), 82, 75 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1934, 1093, 856 ), 90, 50 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 2000, 983, 856 ), 118, 50 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1154, 2289, 1006 ), 125, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1144, 2438, 995 ), 125, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1135, 2579, 980 ), 125, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1134, 2703, 974 ), 125, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "chemicaleng", ( 1127, 2848, 968 ), 125, 80 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( -2137, 9697.5, 669.5 ), 120, 300 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 2729, 5032, 383 ), 60, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 2912.5, 4905.5, 383 ), 200, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 2820, 4740, 383 ), 60, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 2983, 4661, 383 ), 200, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 2878.5, 4528, 383 ), 60, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3039.5, 4463, 383 ), 200, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3096, 4273, 383 ), 200, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3091, 4118, 383 ), 150, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3027.5, 4006.5, 383 ), 60, 140 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 1097, 6176, 600 ), 82, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 1038, 6257, 600 ), 82, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 998, 6356, 600 ), 82, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 971, 6463, 600 ), 82, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 202, 8582, 715 ), 260, 120 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 48, 8794, 715 ), 81, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( -44, 8870, 715 ), 81, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( -136, 8948, 715 ), 81, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( -228, 9032, 715 ), 81, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( -320, 9116, 715 ), 81, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( -400, 9184, 715 ), 81, 200 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3114, 2007, 345 ), 77, 240 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3089, 2104, 345 ), 77, 240 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3065, 2203, 345 ), 77, 240 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3035, 2313, 345 ), 77, 240 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3007, 2420, 345 ), 77, 240 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 2983, 2524, 345 ), 77, 240 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3523, 2898, 210 ), 300, 120 );
    battle_tracks_toggleoffstate( "mp_escape4", "shore", ( 3161, 3734, 210 ), 110, 160 );
}

// Params 5
// Size: 0x7a
function battle_tracks_toggleoffstate( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( level.disable_super_in_turret.ref_11e97 ) )
    {
        return;
    }
    
    if ( var0 != level.mapname || var1 != level.disable_super_in_turret.ref_1226a )
    {
        return;
    }
    
    var5 = spawn( "trigger_radius", var2, 0, var3, var4 );
    var5.targetname = "payload_no_contest_trigger";
    var5.radius = var3;
    var5.height = var4;
    level.disable_super_in_turret.ref_11e97[ level.disable_super_in_turret.ref_11e97.size ] = var5;
}

// Params 1
// Size: 0x5e, Type: bool
function getlocationnameforpoint( var0 )
{
    if ( !isdefined( var0 ) || !isplayer( var0 ) || level.disable_super_in_turret.ref_11e97.size == 0 )
    {
        return true;
    }
    
    foreach ( var2 in level.disable_super_in_turret.ref_11e97 )
    {
        if ( var0 istouching( var2 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 0
// Size: 0x1bc
function timetonextcheckpoint()
{
    scripts\mp\gametypes\br_payload_path_mp_br_mechanics_0::toggle_farah_lights( 0, "all", 0 );
    scripts\mp\gametypes\br_payload_path_mp_br_mechanics_1::toggle_farah_lights( 1, "all", 1 );
    scripts\mp\gametypes\br_payload_path_mp_br_mechanics_2::toggle_farah_lights( 2, "all", 2 );
    scripts\mp\gametypes\br_payload_path_mp_br_mechanics_3::toggle_farah_lights( 3, "all", 3 );
    scripts\mp\gametypes\br_payload_path_mp_br_mechanics_0::toggle_farah_lights( 0, "standard", 0 );
    scripts\mp\gametypes\br_payload_path_mp_br_mechanics_1::toggle_farah_lights( 1, "standard", 1 );
    scripts\mp\gametypes\br_payload_path_mp_don4_0::toggle_farah_lights( 0, "downtown", 0 );
    scripts\mp\gametypes\br_payload_path_mp_don4_1::toggle_farah_lights( 1, "downtown", 1 );
    scripts\mp\gametypes\br_payload_path_mp_don4_2::toggle_farah_lights( 2, "downtown", 2 );
    scripts\mp\gametypes\br_payload_path_mp_don4_3::toggle_farah_lights( 0, "trainstation", 3 );
    scripts\mp\gametypes\br_payload_path_mp_don4_4::toggle_farah_lights( 1, "trainstation", 4 );
    scripts\mp\gametypes\br_payload_path_mp_don4_5::toggle_farah_lights( 2, "trainstation", 5 );
    scripts\mp\gametypes\br_payload_path_mp_don4_6::toggle_farah_lights( 0, "promenade", 6 );
    scripts\mp\gametypes\br_payload_path_mp_don4_7::toggle_farah_lights( 1, "promenade", 7 );
    scripts\mp\gametypes\br_payload_path_mp_don4_8::toggle_farah_lights( 2, "promenade", 8 );
    scripts\mp\gametypes\br_payload_path_mp_don4_9::toggle_farah_lights( 0, "eastriver", 9 );
    scripts\mp\gametypes\br_payload_path_mp_don4_10::toggle_farah_lights( 1, "eastriver", 10 );
    scripts\mp\gametypes\br_payload_path_mp_don4_11::toggle_farah_lights( 2, "eastriver", 11 );
    scripts\mp\gametypes\br_payload_path_mp_don4_1::toggle_farah_lights( 0, "downtown2", 1 );
    scripts\mp\gametypes\br_payload_path_mp_don4_0::toggle_farah_lights( 1, "downtown2", 0 );
    scripts\mp\gametypes\br_payload_path_mp_don4_1::toggle_farah_lights( 0, "downtown3", 1 );
    scripts\mp\gametypes\br_payload_path_mp_don4_2::toggle_farah_lights( 1, "downtown3", 2 );
    scripts\mp\gametypes\br_payload_path_mp_don4_3::toggle_farah_lights( 0, "trainstation2", 3 );
    scripts\mp\gametypes\br_payload_path_mp_don4_4::toggle_farah_lights( 1, "trainstation2", 4 );
    scripts\mp\gametypes\br_payload_path_mp_don4_12::toggle_farah_lights( 0, "port", 12 );
    scripts\mp\gametypes\br_payload_path_mp_don4_13::toggle_farah_lights( 1, "port", 13 );
    scripts\mp\gametypes\br_payload_path_mp_escape4_3::toggle_farah_lights( 0, "livingquarters", 0 );
    scripts\mp\gametypes\br_payload_path_mp_escape4_4::toggle_farah_lights( 0, "chemicaleng", 1 );
    scripts\mp\gametypes\br_payload_path_mp_escape4_5::toggle_farah_lights( 0, "shore", 2 );
    
    if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
    {
        ref_1318d( 1, -1 );
        return;
    }
}

// Params 2
// Size: 0x57
function ref_1318d( var0, var1 )
{
    if ( var1 > 31 || var0 >= 2 )
    {
        return;
    }
    
    var2 = 5;
    var3 = var0 * 5;
    var4 = int( pow( 2, var2 ) ) - 1;
    var5 = ( var1 & var4 ) << var3;
    var6 = ~( var4 << var3 );
    var7 = getomnvar( "ui_br_paths" );
    var8 = var7 & var6;
    var9 = var8 + var5;
    setomnvar( "ui_br_paths", var9 );
}

// Params 3
// Size: 0x15a
function balloon_deposit_cash_vo_explanation( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.targetname = var0;
    var3.target = var1;
    var3.script_index = var2;
    
    if ( isdefined( var3.targetname ) )
    {
        if ( !isdefined( level.struct_class_names[ "targetname" ][ var3.targetname ] ) )
        {
            level.struct_class_names[ "targetname" ][ var3.targetname ] = [];
        }
        
        var4 = level.struct_class_names[ "targetname" ][ var3.targetname ].size;
        level.struct_class_names[ "targetname" ][ var3.targetname ][ var4 ] = var3;
    }
    
    if ( isdefined( var3.target ) )
    {
        if ( !isdefined( level.struct_class_names[ "target" ][ var3.target ] ) )
        {
            level.struct_class_names[ "target" ][ var3.target ] = [];
        }
        
        var4 = level.struct_class_names[ "target" ][ var3.target ].size;
        level.struct_class_names[ "target" ][ var3.target ][ var4 ] = var3;
    }
    
    if ( isdefined( var3.script_noteworthy ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_noteworthy" ][ var3.script_noteworthy ] ) )
        {
            level.struct_class_names[ "script_noteworthy" ][ var3.script_noteworthy ] = [];
        }
        
        var4 = level.struct_class_names[ "script_noteworthy" ][ var3.script_noteworthy ].size;
        level.struct_class_names[ "script_noteworthy" ][ var3.script_noteworthy ][ var4 ] = var3;
    }
    
    return var3;
}

// Params 2
// Size: 0xb
function ref_13929( var0, var1 )
{
    self.origin = var0;
}

// Params 8
// Size: 0xfd
function init_relic_trex( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = 2;
    
    if ( isdefined( var7 ) )
    {
        var9 = newteamhudelem( var7 );
    }
    else
    {
        var9 = newhudelem();
    }
    
    var9.elemtype = "font";
    var9.font = "default";
    var9.fontscale = var9;
    var9.basefontscale = var9;
    var9.x = 0;
    var9.y = 0;
    var9.width = 0;
    var9.height = int( level.fontheight * var9 );
    var9.xoffset = 0;
    var9.yoffset = 0;
    var9.children = [];
    var9 scripts\mp\hud_util::setparent( level.uiparent );
    var9.hidden = 0;
    var9.archived = 0;
    var9.alpha = 1;
    var9 scripts\mp\hud_util::setpoint( var3, var4, var5, var6 );
    
    if ( isdefined( var1 ) )
    {
        var9.label = var1;
    }
    
    if ( isdefined( var2 ) )
    {
        var9 setvalue( var2 );
    }
    
    if ( isdefined( var7 ) )
    {
        var9.color = var7;
    }
    
    return var9;
}

// Params 0
// Size: 0x479
function time_between_rocket_fire()
{
    var0 = 0;
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_neutral_a", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_a", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_neutral_b", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_b", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_neutral_c", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_c", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_neutral_d", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_d", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_neutral_e", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_e", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_a", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_a", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_b", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_b", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_c", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_c", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_d", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_d", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_e", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORT", "icon_waypoint_dom_e", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escorting_a", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_a", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escorting_b", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_b", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escorting_c", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_c", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escorting_d", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_d", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escorting_e", var0, "friendly", "BR_PAYLOAD/OBJ_ESCORTING", "icon_waypoint_dom_e", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_neutral_a", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_a", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_neutral_b", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_b", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_neutral_c", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_c", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_neutral_d", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_d", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_neutral_e", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_e", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_a", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_a", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_b", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_b", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_c", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_c", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_d", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_d", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halt_e", var0, "enemy", "BR_PAYLOAD/OBJ_HALT", "icon_waypoint_dom_e", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halting_a", var0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_a", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halting_b", var0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_b", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halting_c", var0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_c", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halting_d", var0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_d", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_halting_e", var0, "enemy", "BR_PAYLOAD/OBJ_HALTING", "icon_waypoint_dom_e", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_contested_a", var0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_a", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_contested_b", var0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_b", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_contested_c", var0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_c", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_contested_d", var0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_d", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_contested_e", var0, "contest", "BR_PAYLOAD/OBJ_CONTESTED", "icon_waypoint_dom_e", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_blocked_a", var0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_a", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_blocked_b", var0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_b", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_blocked_c", var0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_c", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_blocked_d", var0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_d", 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_blocked_e", var0, "contest", "BR_PAYLOAD/OBJ_BLOCKED", "icon_waypoint_dom_e", 1 );
}

// Params 1
// Size: 0xa5
function init_relic_doubletap( var0 )
{
    var1 = 0;
    var2 = 150;
    var3 = 15;
    level.teamdata[ var0 ][ "checkpoint" ] = spawnstruct();
    level.teamdata[ var0 ][ "checkpoint" ].choppersupport_modifydamage_trial = [];
    var7 = var2;
    var8 = scripts\engine\utility::ter_op( level.disable_super_in_turret.paths.size <= var1, level.disable_super_in_turret.paths.size, var1 );
    
    for ( var9 = 0; var9 < var8 ; var9++ )
    {
        var10 = level.disable_super_in_turret.paths[ var9 ];
        level.teamdata[ var0 ][ "checkpoint" ].choppersupport_modifydamage_trial[ var10.script_index ] = init_relic_damage_from_above( var0, var7, var10 );
        var7 += var3;
    }
}

// Params 3
// Size: 0x46
function ref_12206( var0, var1, var2 )
{
    var3 = relic_doubletap_helper( var2 );
    var4 = level.teamdata[ var1 ][ "checkpoint" ].choppersupport_modifydamage_trial[ var0.script_index ];
    
    if ( isdefined( var4 ) )
    {
        var4.choppergunner_refillmissiles.bar.color = var3;
        return;
    }
}

// Params 1
// Size: 0xa7
function relic_doubletap_helper( var0 )
{
    switch ( var0 )
    {
        case "red":
            return ( 1, 0, 0 );
        case "blue":
            return ( 0, 0.75, 1 );
        case "yellow":
            return ( 1, 1, 0 );
        case "green":
            return ( 0, 1, 0 );
        case "orange":
            return ( 1, 0.5, 0 );
        case "lightblue":
            return ( 0.25, 0.5, 1 );
        case "white":
        default:
            return ( 1, 1, 1 );
    }
}

// Params 3
// Size: 0x1e5
function init_relic_damage_from_above( var0, var1, var2 )
{
    var3 = 14;
    var4 = 14;
    var5 = 14;
    var6 = 140;
    var7 = var3 + var4;
    var8 = newteamhudelem( var0 );
    var8.fontscale = 1.2;
    var8.x = var3;
    var8.y = var1;
    var8.alignx = "left";
    var8.aligny = "top";
    var8.horzalign = "left_adjustable";
    var8.vertalign = "top_adjustable";
    var8.alpha = 0.5;
    var8.glowalpha = 0;
    var8.hidewheninmenu = 1;
    var8.archived = 0;
    var8.label = var2.ref_12201;
    var9 = init_tut_doors( var0, ( 1, 1, 1 ), var6, var5 );
    var9.x = var7;
    var9.y = var1;
    var9.alignx = "left";
    var9.aligny = "top";
    var9.horzalign = "left_adjustable";
    var9.vertalign = "top_adjustable";
    var9.alpha = 0.5;
    ref_132a8( var9 );
    var9.archived = 1;
    var9.hidewheninmenu = 1;
    var9.bar.archived = 1;
    var9.bar.hidewheninmenu = 1;
    var9.bar.alpha = 0.5;
    var8.choppergunner_refillmissiles = var9;
    var8.ticks = [];
    var8.med_transport_initomnvars = [];
    
    for ( var10 = 0; var10 < var2.getquestreward_checkforvalueoverride.size - 1 ; var10++ )
    {
        var8.ticks[ var10 ] = init_relic_doomslayer( var0, var7, var1, var5, var6, var2, var10 );
    }
    
    for ( var10 = 0; var10 < var2.ref_11f9e.size ; var10++ )
    {
        var8.med_transport_initomnvars[ var10 ] = init_structs_mp_br_mechanics( var0, var7, var1, var5, var6, var2, var10 );
    }
    
    return var8;
}

// Params 1
// Size: 0xa0
function last_vampire_sound( var0 )
{
    foreach ( var2 in var0.ticks )
    {
        var2 destroy();
    }
    
    var0.ticks = undefined;
    
    foreach ( var5 in var0.med_transport_initomnvars )
    {
        var5 destroy();
    }
    
    var0.med_transport_initomnvars = undefined;
    var0.choppergunner_refillmissiles.bar destroy();
    var0.choppergunner_refillmissiles.bar = undefined;
    var0.choppergunner_refillmissiles destroy();
    var0.choppergunner_refillmissiles = undefined;
    var0 destroy();
}

// Params 4
// Size: 0x7e
function ref_132a8( var0, var1, var2, var3 )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y;
    self.bar.x = self.x;
    scripts\mp\hud_util::updatebar( self.bar.frac );
}

// Params 5
// Size: 0x104
function init_tut_doors( var0, var1, var2, var3, var4 )
{
    var5 = newteamhudelem( var0 );
    var5.x = 0;
    var5.y = 0;
    var5.frac = 0;
    var5.color = var1;
    var5.sort = -2;
    var5.shader = "progress_bar_fill";
    var5 setshader( "progress_bar_fill", var2, var3 );
    var5.hidden = 0;
    
    if ( isdefined( var4 ) )
    {
        var5.flashfrac = var4;
    }
    
    var6 = newteamhudelem( var0 );
    var6.elemtype = "bar";
    var6.width = var2;
    var6.height = var3;
    var6.xoffset = 0;
    var6.yoffset = 0;
    var6.bar = var5;
    var6.children = [];
    var6.sort = -3;
    var6.color = ( 0, 0, 0 );
    var6.alpha = 0.5;
    var6 scripts\mp\hud_util::setparent( level.uiparent );
    var6 setshader( "progress_bar_bg", var2, var3 );
    var6.hidden = 0;
    return var6;
}

// Params 7
// Size: 0xd8
function init_relic_doomslayer( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = 1;
    var8 = var5.getquestreward_checkforvalueoverride[ var6 ].loot_choppers / var5.ref_13bf1;
    var9 = var1 + var8 * var4;
    var10 = newteamhudelem( var0 );
    var10.shader = "progress_bar_fill";
    var10 setshader( "progress_bar_fill", var7, var3 );
    var10.x = var9;
    var10.y = var2;
    var10.alignx = "left";
    var10.aligny = "top";
    var10.horzalign = "left_adjustable";
    var10.vertalign = "top_adjustable";
    var10.alpha = 0.5;
    var10.glowalpha = 0;
    var10.hidewheninmenu = 1;
    var10.archived = 1;
    var10.color = ( 1, 1, 1 );
    return var10;
}

// Params 7
// Size: 0xf1
function init_structs_mp_br_mechanics( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = 3;
    var8 = 4;
    var9 = var5.ref_11f9e[ var6 ].dist / var5.ref_13bf1;
    var10 = var1 + var9 * var4 - var7 / 2;
    var11 = var2 + var3 / 2 - var8 / 2;
    var12 = newteamhudelem( var0 );
    var12.shader = "progress_bar_fill";
    var12 setshader( "progress_bar_fill", var7, var8 );
    var12.x = var10;
    var12.y = var11;
    var12.alignx = "left";
    var12.aligny = "top";
    var12.horzalign = "left_adjustable";
    var12.vertalign = "top_adjustable";
    var12.alpha = 1;
    var12.glowalpha = 0;
    var12.hidewheninmenu = 1;
    var12.archived = 0;
    var12.color = relic_oneclip_monitor( var0, 0 );
    return var12;
}

// Params 0
// Size: 0x74
function has_balloon()
{
    foreach ( var1 in level.teamnamelist )
    {
        if ( isdefined( level.teamdata[ var1 ][ "checkpoint" ] ) )
        {
            foreach ( var3 in level.teamdata[ var1 ][ "checkpoint" ].choppersupport_modifydamage_trial )
            {
                last_vampire_sound( var3 );
            }
        }
    }
}

// Params 2
// Size: 0x9a
function init_trap_room_obj( var0, var1 )
{
    var2 = newhudelem();
    var2.elemtype = "font";
    var2.font = var0;
    var2.fontscale = var1;
    var2.basefontscale = var1;
    var2.x = 0;
    var2.y = 0;
    var2.width = 0;
    var2.height = int( level.fontheight * var1 );
    var2.xoffset = 0;
    var2.yoffset = 0;
    var2.children = [];
    var2 scripts\mp\hud_util::setparent( level.uiparent );
    var2.hidden = 0;
    var2.archived = 0;
    return var2;
}

// Params 3
// Size: 0x10a
function init_trap_room_interactions( var0, var1, var2 )
{
    var3 = newhudelem();
    var3.x = 0;
    var3.y = 0;
    var3.frac = 0;
    var3.color = var0;
    var3.sort = -2;
    var3.shader = "progress_bar_fill";
    var3 setshader( "progress_bar_fill", var1, var2 );
    var3.hidden = 0;
    var3.archived = 0;
    var4 = newhudelem();
    var4.elemtype = "bar";
    var4.width = var1;
    var4.height = var2;
    var4.xoffset = 0;
    var4.yoffset = 0;
    var4.bar = var3;
    var4.children = [];
    var4.sort = -3;
    var4.color = ( 0, 0, 0 );
    var4.alpha = 0.5;
    var4 scripts\mp\hud_util::setparent( level.uiparent );
    var4 setshader( "progress_bar_bg", var1 + 4, var2 + 4 );
    var4.hidden = 0;
    var4.archived = 0;
    return var4;
}

// Params 2
// Size: 0x1bd
function init_structs( var0, var1 )
{
    var0 = scripts\mp\gametypes\br_public::modifyplayer_damage( var0, 100, -100 );
    var2 = ( 0, var1[ 1 ], 0 );
    var3 = anglestoforward( var2 );
    var4 = var0 + var3 * 110;
    var5 = scripts\mp\gametypes\br_public::modifytriggerlocation( var4, 100, -100 );
    var4 = var5[ "position" ];
    var6 = vectortopitch( var5[ "normal" ] ) + 90;
    var7 = ( var6, var1[ 1 ], 0 );
    var8 = var0 + var3 * -30;
    var5 = scripts\mp\gametypes\br_public::modifytriggerlocation( var8, 100, -100 );
    var8 = var5[ "position" ];
    var6 = vectortopitch( var5[ "normal" ] ) + 90;
    var9 = ( var6, var1[ 1 ], 0 );
    var10 = spawn( "script_model", var4 );
    var10.angles = var7;
    var10 setmodel( "uk_tool_box_small_01" );
    var10 notsolid();
    var10 hide();
    var10.ref_11fa2 = var4;
    var10.ref_11fa1 = var7;
    var10.ref_11f97 = var8;
    var10.ref_11f96 = var9;
    var11 = var1[ 1 ] - 90;
    var10.scriptable = spawn( "script_model", var0 );
    var10.scriptable.angles = ( 0, var11, -1 * var6 );
    var10.scriptable setmodel( "payload_bld_barrier_constructed_01" );
    var10.scriptable unmarkkeyframedmover( 1 );
    var10.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    
    if ( var10.objidnum != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var10.objidnum, "active", var0 );
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var10.objidnum );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var10.objidnum, 1 );
        scripts\mp\objidpoolmanager::objective_set_play_intro( var10.objidnum, 0 );
        scripts\mp\objidpoolmanager::objective_set_play_outro( var10.objidnum, 0 );
        scripts\mp\objidpoolmanager::update_objective_icon( var10.objidnum, "ui_mp_br_mapmenu_icon_obstacle" );
        function_0421( var10.objidnum, 1 );
    }
    
    var10.hostdefensefactormod = 0;
    ref_11f9b( var10 );
    return var10;
}

// Params 2
// Size: 0x82
function ref_13260( var0, var1 )
{
    foreach ( var3 in var0.ref_11f9e )
    {
        if ( var1 == 0 )
        {
            var3 show();
            var3.scriptable setscriptablepartstate( "obstacle", "destroyed" );
            var3.scriptable notsolid();
        }
        
        if ( var3.getquestplunderrewardinstance == var1 )
        {
            scripts\mp\objidpoolmanager::objective_playermask_showtoall( var3.objidnum );
            continue;
        }
        
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var3.objidnum );
    }
}

// Params 0
// Size: 0xc1
function ref_1268d()
{
    foreach ( var1 in level.disable_super_in_turret.paths )
    {
        foreach ( var3 in var1.ref_11f9e )
        {
            if ( var3.getquestplunderrewardinstance == var1.getquestplunderrewardinstance )
            {
                if ( istrue( self.hostdefensefactormod ) && self.team == game[ "attackers" ] || !istrue( self.hostdefensefactormod ) && self.team == game[ "defenders" ] )
                {
                    self enableplayeruse( self );
                    self hudoutlineenableforclient( self, "outline_depth_cyan" );
                    continue;
                }
                
                self disableplayeruse( self );
                self hudoutlinedisableforclient( self );
            }
        }
    }
}

// Params 0
// Size: 0x140
function ref_144e8()
{
    var0 = 5;
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "watchObstacleUse" );
    self endon( "watchObstacleUse" );
    
    if ( !istrue( self.firstinit ) )
    {
        wait 3;
        self.firstinit = 1;
    }
    
    var1 = self;
    var1 setcursorhint( "HINT_NOICON" );
    var1 sethintonobstruction( "show" );
    var1 setusepriority( -1 );
    var1 setuseholdduration( "duration_none" );
    var1 setuserange( 100 );
    var1 sethintstring( &"BR_PAYLOAD/OBSTACLE_BUILD" );
    var1.userate = 1;
    var1.curprogress = 0;
    var1.usetime = var0;
    var1.inuse = 0;
    var1.playerusing = undefined;
    ref_11fa0( var1 );
    
    for ( ;; )
    {
        var1 waittill( "trigger", var2 );
        
        if ( istrue( var2.isjuggernaut ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                var2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/JUGG_CANNOT_BE_USED" );
            }
            
            continue;
        }
        
        if ( get_cave_combat_logic( var2 ) )
        {
            ref_13880( var2 );
            var1.playerusing = var2;
            var1 makeunusable();
            var3 = ref_144e9( var2 );
            
            if ( istrue( var1.isusable ) )
            {
                var1 makeusable();
            }
            
            var1.playerusing = undefined;
            
            if ( istrue( var3 ) )
            {
                ref_11f98( var2 );
            }
        }
    }
}

// Params 1
// Size: 0x187, Type: bool
function ref_144e9( var0 )
{
    var0 endon( "disconnect" );
    var0 endon( "joined_team" );
    var0 endon( "joined_spectators" );
    var1 = self;
    var1.id = "destroy";
    var1.userate = scripts\engine\utility::ter_op( isdefined( var0.objectivescaler ), var0.objectivescaler, 1 );
    
    if ( !istrue( self.hostdefensefactormod ) )
    {
        var1.id = "build";
        self.scriptable setscriptablepartstate( "obstacle", "building" );
    }
    
    var2 = gettime();
    
    while ( isdefined( var0 ) && var0 scripts\cp_mp\utility\player_utility::_isalive() && get_alive_able_players( var0 ) && var0 usebuttonpressed( 1 ) && istrue( var0.tuttxtbox ) )
    {
        var1.curprogress += level.framedurationseconds * var1.userate;
        
        if ( var1.curprogress >= var1.usetime )
        {
            if ( isdefined( var0 ) )
            {
                ref_138f6( var0 );
            }
            
            var1.playerusing = undefined;
            var1.curprogress = 0;
            return true;
        }
        
        var0 scripts\mp\gameobjects::updateuiprogress( var1, 1 );
        waitframe();
    }
    
    if ( self.hostdefensefactormod )
    {
        self show();
    }
    
    var1.playerusing = undefined;
    
    if ( isdefined( var0 ) )
    {
        ref_138f6( var0 );
    }
    
    jumpiftrue(istrue( self.hostdefensefactormod )) LOC_00000143;
    var3 = ( gettime() - var2 ) / 1000;
    ref_11f99( 0, var3 );
    goto LOC_00000177;
}

// Params 1
// Size: 0x2a
function ref_11f9c( var0 )
{
    self.isusable = 1;
    self makeusable();
    ref_11fa0();
    
    if ( var0 )
    {
        scripts\mp\objidpoolmanager::objective_playermask_showtoall( self.objidnum );
    }
    
    thread ref_144e8();
}

// Params 0
// Size: 0x2b
function ref_11f9b()
{
    self notify( "makeObstacleUnusable" );
    self.isusable = 0;
    self.playerusing = undefined;
    self makeunusable();
    self hudoutlinedisable();
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.objidnum );
}

// Params 1
// Size: 0xac
function ref_13880( var0 )
{
    var1 = self;
    
    if ( istrue( var0.isjuggernaut ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "allowActionSet" ) )
        {
            var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "allowActionSet" ) ]]( "juggCrateUse", 0 );
        }
    }
    else
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "allowActionSet" ) )
        {
            var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "allowActionSet" ) ]]( "crateUse", 0 );
        }
        
        var0.tuttxtbox = 1;
        
        if ( self.hostdefensefactormod )
        {
            self hide();
            thread ref_125c3( var0, "briefcase_bomb_mp" );
        }
        else
        {
            thread ref_125c0( var0, "buildable_tool_mp" );
        }
    }
    
    var0 scripts\mp\gameobjects::updateuiprogress( var1, 0 );
}

// Params 1
// Size: 0xa5
function ref_138f6( var0 )
{
    var1 = self;
    
    if ( istrue( var0.isjuggernaut ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "allowActionSet" ) )
        {
            var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "allowActionSet" ) ]]( "juggCrateUse", 1 );
        }
    }
    else if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "allowActionSet" ) )
    {
        var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "allowActionSet" ) ]]( "crateUse", 1 );
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "updateUIProgress" ) )
    {
        var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "updateUIProgress" ) ]]( var1, 0 );
    }
    
    var0.tuttxtbox = undefined;
    var0 notify( "obstacle_use_end" );
}

// Params 1
// Size: 0x17d, Type: bool
function get_cave_combat_logic( var0 )
{
    if ( !var0 scripts\common\utility::is_crate_use_allowed() )
    {
        return false;
    }
    
    if ( !var0 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( var0 isonladder() )
    {
        return false;
    }
    
    if ( isdefined( self.playerscaptured ) && isdefined( self.playerscaptured[ var0 getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( istrue( self.issquadonlycrate ) )
    {
        if ( isdefined( self.playersused ) && scripts\engine\utility::array_contains( self.playersused, var0 ) )
        {
            return false;
        }
        
        if ( var0.squadindex != self.squadindex || var0.team != self.team )
        {
            return false;
        }
    }
    
    if ( istrue( self.validate_station ) )
    {
        if ( isdefined( self.playersused ) && scripts\engine\utility::array_contains( self.playersused, var0 ) )
        {
            return false;
        }
        
        if ( var0.team != self.team )
        {
            return false;
        }
    }
    
    if ( isbot( var0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "botIsKillstreakSupported" ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
            {
                if ( [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]() != "grnd" && ![[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "botIsKillstreakSupported" ) ]]( self.cratetype ) )
                {
                    return false;
                }
            }
        }
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "isKillstreakBlockedForBots" ) )
        {
            if ( [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "isKillstreakBlockedForBots" ) ]]( self.cratetype ) )
            {
                return false;
            }
        }
    }
    
    if ( !self.isusable )
    {
        return false;
    }
    
    if ( var0 isskydiving() )
    {
        return false;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    if ( isdefined( self.playerusing ) && self.playerusing != var0 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x5c, Type: bool
function get_alive_able_players( var0 )
{
    if ( !scripts\common\utility::is_crate_use_allowed() )
    {
        return false;
    }
    
    if ( !var0 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( var0 meleebuttonpressed() )
    {
        return false;
    }
    
    if ( var0 isinexecutionvictim() )
    {
        return false;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    if ( distancesquared( var0.origin, self.origin ) >= 10000 )
    {
        return false;
    }
    
    if ( !self.isusable )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x4d3
function ref_11f98( var0 )
{
    if ( istrue( self.hostdefensefactormod ) )
    {
        self.hostdefensefactormod = 0;
        self.path.ref_11f9f++;
        self sethintstring( &"BR_PAYLOAD/OBSTACLE_BUILD" );
        ref_11f99( 1 );
        self setmodel( "uk_tool_box_small_01" );
        self.origin = self.ref_11fa2;
        self.angles = self.ref_11fa1;
        self dontinterpolate();
        self show();
        var1 = 0;
        
        if ( isdefined( self.path.vehicle.tutonplayerkilled ) && self.path.vehicle.tutonplayerkilled == self )
        {
            self.path.vehicle.tutonplayerkilled = undefined;
            self.path.vehicle.cone = undefined;
            self.path.vehicle.carriable_physics_launch = self;
            var1 = 1;
        }
        else
        {
            var2 = distance2dsquared( self.path.vehicle.origin, self.origin );
            
            if ( var2 < level.disable_super_in_turret.ref_14300 )
            {
                var1 = 1;
            }
        }
        
        if ( var1 )
        {
            ref_11f92( self.path, 0, "obstacleRemoved" );
        }
        
        foreach ( var4 in level.players )
        {
            if ( !isalive( var4 ) )
            {
                continue;
            }
            
            var4 thread scripts\mp\hud_message::showsplash( "br_payload_obstacle_removed", undefined, var0 );
        }
        
        if ( isdefined( var0 ) )
        {
            foreach ( var4 in level.teamdata[ var0.team ][ "players" ] )
            {
                var7 = getdvarint( "br_payload_obstacle_destroyed_xpOverride", 500 );
                var4 thread scripts\mp\rank::giverankxp( "br_payload_obstacle_destroyed", 500, var7, undefined );
                var4 thread scripts\mp\gametypes\br::scriptableusestate( "br_payload_obstacle_destroyed", int( 250 ), var4.currentweapon, 1 );
                var4 thread scripts\mp\rank::scoreeventpopup( "br_payload_obstacle_destroyed" );
                var4 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance( 500, "br_payload_obstacle_destroyed" );
            }
        }
        
        scripts\mp\objidpoolmanager::update_objective_ownerteam( self.objidnum, game[ "attackers" ] );
    }
    else
    {
        self.hostdefensefactormod = 1;
        self.origin = self.ref_11f97;
        self.angles = self.ref_11f96;
        self dontinterpolate();
        self sethintstring( &"BR_PAYLOAD/OBSTACLE_REMOVE" );
        self setmodel( "offhand_wm_briefcase_bomb" );
        self.scriptable setscriptablepartstate( "obstacle", "constructed" );
        
        if ( isdefined( self.path.vehicle.carriable_physics_launch ) && self.path.vehicle.carriable_physics_launch == self )
        {
            self.path.vehicle.tutonplayerkilled = self;
            self.path.vehicle.carriable_physics_launch = undefined;
        }
        
        jumpiffalse(isdefined( var4 )) LOC_0000031e;
        
        foreach ( var4 in level.teamdata[ var4.team ][ "players" ] )
        {
            var7 = getdvarint( "br_payload_obstacle_built_xpOverride", 1000 );
            var4 thread scripts\mp\rank::giverankxp( "br_payload_obstacle_built", 1000, var7, undefined );
            var4 thread scripts\mp\gametypes\br::scriptableusestate( "br_payload_obstacle_built", int( 500 ), var4.currentweapon, 1 );
            var4 thread scripts\mp\rank::scoreeventpopup( "br_payload_obstacle_built" );
            var4 thread scripts\mp\gametypes\br_analytics::deregisterscriptableinstance( 1000, "br_payload_obstacle_built" );
        }
        
        var11 = self.scriptable physics_getentityaabb();
        var12 = physics_createcontents( [ "physicscontents_player" ] );
        var13 = physics_aabbbroadphasequery( var11[ "min" ], var11[ "max" ], var12, [] );
        var14 = self.ref_11fa2 - self.ref_11f97;
        var15 = vectornormalize( var14 );
        var16 = distance( self.ref_11fa2, self.ref_11f97 );
        var17 = var16 / 2;
        var18 = self.ref_11f97 + var15 * var17;
        
        foreach ( var4 in var13 )
        {
            if ( !isdefined( var4 ) || !isalive( var4 ) )
            {
                continue;
            }
            
            var20 = var4.origin - var18;
            var21 = vectornormalize( var20 );
            var22 = var4.origin - self.ref_11f97;
            var23 = var4.origin - self.ref_11fa2;
            var24 = vectordot( var15, var22 );
            var25 = vectordot( var15, var23 );
            
            if ( !( var24 > 0 && var25 < 0 ) )
            {
                continue;
            }
            
            var26 = vectordot( var15, var21 );
            var27 = var26 * var17;
            var27 = abs( var27 );
            var28 = var17 + 35 - var27;
            var28 *= scripts\engine\utility::sign( var26 );
            var29 = var4.origin + var15 * var28;
            var29 = scripts\mp\gametypes\br_public::modifyplayer_damage( var29, 100, -100 );
            var4 setorigin( var29 );
        }
        
        scripts\mp\objidpoolmanager::update_objective_ownerteam( self.objidnum, game[ "defenders" ] );
    }
    
    ref_1318c( self.path.script_index, self.index, self.hostdefensefactormod );
    
    if ( isdefined( var4 ) )
    {
        ref_12261( var4, level.disable_super_in_turret.ref_11f9d, "obstacle" );
    }
    
    ref_11fa0();
    ref_11fa3( game[ "attackers" ] );
    ref_11fa3( game[ "defenders" ] );
}

// Params 2
// Size: 0xe4
function ref_11f99( var0, var1 )
{
    var2 = 2;
    self makeunusable();
    
    if ( var0 )
    {
        playsoundatpos( self.origin + ( 0, 0, 50 ), "payload_buildable_bomb_timer" );
        wait 2;
        self hide();
    }
    
    var3 = "destroying";
    var4 = var2;
    
    if ( isdefined( var1 ) )
    {
        if ( var1 <= 2.3 )
        {
            var3 = "building_failed5";
            var4 = 0.7;
        }
        else if ( var1 <= 3 )
        {
            var3 = "building_failed4";
            var4 = 1;
        }
        else if ( var1 <= 3.6 )
        {
            var3 = "building_failed3";
            var4 = 1.4;
        }
        else if ( var1 <= 4.3 )
        {
            var3 = "building_failed2";
            var4 = 1.7;
        }
        else
        {
            var3 = "building_failed1";
            var4 = 1.9;
        }
    }
    
    self.scriptable setscriptablepartstate( "obstacle", var3 );
    wait var4;
    
    if ( istrue( self.isusable ) )
    {
        self makeusable();
        ref_11fa0();
        return;
    }
}

// Params 2
// Size: 0x54
function relic_oneclip_monitor( var0, var1 )
{
    if ( istrue( var1 ) )
    {
        if ( var0 == game[ "attackers" ] )
        {
            return relic_doubletap_helper( "red" );
        }
        
        return relic_doubletap_helper( "blue" );
    }
    
    if ( var0 == game[ "attackers" ] )
    {
        return relic_doubletap_helper( "blue" );
    }
    
    return relic_doubletap_helper( "red" );
}

// Params 1
// Size: 0x4d
function ref_11fa3( var0 )
{
    var1 = level.teamdata[ var0 ][ "checkpoint" ].choppersupport_modifydamage_trial[ self.path.script_index ];
    
    if ( isdefined( var1 ) )
    {
        var2 = var1.med_transport_initomnvars[ self.index ];
        var2.color = relic_oneclip_monitor( var0, self.hostdefensefactormod );
        return;
    }
}

// Params 0
// Size: 0x111
function ref_11fa0()
{
    var0 = scripts\mp\utility\teams::getteamdata( game[ "attackers" ], "players" );
    var1 = scripts\mp\utility\teams::getteamdata( game[ "defenders" ], "players" );
    jumpiffalse(istrue( self.hostdefensefactormod )) LOC_000000a1;
    
    foreach ( var3 in var0 )
    {
        self enableplayeruse( var3 );
    }
    
    foreach ( var3 in var1 )
    {
        self disableplayeruse( var3 );
    }
    
    if ( var0.size > 0 )
    {
        self hudoutlineenableforclients( var0, "outline_depth_cyan" );
    }
    
    if ( var1.size > 0 )
    {
        self hudoutlinedisableforclients( var1 );
        return;
    }
    
    return;
}

// Params 4
// Size: 0x23
function ref_11f92( var0, var1, var2, var3 )
{
    thread ref_14301( var2, var3, var0 );
    
    if ( istrue( var1 ) )
    {
        ref_12194( var0.label );
        return;
    }
}

// Params 0
// Size: 0x22
function timed_laser_trap_trigger()
{
    level.disable_super_in_turret.overtime = [];
    ref_121a3();
    ref_13189( 0 );
    thread ref_11e10();
}

// Params 1
// Size: 0x68
function ref_12194( var0 )
{
    ref_121a3();
    
    if ( ref_12198() )
    {
        level.disable_super_in_turret.overtime[ var0 ] = level.disable_super_in_turret.ref_121a2 + ref_1219d();
    }
    else
    {
        level.disable_super_in_turret.overtime[ var0 ] = gettime();
    }
    
    level.disable_super_in_turret.overtime[ var0 ] += respawn_solo() * 1000;
}

// Params 0
// Size: 0xf, Type: bool
function ref_12198()
{
    var0 = ref_1219b();
    return var0 >= ref_1219d();
}

// Params 0
// Size: 0x23
function ref_1219b()
{
    if ( isdefined( level.disable_super_in_turret.ref_121a2 ) )
    {
        return ( gettime() - level.disable_super_in_turret.ref_121a2 );
    }
    
    return 0;
}

// Params 0
// Size: 0xe
function ref_1219c()
{
    return level.disable_super_in_turret.ref_12199;
}

// Params 0
// Size: 0xe
function ref_1219d()
{
    return int( ref_1219c() * 1000 );
}

// Params 0
// Size: 0xc0
function ref_121a3()
{
    var0 = ref_1219b();
    var1 = var0 / 1000;
    var2 = [ 5, 4, 3, 2, 1 ];
    
    if ( var1 < level.disable_super_in_turret.ref_1219e || ref_12198() )
    {
        var3 = var2[ 0 ];
    }
    else if ( var2 < level.disable_super_in_turret.ref_1219f )
    {
        var3 = var3[ 1 ];
    }
    else if ( var3 < level.disable_super_in_turret.ref_121a0 )
    {
        var3 = var3[ 2 ];
    }
    else if ( var3 < level.disable_super_in_turret.ref_121a1 )
    {
        var3 = var3[ 3 ];
    }
    else
    {
        var3 = var3[ 4 ];
    }
    
    level.disable_super_in_turret.ref_1219a = var3;
    ref_13188( int( var3 ) );
}

// Params 0
// Size: 0xe
function respawn_solo()
{
    return level.disable_super_in_turret.ref_1219a;
}

// Params 1
// Size: 0x17
function respawn_state_greyout( var0 )
{
    var1 = var0;
    var1 -= gettime();
    
    if ( var1 <= 0 )
    {
        var1 = 0;
    }
    
    return var1;
}

// Params 0
// Size: 0x4e
function respawn_trigger_think()
{
    var0 = gettime();
    
    foreach ( var2 in level.disable_super_in_turret.overtime )
    {
        if ( var2 > var0 )
        {
            var0 = var2;
        }
    }
    
    ref_13189( respawn_state_greyout( int( var0 ) ) );
    return int( var0 );
}

// Params 0
// Size: 0x1c
function respawn_state_ready()
{
    var0 = respawn_trigger_think();
    var0 = ( var0 - gettime() ) / 1000;
    
    if ( var0 <= 0 )
    {
        var0 = 0;
    }
    
    return var0;
}

// Params 0
// Size: 0x18
function respawn_state_hidden()
{
    var0 = respawn_trigger_think();
    var0 -= gettime();
    
    if ( var0 <= 0 )
    {
        var0 = 0;
    }
    
    return var0;
}

// Params 0
// Size: 0x8d, Type: bool
function waittill_player_uses_munition()
{
    var0 = respawn_state_ready();
    
    if ( var0 <= 0 )
    {
        return false;
    }
    
    ref_12194( "minOvertime" );
    level.timelimitoverride = 1;
    level.disable_super_in_turret.ref_121a2 = gettime();
    level notify( "start_overtime" );
    thread ref_14301( "overtime" );
    thread waittill_player_uses_scavenger_contract();
    
    while ( scripts\mp\gamelogic::gettimeremaining() <= 0 && respawn_state_ready() > 0 )
    {
        waitframe();
    }
    
    level notify( "stop_overtime" );
    ref_13189( 0 );
    level.timelimitoverride = 0;
    level.disable_super_in_turret.ref_121a2 = undefined;
    ref_121a3();
    return scripts\mp\gamelogic::gettimeremaining() > 0;
}

// Params 0
// Size: 0x15
function waittill_player_uses_scavenger_contract()
{
    level endon( "stop_overtime" );
    
    for ( ;; )
    {
        waittillframeend();
        var0 = respawn_state_ready();
        waitframe();
    }
}

// Params 0
// Size: 0x12, Type: bool
function ref_12197()
{
    return scripts\mp\gamelogic::gettimeremaining() <= 0 && respawn_state_ready() > 0;
}

// Params 0
// Size: 0x1af
function ref_12193()
{
    var0 = "scr_overtime_debug";
    setdvar( var0, 0 );
    
    for ( ;; )
    {
        while ( !getdvarint( var0, 0 ) )
        {
            wait 0.5;
        }
        
        var1 = scripts\mp\hud_util::createservertimer( "hudbig", 1 );
        var1 scripts\mp\hud_util::setpoint( "LEFTBOTTOM", undefined, 15, -80 );
        var1.color = ( 1, 0, 0 );
        var1.archived = 0;
        var1.label = &"Overtime Seconds: ";
        var2 = scripts\mp\hud_util::createservertimer( "hudbig", 1 );
        var2 scripts\mp\hud_util::setpoint( "LEFTBOTTOM", undefined, 15, -60 );
        var2.color = ( 1, 0, 0 );
        var2.archived = 0;
        var2.label = &"Overtime Seconds Max: ";
        var3 = scripts\mp\hud_util::createservertimer( "hudbig", 1 );
        var3 scripts\mp\hud_util::setpoint( "LEFTBOTTOM", undefined, 15, -40 );
        var3.color = ( 1, 0, 0 );
        var3.archived = 0;
        var3.label = &"Total Overtime: ";
        var4 = scripts\mp\hud_util::createservertimer( "hudbig", 1 );
        var4 scripts\mp\hud_util::setpoint( "LEFTBOTTOM", undefined, 15, -20 );
        var4.color = ( 1, 0, 0 );
        var4.archived = 0;
        var4.label = &"Total Overtime Max: ";
        
        while ( getdvarint( var0, 0 ) )
        {
            waitframe();
            waittillframeend();
            var1 setvalue( respawn_state_ready() );
            var2 setvalue( respawn_solo() );
            var3 setvalue( ref_1219b() / 1000 );
            var4 setvalue( ref_1219c() );
        }
        
        level notify( "stop_overtime" );
        var1 destroy();
        var2 destroy();
        var3 destroy();
        var4 destroy();
    }
}

// Params 0
// Size: 0x1e6
function timed_death()
{
    if ( !level.disable_super_in_turret.checkpoint_objective )
    {
        return;
    }
    
    var0 = [];
    
    if ( isdefined( level.disable_super_in_turret.wait_for_gl_pickup ) && level.disable_super_in_turret.wait_for_gl_pickup.size > 0 )
    {
        foreach ( var2 in level.disable_super_in_turret.wait_for_gl_pickup )
        {
            var3 = var2.script_group;
            
            if ( !isdefined( var3 ) )
            {
                continue;
            }
            
            var4 = respawndelayoverride( var3 );
            
            if ( isdefined( var4 ) )
            {
                var5 = var2.angles;
                
                if ( !isdefined( var5 ) )
                {
                    var5 = ( 0, 0, 0 );
                }
                
                var6 = easepower( "br_plunder_box", var2.origin, var5 );
                
                if ( isdefined( var6 ) )
                {
                    var6.path = var4;
                    var6.getquestplunderrewardinstance = var2.script_index;
                    
                    if ( !isdefined( var6.getquestplunderrewardinstance ) )
                    {
                        var6.getquestplunderrewardinstance = 0;
                    }
                    
                    var0 = var6;
                    var4.wait_for_computer_power[ var4.wait_for_computer_power.size ] = var6;
                }
            }
        }
    }
    
    if ( var0.size == 0 )
    {
        foreach ( var4 in level.disable_super_in_turret.paths )
        {
            foreach ( var10 in var4.wait_for_at_least_one_player_spawns_in )
            {
                var11 = var4.nodes[ var10 ].origin;
                var12 = respawningbr( var4, var10 );
                var6 = init_seq_button( var11, var12, var4.script_index );
                
                if ( isdefined( var6 ) )
                {
                    var6.path = var4;
                    var6.getquestplunderrewardinstance = var4.script_index;
                    
                    if ( !isdefined( var6.getquestplunderrewardinstance ) )
                    {
                        var6.getquestplunderrewardinstance = 0;
                    }
                    
                    var0 = var6;
                    var4.wait_for_computer_power[ var4.wait_for_computer_power.size ] = var6;
                }
            }
        }
    }
    
    thread ref_1316a( var0 );
}

// Params 1
// Size: 0x16
function ref_1316a( var0 )
{
    scripts\mp\flags::gameflagwait( "infil_complete" );
    scripts\mp\gametypes\br_armory_kiosk::ref_131c0( var0 );
}

// Params 3
// Size: 0xbd
function init_seq_button( var0, var1, var2 )
{
    var3 = 300;
    var4 = 600;
    var5 = 50;
    var6 = 100;
    var7 = vectortoangles( var1 );
    var8 = anglestoright( var7 );
    var9 = -1 * var8;
    var10 = var3;
    
    while ( var10 <= var4 )
    {
        var11 = var0 + var10 * var8;
        var12 = scripts\mp\gametypes\br_public::modifyplayer_damage( var11 );
        var13 = abs( var0[ 2 ] - var12[ 2 ] );
        
        if ( var13 < var6 )
        {
            var14 = vectortoangles( var9 );
            var15 = easepower( "br_plunder_box", var12, var14 );
            return var15;
        }
        
        var14 = var2 + var12 * var11;
        var15 = scripts\mp\gametypes\br_public::modifyplayer_damage( var14 );
        var17 = abs( var2[ 2 ] - var15[ 2 ] );
        
        if ( var17 < var8 )
        {
            var14 = vectortoangles( var10 );
            var15 = easepower( "br_plunder_box", var15, var14 );
            return var15;
        }
        
        var16 += var9;
    }
}

// Params 4
// Size: 0x1e
function isusingremotekillstreak( var0, var1, var2, var3 )
{
    isteamonlycrate( var0, var1, var2, ( 0, 1, 0 ), var3 );
}

// Params 4
// Size: 0x1e
function isspreadweapon( var0, var1, var2, var3 )
{
    isteamonlycrate( var0, var1, var2, ( 1, 1, 0 ), var3 );
}

// Params 5
// Size: 0x2a
function isteamonlycrate( var0, var1, var2, var3, var4 )
{
    for ( ;; )
    {
        if ( getdvarint( "debugPathPoint", 0 ) != var2 )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( var1 ) )
        {
        }
        
        if ( isdefined( var4 ) )
        {
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x5b
function ref_13257( var0, var1 )
{
    foreach ( var3 in var0.wait_for_computer_power )
    {
        if ( var3.getquestplunderrewardinstance == var1 )
        {
            var3 setscriptablepartstate( "br_plunder_box", "visible" );
            continue;
        }
        
        var3 setscriptablepartstate( "br_plunder_box", "hidden" );
    }
}

// Params 0
// Size: 0xbe
function toggle_in_use()
{
    var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "payload_c130_loot" );
    var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
    var0.dummymodel = "military_carepackage_01_br";
    var0.friendlymodel = undefined;
    var0.enemymodel = undefined;
    var0.mountmantlemodel = undefined;
    var0.supportsownercapture = 0;
    var0.headicon = undefined;
    var0.usepriority = -1;
    var0.usefov = 180;
    var0.friendlyuseonly = 1;
    var0.ownerusetime = 2;
    var0.otherusetime = 2;
    var0.activatecallback = &scripts\cp_mp\killstreaks\airdrop::dialog_wait_think;
    var0.capturecallback = &dialog_wait_think_civ;
    var0.destroycallback = &scripts\cp_mp\killstreaks\airdrop::dialogqueue;
    var0.ingame = &scripts\cp_mp\killstreaks\airdrop::dialogueindex;
    var0.destroyoncapture = 0;
}

// Params 1
// Size: 0x40
function dialog_wait_think_civ( var0 )
{
    if ( isdefined( self.ref_13428 ) )
    {
        self.ref_13428 setscriptablepartstate( "smoke_signal", "off", 0 );
        self.ref_13428 delete();
    }
    
    var0 thread scripts\mp\utility\points::giveunifiedpoints( "br_c130_box_open" );
    var0.ref_12cd2 = 1;
}

// Params 0
// Size: 0xa, Type: bool
function eliminate_drone_spotlight_speed()
{
    return !istrue( self.ref_12cd2 );
}

// Params 2
// Size: 0x1b
function init_relic_fastbleedout( var0, var1 )
{
    if ( var1 == "juggernaut" )
    {
        var0.ref_133ce = 1;
    }
    
    return var0;
}

// Params 0
// Size: 0x679
function tracegroundheightexfil()
{
    game[ "dialog" ][ "payload_welcome" ] = "gametype_payload";
    game[ "dialog" ][ "halftime" ] = "gametype_payload_halftime";
    game[ "dialog" ][ "timesup_120" ] = "payload_2_min";
    game[ "dialog" ][ "timesup_60" ] = "payload_60_sec";
    game[ "dialog" ][ "timesup_45" ] = "payload_45_sec";
    game[ "dialog" ][ "timesup_20" ] = "payload_20_sec";
    game[ "dialog" ][ "timesup_10" ] = "payload_10_sec";
    game[ "dialog" ][ "payload_oob" ] = "payload_out";
    game[ "dialog" ][ "redeploy" ] = "payload_attack_prepare";
    game[ "dialog" ][ "contract_acquired" ] = "contract_acquired";
    game[ "dialog" ][ "contract_complete" ] = "contract_complete";
    game[ "dialog" ][ "contract_fail" ] = "contract_fail";
    game[ "dialog" ][ "attack_intro1" ] = "gametype_desc_payload_attack";
    game[ "dialog" ][ "attack_intro2" ] = "gametype_desc_payload_attack2";
    game[ "dialog" ][ "attack_securing_a" ] = "payload_attack_alpha_move";
    game[ "dialog" ][ "attack_securing_b" ] = "payload_attack_bravo_move";
    game[ "dialog" ][ "attack_losing_a" ] = "payload_attack_a_back";
    game[ "dialog" ][ "attack_losing_b" ] = "payload_attack_b_back";
    game[ "dialog" ][ "attack_contested_a" ] = "payload_attack_a_contest";
    game[ "dialog" ][ "attack_contested_b" ] = "payload_attack_b_contest";
    game[ "dialog" ][ "attack_blocked_a" ] = "payload_attack_a_blocked";
    game[ "dialog" ][ "attack_blocked_b" ] = "payload_attack_b_blocked";
    game[ "dialog" ][ "attack_obstacle_a" ] = "payload_obs_a";
    game[ "dialog" ][ "attack_obstacle_b" ] = "payload_obs_b";
    game[ "dialog" ][ "attack_secured1_a" ] = [ "payload_attack_a_success", "payload_attack_sat_1" ];
    game[ "dialog" ][ "attack_secured1_b" ] = [ "payload_attack_b_success", "payload_attack_sat_1" ];
    game[ "dialog" ][ "attack_secured2_a" ] = [ "payload_attack_a_success", "payload_attack_sat_2" ];
    game[ "dialog" ][ "attack_secured2_b" ] = [ "payload_attack_b_success", "payload_attack_sat_2" ];
    game[ "dialog" ][ "attack_secured3_a" ] = [ "payload_attack_path_a", "payload_attack_sat_3" ];
    game[ "dialog" ][ "attack_secured3_b" ] = [ "payload_attack_path_b", "payload_attack_sat_3" ];
    game[ "dialog" ][ "payload_attack_a_success" ] = "payload_attack_a_success";
    game[ "dialog" ][ "payload_attack_b_success" ] = "payload_attack_b_success";
    game[ "dialog" ][ "payload_attack_path_a" ] = "payload_attack_path_a";
    game[ "dialog" ][ "payload_attack_path_b" ] = "payload_attack_path_b";
    game[ "dialog" ][ "payload_attack_sat_1" ] = "payload_attack_sat_1";
    game[ "dialog" ][ "payload_attack_sat_2" ] = "payload_attack_sat_2";
    game[ "dialog" ][ "payload_attack_sat_3" ] = "payload_attack_sat_3";
    game[ "dialog" ][ "attack_overtime" ] = "payload_attack_overtime";
    game[ "dialog" ][ "attack_near1_a" ] = "payload_attack_a_near1";
    game[ "dialog" ][ "attack_near1_b" ] = "payload_attack_b_near1";
    game[ "dialog" ][ "attack_near2_a" ] = "payload_attack_a_near2";
    game[ "dialog" ][ "attack_near2_b" ] = "payload_attack_b_near2";
    game[ "dialog" ][ "attack_near3_a" ] = "payload_attack_a_near3";
    game[ "dialog" ][ "attack_near3_b" ] = "payload_attack_b_near3";
    game[ "dialog" ][ "attack_finished" ] = "payload_attack_win";
    game[ "dialog" ][ "attack_stopped" ] = "payload_attack_lose";
    game[ "dialog" ][ "defend_intro1" ] = "gametype_desc_payload_defend";
    game[ "dialog" ][ "defend_intro2" ] = "gametype_desc_payload_defend2";
    game[ "dialog" ][ "defend_losing_a" ] = "payload_defend_a_move";
    game[ "dialog" ][ "defend_losing_b" ] = "payload_defend_b_move";
    game[ "dialog" ][ "defend_securing_a" ] = "payload_defend_a_retreat";
    game[ "dialog" ][ "defend_securing_b" ] = "payload_defend_b_retreat";
    game[ "dialog" ][ "defend_contested_a" ] = "payload_defend_a_contest";
    game[ "dialog" ][ "defend_contested_b" ] = "payload_defend_b_contest";
    game[ "dialog" ][ "defend_blocked_a" ] = "payload_defend_a_block";
    game[ "dialog" ][ "defend_blocked_b" ] = "payload_defend_b_block";
    game[ "dialog" ][ "defend_obstacle_a" ] = "payload_defend_a_destroy";
    game[ "dialog" ][ "defend_obstacle_b" ] = "payload_defend_b_destroy";
    game[ "dialog" ][ "defend_lost1_a" ] = [ "payload_defend_cross_fail1", "payload_defend_sat_1" ];
    game[ "dialog" ][ "defend_lost1_b" ] = [ "payload_defend_cross_fail1", "payload_defend_sat_1" ];
    game[ "dialog" ][ "defend_lost2_a" ] = [ "payload_defend_cross_fail2", "payload_defend_sat_2" ];
    game[ "dialog" ][ "defend_lost2_b" ] = [ "payload_defend_cross_fail2", "payload_defend_sat_2" ];
    game[ "dialog" ][ "defend_lost3_a" ] = [ "payload_defend_path_a", "payload_defend_sat_3" ];
    game[ "dialog" ][ "defend_lost3_b" ] = [ "payload_defend_path_b", "payload_defend_sat_3" ];
    game[ "dialog" ][ "payload_defend_cross_fail1" ] = "payload_defend_cross_fail1";
    game[ "dialog" ][ "payload_defend_cross_fail2" ] = "payload_defend_cross_fail2";
    game[ "dialog" ][ "payload_defend_path_a" ] = "payload_defend_path_a";
    game[ "dialog" ][ "payload_defend_path_b" ] = "payload_defend_path_b";
    game[ "dialog" ][ "payload_defend_sat_1" ] = "payload_defend_sat_1";
    game[ "dialog" ][ "payload_defend_sat_2" ] = "payload_defend_sat_2";
    game[ "dialog" ][ "payload_defend_sat_3" ] = "payload_defend_sat_3";
    game[ "dialog" ][ "defend_overtime" ] = "payload_defend_overtime";
    game[ "dialog" ][ "defend_near1_a" ] = "payload_defend_a_near1";
    game[ "dialog" ][ "defend_near1_b" ] = "payload_defend_b_near1";
    game[ "dialog" ][ "defend_near2_a" ] = "payload_defend_a_near2";
    game[ "dialog" ][ "defend_near2_b" ] = "payload_defend_b_near2";
    game[ "dialog" ][ "defend_near3_a" ] = "payload_defend_a_near3";
    game[ "dialog" ][ "defend_near3_b" ] = "payload_defend_b_near3";
    game[ "dialog" ][ "defend_stopped" ] = "payload_defend_win";
    game[ "dialog" ][ "defend_finished" ] = "payload_defend_lose";
    game[ "dialog" ][ "round_success" ] = undefined;
    game[ "dialog" ][ "round_failure" ] = undefined;
    game[ "dialog" ][ "round_draw" ] = undefined;
}

// Params 4
// Size: 0x392
function ref_14301( var0, var1, var2, var3 )
{
    if ( !isdefined( var0 ) )
    {
        var2.ref_14307 = "none";
        var2.ref_14306 = gettime() + level.disable_super_in_turret.ref_14305;
        var2.ref_142f9 = gettime() + level.disable_super_in_turret.ref_142f8;
        return;
    }
    
    if ( isdefined( var3 ) )
    {
        wait var3;
    }
    
    var4 = ref_1332c( var0 );
    var5 = isdefined( var2 ) && var2.ref_14307 == var0;
    
    if ( !var4 && var5 && isdefined( var2 ) && var2.ref_14306 > gettime() && var2.ref_142f9 > gettime() )
    {
        var2.ref_142f7 = gettime() + level.disable_super_in_turret.ref_142f6;
        return;
    }
    
    if ( !var4 && !var5 && isdefined( var2 ) && var2.ref_142f7 > gettime() )
    {
        var2.ref_142f9 = gettime() + level.disable_super_in_turret.ref_142f8;
        var2.ref_14306 = gettime() + level.disable_super_in_turret.ref_142ff;
        return;
    }
    
    var6 = var5 && isdefined( var2 ) && var2.ref_142f9 <= gettime();
    var7 = undefined;
    var8 = undefined;
    var9 = var4;
    var10 = var4;
    var11 = undefined;
    
    switch ( var0 )
    {
        case "forward":
            var7 = "attack_securing" + var2.iconname;
            var8 = "defend_losing" + var2.iconname;
            
            if ( var6 )
            {
                var10 = 1;
            }
            
            break;
        case "reverse":
            var7 = "attack_losing" + var2.iconname;
            var8 = "defend_securing" + var2.iconname;
            
            if ( var6 )
            {
                var9 = 1;
            }
            
            break;
        case "contested":
            var7 = "attack_contested" + var2.iconname;
            var8 = "defend_contested" + var2.iconname;
            
            if ( var6 )
            {
                var9 = 1;
            }
            
            break;
        case "blocked":
            var7 = "attack_blocked" + var2.iconname;
            break;
        case "obstacleRemoved":
            var7 = "attack_obstacle" + var2.iconname;
            var8 = "defend_obstacle" + var2.iconname;
            break;
        case "checkpoint":
            var7 = "attack_secured" + var1 + var2.iconname;
            var8 = "defend_lost" + var1 + var2.iconname;
            var11 = 2;
            break;
        case "overtime":
            var7 = "attack_overtime";
            var8 = "defend_overtime";
            break;
        case "near":
            var7 = "attack_near" + var1 + var2.iconname;
            var8 = "defend_near" + var1 + var2.iconname;
            
            if ( var6 )
            {
                var10 = 1;
            }
            
            break;
        case "finished":
            var7 = "attack_finished";
            var8 = "defend_finished";
            break;
        case "stopped":
            var7 = "attack_stopped";
            var8 = "defend_stopped";
            break;
        default:
            return;
    }
    
    if ( var9 )
    {
        thread watchweapondrop( var7, game[ "attackers" ], 1, var11, undefined, 1 );
    }
    else if ( isdefined( var7 ) )
    {
        thread watchweapondrop( var7, game[ "attackers" ], 1, var11, undefined, 1, var2 );
    }
    
    if ( var10 )
    {
        thread watchweapondrop( var8, game[ "defenders" ], 1, var11, undefined, 1 );
    }
    else if ( isdefined( var8 ) )
    {
        thread watchweapondrop( var8, game[ "defenders" ], 1, var11, undefined, 1, var2 );
    }
    
    if ( isdefined( var2 ) )
    {
        var2.ref_14307 = var0;
        var2.ref_142f7 = gettime() + level.disable_super_in_turret.ref_142f6;
        var2.ref_14306 = gettime() + level.disable_super_in_turret.ref_14305;
        
        if ( !var5 || var6 )
        {
            var2.ref_142f9 = gettime() + level.disable_super_in_turret.ref_142f8;
            return;
        }
        
        return;
    }
}

// Params 7
// Size: 0x8a
function watchweapondrop( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( isarray( game[ "dialog" ][ var0 ] ) )
    {
        for ( var7 = 0; var7 < game[ "dialog" ][ var0 ].size ; var7++ )
        {
            var8 = game[ "dialog" ][ var0 ][ var7 ];
            
            if ( isdefined( var6 ) )
            {
                watchweapondeathordisconnect( var8, var1, var6, var3 );
            }
            else
            {
                scripts\mp\gametypes\br_public::dmztut_luicallback( var8, var1, var2, var3, var4, var5 );
            }
            
            waitframe();
        }
        
        return;
    }
    
    if ( isdefined( var6 ) )
    {
        watchweapondeathordisconnect( var0, var1, var6, var3 );
        return;
    }
    
    scripts\mp\gametypes\br_public::dmztut_luicallback( var0, var1, var2, var3, var4, var5 );
}

// Params 1
// Size: 0x41, Type: bool
function ref_1332c( var0 )
{
    switch ( var0 )
    {
        case "obstacleRemoved":
        case "finished":
        case "checkpoint":
        case "stopped":
        case "overtime":
            return true;
        default:
            break;
    }
    
    return false;
}

// Params 4
// Size: 0x61
function watchweapondeathordisconnect( var0, var1, var2, var3 )
{
    if ( !isdefined( game[ "dialog" ][ var0 ] ) )
    {
        return;
    }
    
    var4 = scripts\mp\utility\teams::getteamdata( var1, "players" );
    
    for ( var5 = 0; var5 < var4.size ; var5++ )
    {
        var6 = var4[ var5 ];
        var7 = ref_12575( var6 );
        
        if ( isdefined( var7 ) && var2 != var7 )
        {
            continue;
        }
        
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var0, var6, 1, 1, var3 );
    }
}

// Params 0
// Size: 0x2f
function ref_1260a()
{
    self endon( "disconnect" );
    
    if ( istrue( self.ref_142f5 ) )
    {
        return;
    }
    
    self.ref_142f5 = 1;
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "payload_oob", self );
    wait 5;
    self.ref_142f5 = undefined;
}

// Params 0
// Size: 0x275
function timelimitclock()
{
    level endon( "cancel_announcer_dialog" );
    var0 = 0;
    var1 = 0;
    var2 = 0;
    var3 = 0;
    var4 = 0;
    var5 = scripts\engine\utility::ter_op( scripts\mp\utility\game::isanymlgmatch(), 5, 2 );
    
    while ( game[ "state" ] == "playing" )
    {
        if ( scripts\mp\utility\game::gettimelimit() == 0 )
        {
            waitframe();
            continue;
        }
        
        if ( !level.timerstopped && scripts\mp\utility\game::gettimelimit() && !istrue( level.bombsplanted ) )
        {
            var6 = scripts\mp\gamelogic::gettimeremaining() / 1000;
            var7 = int( var6 + 0.5 );
            
            if ( game[ "switchedsides" ] && !isfinalpush() )
            {
                var8 = scripts\mp\gamelogic::checkdefaultjiprules();
                
                if ( !isdefined( level.nojip ) || var8 != level.nojip )
                {
                    setnojiptime( var8, var8 );
                    level.nojip = var8;
                }
            }
            
            var9 = 0;
            
            if ( var5 == 2 && var7 % 2 == 1 )
            {
                var9 = 1;
            }
            
            if ( !var0 && ( var9 == 1 && var7 == 121 || var9 == 0 && var7 == 120 ) )
            {
                scripts\mp\gametypes\br_public::brleaderdialog( "timesup_120", 0, undefined, 1 );
                var0 = 1;
            }
            else if ( !var1 && ( var9 == 1 && var7 == 61 || var9 == 0 && var7 == 60 ) )
            {
                scripts\mp\gametypes\br_public::brleaderdialog( "timesup_60", 0, undefined, 1 );
                var1 = 1;
            }
            else if ( !var2 && ( var9 == 0 && var7 == 46 || var9 == 1 && var7 == 45 ) )
            {
                scripts\mp\gametypes\br_public::brleaderdialog( "timesup_45", 0, undefined, 1 );
                var2 = 1;
            }
            else if ( !var3 && ( var9 == 1 && var7 == 21 || var9 == 0 && var7 == 20 ) )
            {
                scripts\mp\gametypes\br_public::brleaderdialog( "timesup_20", 0, undefined, 1 );
                setmusicstate( "br3_payload_20_sec_left" );
                var3 = 1;
            }
            else if ( !var4 && ( var9 == 1 && var7 == 11 || var9 == 0 && var7 == 10 ) )
            {
                scripts\mp\gametypes\br_public::brleaderdialog( "timesup_10", 0, undefined, 1 );
                var4 = 1;
            }
            
            if ( var7 <= 10 || var7 <= 30 && var7 % var5 == var9 )
            {
                level notify( "match_ending_very_soon" );
                var10 = 1;
                
                if ( var7 == 0 )
                {
                    break;
                }
                
                if ( isdefined( level.overridetimelimitclock ) && level.overridetimelimitclock < var6 )
                {
                    var9 = 0;
                }
                
                if ( var9 )
                {
                    var11 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc( var5 );
                    playsoundatpos( ( 0, 0, 0 ), var11 );
                }
            }
            
            if ( var5 - floor( var5 ) >= 0.05 )
            {
                wait var5 - floor( var5 );
                continue;
            }
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x9f
function technical_initdamage()
{
    if ( !level.disable_super_in_turret.getquestscaledvalue )
    {
        return;
    }
    
    setomnvar( "requires_scriptmover_ladder_checks", 1 );
    ref_13231( level.disable_super_in_turret.getquestrewardstabletype, "buildable_checkpoint", "buildable_checkpoint_clipbrush", "checkpoint_01_anim", "iw8_br_payload_raise_bunker", &"BR_PAYLOAD/PURCHASE_BUNKER", &"BR_PAYLOAD/PURCHASE_BUNKER_DISABLED", level.disable_super_in_turret.getpropsize, "ui_mp_br_mapmenu_icon_bunker" );
    ref_13231( level.disable_super_in_turret.ref_13c1a, "buildable_guardtower", "buildable_guardtower_clipbrush", "guardtower_01_anim", "iw8_br_payload_raise_tower", &"BR_PAYLOAD/PURCHASE_TOWER", &"BR_PAYLOAD/PURCHASE_TOWER_DISABLED", level.disable_super_in_turret.getquesttimefrac, "ui_mp_br_mapmenu_icon_tower" );
    toggle_in_use();
}

// Params 9
// Size: 0x2ac
function ref_13231( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = scripts\engine\utility::getstructarray( var1, "targetname" );
    }
    
    foreach ( var10 in var0 )
    {
        if ( !isdefined( var10.angles ) )
        {
            var10.angles = ( 0, 0, 0 );
        }
        
        var10.ref_11c75 = var3;
        var10.helistoreplunder = var2;
        var10.ref_13931 = var1;
        var10.ref_129f0 = var4;
        var10.ref_1293f = 0;
        var11 = spawn( "script_model", var10.origin );
        var11.angles = var10.angles;
        var11 setmodel( "tag_origin" );
        var11 hide();
        var11.ref_14082 = var5;
        var11.price = var7;
        var11.loc = var10;
        var10.getquestrewardstablevaluecolumnindex = var11;
        var11.scriptable = spawn( "script_model", var10.origin );
        var11.scriptable.angles = var10.angles;
        var11.scriptable setmodel( "military_hq_crate_02_payload" );
        var11.scriptable unmarkkeyframedmover( 1 );
        var11.scriptable setscriptablepartstate( "main", "idle" );
        var12 = var11.scriptable;
        var12.ref_14082 = var6;
        var12.price = var7;
        var12.loc = var10;
        var10.getquestrewardtier = var12;
        var10.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
        
        if ( var10.objidnum != -1 )
        {
            scripts\mp\objidpoolmanager::objective_add_objective( var10.objidnum, "active", var10.origin );
            scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var10.objidnum );
            scripts\mp\objidpoolmanager::update_objective_setbackground( var10.objidnum, 1 );
            scripts\mp\objidpoolmanager::objective_set_play_intro( var10.objidnum, 0 );
            scripts\mp\objidpoolmanager::objective_set_play_outro( var10.objidnum, 0 );
            scripts\mp\objidpoolmanager::update_objective_icon( var10.objidnum, var8 );
            scripts\mp\objidpoolmanager::update_objective_ownerteam( var10.objidnum, game[ "defenders" ] );
            function_0421( var10.objidnum, 1 );
        }
        
        var13 = 0;
        
        if ( isdefined( var10.script_group ) )
        {
            var13 = var10.script_group;
        }
        else
        {
            var10.script_group = var13;
        }
        
        var14 = respawndelayoverride( var13 );
        
        if ( isdefined( var14 ) )
        {
            var15 = var14.getquestscaledvalue.size;
            
            if ( isdefined( var10.script_index ) )
            {
                var15 = var10.script_index;
            }
            else
            {
                var10.script_index = var15;
            }
            
            if ( !isdefined( var14.getquestscaledvalue[ var15 ] ) )
            {
                var14.getquestscaledvalue[ var15 ] = [];
            }
            
            var16 = var14.getquestscaledvalue[ var15 ].size;
            var14.getquestscaledvalue[ var15 ][ var16 ] = var10;
        }
    }
}

// Params 2
// Size: 0x174
function ref_1286a( var0, var1 )
{
    if ( !level.disable_super_in_turret.getquestscaledvalue )
    {
        return;
    }
    
    var2 = var0 - 1;
    scripts\mp\flags::gameflagwait( "infil_complete" );
    
    if ( isdefined( var1 ) )
    {
        if ( var0 > 0 && isdefined( var1.getquestscaledvalue[ var2 ] ) )
        {
            foreach ( var4 in var1.getquestscaledvalue[ var2 ] )
            {
                if ( !istrue( var4.ref_1293f ) )
                {
                    ref_1392d( var4 );
                }
            }
        }
        
        if ( isdefined( var1.getquestscaledvalue[ var0 ] ) )
        {
            foreach ( var7, var4 in var1.getquestscaledvalue[ var0 ] )
            {
                ref_1392e( var4 );
            }
            
            return;
        }
        
        return;
    }
    
    foreach ( var4 in level.disable_super_in_turret.paths )
    {
        if ( var6 > 0 && isdefined( var4.getquestscaledvalue[ var7 ] ) )
        {
            foreach ( var4 in var4.getquestscaledvalue[ var7 ] )
            {
                if ( !istrue( var4.ref_1293f ) )
                {
                    ref_1392d( var4 );
                }
            }
        }
        
        if ( isdefined( var4.getquestscaledvalue[ var6 ] ) )
        {
            foreach ( var4 in var4.getquestscaledvalue[ var6 ] )
            {
                ref_1392e( var4 );
            }
        }
    }
}

// Params 0
// Size: 0x121
function ref_13932()
{
    var0 = 5;
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "makeStructureUnusable" );
    self notify( "structureWatchUse" );
    self endon( "structureWatchUse" );
    var1 = self;
    var1 setcursorhint( "HINT_NOICON" );
    var1 sethintonobstruction( "show" );
    var1 setusepriority( -1 );
    var1 setuseholdduration( "duration_none" );
    var1 sethintstring( var1.ref_14082 );
    var1 sethintstringparams( var1.price );
    var1.userate = 1;
    var1.curprogress = 0;
    var1.usetime = var0;
    var1.inuse = 0;
    var1.playerusing = undefined;
    
    for ( ;; )
    {
        var1 waittill( "trigger", var2 );
        
        if ( istrue( var2.isjuggernaut ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                var2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/JUGG_CANNOT_BE_USED" );
            }
            
            continue;
        }
        
        if ( ref_1392a( var1, var2 ) )
        {
            var3 = int( var1.price / 100 );
            var2 scripts\mp\gametypes\br_plunder::playersetplundercount( var2.plundercount - var3 );
            ref_1361f( var1.loc, var2 );
            return;
        }
    }
}

// Params 1
// Size: 0x198, Type: bool
function ref_1392a( var0 )
{
    if ( !var0 scripts\common\utility::is_crate_use_allowed() )
    {
        return false;
    }
    
    if ( !var0 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( var0 isonladder() )
    {
        return false;
    }
    
    if ( isdefined( self.playerscaptured ) && isdefined( self.playerscaptured[ var0 getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( istrue( self.issquadonlycrate ) )
    {
        if ( isdefined( self.playersused ) && scripts\engine\utility::array_contains( self.playersused, var0 ) )
        {
            return false;
        }
        
        if ( var0.squadindex != self.squadindex || var0.team != self.team )
        {
            return false;
        }
    }
    
    if ( istrue( self.validate_station ) )
    {
        if ( isdefined( self.playersused ) && scripts\engine\utility::array_contains( self.playersused, var0 ) )
        {
            return false;
        }
        
        if ( var0.team != self.team )
        {
            return false;
        }
    }
    
    if ( isbot( var0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "botIsKillstreakSupported" ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGameType" ) )
            {
                if ( [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGameType" ) ]]() != "grnd" && ![[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "botIsKillstreakSupported" ) ]]( self.cratetype ) )
                {
                    return false;
                }
            }
        }
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "isKillstreakBlockedForBots" ) )
        {
            if ( [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "isKillstreakBlockedForBots" ) ]]( self.cratetype ) )
            {
                return false;
            }
        }
    }
    
    if ( !self.isusable )
    {
        return false;
    }
    
    if ( var0 isskydiving() )
    {
        return false;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    if ( isdefined( self.playerusing ) && self.playerusing != var0 )
    {
        return false;
    }
    
    var1 = int( self.price / 100 );
    
    if ( var0.plundercount < var1 )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x1fd
function ref_1392e()
{
    self.getquestrewardstablevaluecolumnindex show();
    self.getquestrewardstablevaluecolumnindex.isusable = 1;
    self.getquestrewardtier.isusable = 1;
    self.getquestrewardstablevaluecolumnindex.scriptable setscriptablepartstate( "main", "idle" );
    self.getquestrewardstablevaluecolumnindex makeusable();
    self.getquestrewardtier makeusable();
    var0 = int( self.getquestrewardstablevaluecolumnindex.price / 100 );
    var1 = scripts\mp\utility\teams::getteamdata( game[ "attackers" ], "players" );
    
    foreach ( var3 in var1 )
    {
        self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient( var3 );
        self.getquestrewardtier disableplayeruse( var3 );
        self.getquestrewardstablevaluecolumnindex disableplayeruse( var3 );
    }
    
    var5 = scripts\mp\utility\teams::getteamdata( game[ "defenders" ], "players" );
    
    foreach ( var3 in var5 )
    {
        var7 = isdefined( var3.plundercount ) && var3.plundercount >= var0;
        var8 = !istrue( self.ref_1293f );
        
        if ( var8 && var7 == 0 )
        {
            self.getquestrewardstablevaluecolumnindex disableplayeruse( var3 );
            self.getquestrewardtier enableplayeruse( var3 );
            self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient( var3 );
            continue;
        }
        
        self.getquestrewardstablevaluecolumnindex enableplayeruse( var3 );
        self.getquestrewardtier disableplayeruse( var3 );
        
        if ( var8 && var7 )
        {
            self.getquestrewardstablevaluecolumnindex.scriptable hudoutlineenableforclient( var3, "outline_depth_cyan" );
            continue;
        }
        
        self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient( var3 );
    }
    
    scripts\mp\objidpoolmanager::update_objective_ownerteam( self.getquestrewardstablevaluecolumnindex.loc.objidnum, game[ "defenders" ] );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.getquestrewardstablevaluecolumnindex.loc.objidnum );
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( self.getquestrewardstablevaluecolumnindex.loc.objidnum, game[ "defenders" ] );
    thread ref_13932();
    thread ref_13932();
}

// Params 0
// Size: 0xa6
function ref_1392d()
{
    self.getquestrewardstablevaluecolumnindex notify( "makeStructureUnusable" );
    self.getquestrewardtier notify( "makeStructureUnusable" );
    self.getquestrewardstablevaluecolumnindex.isusable = 0;
    self.getquestrewardtier.isusable = 0;
    self.getquestrewardstablevaluecolumnindex.scriptable setscriptablepartstate( "main", "idle" );
    self.getquestrewardstablevaluecolumnindex makeunusable();
    self.getquestrewardtier makeunusable();
    ref_13930( self.getquestrewardstablevaluecolumnindex );
    ref_13930( self.getquestrewardtier );
    ref_1392b( self.getquestrewardstablevaluecolumnindex.scriptable );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.getquestrewardstablevaluecolumnindex.loc.objidnum );
    self.getquestrewardstablevaluecolumnindex hide();
}

// Params 0
// Size: 0x74
function ref_13930()
{
    var0 = scripts\mp\utility\teams::getteamdata( game[ "attackers" ], "players" );
    var1 = scripts\mp\utility\teams::getteamdata( game[ "defenders" ], "players" );
    
    foreach ( var3 in var1 )
    {
        self enableplayeruse( var3 );
    }
    
    foreach ( var3 in var0 )
    {
        self disableplayeruse( var3 );
    }
}

// Params 0
// Size: 0x43
function ref_1392b()
{
    var0 = scripts\mp\utility\teams::getteamdata( game[ "attackers" ], "players" );
    var1 = scripts\mp\utility\teams::getteamdata( game[ "defenders" ], "players" );
    
    if ( var0.size > 0 )
    {
        self hudoutlinedisableforclients( var0 );
    }
    
    if ( var1.size > 0 )
    {
        self hudoutlinedisableforclients( var1 );
        return;
    }
}

// Params 0
// Size: 0x84
function ref_126e0()
{
    if ( !level.disable_super_in_turret.getquestscaledvalue )
    {
        return;
    }
    
    if ( self.team == game[ "defenders" ] )
    {
        foreach ( var1 in level.disable_super_in_turret.getquestrewardstabletype )
        {
            ref_126df( var1 );
        }
        
        foreach ( var1 in level.disable_super_in_turret.ref_13c1a )
        {
            ref_126df( var1 );
        }
        
        return;
    }
}

// Params 1
// Size: 0xa8
function ref_126df( var0 )
{
    if ( var0.ref_1293f == 0 )
    {
        var1 = int( var0.getquestrewardstablevaluecolumnindex.price / 100 );
        
        if ( self.plundercount >= var1 )
        {
            var0.getquestrewardstablevaluecolumnindex enableplayeruse( self );
            var0.getquestrewardtier disableplayeruse( self );
            
            if ( istrue( var0.getquestrewardstablevaluecolumnindex.isusable ) )
            {
                var0.getquestrewardstablevaluecolumnindex.scriptable hudoutlineenableforclient( self, "outline_depth_cyan" );
                return;
            }
            
            return;
        }
        
        if ( self.plundercount < var1 )
        {
            var0.getquestrewardstablevaluecolumnindex disableplayeruse( self );
            var0.getquestrewardtier enableplayeruse( self );
            var0.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient( self );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x114
function ref_1361f( var0, var1 )
{
    var0.ref_1293f = 1;
    var2 = var0.getquestrewardstablevaluecolumnindex;
    var2 makeunusable();
    var0.getquestrewardstablevaluecolumnindex = var2;
    ref_1392f( var2, var1, var0.ref_11c75, var0.ref_129f0 );
    var3 = getent( var0.helistoreplunder, "targetname" );
    
    if ( isdefined( var3 ) )
    {
        var4 = spawn( "script_model", var0.origin );
        var4.angles = var0.angles;
        var4 clonebrushmodeltoscriptmodel( var3 );
        var2.collision = var4;
        var5 = getentarrayinradius( "player", "classname", var0.origin, 500 );
        
        foreach ( var1 in var5 )
        {
            if ( !isalive( var1 ) )
            {
                continue;
            }
            
            if ( var1 istouching( var4 ) )
            {
                var1 setorigin( var0.origin );
            }
        }
    }
    
    if ( var0.ref_13931 == "buildable_checkpoint" )
    {
        thread flagwatchradarownerlost();
    }
    else if ( var0.ref_13931 == "buildable_guardtower" )
    {
        ref_13c18( var2, var1 );
    }
    
    return var2;
}

// Params 3
// Size: 0xa2
function ref_1392f( var0, var1, var2 )
{
    var3 = 1.53;
    var4 = anglestoforward( self.angles );
    var5 = self.origin + var4 * 50;
    var6 = spawn( "script_model", self.origin );
    var6.angles = self.angles;
    var6 setmodel( "generic_prop_x3" );
    var6 scriptmodelplayanim( var2, "structure_reveal" );
    var6 scriptmodelpauseanim( 1 );
    self.scriptable delete();
    self setmodel( var1 );
    self linkto( var6, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self dontinterpolate();
    var6 scriptmodelpauseanim( 0 );
    wait var3;
    waitframe();
    var6 delete();
}

// Params 2
// Size: 0x7d
function br_circle_closing_music( var0, var1 )
{
    var2 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc( var0 + ( 0, 0, 3000 ), var0, ( 0, 0, 0 ), "payload_c130_loot", "inactive", undefined, 1 );
    var2.nevertimeout = 1;
    var2 setotherent( var1 );
    var2 waittill( "collision", var3, var4, var5, var6, var7, var8, var9, var10 );
    waitframe();
    var2 scripts\cp_mp\killstreaks\airdrop::makecrateunusable();
    var2 delete();
}

// Params 3
// Size: 0x57
function run_techo_spawner( var0, var1, var2 )
{
    if ( !isdefined( var0.getquestscaledvalue[ var1 ] ) )
    {
        return;
    }
    
    foreach ( var4 in var0.getquestscaledvalue[ var1 ] )
    {
        if ( var4.ref_13931 == var2 && !istrue( var4.ref_1293f ) )
        {
            return var4;
        }
    }
}

// Params 2
// Size: 0x12
function firesalediscount( var0, var1 )
{
    return fix_door_clip( var0, var1, "buildable_checkpoint" );
}

// Params 2
// Size: 0x12
function fix_wall_traversal( var0, var1 )
{
    return fix_door_clip( var0, var1, "buildable_guardtower" );
}

// Params 3
// Size: 0x91, Type: bool
function fix_door_clip( var0, var1, var2 )
{
    var3 = 25;
    var4 = 26;
    var5 = var1.path;
    var6 = level.disable_super_in_turret.getquestplunderrewardinstance;
    
    if ( var6 == 0 && var0.team == game[ "attackers" ] )
    {
        var0 scripts\mp\gametypes\br_armory_kiosk::addtop3brcharge( var3 );
        return false;
    }
    
    if ( var0.team == game[ "attackers" ] )
    {
        var6--;
    }
    
    if ( isdefined( var5.getquestscaledvalue[ var6 ] ) )
    {
        var7 = run_techo_spawner( var5, var6, var2 );
        
        if ( isdefined( var7 ) )
        {
            ref_1361f( var7, var0 );
            return true;
        }
    }
    
    var0 scripts\mp\gametypes\br_armory_kiosk::addtop3brcharge( var4 );
    return false;
}

// Params 0
// Size: 0x268
function flagwatchradarownerlost()
{
    level endon( "game_ended" );
    var0 = ( 0, -30, 0 );
    var1 = ( 0, -90, 0 );
    var2 = rotatevector( var0, self.angles );
    var3 = self.origin + var2;
    var4 = spawnturret( "misc_turret", var3, "manual_turret_payload_mp", 0 );
    var4.angles = ( 0, self.angles[ 1 ], 0 ) + var1;
    var4 setmodel( "weapon_wm_mg_mobile_turret" );
    var4 setscriptablepartstate( "hide_reticle", 1, 0 );
    self.turret = var4;
    var5 = "j_trigger";
    var6 = var4 gettagorigin( var5 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "manual_turret", "createHintObject" ) )
    {
        var4.useownerobj = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "manual_turret", "createHintObject" ) ]]( var6, "HINT_BUTTON", undefined, &"BR_PAYLOAD/TURRET_MG", -1, "duration_none", undefined, 80, 60, 80, 60 );
    }
    
    var4.useownerobj linkto( var4, var5 );
    var4 setdefaultdroppitch( 0 );
    var4 setturretmodechangewait( 1 );
    var4.maxhealth = 999999;
    var4.health = var4.maxhealth;
    var4 makeunusable();
    
    for ( ;; )
    {
        var4.useownerobj waittill( "trigger", var7 );
        var8 = var7.origin;
        var7 scripts\cp_mp\killstreaks\manual_turret::ref_11acd( 0 );
        var7 disableturretdismount();
        var4.owner = var7;
        var7 giveweapon( "manual_turret_payload_mp", -1, 0, -1, 1 );
        var9 = var7 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( "manual_turret_payload_mp", 1 );
        
        if ( !istrue( var9 ) )
        {
            if ( isalive( var7 ) )
            {
                var7 enableturretdismount();
                var7 scripts\cp_mp\killstreaks\manual_turret::ref_11acd( 1 );
                
                if ( var7 hasweapon( "manual_turret_payload_mp" ) )
                {
                    var7 takeweapon( "manual_turret_payload_mp" );
                }
                
                var7 scripts\mp\utility\inventory::switchtolastweapon();
            }
            
            continue;
        }
        
        var4 setotherent( var7 );
        var4 setentityowner( var7 );
        var7 controlturreton( var4 );
        var7 setclientomnvar( "ui_mobile_turret_controls", 2 );
        var7 setplayerangles( var4.angles );
        var7 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire( var7, 0.5, 1 );
        waitframe();
        
        while ( var7 usebuttonpressed() )
        {
            waitframe();
        }
        
        while ( isalive( var7 ) && !var7 usebuttonpressed() && !var7 isinexecutionvictim() )
        {
            waitframe();
        }
        
        if ( isdefined( var7 ) )
        {
            var7 enableturretdismount();
            var7 controlturretoff( var4 );
            var7 setclientomnvar( "ui_mobile_turret_controls", 0 );
            var7 scripts\cp_mp\killstreaks\manual_turret::ref_11acd( 1 );
            
            if ( var7 hasweapon( "manual_turret_payload_mp" ) )
            {
                var7 takeweapon( "manual_turret_payload_mp" );
            }
            
            var7 scripts\mp\utility\inventory::switchtolastweapon();
            var7 thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac7();
            var7 setorigin( var8 );
        }
        
        var4.owner = undefined;
        var4 setotherent( undefined );
        var4 setentityowner( undefined );
        wait 0.5;
    }
}

// Params 1
// Size: 0xc3
function ref_13c18( var0 )
{
    var1 = 4;
    
    if ( !isdefined( level.disable_super_in_turret.ref_129c6 ) )
    {
        level.disable_super_in_turret.ref_129c6 = [];
    }
    
    if ( level.disable_super_in_turret.ref_129c6.size >= var1 )
    {
        var2 = undefined;
        var3 = undefined;
        
        foreach ( var5 in level.disable_super_in_turret.ref_129c6 )
        {
            if ( !isdefined( var3 ) || var5.ref_129c7 < var3 )
            {
                var2 = var6;
                var3 = var5.ref_129c7;
            }
        }
        
        level.disable_super_in_turret.ref_129c6[ var2 ] clearportableradar();
        level.disable_super_in_turret.ref_129c6[ var2 ] = undefined;
    }
    
    self.ref_129c7 = gettime();
    self makeportableradar( var0 );
    level.disable_super_in_turret.ref_129c6[ self getentitynumber() ] = self;
}

// Params 0
// Size: 0x162
function ref_1225e()
{
    level endon( "game_ended" );
    wait 1;
    
    if ( !level.disable_super_in_turret.little_bird_mg_mp_spawncallback )
    {
        return;
    }
    
    var0 = getentitylessscriptablearrayinradius( "scriptable_scriptable_auto_ascender", "classname" );
    var1 = getentitylessscriptablearrayinradius( "scriptable_scriptable_auto_ascender_solo", "classname" );
    var2 = getentitylessscriptablearrayinradius( "scriptable_scriptable_auto_ascender_soa_tower", "classname" );
    var3 = getentitylessscriptablearrayinradius( "scriptable_scriptable_auto_ascender_solo_soa_tower", "classname" );
    
    if ( var0.size )
    {
        foreach ( var5 in var0 )
        {
            if ( var5 getscriptablehaspart( "ascender" ) )
            {
                var5 setscriptablepartstate( "ascender", "noprompt" );
            }
        }
    }
    
    if ( var1.size )
    {
        foreach ( var5 in var1 )
        {
            if ( var5 getscriptablehaspart( "ascender_solo" ) )
            {
                var5 setscriptablepartstate( "ascender_solo", "noprompt" );
            }
        }
    }
    
    if ( var2.size )
    {
        foreach ( var5 in var2 )
        {
            if ( var5 getscriptablehaspart( "ascender" ) )
            {
                var5 setscriptablepartstate( "ascender", "noprompt" );
            }
        }
    }
    
    if ( var3.size )
    {
        foreach ( var5 in var3 )
        {
            if ( var5 getscriptablehaspart( "ascender_solo" ) )
            {
                var5 setscriptablepartstate( "ascender_solo", "noprompt" );
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x167
function terminal_pusher_approach_array_counter()
{
    if ( !level.disable_super_in_turret.mine_caves_turret_1_support )
    {
        return;
    }
    
    var0 = [ "jeep", "tac_rover" ];
    var1 = 0;
    
    if ( !isdefined( level.disable_super_in_turret.vehiclespawns ) )
    {
        level.disable_super_in_turret.vehiclespawns = scripts\engine\utility::getstructarray( "payload_vehicle_spawns", "script_noteworthy" );
    }
    
    foreach ( var3 in level.disable_super_in_turret.vehiclespawns )
    {
        var3.ref_1425c = var3.script_parameters;
        
        if ( !isdefined( var3.ref_1425c ) )
        {
            var3.ref_1425c = var0[ var1 ];
            var1++;
            
            if ( var1 >= var0.size )
            {
                var1 = 0;
            }
        }
        
        if ( !isdefined( var3.angles ) )
        {
            var3.angles = ( 0, 0, 0 );
        }
        
        var4 = var3.script_index;
        var5 = var3.script_group;
        var6 = respawndelayoverride( var5 );
        
        if ( isdefined( var6 ) )
        {
            var7 = var6.getquestreward_checkforvalueoverride[ var4 ];
            
            if ( !isdefined( var7.vehiclespawns ) )
            {
                var7.vehiclespawns = [];
            }
            
            var8 = game[ "attackers" ];
            
            if ( var3.targetname == "defender" )
            {
                var8 = game[ "defenders" ];
            }
            
            if ( !isdefined( var7.vehiclespawns[ var8 ] ) )
            {
                var7.vehiclespawns[ var8 ] = [];
            }
            
            var9 = var7.vehiclespawns[ var8 ].size;
            var7.vehiclespawns[ var8 ][ var9 ] = var3;
        }
    }
}

// Params 0
// Size: 0x45
function spawninitialvehicles()
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) && !istrue( game[ "switchedsides" ] ) )
    {
        scripts\mp\gametypes\br_vehicles::spawninitialvehicles();
        return;
    }
    
    ref_136aa( 1 );
    thread ref_13639( game[ "attackers" ] );
    thread ref_13639( game[ "defenders" ] );
}

// Params 1
// Size: 0x157
function ref_13639( var0 )
{
    level endon( "game_ended" );
    level notify( "spawnDrivableVehiclesTimer_" + var0 );
    level endon( "spawnDrivableVehiclesTimer_" + var0 );
    var1 = 2;
    var2 = 1;
    
    foreach ( var4 in level.disable_super_in_turret.paths )
    {
        var4.ref_11f48[ var0 ] = 0;
    }
    
    for ( ;; )
    {
        foreach ( var4 in level.disable_super_in_turret.paths )
        {
            var7 = relic_amped_last_kill_time( var4 );
            
            if ( var7 < 0 )
            {
                var7 = 0;
            }
            
            var8 = var4.getquestreward_checkforvalueoverride[ var7 ];
            
            if ( isdefined( var8 ) && isdefined( var8.vehiclespawns ) )
            {
                var9 = var8.vehiclespawns[ var0 ];
                
                foreach ( var11 in var9 )
                {
                    if ( var4.ref_11f48[ var0 ] >= var1 )
                    {
                        break;
                    }
                    
                    if ( istrue( var11.inuse ) )
                    {
                        goto LOC_0000012a;
                    }
                    
                    var12 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle( var11.ref_1425c, var11, "alwaysSpawn" );
                    jumpiffalse(isdefined( var12 )) LOC_0000012a;
                    scripts\cp_mp\vehicles\vehicle_spawn::ref_14219( var12 );
                    thread ref_14250( var12, var4, var11 );
                }
            }
        }
        
        var2 = 0;
        wait level.disable_super_in_turret.ref_136ab;
    }
}

// Params 3
// Size: 0x3c
function ref_14250( var0, var1, var2 )
{
    level endon( "game_ended" );
    var0.ref_11f48[ var2 ]++;
    var1.inuse = 1;
    self waittill( "death" );
    var0.ref_11f48[ var2 ]--;
    var1.inuse = undefined;
}

// Params 2
// Size: 0x67
function respawningbr( var0, var1 )
{
    var2 = var0.nodes[ var1 ].origin;
    jumpiffalse(var1 + 1 < var0.nodes.size) LOC_00000047;
    var3 = var0.nodes[ var1 + 1 ].origin;
    var4 = var3 - var2;
    goto LOC_00000064;
}

// Params 1
// Size: 0x6a, Type: bool
function ref_132f6( var0 )
{
    if ( level.disable_super_in_turret.ref_1226a == "port" && var0.label == "B" && var0.getquestplunderrewardinstance == 0 || level.disable_super_in_turret.ref_1226a == "trainstation2" && var0.label == "A" && var0.getquestplunderrewardinstance == 1 )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x3e
function getquestperkbonus( var0 )
{
    var1 = play_rooftop_success_vo( var0, var0.getquestplunderrewardinstance );
    var2 = var1[ 0 ];
    var3 = var1[ 1 ];
    var4 = var1[ 2 ];
    var5 = var1[ 3 ];
    var1 = undefined;
    thread init_relic_dogtags( var0, var2, var4 );
    thread init_relic_dogtags( var0, var3, var4 );
}

// Params 2
// Size: 0x206
function play_rooftop_success_vo( var0, var1 )
{
    var2 = 150;
    var3 = 200;
    var4 = 5;
    var5 = 30;
    var6 = 184;
    var7 = var2 - var4;
    var8 = 50;
    var9 = var0.getquestreward_checkforvalueoverride[ var1 ].ref_11ea5;
    var10 = var0.nodes[ var9 ].origin;
    var11 = var0.nodes[ var9 ].angles;
    var12 = vectornormalize( respawningbr( var0, var9 ) );
    var13 = vectortoangles( var12 );
    var14 = anglestoright( var13 );
    var15 = -1 * var14;
    var16 = var10 + var6 * var12 + var2 * var14;
    var17 = var10 + var6 * var12 + var2 * var15;
    var18 = 0;
    var19 = 0;
    var20 = var2;
    
    while ( var20 <= var3 )
    {
        var21 = var10 + var6 * var12 + var20 * var14;
        var22 = scripts\mp\gametypes\br_public::modifyplayer_damage( var21 );
        var23 = abs( var10[ 2 ] - var22[ 2 ] );
        var24 = var23 < var5;
        
        if ( var24 && !var19 )
        {
            var17 = var22;
            var19 = 1;
        }
        
        var25 = var10 + var6 * var12 + var20 * var15;
        var26 = scripts\mp\gametypes\br_public::modifyplayer_damage( var25 );
        var27 = abs( var10[ 2 ] - var26[ 2 ] );
        var28 = var27 < var5;
        
        if ( var28 && !var18 )
        {
            var16 = var26;
            var18 = 1;
        }
        
        if ( var28 && var24 )
        {
            return [ var22, var26, var13, 1 ];
        }
        
        var20 += var4;
    }
    
    waitframe();
    
    if ( !var18 || !var19 )
    {
        var20 = var8;
        
        while ( var20 <= var7 )
        {
            if ( !var19 )
            {
                var21 = var10 + var6 * var12 + var20 * var14;
                var22 = scripts\mp\gametypes\br_public::modifyplayer_damage( var21 );
                var23 = abs( var10[ 2 ] - var22[ 2 ] );
                var24 = var23 < var5;
                
                if ( var24 )
                {
                    var17 = var22;
                    var19 = 1;
                }
            }
            
            if ( !var18 )
            {
                var25 = var10 + var6 * var12 + var20 * var15;
                var26 = scripts\mp\gametypes\br_public::modifyplayer_damage( var25 );
                var27 = abs( var10[ 2 ] - var26[ 2 ] );
                var28 = var27 < var5;
                
                if ( var28 )
                {
                    var16 = var26;
                    var18 = 1;
                }
            }
            
            if ( var18 && var19 )
            {
                break;
            }
            
            var20 -= var4;
        }
    }
    
    return [ var16, var17, var13, 0 ];
}

// Params 3
// Size: 0x70
function init_relic_dogtags( var0, var1, var2 )
{
    var3 = spawn( "script_model", var1 );
    var3.angles = ( 0, var2[ 1 ], 0 );
    var3 setmodel( "vfx_br_payload_checkpoint" );
    var3 unmarkkeyframedmover( 1 );
    var4 = "checkpoint";
    
    if ( ref_132f6( var0 ) )
    {
        var4 = "checkpoint_ohcheck";
    }
    
    var3 setscriptablepartstate( "checkpoint", var4 );
    ref_1438d( var0 );
    var3 setscriptablepartstate( "checkpoint", "checkpoint_clear" );
    wait 5;
    var3 delete();
}

// Params 1
// Size: 0xc
function ref_1438d( var0 )
{
    var0 waittill( "checkPointUpdate" );
}

// Params 2
// Size: 0x9b
function ref_125c3( var0, var1 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self giveweapon( var0 );
    self setweaponammostock( var0, 0 );
    self setweaponammoclip( var0, 0 );
    scripts\mp\supers::allowsuperweaponstow();
    var2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var0, 0, 1 );
    
    if ( !istrue( var2 ) )
    {
        scripts\mp\supers::unstowsuperweapon();
        
        if ( scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( var0 ) )
        {
            scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( var0 );
        }
        else
        {
            self takeweapon( var0 );
        }
    }
    
    var1 notify( "build_tool_ready" );
    
    while ( istrue( self.tuttxtbox ) )
    {
        waitframe();
        
        if ( !scripts\cp_mp\utility\inventory_utility::iscurrentweapon( var0 ) )
        {
            self.tuttxtbox = 0;
        }
    }
    
    var1 show();
    scripts\cp_mp\utility\inventory_utility::getridofweapon( var0 );
    var1 notify( "build_complete" );
}

// Params 2
// Size: 0x6a
function ref_125c0( var0, var1 )
{
    var2 = self;
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    var2 endon( "death_or_disconnect" );
    
    if ( var2 isgestureplaying( "iw8_ges_payload_build_barrier" ) )
    {
        return;
    }
    
    var2 enableoffhandweapons();
    var2 giveandfireoffhand( var0 );
    waitframe();
    
    if ( !var2 hasweapon( var0 ) )
    {
        var2 giveandfireoffhand( var0 );
        waitframe();
    }
    
    var1 notify( "build_tool_ready" );
    
    while ( istrue( var2.tuttxtbox ) )
    {
        waitframe();
    }
    
    self takeweapon( var0 );
    var1 notify( "build_complete" );
}

// Params 0
// Size: 0x184
function ref_1226d()
{
    if ( !istrue( level.disable_super_in_turret.ref_12272 ) )
    {
        return;
    }
    
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.ref_13ac8 = [];
    level.ref_13ac8[ game[ "attackers" ] ] = [];
    level.ref_13ac8[ game[ "defenders" ] ] = [];
    level.ref_13abe = [];
    level.ref_13abe[ game[ "attackers" ] ] = undefined;
    level.ref_13abe[ game[ "defenders" ] ] = undefined;
    
    for ( var0 = 1;  ; var0 = 0 )
    {
        level waittill( "checkPointUpdate", var1 );
        var2 = int( max( relic_amped_monitor() - 1, 0 ) );
        wait 3;
        var3 = undefined;
        var4 = undefined;
        
        if ( istrue( level.disable_super_in_turret.ref_1226f ) || istrue( level.disable_super_in_turret.ref_12273 ) )
        {
            var5 = scripts\mp\gametypes\br_capshoot_quest::registermovequestlocale();
            var3 = var5[ var2 % var5.size ];
        }
        
        if ( istrue( level.disable_super_in_turret.ref_12270 ) || istrue( level.disable_super_in_turret.ref_12273 ) )
        {
            var6 = scripts\mp\gametypes\br_capshoot_quest::relic_nuketimer_playvo();
            var4 = var6[ var2 % var6.size ];
        }
        
        var7 = level.disable_super_in_turret.ref_12271;
        
        if ( istrue( level.disable_super_in_turret.ref_1226f ) )
        {
            thread init_relic_bang_and_boom( var1, var7, game[ "attackers" ], var3, game[ "defenders" ], var4 );
            
            if ( var0 )
            {
                ref_13357( game[ "attackers" ] );
            }
        }
        
        if ( istrue( level.disable_super_in_turret.ref_12270 ) )
        {
            thread init_relic_bang_and_boom( var1, var7, game[ "defenders" ], var4, game[ "attackers" ], var3 );
            
            if ( var0 )
            {
                ref_13357( game[ "defenders" ] );
            }
        }
        
        if ( var0 )
        {
        }
    }
}

// Params 6
// Size: 0x33
function init_relic_bang_and_boom( var0, var1, var2, var3, var4, var5 )
{
    level notify( "create_quest_tablets" );
    level endon( "create_quest_tablets" );
    
    for ( var6 = 0; var6 < var1 ; var6++ )
    {
        init_relic_amped( var0, var2, var3, var4, var5 );
    }
}

// Params 5
// Size: 0xad
function init_relic_amped( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var5 = -600;
    var6 = -300;
    var7 = 15;
    var8 = var0;
    
    if ( istrue( var0.hidesmokinggunhudfromplayer ) )
    {
        var8 = respawn_enemies( var0 );
    }
    
    var9 = undefined;
    
    if ( isdefined( var8.idle_sfx ) )
    {
        var9 = var8.idle_sfx;
    }
    else
    {
        var9 = var8.vehicle;
    }
    
    if ( isdefined( var9 ) )
    {
        var10 = randomfloatrange( -1 * var7, var7 );
        var11 = ( 0, var9.angles[ 1 ] + var10, 0 );
        var12 = anglestoforward( var11 );
        var13 = randomfloatrange( var5, var6 );
        var14 = var9.origin + var12 * var13;
        var15 = ref_1361c( var14, var1, var2, var3, var4 );
        var15.path = var8;
        return;
    }
}

// Params 5
// Size: 0x7c
function ref_1361c( var0, var1, var2, var3, var4 )
{
    var5 = 20;
    var6 = scripts\mp\gametypes\br_public::modifyplayer_damage( var0 );
    var6 += ( 0, 0, var5 );
    var7 = scripts\mp\gametypes\br_quest_util::ref_135df( var2, var6 );
    
    if ( isdefined( var7 ) )
    {
        var7.team = var1;
        
        if ( van_infil_sfx_chief() )
        {
            var7.ref_12395 = &play_reset_sequences;
        }
        
        if ( istrue( level.disable_super_in_turret.ref_12273 ) )
        {
            var7.ref_12157 = &registerscriptableinstance;
            var7.otherteam = var3;
            var7.ref_12158 = var4;
        }
        
        scripts\mp\gametypes\br_pickups::ref_12b3a( var7 );
    }
    
    return var7;
}

// Params 2
// Size: 0x13a
function play_reset_sequences( var0, var1 )
{
    var2 = var1.path;
    
    if ( !van_infil_sfx_chief() || !isdefined( var2 ) )
    {
        return undefined;
    }
    
    level.disable_super_in_turret.ref_1297a = var2;
    var3 = scripts\engine\utility::array_sort_with_func( level.disable_super_in_turret.ref_12979, &ammorestock_used );
    level.disable_super_in_turret.ref_1297a = undefined;
    var4 = var3[ 0 ];
    
    for ( var5 = 0; var5 < var3.size ; var5++ )
    {
        var6 = var3[ var5 ];
        var7 = 0;
        
        foreach ( var9 in var2.ref_136c3[ var0.team ] )
        {
            if ( isdefined( var9.trigger ) && ispointinvolume( var6.origin, var9.trigger ) )
            {
                continue;
            }
            
            if ( isdefined( var9.ref_14427 ) && ispointinvolume( var6.origin, var9.ref_14427 ) )
            {
                continue;
            }
            
            var7 = 1;
        }
        
        if ( !istrue( var7 ) )
        {
            continue;
        }
        
        var4 = var6;
        break;
    }
    
    var11 = spawnstruct();
    var11.origin = var4.origin;
    var11.angles = var4.angles;
    var11.spawnflags = 16;
    var11.ref_12978 = var4;
    return var11;
}

// Params 1
// Size: 0xf1
function registerscriptableinstance( var0 )
{
    var1 = var0.otherteam;
    var2 = var0.path;
    
    if ( !isdefined( var1 ) || !isdefined( var2 ) || !isdefined( var2.vehicle ) )
    {
        return undefined;
    }
    
    var3 = undefined;
    var4 = undefined;
    
    foreach ( var6 in level.squaddata[ var1 ] )
    {
        var7 = 0;
        var8 = var6.players.size;
        
        if ( var8 > 0 )
        {
            foreach ( var10 in var6.players )
            {
                var7 += distancesquared( var10.origin, var2.vehicle.origin );
            }
            
            var7 /= var8;
            
            if ( !istrue( var4 ) || var7 > var4 )
            {
                var3 = var6;
                var4 = var7;
            }
        }
    }
    
    if ( isdefined( var3 ) && var3.players.size > 0 )
    {
        return var3.players[ 0 ];
    }
    
    return undefined;
}

// Params 1
// Size: 0x4b
function ref_13357( var0 )
{
    var1 = scripts\mp\utility\teams::getteamdata( var0, "players" );
    
    foreach ( var3 in var1 )
    {
        if ( isdefined( var3 ) && isalive( var3 ) )
        {
            var3 thread scripts\mp\hud_message::showsplash( "br_capshoot_quest_first_tablet_alert" );
        }
    }
}

// Params 0
// Size: 0x20, Type: bool
function van_infil_sfx_chief()
{
    return isdefined( level.disable_super_in_turret.ref_12979 ) && level.disable_super_in_turret.ref_12979.size > 0;
}

// Params 2
// Size: 0x39, Type: bool
function ammorestock_used( var0, var1 )
{
    var2 = level.disable_super_in_turret.ref_1297a;
    var3 = var2.vehicle.origin;
    return distancesquared( var0.origin, var3 ) < distancesquared( var1.origin, var3 );
}

// Params 1
// Size: 0x10
function ref_13181( var0 )
{
    ref_13156( "current_player_path_assignment", var0 );
}

// Params 1
// Size: 0x10
function ref_13184( var0 )
{
    ref_13156( "current_player_team_assignment", var0 );
}

// Params 1
// Size: 0x10
function ref_13182( var0 )
{
    ref_13156( "current_player_respawn", var0 );
}

// Params 1
// Size: 0x10
function ref_13183( var0 )
{
    ref_13156( "current_player_tacmap", var0 );
}

// Params 1
// Size: 0x10
function ref_13185( var0 )
{
    ref_13156( "in_cinematic_controls_locked", var0 );
}

// Params 2
// Size: 0x22
function ref_1318b( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( var0 == 1, "number_of_teammates_on_path_b", "number_of_teammates_on_path_a" );
    ref_13157( var2, var1 );
}

// Params 2
// Size: 0x22
function ref_13190( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( var0 == 1, "path_b_state", "path_a_state" );
    ref_13157( var2, var1 );
}

// Params 2
// Size: 0x22
function ref_1318a( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( var0 == 1, "path_b_checkpoints_complete", "path_a_checkpoints_complete" );
    ref_13157( var2, var1 );
}

// Params 1
// Size: 0x24
function ref_13189( var0 )
{
    var1 = int( var0 / 100 );
    var1 = scripts\engine\utility::ter_op( var1 <= 0, 0, var1 );
    ref_13157( "last_chance_time", var1 );
}

// Params 1
// Size: 0x17
function ref_13188( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = 0;
    }
    
    ref_13157( "last_chance_max_time", var0 );
}

// Params 1
// Size: 0x10
function ref_1318e( var0 )
{
    ref_13157( "payload_timer_initialized", var0 );
}

// Params 1
// Size: 0x2f
function ref_11aa2( var0 )
{
    var1 = 0;
    
    if ( var0 >= 0.999 )
    {
        var1 = 10000;
    }
    else if ( var0 > 0 )
    {
        var1 = int( var0 * 10000 );
    }
    
    return var1;
}

// Params 2
// Size: 0x2a
function ref_1318f( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( var0 == 1, "path_b_percent_complete", "path_a_percent_complete" );
    var3 = ref_11aa2( var1 );
    ref_13157( var2, var3 );
}

// Params 3
// Size: 0x32
function ref_1318c( var0, var1, var2 )
{
    var3 = scripts\engine\utility::ter_op( var0 == 1, "path_b_obstacle_state", "path_a_obstacle_state" );
    var4 = scripts\engine\utility::ter_op( var2 == 1, 1, 0 );
    ref_13157( var3, var4, var1 );
}

// Params 3
// Size: 0x47
function ref_13157( var0, var1, var2 )
{
    var3 = reload_use_trigger( var0, var1 );
    var4 = var3[ 0 ];
    var5 = var3[ 1 ];
    var6 = var3[ 2 ];
    var1 = var3[ 3 ];
    var3 = undefined;
    
    if ( isdefined( var2 ) )
    {
        var4 += var2;
    }
    
    if ( var6 == "" )
    {
        return;
    }
    
    ref_1260e( var6, var1, var4, var5 );
}

// Params 2
// Size: 0x3c
function ref_13156( var0, var1 )
{
    var2 = reload_use_trigger( var0, var1 );
    var3 = var2[ 0 ];
    var4 = var2[ 1 ];
    var5 = var2[ 2 ];
    var1 = var2[ 3 ];
    var2 = undefined;
    
    if ( var5 == "" )
    {
        return;
    }
    
    ref_1260d( var5, var1, var3, var4 );
}

// Params 2
// Size: 0x321
function reload_use_trigger( var0, var1 )
{
    var2 = 0;
    var3 = 0;
    var4 = "";
    
    switch ( var0 )
    {
        case "current_player_path_assignment":
            var5 = [ 0, 1 ];
            var2 = var5[ 0 ];
            var3 = var5[ 1 ];
            var5 = undefined;
            var4 = "ui_br_payload_data_client";
            break;
        case "current_player_team_assignment":
            var6 = [ 1, 1 ];
            var2 = var6[ 0 ];
            var3 = var6[ 1 ];
            var6 = undefined;
            var4 = "ui_br_payload_data_client";
            break;
        case "current_player_respawn":
            var7 = [ 2, 1 ];
            var2 = var7[ 0 ];
            var3 = var7[ 1 ];
            var7 = undefined;
            var4 = "ui_br_payload_data_client";
            break;
        case "in_cinematic_controls_locked":
            var8 = [ 3, 1 ];
            var2 = var8[ 0 ];
            var3 = var8[ 1 ];
            var8 = undefined;
            var4 = "ui_br_payload_data_client";
            break;
        case "current_player_tacmap":
            var9 = [ 4, 1 ];
            var2 = var9[ 0 ];
            var3 = var9[ 1 ];
            var9 = undefined;
            var4 = "ui_br_payload_data_client";
            break;
        case "number_of_teammates_on_path_a":
            var10 = [ 0, 6 ];
            var2 = var10[ 0 ];
            var3 = var10[ 1 ];
            var10 = undefined;
            var4 = "ui_br_payload_data";
            break;
        case "number_of_teammates_on_path_b":
            var11 = [ 6, 6 ];
            var2 = var11[ 0 ];
            var3 = var11[ 1 ];
            var11 = undefined;
            var4 = "ui_br_payload_data";
            break;
        case "path_a_state":
            var12 = [ 12, 3 ];
            var2 = var12[ 0 ];
            var3 = var12[ 1 ];
            var12 = undefined;
            var4 = "ui_br_payload_data";
            break;
        case "path_b_state":
            var13 = [ 15, 3 ];
            var2 = var13[ 0 ];
            var3 = var13[ 1 ];
            var13 = undefined;
            var4 = "ui_br_payload_data";
            break;
        case "path_a_checkpoints_complete":
            var14 = [ 18, 2 ];
            var2 = var14[ 0 ];
            var3 = var14[ 1 ];
            var14 = undefined;
            var4 = "ui_br_payload_data";
            break;
        case "path_b_checkpoints_complete":
            var15 = [ 20, 2 ];
            var2 = var15[ 0 ];
            var3 = var15[ 1 ];
            var15 = undefined;
            var4 = "ui_br_payload_data";
            break;
        case "last_chance_time":
            var16 = [ 22, 10 ];
            var2 = var16[ 0 ];
            var3 = var16[ 1 ];
            var16 = undefined;
            var4 = "ui_br_payload_data";
            break;
        case "path_a_obstacle_state":
            var17 = [ 0, 1 ];
            var2 = var17[ 0 ];
            var3 = var17[ 1 ];
            var17 = undefined;
            var4 = "ui_br_payload_data_2";
            break;
        case "path_b_obstacle_state":
            var18 = [ 10, 1 ];
            var2 = var18[ 0 ];
            var3 = var18[ 1 ];
            var18 = undefined;
            var4 = "ui_br_payload_data_2";
            break;
        case "last_chance_max_time":
            var19 = [ 20, 3 ];
            var2 = var19[ 0 ];
            var3 = var19[ 1 ];
            var19 = undefined;
            var4 = "ui_br_payload_data_2";
            break;
        case "payload_timer_initialized":
            var20 = [ 23, 1 ];
            var2 = var20[ 0 ];
            var3 = var20[ 1 ];
            var20 = undefined;
            var4 = "ui_br_payload_data_2";
            break;
        case "path_a_percent_complete":
            var21 = [ 0, 16 ];
            var2 = var21[ 0 ];
            var3 = var21[ 1 ];
            var21 = undefined;
            var4 = "ui_br_payload_percents";
            break;
        case "path_b_percent_complete":
            var22 = [ 16, 16 ];
            var2 = var22[ 0 ];
            var3 = var22[ 1 ];
            var22 = undefined;
            var4 = "ui_br_payload_percents";
            break;
        default:
            break;
    }
    
    return [ var2, var3, var4, var1 ];
}

// Params 4
// Size: 0x43
function ref_1260d( var0, var1, var2, var3 )
{
    var4 = int( pow( 2, var3 ) ) - 1;
    var5 = ( var1 & var4 ) << var2;
    var6 = ~( var4 << var2 );
    var7 = self calloutmarkerping_entityzoffset( var0 );
    var8 = var7 & var6;
    var9 = var8 + var5;
    
    if ( var9 != var7 )
    {
        self setclientomnvar( var0, var9 );
        return;
    }
}

// Params 4
// Size: 0x41
function ref_1260e( var0, var1, var2, var3 )
{
    var4 = int( pow( 2, var3 ) ) - 1;
    var5 = ( var1 & var4 ) << var2;
    var6 = ~( var4 << var2 );
    var7 = getomnvar( var0 );
    var8 = var7 & var6;
    var9 = var8 + var5;
    
    if ( var9 != var7 )
    {
        setomnvar( var0, var9 );
        return;
    }
}

// Params 0
// Size: 0x55
function ref_12258()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    
    if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
    {
        wait 7.66667;
        thread ref_12257();
        return;
    }
    
    wait 6;
    thread ref_12257();
    scripts\mp\flags::gameflagwait( "infil_complete" );
    wait randomintrange( 20, 25 );
    thread ref_12257();
}

#using_animtree( "script_model" );

// Params 0
// Size: 0x330
function ref_12257()
{
    level endon( "game_ended" );
    var0 = [];
    var1 = undefined;
    var2 = level.disable_super_in_turret.ref_1226a;
    var3 = [];
    var4 = 1.2;
    
    switch ( var2 )
    {
        case "port":
            var0 = ( 38775, -23332, 197 );
            var0 = ( 33582, -25827, -278 );
            var1 = 255;
            break;
        case "trainstation2":
            var0 = ( -9592, -17688, -360 );
            var0 = ( -7456, -20160, 592 );
            var1 = 15;
            break;
        case "downtown2":
            var0 = ( 24012, -22726, 371 );
            var0 = ( 21811, -18619, 784 );
            var1 = 60;
            break;
        case "standard":
            var0 = ( 0, 0, 0 );
            var1 = 0;
            break;
        case "livingquarters":
            var0 = ( -17, -7150.75, 707.5 );
            var0 = ( -1349.5, -7417, 640.75 );
            var0 = ( -1654.75, -6373.75, 701 );
            var1 = 170;
            break;
        case "chemicaleng":
            var0 = ( 1281.5, 4766.75, 830.25 );
            var0 = ( 1323.5, 3293.75, 948.25 );
            var0 = ( 269.5, 3797.75, 1199.25 );
            var1 = 270;
            break;
        case "shore":
            var0 = ( -3363, 3374.75, 616.75 );
            var0 = ( -4397, 3984.75, 615 );
            var0 = ( -2523.5, 5642, 879.25 );
            var1 = 65;
            break;
        default:
            break;
    }
    
    var5 = spawnstruct();
    var5.streakname = "precision_airstrike";
    var5.owner = play_random_sound_event();
    var5.score = 0;
    var5.shots_fired = 0;
    var5.hits = 0;
    var5.damage = 0;
    var5.kills = 0;
    var5.setuptimelimit = 0;
    var5.brmini_ontimelimit = 0;
    var6 = undefined;
    var7 = %mp_alfa10_flyin;
    var8 = undefined;
    var9 = 24000;
    var10 = 6500;
    var11 = 1000;
    var12 = 1500;
    
    if ( getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
    {
        var5.setuptimelimit = 1;
        var11 = 1200;
    }
    
    var13 = 215;
    var14 = ( 0, var1, 0 );
    var15 = undefined;
    var16 = play_random_sound_event();
    
    if ( isdefined( var16 ) && istrue( var0.size > 0 ) )
    {
        for ( var17 = 0; var17 < var0.size ; var17++ )
        {
            var18 = scripts\cp_mp\killstreaks\airstrike::getflightpath( var0[ var17 ], var14, var9, 1, var11, var10, var12, var5.streakname, var15 );
            wait var4;
            var11 += randomintrange( 200, 300 );
            level thread scripts\cp_mp\killstreaks\airstrike::doplanestrike( var0[ var17 ], var18[ "startPoint" ], var18[ "endPoint" ], var11, var6, var5, var7, var5.owner, var8 );
            
            if ( var17 == 0 && getdvarint( "scr_br_alt_mode_mini", 0 ) > 0 )
            {
                thread onteammatereviveweapontaken( level, var2 );
            }
        }
        
        if ( getdvarint( "scr_br_alt_mode_mini", 0 ) == 0 )
        {
            thread onteammatereviveweapontaken( level, var2 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x15e
function onteammatereviveweapontaken( var0, var1 )
{
    level endon( "game_ended" );
    wait 5;
    
    switch ( var0 )
    {
        case "port":
            scripts\engine\utility::exploder( "pl_intro_exp_docks" );
            wait var1 - 1;
            scripts\engine\utility::exploder( "pl_intro_exp_docks2" );
            break;
        case "trainstation2":
            wait 0.5;
            scripts\engine\utility::exploder( "pl_intro_exp_trnstn" );
            wait var1 - 0.7;
            scripts\engine\utility::exploder( "pl_intro_exp_trnstn2" );
            break;
        case "downtown2":
            wait var1 - 1;
            scripts\engine\utility::exploder( "pl_intro_exp_dwtn" );
            scripts\engine\utility::exploder( "pl_intro_exp_dwtn2" );
            break;
        case "livingquarters":
            wait 2.5;
            scripts\engine\utility::exploder( "pl_intro_exp_livingquarters_01" );
            wait var1;
            scripts\engine\utility::exploder( "pl_intro_exp_livingquarters_02" );
            wait var1;
            scripts\engine\utility::exploder( "pl_intro_exp_livingquarters_03" );
            break;
        case "chemicaleng":
            wait 2.5;
            scripts\engine\utility::exploder( "pl_intro_exp_chemicaleng_01" );
            wait var1;
            scripts\engine\utility::exploder( "pl_intro_exp_chemicaleng_02" );
            wait var1;
            scripts\engine\utility::exploder( "pl_intro_exp_chemicaleng_03" );
            break;
        case "shore":
            wait 2.5;
            scripts\engine\utility::exploder( "pl_intro_exp_shore_01" );
            wait var1;
            scripts\engine\utility::exploder( "pl_intro_exp_shore_02" );
            wait var1;
            scripts\engine\utility::exploder( "pl_intro_exp_shore_03" );
            break;
        case "standard":
            scripts\engine\utility::exploder( "pl_intro_exp_1" );
            break;
        default:
            break;
    }
}

// Params 0
// Size: 0x4d
function play_random_sound_event()
{
    var0 = undefined;
    
    foreach ( var2 in level.players )
    {
        if ( isalive( var2 ) && var2.team == game[ "attackers" ] )
        {
            var0 = var2;
            break;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0xc7
function startspectatorview()
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "spawned_player" );
    scripts\mp\gametypes\br_spectate::ref_1252a();
    
    if ( isbot( self ) )
    {
        return;
    }
    
    thread ref_12535();
    scripts\mp\utility\player::updatesessionstate( "spectator" );
    scripts\mp\spectating::setdisabled();
    
    if ( isdefined( self.lastdeathangles ) )
    {
        self setplayerangles( self.lastdeathangles );
    }
    
    ref_13182( 1 );
    waitframe();
    var0 = respawntokenclosewithgulag();
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = var0.origin;
    var2 = var0.angles;
    self cameralinkto( var0, "tag_origin", 1 );
    self visionsetthermalforplayer( "ac130_color" );
    self thermalvisionon();
    self playlocalsound( "mp_cmd_camera_zoom_out" );
    self setclienttriggeraudiozonepartialwithfade( "spawn_cam", 0.5, "mix" );
    self waittill( "spawnChoice" );
    self clearclienttriggeraudiozone( 0.5 );
}

// Params 4
// Size: 0x74
function ref_13fd8( var0, var1, var2, var3 )
{
    self unlink();
    var4 = self.origin;
    var5 = self.angles;
    var6 = 0;
    
    if ( var1[ 0 ] != var4[ 0 ] )
    {
        self moveto( var1, 0.1 );
        var6 = 1;
    }
    
    if ( istrue( var6 ) )
    {
        var7 = anglestoforward( var2 ) * 300;
        var7 *= ( 1, 1, 0 );
        var0 earthquakeforplayer( 0.03, 15, var1 + var7, 1000 );
    }
    
    thread x1fin_think( var3 );
}

// Params 1
// Size: 0x2d
function x1fin_think( var0 )
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "death" );
    self waittill( "movedone" );
    
    if ( isdefined( var0 ) )
    {
        self linkto( var0 );
        return;
    }
}

// Params 1
// Size: 0x49
function ref_139d8( var0 )
{
    if ( isdefined( self.play_nuclear_core_vo ) && isdefined( self.ref_12204 ) && !isbot( self ) )
    {
        var1 = ref_12574( var0 );
        var2 = var1[ 0 ];
        var3 = var1[ 1 ];
        var4 = var1[ 2 ];
        var1 = undefined;
        ref_13fd8( self.play_nuclear_core_vo, self, var2, var3, var4 );
        return;
    }
}

// Params 1
// Size: 0xc4
function ref_12574( var0 )
{
    if ( !isdefined( var0 ) )
    {
        if ( isdefined( self.ref_12204 ) )
        {
            var0 = self.ref_12204;
        }
        else
        {
            var0 = level.disable_super_in_turret.paths[ 0 ];
        }
    }
    
    var1 = var0.label;
    var2 = 0;
    
    if ( var1 != "A" )
    {
        var2 = 1;
    }
    
    var3 = respawnheightoverride( var2 );
    var4 = var3.vehicle;
    var5 = 88;
    var6 = var4.angles[ 1 ];
    var7 = anglestoforward( ( 0, var6, 0 ) );
    var8 = 500;
    var9 = 5000;
    var10 = ( var4.origin[ 0 ] + var7[ 0 ] * var8, var4.origin[ 1 ] + var7[ 1 ] * var8, var9 );
    var11 = ( var5, var6, 0 );
    
    if ( self.team == game[ "defenders" ] )
    {
        var11 = ( var5, var6 + 180, 0 );
    }
    
    return [ var10, var11, var4 ];
}

// Params 0
// Size: 0x6e
function respawntokenclosewithgulag()
{
    if ( isdefined( self.play_nuclear_core_vo ) )
    {
        return self.play_nuclear_core_vo;
    }
    
    var0 = ref_12575();
    var1 = ref_12574( var0 );
    var2 = var1[ 0 ];
    var3 = var1[ 1 ];
    var4 = var1[ 2 ];
    var1 = undefined;
    var5 = spawn( "script_model", var2 );
    var5.angles = var3;
    var5 setmodel( "tag_origin" );
    var5 hide();
    var5 unmarkkeyframedmover( 1 );
    var5 showtoplayer( self );
    self.play_nuclear_core_vo = var5;
    return self.play_nuclear_core_vo;
}

// Params 0
// Size: 0x2a
function ref_126bb()
{
    var0 = ref_12575();
    var1 = ref_12574( var0 );
    var2 = var1[ 0 ];
    var3 = var1[ 1 ];
    var4 = var1[ 2 ];
    var1 = undefined;
    scripts\mp\gametypes\br_public::ref_126b9( var2 );
}

// Params 0
// Size: 0xa6
function ref_125e7()
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "playerPrestreamComplete" );
    wait 2;
    thread scripts\mp\spawncamera::startoperatorsound();
    waitframe();
    
    if ( isdefined( self.ref_12135 ) )
    {
        self.ref_12135.origin = self.origin + ( 0, 0, 80 );
        self.ref_12135 linkto( self );
    }
    
    scripts\mp\flags::gameflagwait( "infil_complete" );
    
    if ( isdefined( self.ref_12135 ) )
    {
        self clearsoundsubmix( "iw8_mp_spawn_camera" );
        self.ref_12135 unlink();
        self.ref_12135 stoploopsound( self.ref_12136 );
        self.ref_12135 delete();
        self.ref_12135 = undefined;
        self.ref_12136 = undefined;
        return;
    }
}

// Params 0
// Size: 0x51
function ref_12535()
{
    level endon( "payloadComplete" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    thread scripts\mp\spawncamera::startoperatorsound();
    waitframe();
    
    if ( isdefined( self.ref_12135 ) )
    {
        self.ref_12135.origin = self.origin + ( 0, 0, 80 );
        self.ref_12135 linkto( self );
        return;
    }
}

// Params 0
// Size: 0x179
function tomastrike_isflyingvehicle()
{
    if ( !isdefined( level.disable_super_in_turret.ref_12eac ) )
    {
        var0 = [];
        
        foreach ( var2 in level.disable_super_in_turret.paths )
        {
            var0 = ref_13697( "ee_machinery_satellite_solarpanel_04_dmg_payload_ch3", var2.initchallengeandeventglobals, 0, "satellite_solarpanel_col" );
            var0 = ref_13697( "ee_machinery_satellite_solarpanel_04_dmg_payload_ch3", var2.initchallengeandeventglobals, 1, "satellite_solarpanel_col" );
            var0 = ref_13697( "ee_machinery_satellite_panel_01_payload_ch3", var2.initchallengeandeventglobals, 2, "satellite_panel_col" );
        }
        
        level.disable_super_in_turret.ref_12eac = var0;
    }
    
    var4 = getent( "payload_satellite_clipbrush", "script_noteworthy" );
    
    if ( isdefined( var4 ) )
    {
        var4 delete();
    }
    
    foreach ( var2 in level.disable_super_in_turret.paths )
    {
        foreach ( var7 in level.disable_super_in_turret.ref_12eac )
        {
            if ( var7.script_group == var2.initchallengeandeventglobals )
            {
                var8 = var7;
                
                if ( !isent( var8 ) )
                {
                    var8 = ref_13697( var7.model, var7.script_group, var7.script_index + 1 );
                }
                
                var2.pieces[ var2.pieces.size ] = var8;
            }
        }
        
        var2.ref_12358 = ref_13697( "ee_machinery_satellite_thruster_module_nopanel_dmg_payload" );
    }
}

// Params 4
// Size: 0x82
function ref_13697( var0, var1, var2, var3 )
{
    var4 = spawn( "script_model", ( 0, 0, 0 ) );
    var4 setmodel( var0 );
    var4.script_group = var1;
    var4.script_index = var2;
    
    if ( isdefined( var3 ) )
    {
        var5 = getent( var3, "targetname" );
        
        if ( isdefined( var5 ) )
        {
            var6 = spawn( "script_model", var4.origin );
            var6.angles = var4.angles;
            var6 clonebrushmodeltoscriptmodel( var5 );
            var6 linkto( var4 );
        }
    }
    
    var4 hide();
    return var4;
}

// Params 2
// Size: 0x3a
function rocket_fuel_x1( var0, var1 )
{
    foreach ( var3 in var0.pieces )
    {
        if ( var3.script_index == var1 )
        {
            return var3;
        }
    }
}

// Params 2
// Size: 0x24
function ref_1326a( var0, var1 )
{
    if ( var1 > 0 )
    {
        var2 = rocket_fuel_x1( var0, var1 );
        ref_13dec( var0.idle_sfx, var2, var1 );
        return;
    }
}

// Params 2
// Size: 0xe5
function ref_13dec( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var2 = ( 0, 0, 0 );
    var3 = ( 0, 0, 0 );
    
    switch ( var1 )
    {
        case 0:
            var3 = ( -41.3, -9.2, 106.1 );
            break;
        case 1:
            var3 = ( -23.7, 40.8, 127.1 );
            var2 = ( 0, 2, -80 );
            break;
        case 2:
            var3 = ( -70.7, 40.8, 127.1 );
            var2 = ( 0, 2, -80 );
            break;
        case 3:
            var3 = ( 9.7, -1.8, 100.1 );
            var2 = ( 0, -90, -84 );
            break;
        default:
            break;
    }
    
    var0 show();
    var0 linkto( self, "tag_origin", var3, var2 );
}

// Params 0
// Size: 0x1e
function delay_start_escort_enter_vehicle_objective()
{
    wait 5;
    scripts\mp\utility\sound::besttime( "br_mode_payload_sfx" );
    setglobalsoundcontext( "gamemode", "payload" );
}

// Params 0
// Size: 0x72
function ref_11e11()
{
    level endon( "stop_overtime" );
    var0 = 0;
    var1 = respawn_trigger_think();
    
    for ( ;; )
    {
        var2 = respawn_trigger_think();
        
        if ( var2 > var1 )
        {
            if ( var0 >= 10 )
            {
                foreach ( var4 in level.players )
                {
                    var4 playlocalsound( "mus_payload_overtime_hit" );
                }
            }
            
            var0 = 0;
        }
        else if ( var2 == var1 )
        {
            var0 += 1;
        }
        
        var1 = var2;
        waitframe();
    }
}

// Params 0
// Size: 0xe8
function ref_11e12()
{
    while ( isdefined( level.allowmeleevehicledamage ) == 1 )
    {
        foreach ( var1 in level.players )
        {
            var2 = isdefined( var1.allowmodestructs );
            
            if ( var2 == 0 )
            {
                var1 setplayermusicstate( "br3_payload_overtime_suspense" );
                var1 playlocalsound( "mus_payload_overtime_hit" );
                var1.allowmodestructs = 1;
            }
        }
        
        waitframe();
    }
    
    foreach ( var1 in level.players )
    {
        var2 = isdefined( var1.allowmodestructs );
        
        if ( var2 == 1 )
        {
            var1 setplayermusicstate( "br3_payload_overtime_slam" );
            var1.allowmodestructs = undefined;
        }
    }
    
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 4.5 );
    
    foreach ( var1 in level.players )
    {
        var1 setplayermusicstate( "" );
    }
}

// Params 0
// Size: 0x31
function ref_11e10()
{
    for ( ;; )
    {
        level waittill( "start_overtime" );
        level.allowmeleevehicledamage = 1;
        thread ref_11e12();
        thread ref_11e11();
        level waittill( "stop_overtime" );
        waittillframeend();
        level.allowmeleevehicledamage = undefined;
    }
}

// Params 1
// Size: 0xa
function ref_12804( var0 )
{
    thread ref_126e0();
}

// Params 0
// Size: 0xc5
function ref_12aa5()
{
    foreach ( var1 in level.disable_super_in_turret.paths )
    {
        if ( !isdefined( var1 ) || !isdefined( var1.vehicle ) )
        {
            continue;
        }
        
        var2 = var1.vehicle;
        ref_1425b( var2 );
        getentitylessscriptablearray( "dlog_event_br_payload_game_end", [ "path_name", level.disable_super_in_turret.ref_1226a, "path_index", var1.script_index, "total_push_distance", ref_14244( var2 ), "longest_push_distance", var1.ref_119d6, "total_push_time", var1.ref_13bf5, "checkpoints_completed", var1.getquestplunderrewardinstance, "obstacles_destroyed", var1.ref_11f9f ] );
    }
}

