/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zod\cp_zod.gsc
*************************************************/

main() {
  setDvar("#x370dffb74f8ebd2f2", 0);
  setDvar("#x3c51757bb6571dfe4", 1.25);

  if(getdvarint("#x3553d15a56298db4", 0)) {
    setDvar("#x3ed73a37ce046aa3a", 1);
  }

  _id_C2B0();
  level.hubdestination = "cp_zod_red_star_tr";
  scripts\cp\cp_destinations::load_destination(level.hubdestination);
  scripts\cp\maps\cp_zod\cp_zod_precache::main();
  scripts\cp\maps\cp_zod\gen\cp_zod_art::main();
  scripts\cp\maps\cp_zod\cp_zod_fx::main();
  scripts\cp\maps\cp_zod\cp_zod_lighting::main();
  scripts\cp\maps\cp_zod\cp_zod_hub_spawning::main();
  scripts\cp\zombies\cp_zm_poi_spawning::main();
  hide_dlc_walls();
  remove_dlc_blockers();
  level setup_poi_encounters();

  if(getdvarint("#x364d09974ef4a7017", 0) == 1 || scripts\cp\utility::is_season_live(2)) {
    level setup_elite_spawning_rules();
  }

  level setup_portal_zone_map();
  level setup_portal_location_model_part_state_map();
  level setup_objective_instance_size_array();
  level hide_ltm_props();
  level thread post_launch_clip_fixes();
  level thread watch_for_vlo_open();
  _id_06EE::_id_D88B("compass_map_cp_zod");
  level._id_9F28 = 1;

  if(level._id_3FD9) {
    return;
  }
  level._id_10D15 = "scripts/cp/maps/cp_zod/cp_zod_weaponrank_event.csv";
  level._id_DACA = ::_id_DAC9;
  level._id_81B2 = ["front_gate"];
  level._id_459D = "s4_ar_stango44_mp";
  _id_076F::_id_8172();
  scripts\engine\utility::_id_5C11("introscreen_over");
  level thread _id_1073C();
  level thread _id_070A::_id_9A65();
  level thread _id_09A4::_id_53E6();
  level._id_10D0 = [];
  level._id_4258 = ::onplayerspawned;
  level.pap_model_animated = 1;

  if(getdvarint("#x3553d15a56298db4", 0) == 1) {
    level._id_AE0B = "mtl_s4_camo_pap_a_zm";
    level._id_AE0C = "mtl_s4_camo_pap_b_zm";
    level._id_AE0D = "mtl_s4_camo_pap_c_zm";
  }
}

play_page_vfx() {
  level._effect["office_locked_fx"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_office_locked");
  level scripts\engine\utility::_id_5C24("introscreen_over");

  if(!getdvarint("#x3553d15a56298db4", 0)) {
    return;
  }
  var_0 = scripts\engine\utility::getstruct("page_fx_pos", "targetname");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  var_1 endon("death");
  waitframe();
  playFXOnTag(level._effect["office_locked_fx"], var_1, "tag_origin");
}

_id_C2B0() {
  _id_07F7::_id_7EB6("mp/iw8_default_agent_definition.csv");
}

setup_objective_instance_size_array() {
  level.small_objective_instance_names = ["objective_red_star_apartment_small_first_floor_holdout", "objective_sumpf_flogger_holdout", "objective_tonga_barn_holdout", "objective_apartment_bottom_assault"];
  level.large_objective_instance_names = ["objective_royal_hotel_clocktower_holdout", "objective_royal_hotel_clock_holdout", "objective_basement_north_orb_follow", "objective_basement_south_orb_follow", "objective_basement_outdoor_assault"];
}

setup_poi_encounters() {
  level.a_poi_encounters = [];
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_easy_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_medium_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_hard_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_easy_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_medium_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_hard_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_easy_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_medium_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_hard_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_easy_10_up");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_medium_10_up");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_hard_10_up");
  level.poi_numbers_csv = "cp/zombies/cp_zod_hub_poi_numbers.csv";
  level.a_active_zones = [];
  level.a_active_zones = scripts\engine\utility::array_add(level.a_active_zones, "zone_fob");
}

setup_elite_spawning_rules() {
  level.s_elite_spawning_rules = scripts\cp\utility::_id_EA7B((0, 0, 0), (0, 0, 0));
  level.s_elite_spawning_rules.first_elite_round = 7;
  level.s_elite_spawning_rules.min_spawns_before_elite = 20;
  level.s_elite_spawning_rules.max_total_elites_to_spawn = 2;
}

setup_portal_zone_map() {
  level.a_portal_zone_map = [];
  level.a_portal_zone_map["portal_a"] = "zone_apartments_streets";
  level.a_portal_zone_map["portal_a_1"] = "zone_apartments";
  level.a_portal_zone_map["portal_b"] = "zone_theater";
  level.a_portal_zone_map["portal_c"] = "zone_vloffice_streets";
  level.a_portal_zone_map["portal_c_1"] = "zone_vloffice";
  level.a_portal_zone_map["portal_c_2"] = "zone_basement";
}

setup_portal_location_model_part_state_map() {
  level.a_default_portal_model_state = "hub";
  level.a_portal_model_state_map = [];
  level.a_portal_model_state_map["objectives_location_royal_hotel"] = "hotel";
  level.a_portal_model_state_map["objectives_location_tonga"] = "tonga";
  level.a_portal_model_state_map["objectives_location_sumpf"] = "sumpf";
  level.a_portal_model_state_map["objectives_location_sumpf_first_floor"] = "sumpf";
  level.a_portal_model_state_map["objectives_location_sumpf_second_floor"] = "sumpf";
  level.a_portal_model_state_map["objectives_location_red_star_apartment"] = "apartment";
  level.a_portal_model_state_map["objectives_location_red_star_theater"] = "theater";
  level.a_portal_model_state_map["objectives_location_red_star_basement"] = "basement";
}

hide_ltm_props() {
  if(!istrue(getdvarint("#x32499d9dc5db0430e", 0))) {
    var_0 = getEntArray("h_decor", "targetname");
    var_1 = getEntArray("h_decor", "script_noteworthy");
    var_2 = [];

    if(_func_0107(var_0) && _func_0107(var_1)) {
      var_2 = scripts\engine\utility::array_combine(var_0, var_1);
    } else if(_func_0107(var_0)) {
      var_2 = var_0;
    } else if(_func_0107(var_1)) {
      var_2 = var_1;
    }

    foreach(var_4 in var_2) {
      var_4 hide();
    }
  }
}

_id_1073C() {
  if(!isDefined(level._id_11EF)) {
    level._id_11EF = [];
  }

  wait 0.2;
  _id_0999::_id_5237("front_gate");
  _id_7FE7();
  _id_800D();
  destroy_dlc_scriptable_blockers();
  level thread play_page_vfx();
}

_id_7FE7() {
  var_0 = ["messhall", "front_gate"];
}

onplayerconnect(var_0) {}

_id_DAC9(var_0) {
  return 0;
}

onplayerspawned() {
  scripts\cp\utility::_id_DCC4();
}

_id_800D() {
  scripts\cp\zombies\objective_barriers::init();
  var_0 = spawnStruct();
  var_0._id_4828 = [];
  var_0._id_332E = [];
  _id_0987::_id_3328(var_0);
  _id_0987::_id_D797(var_0._id_332E);
  _id_0987::_id_D2B2(1, 1);
  _id_0987::spawn_one_time_objectives();
  scripts\cp\zombies\objective_barriers::hide_all_objective_clip();
  waittillframeend;
  _id_06EF::_id_E16F(level._id_3BE9._id_96DE["objectives_location_fob"]._id_8300["exfil"].versions[0]);
  _id_0987::add_location_ammo_cache_markers(level._id_3BE9._id_96DE["objectives_location_fob"]);

  if(getdvarint("#x3553d15a56298db4", 0)) {
    level.fn_forever_blitz_start_wait_override = ::cp_zod_forever_blitz_start_wait_override;
    scripts\cp\zombies\objective_forever_blitz::spawn_forever_blitz();
  }
}

cp_zod_forever_blitz_start_wait_override() {
  if(getdvarint("#x3d716d492c9ae8f91", 0) || getdvarint("#x3ed73a37ce046aa3a", 0) == 0) {
    return;
  }
  for(;;) {
    level waittill("walls_removed");

    if(isDefined(level.a_active_zones) && scripts\engine\utility::array_contains(level.a_active_zones, "zone_vloffice")) {
      break;
    }
  }
}

post_launch_clip_fixes() {
  var_0 = getEntArray("clip128x128x8", "targetname");

  if(var_0.size > 0 && isDefined(var_0[0])) {
    var_0[0].origin = (1204, -2064, 192);
    var_0[0].angles = (0, 0, -29.9992);
  }

  var_1 = getEntArray("clip64x64x256", "targetname");

  if(var_1.size > 0 && isDefined(var_1[0])) {
    var_1[0].origin = (-1375.5, 507, 20);
    var_1[0].angles = (0, 0, 0);
  }

  var_2 = getEntArray("clip256x256x8", "targetname");

  if(var_2.size > 0 && isDefined(var_2[0])) {
    var_2[0].origin = (-1008, -896, 64);
    var_2[0].angles = (0, 0, 90);
  }

  var_3 = getEntArray("clip32x32x256", "targetname");

  if(var_3.size > 0 && isDefined(var_3[0])) {
    var_3[0].origin = (-1010, -898, 28);
    var_3[0].angles = (0, 37.9993, 0);
  }

  var_4 = getEntArray("player32x32x256", "targetname");

  if(var_4.size > 0 && isDefined(var_4[0])) {
    var_4[0].origin = (1149, -2223, 206);
    var_4[0].angles = (42.0011, 269.999, -90.0009);
  }
}

hide_dlc_walls() {
  if(!istrue(getdvarint("#x3ed73a37ce046aa3a", 0))) {
    var_0 = getEntArray("hub_wall_s1", "script_noteworthy");

    foreach(var_2 in var_0) {
      scripts\cp\zombies\zm_hub_unlock::toggle_ent(var_2, 0);
    }
  }
}

remove_dlc_blockers() {
  if(istrue(getdvarint("#x3ed73a37ce046aa3a", 0))) {
    var_0 = getEntArray("vl_office_blockers", "script_noteworthy");

    foreach(var_2 in var_0) {
      scripts\cp\zombies\zm_hub_unlock::toggle_ent(var_2, 0);
    }
  }
}

destroy_dlc_scriptable_blockers() {
  if(istrue(getdvarint("#x3ed73a37ce046aa3a", 0))) {
    var_0 = _func_03C0("vl_office_wooden_blockers", "targetname");

    foreach(var_2 in var_0) {
      var_2 _meth_8871(10000);
    }
  }
}

watch_for_vlo_open() {
  level endon("game_ended");
  level waittill("portal_c_1_completed");
  level waittill("players_landed");
  scripts\engine\utility::_id_5C1B("vlo_open");
}