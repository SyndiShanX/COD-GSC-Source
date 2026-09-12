/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58229.gsc
***********************************************/

function bomber_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_bt", 1);
  var_0.destroycallback = &create_script_wait_for_flags;
  var_0.ref_13E92 = "tur_gun_bt_mp";
  level.findclearflightyaw = getdvarint("scr_bt_start_in_the_air", 0);
  level.farah_nobraids_body = getdvarint("scr_bt_drop_bomb_ammo", 4);
  level.failsecretstashquest = getdvarint("scr_bt_allow_runway_refill", 0);
  level.failsmokinggunquest = getdvarint("scr_bt_auto_refill_drop_bomb_time", 20);
  level.find_free_drop_location = getdvarint("scr_bt_drop_bomb_cooldown_ms", 6000);
  level.fast_revive_time = getdvarfloat("scr_bt_drop_bomb_vehicle_dmg", 0.85);
  level.farobjectiveiconid = getdvarfloat("scr_bt_drop_bomb_time_between_bombs", 0.8);
  level.farah_says_cut_wire_green = getdvarint("scr_bt_drop_bomb_destroys_crate", 1);
  level.farah_says_cut_wire_red = getdvarint("scr_bt_drop_bomb_destroys_kiosk", 0);
  level.bt_dropbombdestroystrader = getdvarint("scr_bt_drop_bomb_destroys_trader", 0);
  level.farah_nobraids_body_reset = getdvarint("scr_bt_drop_bomb_destroys_aa_turret", 1);
  level.farah_says_cut_wire_yellow = getdvarint("scr_bt_drop_bomb_destroys_loot", 0);
  level.farms2_gw_ambient_sound_load = getdvarint("scr_bt_drop_bomb_destroys_skyhook", 1);
  level.ffsm_state = getdvarfloat("scr_bt_gunner_time_between_bullets", 0.1);
  level.ffsm_isgulagrespawn = getdvarint("scr_bt_enable_sonar", 1);
  level.findanyaliveplayer = getdvarint("scr_bt_sonar_scan_angle", 35);
  level.findavailableteam = getdvarint("scr_bt_sonar_scan_range", 15000);
  level.find_plunder = getdvarfloat("scr_bt_roll_required_to_drop_bomb", 60);
  level.find_and_run_elevator_spawngroup = getdvarfloat("scr_bt_pitch_required_to_drop_bomb", 45);
  level.failedmission = getdvarint("scr_bt_additional_contrail_vfx", 1);
  level.finalthreeuav = getdvarint("scr_bt_wing_contrails_min_speed", 60);
  level.finalkillcamplaybackbegin = getdvarint("scr_bt_cloud_contrails_min_speed", 90);
  level.finalsurvivorcount = getdvarint("scr_bt_fast_contrails_min_speed", 80);
  level.find_ai_spawner = getdvarint("scr_bt_oob_override_seconds", 40);
  level.fake_digit_pool = getdvarint("scr_bt_collision_before_liftoff", 0);
  level.fiftypercent_music = getdvarint("scr_bt_hide_pilot", 0);
  level.failtimedrunquest = getdvarfloat("scr_bt_bomb_inherit_velocity", 0.4);
  level.failx1finquest = getdvarint("scr_bt_bomb_max_velocity", 330);
  level.finale_setup = getdvarint("scr_bt_bomb_min_drop_height", 800);
  level.ffsm_onground_stateenter = getdvarint("scr_bt_gas_damage_players_airplane", 3);
  level.farah_disable_ai_color_before_hallway_takedown = getdvarfloat("scr_bt_dot_velocity_ground_reduce_damage", 0);
  level.fananim = getdvarfloat("scr_bt_dot_velocity_ground_no_damage", 0.18);
  level.falling_xyratio = getdvarfloat("scr_bt_dot_velocity_ground_little_damage", 0.85);
  level.bt_ignorelandinggeardamage = getdvarint("scr_bt_ignoreLandingGearDamage", 0);
  level.bt_reducelandinggeardamage = getdvarint("scr_bt_reduceLandingGearDamage", 1);
  level.bt_dotvelocitygroundlandinggear = getdvarfloat("scr_bt_dot_velocity_ground_landing_gear", 0.25);
  level.bt_minspeedfactoryfordotvelocity = getdvarfloat("scr_bt_min_speed_factor_for_dot_velocity", 0.2);
  level.findquestplacement = getdvarint("scr_bt_velocity_ground_little_damage", 2);
  level.find_supply_station = getdvarint("scr_bt_show_runway_icon", 0);
  level.ffsm_skydive_stateenter = getdvarfloat("scr_bt_gunner_target_refresh_time", 0.1);
  level.ffsm_parachuteopen_stateenter = getdvarfloat("scr_bt_gunner_target_range", 15000);
  level.fake_hit_target_monitor = getdvarfloat("scr_bt_dmg_factor_fuselage", 0.5);
  level.fake_magic_grenade_watch = getdvarfloat("scr_bt_dmg_multiplier_propeller", 1);
  level.fake_exploder = getdvarfloat("scr_bt_dmg_multiplier_driverless", 10);
  level.fake_model = getdvarfloat("scr_bt_dmg_damage_pitch_threshold", 40);
  level.fakeprops = getdvarfloat("scr_bt_dmg_damage_roll_threshold", 45);
  level.fake_magic_grenade_watch_individual = getdvarfloat("scr_bt_dmg_damage_pitch_factor", 2);
  level.fake_trigger_think = getdvarfloat("scr_bt_dmg_damage_roll_factor", 2);
  level.fallback_index = getdvarfloat("scr_bt_dmg_damage_upside_down_factor", 20);
  level.findgunsmithattachments = getdvarfloat("scr_bt_dmg_mod_vs_fd", 5);
  level.findfirstaliveplayer = getdvarfloat("scr_bt_dmg_mod_vs_bt", 5);
  level.findnewplunderextractsite = getdvarfloat("scr_bt_dmg_mod_vs_vehicles", 5);
  level.findeventforchosenweight = getdvarfloat("scr_bt_dmg_mod_vs_AA", 10);
  level.findminmaxangleovertime = getdvarfloat("scr_bt_dmg_mod_vs_Player", 1);
  level.failx1stashquest = getdvarfloat("scr_bt_dmg_burn_down_time", 4);
  level.fast_rope_over_black = getdvarint("scr_bt_enable_server_hud", 0);
  level.ffsm_landed_stateenter = getdvarint("scr_bt_force_netfield_high_lod", 1);
  level.failsafe_door_breach_frozen = getdvarint("scr_bt_bomber_fast_contrails_min_angle", 55);
  level.ffsm_introsetup = getdvarint("scr_bt_bomber_enable_smoke_vfx", 0);
  level.failstringsetup = getdvarint("scr_bt_bomber_speed_diff_damage", 1);
  level.finale_main = getdvarint("scr_bt_bomber_longer_vehicle_explosion", 0);
  level.fight_on_jammer_2_bridge = getdvarint("scr_bt_bomber_ignore_self_collision", 1);
  level.fake_agent_model_setup = getdvarint("scr_bt_camera_follow_enable", 0);
  level.findteamwithnoplayers = getdvarfloat("scr_bt_wait_camera_follow_bomb", 0.5);
  level.findvalidspectateprop = getdvarfloat("scr_bt_wait_start_camera_follow", 0);
  level.finale = getdvarint("scr_bt_landing_gear_stay_still", 1);
  level.failsafe_door_breach_frozen_player = getdvarint("scr_bt_ads_allow_camera_transition", 1);
  level.failhistoryquest = getdvarfloat("scr_bt_ads_fade_delay_timer", 0.6);
  level.failedtext = getdvarint("scr_bt_ads_debounce_ms", 850);
  level.ffsm_nextstreamhinttime = getdvarint("scr_bt_free_look_end_delay_ms", 400);
  level.bt_damagedebouncetimems = getdvarint("scr_bt_damage_debounce_time_ms", 500);
  level.bt_damagedebouncethresholdpct = getdvarfloat("scr_bt_damage_debounce_threshold_pct", 0.3);
  level.final_wave = getdvarfloat("scr_bt_impulse_dmg_threshold_high", 4.5);
  level.final_switch_think = getdvarfloat("scr_bt_impulse_dmg_threshold_mid", 0.9);
  level.final_radius_think = getdvarfloat("scr_bt_impulse_dmg_threshold_low", 0.3);
  level.fillmaxarmorplate = getdvarfloat("scr_bt_impulse_dmg_factor_low", 0.05);
  level.filtervehiclespawnstructsfunc = getdvarfloat("scr_bt_impulse_dmg_factor_mid_low", 0.2);
  level.filtervehiclespawnstructs = getdvarfloat("scr_bt_impulse_dmg_factor_mid_high", 0.75);
  create_trial_weapon_spawn();
  create_thrust_fire();
  create_trophy_station();
  create_struct_at();
  create_struct();
  create_temp_infil_structs();
  create_solution_digit_mark();
  create_usb_anim_rig();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_bt", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_bt", "init")]]();
  }

  create_tut_loot_struct();
  create_traversal_node_and_link();
}

function create_traversal_node_and_link() {
  thread ref_1327D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_bt", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_bt", "initLate")]]();
  }

  if(istrue(level.failsecretstashquest)) {
    createspawncamera();
    return;
  }
}

function create_trial_weapon_spawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("veh_bt", 1);
  var_0.enterstartcallback = &create_rocket_death_fx;
  var_0.enterendcallback = &create_race;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &create_saw_interaction;
  var_0.reentercallback = &createflagstart;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["front"] = 50;
  var_0.exitextents["back"] = 355;
  var_0.exitextents["left"] = 255;
  var_0.exitextents["right"] = 255;
  var_0.exitextents["top"] = 10;
  var_0.exitextents["bottom"] = 50;
  var_0.allowairexit = 1;
  var_1 = "right";
  var_0.exitoffsets[var_1] = (150, -35, -45);
  var_0.exitdirections[var_1] = "right";
  var_1 = "left";
  var_0.exitoffsets[var_1] = (150, 35, -45);
  var_0.exitdirections[var_1] = "left";
  var_1 = "top_left";
  var_0.exitoffsets[var_1] = (69, -40, -45);
  var_0.exitdirections[var_1] = "left";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-355, 0, -45);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-255, 255, -45);
  var_0.exitdirections[var_1] = "back";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-200, -180, -45);
  var_0.exitdirections[var_1] = "right";
  var_2 = ["pilot", "seat_two", "seat_three", "seat_four"];
  var_3 = "pilot";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_bt", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["right", "left", "top_left", "back", "back_left", "back_right"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D8();
  var_4.animtag = "tag_seat_0";
  var_4.ref_12023 = "ping_vehicle_pilot";
  var_3 = "seat_two";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_bt", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["right", "left", "top_left", "back", "back_left", "back_right"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.ref_13E8A = getcompleteweaponname("tur_gun_bt_mp");
  var_4.ref_13E92 = "tur_gun_bt_mp";
  var_4.animtag = "tag_seat_2";
  var_4.ref_12023 = "ping_vehicle_gunner";
  var_3 = "seat_three";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_bt", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["right", "left", "top_left", "back", "back_left", "back_right"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.ref_13E8A = getcompleteweaponname("tur_gun_bt_mp");
  var_4.ref_13E92 = "tur_gun_bt_mp";
  var_4.animtag = "tag_seat_3";
  var_4.ref_12023 = "ping_vehicle_gunner";
  var_3 = "seat_four";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_bt", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["right", "back_left", "top_left", "right", "back_right", "top_right"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.ref_13E8A = getcompleteweaponname("tur_gun_bt_mp");
  var_4.ref_13E92 = "tur_gun_bt_mp";
  var_4.animtag = "tag_seat_4";
  var_4.ref_12023 = "ping_vehicle_gunner";
}

function create_thrust_fire() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh_bt", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("veh_bt", "single", ["pilot", "seat_two", "seat_three", "seat_four"]);
}

function create_trophy_station() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("veh_bt", 1);
  var_0.id = 20;
  var_0.seatids["pilot"] = 0;
  var_0.seatids["seat_two"] = 1;
  var_0.seatids["seat_three"] = 2;
  var_0.seatids["seat_four"] = 3;
  var_0.ref_12DA2[0] = 0;
  var_0.ref_12DA2[1] = 1;
  var_0.ref_12DA3["pilot"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["pilot"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["pilot"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["pilot"]["tur_gun_bt_mp"] = 1;
  var_0.ref_12DA3["seat_two"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_two"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_two"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_two"]["tur_gun_bt_mp"] = 1;
  var_0.ref_12DA3["seat_three"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_three"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_three"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_three"]["tur_gun_bt_mp"] = 1;
  var_0.ref_12DA3["seat_four"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_four"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_four"]["tur_gun_bt_mp"] = 0;
  var_0.ref_12DA3["seat_four"]["tur_gun_bt_mp"] = 1;
}

function create_struct_at() {
  level.cruisepredator_watchownerdisownaction = getdvarfloat("scr_br_bomber_health_override", 2250);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("veh_bt", level.cruisepredator_watchownerdisownaction, undefined, undefined, undefined, level.failx1stashquest);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("veh_bt");
  var_0.class = "heavy";
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("veh_bt", "light");
  var_1.ref_12024 = &createalldestinationvfx;
  var_1.ref_1202D = &createapcturret;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("veh_bt", "medium");
  var_1.ref_12024 = &createallhistorydestinations;
  var_1.ref_1202D = &createattractionicontrigger;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("veh_bt", "heavy");
  var_1.ref_12024 = &createagenttargetloadout;
  var_1.ref_1202D = &createandstartlights;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("veh_bt");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("veh_bt", 13);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("veh_bt", &createdefaultrectangularzone);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("veh_bt", &create_oscilloscope);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("tur_gun_bt_mp", 5);
}

function create_struct() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("veh_bt", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function create_temp_infil_structs() {
  level._effect["bomber_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_bomber_death_exp.vfx");
  level._effect["bomber_explode_grd"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_bomber_death_exp_ground.vfx");
  level._effect["bomber_bomb_explode_ground"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_bomber_exp.vfx");
  level._effect["bomber_bomb_explode_air"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_bomber_exp.vfx");
  level._effect["bomber_bomb_wind_vfx"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br_parachute_wisp_01");
}

#using_animtree("");

function create_solution_digit_mark() {
  level.scr_anim["bomber"]["spin_up"] = % sdr_mp_veh_bt_spin_up;
  level.scr_anim["bomber"]["spin_down"] = $sdr_mp_veh_bt_spin_down;
}

function create_usb_anim_rig() {
  game["dialog"]["bt_loadout_destroyed"] = "loadout_drop_destroyed_temp";
}

function create_silencer_pick_ups() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_bt");
  return var_0.ref_13E92;
}

function create_mp_version_of_vehicle(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_air_bomber_wz";
  var_0.targetname = "veh_bt";

  if(!isDefined(var_0.vehicletype)) {
    var_0.vehicletype = "bt_mp";
  }

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = create_silencer_pick_ups();
  var_4 = create_name_fx(var_2, var_3, "veh_s4_mil_air_bomber_turret_nose_wz", "tag_gunner_turret1_rot", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_4, getcompleteweaponname(var_3), undefined, "seat_two");
  var_4 settoparc(28);
  var_4 setbottomarc(37);
  var_4 setrightarc(96);
  var_4 setleftarc(96);
  var_4 = create_name_fx(var_2, var_3, "veh_s4_mil_air_bomber_turret_tail_wz", "tag_gunner_turret2_rot", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_4, getcompleteweaponname(var_3), undefined, "seat_three");
  var_4 settoparc(28);
  var_4 setbottomarc(37);
  var_4 setrightarc(92);
  var_4 setleftarc(92);
  var_4 = create_name_fx(var_2, var_3, "veh_s4_mil_air_bomber_turret_belly_wz", "tag_gunner_turret3_rot", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_4, getcompleteweaponname(var_3), undefined, "seat_four");
  var_4 settoparc(0);
  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "veh_bt", var_0);
  var_2.objweapon = getcompleteweaponname("tur_gun_bt_mp");
  var_2.ref_13E92 = var_3;
  var_2.dropbombs = [];

  for(var_5 = 0; var_5 < level.farah_nobraids_body; var_5++) {
    var_2.dropbombs[var_2.dropbombs.size] = 0;
  }

  var_2.shouldmodeplayfinalmoments = 0;
  var_2.ref_120B4 = level.find_ai_spawner;
  thread cruisepredator_detachplayerfromintro();
  thread cruisepredator_watchintropoddisown();
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_bt", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_bt", "create")]](var_2);
  }

  thread helis_assault3_hangar_check_size();
  thread current_ally_volume();

  if(level.ffsm_landed_stateenter) {
    var_2 unmarkkeyframedmover(1);
  }

  return var_2;
}

function helis_assault3_hangar_check_size() {
  var_0 = self;
  var_0 endon("death");
  var_0 vehphys_enablecollisioncallback(1);

  if(getdvarint("scr_br_bt_invincible", 0)) {
    return;
  }

  wait 5;
  var_1 = [];

  for(var_2 = [];; var_2 = min(var_24 * level.bt_damagedebouncethresholdpct, var_0.maxhealth)) {
    var_0 waittill("collision", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_10) && isDefined(var_10.helperdronetype) && var_10.helperdronetype == "radar_drone_recon") {
      continue;
    }

    if(istrue(level.fake_digit_pool) && !istrue(var_0.shouldmodeplayfinalmoments)) {
      continue;
    }

    if(isDefined(var_10.model)) {
      if(unset_bullet_shields(var_10)) {
        if(isDefined(var_10.owner) && isDefined(var_0.owner) && var_10.owner == var_0.owner) {
          continue;
        }

        createteamdefenderflagbase(var_10);

        if(isDefined(var_0)) {
          createquestobjicon(var_0, 9000, var_10, var_7);
        }

        continue;
      }

      if(istrue(var_0.shouldmodeplayfinalmoments) && (unresolvedcollisiontolerancesqr(var_10) || var_10 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function())) {
        if(isDefined(var_10.owner) && isDefined(var_0.owner) && var_10.owner.team != var_0.owner.team) {
          var_12 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

          foreach(var_14 in var_12) {
            var_14 dodamage(20, var_0.origin, var_10.owner, var_14, "MOD_EXPLOSIVE", "tur_gun_bt_mp");
          }

          var_16 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_10);

          foreach(var_14 in var_16) {
            var_14 dodamage(20, var_0.origin, var_0.owner, var_14, "MOD_EXPLOSIVE", "tur_gun_bt_mp");
          }
        }

        var_0 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
        var_0 dodamage(9000, var_7, undefined, undefined, "MOD_CRUSH");
        var_0 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
        var_10 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
        var_10 dodamage(9000, var_7, undefined, undefined, "MOD_CRUSH");
        var_10 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
        continue;
      }
    }

    var_19 = 1;
    var_20 = 0;
    var_21 = 0;

    switch (var_11) {
      case 0:
        var_19 = level.fake_hit_target_monitor;
        break;
      case 1:
        var_19 = level.fake_magic_grenade_watch;
        var_20 = 1;
        break;
      case 2:
        var_21 = 1;
        break;
      default:
        break;
    }

    if(var_20) {
      var_22 = var_19;
    } else {
      var_22 = var_9 * var_19;
    }

    if(istrue(level.failstringsetup)) {
      var_23 = length(var_0 vehicle_getvelocity() - var_0.current_automated_respawn_timer_value);
      var_22 *= var_23 / 17.6;
    }

    if(abs(angleclamp180(var_0.angles[0]) > level.fake_model)) {
      var_22 *= level.fake_magic_grenade_watch_individual;
    }

    if(abs(var_0.angles[2]) > level.fakeprops) {
      var_22 *= level.fake_trigger_think;
    }

    if(var_0.angles[2] > 90 || var_0.angles[2] < -90) {
      var_22 *= level.fallback_index;
    }

    var_24 = 0;

    if(var_22 > level.final_wave) {
      var_24 = var_0.maxhealth;
    } else if(var_22 > level.final_switch_think) {
      var_25 = level.final_wave - level.final_switch_think;
      var_26 = (var_22 - level.final_switch_think) / var_25;
      var_27 = var_0.maxhealth * level.filtervehiclespawnstructsfunc;
      var_28 = var_0.maxhealth * level.filtervehiclespawnstructs;
      var_24 = scripts\engine\math::lerp(var_27, var_28, var_26);
    } else if(var_22 > level.final_radius_think) {
      var_24 = var_0.maxhealth * level.fillmaxarmorplate;
    }

    var_29 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_0);

    if(!isDefined(var_29)) {
      var_24 *= level.fake_exploder;
    }

    var_30 = -1;

    if(var_11 != 1) {
      var_30 = abs(vectordot(var_8, vectorNormalize(var_0.current_automated_respawn_timer_value)));
      var_31 = 1;

      if(var_21 && var_9 < level.bt_minspeedfactoryfordotvelocity) {
        var_31 = 0;
      }

      if(var_31) {
        if(var_30 > level.falling_xyratio) {
          var_24 += var_0.maxhealth * 0.25 + randomintrange(50, 100);
        } else if(var_30 > level.fananim) {
          var_24 *= level.findquestplacement;
        } else if(level.farah_disable_ai_color_before_hallway_takedown > 0 && var_30 <= level.fananim) {
          var_24 *= level.farah_disable_ai_color_before_hallway_takedown;
        }
      }
    } else {
      var_24 += 550;
    }

    if(isDefined(var_1[var_11]) && var_1[var_11] > gettime()) {
      if(var_24 < var_2[var_11]) {
        continue;
      }
    }

    if(var_21 && var_24 > 0) {
      if(level.bt_ignorelandinggeardamage) {
        continue;
      }

      if(level.bt_reducelandinggeardamage && var_30 <= level.bt_dotvelocitygroundlandinggear) {
        continue;
      }
    }

    if(var_24 > 0) {
      createquestobjicon(var_0, var_24, var_10, var_7);
      var_1 = gettime() + level.bt_damagedebouncetimems;
    }
  }
}

function current_ally_volume() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0.current_automated_respawn_timer_value = 0;

  for(;;) {
    waittillframeend();
    var_0.current_automated_respawn_timer_value = var_0 vehicle_getvelocity();
    waitframe();
  }
}

function createquestobjicon(var_0, var_1, var_2) {
  var_3 = self;

  if(var_0 > 650) {
    cull_list_of_players(var_3, "screenshake_bt_coll_damage", "rumble_bt_coll_damage");
  }

  var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);

  if(var_3.health - var_0 <= 0) {
    if(!istrue(var_3.should_play_player_infil) && (var_1.classname == "worldspawn" || var_1 == var_3)) {
      createteamdefenderflag();
    } else {
      var_3 dodamage(var_0, var_2, undefined, undefined, "MOD_CRUSH");
      var_3 radiusdamage(var_3.origin, 512, 200, 80, var_3, "MOD_EXPLOSIVE", "tur_gun_bt_mp");
      var_3.brlootchoppercrateactivatecallback = 1;
      var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
      return;
    }
  }

  var_3 dodamage(var_0, var_2, undefined, undefined, "MOD_CRUSH");
  var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
}

function createteamdefenderflag() {
  var_0 = self;
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  foreach(var_3 in var_1) {
    var_3.donotmodifydamage = 1;
    var_3 dodamage(99, var_0.origin, var_3, var_3, "MOD_RIFLE_BULLET", "tur_gun_bt_mp");
    var_3.donotmodifydamage = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);

  foreach(var_6 in var_1) {
    var_6.plotarmor = 1;
  }

  var_0 radiusdamage(var_0.origin, 512, 200, 80, var_0, "MOD_EXPLOSIVE", "tur_gun_bt_mp");
  var_0.brlootchoppercrateactivatecallback = 1;

  foreach(var_6 in var_1) {
    var_6.plotarmor = 0;
  }
}

function create_name_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("misc_turret", var_0 gettagorigin(var_3), var_1, 0);
  var_5 linkTo(var_0, var_3, var_4, (0, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("sentry_offline");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

function create_script_wait_for_flags(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "tur_gun_bt_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(isDefined(self.owner)) {
    self.owner.br_pe_chopper_damage_time = var_0.meansofdeath;
  }

  self notify("predeath");

  if(istrue(level.finale_main)) {
    wait 0.2;
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  self setscriptablepartstate("fx", "base");
  self setscriptablepartstate("cloud_contrail", "base");
  self setscriptablepartstate("fast_contrail", "base");
  self setscriptablepartstate("engine_smoke", "base");

  if(isDefined(self.isballisticspecial)) {
    foreach(var_3 in self.isballisticspecial) {
      self setscriptablepartstate(var_3, "off");
    }
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread create_passengers_unload_groups();
  var_5 = self gettagorigin("tag_origin");

  if(!istrue(self.brlootchoppercrateactivatecallback)) {
    self radiusdamage(self.origin, 512, 200, 80, self, "MOD_EXPLOSIVE", "tur_gun_bt_mp");
  }

  var_6 = scripts\engine\utility::ter_op(self.shouldmodeplayfinalmoments, "bomber_explode", "bomber_explode_grd");
  playFX(scripts\engine\utility::getfx(var_6), var_5, anglesToForward(self.angles), anglestoup(self.angles));

  if(soundexists("s4_bt_bomb_expl_trans")) {
    playsoundatpos(var_5, "s4_bt_bomb_expl_trans");
  }

  earthquake(0.4, 800, var_5, 0.7);
  playrumbleonposition("grenade_rumble", var_5);
  physicsexplosionsphere(var_5, 500, 200, 1);
}

function cruisepredator_watchintropoddisown() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  wait 2;
  var_1 = 1;
  var_2 = [var_0];

  for(;;) {
    var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_4 = var_0.origin + anglestoup(var_0.angles) * -600;
    var_5 = scripts\engine\trace::ray_trace(var_0.origin, var_4, var_2, var_3, 0);

    if(isDefined(var_5)) {
      if(var_1 && var_5["hittype"] == "hittype_none") {
        if(!istrue(level.finale)) {
          var_0 setscriptablepartstate("landing_gear", "closing", 0);
        }

        var_0 setscriptablepartstate("bay_door", "bay_door_opening", 0);
        var_1 = 0;
      } else if(!var_1 && var_5["hittype"] != "hittype_none") {
        if(!istrue(level.finale)) {
          var_0 setscriptablepartstate("landing_gear", "opening", 0);
        }

        var_0 setscriptablepartstate("bay_door", "bay_door_closing", 0);
        var_1 = 1;
      }
    }

    wait 0.3;
  }
}

function cruisepredator_detachplayerfromintro() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0.curr_airlock_pos = 0;
  var_0.should_play_player_infil = 0;

  for(;;) {
    var_1 = [var_0];

    if(isDefined(var_0.waittill_player_picksup_armor)) {
      var_1 = [var_0, var_0.waittill_player_picksup_armor];
    }

    var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_0.origin - (0, 0, 150), var_1, var_2, 0);

    if(isDefined(var_3)) {
      if(var_3["hittype"] == "hittype_none") {
        var_0.shouldmodeplayfinalmoments = 1;
        var_0.should_play_player_infil = 1;
        var_0 setscriptablepartstate("single", "vehicle_use_in_air");
      } else if(istrue(var_0.shouldmodeplayfinalmoments)) {
        cull_list_of_players(var_0, "screenshake_bt_land", "rumble_bt_land");
        var_0.shouldmodeplayfinalmoments = 0;
        var_0 setscriptablepartstate("single", "vehicle_use");
      }
    }

    var_4 = regroup_process_started(var_0);

    if(var_0.curr_airlock_pos != var_4 && isDefined(var_0.owner)) {
      var_0.curr_airlock_pos = var_4;
      cs_flags_init(var_0.owner, 1);
    }

    wait 0.2;
  }
}

function create_passengers_unload_groups() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_bt", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_bt", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function createdefaultrectangularzone(var_0) {
  if(isDefined(var_0.damage) && var_0.damage > 0) {
    self notify("damage_taken", var_0);
  }

  return true;
}

function create_oscilloscope(var_0) {
  thread create_script_wait_for_flags(var_0);
  return true;
}

function create_silencer_pick_up(var_0, var_1) {
  if(!isDefined(var_0.turrets) || !isDefined(var_1)) {
    return undefined;
  }

  return var_0.turrets[var_1];
}

function createdevguientryforkidnapper() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("propeller_spin_up");
  var_0 notify("propeller_spin_down");

  if(istrue(var_0.ref_128E9)) {
    return;
  }

  var_0 setscriptablepartstate("propeller", "spin_up", 0);
  var_0.ref_128E9 = 1;
  wait getanimlength(level.scr_anim["bomber"]["spin_up"]);

  if(!isDefined(var_0)) {
    return;
  }

  var_0 setscriptablepartstate("propeller", "idle", 0);
}

function createdestinationvfx() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("propeller_spin_down");
  var_0 notify("propeller_spin_up");

  if(!isDefined(var_0.ref_128E9)) {
    return;
  }

  var_0 setscriptablepartstate("propeller", "spin_down", 0);
  var_0.ref_128E9 = undefined;
  wait getanimlength(level.scr_anim["bomber"]["spin_down"]);

  if(!isDefined(var_0)) {
    return;
  }

  var_0 setscriptablepartstate("propeller", "idle_no_spin", 0);
}

function create_primary_weapon_obj_from_custom_loadout(var_0) {
  var_1 = self;

  if(!isDefined(var_1.isballisticspecial)) {
    var_1.isballisticspecial = [];
  }

  if(!scripts\engine\utility::array_contains(var_1.isballisticspecial, "left_wing_damage") && randomfloat(1) < 0.4) {
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "left_wing_damage";
  }

  if(!scripts\engine\utility::array_contains(var_1.isballisticspecial, "right_wing_damage") && randomfloat(1) < 0.4) {
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "right_wing_damage";
  }

  if(var_0 && !scripts\engine\utility::array_contains(var_1.isballisticspecial, "tail_damage") && randomfloat(1) < 0.5) {
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "tail_damage";
    return;
  }
}

function createc130pathstruct(var_0) {
  var_1 = self;

  foreach(var_3 in var_1.isballisticspecial) {
    var_1 setscriptablepartstate(var_3, var_0, 0);
  }
}

function createalldestinationvfx(var_0, var_1) {
  var_2 = self;
  create_primary_weapon_obj_from_custom_loadout(var_2, 0);
  createc130pathstruct(var_2, "light");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14165(var_0, var_1);
}

function createapcturret(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416A(var_0, var_1);
}

function createallhistorydestinations(var_0, var_1) {
  var_2 = self;
  create_primary_weapon_obj_from_custom_loadout(var_2, 1);
  createc130pathstruct(var_2, "medium");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14167(var_0, var_1);
}

function createattractionicontrigger(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416B(var_0, var_1);
}

function createagenttargetloadout(var_0, var_1) {
  var_2 = self;
  create_primary_weapon_obj_from_custom_loadout(var_2, 1);
  createc130pathstruct(var_2, "heavy");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var_0, var_1);
}

function createandstartlights(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var_0, var_1);
}

function ref_1327D() {
  level.createprematchloadout = spawnStruct();
  level.createprematchloadout.powers = [];
  bhadriotshield(level.createprematchloadout, "dropbomb", "+attack", &createscript_covernodes);
}

function ref_14231(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommand(var_6, var_4);
    }
  }
}

function ref_14230(var_0) {
  if(!isDefined(self) || isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommandremove(var_6, var_4);
    }
  }
}

function bhadriotshield(var_0, var_1, var_2, var_3) {
  if(isstring(var_2)) {
    var_2 = [var_2];
  }

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
}

function cs_setup_arrays(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle)) {
    return;
  }

  var_2.vehicle.turret.turreton = 1;
  var_2.vehicle.turret setmode("manual");
  thread csm_alg();
}

function csm_alg() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_bomber");
  var_0.vehicle endon("death");
  var_1 = var_0.vehicle.turret;
  var_2 = 6;

  for(;;) {
    var_1 shootturret("tag_flash", var_2);
    wait level.ffsm_state;

    if(!var_0 attackButtonPressed()) {
      return;
    }
  }
}

function createscript_covernodes(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle.dropbombs)) {
    return;
  }

  var_3 = -1;

  for(var_4 = 0; var_4 < var_2.vehicle.dropbombs.size; var_4++) {
    if(var_2.vehicle.dropbombs[var_4] == 0) {
      var_3 = var_4;
    }
  }

  if(var_3 < 0) {
    if(isDefined(level.ref_13352)) {
      [[level.ref_13352]]("BT_RELEASE/DROP_BOMB_NO_AMMO");
    }

    var_2 playlocalsound("br_pickup_deny");
    return;
  }

  if(abs(var_2.vehicle.angles[2]) > level.find_plunder || abs(angleclamp180(var_2.vehicle.angles[0])) > level.find_and_run_elevator_spawngroup) {
    if(isDefined(level.ref_13352)) {
      [[level.ref_13352]]("BT_RELEASE/PLANE_LEVEL_WITH_GROUND");
    }

    var_2 playlocalsound("br_pickup_deny");
    return;
  }

  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_6 = [];
  var_7 = scripts\engine\trace::ray_trace(var_2.vehicle.origin, var_2.vehicle.origin - (0, 0, level.finale_setup), var_6, var_5, 0);

  if(isDefined(var_7)) {
    if(var_7["hittype"] != "hittype_none") {
      if(isDefined(level.ref_13352)) {
        [[level.ref_13352]]("BT_RELEASE/DROP_BOMB_GROUND_TOO_CLOSE");
      }

      var_2 playlocalsound("br_pickup_deny");
      return;
    }
  }

  if(istrue(var_2.vehicle.turn_on_search_light)) {
    return;
  } else {
    var_2.vehicle.turn_on_search_light = 1;
  }

  cull_list_of_players(var_2.vehicle, "screenshake_bt_shoot", "rumble_bt_shoot");
  thread createstreakinfo_ai_turret(var_2);
}

function createstreakinfo_ai_turret(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_2 = ctf_bot_defender_limit_for_team(var_1);
  var_3 = var_1.vehicle;
  var_3 endon("death");
  var_4 = var_3.origin;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(level.cumulative_damage_monitor)) {
    foreach(var_6 in level.players) {
      if(var_1 == var_6) {
        continue;
      }

      if(isDefined(var_6.vehicle) && var_6.vehicle == var_3) {
        continue;
      }

      if(var_6.origin[2] > var_4[2]) {
        continue;
      }

      var_7 = distance2dsquared(var_6.origin, var_4);

      if(var_7 < 2890000) {
        if(!isDefined(var_6.cratephysicsoff)) {
          var_6.cratephysicsoff = 1;
          thread ref_12511();

          if(var_1.team != var_6.team) {
            var_6 thread[[level.cumulative_damage_monitor]]("br_bt_bomb_alert_enemy");
          }
        }
      }
    }
  }

  if(soundexists("s4_bt_bomb_deploy_3d")) {
    var_3 playsoundtoplayer("s4_bt_bomb_deploy_3d", var_1);
  }

  var_3.dropbombs[var_0] = level.failsmokinggunquest;

  if(isDefined(var_1)) {
    cs_flags_init(var_1, 1);
  }

  var_3.watch_for_players_ledgespawners = gettime();
  thread crushing_players(var_1);
  thread createscreeneffectext(var_3);
  wait level.farobjectiveiconid;
  var_3.turn_on_search_light = 0;
}

function ctf_bot_defender_limit_for_team() {
  var_0 = self;
  var_1 = var_0.vehicle;
  var_2 = (0, 0, 0);
  var_3 = -800;
  var_4 = 0;
  var_5 = undefined;
  var_6 = 15;
  var_7 = 0.2;
  var_8 = (var_7, var_7, var_7);

  if(level.failtimedrunquest >= 0 && isDefined(var_0.vehicle)) {
    var_9 = var_1 getentityvelocity();
    var_4 = (var_9[0] * level.failtimedrunquest, var_9[1] * level.failtimedrunquest, var_2[2]);
  }

  var_10 = var_1.origin;
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_12 = [var_1, var_0];
  var_5 = var_4;
  var_13 = var_7;

  while(var_13 < var_6) {
    var_14 = var_13 - var_7;
    var_15 = var_2[2] + var_13 * var_3;

    if(var_15 > level.failx1finquest) {
      var_5 = (var_4[0], var_4[1], level.failx1finquest);
    }

    var_16 = var_5 * var_14 + (0, 0, 0.5 * var_3 * var_14 * var_14);
    var_17 = var_5 * var_13 + (0, 0, 0.5 * var_3 * var_13 * var_13);
    var_18 = var_10 + var_16;
    var_19 = var_10 + var_17;
    var_20 = scripts\engine\trace::ray_trace(var_18, var_19, var_12, var_11, 0);

    if(isDefined(var_20) && var_20["fraction"] < 1) {
      var_19 = var_20["position"] + (0, 0, 20);
      return var_19;
    }

    var_13 += var_7;
  }
}

function ref_12511() {
  var_0 = self;
  var_0 endon("disconnect");
  level endon("game_ended");
  wait 7;

  if(!isDefined(var_0)) {
    return;
  }

  var_0.cratephysicsoff = undefined;
}

function createscreeneffectext(var_0) {
  var_1 = self;
  var_1 endon("death");
  level endon("game_ended");

  if(!isDefined(var_1.owner)) {
    return;
  }

  var_2 = var_1.owner;
  var_2 endon("bt_bomb_force_refill");

  while(var_1.dropbombs[var_0] > 0) {
    var_1.dropbombs[var_0] -= 0.05;
    wait 0.05;
  }

  createscriptedspawnpoint(var_1, 1, var_0);
}

function crushing_players(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 notify("bomber_new_bomb_drop");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 setModel("lm_ach_gp_bomb_600lb_01_gameplay");
  var_2 setCanDamage(1);
  var_2.origin = var_0;
  var_2.angles = (0, 0, 0);
  var_2.health = 9000;
  var_2 show();
  var_2.owner = var_1;
  var_2.ref_123A8 = 0;
  var_2 playLoopSound("s4_bt_bomb_drop_tonal_lp");
  thread create_fake_loot_model_from_struct();

  if(isDefined(var_1.vehicle)) {
    var_1.vehicle.waittill_player_picksup_armor = var_2;
  }

  if(!isDefined(level.ref_123A9)) {
    level.ref_123A9 = [];
  }

  level.ref_123A9[level.ref_123A9.size] = var_2;
  var_3 = (0, 0, -1);

  if(level.failtimedrunquest >= 0 && isDefined(var_1.vehicle)) {
    var_4 = var_1.vehicle getentityvelocity();
    var_3 = (var_4[0] * level.failtimedrunquest, var_4[1] * level.failtimedrunquest, var_3[2]);
  }

  var_2.velocity = var_3;
  var_2 movegravity(var_3, 60);
  thread current_button_counter();
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_6 = [var_2];

  if(istrue(level.fake_agent_model_setup)) {
    thread ref_12513(var_1);
  }

  thread current_cypher_pieces();

  for(;;) {
    var_7 = var_2.origin;
    waitframe();
    var_8 = scripts\engine\trace::ray_trace(var_7, var_2.origin, var_6, var_5, 0);

    if(isDefined(var_8) && var_8["fraction"] < 1) {
      var_2.origin = var_8["position"] + (0, 0, 20);
      createteamdefenderflagbase(var_2);
      break;
    }

    if(var_2.velocity[2] > level.failx1finquest) {
      var_2.velocity = (var_2.velocity[0], var_2.velocity[1], level.failx1finquest);
    }
  }
}

function current_cypher_pieces() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  waitframe();
  playFXOnTag(level._effect["bomber_bomb_wind_vfx"], var_0, "tag_origin");
}

function ref_12513(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  wait level.findvalidspectateprop;

  if(!isDefined(var_1.gas_vfx_range_think)) {
    var_1.gas_vfx_range_think = 0;
  }

  var_1.gas_vfx_range_think += 1;
  thread ref_12515(var_1);

  if(!isDefined(var_0)) {
    return;
  }

  var_1.vehicle method_87d7(var_0);
  var_1 setclientomnvar("ui_airplane_ads_active", 0);
  var_2 = "timeout";
  thread ref_12514(var_1);

  for(;;) {
    if(!isDefined(var_2)) {
      return;
    }

    if(var_2 == "exiting_pilot_seat_bomber") {
      var_1.gas_vfx_range_think -= 1;
      var_1 setclientomnvar("ui_airplane_ads_active", 0);
      return;
    }

    if(!var_1 adsButtonPressed() || var_2 == "exiting_pilot_seat_bomber") {
      var_1.gas_vfx_range_think -= 1;
      var_1 setclientomnvar("ui_airplane_ads_active", 0);
      var_1.vehicle method_87d7();
      return;
    }

    if(var_2 == "bomber_camera_bomb_exploded") {
      return;
    }

    var_2 = scripts\engine\utility::waittill_any_in_array_or_timeout(["exiting_pilot_seat_bomber", "bomber_camera_bomb_exploded"], 1);
  }
}

function ref_12514(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("bomber_new_bomb_drop");
  var_1 endon("bomber_pilot_stop_ads");

  while(isDefined(var_0)) {
    wait 0.1;
  }

  thread ref_12515(var_1);
  var_1.gas_vfx_range_think -= 1;

  if(var_1 adsButtonPressed() && var_1.gas_vfx_range_think == 0) {
    var_1 setclientomnvar("ui_airplane_ads_active", 1);
  }

  var_1 notify("bomber_camera_bomb_exploded");
}

function ref_12515(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("bomber_new_bomb_drop");
  var_1 notify("bomber_new_fade");
  var_1 endon("bomber_new_fade");

  if(isDefined(level.critical_messages)) {
    var_1 thread[[level.critical_messages]]();
  }

  wait var_0;

  if(isDefined(level.createzombieloadout)) {
    var_1 thread[[level.createzombieloadout]]();
    return;
  }
}

function current_button_counter() {
  var_0 = self;

  while(isDefined(var_0) && isDefined(var_0.ref_123A8) && !istrue(var_0.ref_123A8)) {
    if(var_0.origin[2] < -10000) {
      createteamdefenderflagbase(var_0);
      break;
    }

    wait 0.5;
  }
}

function create_fake_loot_model_from_struct() {
  var_0 = self;
  var_0 endon("death");
  level endon("game_ended");
  wait 1;
  var_0 waittill("damage");

  if(!isDefined(var_0)) {
    return;
  }

  createteamdefenderflagbase(var_0);
}

function createteamdefenderflagbase() {
  var_0 = self;
  var_0.ref_123A8 = 1;
  var_0 stoploopsound("s4_bt_bomb_drop_tonal_lp");
  level.ref_123A9 = scripts\engine\utility::array_remove(level.ref_123A9, var_0);

  if(!isDefined(var_0.owner)) {
    var_0 delete();
    return;
  }

  var_1 = var_0.origin;
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_3 = [];
  var_4 = scripts\engine\trace::ray_trace(var_1, var_1 - (0, 0, 100), var_3, var_2, 0);
  var_5 = spawnfx(scripts\engine\utility::getfx("bomber_bomb_explode_ground"), var_1);

  if(isDefined(var_4)) {
    if(var_4["hittype"] == "hittype_none") {
      var_5 = spawnfx(scripts\engine\utility::getfx("bomber_bomb_explode_air"), var_1, anglesToForward(var_0.angles), anglestoup(var_0.angles));
    }
  }

  playsoundatpos(var_1, "s4_bt_bomb_expl_trans");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  var_5 unmarkkeyframedmover(1);
  triggerfx(var_5);
  thread createobjectivelist(var_5);
  var_0.owner.current_count_down = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  if(istrue(level.farah_says_cut_wire_yellow)) {
    var_6 = canceljoins(undefined, undefined, var_1, 980);

    if(isDefined(var_6)) {
      foreach(var_8 in var_6) {
        if(isDefined(level.ref_11A22)) {
          [[level.ref_11A22]](var_8);
          var_0.owner.current_count_down[5] += 1;
          LOC_000001de:
        }
        LOC_000001de:
      }
    }
  }

  var_10 = [];

  if(isDefined(level.resttimems)) {
    var_10 = [[level.resttimems]](var_1, 980);
  }

  var_2 = scripts\engine\trace::create_contents(1, 1, 0, 0, 0, 1, 1);
  var_3 = [var_0];

  foreach(var_12 in var_10) {
    var_4 = scripts\engine\trace::ray_trace(var_1 + (0, 0, 50), var_12.origin + (0, 0, 50), var_3, var_2, 0);

    if(isDefined(var_4["surfaceflags"]) && var_4["surfaceflags"] == 0) {
      if(var_12.team != var_0.owner.team) {
        if(isDefined(level.createpropspeclist)) {
          var_13 = [[level.createpropspeclist]](var_12);

          if(istrue(var_13)) {
            var_0.owner.current_count_down[3] += 1;
          } else {
            var_0.owner.current_count_down[4] += 1;
          }
        }

        var_12 dodamage(60, var_1, var_0.owner, var_0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb");
      }
    }

    var_12 earthquakeforplayer(0.35, 2, var_1, 980);
    var_4 = scripts\engine\trace::ray_trace(var_12.origin + (0, 0, 25), var_1 + (0, 0, 75), var_3, var_2, 0);

    if(isDefined(var_4["hittype"]) && var_4["hittype"] == "hittype_none") {
      var_12 thread scripts\cp_mp\utility\shellshock_utility::_shellshock("frag_grenade_mp", "top", 2.5, 1);
    }
  }

  var_0 radiusdamage(var_1, 512, 5000, 180, var_0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb");

  if(istrue(level.farah_says_cut_wire_green) && isDefined(level.br_pickups)) {
    var_15 = undefined;

    foreach(var_17 in level.br_pickups.crates) {
      if(isDefined(var_17.team) && isDefined(var_0.owner) && var_17.team == var_0.owner.team) {
        continue;
      }

      var_18 = distance(var_1, var_17.origin);

      if(isDefined(var_18) && var_18 < 980) {
        if(var_17.cratetype == "battle_royale_loadout") {
          if(isDefined(level.crossbowimpactwatcher)) {
            var_15 = [[level.crossbowimpactwatcher]](var_17.team, "players");
          }

          if(isDefined(level.createplayerplundereventdata)) {
            level thread[[level.createplayerplundereventdata]]("bt_loadout_destroyed", 1, var_15);
          }

          var_0.owner.current_count_down[1] += 1;
        } else {
          var_0.owner.current_count_down[2] += 1;
        }

        var_17 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();

        if(isDefined(level.cruise_predator_direction_override)) {
          var_0.owner thread[[level.cruise_predator_direction_override]]("br_bt_bomb_destroy_crate");
          LOC_00000517:
        }
        LOC_00000517:
      }
      LOC_00000517:
    }
  }

  if(istrue(level.farms2_gw_ambient_sound_load) && isDefined(level.ref_13400)) {
    foreach(var_21 in level.ref_13400.areas_remaining) {
      var_22 = distance(var_1, var_21.origin);

      if(var_22 < 980) {
        var_21.chopperexfil_sfx_before_sh070[[level.cumulative_damage_to_chopper_boss]]();
        LOC_00000588:
      }
      LOC_00000588:
    }
  }

  if(istrue(level.farah_says_cut_wire_red) && isDefined(level.br_armory_kiosk)) {
    foreach(var_25 in level.br_armory_kiosk.scriptables) {
      var_26 = distance(var_1, var_25.origin);

      if(var_26 < 980) {
        if(isDefined(var_25.visible)) {
          if(isDefined(level.little_bird_mg_mp_initspawning)) {
            foreach(var_12 in level.players) {
              if(isDefined(var_12.delay_kick_inactive_player) && var_12.delay_kick_inactive_player == var_25) {
                if(isDefined(level.createquestcircle)) {
                  var_12[[level.createquestcircle]](2);
                }
              }
            }

            [[level.little_bird_mg_mp_initspawning]](var_25);
            var_0.owner.current_count_down[0] += 1;

            if(isDefined(level.cruise_predator_direction_override)) {
              var_0.owner thread[[level.cruise_predator_direction_override]]("br_bt_bomb_destroy_kiosk");
            }

            if(isDefined(level.crossbowbolts)) {
              var_29 = [[level.crossbowbolts]]("timedrun");

              foreach(var_31 in var_29.instances) {
                if(var_31.ref_1393B.ref_13A7A == var_25) {
                  if(isDefined(level.crossbow)) {
                    var_31[[level.crossbow]]();
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  bomberbombdisabletrader(var_0, var_1);

  if(isDefined(level.vehicle) && isDefined(level.vehicle.instances)) {
    foreach(var_35 in level.vehicle.instances) {
      foreach(var_37 in var_35) {
        var_38 = distance(var_1, var_37.origin);

        if(var_38 > 980) {
          continue;
        }

        var_39 = int(var_37.maxhealth * level.fast_revive_time);
        var_37 dodamage(var_39, var_1, var_0.owner, var_0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb");

        if(var_37.vehiclename == "cargo_truck_susp_aa") {
          var_0.owner.current_count_down[6] += 1;
          continue;
        }

        var_0.owner.current_count_down[7] += 1;
        LOC_00000822:
      }
    }
  }

  if(istrue(level.farah_nobraids_body_reset)) {
    if(isDefined(level.arenaflag_showflagoutlineplayer)) {
      foreach(var_43 in level.arenaflag_showflagoutlineplayer) {
        var_44 = distance(var_1, var_43.origin);

        if(var_44 > 980) {
          continue;
        }

        var_43 dodamage(5000, var_1, var_0.owner, var_0.owner, "MOD_EXPLOSIVE", "tur_gun_bt_mp_bomb");
        var_0.owner.current_count_down[8] += 1;

        if(isDefined(level.cruise_predator_direction_override)) {
          var_0.owner thread[[level.cruise_predator_direction_override]]("br_bt_bomb_destroy_aa_turret");
          LOC_000008f5:
        }
        LOC_000008f5:
      }
    }
  }

  var_0.owner.current_count_down[9] += 1;
  var_46 = [];

  for(var_47 = 0; var_47 < var_0.owner.current_count_down.size; var_47++) {
    switch (var_47) {
      case 0:
        var_46 = "buystations";
        break;
      case 1:
        var_46 = "loadout_crates";
        break;
      case 2:
        var_46 = "other_crates";
        break;
      case 3:
        var_46 = "downed_enemy";
        break;
      case 4:
        var_46 = "enemy";
        break;
      case 5:
        var_46 = "loot";
        break;
      case 6:
        var_46 = "aa_truck";
        break;
      case 7:
        var_46 = "other_vehicles";
        break;
      case 8:
        var_46 = "aa_turret";
        break;
      case 9:
        var_46 = "total_bombs";
        break;
      default:
        break;
    }

    var_46 = var_0.owner.current_count_down[var_47];
  }

  var_46 = "location";
  var_48 = var_1[0] + "," + var_1[1] + "," + var_1[2];
  var_46 = var_48;

  if(isDefined(var_0.owner)) {
    var_0.owner dlog_recordplayerevent("dlog_event_plane_bomb_accuracy", var_46);
  }

  var_0 delete();
}

function bomberbombdisabletrader(var_0, var_1) {
  if(istrue(level.bt_dropbombdestroystrader) && isDefined(level.debug_trap_room)) {
    foreach(var_3 in level.debug_trap_room.scriptables) {
      var_4 = distance(var_1, var_3.origin);

      if(var_4 < 980 && isDefined(var_3.visible) && isDefined(level.disablearmorytraderfrombomb)) {
        [[level.disablearmorytraderfrombomb]](var_3);
        var_0.owner.current_count_down[5] += 1;

        if(isDefined(level.cruise_predator_direction_override)) {
          var_0.owner thread[[level.cruise_predator_direction_override]]("br_bt_bomb_destroy_trader");
        }
      }
    }

    return;
  }
}

function createobjectivelist(var_0) {
  var_1 = self;
  level endon("game_ended");
  wait var_0;

  if(isDefined(var_1)) {
    var_1 delete();
    return;
  }
}

function createspawncamera() {
  level.createsmokesignalfx = getEntArray("veh_a10fd_reload_drop_bomb", "targetname");

  foreach(var_1 in level.createsmokesignalfx) {
    thread createserverfontstring(level);
  }
}

function createserverfontstring(var_0) {
  level endon("game_ended");
  thread ctfnukeended(level);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1.vehicle) || !isDefined(var_1.vehicle.model) || !isDefined(var_1.vehicle.dropbombs) || var_1.vehicle.model != "veh_s4_mil_air_bomber_wz") {
      continue;
    }

    var_2 = 0;

    for(var_3 = 0; var_3 < var_1.vehicle.dropbombs.size; var_3++) {
      if(var_1.vehicle.dropbombs[var_3] == 0) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      continue;
    }

    if(isDefined(var_1.vehicle.watch_for_players_ledgespawners)) {
      var_4 = var_1.vehicle.watch_for_players_ledgespawners + level.find_free_drop_location;

      if(var_4 > gettime()) {
        continue;
      }
    }

    if(isDefined(level.crossbowusageloop)) {
      var_1 thread[[level.crossbowusageloop]]("br_bt_restock_bombs", 150);
    }

    if(isDefined(level.ctgs_recordmatchstats)) {
      var_1 thread[[level.ctgs_recordmatchstats]]("br_bt_restock_bombs");
    }

    if(isDefined(level.cumulative_damage_monitor)) {
      var_1 thread[[level.cumulative_damage_monitor]]("br_bt_restock_bombs_splash");
    }

    createscriptedspawnpoint(var_1.vehicle, level.farah_nobraids_body);
    var_1 notify("bt_bomb_force_refill");
    LOC_0000015d:
  }
}

function ctfnukeended(var_0) {
  level endon("game_ended");

  if(!istrue(level.find_supply_station)) {
    return;
  }

  level waittill("prematch_done");
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var_1 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_1, "current", var_0, "ui_mp_br_mapmenu_icon_escape_objective_friendly");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);
  }

  for(;;) {
    objective_removeallfrommask(var_1);

    if(isDefined(level.vehicle.instances) && isDefined(level.vehicle.instances["veh_bt"])) {
      foreach(var_3 in level.vehicle.instances["veh_bt"]) {
        var_4 = distance(var_3.origin, var_0);

        if(var_4 < 12000) {
          var_5 = 1;

          for(var_6 = 0; var_6 < var_3.dropbombs.size; var_6++) {
            if(var_3.dropbombs[var_6] > 0) {
              var_5 = 0;
            }
          }

          if(!var_5) {
            var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_3);

            if(isDefined(var_7)) {
              objective_addclienttomask(var_1, var_7);
            }
          }
        }
      }

      objective_showtoplayersinmask(var_1);
    }

    wait 5;
  }
}

function createscriptedspawnpoint(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && var_2.dropbombs[var_1] == 0) {
    return;
  }

  if(!isDefined(var_1)) {
    for(var_3 = 0; var_3 < var_2.dropbombs.size; var_3++) {
      var_2.dropbombs[var_3] = 0;
    }
  } else {
    var_2.dropbombs[var_1] = 0;
  }

  if(!isDefined(var_2.owner)) {
    return;
  }

  var_4 = var_2.owner;
  cs_flags_init(var_4, 1);
  var_5 = soundexists("plane_ch3_bomb_reload");

  if(var_5) {
    var_4 playsoundtoplayer("plane_ch3_bomb_reload", var_4);
    return;
  }
}

function ref_12636(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("death_or_disconnect");
  var_2 endon("exiting_pilot_seat_bomber");

  for(;;) {
    var_2 waittill(var_1);
    waittillframeend();
    var_2 thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

function ref_12635(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("exiting_pilot_seat_bomber");

  if(isbot(var_1)) {
    return;
  }

  foreach(var_3 in var_0.powers) {
    thread ref_12636(var_1, var_0);
  }
}

function create_rocket_death_fx(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3.javelin)) {
    if(isDefined(var_3.javelin.state) && var_3.javelin.state != "off" || isDefined(var_3.javelin.target) || isDefined(var_3.javelin.groundlockonent)) {
      var_4.success = 0;
      return;
    }
  }

  var_3 skydive_setbasejumpingstatus(0);
  var_3 skydive_setdeploymentstatus(0);

  if(isDefined(level.findclearflightyaw) && level.findclearflightyaw > 0) {
    var_0.origin += (0, 0, level.findclearflightyaw);
  }

  if(istrue(level.ffsm_isgulagrespawn)) {
    if(var_1 == "pilot") {
      thread ref_1315F();
    }
  }

  thread create_heartbeat_sensor_pick_ups();

  if(var_1 == "pilot") {
    thread createdevguientryforkidnapper();
  }

  if(isDefined(var_2)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);

    if(var_2 != "pilot") {
      createcallbacks(var_0, var_3, var_4, "tur_gun_bt_mp", var_2, var_1);
    }
  }

  if(var_1 == "pilot") {
    thread ref_14231(var_3);
    thread ref_12635(var_3);

    if(istrue(level.fast_rope_over_black)) {
      thread cumulative_damage_expire_time();
    }

    if(istrue(level.ffsm_introsetup)) {
      thread cur_goal_struct();
    }

    thread createnagarray();
  } else {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "tur_gun_bt_mp", var_4, 1);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
  ref_13FBF(var_3, "ui_fd_target", 2047, 0, 11, 1);

  if(var_1 != "pilot") {
    thread set_track_operational_status();
    return;
  }
}

function playerpowerrestartallcooldowns() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }

  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("exiting_pilot_seat_bomber");

  while(!isDefined(var_0.vehicle)) {
    waitframe();
  }

  while(isDefined(var_0.vehicle)) {
    if(isDefined(var_0.waittillspectating) && gettime() - var_0.waittillspectating < level.ffsm_nextstreamhinttime) {
      waitframe();
      continue;
    }

    if(var_0 method_87db()) {
      var_0.playerpowersaddhudelem = 1;
      var_0.waittillspectating = gettime();
    } else if(isDefined(var_0.waittillspectating)) {
      var_0.playerpowersaddhudelem = undefined;
      var_0.waittillspectating = undefined;
    }

    waitframe();
  }
}

function binoculars_istargetinrange() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }

  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_bomber");
  var_0 setclientomnvar("ui_airplane_ads_active", 0);

  while(!isDefined(var_0.vehicle)) {
    waitframe();
  }

  var_0.vehicle endon("death");
  var_1 = 0;

  while(isDefined(var_0.vehicle)) {
    if(isDefined(var_0.waittill_player_has_dropkit_marker) && gettime() - var_0.waittill_player_has_dropkit_marker < level.failedtext) {
      waitframe();
      continue;
    }

    if(binoculars_istargetinbroadfov() != var_1 && !isDefined(var_0.playerpowersaddhudelem)) {
      var_0.waittill_player_has_dropkit_marker = gettime();

      if(isDefined(level.critical_messages)) {
        var_0 notify("playerCinematicFadeOutForceEnd");
        var_0 thread[[level.critical_messages]]();
      }

      var_2 = gettime() + level.failhistoryquest * 1000;

      while(binoculars_istargetinbroadfov() != var_1 && gettime() < var_2) {
        waitframe();
      }

      if(isDefined(level.createzombieloadout)) {
        var_0 thread[[level.createzombieloadout]]();
      }

      if(binoculars_istargetinbroadfov() != var_1) {
        var_1 = !var_1;
        var_0 setclientomnvar("ui_airplane_ads_active", var_1);
      }
    }

    waitframe();
  }
}

function binoculars_istargetinbroadfov() {
  var_0 = self;

  if(!isDefined(var_0.vehicle)) {
    return false;
  }

  if(!var_0 adsButtonPressed()) {
    return false;
  }

  if(regroup_process_started(var_0.vehicle) != 2) {
    return false;
  }

  var_1 = [var_0.vehicle];

  if(isDefined(var_0.vehicle.waittill_player_picksup_armor)) {
    var_1 = [var_0.vehicle, var_0.vehicle.waittill_player_picksup_armor];
  }

  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_3 = scripts\engine\trace::ray_trace(var_0.vehicle.origin, var_0.vehicle.origin - (0, 0, 600), var_1, var_2, 0);
  return var_3["fraction"] >= 1;
}

function binoculars_iswithinprojectiondistance() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }

  var_0 setclientomnvar("ui_airplane_ads_active", 0);
}

function cur_goal_struct() {
  var_0 = self;
  var_0 endon("exiting_pilot_seat_bomber");
  level endon("game_ended");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    return;
  }

  var_1 = var_0.vehicle;
  var_1 endon("death");
  var_1.nuke_killplayerwithattacker = 0;

  while(isDefined(var_0.vehicle)) {
    if(var_0 fragButtonPressed() && istrue(var_1.shouldmodeplayfinalmoments) && !istrue(var_1.nuke_killplayerwithattacker)) {
      thread create_puddle_triggers();
    }

    wait 0.2;
  }
}

function createnagarray() {
  var_0 = self;
  var_0 endon("exiting_pilot_seat_aircraft");
  level endon("game_ended");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    return;
  }

  var_1 = var_0.vehicle;
  var_1 endon("death");

  if(istrue(var_1.shouldmodeplayfinalmoments)) {
    return;
  }

  for(;;) {
    while(var_1 vehicle_getspeed() < 60) {
      wait 0.2;
    }

    cull_list_of_players(var_1, "screenshake_bt_accell", "rumble_bt_accell");

    while(var_1 vehicle_getspeed() > 60) {
      wait 1.5;
    }
  }
}

function create_puddle_triggers() {
  var_0 = self;
  var_0 endon("death");
  var_0 notify("engineSmokeThink");
  var_0 endon("engineSmokeThink");
  var_0.nuke_killplayerwithattacker = 1;
  var_0 setscriptablepartstate("engine_smoke", "engine_smoke", 1);
  cull_list_of_players(var_0, "screenshake_fd_airbrake", "rumble_bt_airbrake");

  if(soundexists("s4_fd_air_brake")) {
    var_0 playsoundtoplayer("s4_fd_air_brake", var_0.owner);
  }

  wait 2;

  while(isDefined(var_0.owner) && var_0.owner fragButtonPressed()) {
    wait 0.4;
  }

  var_0.nuke_killplayerwithattacker = 0;
  var_0 setscriptablepartstate("engine_smoke", "base", 0);
}

function createcallbacks(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = create_silencer_pick_up(var_0, var_4);

  if(!istrue(var_2.playerdisconnect)) {
    var_1 enableturretdismount();
    var_1 controlturretoff(var_6);

    if(var_4 != "pilot" && !istrue(var_2.playerdeath)) {
      creategulagjailloadout(var_1);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_1, var_0, var_0.ref_13E92, var_2, 1);
    }
  }

  var_6.owner = undefined;
  var_6 setotherent(undefined);
  var_6 setentityowner(undefined);
  var_6 setsentryowner(undefined);
}

function create_heartbeat_sensor_pick_ups() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("vehicle_contrails_debug");
  level endon("game_ended");
  var_0.ref_145C9 = 0;
  var_0.helicrash = 0;
  var_0.spawn_fake_letter = 0;

  for(;;) {
    if(istrue(var_0.ref_145C9)) {
      if(var_0 vehicle_getspeed() < level.finalthreeuav) {
        var_0.ref_145C9 = 0;
        var_0 setscriptablepartstate("fx", "base", 0);
      }
    } else if(var_0 vehicle_getspeed() > level.finalthreeuav) {
      var_0.ref_145C9 = 1;
      var_0 setscriptablepartstate("fx", "trails", 0);
    }

    if(istrue(level.failedmission)) {
      if(istrue(var_0.helicrash)) {
        if(var_0 vehicle_getspeed() < level.finalkillcamplaybackbegin) {
          var_0.helicrash = 0;
          var_0 setscriptablepartstate("cloud_contrail", "base", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.finalkillcamplaybackbegin) {
        var_0.helicrash = 1;
        var_0 setscriptablepartstate("cloud_contrail", "cloud_contrail", 0);
      }

      if(istrue(var_0.spawn_fake_letter)) {
        if(var_0 vehicle_getspeed() < level.finalsurvivorcount || abs(var_0.angles[2]) < level.failsafe_door_breach_frozen) {
          var_0.spawn_fake_letter = 0;
          var_0.ref_138A5 = undefined;
          var_0 setscriptablepartstate("fast_contrail", "base", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.finalsurvivorcount && abs(var_0.angles[2]) > level.failsafe_door_breach_frozen) {
        var_0.spawn_fake_letter = 1;
        var_0.ref_138A5 = gettime();
        var_0 setscriptablepartstate("fast_contrail", "fast_contrail", 0);
      }
    }

    if(istrue(var_0.spawn_fake_letter)) {
      if(isDefined(var_0.ref_138A5) && gettime() - var_0.ref_138A5 > 500) {
        var_0 setscriptablepartstate("rumble_turn", "rumble_bt_turn", 0);
        var_0.ref_1443E = 1;
      }
    } else if(istrue(var_0.ref_1443E)) {
      var_0 setscriptablepartstate("rumble_turn", "neutral", 0);
      var_0.ref_1443E = undefined;
    }

    wait 0.3;
  }
}

function regroup_process_started() {
  var_0 = self;
  var_1 = 0;

  if(var_0.shouldmodeplayfinalmoments) {
    var_1 = 2;
  } else if(var_0 vehicle_getspeed() > 5) {
    var_1 = 1;
  } else {
    var_1 = 0;
  }

  return var_1;
}

function create_race(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    thread create_rig_for_usb_animation(var_0, var_1, var_2, var_3, var_4);
  } else if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "pilot" || var_1 == "seat_two" || var_1 == "seat_three" || var_1 == "seat_four") {
      creategulagjailloadout(var_3);
    }
  }

  if(!istrue(level.client_activate)) {
    var_3 skydive_setbasejumpingstatus(1);
    var_3 skydive_setdeploymentstatus(1);
    return;
  }
}

function create_rig_for_usb_animation(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3.should_hide_buried_mother_corpse)) {
    var_3.should_hide_buried_mother_corpse = 1;
  } else {
    var_3.should_hide_buried_mother_corpse += 1;
  }

  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_pickup_origin(var_0, var_1, var_2, var_4);

  if(isDefined(var_3.carriable_set_dropped)) {
    if(isDefined(level.createpropspecatehud)) {
      var_3 thread[[level.createpropspecatehud]]();
    }
  }

  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && (var_2 == "seat_two" || var_2 == "seat_three" || var_2 == "seat_four")) {
    var_5 = "bt_mp";
    var_6 = 6;
  }

  if(var_1 == "pilot") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_0.owner = var_3;
    var_3 controlslinkTo(var_0);
    cs_flags_init(var_3, 1);
    var_3.current_count_down = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    if(istrue(level.failsafe_door_breach_frozen_player)) {
      thread binoculars_istargetinrange();
    }

    thread playerpowerrestartallcooldowns();
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  } else if(var_1 == "seat_two" || var_1 == "seat_three" || var_1 == "seat_four") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = create_silencer_pick_up(var_0, var_1);
    var_7.owner = var_3;
    var_7 setotherent(var_3);
    var_7 setentityowner(var_3);
    var_7 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_7);
    create_heartbeat_sensor_pick_up(var_3);
    var_3 setentitysoundcontext("vehicle", "interior", 0.2);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(getdvarint("scr_enable_ap_visionset_override", 1)) {
    if(isDefined(level..visionsetoverrideplanes)) {
      var_3 visionsetnakedforplayer(level..visionsetoverrideplanes, 0);
    } else {
      var_3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("mp_wz_island_ap");
    }
  }

  wait 1;

  if(istrue(level.fiftypercent_music) && isDefined(var_3) && var_1 == "pilot") {
    var_3 playerhide();
    return;
  }
}

function create_saw_interaction(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && var_1 == "pilot") {
    thread ref_14230(var_3);
    createrectangularzonebasedonent(var_3);
    var_3 notify("exiting_pilot_seat_bomber");
    thread createdestinationvfx();
    var_3 notify("bomberHeadIconForceDelete");
    cs_flags_init(var_3, 0);

    if(isDefined(level.createzombieloadout)) {
      var_3 thread[[level.createzombieloadout]]();
    }

    if(isDefined(var_3.playerpowersaddhudelem)) {
      var_3.playerpowersaddhudelem = undefined;
      var_3.waittillspectating = undefined;
    }

    var_3 setclientomnvar("ui_airplane_ads_active", 0);
  }

  if(istrue(var_4.success)) {
    create_score_message(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function create_score_message(var_0, var_1, var_2, var_3, var_4) {
  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_protect_hq_zone(var_0, var_1, var_2, var_4);

  if(var_1 == "pilot") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
    var_0.owner = undefined;
  } else if(var_1 == "seat_two" || var_1 == "seat_three" || var_1 == "seat_four") {
    var_3 setentitysoundcontext("vehicle", "", 0.2);
  }

  var_5 = !isDefined(var_2);

  if(var_5 && var_3 hasweapon(var_0.ref_13E92) || var_1 == "tag_seat_2" || var_1 == "tag_seat_3" || var_1 == "tag_seat_4") {
    var_6 = create_silencer_pick_up(var_0, var_1);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);

      if(!istrue(var_4.playerdeath)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0.ref_13E92, var_4, 1);
      }

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);
    var_6 setentityowner(undefined);
    var_6 setsentryowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      creategulagjailloadout(var_3);
    }
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 controlsunlink();

    if(istrue(var_4.playerdeath)) {
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
    }

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  if(istrue(level.failsafe_door_breach_frozen_player)) {
    binoculars_iswithinprojectiondistance(var_3);
  }

  if(isDefined(level.ref_142D1)) {
    var_3 visionsetnakedforplayer(level.ref_142D1, 0);
  } else {
    var_3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("", 0);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function create_heartbeat_sensor_pick_up(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_bt");

  if(istrue(var_1.ref_133D3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ctmgGunnerMissileRedux", 0.4, 0, &create_smoke_occluder);
}

function creategulagjailloadout(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_bt");

  if(istrue(var_1.ref_133D3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ctmgGunnerMissileRedux", 0);
}

function create_smoke_occluder(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "MOD_PROJECTILE_SPLASH" && var_4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  switch (var_5.basename) {
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

function createflagstart(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F6(var_4);
  thread creategulagarenaloadout(var_0, var_1, var_2, var_3, var_4);
}

function creategulagarenaloadout(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "pilot") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F7(var_5);
    return;
  }
}

function ref_13DDA() {
  return true;
}

function trophy_protectionsuccessful(var_0) {
  self.ref_13DDF--;
  var_1 = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyDestroyTarget", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyDestroyTarget", "init")]](var_0);
  }

  var_2 = trophy_getbesttag(var_1);
  self setscriptablepartstate("trophy_detonate", var_2);
  var_3 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_4 = combineangles(var_3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyExplode", "init")) {
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyExplode", "init")]](var_1, var_4);
  }

  if(self.ref_13DDF == 0) {
    self notify("upgrade_message", "trophy_no_ammo");
    self waittill("trophy_ammo_refill");
    return;
  }

  self notify("upgrade_message", "trophy_ammo_used");
}

function trophy_getbesttag(var_0) {
  var_1 = ["tag_trophy_1", "tag_trophy_2", "tag_trophy_3", "tag_trophy_4"];
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = distancesquared(var_6, var_0);

    if(var_8 == 0 || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

function create_tut_loot_struct() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_bt", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &create_seatids_override;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("veh_bt", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function create_seatids_override() {
  var_0 = getDvar("scr_br_bomber_struct_string", "veh_bt");

  if(isDefined(level.ref_1218A) && level.ref_1218A.size != 0) {
    var_1 = level.ref_1218A;
  } else {
    var_1 = scripts\engine\utility::getStructArray(var_1, "targetname");
  }

  if(var_1.size > 0) {
    var_1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_1, 1);

    if(var_1.size > 1) {
      var_1 = scripts\engine\utility::array_randomize(var_1);
    }
  }

  return var_1;
}

function cs_flags_init(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || !isDefined(var_1.vehicle) || isbot(var_1)) {
    return;
  }

  var_2 = var_1.vehicle;

  if(!isDefined(var_2.curr_airlock_pos) || !isDefined(var_2.dropbombs)) {
    return;
  }

  var_3 = cs_add_to_struct_array(var_0, var_2.curr_airlock_pos, var_2.dropbombs);
  var_1 setclientomnvar("ui_br_fd_state", var_3);
}

function cs_add_to_struct_array(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = 3;
  var_5 = 127;

  for(var_6 = 0; var_6 < var_2.size; var_6++) {}

  var_7 = int(var_0) &var_3;
  var_7 += (int(var_1) &var_4) << 1;

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 += (int(var_2[var_6] / level.failsmokinggunquest * 127) &var_5) << 3 + 7 * var_6;
  }

  return var_7;
}

function cumulative_damage_expire_time() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_bomber");
  var_1 = 40;
  var_2 = -135;
  var_0.cruisepredator_watchgameend = ref_12530(var_0, var_1, var_2, "left", "middle", "center", "bottom", &"MP_WZ_ISLAND/FD_IN_AIR_COUNTER");

  while(!isDefined(var_0.vehicle)) {
    wait 0.5;
  }

  thread current_anim_ref();
}

function createrectangularzonebasedonent() {
  var_0 = self;

  if(isDefined(var_0.cruisepredator_watchgameend)) {
    var_0.cruisepredator_watchgameend destroy();
  }

  var_0.cruisepredator_watchgameend = undefined;
}

function current_anim_ref() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }

  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_bomber");

  for(;;) {
    if(!isDefined(var_0.vehicle)) {
      return;
    }

    var_1 = 0;

    foreach(var_3 in level.vehicle.instances["veh_bt"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments)) {
        var_1++;
      }
    }

    if(isDefined(level.vehicle.instances["veh_a10fd"])) {
      foreach(var_6 in level.vehicle.instances["veh_a10fd"]) {
        if(istrue(var_6.shouldmodeplayfinalmoments)) {
          var_1++;
        }
      }
    }

    var_0.cruisepredator_watchgameend setvalue(var_1);
    wait 3;
  }
}

function ref_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = init_reach_pipe_room("default", 1);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 1;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6)) {
    var_8.label = var_6;
  }

  if(isDefined(var_7)) {
    var_8 setvalue(var_7);
  }

  return var_8;
}

function init_reach_pipe_room(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.hidden = 0;
  return var_2;
}

function ref_1315F() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("bomberHeadIconForceDelete");
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
  }

  wait 2;

  while(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(var_0)) {
    var_2 = [];
    var_3 = rooftop_active();
    var_4 = var_3[0];
    var_5 = var_3[1];
    var_3 = undefined;

    foreach(var_7 in level.players) {
      if(var_7.team == var_0.team) {
        continue;
      }

      if(isDefined(level.ctf_bot_attacker_limit_for_team)) {
        if(var_7[[level.ctf_bot_attacker_limit_for_team]]()) {
          continue;
        }
      }

      if(isDefined(level.cruisepredator_assigntargetmarkers)) {
        if(var_7[[level.cruisepredator_assigntargetmarkers]]("specialty_guerrilla") || var_7[[level.cruisepredator_assigntargetmarkers]]("specialty_covert_ops")) {
          continue;
        }
      }

      if(isDefined(var_7.vehicle) && isDefined(var_7.vehicle.targetname) && (var_7.vehicle.targetname == "veh_bt" || var_7.vehicle.targetname == "veh_a10fd")) {
        if(var_7.vehicle _calloutmarkerping_isvehicleoccupiedbyenemy::ref_1331B(var_7)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_7);
        }

        continue;
      }

      if(isDefined(var_7.currentweapon) && isDefined(var_7.currentweapon.basename) && (var_7.currentweapon.basename == "manual_turret_flak_mp_highrof" || var_7.currentweapon.basename == "manual_turret_flak_mp" || var_7.currentweapon.basename == "manual_turret_flak_vehicle")) {
        var_2 = scripts\engine\utility::array_add(var_2, var_7);
        continue;
      }

      var_8 = ref_13D9C(var_7.origin, var_0.vehicle.origin, var_4, var_5);

      if(istrue(var_8)) {
        var_2 = scripts\engine\utility::array_add(var_2, var_7);
      }
    }

    if(isDefined(level.decoygrenades)) {
      foreach(var_11 in level.decoygrenades) {
        if(!isDefined(var_11)) {
          continue;
        }

        if(isDefined(var_11.team) && var_11.team == var_0.team) {
          continue;
        }

        var_8 = ref_13D9C(var_11.origin, var_0.vehicle.origin, var_4, var_5);

        if(istrue(var_8)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_11);
        }
      }
    }

    if(istrue(level.farah_says_cut_wire_red)) {
      if(isDefined(level.br_armory_kiosk.scriptables)) {
        foreach(var_14 in level.br_armory_kiosk.scriptables) {
          if(!istrue(var_14.visible)) {
            continue;
          }

          var_15 = distance(var_0.vehicle.origin, var_14.origin);

          if(var_15 < 20000) {
            var_2 = scripts\engine\utility::array_add(var_2, var_14);
          }
        }
      }
    }

    if(isDefined(level.br_pickups.crates)) {
      foreach(var_18 in level.br_pickups.crates) {
        if(!isDefined(var_18) || !isDefined(var_18.origin)) {
          continue;
        }

        if(isDefined(var_18.team) && var_18.team == var_0.team) {
          continue;
        }

        var_19 = distance(var_0.vehicle.origin, var_18.origin);

        if(isDefined(var_19) && var_19 < 20000) {
          var_2 = scripts\engine\utility::array_add(var_2, var_18);
        }
      }
    }

    if(var_2.size > 0) {
      var_21 = level.teamdata[var_0.team]["alivePlayers"];

      if(istrue(var_1)) {
        var_21 = level.squaddata[var_0.team][var_0.squadindex].players;
      }

      foreach(var_23 in var_21) {
        if(!isalive(var_23)) {
          continue;
        }

        if(isDefined(level.ctf_bot_attacker_limit_for_team)) {
          if(var_23[[level.ctf_bot_attacker_limit_for_team]]()) {
            continue;
          }
        }

        var_24 = distance(var_0.vehicle.origin, var_23.origin);

        if(var_24 < 10000) {
          foreach(var_26 in var_2) {
            thread cur_vision(var_23, var_26);
          }
        }
      }

      if(soundexists("s4_fd_scan_ping")) {
        var_0 playsoundtoplayer("s4_fd_scan_ping", var_0);
      }
    }

    wait 3.25;
  }
}

function rooftop_active() {
  var_0 = self;
  var_0 notify("get_sonar_cone_scan_vertices");
  var_0 endon("get_sonar_cone_scan_vertices");
  var_1 = var_0.vehicle.origin;
  var_2 = anglesToForward(var_0.vehicle.angles);
  var_2 = (var_2[0], var_2[1], 0);
  var_3 = vectorcross(var_2, (0, 0, 1));
  var_4 = var_2 * level.findavailableteam * cos(level.findanyaliveplayer);
  var_5 = level.findavailableteam * sin(level.findanyaliveplayer);
  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;
  var_9 = undefined;

  for(var_10 = 0; var_10 < 2; var_10++) {
    var_11 = var_10 / 2 * 360;
    var_12 = var_1 + var_4 + var_5 * var_3 * cos(var_11);
    var_7 = var_12;

    if(isDefined(var_9)) {
      var_8 = var_12;
      continue;
    }

    var_9 = var_12;
  }

  return [var_8, var_9];
}

function ref_13D9C(var_0, var_1, var_2, var_3) {
  var_4 = updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3);

  if(var_4) {
    return 1;
  }

  return 0;
}

function updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3) {
  if(!use_nvg_think(var_0, var_1, var_2)) {
    return false;
  }

  if(!use_nvg_think(var_0, var_2, var_3)) {
    return false;
  }

  if(!use_nvg_think(var_0, var_3, var_1)) {
    return false;
  }

  return true;
}

function use_nvg_think(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]) < 0;
}

function cur_vision(var_0, var_1) {
  var_2 = self;
  var_3 = undefined;

  if(isDefined(var_0.classname) && var_0.classname == "scriptable_br_plunder_box" || isDefined(var_0.cratetype)) {
    var_4 = "hud_icon_ground_marked_obj";
    var_3 = var_0.origin;
  } else if(updateexpiredlootleader(var_1) || var_1 _calloutmarkerping_isvehicleoccupiedbyenemy::updatedroprelicsfunc()) {
    var_4 = "hud_icon_air_marked";
  } else {
    var_4 = "hud_icon_ground_marked";
  }

  var_5 = 8;
  var_6 = 1;
  var_7 = 500;
  var_8 = 31500;
  var_9 = var_2 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_4, var_4, var_5, var_6, var_8, var_7, undefined, 1, 1, var_4);
  cur_wave_start_time(var_4, var_2);
  scriptedspawnpointarray(var_4, var_2, var_3);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_9);
}

function scriptedspawnpointarray(var_0, var_1) {
  var_2 = self;

  if(!isDefined(level.cruise_predator_direction_override)) {
    return;
  }

  if(!isDefined(var_2) || !isDefined(var_0) || !isDefined(var_0.lastkilledby) || !isDefined(var_0.lastkilledby.team)) {
    return;
  }

  if(!isent(var_0) || !isPlayer(var_0)) {
    return;
  }

  if(var_0.health != 0) {
    return;
  }

  if(var_2 == var_1 && var_0.lastkilledby.team == var_2.team && var_0.lastkilledby != var_2) {
    var_2 thread[[level.cruise_predator_direction_override]]("br_fd_mark_assist");
    return;
  }
}

function cur_wave_start_time(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("bomberHeadIconForceDelete");
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death_or_disconnect", 3);
}

function updateexpiredlootleader() {
  var_0 = self;

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.targetname) && var_0.vehicle.targetname == "veh_bt") {
    return true;
  }

  return false;
}

function unresolvedcollisiontolerancesqr() {
  var_0 = self;

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_0.targetname) && var_0.targetname == "veh_bt") {
    return true;
  }

  return false;
}

function unset_bullet_shields() {
  var_0 = self;

  if(isDefined(var_0.model) && var_0.model == "lm_ach_gp_bomb_600lb_01_gameplay") {
    return true;
  }

  return false;
}

function set_track_operational_status(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("death_or_disconnect");

  if(!isDefined(var_0)) {
    var_0 = level.ffsm_skydive_stateenter;
  }

  jumpiftrue(isDefined(var_1)) LOC_0000002d;
  var_1 = level.ffsm_parachuteopen_stateenter;

  while(isDefined(var_2.vehicle)) {
    var_3 = var_2.origin;
    var_4 = var_2 getplayerangles();
    var_5 = anglesToForward(var_4);
    var_6 = var_3 + var_5 * var_1;
    var_7 = scripts\engine\trace::ray_trace(var_3, var_6);
    var_8 = var_7["entity"];

    if(isDefined(var_8) && isDefined(var_8.entity_number) && isDefined(var_8.team) && var_2.team != var_8.team) {
      var_9 = isDefined(var_8.vehiclename);
      var_10 = !isDefined(var_2.ref_13A7E) || var_2.ref_13A7E != var_8.entity_number;
      var_11 = !isDefined(var_2.ref_13A7F) || var_2.ref_13A7F != var_9;

      if(var_10) {
        ref_13FBF(var_2, "ui_fd_target", var_8.entity_number, 0, 11, 1);
        var_2.ref_13A7E = var_8.entity_number;
      }

      if(var_11) {
        ref_13FBF(var_2, "ui_fd_target", var_9, 11, 1, 0);
        var_2.ref_13A7F = var_9;
      }
    } else if(isDefined(var_2.ref_13A7E) || isDefined(var_2.ref_13A7F)) {
      ref_13FBF(var_2, "ui_fd_target", 2047, 0, 11, 1);
      var_2.ref_13A7E = undefined;
      var_2.ref_13A7F = undefined;
    }

    wait var_0;
  }
}

function ref_13FBF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  if(!isDefined(var_1)) {
    return;
  }

  var_6 = int(pow(2, var_3)) - 1;
  var_7 = (var_1 &var_6) << var_2;
  var_8 = ~(var_6 << var_2);
  var_9 = self calloutmarkerping_entityzoffset(var_0);

  if(istrue(var_4)) {
    self setclientomnvar(var_0, var_7);
    return;
  } else if(!isDefined(var_9)) {
    var_9 = var_8;
  }

  var_10 = var_9 &var_8;

  if(!isDefined(var_7)) {
    return;
  }

  var_11 = var_10 + var_7;

  if(var_11 != var_9) {
    self setclientomnvar(var_0, var_11);
    return;
  }
}

function cull_list_of_players(var_0, var_1) {
  var_2 = self;
  var_2 setscriptablepartstate("screenshake", var_0, 0);
  var_2 setscriptablepartstate("rumble", var_1, 0);
}