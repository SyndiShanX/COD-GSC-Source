
// Params 0
// Size: 0x560
function bomber_init()
{
    var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_bt", 1 );
    var0.destroycallback = &create_script_wait_for_flags;
    var0.ref_13e92 = "tur_gun_bt_mp";
    level.findclearflightyaw = getdvarint( "scr_bt_start_in_the_air", 0 );
    level.farah_nobraids_body = getdvarint( "scr_bt_drop_bomb_ammo", 4 );
    level.failsecretstashquest = getdvarint( "scr_bt_allow_runway_refill", 0 );
    level.failsmokinggunquest = getdvarint( "scr_bt_auto_refill_drop_bomb_time", 20 );
    level.find_free_drop_location = getdvarint( "scr_bt_drop_bomb_cooldown_ms", 6000 );
    level.fast_revive_time = getdvarfloat( "scr_bt_drop_bomb_vehicle_dmg", 0.85 );
    level.farobjectiveiconid = getdvarfloat( "scr_bt_drop_bomb_time_between_bombs", 0.8 );
    level.farah_says_cut_wire_green = getdvarint( "scr_bt_drop_bomb_destroys_crate", 1 );
    level.farah_says_cut_wire_red = getdvarint( "scr_bt_drop_bomb_destroys_kiosk", 0 );
    level.áãcH¢í†€V†Ã 6iªﬂ£Ükjaè" = getdvarint( "scr_bt_drop_bomb_destroys_trader", 0 );
    level.farah_nobraids_body_reset = getdvarint( "scr_bt_drop_bomb_destroys_aa_turret", 1 );
    level.farah_says_cut_wire_yellow = getdvarint( "scr_bt_drop_bomb_destroys_loot", 0 );
    level.farms2_gw_ambient_sound_load = getdvarint( "scr_bt_drop_bomb_destroys_skyhook", 1 );
    level.ffsm_state = getdvarfloat( "scr_bt_gunner_time_between_bullets", 0.1 );
    level.ffsm_isgulagrespawn = getdvarint( "scr_bt_enable_sonar", 1 );
    level.findanyaliveplayer = getdvarint( "scr_bt_sonar_scan_angle", 35 );
    level.findavailableteam = getdvarint( "scr_bt_sonar_scan_range", 15000 );
    level.find_plunder = getdvarfloat( "scr_bt_roll_required_to_drop_bomb", 60 );
    level.find_and_run_elevator_spawngroup = getdvarfloat( "scr_bt_pitch_required_to_drop_bomb", 45 );
    level.failedmission = getdvarint( "scr_bt_additional_contrail_vfx", 1 );
    level.finalthreeuav = getdvarint( "scr_bt_wing_contrails_min_speed", 60 );
    level.finalkillcamplaybackbegin = getdvarint( "scr_bt_cloud_contrails_min_speed", 90 );
    level.finalsurvivorcount = getdvarint( "scr_bt_fast_contrails_min_speed", 80 );
    level.find_ai_spawner = getdvarint( "scr_bt_oob_override_seconds", 40 );
    level.fake_digit_pool = getdvarint( "scr_bt_collision_before_liftoff", 0 );
    level.fiftypercent_music = getdvarint( "scr_bt_hide_pilot", 0 );
    level.failtimedrunquest = getdvarfloat( "scr_bt_bomb_inherit_velocity", 0.4 );
    level.failx1finquest = getdvarint( "scr_bt_bomb_max_velocity", 330 );
    level.finale_setup = getdvarint( "scr_bt_bomb_min_drop_height", 800 );
    level.ffsm_onground_stateenter = getdvarint( "scr_bt_gas_damage_players_airplane", 3 );
    level.farah_disable_ai_color_before_hallway_takedown = getdvarfloat( "scr_bt_dot_velocity_ground_reduce_damage", 0 );
    level.fananim = getdvarfloat( "scr_bt_dot_velocity_ground_no_damage", 0.18 );
    level.falling_xyratio = getdvarfloat( "scr_bt_dot_velocity_ground_little_damage", 0.85 );
    level.£√&é}ñvπÌ9YÿXõå-7ÏŸ+…FX÷¬;¨ = getdvarint( "scr_bt_ignoreLandingGearDamage", 0 );
    level.¢,ƒ£Î'+å´¨c∞7å“sŒ≥VX‰ë,⁄,vY = getdvarint( "scr_bt_reduceLandingGearDamage", 1 );
    level.ÅC "ã?8(√Î„”M…`õK∂Pß2îª3àt+:áåÛq˝ = getdvarfloat( "scr_bt_dot_velocity_ground_landing_gear", 0.25 );
    level.Ω!ZÛ–7‹¯wË≈cê'Ofk#:á“@ß‰ﬁ∏-üõ√˚ = getdvarfloat( "scr_bt_min_speed_factor_for_dot_velocity", 0.2 );
    level.findquestplacement = getdvarint( "scr_bt_velocity_ground_little_damage", 2 );
    level.find_supply_station = getdvarint( "scr_bt_show_runway_icon", 0 );
    level.ffsm_skydive_stateenter = getdvarfloat( "scr_bt_gunner_target_refresh_time", 0.1 );
    level.ffsm_parachuteopen_stateenter = getdvarfloat( "scr_bt_gunner_target_range", 15000 );
    level.fake_hit_target_monitor = getdvarfloat( "scr_bt_dmg_factor_fuselage", 0.5 );
    level.fake_magic_grenade_watch = getdvarfloat( "scr_bt_dmg_multiplier_propeller", 1 );
    level.fake_exploder = getdvarfloat( "scr_bt_dmg_multiplier_driverless", 10 );
    level.fake_model = getdvarfloat( "scr_bt_dmg_damage_pitch_threshold", 40 );
    level.fakeprops = getdvarfloat( "scr_bt_dmg_damage_roll_threshold", 45 );
    level.fake_magic_grenade_watch_individual = getdvarfloat( "scr_bt_dmg_damage_pitch_factor", 2 );
    level.fake_trigger_think = getdvarfloat( "scr_bt_dmg_damage_roll_factor", 2 );
    level.fallback_index = getdvarfloat( "scr_bt_dmg_damage_upside_down_factor", 20 );
    level.findgunsmithattachments = getdvarfloat( "scr_bt_dmg_mod_vs_fd", 5 );
    level.findfirstaliveplayer = getdvarfloat( "scr_bt_dmg_mod_vs_bt", 5 );
    level.findnewplunderextractsite = getdvarfloat( "scr_bt_dmg_mod_vs_vehicles", 5 );
    level.findeventforchosenweight = getdvarfloat( "scr_bt_dmg_mod_vs_AA", 10 );
    level.findminmaxangleovertime = getdvarfloat( "scr_bt_dmg_mod_vs_Player", 1 );
    level.failx1stashquest = getdvarfloat( "scr_bt_dmg_burn_down_time", 4 );
    level.fast_rope_over_black = getdvarint( "scr_bt_enable_server_hud", 0 );
    level.ffsm_landed_stateenter = getdvarint( "scr_bt_force_netfield_high_lod", 1 );
    level.failsafe_door_breach_frozen = getdvarint( "scr_bt_bomber_fast_contrails_min_angle", 55 );
    level.ffsm_introsetup = getdvarint( "scr_bt_bomber_enable_smoke_vfx", 0 );
    level.failstringsetup = getdvarint( "scr_bt_bomber_speed_diff_damage", 1 );
    level.finale_main = getdvarint( "scr_bt_bomber_longer_vehicle_explosion", 0 );
    level.fight_on_jammer_2_bridge = getdvarint( "scr_bt_bomber_ignore_self_collision", 1 );
    level.fake_agent_model_setup = getdvarint( "scr_bt_camera_follow_enable", 0 );
    level.findteamwithnoplayers = getdvarfloat( "scr_bt_wait_camera_follow_bomb", 0.5 );
    level.findvalidspectateprop = getdvarfloat( "scr_bt_wait_start_camera_follow", 0 );
    level.finale = getdvarint( "scr_bt_landing_gear_stay_still", 1 );
    level.failsafe_door_breach_frozen_player = getdvarint( "scr_bt_ads_allow_camera_transition", 1 );
    level.failhistoryquest = getdvarfloat( "scr_bt_ads_fade_delay_timer", 0.6 );
    level.failedtext = getdvarint( "scr_bt_ads_debounce_ms", 850 );
    level.ffsm_nextstreamhinttime = getdvarint( "scr_bt_free_look_end_delay_ms", 400 );
    level.á®j·Òó°1Rzπç√ç»≠„ıI¯ùOYk = getdvarint( "scr_bt_damage_debounce_time_ms", 500 );
    level.∏$Ç£á8?ÔÂE¡Îç£HJ®)zG”ìˇmKß = getdvarfloat( "scr_bt_damage_debounce_threshold_pct", 0.3 );
    level.final_wave = getdvarfloat( "scr_bt_impulse_dmg_threshold_high", 4.5 );
    level.final_switch_think = getdvarfloat( "scr_bt_impulse_dmg_threshold_mid", 0.9 );
    level.final_radius_think = getdvarfloat( "scr_bt_impulse_dmg_threshold_low", 0.3 );
    level.fillmaxarmorplate = getdvarfloat( "scr_bt_impulse_dmg_factor_low", 0.05 );
    level.filtervehiclespawnstructsfunc = getdvarfloat( "scr_bt_impulse_dmg_factor_mid_low", 0.2 );
    level.filtervehiclespawnstructs = getdvarfloat( "scr_bt_impulse_dmg_factor_mid_high", 0.75 );
    create_trial_weapon_spawn();
    create_thrust_fire();
    create_trophy_station();
    create_struct_at();
    create_struct();
    create_temp_infil_structs();
    create_solution_digit_mark();
    create_usb_anim_rig();
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_bt", "init" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_bt", "init" ) ]]();
    }
    
    create_tut_loot_struct();
    create_traversal_node_and_link();
}

// Params 0
// Size: 0x3b
function create_traversal_node_and_link()
{
    thread ref_1327d();
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_bt", "initLate" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_bt", "initLate" ) ]]();
    }
    
    if ( istrue( level.failsecretstashquest ) )
    {
        createspawncamera();
        return;
    }
}

// Params 0
// Size: 0x41b
function create_trial_weapon_spawn()
{
    var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( "veh_bt", 1 );
    var0.enterstartcallback = &create_rocket_death_fx;
    var0.enterendcallback = &create_race;
    var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
    var0.exitendcallback = &create_saw_interaction;
    var0.reentercallback = &createflagstart;
    var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
    var0.exitextents[ "front" ] = 50;
    var0.exitextents[ "back" ] = 355;
    var0.exitextents[ "left" ] = 255;
    var0.exitextents[ "right" ] = 255;
    var0.exitextents[ "top" ] = 10;
    var0.exitextents[ "bottom" ] = 50;
    var0.allowairexit = 1;
    var1 = "right";
    var0.exitoffsets[ var1 ] = ( 150, -35, -45 );
    var0.exitdirections[ var1 ] = "right";
    var1 = "left";
    var0.exitoffsets[ var1 ] = ( 150, 35, -45 );
    var0.exitdirections[ var1 ] = "left";
    var1 = "top_left";
    var0.exitoffsets[ var1 ] = ( 69, -40, -45 );
    var0.exitdirections[ var1 ] = "left";
    var1 = "back";
    var0.exitoffsets[ var1 ] = ( -355, 0, -45 );
    var0.exitdirections[ var1 ] = "back";
    var1 = "back_left";
    var0.exitoffsets[ var1 ] = ( -255, 255, -45 );
    var0.exitdirections[ var1 ] = "back";
    var1 = "back_right";
    var0.exitoffsets[ var1 ] = ( -200, -180, -45 );
    var0.exitdirections[ var1 ] = "right";
    var2 = [ "pilot", "seat_two", "seat_three", "seat_four" ];
    var3 = "pilot";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "veh_bt", var3, 1 );
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, var2 );
    var4.exitids = [ "right", "left", "top_left", "back", "back_left", "back_right" ];
    var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d8();
    var4.animtag = "tag_seat_0";
    var4.ref_12023 = "ping_vehicle_pilot";
    var3 = "seat_two";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "veh_bt", var3, 1 );
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, var2 );
    var4.exitids = [ "right", "left", "top_left", "back", "back_left", "back_right" ];
    var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
    var4.ref_13e8a = getcompleteweaponname( "tur_gun_bt_mp" );
    var4.ref_13e92 = "tur_gun_bt_mp";
    var4.animtag = "tag_seat_2";
    var4.ref_12023 = "ping_vehicle_gunner";
    var3 = "seat_three";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "veh_bt", var3, 1 );
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, var2 );
    var4.exitids = [ "right", "left", "top_left", "back", "back_left", "back_right" ];
    var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
    var4.ref_13e8a = getcompleteweaponname( "tur_gun_bt_mp" );
    var4.ref_13e92 = "tur_gun_bt_mp";
    var4.animtag = "tag_seat_3";
    var4.ref_12023 = "ping_vehicle_gunner";
    var3 = "seat_four";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "veh_bt", var3, 1 );
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, var2 );
    var4.exitids = [ "right", "back_left", "top_left", "right", "back_right", "top_right" ];
    var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
    var4.ref_13e8a = getcompleteweaponname( "tur_gun_bt_mp" );
    var4.ref_13e92 = "tur_gun_bt_mp";
    var4.animtag = "tag_seat_4";
    var4.ref_12023 = "ping_vehicle_gunner";
}

// Params 0
// Size: 0x39
function create_thrust_fire()
{
    var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( "veh_bt", 1 );
    scripts\cp_mp\vehicles\vehicle_interact::ref_1419d( "veh_bt", "single", [ "pilot", "seat_two", "seat_three", "seat_four" ] );
}

// Params 0
// Size: 0x1c5
function create_trophy_station()
{
    var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e( "veh_bt", 1 );
    var0.id = 20;
    var0.seatids[ "pilot" ] = 0;
    var0.seatids[ "seat_two" ] = 1;
    var0.seatids[ "seat_three" ] = 2;
    var0.seatids[ "seat_four" ] = 3;
    var0.ref_12da2[ 0 ] = 0;
    var0.ref_12da2[ 1 ] = 1;
    var0.ref_12da3[ "pilot" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "pilot" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "pilot" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "pilot" ][ "tur_gun_bt_mp" ] = 1;
    var0.ref_12da3[ "seat_two" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_two" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_two" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_two" ][ "tur_gun_bt_mp" ] = 1;
    var0.ref_12da3[ "seat_three" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_three" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_three" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_three" ][ "tur_gun_bt_mp" ] = 1;
    var0.ref_12da3[ "seat_four" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_four" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_four" ][ "tur_gun_bt_mp" ] = 0;
    var0.ref_12da3[ "seat_four" ][ "tur_gun_bt_mp" ] = 1;
}

// Params 0
// Size: 0xff
function create_struct_at()
{
    level.cruisepredator_watchownerdisownaction = getdvarfloat( "scr_br_bomber_health_override", 2250 );
    scripts\cp_mp\vehicles\vehicle_damage::ref_1416c( "veh_bt", level.cruisepredator_watchownerdisownaction, undefined, undefined, undefined, level.failx1stashquest );
    var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle( "veh_bt" );
    var0.class = "heavy";
    var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d( "veh_bt", "light" );
    var1.ref_12024 = &createalldestinationvfx;
    var1.ref_1202d = &createapcturret;
    var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d( "veh_bt", "medium" );
    var1.ref_12024 = &createallhistorydestinations;
    var1.ref_1202d = &createattractionicontrigger;
    var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d( "veh_bt", "heavy" );
    var1.ref_12024 = &createagenttargetloadout;
    var1.ref_1202d = &createandstartlights;
    scripts\cp_mp\vehicles\vehicle_damage::ref_1413d( "veh_bt" );
    scripts\cp_mp\vehicles\vehicle_damage::ref_14178( "veh_bt", 13 );
    scripts\cp_mp\vehicles\vehicle_damage::ref_14175( "veh_bt", &createdefaultrectangularzone );
    scripts\cp_mp\vehicles\vehicle_damage::ref_14171( "veh_bt", &create_oscilloscope );
    scripts\cp_mp\vehicles\vehicle_damage::ref_1417b( "tur_gun_bt_mp", 5 );
}

// Params 0
// Size: 0x81
function create_struct()
{
    var0 = _calloutmarkerping_predicted_log::ref_1410f( "veh_bt", 1 );
    var0.challengeevaluator = 2;
    var0.keycardlocs_chosen = 0.75;
    var0.is_using_stealth_debug = 350;
    var0.is_valid_station_name = 525;
    var0.is_two_hit_melee_weapon = 875;
    var0.isakimbomeleeweapon = 5;
    var0.isallowedweapon = 20;
    var0.isakimbo = 40;
    var0.isattachmentgrenadelauncher = 0;
    var0.isattachmentselectfire = 0;
    var0.isassaulting = 0;
}

// Params 0
// Size: 0x66
function create_temp_infil_structs()
{
    level._effect[ "bomber_explode" ] = loadfx( "vfx/iw8_br/island/veh/vfx_br3_bomber_death_exp.vfx" );
    level._effect[ "bomber_explode_grd" ] = loadfx( "vfx/iw8_br/island/veh/vfx_br3_bomber_death_exp_ground.vfx" );
    level._effect[ "bomber_bomb_explode_ground" ] = loadfx( "vfx/iw8_br/island/veh/vfx_br3_bomber_exp.vfx" );
    level._effect[ "bomber_bomb_explode_air" ] = loadfx( "vfx/iw8_br/island/veh/vfx_br3_bomber_exp.vfx" );
    level._effect[ "bomber_bomb_wind_vfx" ] = loadfx( "vfx/iw8_br/island/gameplay/vfx_br_parachute_wisp_01" );
}

#using_animtree( "" );

// Params 0
// Size: 0x38
function create_solution_digit_mark()
{
    level.scr_anim[ "bomber" ][ "spin_up" ] = %sdr_mp_veh_bt_spin_up;
    level.scr_anim[ "bomber" ][ "spin_down" ] = $sdr_mp_veh_bt_spin_down;
}

// Params 0
// Size: 0x15
function create_usb_anim_rig()
{
    game[ "dialog" ][ "bt_loadout_destroyed" ] = "loadout_drop_destroyed_temp";
}

// Params 0
// Size: 0x16
function create_silencer_pick_ups()
{
    var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_bt" );
    return var0.ref_13e92;
}

// Params 2
// Size: 0x20a
function create_mp_version_of_vehicle( var0, var1 )
{
    if ( !isdefined( var0.angles ) )
    {
        var0.angles = ( 0, 0, 0 );
    }
    
    var0.modelname = "veh_s4_mil_air_bomber_wz";
    var0.targetname = "veh_bt";
    
    if ( !isdefined( var0.vehicletype ) )
    {
        var0.vehicletype = "bt_mp";
    }
    
    var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle( var0, var1 );
    
    if ( !isdefined( var2 ) )
    {
        return undefined;
    }
    
    var3 = create_silencer_pick_ups();
    var4 = create_name_fx( var2, var3, "veh_s4_mil_air_bomber_turret_nose_wz", "tag_gunner_turret1_rot", ( 0, 0, 0 ) );
    scripts\cp_mp\vehicles\vehicle::ref_14207( var2, var4, getcompleteweaponname( var3 ), undefined, "seat_two" );
    var4 settoparc( 28 );
    var4 setbottomarc( 37 );
    var4 setrightarc( 96 );
    var4 setleftarc( 96 );
    var4 = create_name_fx( var2, var3, "veh_s4_mil_air_bomber_turret_tail_wz", "tag_gunner_turret2_rot", ( 0, 0, 0 ) );
    scripts\cp_mp\vehicles\vehicle::ref_14207( var2, var4, getcompleteweaponname( var3 ), undefined, "seat_three" );
    var4 settoparc( 28 );
    var4 setbottomarc( 37 );
    var4 setrightarc( 92 );
    var4 setleftarc( 92 );
    var4 = create_name_fx( var2, var3, "veh_s4_mil_air_bomber_turret_belly_wz", "tag_gunner_turret3_rot", ( 0, 0, 0 ) );
    scripts\cp_mp\vehicles\vehicle::ref_14207( var2, var4, getcompleteweaponname( var3 ), undefined, "seat_four" );
    var4 settoparc( 0 );
    scripts\cp_mp\vehicles\vehicle::ref_14138( var2, "veh_bt", var0 );
    var2.objweapon = getcompleteweaponname( "tur_gun_bt_mp" );
    var2.ref_13e92 = var3;
    var2.dropbombs = [];
    
    for ( var5 = 0; var5 < level.farah_nobraids_body ; var5++ )
    {
        var2.dropbombs[ var2.dropbombs.size ] = 0;
    }
    
    var2.shouldmodeplayfinalmoments = 0;
    var2.ref_120b4 = level.find_ai_spawner;
    thread cruisepredator_detachplayerfromintro();
    thread cruisepredator_watchintropoddisown();
    _calloutmarkerping_predicted_timeout::ref_1412b( var2 );
    scripts\cp_mp\vehicles\vehicle::ref_14139( var2, var0 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_bt", "create" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_bt", "create" ) ]]( var2 );
    }
    
    thread helis_assault3_hangar_check_size();
    thread current_ally_volume();
    
    if ( level.ffsm_landed_stateenter )
    {
        var2 unmarkkeyframedmover( 1 );
    }
    
    return var2;
}

// Params 0
// Size: 0x50e
function helis_assault3_hangar_check_size()
{
    var0 = self;
    var0 endon( "death" );
    var0 vehphys_enablecollisioncallback( 1 );
    
    if ( getdvarint( "scr_br_bt_invincible", 0 ) )
    {
        return;
    }
    
    wait 5;
    var1 = [];
    
    for ( var2 = [];  ; var2 = min( var24 * level.∏$Ç£á8?ÔÂE¡Îç£HJ®)zG”ìˇmKß, var0.maxhealth ) )
    {
        var0 waittill( "collision", var3, var4, var5, var6, var7, var8, var9, var10, var11 );
        
        if ( isdefined( var10 ) && isdefined( var10.helperdronetype ) && var10.helperdronetype == "radar_drone_recon" )
        {
            continue;
        }
        
        if ( istrue( level.fake_digit_pool ) && !istrue( var0.shouldmodeplayfinalmoments ) )
        {
            continue;
        }
        
        if ( isdefined( var10.model ) )
        {
            if ( unset_bullet_shields( var10 ) )
            {
                if ( isdefined( var10.owner ) && isdefined( var0.owner ) && var10.owner == var0.owner )
                {
                    continue;
                }
                
                createteamdefenderflagbase( var10 );
                
                if ( isdefined( var0 ) )
                {
                    createquestobjicon( var0, 9000, var10, var7 );
                }
                
                continue;
            }
            
            if ( istrue( var0.shouldmodeplayfinalmoments ) && ( unresolvedcollisiontolerancesqr( var10 ) || var10 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() ) )
            {
                if ( isdefined( var10.owner ) && isdefined( var0.owner ) && var10.owner.team != var0.owner.team )
                {
                    var12 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var0 );
                    
                    foreach ( var14 in var12 )
                    {
                        var14 dodamage( 20, var0.origin, var10.owner, var14, "MOD_EXPLOSIVE", "tur_gun_bt_mp" );
                    }
                    
                    var16 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var10 );
                    
                    foreach ( var14 in var16 )
                    {
                        var14 dodamage( 20, var0.origin, var0.owner, var14, "MOD_EXPLOSIVE", "tur_gun_bt_mp" );
                    }
                }
                
                var0 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 1 );
                var0 dodamage( 9000, var7, undefined, undefined, "MOD_CRUSH" );
                var0 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
                var10 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 1 );
                var10 dodamage( 9000, var7, undefined, undefined, "MOD_CRUSH" );
                var10 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
                continue;
            }
        }
        
        var19 = 1;
        var20 = 0;
        var21 = 0;
        
        switch ( var11 )
        {
            case 0:
                var19 = level.fake_hit_target_monitor;
                break;
            case 1:
                var19 = level.fake_magic_grenade_watch;
                var20 = 1;
                break;
            case 2:
                var21 = 1;
                break;
            default:
                break;
        }
        
        if ( var20 )
        {
            var22 = var19;
        }
        else
        {
            var22 = var9 * var19;
        }
        
        if ( istrue( level.failstringsetup ) )
        {
            var23 = length( var0 vehicle_getvelocity() - var0.current_automated_respawn_timer_value );
            var22 *= var23 / 17.6;
        }
        
        if ( abs( angleclamp180( var0.angles[ 0 ] ) > level.fake_model ) )
        {
            var22 *= level.fake_magic_grenade_watch_individual;
        }
        
        if ( abs( var0.angles[ 2 ] ) > level.fakeprops )
        {
            var22 *= level.fake_trigger_think;
        }
        
        if ( var0.angles[ 2 ] > 90 || var0.angles[ 2 ] < -90 )
        {
            var22 *= level.fallback_index;
        }
        
        var24 = 0;
        
        if ( var22 > level.final_wave )
        {
            var24 = var0.maxhealth;
        }
        else if ( var22 > level.final_switch_think )
        {
            var25 = level.final_wave - level.final_switch_think;
            var26 = ( var22 - level.final_switch_think ) / var25;
            var27 = var0.maxhealth * level.filtervehiclespawnstructsfunc;
            var28 = var0.maxhealth * level.filtervehiclespawnstructs;
            var24 = scripts\engine\math::lerp( var27, var28, var26 );
        }
        else if ( var22 > level.final_radius_think )
        {
            var24 = var0.maxhealth * level.fillmaxarmorplate;
        }
        
        var29 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( var0 );
        
        if ( !isdefined( var29 ) )
        {
            var24 *= level.fake_exploder;
        }
        
        var30 = -1;
        
        if ( var11 != 1 )
        {
            var30 = abs( vectordot( var8, vectornormalize( var0.current_automated_respawn_timer_value ) ) );
            var31 = 1;
            
            if ( var21 && var9 < level.Ω!ZÛ–7‹¯wË≈cê'Ofk#:á“@ß‰ﬁ∏-üõ√˚ )
            {
                var31 = 0;
            }
            
            if ( var31 )
            {
                if ( var30 > level.falling_xyratio )
                {
                    var24 += var0.maxhealth * 0.25 + randomintrange( 50, 100 );
                }
                else if ( var30 > level.fananim )
                {
                    var24 *= level.findquestplacement;
                }
                else if ( level.farah_disable_ai_color_before_hallway_takedown > 0 && var30 <= level.fananim )
                {
                    var24 *= level.farah_disable_ai_color_before_hallway_takedown;
                }
            }
        }
        else
        {
            var24 += 550;
        }
        
        if ( isdefined( var1[ var11 ] ) && var1[ var11 ] > gettime() )
        {
            if ( var24 < var2[ var11 ] )
            {
                continue;
            }
        }
        
        if ( var21 && var24 > 0 )
        {
            if ( level.£√&é}ñvπÌ9YÿXõå-7ÏŸ+…FX÷¬;¨ )
            {
                continue;
            }
            
            if ( level.¢,ƒ£Î'+å´¨c∞7å“sŒ≥VX‰ë,⁄,vY && var30 <= level.ÅC "ã?8(√Î„”M…`õK∂Pß2îª3àt+:áåÛq˝ )
            {
                continue;
            }
        }
        
        if ( var24 > 0 )
        {
            createquestobjicon( var0, var24, var10, var7 );
            var1 = gettime() + level.á®j·Òó°1Rzπç√ç»≠„ıI¯ùOYk;
        }
    }
}

// Params 0
// Size: 0x2d
function current_ally_volume()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0.current_automated_respawn_timer_value = 0;
    
    for ( ;; )
    {
        waittillframeend();
        var0.current_automated_respawn_timer_value = var0 vehicle_getvelocity();
        waitframe();
    }
}

// Params 3
// Size: 0xbb
function createquestobjicon( var0, var1, var2 )
{
    var3 = self;
    
    if ( var0 > 650 )
    {
        cull_list_of_players( var3, "screenshake_bt_coll_damage", "rumble_bt_coll_damage" );
    }
    
    var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 1 );
    
    if ( var3.health - var0 <= 0 )
    {
        if ( !istrue( var3.should_play_player_infil ) && ( var1.classname == "worldspawn" || var1 == var3 ) )
        {
            createteamdefenderflag();
        }
        else
        {
            var3 dodamage( var0, var2, undefined, undefined, "MOD_CRUSH" );
            var3 radiusdamage( var3.origin, 512, 200, 80, var3, "MOD_EXPLOSIVE", "tur_gun_bt_mp" );
            var3.brlootchoppercrateactivatecallback = 1;
            var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
            return;
        }
    }
    
    var3 dodamage( var0, var2, undefined, undefined, "MOD_CRUSH" );
    var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
}

// Params 0
// Size: 0xe0
function createteamdefenderflag()
{
    var0 = self;
    var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var0 );
    
    foreach ( var3 in var1 )
    {
        var3.donotmodifydamage = 1;
        var3 dodamage( 99, var0.origin, var3, var3, "MOD_RIFLE_BULLET", "tur_gun_bt_mp" );
        var3.donotmodifydamage = undefined;
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( var0 );
    
    foreach ( var6 in var1 )
    {
        var6.plotarmor = 1;
    }
    
    var0 radiusdamage( var0.origin, 512, 200, 80, var0, "MOD_EXPLOSIVE", "tur_gun_bt_mp" );
    var0.brlootchoppercrateactivatecallback = 1;
    
    foreach ( var6 in var1 )
    {
        var6.plotarmor = 0;
    }
}

// Params 5
// Size: 0x8c
function create_name_fx( var0, var1, var2, var3, var4 )
{
    var5 = spawnturret( "misc_turret", var0 gettagorigin( var3 ), var1, 0 );
    var5 linkto( var0, var3, var4, ( 0, 0, 0 ) );
    var5 setmodel( var2 );
    var5 setmode( "sentry_offline" );
    var5 setsentryowner( undefined );
    var5 makeunusable();
    var5 setdefaultdroppitch( 0 );
    var5 setturretmodechangewait( 1 );
    var5.angles = var0.angles;
    var5.vehicle = var0;
    var5.maxhealth = 999999;
    var5.health = var5.maxhealth;
    return var5;
}

// Params 2
// Size: 0x1a0
function create_script_wait_for_flags( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = spawnstruct();
        var0.inflictor = self;
        var0.objweapon = "tur_gun_bt_mp";
        var0.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner.br_pe_chopper_damage_time = var0.meansofdeath;
    }
    
    self notify( "predeath" );
    
    if ( istrue( level.finale_main ) )
    {
        wait 0.2;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    scripts\cp_mp\vehicles\vehicle_damage::ref_14162( var0 );
    self setscriptablepartstate( "fx", "base" );
    self setscriptablepartstate( "cloud_contrail", "base" );
    self setscriptablepartstate( "fast_contrail", "base" );
    self setscriptablepartstate( "engine_smoke", "base" );
    
    if ( isdefined( self.isballisticspecial ) )
    {
        foreach ( var3 in self.isballisticspecial )
        {
            self setscriptablepartstate( var3, "off" );
        }
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants( self, var0 );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals( undefined, undefined, 1 );
    thread create_passengers_unload_groups();
    var5 = self gettagorigin( "tag_origin" );
    
    if ( !istrue( self.brlootchoppercrateactivatecallback ) )
    {
        self radiusdamage( self.origin, 512, 200, 80, self, "MOD_EXPLOSIVE", "tur_gun_bt_mp" );
    }
    
    var6 = scripts\engine\utility::ter_op( self.shouldmodeplayfinalmoments, "bomber_explode", "bomber_explode_grd" );
    playfx( scripts\engine\utility::getfx( var6 ), var5, anglestoforward( self.angles ), anglestoup( self.angles ) );
    
    if ( soundexists( "s4_bt_bomb_expl_trans" ) )
    {
        playsoundatpos( var5, "s4_bt_bomb_expl_trans" );
    }
    
    earthquake( 0.4, 800, var5, 0.7 );
    playrumbleonposition( "grenade_rumble", var5 );
    physicsexplosionsphere( var5, 500, 200, 1 );
}

// Params 0
// Size: 0xf4
function cruisepredator_watchintropoddisown()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    wait 2;
    var1 = 1;
    var2 = [ var0 ];
    
    for ( ;; )
    {
        var3 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
        var4 = var0.origin + anglestoup( var0.angles ) * -600;
        var5 = scripts\engine\trace::ray_trace( var0.origin, var4, var2, var3, 0 );
        
        if ( isdefined( var5 ) )
        {
            if ( var1 && var5[ "hittype" ] == "hittype_none" )
            {
                if ( !istrue( level.finale ) )
                {
                    var0 setscriptablepartstate( "landing_gear", "closing", 0 );
                }
                
                var0 setscriptablepartstate( "bay_door", "bay_door_opening", 0 );
                var1 = 0;
            }
            else if ( !var1 && var5[ "hittype" ] != "hittype_none" )
            {
                if ( !istrue( level.finale ) )
                {
                    var0 setscriptablepartstate( "landing_gear", "opening", 0 );
                }
                
                var0 setscriptablepartstate( "bay_door", "bay_door_closing", 0 );
                var1 = 1;
            }
        }
        
        wait 0.3;
    }
}

// Params 0
// Size: 0x132
function cruisepredator_detachplayerfromintro()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0.curr_airlock_pos = 0;
    var0.should_play_player_infil = 0;
    
    for ( ;; )
    {
        var1 = [ var0 ];
        
        if ( isdefined( var0.waittill_player_picksup_armor ) )
        {
            var1 = [ var0, var0.waittill_player_picksup_armor ];
        }
        
        var2 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
        var3 = scripts\engine\trace::ray_trace( var0.origin, var0.origin - ( 0, 0, 150 ), var1, var2, 0 );
        
        if ( isdefined( var3 ) )
        {
            if ( var3[ "hittype" ] == "hittype_none" )
            {
                var0.shouldmodeplayfinalmoments = 1;
                var0.should_play_player_infil = 1;
                var0 setscriptablepartstate( "single", "vehicle_use_in_air" );
            }
            else if ( istrue( var0.shouldmodeplayfinalmoments ) )
            {
                cull_list_of_players( var0, "screenshake_bt_land", "rumble_bt_land" );
                var0.shouldmodeplayfinalmoments = 0;
                var0 setscriptablepartstate( "single", "vehicle_use" );
            }
        }
        
        var4 = regroup_process_started( var0 );
        
        if ( var0.curr_airlock_pos != var4 && isdefined( var0.owner ) )
        {
            var0.curr_airlock_pos = var4;
            cs_flags_init( var0.owner, 1 );
        }
        
        wait 0.2;
    }
}

// Params 0
// Size: 0x36
function create_passengers_unload_groups()
{
    scripts\cp_mp\vehicles\vehicle::ref_14185( self );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_bt", "delete" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_bt", "delete" ) ]]( self );
    }
    
    waitframe();
    scripts\cp_mp\vehicles\vehicle::ref_14186( self );
}

// Params 1
// Size: 0x27, Type: bool
function createdefaultrectangularzone( var0 )
{
    if ( isdefined( var0.damage ) && var0.damage > 0 )
    {
        self notify( "damage_taken", var0 );
    }
    
    return true;
}

// Params 1
// Size: 0xe, Type: bool
function create_oscilloscope( var0 )
{
    thread create_script_wait_for_flags( var0 );
    return true;
}

// Params 2
// Size: 0x23
function create_silencer_pick_up( var0, var1 )
{
    if ( !isdefined( var0.turrets ) || !isdefined( var1 ) )
    {
        return undefined;
    }
    
    return var0.turrets[ var1 ];
}

// Params 0
// Size: 0x73
function createdevguientryforkidnapper()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0 endon( "propeller_spin_up" );
    var0 notify( "propeller_spin_down" );
    
    if ( istrue( var0.ref_128e9 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "spin_up", 0 );
    var0.ref_128e9 = 1;
    wait getanimlength( level.scr_anim[ "bomber" ][ "spin_up" ] );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "idle", 0 );
}

// Params 0
// Size: 0x70
function createdestinationvfx()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0 endon( "propeller_spin_down" );
    var0 notify( "propeller_spin_up" );
    
    if ( !isdefined( var0.ref_128e9 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "spin_down", 0 );
    var0.ref_128e9 = undefined;
    wait getanimlength( level.scr_anim[ "bomber" ][ "spin_down" ] );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "idle_no_spin", 0 );
}

// Params 1
// Size: 0xd4
function create_primary_weapon_obj_from_custom_loadout( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1.isballisticspecial ) )
    {
        var1.isballisticspecial = [];
    }
    
    if ( !scripts\engine\utility::array_contains( var1.isballisticspecial, "left_wing_damage" ) && randomfloat( 1 ) < 0.4 )
    {
        var1.isballisticspecial[ var1.isballisticspecial.size ] = "left_wing_damage";
    }
    
    if ( !scripts\engine\utility::array_contains( var1.isballisticspecial, "right_wing_damage" ) && randomfloat( 1 ) < 0.4 )
    {
        var1.isballisticspecial[ var1.isballisticspecial.size ] = "right_wing_damage";
    }
    
    if ( var0 && !scripts\engine\utility::array_contains( var1.isballisticspecial, "tail_damage" ) && randomfloat( 1 ) < 0.5 )
    {
        var1.isballisticspecial[ var1.isballisticspecial.size ] = "tail_damage";
        return;
    }
}

// Params 1
// Size: 0x36
function createc130pathstruct( var0 )
{
    var1 = self;
    
    foreach ( var3 in var1.isballisticspecial )
    {
        var1 setscriptablepartstate( var3, var0, 0 );
    }
}

// Params 2
// Size: 0x25
function createalldestinationvfx( var0, var1 )
{
    var2 = self;
    create_primary_weapon_obj_from_custom_loadout( var2, 0 );
    createc130pathstruct( var2, "light" );
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14165( var0, var1 );
}

// Params 2
// Size: 0x11
function createapcturret( var0, var1 )
{
    var2 = self;
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416a( var0, var1 );
}

// Params 2
// Size: 0x26
function createallhistorydestinations( var0, var1 )
{
    var2 = self;
    create_primary_weapon_obj_from_custom_loadout( var2, 1 );
    createc130pathstruct( var2, "medium" );
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14167( var0, var1 );
}

// Params 2
// Size: 0x11
function createattractionicontrigger( var0, var1 )
{
    var2 = self;
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416b( var0, var1 );
}

// Params 2
// Size: 0x26
function createagenttargetloadout( var0, var1 )
{
    var2 = self;
    create_primary_weapon_obj_from_custom_loadout( var2, 1 );
    createc130pathstruct( var2, "heavy" );
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14163( var0, var1 );
}

// Params 2
// Size: 0x11
function createandstartlights( var0, var1 )
{
    var2 = self;
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14169( var0, var1 );
}

// Params 0
// Size: 0x30
function ref_1327d()
{
    level.createprematchloadout = spawnstruct();
    level.createprematchloadout.powers = [];
    bhadriotshield( level.createprematchloadout, "dropbomb", "+attack", &createscript_covernodes );
}

// Params 1
// Size: 0x66
function ref_14231( var0 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( var2 in var0.powers )
    {
        foreach ( var4 in var2.clients_hacked )
        {
            self notifyonplayercommand( var6, var4 );
        }
    }
}

// Params 1
// Size: 0x6d
function ref_14230( var0 )
{
    if ( !isdefined( self ) || isbot( self ) )
    {
        return;
    }
    
    foreach ( var2 in var0.powers )
    {
        foreach ( var4 in var2.clients_hacked )
        {
            self notifyonplayercommandremove( var6, var4 );
        }
    }
}

// Params 4
// Size: 0x42
function bhadriotshield( var0, var1, var2, var3 )
{
    if ( isstring( var2 ) )
    {
        var2 = [ var2 ];
    }
    
    var0.powers[ var1 ] = spawnstruct();
    var0.powers[ var1 ].clients_hacked = var2;
    var0.powers[ var1 ].func = var3;
}

// Params 2
// Size: 0x47
function cs_setup_arrays( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( var2.vehicle ) )
    {
        return;
    }
    
    var2.vehicle.turret.turreton = 1;
    var2.vehicle.turret setmode( "manual" );
    thread csm_alg();
}

// Params 0
// Size: 0x56
function csm_alg()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_bomber" );
    var0.vehicle endon( "death" );
    var1 = var0.vehicle.turret;
    var2 = 6;
    
    for ( ;; )
    {
        var1 shootturret( "tag_flash", var2 );
        wait level.ffsm_state;
        
        if ( !var0 attackbuttonpressed() )
        {
            return;
        }
    }
}

// Params 2
// Size: 0x190
function createscript_covernodes( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( var2.vehicle.dropbombs ) )
    {
        return;
    }
    
    var3 = -1;
    
    for ( var4 = 0; var4 < var2.vehicle.dropbombs.size ; var4++ )
    {
        if ( var2.vehicle.dropbombs[ var4 ] == 0 )
        {
            var3 = var4;
        }
    }
    
    if ( var3 < 0 )
    {
        if ( isdefined( level.ref_13352 ) )
        {
            [[ level.ref_13352 ]]( "BT_RELEASE/DROP_BOMB_NO_AMMO" );
        }
        
        var2 playlocalsound( "br_pickup_deny" );
        return;
    }
    
    if ( abs( var2.vehicle.angles[ 2 ] ) > level.find_plunder || abs( angleclamp180( var2.vehicle.angles[ 0 ] ) ) > level.find_and_run_elevator_spawngroup )
    {
        if ( isdefined( level.ref_13352 ) )
        {
            [[ level.ref_13352 ]]( "BT_RELEASE/PLANE_LEVEL_WITH_GROUND" );
        }
        
        var2 playlocalsound( "br_pickup_deny" );
        return;
    }
    
    var5 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
    var6 = [];
    var7 = scripts\engine\trace::ray_trace( var2.vehicle.origin, var2.vehicle.origin - ( 0, 0, level.finale_setup ), var6, var5, 0 );
    
    if ( isdefined( var7 ) )
    {
        if ( var7[ "hittype" ] != "hittype_none" )
        {
            if ( isdefined( level.ref_13352 ) )
            {
                [[ level.ref_13352 ]]( "BT_RELEASE/DROP_BOMB_GROUND_TOO_CLOSE" );
            }
            
            var2 playlocalsound( "br_pickup_deny" );
            return;
        }
    }
    
    if ( istrue( var2.vehicle.turn_on_search_light ) )
    {
        return;
    }
    else
    {
        var2.vehicle.turn_on_search_light = 1;
    }
    
    cull_list_of_players( var2.vehicle, "screenshake_bt_shoot", "rumble_bt_shoot" );
    thread createstreakinfo_ai_turret( var2 );
}

// Params 1
// Size: 0x174
function createstreakinfo_ai_turret( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "disconnect" );
    var2 = ctf_bot_defender_limit_for_team( var1 );
    var3 = var1.vehicle;
    var3 endon( "death" );
    var4 = var3.origin;
    
    if ( isdefined( var2 ) )
    {
        var4 = var2;
    }
    
    if ( isdefined( level.cumulative_damage_monitor ) )
    {
        foreach ( var6 in level.players )
        {
            if ( var1 == var6 )
            {
                continue;
            }
            
            if ( isdefined( var6.vehicle ) && var6.vehicle == var3 )
            {
                continue;
            }
            
            if ( var6.origin[ 2 ] > var4[ 2 ] )
            {
                continue;
            }
            
            var7 = distance2dsquared( var6.origin, var4 );
            
            if ( var7 < 2890000 )
            {
                if ( !isdefined( var6.cratephysicsoff ) )
                {
                    var6.cratephysicsoff = 1;
                    thread ref_12511();
                    
                    if ( var1.team != var6.team )
                    {
                        var6 thread [[ level.cumulative_damage_monitor ]]( "br_bt_bomb_alert_enemy" );
                    }
                }
            }
        }
    }
    
    if ( soundexists( "s4_bt_bomb_deploy_3d" ) )
    {
        var3 playsoundtoplayer( "s4_bt_bomb_deploy_3d", var1 );
    }
    
    var3.dropbombs[ var0 ] = level.failsmokinggunquest;
    
    if ( isdefined( var1 ) )
    {
        cs_flags_init( var1, 1 );
    }
    
    var3.watch_for_players_ledgespawners = gettime();
    thread crushing_players( var1 );
    thread createscreeneffectext( var3 );
    wait level.farobjectiveiconid;
    var3.turn_on_search_light = 0;
}

// Params 0
// Size: 0x166
function ctf_bot_defender_limit_for_team()
{
    var0 = self;
    var1 = var0.vehicle;
    var2 = ( 0, 0, 0 );
    var3 = -800;
    var4 = 0;
    var5 = undefined;
    var6 = 15;
    var7 = 0.2;
    var8 = ( var7, var7, var7 );
    
    if ( level.failtimedrunquest >= 0 && isdefined( var0.vehicle ) )
    {
        var9 = var1 getentityvelocity();
        var4 = ( var9[ 0 ] * level.failtimedrunquest, var9[ 1 ] * level.failtimedrunquest, var2[ 2 ] );
    }
    
    var10 = var1.origin;
    var11 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
    var12 = [ var1, var0 ];
    var5 = var4;
    var13 = var7;
    
    while ( var13 < var6 )
    {
        var14 = var13 - var7;
        var15 = var2[ 2 ] + var13 * var3;
        
        if ( var15 > level.failx1finquest )
        {
            var5 = ( var4[ 0 ], var4[ 1 ], level.failx1finquest );
        }
        
        var16 = var5 * var14 + ( 0, 0, 0.5 * var3 * var14 * var14 );
        var17 = var5 * var13 + ( 0, 0, 0.5 * var3 * var13 * var13 );
        var18 = var10 + var16;
        var19 = var10 + var17;
        var20 = scripts\engine\trace::ray_trace( var18, var19, var12, var11, 0 );
        
        if ( isdefined( var20 ) && var20[ "fraction" ] < 1 )
        {
            var19 = var20[ "position" ] + ( 0, 0, 20 );
            return var19;
        }
        
        var13 += var7;
    }
}

// Params 0
// Size: 0x23
function ref_12511()
{
    var0 = self;
    var0 endon( "disconnect" );
    level endon( "game_ended" );
    wait 7;
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0.cratephysicsoff = undefined;
}

// Params 1
// Size: 0x6b
function createscreeneffectext( var0 )
{
    var1 = self;
    var1 endon( "death" );
    level endon( "game_ended" );
    
    if ( !isdefined( var1.owner ) )
    {
        return;
    }
    
    var2 = var1.owner;
    var2 endon( "bt_bomb_force_refill" );
    
    while ( var1.dropbombs[ var0 ] > 0 )
    {
        var1.dropbombs[ var0 ] -= 0.05;
        wait 0.05;
    }
    
    createscriptedspawnpoint( var1, 1, var0 );
}

// Params 1
// Size: 0x1fe
function crushing_players( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "disconnect" );
    var1 notify( "bomber_new_bomb_drop" );
    var2 = scripts\engine\utility::spawn_tag_origin();
    var2 setmodel( "lm_ach_gp_bomb_600lb_01_gameplay" );
    var2 setcandamage( 1 );
    var2.origin = var0;
    var2.angles = ( 0, 0, 0 );
    var2.health = 9000;
    var2 show();
    var2.owner = var1;
    var2.ref_123a8 = 0;
    var2 playloopsound( "s4_bt_bomb_drop_tonal_lp" );
    thread create_fake_loot_model_from_struct();
    
    if ( isdefined( var1.vehicle ) )
    {
        var1.vehicle.waittill_player_picksup_armor = var2;
    }
    
    if ( !isdefined( level.ref_123a9 ) )
    {
        level.ref_123a9 = [];
    }
    
    level.ref_123a9[ level.ref_123a9.size ] = var2;
    var3 = ( 0, 0, -1 );
    
    if ( level.failtimedrunquest >= 0 && isdefined( var1.vehicle ) )
    {
        var4 = var1.vehicle getentityvelocity();
        var3 = ( var4[ 0 ] * level.failtimedrunquest, var4[ 1 ] * level.failtimedrunquest, var3[ 2 ] );
    }
    
    var2.velocity = var3;
    var2 movegravity( var3, 60 );
    thread current_button_counter();
    var5 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
    var6 = [ var2 ];
    
    if ( istrue( level.fake_agent_model_setup ) )
    {
        thread ref_12513( var1 );
    }
    
    thread current_cypher_pieces();
    
    for ( ;; )
    {
        var7 = var2.origin;
        waitframe();
        var8 = scripts\engine\trace::ray_trace( var7, var2.origin, var6, var5, 0 );
        
        if ( isdefined( var8 ) && var8[ "fraction" ] < 1 )
        {
            var2.origin = var8[ "position" ] + ( 0, 0, 20 );
            createteamdefenderflagbase( var2 );
            break;
        }
        
        if ( var2.velocity[ 2 ] > level.failx1finquest )
        {
            var2.velocity = ( var2.velocity[ 0 ], var2.velocity[ 1 ], level.failx1finquest );
        }
    }
}

// Params 0
// Size: 0x29
function current_cypher_pieces()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    waitframe();
    playfxontag( level._effect[ "bomber_bomb_wind_vfx" ], var0, "tag_origin" );
}

// Params 1
// Size: 0x108
function ref_12513( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "disconnect" );
    wait level.findvalidspectateprop;
    
    if ( !isdefined( var1.gas_vfx_range_think ) )
    {
        var1.gas_vfx_range_think = 0;
    }
    
    var1.gas_vfx_range_think += 1;
    thread ref_12515( var1 );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1.vehicle method_87d7( var0 );
    var1 setclientomnvar( "ui_airplane_ads_active", 0 );
    var2 = "timeout";
    thread ref_12514( var1 );
    
    for ( ;; )
    {
        if ( !isdefined( var2 ) )
        {
            return;
        }
        
        if ( var2 == "exiting_pilot_seat_bomber" )
        {
            var1.gas_vfx_range_think -= 1;
            var1 setclientomnvar( "ui_airplane_ads_active", 0 );
            return;
        }
        
        if ( !var1 adsbuttonpressed() || var2 == "exiting_pilot_seat_bomber" )
        {
            var1.gas_vfx_range_think -= 1;
            var1 setclientomnvar( "ui_airplane_ads_active", 0 );
            var1.vehicle method_87d7();
            return;
        }
        
        if ( var2 == "bomber_camera_bomb_exploded" )
        {
            return;
        }
        
        var2 = scripts\engine\utility::waittill_any_in_array_or_timeout( [ "exiting_pilot_seat_bomber", "bomber_camera_bomb_exploded" ], 1 );
    }
}

// Params 1
// Size: 0x76
function ref_12514( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "bomber_new_bomb_drop" );
    var1 endon( "bomber_pilot_stop_ads" );
    
    while ( isdefined( var0 ) )
    {
        wait 0.1;
    }
    
    thread ref_12515( var1 );
    var1.gas_vfx_range_think -= 1;
    
    if ( var1 adsbuttonpressed() && var1.gas_vfx_range_think == 0 )
    {
        var1 setclientomnvar( "ui_airplane_ads_active", 1 );
    }
    
    var1 notify( "bomber_camera_bomb_exploded" );
}

// Params 1
// Size: 0x52
function ref_12515( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "bomber_new_bomb_drop" );
    var1 notify( "bomber_new_fade" );
    var1 endon( "bomber_new_fade" );
    
    if ( isdefined( level.critical_messages ) )
    {
        var1 thread [[ level.critical_messages ]]();
    }
    
    wait var0;
    
    if ( isdefined( level.createzombieloadout ) )
    {
        var1 thread [[ level.createzombieloadout ]]();
        return;
    }
}

// Params 0
// Size: 0x47
function current_button_counter()
{
    var0 = self;
    
    while ( isdefined( var0 ) && isdefined( var0.ref_123a8 ) && !istrue( var0.ref_123a8 ) )
    {
        if ( var0.origin[ 2 ] < -10000 )
        {
            createteamdefenderflagbase( var0 );
            break;
        }
        
        wait 0.5;
    }
}

// Params 0
// Size: 0x2b
function create_fake_loot_model_from_struct()
{
    var0 = self;
    var0 endon( "death" );
    level endon( "game_ended" );
    wait 1;
    var0 waittill( "damage" );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    createteamdefenderflagbase( var0 );
}

// Params 0
// Size: 0xa99
function createteamdefenderflagbase()
{
    var0 = self;
    var0.ref_123a8 = 1;
    var0 stoploopsound( "s4_bt_bomb_drop_tonal_lp" );
    level.ref_123a9 = scripts\engine\utility::array_remove( level.ref_123a9, var0 );
    
    if ( !isdefined( var0.owner ) )
    {
        var0 delete();
        return;
    }
    
    var1 = var0.origin;
    var2 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
    var3 = [];
    var4 = scripts\engine\trace::ray_trace( var1, var1 - ( 0, 0, 100 ), var3, var2, 0 );
    var5 = spawnfx( scripts\engine\utility::getfx( "bomber_bomb_explode_ground" ), var1 );
    
    if ( isdefined( var4 ) )
    {
        if ( var4[ "hittype" ] == "hittype_none" )
        {
            var5 = spawnfx( scripts\engine\utility::getfx( "bomber_bomb_explode_air" ), var1, anglestoforward( var0.angles ), anglestoup( var0.angles ) );
        }
    }
    
    playsoundatpos( var1, "s4_bt_bomb_expl_trans" );
    earthquake( 0.4, 800, var1, 0.7 );
    playrumbleonposition( "grenade_rumble", var1 );
    physicsexplosionsphere( var1, 500, 200, 1 );
    var5 unmarkkeyframedmover( 1 );
    triggerfx( var5 );
    thread createobjectivelist( var5 );
    var0.owner.current_count_down = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
    
    if ( istrue( level.farah_says_cut_wire_yellow ) )
    {
        var6 = canceljoins( undefined, undefined, var1, 980 );
        
        if ( isdefined( var6 ) )
        {
            foreach ( var8 in var6 )
            {
                if ( isdefined( level.ref_11a22 ) )
                {
                    [[ level.ref_11a22 ]]( var8 );
                    var0.owner.current_count_down[ 5 ] += 1;
                LOC_000001de:
                }
            LOC_000001de:
            }
        }
    }
    
    var10 = [];
    
    if ( isdefined( level.resttimems ) )
    {
        var10 = [[ level.resttimems ]]( var1, 980 );
    }
    
    var2 = scripts\engine\trace::create_contents( 1, 1, 0, 0, 0, 1, 1 );
    var3 = [ var0 ];
    
    foreach ( var12 in var10 )
    {
        var4 = scripts\engine\trace::ray_trace( var1 + ( 0, 0, 50 ), var12.origin + ( 0, 0, 50 ), var3, var2, 0 );
        
        if ( isdefined( var4[ "surfaceflags" ] ) && var4[ "surfaceflags" ] == 0 )
        {
            if ( var12.team != var0.owner.team )
            {
                if ( isdefined( level.createpropspeclist ) )
                {
                    var13 = [[ level.createpropspeclist ]]( var12 );
                    
                    if ( istrue( var13 ) )
                    {
                        var0.owner.current_count_down[ 3 ] += 1;
                    }
                    else
                    {
                        var0.owner.current_count_down[ 4 ] += 1;
                    }
                }
                
                var12 dodamage( 60, var1, var0.owner, var0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb" );
            }
        }
        
        var12 earthquakeforplayer( 0.35, 2, var1, 980 );
        var4 = scripts\engine\trace::ray_trace( var12.origin + ( 0, 0, 25 ), var1 + ( 0, 0, 75 ), var3, var2, 0 );
        
        if ( isdefined( var4[ "hittype" ] ) && var4[ "hittype" ] == "hittype_none" )
        {
            var12 thread scripts\cp_mp\utility\shellshock_utility::_shellshock( "frag_grenade_mp", "top", 2.5, 1 );
        }
    }
    
    var0 radiusdamage( var1, 512, 5000, 180, var0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb" );
    
    if ( istrue( level.farah_says_cut_wire_green ) && isdefined( level.br_pickups ) )
    {
        var15 = undefined;
        
        foreach ( var17 in level.br_pickups.crates )
        {
            if ( isdefined( var17.team ) && isdefined( var0.owner ) && var17.team == var0.owner.team )
            {
                continue;
            }
            
            var18 = distance( var1, var17.origin );
            
            if ( isdefined( var18 ) && var18 < 980 )
            {
                if ( var17.cratetype == "battle_royale_loadout" )
                {
                    if ( isdefined( level.crossbowimpactwatcher ) )
                    {
                        var15 = [[ level.crossbowimpactwatcher ]]( var17.team, "players" );
                    }
                    
                    if ( isdefined( level.createplayerplundereventdata ) )
                    {
                        level thread [[ level.createplayerplundereventdata ]]( "bt_loadout_destroyed", 1, var15 );
                    }
                    
                    var0.owner.current_count_down[ 1 ] += 1;
                }
                else
                {
                    var0.owner.current_count_down[ 2 ] += 1;
                }
                
                var17 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
                
                if ( isdefined( level.cruise_predator_direction_override ) )
                {
                    var0.owner thread [[ level.cruise_predator_direction_override ]]( "br_bt_bomb_destroy_crate" );
                LOC_00000517:
                }
            LOC_00000517:
            }
        LOC_00000517:
        }
    }
    
    if ( istrue( level.farms2_gw_ambient_sound_load ) && isdefined( level.ref_13400 ) )
    {
        foreach ( var21 in level.ref_13400.areas_remaining )
        {
            var22 = distance( var1, var21.origin );
            
            if ( var22 < 980 )
            {
                var21.chopperexfil_sfx_before_sh070 [[ level.cumulative_damage_to_chopper_boss ]]();
            LOC_00000588:
            }
        LOC_00000588:
        }
    }
    
    if ( istrue( level.farah_says_cut_wire_red ) && isdefined( level.br_armory_kiosk ) )
    {
        foreach ( var25 in level.br_armory_kiosk.scriptables )
        {
            var26 = distance( var1, var25.origin );
            
            if ( var26 < 980 )
            {
                if ( isdefined( var25.visible ) )
                {
                    if ( isdefined( level.little_bird_mg_mp_initspawning ) )
                    {
                        foreach ( var12 in level.players )
                        {
                            if ( isdefined( var12.delay_kick_inactive_player ) && var12.delay_kick_inactive_player == var25 )
                            {
                                if ( isdefined( level.createquestcircle ) )
                                {
                                    var12 [[ level.createquestcircle ]]( 2 );
                                }
                            }
                        }
                        
                        [[ level.little_bird_mg_mp_initspawning ]]( var25 );
                        var0.owner.current_count_down[ 0 ] += 1;
                        
                        if ( isdefined( level.cruise_predator_direction_override ) )
                        {
                            var0.owner thread [[ level.cruise_predator_direction_override ]]( "br_bt_bomb_destroy_kiosk" );
                        }
                        
                        if ( isdefined( level.crossbowbolts ) )
                        {
                            var29 = [[ level.crossbowbolts ]]( "timedrun" );
                            
                            foreach ( var31 in var29.instances )
                            {
                                if ( var31.ref_1393b.ref_13a7a == var25 )
                                {
                                    if ( isdefined( level.crossbow ) )
                                    {
                                        var31 [[ level.crossbow ]]();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    bomberbombdisabletrader( var0, var1 );
    
    if ( isdefined( level.vehicle ) && isdefined( level.vehicle.instances ) )
    {
        foreach ( var35 in level.vehicle.instances )
        {
            foreach ( var37 in var35 )
            {
                var38 = distance( var1, var37.origin );
                
                if ( var38 > 980 )
                {
                    continue;
                }
                
                var39 = int( var37.maxhealth * level.fast_revive_time );
                var37 dodamage( var39, var1, var0.owner, var0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb" );
                
                if ( var37.vehiclename == "cargo_truck_susp_aa" )
                {
                    var0.owner.current_count_down[ 6 ] += 1;
                    continue;
                }
                
                var0.owner.current_count_down[ 7 ] += 1;
            LOC_00000822:
            }
        }
    }
    
    if ( istrue( level.farah_nobraids_body_reset ) )
    {
        if ( isdefined( level.arenaflag_showflagoutlineplayer ) )
        {
            foreach ( var43 in level.arenaflag_showflagoutlineplayer )
            {
                var44 = distance( var1, var43.origin );
                
                if ( var44 > 980 )
                {
                    continue;
                }
                
                var43 dodamage( 5000, var1, var0.owner, var0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb" );
                var0.owner.current_count_down[ 8 ] += 1;
                
                if ( isdefined( level.cruise_predator_direction_override ) )
                {
                    var0.owner thread [[ level.cruise_predator_direction_override ]]( "br_bt_bomb_destroy_aa_turret" );
                LOC_000008f5:
                }
            LOC_000008f5:
            }
        }
    }
    
    var0.owner.current_count_down[ 9 ] += 1;
    var46 = [];
    
    for ( var47 = 0; var47 < var0.owner.current_count_down.size ; var47++ )
    {
        switch ( var47 )
        {
            case 0:
                var46 = "buystations";
                break;
            case 1:
                var46 = "loadout_crates";
                break;
            case 2:
                var46 = "other_crates";
                break;
            case 3:
                var46 = "downed_enemy";
                break;
            case 4:
                var46 = "enemy";
                break;
            case 5:
                var46 = "loot";
                break;
            case 6:
                var46 = "aa_truck";
                break;
            case 7:
                var46 = "other_vehicles";
                break;
            case 8:
                var46 = "aa_turret";
                break;
            case 9:
                var46 = "total_bombs";
                break;
            default:
                break;
        }
        
        var46 = var0.owner.current_count_down[ var47 ];
    }
    
    var46 = "location";
    var48 = var1[ 0 ] + "," + var1[ 1 ] + "," + var1[ 2 ];
    var46 = var48;
    
    if ( isdefined( var0.owner ) )
    {
        var0.owner dlog_recordplayerevent( "dlog_event_plane_bomb_accuracy", var46 );
    }
    
    var0 delete();
}

// Params 2
// Size: 0xba
function bomberbombdisabletrader( var0, var1 )
{
    if ( istrue( level.áãcH¢í†€V†Ã 6iªﬂ£Ükjaè" ) && isdefined( level.debug_trap_room ) )
    {
        foreach ( var3 in level.debug_trap_room.scriptables )
        {
            var4 = distance( var1, var3.origin );
            
            if ( var4 < 980 && isdefined( var3.visible ) && isdefined( level.ï kªÿkp©¡C˘W
ÇË~Ã‡∞ıè@}GHŒ ) )
            {
                [[ level.ï kªÿkp©¡C˘W
ÇË~Ã‡∞ıè@}GHŒ ]]( var3 );
                var0.owner.current_count_down[ 5 ] += 1;
                
                if ( isdefined( level.cruise_predator_direction_override ) )
                {
                    var0.owner thread [[ level.cruise_predator_direction_override ]]( "br_bt_bomb_destroy_trader" );
                }
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x1b
function createobjectivelist( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    wait var0;
    
    if ( isdefined( var1 ) )
    {
        var1 delete();
        return;
    }
}

// Params 0
// Size: 0x41
function createspawncamera()
{
    level.createsmokesignalfx = getentarray( "veh_a10fd_reload_drop_bomb", "targetname" );
    
    foreach ( var1 in level.createsmokesignalfx )
    {
        thread createserverfontstring( level );
    }
}

// Params 1
// Size: 0x161
function createserverfontstring( var0 )
{
    level endon( "game_ended" );
    thread ctfnukeended( level );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        
        if ( !isdefined( var1.vehicle ) || !isdefined( var1.vehicle.model ) || !isdefined( var1.vehicle.dropbombs ) || var1.vehicle.model != "veh_s4_mil_air_bomber_wz" )
        {
            continue;
        }
        
        var2 = 0;
        
        for ( var3 = 0; var3 < var1.vehicle.dropbombs.size ; var3++ )
        {
            if ( var1.vehicle.dropbombs[ var3 ] == 0 )
            {
                var2 = 1;
            }
        }
        
        if ( !var2 )
        {
            continue;
        }
        
        if ( isdefined( var1.vehicle.watch_for_players_ledgespawners ) )
        {
            var4 = var1.vehicle.watch_for_players_ledgespawners + level.find_free_drop_location;
            
            if ( var4 > gettime() )
            {
                continue;
            }
        }
        
        if ( isdefined( level.crossbowusageloop ) )
        {
            var1 thread [[ level.crossbowusageloop ]]( "br_bt_restock_bombs", 150 );
        }
        
        if ( isdefined( level.ctgs_recordmatchstats ) )
        {
            var1 thread [[ level.ctgs_recordmatchstats ]]( "br_bt_restock_bombs" );
        }
        
        if ( isdefined( level.cumulative_damage_monitor ) )
        {
            var1 thread [[ level.cumulative_damage_monitor ]]( "br_bt_restock_bombs_splash" );
        }
        
        createscriptedspawnpoint( var1.vehicle, level.farah_nobraids_body );
        var1 notify( "bt_bomb_force_refill" );
    LOC_0000015d:
    }
}

// Params 1
// Size: 0x113
function ctfnukeended( var0 )
{
    level endon( "game_ended" );
    
    if ( !istrue( level.find_supply_station ) )
    {
        return;
    }
    
    level waittill( "prematch_done" );
    var1 = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    
    if ( var1 != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var1, "current", var0, "ui_mp_br_mapmenu_icon_escape_objective_friendly" );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var1, 1 );
    }
    
    for ( ;; )
    {
        objective_removeallfrommask( var1 );
        
        if ( isdefined( level.vehicle.instances ) && isdefined( level.vehicle.instances[ "veh_bt" ] ) )
        {
            foreach ( var3 in level.vehicle.instances[ "veh_bt" ] )
            {
                var4 = distance( var3.origin, var0 );
                
                if ( var4 < 12000 )
                {
                    var5 = 1;
                    
                    for ( var6 = 0; var6 < var3.dropbombs.size ; var6++ )
                    {
                        if ( var3.dropbombs[ var6 ] > 0 )
                        {
                            var5 = 0;
                        }
                    }
                    
                    if ( !var5 )
                    {
                        var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( var3 );
                        
                        if ( isdefined( var7 ) )
                        {
                            objective_addclienttomask( var1, var7 );
                        }
                    }
                }
            }
            
            objective_showtoplayersinmask( var1 );
        }
        
        wait 5;
    }
}

// Params 2
// Size: 0x8c
function createscriptedspawnpoint( var0, var1 )
{
    var2 = self;
    
    if ( isdefined( var1 ) && var2.dropbombs[ var1 ] == 0 )
    {
        return;
    }
    
    if ( !isdefined( var1 ) )
    {
        for ( var3 = 0; var3 < var2.dropbombs.size ; var3++ )
        {
            var2.dropbombs[ var3 ] = 0;
        }
    }
    else
    {
        var2.dropbombs[ var1 ] = 0;
    }
    
    if ( !isdefined( var2.owner ) )
    {
        return;
    }
    
    var4 = var2.owner;
    cs_flags_init( var4, 1 );
    var5 = soundexists( "plane_ch3_bomb_reload" );
    
    if ( var5 )
    {
        var4 playsoundtoplayer( "plane_ch3_bomb_reload", var4 );
        return;
    }
}

// Params 2
// Size: 0x3a
function ref_12636( var0, var1 )
{
    var2 = self;
    level endon( "game_ended" );
    var2 endon( "death_or_disconnect" );
    var2 endon( "exiting_pilot_seat_bomber" );
    
    for ( ;; )
    {
        var2 waittill( var1 );
        waittillframeend();
        var2 thread [[ var0.powers[ var1 ].func ]]( var0, var1 );
    }
}

// Params 1
// Size: 0x53
function ref_12635( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "exiting_pilot_seat_bomber" );
    
    if ( isbot( var1 ) )
    {
        return;
    }
    
    foreach ( var3 in var0.powers )
    {
        thread ref_12636( var1, var0 );
    }
}

// Params 5
// Size: 0x183
function create_rocket_death_fx( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var3.javelin ) )
    {
        if ( isdefined( var3.javelin.state ) && var3.javelin.state != "off" || isdefined( var3.javelin.target ) || isdefined( var3.javelin.groundlockonent ) )
        {
            var4.success = 0;
            return;
        }
    }
    
    var3 skydive_setbasejumpingstatus( 0 );
    var3 skydive_setdeploymentstatus( 0 );
    
    if ( isdefined( level.findclearflightyaw ) && level.findclearflightyaw > 0 )
    {
        var0.origin += ( 0, 0, level.findclearflightyaw );
    }
    
    if ( istrue( level.ffsm_isgulagrespawn ) )
    {
        if ( var1 == "pilot" )
        {
            thread ref_1315f();
        }
    }
    
    thread create_heartbeat_sensor_pick_ups();
    
    if ( var1 == "pilot" )
    {
        thread createdevguientryforkidnapper();
    }
    
    if ( isdefined( var2 ) )
    {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc( var3, var4 );
        
        if ( var2 != "pilot" )
        {
            createcallbacks( var0, var3, var4, "tur_gun_bt_mp", var2, var1 );
        }
    }
    
    if ( var1 == "pilot" )
    {
        thread ref_14231( var3 );
        thread ref_12635( var3 );
        
        if ( istrue( level.fast_rope_over_black ) )
        {
            thread cumulative_damage_expire_time();
        }
        
        if ( istrue( level.ffsm_introsetup ) )
        {
            thread cur_goal_struct();
        }
        
        thread createnagarray();
    }
    else
    {
        var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret( var3, "tur_gun_bt_mp", var4, 1 );
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc( var3, var4 );
    ref_13fbf( var3, "ui_fd_target", 2047, 0, 11, 1 );
    
    if ( var1 != "pilot" )
    {
        thread set_track_operational_status();
        return;
    }
}

// Params 0
// Size: 0x9f
function playerpowerrestartallcooldowns()
{
    var0 = self;
    
    if ( isbot( var0 ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var0 endon( "exiting_pilot_seat_bomber" );
    
    while ( !isdefined( var0.vehicle ) )
    {
        waitframe();
    }
    
    while ( isdefined( var0.vehicle ) )
    {
        if ( isdefined( var0.waittillspectating ) && gettime() - var0.waittillspectating < level.ffsm_nextstreamhinttime )
        {
            waitframe();
            continue;
        }
        
        if ( var0 method_87db() )
        {
            var0.playerpowersaddhudelem = 1;
            var0.waittillspectating = gettime();
        }
        else if ( isdefined( var0.waittillspectating ) )
        {
            var0.playerpowersaddhudelem = undefined;
            var0.waittillspectating = undefined;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x10a
function binoculars_istargetinrange()
{
    var0 = self;
    
    if ( isbot( var0 ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_bomber" );
    var0 setclientomnvar( "ui_airplane_ads_active", 0 );
    
    while ( !isdefined( var0.vehicle ) )
    {
        waitframe();
    }
    
    var0.vehicle endon( "death" );
    var1 = 0;
    
    while ( isdefined( var0.vehicle ) )
    {
        if ( isdefined( var0.waittill_player_has_dropkit_marker ) && gettime() - var0.waittill_player_has_dropkit_marker < level.failedtext )
        {
            waitframe();
            continue;
        }
        
        if ( binoculars_istargetinbroadfov() != var1 && !isdefined( var0.playerpowersaddhudelem ) )
        {
            var0.waittill_player_has_dropkit_marker = gettime();
            
            if ( isdefined( level.critical_messages ) )
            {
                var0 notify( "playerCinematicFadeOutForceEnd" );
                var0 thread [[ level.critical_messages ]]();
            }
            
            var2 = gettime() + level.failhistoryquest * 1000;
            
            while ( binoculars_istargetinbroadfov() != var1 && gettime() < var2 )
            {
                waitframe();
            }
            
            if ( isdefined( level.createzombieloadout ) )
            {
                var0 thread [[ level.createzombieloadout ]]();
            }
            
            if ( binoculars_istargetinbroadfov() != var1 )
            {
                var1 = !var1;
                var0 setclientomnvar( "ui_airplane_ads_active", var1 );
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0xb4, Type: bool
function binoculars_istargetinbroadfov()
{
    var0 = self;
    
    if ( !isdefined( var0.vehicle ) )
    {
        return false;
    }
    
    if ( !var0 adsbuttonpressed() )
    {
        return false;
    }
    
    if ( regroup_process_started( var0.vehicle ) != 2 )
    {
        return false;
    }
    
    var1 = [ var0.vehicle ];
    
    if ( isdefined( var0.vehicle.waittill_player_picksup_armor ) )
    {
        var1 = [ var0.vehicle, var0.vehicle.waittill_player_picksup_armor ];
    }
    
    var2 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
    var3 = scripts\engine\trace::ray_trace( var0.vehicle.origin, var0.vehicle.origin - ( 0, 0, 600 ), var1, var2, 0 );
    return var3[ "fraction" ] >= 1;
}

// Params 0
// Size: 0x18
function binoculars_iswithinprojectiondistance()
{
    var0 = self;
    
    if ( isbot( var0 ) )
    {
        return;
    }
    
    var0 setclientomnvar( "ui_airplane_ads_active", 0 );
}

// Params 0
// Size: 0x74
function cur_goal_struct()
{
    var0 = self;
    var0 endon( "exiting_pilot_seat_bomber" );
    level endon( "game_ended" );
    wait 2;
    
    if ( !isdefined( var0.vehicle ) )
    {
        return;
    }
    
    var1 = var0.vehicle;
    var1 endon( "death" );
    var1.nuke_killplayerwithattacker = 0;
    
    while ( isdefined( var0.vehicle ) )
    {
        if ( var0 fragbuttonpressed() && istrue( var1.shouldmodeplayfinalmoments ) && !istrue( var1.nuke_killplayerwithattacker ) )
        {
            thread create_puddle_triggers();
        }
        
        wait 0.2;
    }
}

// Params 0
// Size: 0x78
function createnagarray()
{
    var0 = self;
    var0 endon( "exiting_pilot_seat_aircraft" );
    level endon( "game_ended" );
    wait 2;
    
    if ( !isdefined( var0.vehicle ) )
    {
        return;
    }
    
    var1 = var0.vehicle;
    var1 endon( "death" );
    
    if ( istrue( var1.shouldmodeplayfinalmoments ) )
    {
        return;
    }
    
    for ( ;; )
    {
        while ( var1 vehicle_getspeed() < 60 )
        {
            wait 0.2;
        }
        
        cull_list_of_players( var1, "screenshake_bt_accell", "rumble_bt_accell" );
        
        while ( var1 vehicle_getspeed() > 60 )
        {
            wait 1.5;
        }
    }
}

// Params 0
// Size: 0xa1
function create_puddle_triggers()
{
    var0 = self;
    var0 endon( "death" );
    var0 notify( "engineSmokeThink" );
    var0 endon( "engineSmokeThink" );
    var0.nuke_killplayerwithattacker = 1;
    var0 setscriptablepartstate( "engine_smoke", "engine_smoke", 1 );
    cull_list_of_players( var0, "screenshake_fd_airbrake", "rumble_bt_airbrake" );
    
    if ( soundexists( "s4_fd_air_brake" ) )
    {
        var0 playsoundtoplayer( "s4_fd_air_brake", var0.owner );
    }
    
    wait 2;
    
    while ( isdefined( var0.owner ) && var0.owner fragbuttonpressed() )
    {
        wait 0.4;
    }
    
    var0.nuke_killplayerwithattacker = 0;
    var0 setscriptablepartstate( "engine_smoke", "base", 0 );
}

// Params 6
// Size: 0x71
function createcallbacks( var0, var1, var2, var3, var4, var5 )
{
    var6 = create_silencer_pick_up( var0, var4 );
    
    if ( !istrue( var2.playerdisconnect ) )
    {
        var1 enableturretdismount();
        var1 controlturretoff( var6 );
        
        if ( var4 != "pilot" && !istrue( var2.playerdeath ) )
        {
            creategulagjailloadout( var1 );
            scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret( var1, var0, var0.ref_13e92, var2, 1 );
        }
    }
    
    var6.owner = undefined;
    var6 setotherent( undefined );
    var6 setentityowner( undefined );
    var6 setsentryowner( undefined );
}

// Params 0
// Size: 0x205
function create_heartbeat_sensor_pick_ups()
{
    var0 = self;
    var0 endon( "death" );
    var0 endon( "vehicle_contrails_debug" );
    level endon( "game_ended" );
    var0.ref_145c9 = 0;
    var0.helicrash = 0;
    var0.spawn_fake_letter = 0;
    
    for ( ;; )
    {
        if ( istrue( var0.ref_145c9 ) )
        {
            if ( var0 vehicle_getspeed() < level.finalthreeuav )
            {
                var0.ref_145c9 = 0;
                var0 setscriptablepartstate( "fx", "base", 0 );
            }
        }
        else if ( var0 vehicle_getspeed() > level.finalthreeuav )
        {
            var0.ref_145c9 = 1;
            var0 setscriptablepartstate( "fx", "trails", 0 );
        }
        
        if ( istrue( level.failedmission ) )
        {
            if ( istrue( var0.helicrash ) )
            {
                if ( var0 vehicle_getspeed() < level.finalkillcamplaybackbegin )
                {
                    var0.helicrash = 0;
                    var0 setscriptablepartstate( "cloud_contrail", "base", 0 );
                }
            }
            else if ( var0 vehicle_getspeed() > level.finalkillcamplaybackbegin )
            {
                var0.helicrash = 1;
                var0 setscriptablepartstate( "cloud_contrail", "cloud_contrail", 0 );
            }
            
            if ( istrue( var0.spawn_fake_letter ) )
            {
                if ( var0 vehicle_getspeed() < level.finalsurvivorcount || abs( var0.angles[ 2 ] ) < level.failsafe_door_breach_frozen )
                {
                    var0.spawn_fake_letter = 0;
                    var0.ref_138a5 = undefined;
                    var0 setscriptablepartstate( "fast_contrail", "base", 0 );
                }
            }
            else if ( var0 vehicle_getspeed() > level.finalsurvivorcount && abs( var0.angles[ 2 ] ) > level.failsafe_door_breach_frozen )
            {
                var0.spawn_fake_letter = 1;
                var0.ref_138a5 = gettime();
                var0 setscriptablepartstate( "fast_contrail", "fast_contrail", 0 );
            }
        }
        
        if ( istrue( var0.spawn_fake_letter ) )
        {
            if ( isdefined( var0.ref_138a5 ) && gettime() - var0.ref_138a5 > 500 )
            {
                var0 setscriptablepartstate( "rumble_turn", "rumble_bt_turn", 0 );
                var0.ref_1443e = 1;
            }
        }
        else if ( istrue( var0.ref_1443e ) )
        {
            var0 setscriptablepartstate( "rumble_turn", "neutral", 0 );
            var0.ref_1443e = undefined;
        }
        
        wait 0.3;
    }
}

// Params 0
// Size: 0x30
function regroup_process_started()
{
    var0 = self;
    var1 = 0;
    
    if ( var0.shouldmodeplayfinalmoments )
    {
        var1 = 2;
    }
    else if ( var0 vehicle_getspeed() > 5 )
    {
        var1 = 1;
    }
    else
    {
        var1 = 0;
    }
    
    return var1;
}

// Params 5
// Size: 0x82
function create_race( var0, var1, var2, var3, var4 )
{
    if ( istrue( var4.success ) )
    {
        thread create_rig_for_usb_animation( var0, var1, var2, var3, var4 );
    }
    else if ( !istrue( var4.playerdisconnect ) && !istrue( var4.playerdeath ) )
    {
        if ( var1 == "pilot" || var1 == "seat_two" || var1 == "seat_three" || var1 == "seat_four" )
        {
            creategulagjailloadout( var3 );
        }
    }
    
    if ( !istrue( level.client_activate ) )
    {
        var3 skydive_setbasejumpingstatus( 1 );
        var3 skydive_setdeploymentstatus( 1 );
        return;
    }
}

// Params 5
// Size: 0x1e1
function create_rig_for_usb_animation( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var3.should_hide_buried_mother_corpse ) )
    {
        var3.should_hide_buried_mother_corpse = 1;
    }
    else
    {
        var3.should_hide_buried_mother_corpse += 1;
    }
    
    var3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_pickup_origin( var0, var1, var2, var4 );
    
    if ( isdefined( var3.carriable_set_dropped ) )
    {
        if ( isdefined( level.createpropspecatehud ) )
        {
            var3 thread [[ level.createpropspecatehud ]]();
        }
    }
    
    var5 = undefined;
    var6 = undefined;
    
    if ( isdefined( var2 ) && ( var2 == "seat_two" || var2 == "seat_three" || var2 == "seat_four" ) )
    {
        var5 = "bt_mp";
        var6 = 6;
    }
    
    if ( var1 == "pilot" )
    {
        var0 setotherent( var3 );
        var0 setentityowner( var3 );
        var0.owner = var3;
        var3 controlslinkto( var0 );
        cs_flags_init( var3, 1 );
        var3.current_count_down = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
        
        if ( istrue( level.failsafe_door_breach_frozen_player ) )
        {
            thread binoculars_istargetinrange();
        }
        
        thread playerpowerrestartallcooldowns();
        var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer( var0, var1, var2, undefined, var5, var6 );
    }
    else if ( var1 == "seat_two" || var1 == "seat_three" || var1 == "seat_four" )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime( var3, 0 );
        var7 = create_silencer_pick_up( var0, var1 );
        var7.owner = var3;
        var7 setotherent( var3 );
        var7 setentityowner( var3 );
        var7 setsentryowner( var3 );
        var3 disableturretdismount();
        var3 controlturreton( var7 );
        create_heartbeat_sensor_pick_up( var3 );
        var3 setentitysoundcontext( "vehicle", "interior", 0.2 );
    }
    
    thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6( var4, 1 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter( var0, var2, var1, var3 );
    
    if ( getdvarint( "scr_enable_ap_visionset_override", 1 ) )
    {
        if ( isdefined( level.≤(…g»ó "c*Cì∞zQ‡GÌµ◊ ) )
        {
            var3 visionsetnakedforplayer( level.≤(…g»ó "c*Cì∞zQ‡GÌµ◊, 0 );
        }
        else
        {
            var3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer( "mp_wz_island_ap" );
        }
    }
    
    wait 1;
    
    if ( istrue( level.fiftypercent_music ) && isdefined( var3 ) && var1 == "pilot" )
    {
        var3 playerhide();
        return;
    }
}

// Params 5
// Size: 0x96
function create_saw_interaction( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var1 ) && var1 == "pilot" )
    {
        thread ref_14230( var3 );
        createrectangularzonebasedonent( var3 );
        var3 notify( "exiting_pilot_seat_bomber" );
        thread createdestinationvfx();
        var3 notify( "bomberHeadIconForceDelete" );
        cs_flags_init( var3, 0 );
        
        if ( isdefined( level.createzombieloadout ) )
        {
            var3 thread [[ level.createzombieloadout ]]();
        }
        
        if ( isdefined( var3.playerpowersaddhudelem ) )
        {
            var3.playerpowersaddhudelem = undefined;
            var3.waittillspectating = undefined;
        }
        
        var3 setclientomnvar( "ui_airplane_ads_active", 0 );
    }
    
    if ( istrue( var4.success ) )
    {
        create_score_message( var0, var1, var2, var3, var4 );
        return;
    }
}

// Params 5
// Size: 0x1c0
function create_score_message( var0, var1, var2, var3, var4 )
{
    var3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_protect_hq_zone( var0, var1, var2, var4 );
    
    if ( var1 == "pilot" )
    {
        var0 setotherent( undefined );
        var0 setentityowner( undefined );
        var0.owner = undefined;
    }
    else if ( var1 == "seat_two" || var1 == "seat_three" || var1 == "seat_four" )
    {
        var3 setentitysoundcontext( "vehicle", "", 0.2 );
    }
    
    var5 = !isdefined( var2 );
    
    if ( var5 && var3 hasweapon( var0.ref_13e92 ) || var1 == "tag_seat_2" || var1 == "tag_seat_3" || var1 == "tag_seat_4" )
    {
        var6 = create_silencer_pick_up( var0, var1 );
        
        if ( !istrue( var4.playerdisconnect ) )
        {
            var3 enableturretdismount();
            var3 controlturretoff( var6 );
            
            if ( !istrue( var4.playerdeath ) )
            {
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret( var3, var0, var0.ref_13e92, var4, 1 );
            }
            
            thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime( var3, var4.playerdeath );
        }
        
        var6.owner = undefined;
        var6 setotherent( undefined );
        var6 setentityowner( undefined );
        var6 setsentryowner( undefined );
        
        if ( !istrue( var4.playerdisconnect ) )
        {
            creategulagjailloadout( var3 );
        }
    }
    
    if ( !istrue( var4.playerdisconnect ) )
    {
        var3 controlsunlink();
        
        if ( istrue( var4.playerdeath ) )
        {
            var3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
        }
        
        var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
        var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit( var3, var2, var4 );
        
        if ( !var7 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "handleSuicideFromVehicles" ) )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "handleSuicideFromVehicles" ) ]]( var3 );
            }
            else
            {
                var3 suicide();
            }
        }
    }
    
    if ( istrue( level.failsafe_door_breach_frozen_player ) )
    {
        binoculars_iswithinprojectiondistance( var3 );
    }
    
    if ( isdefined( level.ref_142d1 ) )
    {
        var3 visionsetnakedforplayer( level.ref_142d1, 0 );
    }
    else
    {
        var3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer( "", 0 );
    }
    
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit( var0, var1, var2, var3 );
}

// Params 1
// Size: 0x48
function create_heartbeat_sensor_pick_up( var0 )
{
    if ( isdefined( var0.set_thirdperson ) )
    {
        return;
    }
    
    var0.set_thirdperson = 1;
    var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_bt" );
    
    if ( istrue( var1.ref_133d3 ) )
    {
        return;
    }
    
    var0 scripts\cp_mp\utility\damage_utility::adddamagemodifier( "ctmgGunnerMissileRedux", 0.4, 0, &create_smoke_occluder );
}

// Params 1
// Size: 0x3c
function creategulagjailloadout( var0 )
{
    if ( !isdefined( var0.set_thirdperson ) )
    {
        return;
    }
    
    var0.set_thirdperson = undefined;
    var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_bt" );
    
    if ( istrue( var1.ref_133d3 ) )
    {
        return;
    }
    
    var0 scripts\cp_mp\utility\damage_utility::removedamagemodifier( "ctmgGunnerMissileRedux", 0 );
}

// Params 7
// Size: 0x91
function create_smoke_occluder( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( var4 != "MOD_PROJECTILE_SPLASH" && var4 != "MOD_GRENADE_SPLASH" )
    {
        return 1;
    }
    
    if ( !isdefined( var5 ) )
    {
        return 1;
    }
    
    switch ( var5.basename )
    {
        case "tur_gun_bt_mp":
        case "iw8_la_t9launcher_mp":
        case "iw8_la_t9freefire_mp":
        case "lighttank_tur_mp":
        case "iw8_la_rpapa7_mp":
        case "iw8_la_kgolf_mp":
        case "iw8_la_juliet_mp":
        case "iw8_la_gromeo_mp":
        case "iw8_la_gromeoks_mp":
        case "iw8_la_mike32_mp":
        case "iw8_la_t9standard_mp":
            return 0;
        default:
            return 1;
    }
}

// Params 5
// Size: 0x1a
function createflagstart( var0, var1, var2, var3, var4 )
{
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6( var4 );
    thread creategulagarenaloadout( var0, var1, var2, var3, var4 );
}

// Params 5
// Size: 0x28
function creategulagarenaloadout( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var2 ) && var2 == "pilot" )
    {
        var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc( var3, var4 );
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7( var5 );
        return;
    }
}

// Params 0
// Size: 0x5, Type: bool
function ref_13dda()
{
    return true;
}

// Params 1
// Size: 0xc4
function trophy_protectionsuccessful( var0 )
{
    self.ref_13ddf--;
    var1 = var0.origin;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_trophyDestroyTarget", "init" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_trophyDestroyTarget", "init" ) ]]( var0 );
    }
    
    var2 = trophy_getbesttag( var1 );
    self setscriptablepartstate( "trophy_detonate", var2 );
    var3 = vectortoangles( self gettagorigin( var2 ) - var1 );
    var4 = combineangles( var3, ( -90, 0, 0 ) );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_trophyExplode", "init" ) )
    {
        self.explosion thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_trophyExplode", "init" ) ]]( var1, var4 );
    }
    
    if ( self.ref_13ddf == 0 )
    {
        self notify( "upgrade_message", "trophy_no_ammo" );
        self waittill( "trophy_ammo_refill" );
        return;
    }
    
    self notify( "upgrade_message", "trophy_ammo_used" );
}

// Params 1
// Size: 0x6d
function trophy_getbesttag( var0 )
{
    var1 = [ "tag_trophy_1", "tag_trophy_2", "tag_trophy_3", "tag_trophy_4" ];
    var2 = undefined;
    var3 = undefined;
    
    foreach ( var5 in var1 )
    {
        var6 = self gettagorigin( var5 );
        var7 = distancesquared( var6, var0 );
        
        if ( var8 == 0 || var7 < var2 )
        {
            var2 = var7;
            var3 = var5;
        }
    }
    
    return var3;
}

// Params 0
// Size: 0x65
function create_tut_loot_struct()
{
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "veh_bt", 1 );
    var0.maxinstancecount = 2;
    var0.priority = 75;
    var0.getspawnstructscallback = &create_seatids_override;
    var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_bt", "spawnCallback" );
    var0.clearancecheckradius = 185;
    var0.clearancecheckheight = 138;
    var0.clearancecheckminradius = 185;
}

// Params 0
// Size: 0x5f
function create_seatids_override()
{
    var0 = getdvar( "scr_br_bomber_struct_string", "veh_bt" );
    
    if ( isdefined( level.ref_1218a ) && level.ref_1218a.size != 0 )
    {
        var1 = level.ref_1218a;
    }
    else
    {
        var1 = scripts\engine\utility::getstructarray( var1, "targetname" );
    }
    
    if ( var1.size > 0 )
    {
        var1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag( var1, 1 );
        
        if ( var1.size > 1 )
        {
            var1 = scripts\engine\utility::array_randomize( var1 );
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x65
function cs_flags_init( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1 ) || !isdefined( var1.vehicle ) || isbot( var1 ) )
    {
        return;
    }
    
    var2 = var1.vehicle;
    
    if ( !isdefined( var2.curr_airlock_pos ) || !isdefined( var2.dropbombs ) )
    {
        return;
    }
    
    var3 = cs_add_to_struct_array( var0, var2.curr_airlock_pos, var2.dropbombs );
    var1 setclientomnvar( "ui_br_fd_state", var3 );
}

// Params 3
// Size: 0x67
function cs_add_to_struct_array( var0, var1, var2 )
{
    var3 = 1;
    var4 = 3;
    var5 = 127;
    
    for ( var6 = 0; var6 < var2.size ; var6++ )
    {
    }
    
    var7 = int( var0 ) & var3;
    var7 += ( int( var1 ) & var4 ) << 1;
    
    for ( var6 = 0; var6 < var2.size ; var6++ )
    {
        var7 += ( int( var2[ var6 ] / level.failsmokinggunquest * 127 ) & var5 ) << 3 + 7 * var6;
    }
    
    return var7;
}

// Params 0
// Size: 0x66
function cumulative_damage_expire_time()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_bomber" );
    var1 = 40;
    var2 = -135;
    var0.cruisepredator_watchgameend = ref_12530( var0, var1, var2, "left", "middle", "center", "bottom", &"MP_WZ_ISLAND/FD_IN_AIR_COUNTER" );
    
    while ( !isdefined( var0.vehicle ) )
    {
        wait 0.5;
    }
    
    thread current_anim_ref();
}

// Params 0
// Size: 0x22
function createrectangularzonebasedonent()
{
    var0 = self;
    
    if ( isdefined( var0.cruisepredator_watchgameend ) )
    {
        var0.cruisepredator_watchgameend destroy();
    }
    
    var0.cruisepredator_watchgameend = undefined;
}

// Params 0
// Size: 0xdd
function current_anim_ref()
{
    var0 = self;
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_bomber" );
    
    for ( ;; )
    {
        if ( !isdefined( var0.vehicle ) )
        {
            return;
        }
        
        var1 = 0;
        
        foreach ( var3 in level.vehicle.instances[ "veh_bt" ] )
        {
            if ( istrue( var3.shouldmodeplayfinalmoments ) )
            {
                var1++;
            }
        }
        
        if ( isdefined( level.vehicle.instances[ "veh_a10fd" ] ) )
        {
            foreach ( var6 in level.vehicle.instances[ "veh_a10fd" ] )
            {
                if ( istrue( var6.shouldmodeplayfinalmoments ) )
                {
                    var1++;
                }
            }
        }
        
        var0.cruisepredator_watchgameend setvalue( var1 );
        wait 3;
    }
}

// Params 8
// Size: 0x96
function ref_12530( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = init_reach_pipe_room( "default", 1 );
    var8.x = var0;
    var8.y = var1;
    var8.alignx = var2;
    var8.aligny = var3;
    var8.horzalign = var4;
    var8.vertalign = var5;
    var8.alpha = 1;
    var8.glowalpha = 0;
    var8.hidewheninmenu = 1;
    var8.archived = 0;
    
    if ( isdefined( var6 ) )
    {
        var8.label = var6;
    }
    
    if ( isdefined( var7 ) )
    {
        var8 setvalue( var7 );
    }
    
    return var8;
}

// Params 2
// Size: 0x86
function init_reach_pipe_room( var0, var1 )
{
    var2 = newclienthudelem( self );
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
    var2.hidden = 0;
    return var2;
}

// Params 0
// Size: 0x4ac
function ref_1315f()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "bomberHeadIconForceDelete" );
    var1 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) )
    {
        var1 = level [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]();
    }
    
    wait 2;
    
    while ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver( var0 ) )
    {
        var2 = [];
        var3 = rooftop_active();
        var4 = var3[ 0 ];
        var5 = var3[ 1 ];
        var3 = undefined;
        
        foreach ( var7 in level.players )
        {
            if ( var7.team == var0.team )
            {
                continue;
            }
            
            if ( isdefined( level.ctf_bot_attacker_limit_for_team ) )
            {
                if ( var7 [[ level.ctf_bot_attacker_limit_for_team ]]() )
                {
                    continue;
                }
            }
            
            if ( isdefined( level.cruisepredator_assigntargetmarkers ) )
            {
                if ( var7 [[ level.cruisepredator_assigntargetmarkers ]]( "specialty_guerrilla" ) || var7 [[ level.cruisepredator_assigntargetmarkers ]]( "specialty_covert_ops" ) )
                {
                    continue;
                }
            }
            
            if ( isdefined( var7.vehicle ) && isdefined( var7.vehicle.targetname ) && ( var7.vehicle.targetname == "veh_bt" || var7.vehicle.targetname == "veh_a10fd" ) )
            {
                if ( var7.vehicle _calloutmarkerping_isvehicleoccupiedbyenemy::ref_1331b( var7 ) )
                {
                    var2 = scripts\engine\utility::array_add( var2, var7 );
                }
                
                continue;
            }
            
            if ( isdefined( var7.currentweapon ) && isdefined( var7.currentweapon.basename ) && ( var7.currentweapon.basename == "manual_turret_flak_mp_highrof" || var7.currentweapon.basename == "manual_turret_flak_mp" || var7.currentweapon.basename == "manual_turret_flak_vehicle" ) )
            {
                var2 = scripts\engine\utility::array_add( var2, var7 );
                continue;
            }
            
            var8 = ref_13d9c( var7.origin, var0.vehicle.origin, var4, var5 );
            
            if ( istrue( var8 ) )
            {
                var2 = scripts\engine\utility::array_add( var2, var7 );
            }
        }
        
        if ( isdefined( level.decoygrenades ) )
        {
            foreach ( var11 in level.decoygrenades )
            {
                if ( !isdefined( var11 ) )
                {
                    continue;
                }
                
                if ( isdefined( var11.team ) && var11.team == var0.team )
                {
                    continue;
                }
                
                var8 = ref_13d9c( var11.origin, var0.vehicle.origin, var4, var5 );
                
                if ( istrue( var8 ) )
                {
                    var2 = scripts\engine\utility::array_add( var2, var11 );
                }
            }
        }
        
        if ( istrue( level.farah_says_cut_wire_red ) )
        {
            if ( isdefined( level.br_armory_kiosk.scriptables ) )
            {
                foreach ( var14 in level.br_armory_kiosk.scriptables )
                {
                    if ( !istrue( var14.visible ) )
                    {
                        continue;
                    }
                    
                    var15 = distance( var0.vehicle.origin, var14.origin );
                    
                    if ( var15 < 20000 )
                    {
                        var2 = scripts\engine\utility::array_add( var2, var14 );
                    }
                }
            }
        }
        
        if ( isdefined( level.br_pickups.crates ) )
        {
            foreach ( var18 in level.br_pickups.crates )
            {
                if ( !isdefined( var18 ) || !isdefined( var18.origin ) )
                {
                    continue;
                }
                
                if ( isdefined( var18.team ) && var18.team == var0.team )
                {
                    continue;
                }
                
                var19 = distance( var0.vehicle.origin, var18.origin );
                
                if ( isdefined( var19 ) && var19 < 20000 )
                {
                    var2 = scripts\engine\utility::array_add( var2, var18 );
                }
            }
        }
        
        if ( var2.size > 0 )
        {
            var21 = level.teamdata[ var0.team ][ "alivePlayers" ];
            
            if ( istrue( var1 ) )
            {
                var21 = level.squaddata[ var0.team ][ var0.squadindex ].players;
            }
            
            foreach ( var23 in var21 )
            {
                if ( !isalive( var23 ) )
                {
                    continue;
                }
                
                if ( isdefined( level.ctf_bot_attacker_limit_for_team ) )
                {
                    if ( var23 [[ level.ctf_bot_attacker_limit_for_team ]]() )
                    {
                        continue;
                    }
                }
                
                var24 = distance( var0.vehicle.origin, var23.origin );
                
                if ( var24 < 10000 )
                {
                    foreach ( var26 in var2 )
                    {
                        thread cur_vision( var23, var26 );
                    }
                }
            }
            
            if ( soundexists( "s4_fd_scan_ping" ) )
            {
                var0 playsoundtoplayer( "s4_fd_scan_ping", var0 );
            }
        }
        
        wait 3.25;
    }
}

// Params 0
// Size: 0xd5
function rooftop_active()
{
    var0 = self;
    var0 notify( "get_sonar_cone_scan_vertices" );
    var0 endon( "get_sonar_cone_scan_vertices" );
    var1 = var0.vehicle.origin;
    var2 = anglestoforward( var0.vehicle.angles );
    var2 = ( var2[ 0 ], var2[ 1 ], 0 );
    var3 = vectorcross( var2, ( 0, 0, 1 ) );
    var4 = var2 * level.findavailableteam * cos( level.findanyaliveplayer );
    var5 = level.findavailableteam * sin( level.findanyaliveplayer );
    var6 = [];
    var7 = ( 0, 0, 0 );
    var8 = undefined;
    var9 = undefined;
    
    for ( var10 = 0; var10 < 2 ; var10++ )
    {
        var11 = var10 / 2 * 360;
        var12 = var1 + var4 + var5 * var3 * cos( var11 );
        var7 = var12;
        
        if ( isdefined( var9 ) )
        {
            var8 = var12;
            continue;
        }
        
        var9 = var12;
    }
    
    return [ var8, var9 ];
}

// Params 4
// Size: 0x1d
function ref_13d9c( var0, var1, var2, var3 )
{
    var4 = updatescrapassistdataforcecredit( var0, var1, var2, var3 );
    
    if ( var4 )
    {
        return 1;
    }
    
    return 0;
}

// Params 4
// Size: 0x31, Type: bool
function updatescrapassistdataforcecredit( var0, var1, var2, var3 )
{
    if ( !use_nvg_think( var0, var1, var2 ) )
    {
        return false;
    }
    
    if ( !use_nvg_think( var0, var2, var3 ) )
    {
        return false;
    }
    
    if ( !use_nvg_think( var0, var3, var1 ) )
    {
        return false;
    }
    
    return true;
}

// Params 3
// Size: 0x2c, Type: bool
function use_nvg_think( var0, var1, var2 )
{
    return ( var2[ 0 ] - var1[ 0 ] ) * ( var0[ 1 ] - var1[ 1 ] ) - ( var0[ 0 ] - var1[ 0 ] ) * ( var2[ 1 ] - var1[ 1 ] ) < 0;
}

// Params 2
// Size: 0xb2
function cur_vision( var0, var1 )
{
    var2 = self;
    var3 = undefined;
    
    if ( isdefined( var0.classname ) && var0.classname == "scriptable_br_plunder_box" || isdefined( var0.cratetype ) )
    {
        var4 = "hud_icon_ground_marked_obj";
        var3 = var0.origin;
    }
    else if ( updateexpiredlootleader( var1 ) || var1 _calloutmarkerping_isvehicleoccupiedbyenemy::updatedroprelicsfunc() )
    {
        var4 = "hud_icon_air_marked";
    }
    else
    {
        var4 = "hud_icon_ground_marked";
    }
    
    var5 = 8;
    var6 = 1;
    var7 = 500;
    var8 = 31500;
    var9 = var2 scripts\cp_mp\entityheadicons::setheadicon_singleimage( var4, var4, var5, var6, var8, var7, undefined, 1, 1, var4 );
    cur_wave_start_time( var4, var2 );
    scriptedspawnpointarray( var4, var2, var3 );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var9 );
}

// Params 2
// Size: 0x94
function scriptedspawnpointarray( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( level.cruise_predator_direction_override ) )
    {
        return;
    }
    
    if ( !isdefined( var2 ) || !isdefined( var0 ) || !isdefined( var0.lastkilledby ) || !isdefined( var0.lastkilledby.team ) )
    {
        return;
    }
    
    if ( !isent( var0 ) || !isplayer( var0 ) )
    {
        return;
    }
    
    if ( var0.health != 0 )
    {
        return;
    }
    
    if ( var2 == var1 && var0.lastkilledby.team == var2.team && var0.lastkilledby != var2 )
    {
        var2 thread [[ level.cruise_predator_direction_override ]]( "br_fd_mark_assist" );
        return;
    }
}

// Params 1
// Size: 0x2d
function cur_wave_start_time( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "bomberHeadIconForceDelete" );
    var0 scripts\engine\utility::waittill_notify_or_timeout( "death_or_disconnect", 3 );
}

// Params 0
// Size: 0x3c, Type: bool
function updateexpiredlootleader()
{
    var0 = self;
    
    if ( isdefined( var0.vehicle ) && isdefined( var0.vehicle.targetname ) && var0.vehicle.targetname == "veh_bt" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x2e, Type: bool
function unresolvedcollisiontolerancesqr()
{
    var0 = self;
    
    if ( var0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isdefined( var0.targetname ) && var0.targetname == "veh_bt" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x25, Type: bool
function unset_bullet_shields()
{
    var0 = self;
    
    if ( isdefined( var0.model ) && var0.model == "lm_ach_gp_bomb_600lb_01_gameplay" )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x172
function set_track_operational_status( var0, var1 )
{
    var2 = self;
    level endon( "game_ended" );
    var2 endon( "death_or_disconnect" );
    
    if ( !isdefined( var0 ) )
    {
        var0 = level.ffsm_skydive_stateenter;
    }
    
    jumpiftrue(isdefined( var1 )) LOC_0000002d;
    var1 = level.ffsm_parachuteopen_stateenter;
    
    while ( isdefined( var2.vehicle ) )
    {
        var3 = var2.origin;
        var4 = var2 getplayerangles();
        var5 = anglestoforward( var4 );
        var6 = var3 + var5 * var1;
        var7 = scripts\engine\trace::ray_trace( var3, var6 );
        var8 = var7[ "entity" ];
        
        if ( isdefined( var8 ) && isdefined( var8.entity_number ) && isdefined( var8.team ) && var2.team != var8.team )
        {
            var9 = isdefined( var8.vehiclename );
            var10 = !isdefined( var2.ref_13a7e ) || var2.ref_13a7e != var8.entity_number;
            var11 = !isdefined( var2.ref_13a7f ) || var2.ref_13a7f != var9;
            
            if ( var10 )
            {
                ref_13fbf( var2, "ui_fd_target", var8.entity_number, 0, 11, 1 );
                var2.ref_13a7e = var8.entity_number;
            }
            
            if ( var11 )
            {
                ref_13fbf( var2, "ui_fd_target", var9, 11, 1, 0 );
                var2.ref_13a7f = var9;
            }
        }
        else if ( isdefined( var2.ref_13a7e ) || isdefined( var2.ref_13a7f ) )
        {
            ref_13fbf( var2, "ui_fd_target", 2047, 0, 11, 1 );
            var2.ref_13a7e = undefined;
            var2.ref_13a7f = undefined;
        }
        
        wait var0;
    }
}

// Params 5
// Size: 0x6d
function ref_13fbf( var0, var1, var2, var3, var4 )
{
    var5 = self;
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var6 = int( pow( 2, var3 ) ) - 1;
    var7 = ( var1 & var6 ) << var2;
    var8 = ~( var6 << var2 );
    var9 = self calloutmarkerping_entityzoffset( var0 );
    
    if ( istrue( var4 ) )
    {
        self setclientomnvar( var0, var7 );
        return;
    }
    else if ( !isdefined( var9 ) )
    {
        var9 = var8;
    }
    
    var10 = var9 & var8;
    
    if ( !isdefined( var7 ) )
    {
        return;
    }
    
    var11 = var10 + var7;
    
    if ( var11 != var9 )
    {
        self setclientomnvar( var0, var11 );
        return;
    }
}

// Params 2
// Size: 0x20
function cull_list_of_players( var0, var1 )
{
    var2 = self;
    var2 setscriptablepartstate( "screenshake", var0, 0 );
    var2 setscriptablepartstate( "rumble", var1, 0 );
}

