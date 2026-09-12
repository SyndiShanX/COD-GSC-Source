/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_br_syrk\cp_br_syrk_humvee.gsc
************************************************************/

function start() {
  if(!scripts\engine\utility::flag_exist("cp_br_humvee_initted")) {
    scripts\engine\utility::flag_init("cp_br_humvee_initted");
  }

  scripts\cp\maps\cp_br_syrk\vehicle_travel::init();
  load_vfx();
  setDvar("cg_thirdPersonCarRange", 450);
  setDvar("cg_thirdPersonCarForward", 20);
  setDvar("cg_thirdPersonCarUp", 150);
  var_0 = scripts\engine\utility::getStruct("humvee_spawner", "script_noteworthy");
  level thread scripts\cp\maps\cp_br_syrk\vehicle_travel::deploy_vehicle(var_0, scripts\cp\maps\cp_br_syrk\vehicle_travel::get_humvee_info(var_0));
  level thread scripts\cp\maps\cp_br_syrk\vehicle_travel::set_up_ieds();
  thread cp_br_syrk_tutorial_dialogue();
  activate_radius_distance_trigger_markers();
  scripts\engine\utility::flag_set("cp_br_humvee_initted");
}

function teleport_players() {
  var_0 = scripts\engine\utility::getStructArray("humvee_player_start", "script_noteworthy");

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  foreach(var_3 in level.players) {
    var_4 = var_0[var_5];
    var_3 setOrigin(var_4.origin);
    var_3 setplayerangles(var_4.angles);
  }
}

function set_up_suicide_bomber_call_back() {
  level.suicide_bomber_combat_func = &suicide_bomber_combat_func;
  level.suicide_bomber_explode_func = &suicide_bomber_explode_func;
}

function suicide_bomber_combat_func() {
  self endon("death");
  var_0 = get_closet_alive_player(self);
  self getenemyinfo(var_0);

  for(;;) {
    self.bomberusegrenade = 0;

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on)) {
        self.bombertarget = self.enemy.vehicle_riding_on;
      } else {
        self.bombertarget = undefined;
      }
    }

    wait 0.25;
  }
}

function get_closet_alive_player(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return scripts\engine\utility::getclosest(var_0.origin, var_1);
}

function suicide_bomber_explode_func(var_0) {
  if(isDefined(var_0.bombertarget) && scripts\engine\utility::array_contains(level.vehicle_travel_array, var_0.bombertarget)) {
    var_1 = var_0.bombertarget;
    var_2 = get_closest_ied_triggering_tag(var_1, var_0);

    if(isDefined(var_2)) {
      var_3 = var_1 gettagorigin(var_2);
      var_4 = scripts\cp\maps\cp_br_syrk\vehicle_travel::get_repair_interaction_point_name(var_2);
      var_5 = scripts\cp\maps\cp_br_syrk\vehicle_travel::get_vehicle_interaction_point(var_1, var_4);
      scripts\cp\maps\cp_br_syrk\vehicle_travel::try_enable_repair_interaction(var_1, var_2, var_0.origin, var_4, var_5);
      return;
    }

    return;
  }
}

function get_closest_ied_triggering_tag(var_0, var_1) {
  var_2 = 99999999;
  var_3 = undefined;

  if(isDefined(var_0.ied_triggering_tags)) {
    foreach(var_5 in var_0.ied_triggering_tags) {
      var_6 = distancesquared(var_0 gettagorigin(var_5), var_1.origin);

      if(var_6 < var_2) {
        var_2 = var_6;
        var_3 = var_5;
      }
    }
  }

  return var_3;
}

function register_spawn_groups() {
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_one", 1, 1, 1, 3, 3, "drive_down_hill_house_one_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_one_back_right", 2, 2, 2, 4, 5, "drive_down_hill_house_one_back_right_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_two", 1, 1, 1, 4, 3, "drive_down_hill_house_two_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_three", 1, 1, 1, 4, 3, "drive_down_hill_house_three_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_three_back", 4, 4, 4, 4, 3, "drive_down_hill_house_three_back_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_four_rpg", 1, 1, 1, 5, 3, "drive_down_hill_house_four_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_five_mix", 2, 2, 2, 5, 3, "drive_down_hill_house_five_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_five_back", 4, 4, 4, 5, 3, "drive_down_hill_house_five_back_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_six", 1, 1, 1, 5, 3, "drive_down_hill_house_six_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_six_back", 3, 3, 3, 5, 3, "drive_down_hill_house_six_back_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_seven_mix", 3, 3, 3, 5, 3, "drive_down_hill_house_seven_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("drive_down_hill_house_suicide_bomber", 1, 3, 3, 5, 3, "drive_down_hill_suicide_bomber_spawner", undefined, undefined, undefined);
  thread drive_down_hill_enemy_spawn_think();
}

function drive_down_hill_enemy_spawn_think() {
  level endon("game_ended");
  level scripts\engine\utility::ref_143A5("ied_group_one_exploded", "reached_IED_zone_one");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_one");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_one_back_right");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_two");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_three");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_three_back");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_four_rpg");
  level scripts\engine\utility::ref_143A5("ied_group_two_exploded", "reached_IED_zone_two");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_five_mix");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_five_back");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_six");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_six_back");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_seven_mix");
  scripts\cp\cp_modular_spawning::run_spawn_module("drive_down_hill_house_suicide_bomber");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/BOMBER_INBOUND");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_bombers_10", "allies");
}

function get_vehicle_part_struct(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_1) {
      return var_4;
    }
  }
}

function activate_radius_distance_trigger_markers() {
  var_0 = scripts\engine\utility::getStructArray("radius_distance_trigger_marker", "script_noteworthy");

  foreach(var_2 in var_0) {
    thread radius_detection_monitor(var_2);
  }
}

function radius_detection_monitor(var_0) {
  var_1 = var_0.groupname + "";
  var_2 = undefined;

  if(isDefined(var_0.name)) {
    var_2 = var_0.name + "";
  }

  level endon("game_ended");

  if(isDefined(var_2)) {
    level endon(var_2);
  } else {
    level endon(var_1);
  }

  var_3 = var_0.radius;
  var_4 = var_3 * var_3;

  for(;;) {
    if(any_player_within_range(var_0, var_4)) {
      radius_detection_monitor_send_notify(var_1, var_0, var_2);
    }

    if(any_vehicle_within_range(var_0, var_4)) {
      radius_detection_monitor_send_notify(var_1, var_0, var_2);
    }

    waitframe();
  }
}

function radius_detection_monitor_send_notify(var_0, var_1, var_2) {
  if(isDefined(var_1.script_parameters)) {
    level notify(var_0, var_1.script_parameters + "");
  } else {
    level notify(var_0);
  }

  if(isDefined(var_2)) {
    level notify(var_2);
    return;
  }
}

function any_player_within_range(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(istrue(var_3.unable_to_trigger_radius_detection_monitor)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_3.origin) < var_1) {
      return true;
    }
  }

  return false;
}

function any_vehicle_within_range(var_0, var_1) {
  foreach(var_3 in level.vehicle_travel_array) {
    if(distancesquared(var_0.origin, var_3.origin) < var_1) {
      return true;
    }
  }

  return false;
}

function cp_br_syrk_tutorial_dialogue() {
  level endon("game_ended");
  thread near_ied_zone_warning_monitor();
  thread ied_marked_vo_monitor();
  thread repair_vehicle_intro_vo_monitor();
  scripts\engine\utility::flag_wait("infil_complete");
  thread vehicle_station_tutorial_vo_monitor();
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/EVERYONE_IN_VEHICLE");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_infil_start_nag_10", "allies");
  level waittill("trigger_IED_up_ahead_dialogue");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/IED_AHEAD");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_mark_ieds_10", "allies");
  thread delay_nag_mark_ied_vo();
}

function vehicle_station_tutorial_vo_monitor() {
  level endon("game_ended");
  level waittill("players_entered_vehicle");
  thread delay_use_gunner_turret_vo();
  thread delay_use_assault_drone_vo();
}

function delay_use_gunner_turret_vo() {
  level endon("game_ended");
  level endon("player_used_vehicle_gunner_turret");
  wait 3;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/USE_TURRET");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_turret_10", "allies");
}

function delay_use_assault_drone_vo() {
  level endon("game_ended");
  level endon("player_used_vehicle_mine_drone");
  wait 7;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/USE_ASSAULT_DRONE");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_drone_10", "allies");
}

function delay_nag_mark_ied_vo() {
  level endon("game_ended");
  level endon("IED_marked");
  level endon("stop_ied_nag");

  for(;;) {
    wait randomintrange(20, 30);
    level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/NAG_MARK_IED");
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_mark_ieds_20", "allies");
  }
}

function repair_vehicle_intro_vo_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_needs_repair");
    level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/REPAIR_VEHICLE_INTRO");
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_repair_10", "allies");
  }
}

function ied_marked_vo_monitor() {
  level endon("game_ended");
  var_0 = 120;

  for(var_1 = gettime();; var_1 = var_2 + var_0 * 1000) {
    level waittill("IED_marked");
    var_2 = gettime();

    if(var_2 > var_1) {
      scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_ieds_found_10", "allies");
    }
  }
}

function near_ied_zone_warning_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("near_IED_zone", var_0);

    if(any_ied_left_unidentified_in_zone(var_0)) {
      level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/WATCH_OUT_FOR_IED");
      scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_vehicle_find_ieds_10", "allies");
    }

    waitframe();
  }
}

function any_ied_left_unidentified_in_zone(var_0) {
  foreach(var_2 in level.unidentified_ieds) {
    if(isDefined(var_2.ied_controller) && isDefined(var_2.ied_controller.groupname) && var_2.ied_controller.groupname == var_0) {
      return true;
    }
  }

  return false;
}

function load_vfx() {
  load_surface_speed_vfx("cp_decho_rebel", "default", "slow", "vfx/iw8_cp/prop/vfx_humvee_treadfx_dust_slow.vfx");
  load_surface_speed_vfx("cp_decho_rebel", "default", "fast", "vfx/iw8_cp/prop/vfx_humvee_treadfx_dust_fast.vfx");
  load_surface_speed_vfx("cp_decho_rebel", "dust", "slow", "vfx/iw8_cp/prop/vfx_humvee_treadfx_dust_slow.vfx");
  load_surface_speed_vfx("cp_decho_rebel", "dust", "fast", "vfx/iw8_cp/prop/vfx_humvee_treadfx_dust_fast.vfx");
}

function load_surface_speed_vfx(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle.templates.surface_effects[var_0])) {
    level.vehicle.templates.surface_effects[var_0] = [];
  }

  var_4 = var_1 + "_" + var_2;
  level.vehicle.templates.surface_effects[var_0][var_4] = loadfx(var_3);
}