/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\sp_jup_vip\sp_jup_vip.gsc
*****************************************************/



#using script_1626cbe6741a772b;
#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_25d7b38eca129c47;
#using script_484f370bbd65b30a;
#using script_4b7698942d6f679a;
#using script_51f0a664afd44022;
#using script_53f4e6352b0b2425;
#using script_5c18c06254fef64e;
#using script_6316dce3e06af39e;
#using script_6bf6c8e2e1fdccaa;
#using script_72a4961ba7d664b5;
#using script_760b8e170bd1e20d;
#using script_7c9c760b9c462263;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\basic_wind;
#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\audio;
#using scripts\sp\hud_util;
#using scripts\sp\load;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_fx;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_makarov_reveal;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace sp_jup_vip;

function main() {
  setsaveddvar(@ "hash_490c69bf1996a7b0", "1");
  setsaveddvar(@ "hash_2202ee095a4b0546", "1");
  setDvar(@ "hash_2a4f08bc79265550", 1);

  if(getdvarint(@ "hash_c14e40d42354b411", 0) == 1) {
    println("<dev string:x1c>");
    scripts\sp\utility::function_e151438c44c81414();
  }

  level.var_4c9c84f746d64381 = 1;
  setDvar(@ "hash_1fbf179e197540f3", 0);
  flag_init("introscreen_start_wait");
  setDvar(@ "hash_84003ec62f06a169", 0);
  namespace_5968c159727be306::main();
  scripts\sp\maps\sp_jup_vip\sp_jup_vip_fx::main();
  namespace_20bc39e1e8895429::main();
  namespace_165c742e346e899e::main();
  transient_init("sp_jup_vip_water_vista_tr");
  precache();
  function_ff5d9827b7a048eb();
  init_flags();
  hint_strings();
  thread obj_flow();
  thread fov_flow();
  thread function_94d47ea467072bfd();
  level thread function_1ccb66fcaa05772();
  audio::set_audio_level_fade_time(1);
  scripts\sp\load::main();
  add_global_spawn_function("axis", &function_cde6164f0802468f);
  add_global_spawn_function("allies", &function_cde6164f0802468f);
  scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::main();
  set_completed_flags();
  setup_player();
  level.loot.maxweapons = 50;
  namespace_13d705da8b3c65b4::init();
  function_71ff564120e02eaa();
  function_fcdbed0749727cd7();
  thread namespace_4c190714a889a5c1::function_52e5bb0e329da129();
  level.var_ecd8c327b55af5e8 = 0;
  jets = getEntArray("courtyard_flyover_jets", "script_noteworthy");

  foreach(jet in jets) {
    jet hide();
  }

  level.friendlyfire["friend_kill_points"] = -450;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.var_eed0b997e799ad2e = 523;
  level.custom_friendly_fire_message = 524;
}

function precache() {
  precachemodel("misc_wm_bomb_drone_v0");
  precachemodel("misc_rapelling_rope_sim_fiber_long");
  precachemodel("parts_jup_headgear_m48_mod1_divemask_vm");
  precachemodel("misc_wm_ascender");
  precachemodel("jup_dpv_01_propeller");
  precachemodel("misc_wm_grappling_gun_v0");
  precachemodel("vm_c_jup_sp_villain_nolan_urban");
  precachemodel("vb_c_jup_sp_villain_nolan_urban");
  precachemodel("veh9_mil_air_heli_hind_mp");
  precachemodel("body_c_jup_sp_civ_prisoner_01_b_blood");
  precachemodel("body_c_jup_sp_civ_prisoner_02_b_blood");
  precachemodel("body_c_jup_sp_civ_prisoner_03_b_blood");
  precachemodel("body_c_jup_sp_civ_prisoner_04_b_blood");
  precachemodel("body_c_jup_sp_civ_prisoner_05_b_blood");
  add_hint_string("vip_dive_down", &"MARINA/GO_UNDERWATER");
  add_hint_string("vip_use_dpv_sprint", &"MARINA/SWIM_FASTER");
  add_hint_string("smoke_hint", &"SP_JUP_VIP/SMOKE_HINT");
}

function init_flags() {
  flag_init("flag_teamwork");
  flag_init("flag_control_room");
  flag_init("flag_squad");
  flag_init("flag_door01");
  flag_init("flag_door02");
  flag_init("flag_pri_door");
  flag_init("flag_pe");
  flag_init("flag_bridge");
  flag_init("flag_allies_begin_descend");
  flag_init("flag_door_4_closed");
  flag_init("flag_countdown_end");
  flag_init("flag_remove_player_scuba_gear");
}

function set_completed_flags() {
  level endon("return_completed_flags");

  if(is_default_start()) {
    return;
  }

  start = level.start_point;

  if(!isDefined(start)) {
    return;
  }

  if(start == "intro_dev_only_dont_use") {
    return;
  }

  if(start == "scuba") {
    return;
  }

  if(start == "wall") {
    return;
  }

  if(start == "infil") {
    return;
  }

  if(start == "maintenance") {
    return;
  }

  flag_set("flag_close_main_gate");
  flag_set("flag_infil_chopper_land");

  if(start == "descend") {
    return;
  }

  if(start == "reach_vip") {
    return;
  }

  if(start == "makarov_reveal") {
    return;
  }

  flag_set("flag_obj_reach_makarov_complete");

  if(start == "riot") {
    return;
  }

  flag_set("follow_makarov_objective_complete");
  flag_set("flag_locker_exit");
  flag_set("flag_riot_armory_advance");

  if(start == "elevator") {
    return;
  }

  flag_set("flag_obj_escape_cells_complete");
  flag_set("cine_elevator_actual_teleport");
  flag_set("cine_elevator_pre_end");
  flag_set("cine_elevator_end");

  if(start == "courtyard_arrive") {
    return;
  }

  flag_set("flag_obj_reach_gatehouse_activate");
  flag_set("flag_courtyard_update_vols_to_gate");
  flag_set("flag_courtyard_helipad_enemies_spawned");
  flag_set("flag_courtyard_exit_passed_helipad");
  flag_set("flag_courtyard_jet_strike_hit");

  if(start == "courtyard_retreat") {
    return;
  }

  flag_set("flag_obj_courtyard_reach_gatehouse");
  flag_set("flag_courtyard_retreat_send_allies_to_anim_start");

  if(start == "escape_start") {
    return;
  }

  flag_set("flag_redirect_heli_spawn");
  flag_set("flag_escape_cliff_start");
  flag_set("flag_escape_tunnel_heli_spawn");

  if(start == "cliff_start") {
    return;
  }

  flag_set("flag_escape_cliff_heli_enter");

  if(start == "slide_start") {
    return;
  }
}

function function_ff5d9827b7a048eb() {
  add_start("intro_dev_only_dont_use", &function_86a88b13dcfe495e, &function_43de679a99606c07, ["sp_jup_vip_scuba_tr", "sp_jup_vip_gulag_exterior_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_maintenance_vista_tr", "sp_jup_vip_exfil_tr"], &function_67284e12c35a9944);
  add_start("scuba", &function_4a5007e839e4aed4, &function_63309bd4e738c785, ["sp_jup_vip_scuba_tr", "sp_jup_vip_gulag_exterior_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_exfil_tr"], &function_e4045a2c8864391a);
  add_start("wall", &function_65a5cbf78d6b21f2, &function_d9013be857e37ea3, ["sp_jup_vip_scuba_tr", "sp_jup_vip_gulag_exterior_tr", "sp_jup_vip_rooftop_vista_tr", "sp_jup_vip_tower_vista_tr", "sp_jup_vip_maintenance_vista_tr", "sp_jup_vip_infil_tr", "sp_jup_vip_exfil_tr"], &function_90624d43f9fdb0d8);
  add_start("infil", &function_8106fefb1e9cb632, &function_fcb2584dbaf97de3, ["sp_jup_vip_infil_tr", "sp_jup_vip_gulag_exterior_tr", "sp_jup_vip_rooftop_vista_tr", "sp_jup_vip_tower_vista_tr", "sp_jup_vip_water_vista_tr", "sp_jup_vip_maintenance_vista_tr"], &function_d35ab83927d91418);
  add_start("maintenance", &function_6c846fc3431cc563, &function_ebad221b81fb5af4, ["sp_jup_vip_gulag_exterior_tr", "sp_jup_vip_rooftop_vista_tr", "sp_jup_vip_tower_vista_tr", "sp_jup_vip_maintenance_tr", "sp_jup_vip_water_vista_tr", "sp_jup_vip_infil_tr"], &function_bf4da5e644e35955);
  add_start("descend", &function_2ccfd6fd7896c60a, &function_84facbc07f411f7b, ["sp_jup_vip_piperoom_tr", "sp_jup_vip_panopticon_tr"], &function_d9f162cb6aefa040);
  add_start("reach_vip", &function_8607f97cb7f96343, &function_4ed0c87d948afc54, ["sp_jup_vip_panopticon_tr", "sp_jup_vip_cell_tr"], &function_50e68fbce0e7f935);
  add_start("makarov_reveal", &function_765dbc792acc92ad, &function_4473dc8032381786, ["sp_jup_vip_cell_tr", "sp_jup_vip_panopticon_tr"], &function_fd527fd6fc6a6bcf);
  add_start("riot", &riot_start, &riot_main, ["sp_jup_vip_cell_tr", "sp_jup_vip_panopticon_tr"], &function_da753a8b4cc3cdb6);
  add_start("elevator", &elevator_start, &elevator_main, ["sp_jup_vip_cell_tr", "sp_jup_vip_panopticon_tr"], &function_ba71f4c16efdae8e);
  add_start("courtyard_arrive", &function_312ac2bdc608977d, &function_3c6ab9ba991c1136, ["sp_jup_vip_rooftop_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_maintenance_tr", "sp_jup_vip_tower_tr"], &function_62b5ab121c530e3f);
  add_start("courtyard_retreat", &courtyard_retreat_start, &courtyard_retreat_main, ["sp_jup_vip_rooftop_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_maintenance_tr", "sp_jup_vip_tower_tr"], &courtyard_retreat_catchup);
  add_start("escape_start", &escape_start, &escape_main, ["sp_jup_vip_rooftop_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_maintenance_tr", "sp_jup_vip_tower_tr"], &escape_catchup);
  add_start("cliff_start", &cliff_start, &cliff_main, ["sp_jup_vip_rooftop_tr", "sp_jup_vip_gulag_exterior_tr", "sp_jup_vip_exfil_tr", "sp_jup_vip_exfil_hallway_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_tower_tr"], &function_45ec82c0014d1b4c);
  add_start("slide_start", &slide_start, &slide_main, ["sp_jup_vip_rooftop_tr", "sp_jup_vip_gulag_exterior_tr", "sp_jup_vip_exfil_tr", "sp_jup_vip_exfil_hallway_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_tower_tr"], &slide_catchup);
  set_default_start("scuba");
}

function function_cde6164f0802468f() {
  self.laserenabled = 0;
  self.disableupdatelaserstatus = 1;
  self laserforceoff();
}

function music_flow() {
  flag_wait("flag_begin_explosions");
  explosion = snd_play("temp_explo_distant", level.player);
  function_e70d88e85d5fb19a(explosion, 1, 0);
  explosion2 = snd_play("temp_explo_low", level.player);
  function_e70d88e85d5fb19a(explosion2, 1, 0);
  wait 2;
  snd_stop(explosion, 0);
  snd_stop(explosion2, 0);
  flag_wait("flag_turn_spotlights_towards_explosion");
  walla = snd_play("temp_walla_foreign_alert_lp", level.player);
  function_e70d88e85d5fb19a(walla, 1, 0);
  alarms = snd_play("temp_env_alarm_lrg_lp", level.player);
  function_e70d88e85d5fb19a(alarms, 1, 0);
  wait 10;

  if(isDefined(alarms)) {
    snd_stop(alarms, 2.5);
  }

  flag_wait("flag_infil_player_at_door");

  if(isDefined(walla)) {
    snd_stop(walla, 2.5);
  }

  flag_wait("flag_makarov_pcap_complete");
  walla = snd_play("temp_walla_foreign_alert_lp", level.player);
  function_e70d88e85d5fb19a(walla, 1, 0);
  alarms = snd_play("temp_env_alarm_lrg_lp", level.player);
  function_e70d88e85d5fb19a(alarms, 1, 0);
  flag_wait("vip_stop_alarms");

  if(isDefined(alarms)) {
    snd_stop(alarms, 2.5);
  }

  flag_wait("flag_cellriot_door07_open");

  if(isDefined(walla)) {
    snd_stop(walla, 2.5);
  }
}

function function_14b6f7e56f315af9() {
  thread function_6d9b8c5411a31ba();
  level.var_6b29049bdb111387 = 0;

  while(!flag("vip_fov_maintenance_piperoom_enter")) {
    if(!level.var_6b29049bdb111387) {
      flag_wait("vip_fov_maintenance_squeezy_stairs_exit");

      while(level.player istouching(self)) {
        waitframe();
      }

      waitframe();
      level.player modifybasefov(65, 1, 0.5, 0.5);
      level.var_6b29049bdb111387 = 1;
    }

    waitframe();
  }
}

function function_6d9b8c5411a31ba() {
  while(!flag("vip_fov_maintenance_piperoom_enter")) {
    if(level.player istouching(self)) {
      if(flag("vip_fov_maintenance_squeezy_stairs_exit")) {
        flag_clear("vip_fov_maintenance_squeezy_stairs_exit");
        level.var_6b29049bdb111387 = 0;
      }
    }

    waitframe();
  }
}

function fov_flow() {
  flag_wait("vip_fov_scuba_gameplay_start");

  if(!flag("vip_fov_scuba_gameplay_end")) {
    level.player modifybasefov(60, 1.5, 0.5, 0.5);
  }

  flag_wait("vip_fov_scuba_gameplay_end");

  if(!flag("vip_fov_wallascend_top_of_wall")) {
    level.player modifybasefov(65, 1.5, 0.5, 0.5);
  }

  flag_wait("vip_fov_wallascend_top_of_wall");

  if(!flag("vip_fov_maintenance_piperoom_enter")) {
    level.player modifybasefov(65, 0.5, 0.25, 0.25);
  }

  lerp_fov_trigger_infil_wooden_frame = getEnt("lerp_fov_trigger_infil_wooden_frame", "targetname");
  lerp_fov_trigger_infil_wooden_frame thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_infil_tower_exit = getEnt("lerp_fov_trigger_infil_tower_exit", "targetname");
  lerp_fov_trigger_infil_tower_exit thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_infil_scaffolding_stairs_enter = getEnt("lerp_fov_trigger_infil_scaffolding_stairs_enter", "targetname");
  lerp_fov_trigger_infil_scaffolding_stairs_enter thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_maintenance_scaffolding_stairs_exit = getEnt("lerp_fov_trigger_maintenance_scaffolding_stairs_exit", "targetname");
  lerp_fov_trigger_maintenance_scaffolding_stairs_exit thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_maintenance_squeezy_stairs_enter = getEnt("lerp_fov_trigger_maintenance_squeezy_stairs_enter", "targetname");
  lerp_fov_trigger_maintenance_squeezy_stairs_enter thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_maintenance_squeezy_stairs_stairs = getEnt("lerp_fov_trigger_maintenance_squeezy_stairs_stairs", "targetname");
  lerp_fov_trigger_maintenance_squeezy_stairs_stairs thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_maintenance_squeezy_stairs_stairs thread function_14b6f7e56f315af9();
  flag_wait("vip_fov_maintenance_piperoom_enter");

  if(!flag("vip_fov_cellblockdescend_pipe_enter")) {
    level.player modifybasefov(55, 0.5, 0.25, 0.25);
  }

  lerp_fov_trigger_pipe_room_pipe = getEnt("lerp_fov_trigger_pipe_room_pipe", "targetname");
  lerp_fov_trigger_pipe_room_pipe thread lerp_fov_over_distance_trigger();
  flag_wait("vip_fov_cellblockdescend_gameplay_start");

  if(!flag("flag_makarov_pcap_complete")) {
    level.player modifybasefov(80, 1, 0.1, 0.1);
  }

  var_9b5e1938a495dbda = getEnt("lerp_fov_trigger_cellblock_entry", "targetname");
  var_9b5e1938a495dbda thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_reachvip_dungeon_stairs_enter = getEnt("lerp_fov_trigger_reachvip_dungeon_stairs_enter", "targetname");
  lerp_fov_trigger_reachvip_dungeon_stairs_enter thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_reachvip_dungeon_stairs_exit = getEnt("lerp_fov_trigger_reachvip_dungeon_stairs_exit", "targetname");
  lerp_fov_trigger_reachvip_dungeon_stairs_exit thread lerp_fov_over_distance_trigger();
  flag_wait("flag_makarov_pcap_complete");
  utility::disable_trigger_with_targetname("lerp_fov_trigger_reachvip_dungeon_stairs_enter");
  utility::disable_trigger_with_targetname("lerp_fov_trigger_reachvip_dungeon_stairs_exit");

  if(flag("cine_elevator_pre_end")) {}

  lerp_fov_trigger_corridor = getEnt("lerp_fov_trigger_corridor", "targetname");
  lerp_fov_trigger_corridor thread lerp_fov_over_distance_trigger();
  flag_wait("cine_elevator_pre_end");

  if(!flag("flag_escape_tunnel_enter")) {
    wait 2;
    level.player modifybasefov(65, 2, 0.5, 0.5);
  }

  lerp_fov_trigger_escape_tunnel_enter = getEnt("lerp_fov_trigger_escape_tunnel_enter", "targetname");
  lerp_fov_trigger_escape_tunnel_enter thread lerp_fov_over_distance_trigger();
  lerp_fov_trigger_escape_hallway_prisoner_door_breach = getEnt("lerp_fov_trigger_escape_hallway_prisoner_door_breach", "targetname");
  lerp_fov_trigger_escape_hallway_prisoner_door_breach thread lerp_fov_over_distance_trigger();
}

function function_bafc9a2a31f04c09(objectivename, var_3ed87ea90882333, var_4ddc8d75e113b606) {
  flag_wait(var_4ddc8d75e113b606);
  objective_remove_location(objectivename, var_3ed87ea90882333);
}

function function_92a30d568ca909c3() {
  while(!flag("flag_killed_all_level_1_enemies") || !flag("flag_killed_level_2_enemies") || !flag("flag_killed_level_3_enemies")) {
    waitframe();
  }

  objective_complete("assess_threats");
}

function obj_flow() {
  flag_wait("flag_start_wall_ascend");
  var_2e2e1ffa730e3db3 = getStruct("start_rappel_interact", "targetname");
  objective_add("rescue_makarov", "current", var_2e2e1ffa730e3db3.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER", undefined, undefined, 0, 1);
  objectiveindex = _objective_getindexforname("rescue_makarov");
  objective_setplayintro(objectiveindex, 1);
  function_ff959ec1bd44c166("rescue_makarov", -110);

  if(isDefined(var_2e2e1ffa730e3db3)) {
    if(!flag("flag_obj_get_to_gulag_complete")) {
      wait 6;
    }

    if(!flag("flag_obj_get_to_gulag_complete") && !flag("flag_vip_wall_player_grabbed_brace")) {
      var_f23743d01d0d8f2 = level.player getclientomnvar("ui_show_objectives");

      if(!var_f23743d01d0d8f2) {
        display_hint("focus_hint", undefined, 0, var_2e2e1ffa730e3db3, "trigger");
      }
    }
  }

  flag_wait("flag_obj_get_to_gulag_complete");
  function_ff959ec1bd44c166("rescue_makarov", 0);
  obj_struct = getStruct("obj_infil_reach_cells_wall", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER");
  objectiveindex = _objective_getindexforname("rescue_makarov");
  objective_setplayintro(objectiveindex, 1);
  flag_wait("flag_obj_synch_with_bravo");
  flag_wait("flag_obj_infil_wall_complete");
  obj_struct = getStruct("obj_infil_reach_cells_maintenance", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER");
  flag_wait("flag_obj_infil_maintenance_start");
  flag_clear("wind_on");
  obj_struct = getStruct("obj_infil_maint_hatch", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER");
  function_3234e40df03b0a40("rescue_makarov");
  flag_wait("flag_maint_obj_update");
  obj_struct = getStruct("obj_infil_maint_hatch_lower", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER");
  flag_wait("flag_obj_infil_maintenance_complete");
  obj_struct = getStruct("obj_infil_reach_cells_pipe_room_end", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER");
  function_ff959ec1bd44c166("rescue_makarov", 0);
  flag_wait("flag_obj_infil__pipe_room_complete");
  obj_struct = getStruct("infil_pipe_gate_interact", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER");
  function_ff959ec1bd44c166("rescue_makarov", -90);
  flag_wait("flag_obj_reach_makarov_activate");
  function_ff959ec1bd44c166("rescue_makarov", 0);
  obj_struct = getStruct("obj_location_rescue_627", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER", undefined, undefined, undefined, undefined, undefined);
  objectiveindex = _objective_getindexforname("rescue_makarov");
  objective_setplayintro(objectiveindex, 1);
  flag_wait("flag_obj_assess_threat_1");
  obj_struct = getStruct("lookat_level_1_pushdown", "targetname");
  objective_add("assess_threats", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_ELIMINATE_GUARDS", undefined, undefined, undefined, undefined, undefined, 1);
  objective_add_location_position("assess_threats", "lookat_level_1_cells", obj_struct.origin);
  objectiveindex = _objective_getindexforname("assess_threats");
  objective_setplayintro(objectiveindex, 1);
  flag_wait("flag_obj_assess_threat_2");
  obj_struct = getStruct("lookat_level_2_cells", "targetname");
  objective_add_location_position("assess_threats", "lookat_level_2_cells", obj_struct.origin);
  flag_wait("flag_obj_assess_threat_3");
  obj_struct = getStruct("lookat_level_3_cells", "targetname");
  objective_add_location_position("assess_threats", "lookat_level_3_cells", obj_struct.origin);
  thread function_bafc9a2a31f04c09("assess_threats", "lookat_level_1_cells", "flag_killed_all_level_1_enemies");
  thread function_bafc9a2a31f04c09("assess_threats", "lookat_level_2_cells", "flag_killed_level_2_enemies");
  thread function_bafc9a2a31f04c09("assess_threats", "lookat_level_3_cells", "flag_killed_level_3_enemies");
  thread function_92a30d568ca909c3();
  flag_wait("flag_end_descend");
  objective_complete("assess_threats");
  objective_set_state("assess_threats", "invisible");
  waitframe();
  objective_remove("assess_threats");
  obj_struct = getStruct("obj_infil_rescue_makarov", "targetname");
  objective_update("rescue_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER");
  objectiveindex = _objective_getindexforname("rescue_makarov");
  objective_setplayintro(objectiveindex, 1);

  if(isDefined(level.ally1)) {
    objective_add_location_entity("rescue_makarov", "ally1", level.ally1);
    pos = level.ally1 gettagorigin("j_head");
    objective_set_z_offset("rescue_makarov", pos[2] * -1 * 0.3);
  }

  flag_wait("flag_show_mak_reveal_breach_prompt");
  objective_remove_location("rescue_makarov", "ally1");
  objective_set_z_offset("rescue_makarov", 0);
  breach_interact = getStruct("reach_vip_pcap_interact", "targetname");
  objective_update("rescue_makarov", "current", breach_interact.origin, &"SP_JUP_VIP/OBJ_RESCUE_PRISONER", undefined, undefined, 0, 1);
  objectiveindex = _objective_getindexforname("rescue_makarov");
  objective_setplayintro(objectiveindex, 1);
  function_ff959ec1bd44c166("rescue_makarov", -110);
  flag_wait("flag_obj_reach_makarov_complete");
  objective_complete("rescue_makarov");
  flag_wait("flag_makarov_pcap_complete");
  objective_add("escape_makarov", "current", undefined, &"SP_JUP_VIP/OBJ_ESCAPE_MAKAROV", undefined, undefined, 48, 1);
  objectiveindex = _objective_getindexforname("escape_makarov");
  objective_setplayintro(objectiveindex, 1);
  objective_add_location_entity("escape_makarov", "makarov", level.makarov);
  function_54586a40e8a00778("escape_makarov");
  objective_set_state("rescue_makarov", "invisible");
  waitframe();
  objective_remove("rescue_makarov");
  flag_wait("follow_makarov_objective_complete");
  objective_remove_location("escape_makarov", "makarov");
  objective_set_z_offset("escape_makarov", 0);
  var_857b73f656830e9f = getStruct("riot_armory_objective_marker", "targetname");
  objective_update("escape_makarov", "current", var_857b73f656830e9f.origin, &"SP_JUP_VIP/OBJ_ESCAPE_MAKAROV", undefined, undefined, 5, 1);
  objective_setplayintro(objectiveindex, 1);
  function_3234e40df03b0a40("escape_makarov");
  flag_wait("flag_riot_armory_advance");
  var_bbe1a68d34072ea5 = getStruct("riot_elevator_interact", "targetname");
  objective_update("escape_makarov", "current", var_bbe1a68d34072ea5.origin, &"SP_JUP_VIP/OBJ_ESCAPE_MAKAROV", undefined, undefined, 5, 1);
  objective_setplayintro(objectiveindex, 1);
  function_3234e40df03b0a40("escape_makarov");
  flag_wait("flag_obj_escape_cells_complete");
  objective_add_location_entity("escape_makarov", "makarov", level.makarov);
  function_54586a40e8a00778("escape_makarov");
  function_ff959ec1bd44c166("escape_makarov", 0);
  flag_wait("flag_obj_reach_gatehouse_activate");
  objective_remove_location("escape_makarov", "makarov");
  objective_set_z_offset("escape_makarov", 0);
  obj_struct = getStruct("obj_struct_gatehouse_tunnel", "targetname");
  objective_update("escape_makarov", "current", obj_struct.origin, &"SP_JUP_VIP/OBJ_ESCAPE_MAKAROV", undefined, undefined, 0, 1);
  objectiveindex = _objective_getindexforname("escape_makarov");
  objective_setplayintro(objectiveindex, 1);
  flag_wait("flag_obj_courtyard_reach_gatehouse");
  objstruct = getStruct("obj_escape_bridge", "targetname");
  objective_update("escape_makarov", "current", objstruct.origin, &"SP_JUP_VIP/OBJ_ESCAPE_MAKAROV", undefined, undefined, 0, 1);
  flag_wait("flag_obj_escape_redirect");
  objective_update("escape_makarov", "current", objstruct.origin, &"SP_JUP_VIP/OBJ_ESCAPE_MAKAROV", undefined, undefined, 0, 1);
  objectiveindex = _objective_getindexforname("escape_makarov");
  objective_setplayintro(objectiveindex, 1);
  objective_ping(objectiveindex);
  thread function_ffe7ed6943695f7a(objectiveindex);
  objective_add_location_entity("escape_makarov", "makarov", level.makarov);
  function_54586a40e8a00778("escape_makarov");
  flag_wait("flag_obj_escape_makarov_complete");
  objective_complete("escape_makarov");
}

function function_ffe7ed6943695f7a(objectiveindex) {
  level endon("flag_escape_tunnel_player_through_door");
  flag_wait("flag_escape_redirect_scene_end");
  wait 5;
  display_hint("focus_hint", undefined, 0, level, "flag_escape_tunnel_player_through_door");
}

function setup_player() {
  level thread function_f5e2e591fdb465b2();
  var_2f7136cf6c5b1b14 = ["frag", "semtex", "smoke", "smoke_righthand"];
  offhandprecache(var_2f7136cf6c5b1b14);
  level.startweapon = make_weapon("jup_jp02_ar_bromeo805_vip");
  level.var_5d30013b94a2135d = make_weapon("iw9_me_knife_sp_dpv");
  level.var_2d3ac368e2984df7 = make_weapon("jup_ar_mike4_sp_grappling_gun");
  level.player give_weapon(level.startweapon);
  level.smg = make_weapon("jup_jp02_sm_scharlie3_vip");
  level.player give_weapon(level.smg, 0, 0, 0, 1);
  level.player give_offhand("semtex");
  level.player give_offhand("smoke");
  level.player switchtoweapon(level.startweapon);
  level.player givemaxammo(level.startweapon);
  level.player givemaxammo(level.smg);
  level.player player_recoilscaleon(45);
}

function function_1ccb66fcaa05772() {
  level thread function_ae20b2a7fa79cb4();
}

function function_f5e2e591fdb465b2() {
  function_7d89f98164b6df3d("vm_c_jup_sp_villain_nolan_urban", "vb_c_jup_sp_villain_nolan_urban", "default_character_shadow");
  scripts\sp\player_rig::init_player_rig("vm_c_jup_sp_villain_nolan_urban", undefined, "vb_c_jup_sp_villain_nolan_urban");
  level.player val::set("vip_player", "show_legs_and_shadow", 0);
  level.player function_c4ec7d985422ce24("vb_c_jup_sp_villain_nolan_urban");
  flag_wait("flag_remove_player_scuba_gear");
}

function function_7d89f98164b6df3d(viewmodel, legmodel, shadowmodel) {
  if(isDefined(viewmodel)) {
    level.player setviewmodel(viewmodel);
  }

  if(isDefined(legmodel)) {
    level.player setlegsmodel(legmodel);
  }

  if(isDefined(shadowmodel)) {
    level.player setshadowmodel(shadowmodel);
  }
}

function hint_strings() {
  add_hint_string("use_drone_hint", &"SP_JUP_VIP/USE_DRONE_HINT");
  add_hint_string("fire_drone_hint", &"SP_JUP_VIP/FIRE_DRONE_HINT");
  add_hint_string("nvg_hint", &"SP_JUP_VIP/NVG_HINT");
  add_hint_string("call_charlie_hint", &"SP_JUP_VIP/CALL_CHARLIE_HINT");
  add_hint_string("belay_hint", &"SP_JUP_VIP/BELAY_HINT");
  add_hint_string("crouch_hint", &"SP_JUP_VIP/CROUCH_HINT");
  add_hint_string("zipline_hint", &"SP_JUP_VIP/ZIPLINE_HINT");
}