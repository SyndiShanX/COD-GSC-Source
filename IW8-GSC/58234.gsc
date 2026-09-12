/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58234.gsc
***********************************************/

function bot_gulag_think() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_a10fd", 1);
  var_0.destroycallback = &bot_get_stored_custom_classes;
  var_0.ref_13E92 = "tur_gun_fd_mp_seeking";
  level.pindia_headlights = getdvarint("scr_fd_start_in_the_air", 0);
  level.picking_up_minigun = getdvarfloat("scr_fd_gunner_time_between_bullets", 0.1);
  level.picked_up_weapon = getdvarint("scr_fd_enable_sonar", 1);
  level.pilot_model = getdvarint("scr_fd_sonar_scan_angle", 35);
  level.pilot_setups = getdvarint("scr_fd_sonar_scan_range", 15000);
  level.ph_checkforovertime = getdvarint("scr_fd_additional_contrail_vfx", 1);
  level.pickuptrigger = getdvarint("scr_fd_wing_contrails_min_speed", 65);
  level.pickup_truck_initomnvars = getdvarint("scr_fd_cloud_contrails_min_speed", 100);
  level.pickupchecks = getdvarint("scr_fd_fast_contrails_min_speed", 90);
  level.pilot_anim_loop = getdvarint("scr_fd_oob_override_seconds", 40);
  level.phfrozen = getdvarint("scr_fd_collision_before_liftoff", 0);
  level.pickprematchrandomloadout = getdvarint("scr_fd_hide_pilot", 0);
  level.pickedupcoreminigun = getdvarint("scr_fd_gas_damage_players_airplane", 3);
  level.pick_up_data = getdvarfloat("scr_fd_dot_velocity_ground_no_damage", 0.15);
  level.pick_from_preset_solutions = getdvarfloat("scr_fd_dot_velocity_ground_little_damage", 0.85);
  level.fd_ignorelandinggeardamage = getdvarint("scr_fd_ignoreLandingGearDamage", 0);
  level.fd_reducelandinggeardamage = getdvarint("scr_fd_reduceLandingGearDamage", 1);
  level.fd_dotvelocitygroundlandinggear = getdvarfloat("scr_fd_dot_velocity_ground_landing_gear", 0.25);
  level.fd_minspeedfactoryfordotvelocity = getdvarfloat("scr_fd_min_speed_factor_for_dot_velocity", 0.2);
  level.pit_locations = getdvarint("scr_fd_velocity_ground_little_damage", 2);
  level.phase_three_combat = getdvarint("scr_fd_auto_target", 1);
  level.phase_zero_combat = getdvarfloat("scr_fd_auto_target_enable_with_ads_only", 0);
  level.phclass = getdvarfloat("scr_fd_auto_target_refresh_time", 0.1);
  level.phase_two_combat = getdvarfloat("scr_fd_auto_target_angle", 2.25);
  level.phaseindex = getdvarfloat("scr_fd_auto_target_range", 12000);
  level.pingedenemies = getdvarfloat("scr_fd_dmg_mod_vs_fd", 5);
  level.ping_response_time = getdvarfloat("scr_fd_dmg_mod_vs_bt", 3.75);
  level.pistolslide = getdvarfloat("scr_fd_dmg_mod_vs_vehicles", 5);
  level.pindia_vehicle_registration = getdvarfloat("scr_fd_dmg_mod_vs_AA", 10);
  level.pipe_room_dogtag_revive = getdvarfloat("scr_fd_dmg_mod_vs_Player", 0.475);
  level.phone_group_spawned = getdvarfloat("scr_fd_dmg_multiplier_fuselage", 0.5);
  level.phonehint = getdvarfloat("scr_fd_dmg_multiplier_propeller", 1.5);
  level.phone_group_spawned_timeout = getdvarfloat("scr_fd_dmg_multiplier_landing_gear", 0);
  level.phone = getdvarfloat("scr_fd_dmg_multiplier_driverless", 10);
  level.phoneisringing = getdvarfloat("scr_fd_dmg_damage_pitch_threshold", 40);
  level.phoneplayring = getdvarfloat("scr_fd_dmg_damage_roll_threshold", 45);
  level.phoneisnotringing = getdvarfloat("scr_fd_dmg_damage_pitch_factor", 2);
  level.phonemorsesinglescriptableused = getdvarfloat("scr_fd_dmg_damage_roll_factor", 2);
  level.phonesfx = getdvarfloat("scr_fd_dmg_damage_upside_down_factor", 20);
  level.phcountdowntimer = getdvarfloat("scr_fd_dmg_burn_down_time", 4);
  level.pickclassbr = getdvarint("scr_fd_enable_server_hud", 0);
  level.pickedpball = getdvarint("scr_fd_force_netfield_high_lod", 1);
  level.pickup_truck_initdamage = getdvarint("scr_fd_aircraft_max_allowed", 30);
  level.ph_setfinalkillcamwinner = getdvarfloat("scr_fd_aircraft_respawn", 0);
  level.ph_endgame = getdvarfloat("scr_fd_aircraft_type", 1);
  level.phase_five_combat = getdvarint("scr_fd_aircraft_respawn_max_circle_index", 4);
  level.ph_loadouts = getdvarint("scr_fd_aircraft_fast_contrails_min_angle", 55);
  level.phase_four_combat = getdvarint("scr_fd_aircraft_speed_diff_damage", 1);
  level.pickup_timeout = getdvarint("scr_fd_aircraft_longer_vehicle_explosion", 0);
  level.pickrandomspawn = getdvarint("scr_fd_aircraft_ignore_self_collision", 1);
  level.pistolweapon = getdvarint("scr_fd_turret_owner_is_airplane", 0);
  level.pilot_linkto_origin_offset = getdvarint("scr_fd_skydive_ignore_auto_target", 1);
  level.fd_damagedebouncetimems = getdvarint("scr_fd_damage_debounce_time_ms", 500);
  level.fd_damagedebouncethresholdpct = getdvarfloat("scr_fd_damage_debounce_threshold_pct", 0.3);
  level.pickup_sound_playerwm_handler = getdvarfloat("scr_fd_impulse_dmg_threshold_high", 4.5);
  level.pickup_sound_playervm_handler = getdvarfloat("scr_fd_impulse_dmg_threshold_mid", 0.9);
  level.pickup_sound_hvt_handler = getdvarfloat("scr_fd_impulse_dmg_threshold_low", 0.3);
  level.pickrandomvehiclespawn = getdvarfloat("scr_fd_impulse_dmg_factor_low", 0.05);
  level.pickup_saw_and_start_mission = getdvarfloat("scr_fd_impulse_dmg_factor_mid_low", 0.2);
  level.pickup_gasmask = getdvarfloat("scr_fd_impulse_dmg_factor_mid_high", 0.75);
  bot_is_capturing_hq_zone();
  bot_hq_start();
  bot_is_capturing_zone();
  bot_has_streak_in_crate();
  bot_has_player_enemy();
  bot_hp_allow_predictive_capping();
  bot_gun_pick_personality_from_weapon();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_a10fd", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_a10fd", "init")]]();
  }

  bot_is_in_gas();
  bot_hq_think();
}

function bot_hq_think() {
  thread ref_1327D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_a10fd", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_a10fd", "initLate")]]();
    return;
  }
}

function bot_is_capturing_hq_zone() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("veh_a10fd", 1);
  var_0.enterstartcallback = &bot_get_low_on_all_ammo;
  var_0.enterendcallback = &bot_get_human_picked_class;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &bot_get_num_teammates_capturing_zone;
  var_0.reentercallback = &bot_parachute_into_map;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["front"] = 0;
  var_0.exitextents["back"] = 255;
  var_0.exitextents["left"] = 150;
  var_0.exitextents["right"] = 150;
  var_0.exitextents["top"] = 10;
  var_0.exitextents["bottom"] = 50;
  var_0.allowairexit = 1;
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-150, 150, -45);
  var_0.exitdirections[var_1] = "left";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-150, -150, -45);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-255, 0, -45);
  var_0.exitdirections[var_1] = "back";
  var_1 = "front";
  var_0.exitoffsets[var_1] = (30, 0, -45);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_left";
  var_0.exitoffsets[var_1] = (90, 35, 45);
  var_0.exitdirections[var_1] = "left";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-90, 35, 45);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["pilot", "gunner"];
  var_3 = "pilot";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_a10fd", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["back_left", "back_right", "back"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D8();
  var_4.ref_13E8A = getcompleteweaponname("tur_gun_fd_mp_seeking");
  var_4.ref_13E92 = "tur_gun_fd_mp_seeking";
  var_4.animtag = "tag_seat_0";
  var_4.ref_12023 = "ping_vehicle_pilot";
  var_3 = "gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_a10fd", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["back_left", "back_right", "back"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "tag_seat_2";
  var_4.ref_12023 = "ping_vehicle_rider";
  var_4.ref_145E0 = getdvarint("scr_fd_passenger_world_up_ref", 0);
  var_4.ref_1409C = getdvarint("scr_fd_passenger_use_tag_angles", 1);
}

function bot_hq_start() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh_a10fd", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("veh_a10fd", "single", ["pilot", "gunner"]);
}

function bot_is_capturing_zone() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("veh_a10fd", 1);
  var_0.id = 19;
  var_0.seatids["pilot"] = 0;
  var_0.seatids["gunner"] = 1;
  var_0.ref_12DA2[0] = 0;
  var_0.ref_12DA2[1] = 1;
  var_0.ref_12DA3["pilot"]["tur_gun_fd_mp_seeking"] = 0;
  var_0.ref_12DA3["pilot"]["tur_gun_fd_mp_seeking"] = 1;
  var_0.ref_12DA3["gunner"]["tur_gun_fd_mp_seeking"] = 0;
  var_0.ref_12DA3["gunner"]["tur_gun_fd_mp_seeking"] = 1;
}

function bot_has_streak_in_crate() {
  level.br_pe_chopper_crates = getdvarfloat("scr_fd_health_override", 1500);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("veh_a10fd", level.br_pe_chopper_crates, undefined, undefined, undefined, level.phcountdowntimer);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("veh_a10fd");
  var_0.class = "heavy";
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("veh_a10fd", "light");
  var_1.ref_12024 = &bot_loadout_choose_from_custom_default_class;
  var_1.ref_1202D = &bot_modify_behavior_from_loadout;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("veh_a10fd", "medium");
  var_1.ref_12024 = &bot_loadout_team;
  var_1.ref_1202D = &bot_modify_behavior_from_tweakables;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("veh_a10fd", "heavy");
  var_1.ref_12024 = &bot_loadout;
  var_1.ref_1202D = &bot_match_rules_invalidate_loadout;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("veh_a10fd");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("veh_a10fd", 10);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("veh_a10fd", &bot_nags);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("veh_a10fd", &bot_get_active_tactical_goals_of_type);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("tur_gun_fd_mp_seeking", 5);
}

function bot_has_player_enemy() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("veh_a10fd", 1);
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

function bot_hp_allow_predictive_capping() {
  level._effect["aircraft_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_dauntless_death_exp.vfx");
  level._effect["aircraft_explode_grd"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_dauntless_death_exp_ground.vfx");
}

#using_animtree("");

function bot_gun_pick_personality_from_weapon() {
  level.scr_anim["aircraft"]["spin_up"] = % sdr_mp_veh_dalpha_propeller_spin_up;
  level.scr_anim["aircraft"]["spin_down"] = $sdr_mp_veh_dalpha_propeller_spin_down;
}

function bot_give_weapon() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_a10fd");
  var_1 = var_0.ref_13E92;
  return var_1;
}

function bot_gametype_set_role(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_air_dalpha_wz";
  var_0.targetname = "veh_a10fd";

  if(!isDefined(var_0.vehicletype)) {
    var_0.vehicletype = "a10_warthog_fd";
  }

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = bot_give_weapon();
  var_4 = bot_get_teammates_capturing_zone();
  var_5 = bot_gametype_zones_precached(var_2, var_3, "veh_s4_mil_air_dalpha_wz_turret_attach", var_4.tag, var_4.tagoffset);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_5, getcompleteweaponname(var_3));
  var_2.ref_13E92 = var_3;

  if(level.pistolweapon) {
    var_5 setentityowner(var_2);
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "veh_a10fd", var_0);
  var_2.objweapon = getcompleteweaponname("tur_gun_fd_mp_seeking");
  var_2.shouldmodeplayfinalmoments = 0;
  var_2.ref_120B4 = level.pilot_anim_loop;
  var_2.ref_13E83 = "tag_flash";
  thread botisonplayerteam();
  thread botloadoutfavoritecamosecondary();
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_a10fd", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_a10fd", "create")]](var_2);
  }

  if(getdvarfloat("scr_br_fd_spawnProtectionTimer", 0) > 0) {
    var_2.ref_13A32 = gettime() + getdvarfloat("scr_br_fd_spawnProtectionTimer", 0) * 1000;
  }

  thread helis_assault3_hangar_check_size();
  thread br_tacmap_icon();

  if(level.pickedpball) {
    var_2 unmarkkeyframedmover(1);
  }

  return var_2;
}

function helis_assault3_hangar_check_size() {
  var_0 = self;
  var_0 endon("death");
  var_0 vehphys_enablecollisioncallback(1);

  if(getdvarint("scr_br_fd_invincible", 0)) {
    return;
  }

  wait 5;
  var_1 = [];

  for(var_2 = [];; var_2 = min(var_25 * level.fd_damagedebouncethresholdpct, var_0.maxhealth)) {
    var_0 waittill("collision", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_10) && isDefined(var_10.helperdronetype) && var_10.helperdronetype == "radar_drone_recon") {
      continue;
    }

    if(istrue(level.phfrozen) && !istrue(var_0.shouldmodeplayfinalmoments)) {
      continue;
    }

    var_12 = 0;

    if(istrue(level.pickrandomspawn)) {
      var_12 = isDefined(var_10) && var_10 == var_0;
    }

    if(isDefined(var_10.model) && !var_12) {
      if(var_10 _calloutmarkerping_handleluinotify_mappingdeletemarker::unset_bullet_shields()) {
        var_10 _calloutmarkerping_handleluinotify_mappingdeletemarker::createteamdefenderflagbase();

        if(isDefined(var_0)) {
          bot_should_cap_next_zone(var_0, 9000, var_10, var_7);
        }

        continue;
      }

      if(istrue(var_0.shouldmodeplayfinalmoments) && (unreachable_function(var_10) || var_10 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr())) {
        if(isDefined(var_10.owner) && isDefined(var_0.owner) && var_10.owner.team != var_0.owner.team) {
          var_13 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

          foreach(var_15 in var_13) {
            var_15 dodamage(20, var_0.origin, var_10.owner, var_15, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking");
          }

          var_17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_10);

          foreach(var_15 in var_17) {
            var_15 dodamage(20, var_0.origin, var_0.owner, var_15, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking");
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

    var_20 = 1;
    var_21 = 0;
    var_22 = 0;

    switch (var_11) {
      case 0:
        var_20 = level.phone_group_spawned;
        break;
      case 1:
        var_20 = level.phonehint;
        var_21 = 1;
        break;
      case 2:
        var_22 = 1;
        break;
      default:
        break;
    }

    if(var_21) {
      var_23 = var_20;
    } else {
      var_23 = var_9 * var_20;
    }

    if(istrue(level.phase_four_combat)) {
      var_24 = length(var_0 vehicle_getvelocity() - var_0.br_toggle_armor_allows);
      var_23 *= var_24 / 17.6;
    }

    if(abs(angleclamp180(var_0.angles[0]) > level.phoneisringing)) {
      var_23 *= level.phoneisnotringing;
    }

    if(abs(var_0.angles[2]) > level.phoneplayring) {
      var_23 *= level.phonemorsesinglescriptableused;
    }

    if(var_0.angles[2] > 90 || var_0.angles[2] < -90) {
      var_23 *= level.phonesfx;
    }

    var_25 = 0;

    if(var_23 > level.pickup_sound_playerwm_handler) {
      var_25 = var_0.maxhealth;
    } else if(var_23 > level.pickup_sound_playervm_handler) {
      var_26 = level.pickup_sound_playerwm_handler - level.pickup_sound_playervm_handler;
      var_27 = (var_23 - level.pickup_sound_playervm_handler) / var_26;
      var_28 = var_0.maxhealth * level.pickup_saw_and_start_mission;
      var_29 = var_0.maxhealth * level.pickup_gasmask;
      var_25 = scripts\engine\math::lerp(var_28, var_29, var_27);
    } else if(var_23 > level.pickup_sound_hvt_handler) {
      var_25 = var_0.maxhealth * level.pickrandomvehiclespawn;
    }

    var_30 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_0);

    if(!isDefined(var_30)) {
      var_25 *= level.phone;
    }

    var_31 = -1;

    if(var_11 != 1) {
      var_31 = abs(vectordot(var_8, vectorNormalize(var_0.br_toggle_armor_allows)));
      var_32 = 1;

      if(var_22 && var_9 < level.fd_minspeedfactoryfordotvelocity) {
        var_32 = 0;
      }

      if(var_32) {
        if(var_31 > level.pick_from_preset_solutions) {
          var_25 += var_0.maxhealth * 0.25 + randomintrange(50, 100);
        } else if(var_31 > level.pick_up_data) {
          var_25 *= level.pit_locations;
        }
      }
    } else {
      var_25 += 550;
    }

    if(isDefined(var_1[var_11]) && var_1[var_11] > gettime()) {
      if(var_25 < var_2[var_11]) {
        continue;
      }
    }

    if(var_22 && var_25 > 0) {
      if(level.fd_ignorelandinggeardamage) {
        continue;
      }

      if(level.fd_reducelandinggeardamage && var_31 <= level.fd_dotvelocitygroundlandinggear) {
        continue;
      }
    }

    if(var_25 > 0) {
      bot_should_cap_next_zone(var_0, var_25, var_10, var_7);
      var_1 = gettime() + level.fd_damagedebouncetimems;
    }
  }
}

function br_tacmap_icon() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0.br_toggle_armor_allows = 0;

  for(;;) {
    waittillframeend();
    var_0.br_toggle_armor_allows = var_0 vehicle_getvelocity();
    waitframe();
  }
}

function bot_should_cap_next_zone(var_0, var_1, var_2) {
  var_3 = self;

  if(var_0 > 650) {
    br_pickupdenyweaponpickupap(var_3, "screenshake_fd_coll_damage", "rumble_fd_coll_damage");
  }

  var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);

  if(var_3.health - var_0 <= 0) {
    if(!istrue(var_3.should_play_player_infil) && (var_1.classname == "worldspawn" || var_1 == var_3)) {
      br_mapboundsfull();
    } else {
      var_3 dodamage(var_0, var_2, undefined, undefined, "MOD_CRUSH");
      var_3 radiusdamage(var_3.origin, 250, 200, 80, var_3, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking");
      var_3.brlootchoppercrateactivatecallback = 1;
      var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
      return;
    }
  }

  var_3 dodamage(var_0, var_2, undefined, undefined, "MOD_CRUSH");
  var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
}

function br_mapboundsfull() {
  var_0 = self;
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  foreach(var_3 in var_1) {
    var_3.donotmodifydamage = 1;
    var_3 dodamage(99, var_0.origin, var_3, var_3, "MOD_RIFLE_BULLET", "tur_gun_fd_mp_seeking");
    var_3.donotmodifydamage = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);

  foreach(var_6 in var_1) {
    var_6.plotarmor = 1;
  }

  var_0 radiusdamage(var_0.origin, 250, 200, 80, var_0, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking");
  var_0.brlootchoppercrateactivatecallback = 1;

  foreach(var_6 in var_1) {
    var_6.plotarmor = 0;
  }
}

function bot_get_teammates_capturing_zone() {
  var_0 = spawnStruct();

  if(getdvarint("aircraft_turret_tag_animate", 0) == 1) {
    var_0.tag = "tag_body_animate";
    var_0.tagoffset = (58.87, 0, 60.052);
  } else {
    var_0.tag = "tag_turret";
    var_0.tagoffset = (0, 0, 0);
  }

  return var_0;
}

function bot_gametype_zones_precached(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("misc_turret", var_0 gettagorigin(var_3), var_1, 0);
  var_5 unmarkkeyframedmover(1);
  var_5 linkTo(var_0, var_3, var_4, (-1, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("manual_target");
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

function bot_get_stored_custom_classes(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "tur_gun_fd_mp_seeking";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(isDefined(self.owner)) {
    self.owner.br_pe_chopper_damage_time = var_0.meansofdeath;
  }

  self notify("predeath");

  if(istrue(level.pickup_timeout)) {
    wait 0.2;
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  self setscriptablepartstate("fx", "base");
  self setscriptablepartstate("cloud_contrail", "base");
  self setscriptablepartstate("fast_contrail", "base");
  self setscriptablepartstate("engine_smoke", "base", 0);

  if(isDefined(self.isballisticspecial)) {
    foreach(var_3 in self.isballisticspecial) {
      self setscriptablepartstate(var_3, "off");
    }
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread bot_get_angles_to_goal();
  var_5 = self gettagorigin("tag_origin");

  if(!istrue(self.brlootchoppercrateactivatecallback)) {
    self radiusdamage(self.origin, 250, 200, 80, self, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking");
  }

  var_6 = scripts\engine\utility::ter_op(self.shouldmodeplayfinalmoments, "aircraft_explode", "aircraft_explode_grd");
  playFX(scripts\engine\utility::getfx(var_6), var_5, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_5, "car_explode");
  earthquake(0.4, 800, var_5, 0.7);
  playrumbleonposition("grenade_rumble", var_5);
  physicsexplosionsphere(var_5, 500, 200, 1);
}

function botloadoutfavoritecamosecondary() {
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
        var_0 setscriptablepartstate("landing_gear", "closing", 0);
        var_1 = 0;
      } else if(!var_1 && var_5["hittype"] != "hittype_none") {
        var_0 setscriptablepartstate("landing_gear", "opening", 0);
        var_1 = 1;
      }
    }

    wait 0.3;
  }
}

function botisonplayerteam() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0.br_alt_mode_inflation = 0;
  var_0.should_play_player_infil = 0;
  var_1 = [var_0];

  for(;;) {
    if(!isplane(var_0)) {
      notaplaneerror(var_0);
      return;
    }

    var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_0.origin - (0, 0, 150), var_1, var_2, 0);

    if(isDefined(var_3)) {
      if(var_3["hittype"] == "hittype_none") {
        var_0.shouldmodeplayfinalmoments = 1;
        var_0.should_play_player_infil = 1;
        var_0 setscriptablepartstate("single", "vehicle_use_in_air");
      } else if(istrue(var_0.shouldmodeplayfinalmoments)) {
        br_pickupdenyweaponpickupap(var_0, "screenshake_fd_land", "rumble_fd_land");
        var_0.shouldmodeplayfinalmoments = 0;
        var_0 setscriptablepartstate("single", "vehicle_use");
      }

      if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
        var_0 dodamage(10000, var_0.origin, undefined, undefined);
      }
    }

    var_4 = register_sequence_4_objectives(var_0);

    if(var_0.br_alt_mode_inflation != var_4 && isDefined(var_0.owner)) {
      var_0.br_alt_mode_inflation = var_4;
      bots_with_player_enemy(var_0.owner, 1);
    }

    wait 0.2;
  }
}

function bot_get_angles_to_goal() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_a10fd", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_a10fd", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function bot_nags(var_0) {
  if(isDefined(var_0.damage) && var_0.damage > 0) {
    self notify("damage_taken", var_0);
  }

  return true;
}

function bot_get_active_tactical_goals_of_type(var_0) {
  thread bot_get_stored_custom_classes(var_0);
  return true;
}

function bot_on_player_death() {
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
  wait getanimlength(level.scr_anim["aircraft"]["spin_up"]);

  if(!isDefined(var_0)) {
    return;
  }

  var_0 setscriptablepartstate("propeller", "idle", 0);
}

function bot_next_difficulty_type_index() {
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
  wait getanimlength(level.scr_anim["aircraft"]["spin_down"]);

  if(!isDefined(var_0)) {
    return;
  }

  var_0 setscriptablepartstate("propeller", "idle_no_spin", 0);
}

function bot_get_distance_to_goal(var_0) {
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

function bot_nag(var_0) {
  var_1 = self;

  foreach(var_3 in var_1.isballisticspecial) {
    var_1 setscriptablepartstate(var_3, var_0, 0);
  }
}

function bot_loadout_choose_from_custom_default_class(var_0, var_1) {
  var_2 = self;
  bot_get_distance_to_goal(var_2, 0);
  bot_nag(var_2, "light");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14165(var_0, var_1);
}

function bot_modify_behavior_from_loadout(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416A(var_0, var_1);
}

function bot_loadout_team(var_0, var_1) {
  var_2 = self;
  bot_get_distance_to_goal(var_2, 1);
  bot_nag(var_2, "medium");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14167(var_0, var_1);
}

function bot_modify_behavior_from_tweakables(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416B(var_0, var_1);
}

function bot_loadout(var_0, var_1) {
  var_2 = self;
  bot_get_distance_to_goal(var_2, 1);
  bot_nag(var_2, "heavy");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var_0, var_1);
}

function bot_match_rules_invalidate_loadout(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var_0, var_1);
}

function ref_1327D() {
  level.bot_set_zone_nodes = spawnStruct();
  level.bot_set_zone_nodes.powers = [];
  bhadriotshield(level.bot_set_zone_nodes, "pilotgunner", "+attack", &botstopmovingonlaststand);
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

function botstopmovingonlaststand(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle)) {
    return;
  }

  var_2.vehicle.turret.turreton = 1;
  var_2.vehicle.turret setmode("manual");
  thread bottompercentagetoadjusteconomy();
}

function bottompercentagetoadjusteconomy() {
  var_0 = self;
  var_0 notify("pilotTurretDebounce");
  var_0 endon("pilotTurretDebounce");
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_aircraft");
  var_0.vehicle endon("death");
  var_1 = var_0.vehicle.turret;

  if(isDefined(var_1)) {
    var_1.owner = var_0;
  }

  var_2 = 6;

  for(;;) {
    var_1 shootturret(var_0.vehicle.ref_13E83, var_2, 1);

    if(istrue(var_0.vehicle.binoculars_onstateenterfunc)) {
      var_0.binoculars_onstateexitfunc[1] += 1;
    } else {
      var_0.binoculars_onstateexitfunc[0] += 1;
    }

    if(var_0.vehicle.ref_13E83 == "tag_flash") {
      var_0.vehicle.ref_13E83 = "tag_flash_2";
    } else {
      var_0.vehicle.ref_13E83 = "tag_flash";
    }

    br_pickupdenyweaponpickupap(var_0.vehicle, "screenshake_fd_shoot", "rumble_fd_shoot");
    ref_13FBF(var_0, "ui_fd_target", 1, 12, 11, 0);
    wait level.picking_up_minigun;

    if(!var_0 attackButtonPressed()) {
      ref_13FBF(var_0, "ui_fd_target", 0, 12, 1, 0);
      return;
    }
  }
}

function ref_12636(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("death_or_disconnect");
  var_2 endon("exiting_pilot_seat_aircraft");

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
  var_1 endon("exiting_pilot_seat_aircraft");

  if(isbot(var_1)) {
    return;
  }

  foreach(var_3 in var_0.powers) {
    thread ref_12636(var_1, var_0);
  }
}

function bot_get_low_on_all_ammo(var_0, var_1, var_2, var_3, var_4) {
  if(!isplane(var_0)) {
    notaplaneerror(var_0);
  }

  if(isDefined(level.pindia_headlights) && level.pindia_headlights > 0) {
    var_0.origin += (0, 0, level.pindia_headlights);
  }

  thread bot_gametype_get_num_players_on_team();
  thread bot_on_player_death();

  if(var_1 == "pilot") {
    if(istrue(level.phase_three_combat)) {
      ref_13FBF(var_3, "ui_fd_target", 2047, 0, 11, 1);
      thread checkpoint_release_spawnpoint();
      thread binoculars_istargetinrange();
    }

    if(istrue(level.picked_up_weapon)) {
      init_player_health(var_3);
      thread ref_1315F();
    }

    thread ref_14231(var_3);
    thread ref_12635(var_3);

    if(!istrue(level.phonesringing_singlemorse) && istrue(level.pickclassbr)) {
      thread br_allowloadout();
    }

    thread br_alt_mode_impulse_player();
    thread bot_pick_new_zone();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
}

function br_alt_mode_impulse_player() {
  var_0 = self;
  var_0 endon("exiting_pilot_seat_aircraft");
  level endon("game_ended");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    return;
  }

  var_1 = var_0.vehicle;
  var_1 endon("death");
  var_1.nuke_killplayerwithattacker = 0;

  while(isDefined(var_0) && isDefined(var_0.vehicle)) {
    if(istrue(var_1.shouldmodeplayfinalmoments) && !istrue(var_1.nuke_killplayerwithattacker)) {
      var_2 = var_0 usinggamepad() && var_0 fragButtonPressed();
      var_3 = !var_0 usinggamepad() && var_0 method_87d4();

      if(var_2 || var_3) {
        thread bot_get_flag_carrier();
      }
    }

    wait 0.2;
  }
}

function bot_pick_new_zone() {
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

    br_pickupdenyweaponpickupap(var_1, "screenshake_fd_accell", "rumble_fd_accell");

    while(var_1 vehicle_getspeed() > 60) {
      wait 1.5;
    }

    if(!isplane(var_1)) {
      notaplaneerror(var_1);
      return;
    }
  }
}

function bot_get_flag_carrier() {
  var_0 = self;
  var_0 endon("death");
  var_0 notify("engineSmokeThink");
  var_0 endon("engineSmokeThink");
  var_0.nuke_killplayerwithattacker = 1;
  br_pickupdenyweaponpickupap(var_0, "screenshake_fd_airbrake", "rumble_fd_airbrake");
  var_0 setscriptablepartstate("engine_smoke", "engine_smoke", 1);

  if(soundexists("s4_fd_air_brake")) {
    var_0 playsoundtoplayer("s4_fd_air_brake", var_0.owner);
  }

  var_1 = 1;

  for(var_2 = 1; isDefined(var_0) && isDefined(var_0.owner) && (var_1 || var_2); var_2 = !var_0.owner usinggamepad() && var_0.owner method_87d4()) {
    wait 0.4;
    var_1 = var_0.owner usinggamepad() && var_0.owner fragButtonPressed();
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_0.nuke_killplayerwithattacker = 0;
  var_0 setscriptablepartstate("engine_smoke", "base", 0);
}

function bot_gametype_get_num_players_on_team() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("vehicle_contrails_debug");
  level endon("game_ended");
  var_0.ref_145C9 = 0;
  var_0.helicrash = 0;
  var_0.spawn_fake_letter = 0;

  for(;;) {
    if(istrue(var_0.ref_145C9)) {
      if(var_0 vehicle_getspeed() < level.pickuptrigger) {
        var_0.ref_145C9 = 0;
        var_0 setscriptablepartstate("fx", "base", 0);
      }
    } else if(var_0 vehicle_getspeed() > level.pickuptrigger) {
      var_0.ref_145C9 = 1;
      var_0 setscriptablepartstate("fx", "trails", 0);
    }

    if(istrue(level.ph_checkforovertime)) {
      if(istrue(var_0.helicrash)) {
        if(var_0 vehicle_getspeed() < level.pickup_truck_initomnvars) {
          var_0.helicrash = 0;
          var_0 setscriptablepartstate("cloud_contrail", "base", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.pickup_truck_initomnvars) {
        var_0.helicrash = 1;
        var_0 setscriptablepartstate("cloud_contrail", "cloud_contrail", 0);
      }

      if(istrue(var_0.spawn_fake_letter)) {
        if(var_0 vehicle_getspeed() < level.pickupchecks || abs(var_0.angles[2]) < level.ph_loadouts) {
          var_0.spawn_fake_letter = 0;
          var_0.ref_138A5 = undefined;
          var_0 setscriptablepartstate("fast_contrail", "base", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.pickupchecks && abs(var_0.angles[2]) > level.ph_loadouts) {
        var_0.spawn_fake_letter = 1;
        var_0.ref_138A5 = gettime();
        var_0 setscriptablepartstate("fast_contrail", "fast_contrail", 0);
      }
    }

    if(istrue(var_0.spawn_fake_letter)) {
      if(isDefined(var_0.ref_138A5) && gettime() - var_0.ref_138A5 > 500) {
        var_0 setscriptablepartstate("rumble_turn", "rumble_fd_turn", 0);
        var_0.ref_1443E = 1;
      }
    } else if(istrue(var_0.ref_1443E)) {
      var_0 setscriptablepartstate("rumble_turn", "neutral", 0);
      var_0.ref_1443E = undefined;
    }

    wait 0.3;
  }
}

function register_sequence_4_objectives() {
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

function bot_get_human_picked_class(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    thread bot_get_landing_spot(var_0, var_1, var_2, var_3, var_4);
    return;
  }

  if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "pilot") {
      checkpoint_player_spawns_func(var_3);
      bot_pick_new_loadout_next_spawn(var_3);
      return;
    }

    return;
  }
}

function bot_get_landing_spot(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3.should_hide_buried_mother_corpse)) {
    var_3.should_hide_buried_mother_corpse = 1;
  } else {
    var_3.should_hide_buried_mother_corpse += 1;
  }

  bot_pickup_origin(var_3, var_0, var_1, var_2, var_4);

  if(isDefined(var_3.carriable_set_dropped)) {
    if(isDefined(level.bot_shotguns)) {
      var_3 thread[[level.bot_shotguns]]();
    }
  }

  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "gunner") {
    var_5 = "a10_warthog_fd";
    var_6 = 3;
  }

  if(var_1 == "pilot") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_0.owner = var_3;
    var_3 controlslinkTo(var_0);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13E92);
    var_7.owner = var_3;
    var_3.vehicle.turret = var_7;
    bot_gametype_get_allied_defenders_for_team(var_3);
    bots_with_player_enemy(var_3, 1);
    var_3.binoculars_onstateexitfunc = [0, 0];
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
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

  if(istrue(level.pickprematchrandomloadout) && isDefined(var_3) && var_1 == "pilot") {
    var_3 playerhide();
    return;
  }
}

function bot_get_num_teammates_capturing_zone(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && var_1 == "pilot") {
    thread ref_14230(var_3);
    bot_snipers(var_3);
    var_3 notify("exiting_pilot_seat_aircraft");
    thread bot_next_difficulty_type_index();
    var_3 notify("aircraftHeadIconForceDelete");
    bots_with_player_enemy(var_3, 0);
  }

  if(istrue(var_4.success)) {
    var_3 notify("exiting_seat_aircraft");
    bot_get_player_enemy(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function bot_get_player_enemy(var_0, var_1, var_2, var_3, var_4) {
  bot_protect_hq_zone(var_3, var_0, var_1, var_2, var_4);

  if(var_1 == "pilot") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  var_5 = !isDefined(var_2);

  if(var_1 == "pilot" || var_5 && var_3 hasweapon(var_0.ref_13E92)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13E92);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);

    if(!level.pistolweapon) {
      var_6 setentityowner(undefined);
    }

    bot_pick_new_loadout_next_spawn(var_3);
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

  if(isDefined(level.ref_142D1)) {
    var_3 visionsetnakedforplayer(level.ref_142D1, 0);
  } else {
    var_3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("", 0);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function bot_gametype_get_allied_defenders_for_team(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_a10fd");

  if(istrue(var_1.ref_133D3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ctmgGunnerMissileRedux", 0.4, 0, &bot_go_to_destination);
}

function bot_pick_new_loadout_next_spawn(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_a10fd");

  if(istrue(var_1.ref_133D3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ctmgGunnerMissileRedux", 0);
}

function bot_go_to_destination(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "MOD_PROJECTILE_SPLASH" && var_4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  switch (var_5.basename) {
    case "tur_gun_fd_mp_seeking":
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

function bot_parachute_into_map(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F6(var_4);
  thread bot_pick_dd_zone_with_fewer_defenders(var_0, var_1, var_2, var_3, var_4);
}

function bot_pick_dd_zone_with_fewer_defenders(var_0, var_1, var_2, var_3, var_4) {
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

function bot_is_in_gas() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_a10fd", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &bot_get_tdef_flag;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("veh_a10fd", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function bot_get_tdef_flag() {
  if(isDefined(level.ref_1217D) && level.ref_1217D.size != 0) {
    var_0 = level.ref_1217D;
  } else {
    var_0 = scripts\engine\utility::getStructArray("veh_a10fd", "targetname");
  }

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

function bots_with_player_enemy(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || !isDefined(var_1.vehicle) || isbot(var_1)) {
    return;
  }

  var_2 = var_1.vehicle;

  if(!isDefined(var_2.br_alt_mode_inflation)) {
    return;
  }

  var_3 = bots_seek_player(var_0, var_2.br_alt_mode_inflation);
  var_1 setclientomnvar("ui_br_fd_state", var_3);
}

function bots_seek_player(var_0, var_1) {
  var_2 = 1;
  var_3 = 3;
  var_4 = int(var_0) &var_2;
  var_4 += (int(var_1) &var_3) << 1;
  return var_4;
}

function br_allowloadout() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_aircraft");
  var_1 = -40;
  var_2 = -135;
  var_3 = 40;
  var_4 = -135;
  var_0.botloadoutfavoritecamoprimary = ref_12530(var_0, var_3, var_4, "left", "middle", "center", "bottom", &"MP_WZ_ISLAND/FD_IN_AIR_COUNTER");

  while(!isDefined(var_0.vehicle)) {
    wait 0.5;
  }

  thread br_ammo_update_ammotype_weapons();
}

function bot_snipers() {
  var_0 = self;

  if(isDefined(var_0.botloadoutfavoritecamoprimary)) {
    var_0.botloadoutfavoritecamoprimary destroy();
  }

  var_0.botloadoutfavoritecamoprimary = undefined;
}

function br_ammo_update_ammotype_weapons() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }

  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_aircraft");

  for(;;) {
    if(!isDefined(var_0.vehicle)) {
      return;
    }

    var_1 = 0;

    foreach(var_3 in level.vehicle.instances["veh_a10fd"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments)) {
        var_1++;
      }
    }

    if(isDefined(level.vehicle.instances["veh_bt"])) {
      foreach(var_6 in level.vehicle.instances["veh_bt"]) {
        if(istrue(var_6.shouldmodeplayfinalmoments)) {
          var_1++;
        }
      }
    }

    var_0.botloadoutfavoritecamoprimary setvalue(var_1);
    wait 3;
  }
}

function ref_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = init_player_plane_exit_anims("default", 1);
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

function init_player_plane_exit_anims(var_0, var_1) {
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

function init_player_health() {
  self.br_pelletmaxdamage = spawnStruct();
  self.br_pelletmaxdamage.ref_13A72 = [];
}

function ref_1315F() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("aircraftHeadIconForceDelete");
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
  }

  wait 2;

  while(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(var_0)) {
    var_2 = [];
    var_3 = rooftop_active(level.pilot_setups, level.pilot_model);
    var_4 = var_3[0];
    var_5 = var_3[1];
    var_3 = undefined;

    foreach(var_7 in level.players) {
      if(var_7.team == var_0.team) {
        continue;
      }

      if(isDefined(level.br_pickupdenyalreadyhaveplatepouch)) {
        if(var_7[[level.br_pickupdenyalreadyhaveplatepouch]]()) {
          continue;
        }
      }

      if(isDefined(level.br_movingcirclemovedistmin)) {
        if(var_7[[level.br_movingcirclemovedistmin]]("specialty_guerrilla") || var_7[[level.br_movingcirclemovedistmin]]("specialty_covert_ops")) {
          continue;
        }
      }

      if(isDefined(var_7.vehicle) && isDefined(var_7.vehicle.targetname) && (var_7.vehicle.targetname == "veh_bt" || var_7.vehicle.targetname == "veh_a10fd")) {
        if(ref_1331B(var_7.vehicle, var_7)) {
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

    if(isDefined(level.dummy_hint)) {
      foreach(var_14 in level.dummy_hint) {
        if(!isDefined(var_14)) {
          continue;
        }

        var_8 = ref_13D9C(var_14.origin, var_0.vehicle.origin, var_4, var_5);

        if(istrue(var_8)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_14);
        }
      }
    }

    if(var_2.size > 0) {
      var_16 = level.teamdata[var_0.team]["alivePlayers"];

      if(istrue(var_1)) {
        var_16 = level.squaddata[var_0.team][var_0.squadindex].players;
      }

      foreach(var_18 in var_16) {
        if(!isalive(var_18)) {
          continue;
        }

        if(isDefined(level.br_pickupdenyalreadyhaveplatepouch)) {
          if(var_18[[level.br_pickupdenyalreadyhaveplatepouch]]()) {
            continue;
          }
        }

        var_19 = distance(var_0.vehicle.origin, var_18.origin);

        if(var_19 < 10000) {
          foreach(var_21 in var_2) {
            thread br_plunder_site_use_states(var_18, var_21);
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

function rooftop_active(var_0, var_1) {
  var_2 = self;
  var_2 notify("get_sonar_cone_scan_vertices");
  var_2 endon("get_sonar_cone_scan_vertices");
  var_3 = var_2.vehicle.origin;
  var_4 = anglesToForward(var_2.vehicle.angles);
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = vectorcross(var_4, (0, 0, 1));
  var_6 = var_4 * var_0 * cos(var_1);
  var_7 = var_0 * sin(var_1);
  var_8 = [];
  var_9 = (0, 0, 0);
  var_10 = undefined;
  var_11 = undefined;

  for(var_12 = 0; var_12 < 2; var_12++) {
    var_13 = var_12 / 2 * 360;
    var_14 = var_3 + var_6 + var_7 * var_5 * cos(var_13);
    var_9 = var_14;

    if(isDefined(var_11)) {
      var_10 = var_14;
      continue;
    }

    var_11 = var_14;
  }

  return [var_10, var_11];
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

function ref_1331B(var_0) {
  var_1 = self;
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_1);

  if(isDefined(var_2)) {
    if(var_2 == var_0) {
      return true;
    }
  } else {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);

    foreach(var_5 in var_3) {
      if(var_5 == var_0) {
        return true;
      }

      break;
    }
  }

  return false;
}

function br_plunder_site_use_states(var_0, var_1) {
  var_2 = self;
  var_3 = undefined;

  if(isDefined(var_0.type) && var_0.type == "br_loot_cache_lege") {
    var_4 = "hud_icon_ground_marked_obj_leg";
    var_3 = var_0.origin;
  } else if(updatedroprelicsfunc(var_1) || var_1 _calloutmarkerping_handleluinotify_mappingdeletemarker::updateexpiredlootleader()) {
    var_4 = "hud_icon_air_marked";
  } else {
    var_4 = "hud_icon_ground_marked";
  }

  var_5 = 8;
  var_6 = 1;
  var_7 = 500;
  var_8 = 31500;
  var_9 = var_2 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_4, var_4, var_5, var_6, var_8, var_7, undefined, 1, 1, var_4);
  br_prematchspawnlocations(var_4, var_2);
  scriptedspawnpointarray(var_4, var_2, var_3);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_9);
}

function scriptedspawnpointarray(var_0, var_1) {
  var_2 = self;

  if(!isDefined(level.br_movingcirclegulagcloseoffset)) {
    return;
  }

  if(!isDefined(var_2) || !isDefined(var_0) || !isDefined(var_1) || !isDefined(var_0.lastkilledby) || !isDefined(var_0.lastkilledby.team)) {
    return;
  }

  if(!isent(var_0) || !isPlayer(var_0)) {
    return;
  }

  if(var_0.health != 0) {
    return;
  }

  if(var_2 != var_1) {
    return;
  }

  if(var_2 == var_1 && var_0.lastkilledby.team == var_1.team && var_0.lastkilledby != var_1) {
    var_1 thread[[level.br_movingcirclegulagcloseoffset]]("br_fd_mark_assist");
    return;
  }
}

function br_prematchspawnlocations(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("aircraftHeadIconForceDelete");
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death_or_disconnect", 3);
}

function updatedroprelicsfunc() {
  var_0 = self;

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.targetname) && var_0.vehicle.targetname == "veh_a10fd") {
    return true;
  }

  return false;
}

function unreachable_function() {
  var_0 = self;

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_0.targetname) && var_0.targetname == "veh_a10fd") {
    return true;
  }

  return false;
}

function unrescuable_fail() {
  var_0 = self;

  if(isDefined(var_0.classname) && var_0.classname == "misc_turret" && isDefined(var_0.model) && var_0.model == "veh_s4_mil_air_dalpha_wz_turret_attach") {
    return true;
  }

  return false;
}

function checkpoint_release_spawnpoint() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("exiting_pilot_seat_aircraft");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    ref_13FBF(var_0, "ui_fd_target", 2047, 0, 11, 1);
    return;
  }

  var_0.br_standard_loadout = spawnStruct();
  var_1 = var_0.vehicle.turret;

  while(isDefined(var_0.vehicle)) {
    var_0.br_standard_loadout.checkpoint_set = [];

    if(istrue(level.phase_zero_combat)) {
      if(!istrue(var_0.vehicle.binoculars_onstateenterfunc)) {
        ref_13FBF(var_0, "ui_fd_target", 2047, 0, 11, 0);
        wait level.phclass;
        continue;
      }
    }

    if(istrue(level.phase_three_combat) && isDefined(var_0.vehicle.turret)) {
      var_2 = var_0.vehicle.turret method_87cf("tag_flash");

      if(checkpoint_trigger(var_2)) {
        var_0.br_standard_loadout.checkpoint_set[0] = var_2;
      }
    }

    checkpoint_register(var_0);
    wait level.phclass;

    if(isDefined(var_0.br_standard_loadout) && isDefined(var_0.br_standard_loadout.target) && !isalive(var_0.br_standard_loadout.target)) {
      var_0.br_standard_loadout.target = undefined;
      checkpoint_register(var_0);
      ref_13FBF(var_0, "ui_fd_target", 2047, 0, 11, 1);
    }
  }
}

function checkpoint_trigger(var_0) {
  var_1 = self;
  var_2 = isDefined(var_0);

  if(var_2) {
    var_3 = isDefined(var_0.owner);
    var_4 = var_3 && isDefined(var_0.owner.team) && var_0.owner.team != "neutral";
    var_5 = var_3 && isDefined(var_0.owner.vehicle) && var_0.owner.vehicle == var_0;
    var_6 = var_5 && var_4 && var_0.owner.team != var_1.team;
    var_7 = isDefined(var_0.team) && var_0.team != "neutral";
    var_8 = undefined;
    var_9 = isPlayer(var_0) && var_0 isskydiving() && istrue(level.pilot_linkto_origin_offset);
    var_10 = isPlayer(var_0) && istrue(var_0.ref_125CD);
    var_11 = isDefined(var_0.agent_type) && (var_0.agent_type == "actor_kenosha" || var_0.agent_type == "actor_greenbay");

    if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(var_6) {
        return true;
      }
    } else if(var_7 && !var_11) {
      var_8 = var_0.team != var_1.team;

      if(var_8 && !var_9 && !var_10) {
        return true;
      }
    }
  }

  return false;
}

function checkpoints_init(var_0) {
  return (var_0 gettagorigin("tag_flash") + var_0 gettagorigin("tag_flash_2")) / 2;
}

function checkpoints_count(var_0) {
  return var_0 gettagangles("tag_flash");
}

function ref_127DF(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]);
}

function checkpoint_player_spawns_func() {
  var_0 = self;
  ref_13FBF(var_0, "ui_fd_target", 2047, 0, 11, 1);
  var_0.br_standard_loadout = undefined;
}

function checkpoint_register() {
  var_0 = self;
  var_1 = var_0.br_standard_loadout.checkpoint_set;

  if(!isDefined(var_1) || var_1.size <= 0) {
    var_0.br_standard_loadout.target = undefined;
    ref_13FBF(var_0, "ui_fd_target", 2047, 0, 11, 1);
    return;
  }

  var_2 = checkpoints_init(var_0.vehicle.turret);
  var_3 = anglesToForward(var_0.vehicle.angles);
  var_4 = var_3 * level.phaseindex * cos(level.phase_two_combat);
  var_5 = var_2 + var_4;
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_1) {
    var_10 = ref_127DF(var_9.origin, var_2, var_5);

    if(!isDefined(var_7) || var_10 < var_7) {
      var_7 = var_10;
      var_6 = var_9;
    }
  }

  if(isDefined(var_0.br_standard_loadout.target) && var_6 == var_0.br_standard_loadout.target) {
    ref_13FBF(var_0, "ui_fd_target", var_6 getentitynumber(), 0, 11, 0);
    return;
  }

  var_0.br_standard_loadout.target = var_6;
  ref_13FBF(var_0, "ui_fd_target", var_6 getentitynumber(), 0, 11, 1);

  if(soundexists("s4_fd_target_locked")) {
    var_0 playsoundtoplayer("s4_fd_target_locked", var_0);
  }

  if(isDefined(var_6.vehicle)) {
    ref_13FBF(var_0, "ui_fd_target", 1, 11, 1, 0);
    return;
  }

  ref_13FBF(var_0, "ui_fd_target", 0, 11, 1, 0);
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

function binoculars_istargetinrange() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");

  if(isbot(var_0)) {
    return;
  }

  while(!isDefined(var_0.vehicle)) {
    waitframe();
  }

  if(!isDefined(var_0.vehicle)) {
    return;
  }

  var_0.vehicle endon("death");
  var_0 endon("exiting_seat_aircraft");
  var_0.vehicle.binoculars_onstateenterfunc = 0;
  var_1 = 0;

  while(isDefined(var_0.vehicle)) {
    while(var_1 == var_0 adsButtonPressed()) {
      waitframe();
    }

    var_1 = var_0 adsButtonPressed();

    if(var_1) {
      var_0.vehicle.binoculars_onstateenterfunc = 1;
      var_0 setclientomnvar("ui_airplane_ads_active", 1);
      continue;
    }

    var_0.vehicle.binoculars_onstateenterfunc = 0;
    var_0 setclientomnvar("ui_airplane_ads_active", 0);
  }
}

function loadout_finalizeweapons(var_0) {
  if(!isDefined(self.loadout_fixcopiedclassstruct)) {
    self.loadout_fixcopiedclassstruct = 1;
    self method_87d0(0);
    ref_13FEC(var_0, 1);
    return;
  }

  var_1 = ref_13FEC(var_0, 1);

  if(var_1) {
    self.loadout_fixcopiedclassstruct++;
    return;
  }
}

function move_structs(var_0) {
  if(isDefined(self.loadout_fixcopiedclassstruct)) {
    var_1 = ref_13FEC(var_0, 0);

    if(var_1) {
      self.loadout_fixcopiedclassstruct--;
    }

    if(!self.loadout_fixcopiedclassstruct) {
      self method_87d0(1);
      self.loadout_fixcopiedclassstruct = undefined;
      return;
    }

    return;
  }
}

function ref_13FEC(var_0, var_1) {
  if(!isDefined(self.loadout_getglobalclassstruct)) {
    self.loadout_getglobalclassstruct = [0, 0, 0, 0, 0];
  }

  var_2 = undefined;

  switch (var_0) {
    case "vehicle":
      var_2 = 0;
      break;
    case "gulag":
      var_2 = 1;
      break;
    case "laststand":
      var_2 = 2;
      break;
    case "skydive":
      var_2 = 3;
      break;
    case "aa_turret":
      var_2 = 4;
      break;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(var_1) {
    if(istrue(self.loadout_getglobalclassstruct[var_2])) {
      return 0;
    }

    self.loadout_getglobalclassstruct[var_2] = 1;
    return 1;
  }

  if(istrue(self.loadout_getglobalclassstruct[var_2])) {
    self.loadout_getglobalclassstruct[var_2] = 0;
    return 1;
  }

  return 0;
}

function br_pickupdenyweaponpickupap(var_0, var_1) {
  var_2 = self;

  if(!isplane(var_2)) {
    notaplaneerror(var_2);
    return;
  }

  var_2 setscriptablepartstate("screenshake", var_0, 0);
  var_2 setscriptablepartstate("rumble", var_1, 0);
}

function isplane(var_0) {
  return unreachable_function(var_0) && var_0.model == "veh_s4_mil_air_dalpha_wz" && var_0.vehiclename == "veh_a10fd";
}

function notaplaneerror(var_0, var_1) {
  var_2 = "Vehicle is not a plane: vehicleName = " + var_1.vehiclename + ", model = " + var_1.model;
  var_3 = var_2 == undefined;
}

function bot_pickup_origin(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4)) {
    return;
  }

  var_4.br_pickupdenyalreadyhavequest = gettime();
  bot_set_difficultysetting(var_4, var_0, var_1);
  var_5 = [];
  var_6 = respawntags(var_0);
  var_5 = "plane_type";
  var_5 = var_6;
  var_7 = retreat_vehicle_collision_clear(var_4, var_2);
  var_5 = "player_type_enter";
  var_5 = var_7;

  if(var_7 == "enter_vehicle") {
    var_8 = restartcircleelimination(var_4);
    var_5 = "entering_vehicle_status";
    var_5 = var_8;
    var_9 = register_trap_room_objectives(var_4);
    var_5 = "airplane_map_location";
    var_5 = var_9;
    var_10 = register_valid_gametypes_for_create_script(var_4);
    var_5 = "num_airplanes_in_air";
    var_5 = var_10;
    var_11 = restock_dialoguesectionalogic(var_4);
    var_5 = "player_input_type";
    var_5 = var_11;
  } else {
    var_5 = "entering_vehicle_status";
    var_5 = "";
    var_5 = "airplane_map_location";
    var_5 = "";
    var_5 = "num_airplanes_in_air";
    var_5 = 0;
    var_5 = "player_input_type";
    var_5 = "";
  }

  var_4 dlog_recordplayerevent("dlog_event_plane_player_enter", var_5);
}

function bot_protect_hq_zone(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4)) {
    return;
  }

  var_5 = [];
  var_6 = respawntags(var_0);
  var_5 = "plane_type";
  var_5 = var_6;
  var_7 = retreatanddie(var_4, var_2);
  var_5 = "player_type_exit";
  var_5 = var_7;

  if(var_7 == "exit_vehicle") {
    var_8 = restartwrapper(var_4, var_3);
    var_5 = "exit_vehicle_cause";
    var_5 = var_8;
    var_9 = respawntimedisable(var_4);
    var_5 = "airplane_play_session";
    var_5 = var_9;

    if(var_8 == "death") {
      var_10 = register_techo_seat_data(var_0);
      var_5 = "airplane_majority_dmg_type";
      var_5 = var_10;
      var_11 = register_subway_track(var_4);
      var_5 = "airplane_cause_death";
      var_5 = var_11;
      var_12 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0).size + 1;
      var_5 = "num_airplane_occupants";
      var_5 = var_12;
      var_13 = register_trap_room_objectives(var_4);
      var_5 = "airplane_exit_map_location";
      var_5 = var_13;
    } else {
      var_5 = "airplane_majority_dmg_type";
      var_5 = "";
      var_5 = "airplane_cause_death";
      var_5 = "";
      var_5 = "num_airplane_occupants";
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0).size + 1;
      var_5 = "airplane_exit_map_location";
      var_5 = "";
    }
  } else {
    var_5 = "exit_vehicle_cause";
    var_5 = "";
    var_5 = "airplane_play_session";
    var_5 = 0;
    var_5 = "airplane_majority_dmg_type";
    var_5 = "";
    var_5 = "airplane_cause_death";
    var_5 = "";
    var_5 = "num_airplane_occupants";
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0).size + 1;
    var_5 = "airplane_exit_map_location";
    var_5 = "";
  }

  var_4 dlog_recordplayerevent("dlog_event_plane_player_exit", var_5);

  if(isDefined(var_4.br_pe_chopper_damage_time)) {
    var_4.br_pe_chopper_damage_time = undefined;
  }

  if(isDefined(var_4.br_onvehicledeath)) {
    var_4.br_onvehicledeath = undefined;
  }

  bot_set_difficultysetting(var_4, var_0, var_1);

  if(isDefined(var_4.binoculars_onstateexitfunc) && unreachable_function(var_0)) {
    if(isDefined(var_4.binoculars_onstateexitfunc[0]) && isDefined(var_4.binoculars_onstateexitfunc[1]) && var_4.binoculars_onstateexitfunc[1] > 0) {
      var_4 dlog_recordplayerevent("dlog_event_plane_dauntless_ads_usage", ["ads_bullets", var_4.binoculars_onstateexitfunc[0], "auto_target_bullets", var_4.binoculars_onstateexitfunc[1]]);
    }

    var_4.binoculars_onstateexitfunc = undefined;
    return;
  }
}

function restartcircleelimination() {
  var_0 = self;

  if(!isDefined(var_0.should_hide_buried_mother_corpse)) {
    return "";
  }

  if(var_0.should_hide_buried_mother_corpse < 0) {
    return "first_time_entering";
  }

  if(var_0.should_hide_buried_mother_corpse == 0) {
    return "re_entering_new_life";
  }

  return "re_entering_same_life";
}

function respawntags() {
  var_0 = self;

  if(unreachable_function(var_0)) {
    return 1;
  }

  if(var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return 2;
  }

  if(var_0 _calloutmarkerping_onpingchallenge::unset_force_aitype_riotshield()) {
    return 3;
  }

  return 0;
}

function retreat_vehicle_collision_clear(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    return "seat_swapping";
  }

  return "enter_vehicle";
}

function register_trap_room_objectives() {
  var_0 = self;

  if(!isDefined(var_0.calloutarea)) {
    return "";
  }

  return var_0.calloutarea;
}

function register_valid_gametypes_for_create_script() {
  var_0 = self;
  var_1 = 0;

  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return var_1;
  }

  if(isDefined(level.vehicle.instances["veh_a10fd"])) {
    foreach(var_3 in level.vehicle.instances["veh_a10fd"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments)) {
        var_1++;
      }
    }
  }

  if(isDefined(level.vehicle.instances["veh_bt"])) {
    foreach(var_6 in level.vehicle.instances["veh_bt"]) {
      if(istrue(var_6.shouldmodeplayfinalmoments)) {
        var_1++;
      }
    }
  }

  return var_1;
}

function restock_dialoguesectionalogic() {
  var_0 = self;

  if(var_0 usinggamepad()) {
    return "controller";
  }

  return "kbm";
}

function retreatanddie(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    return "seat_swapping";
  }

  return "exit_vehicle";
}

function restartwrapper(var_0) {
  var_1 = self;

  if(!isDefined(var_0.onprematchfadedone2)) {
    return "";
  }

  return tolower(var_0.onprematchfadedone2);
}

function respawntimedisable() {
  var_0 = self;

  if(!isDefined(var_0.br_pickupdenyalreadyhavequest)) {
    return 0;
  }

  var_1 = int((gettime() - var_0.br_pickupdenyalreadyhavequest) / 1000);
  return var_1;
}

function register_techo_seat_data() {
  var_0 = self;
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0.waitthensetgendersoundcontext)) {
    var_3 = 1;

    while(var_3 < var_0.waitthensetgendersoundcontext.size) {
      if(var_1 < var_0.waitthensetgendersoundcontext[var_3]) {
        var_1 = var_0.waitthensetgendersoundcontext[var_3];
        var_2 = var_3;
      }

      var_3 += 2;
    }

    var_4 = var_0.waitthensetgendersoundcontext[var_2 - 1];
    return var_4;
  }

  return "";
}

function register_subway_track() {
  var_0 = self;

  if(isDefined(var_0.br_pe_chopper_damage_time)) {
    return var_0.br_pe_chopper_damage_time;
  }

  return "";
}

function bot_set_difficultysetting(var_0, var_1) {
  var_2 = self;
  var_3 = -1;

  if(!isDefined(level.ref_13B94)) {
    level.ref_13B94 = ["bomber_pilot", 0, "bomber_gunner", 0, "dauntless_pilot", 0, "dauntless_passenger", 0];
  }

  switch (var_1) {
    case "pilot":
      if(unreachable_function(var_0)) {
        var_3 = 5;
      } else {
        var_3 = 1;
      }

      break;
    case "gunner":
      var_3 = 7;
      break;
    case "seat_four":
    case "seat_three":
    case "seat_two":
      var_3 = 3;
      break;
    default:
      break;
  }

  if(var_3 < 0 || !isDefined(var_2)) {
    return;
  }

  if(!isDefined(var_2.ref_13B95)) {
    var_2.ref_13B95 = gettime();
    return;
  }

  var_2.ref_13B95 = int((gettime() - var_2.ref_13B95) / 1000);
  level.ref_13B94[var_3] += var_2.ref_13B95;
  var_2.ref_13B95 = undefined;
  getentitylessscriptablearray("dlog_event_plane_time_spent_per_seat", level.ref_13B94);
}