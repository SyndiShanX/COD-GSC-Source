/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_obj_convoyescort.gsc
**********************************************************************/

function main() {
  level.convoyescort_interaction = &register_interactions;
  level.suicide_bomber_combat_func = &suicide_bomber_combat_func;
  level.convoyescort_obj_func = &register_convoyescort_objective;
}

function register_convoyescort_objective() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = &scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("obj_convoyescort", &obj_maj_approach_init, &obj_maj_approach_start, &obj_maj_approach_end, &debugbeatobjective, &debug_start_convoyescort);
  thread register_spawn_functions();
}

function register_interactions() {}

function obj_maj_approach_init(var_0) {}

function obj_maj_approach_start(var_0) {
  thread convoy_spawn(level);
  wait 99999;
}

function obj_maj_approach_end(var_0) {}

function debugbeatobjective(var_0) {
  level notify("debug_beat_" + var_0 + "_objective");
}

function convoy_spawn(var_0) {
  level.convoy_speed_override = 12;
  var_1 = scripts\engine\utility::getStruct("convoy_start_01", "targetname");
  var_2 = "convoyescort-type";
  var_3 = "convoy_to_escort";
  var_4 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_5 = level[[var_4]](var_3, var_2, var_1, var_0);
  thread convoy_settings(level);
  thread temp_start_and_stop_test();
}

function convoy_settings(var_0) {
  var_0 thread scripts\cp\cp_convoy_manager::set_center_compromises(0);
}

function temp_start_and_stop_test() {
  level endon("game_ended");

  for(;;) {
    wait 10;
    thread convoy_stop_all_cars();
    announcement("Stopping convoy test!");
    wait 2;
    thread convoy_resume_all_cars();
    announcement("Resuming convoy test!");
  }
}

function convoy_stop_all_cars() {
  var_0 = level.all_convoys["convoy_to_escort"];

  foreach(var_2 in var_0.spawned_vehicles) {
    var_2 vehicle_setspeedimmediate(0, 1, 1);
  }
}

function convoy_resume_all_cars() {
  var_0 = level.all_convoys["convoy_to_escort"];

  foreach(var_2 in var_0.spawned_vehicles) {
    var_2 resumespeed();
  }
}

function register_spawn_functions() {
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("building_guards", 18, 18, 18, 0.1, 0, "building_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards", &setup_manual_goalpos);
}

function setup_manual_goalpos(var_0, var_1) {
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "building_guards":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      break;
  }
}

function watchforstopwaves(var_0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var_0) {
  level endon("game_ended");
  level waittill("end_wave_convoyescort_spawners");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function stopwaveandstartthisone(var_0) {
  level notify("end_wave_convoyescort_spawners");
  wait 0.5;
  [[var_0]]();
}

function suicide_bomber_combat_func() {
  self endon("death");
  var_0 = get_closet_alive_player(self);
  self getenemyinfo(var_0);

  for(;;) {
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

function debug_start_convoyescort(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "convoyescort_debug_start_loc", 1);
}