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
  var0 = &scripts\cp\cp_objectives::registerobjective;
  [[var0]]("obj_convoyescort", &obj_maj_approach_init, &obj_maj_approach_start, &obj_maj_approach_end, &debugbeatobjective, &debug_start_convoyescort);
  thread register_spawn_functions();
}

function register_interactions() {}

function obj_maj_approach_init(var0) {}

function obj_maj_approach_start(var0) {
  thread convoy_spawn(level);
  wait 99999;
}

function obj_maj_approach_end(var0) {}

function debugbeatobjective(var0) {
  level notify("debug_beat_" + var0 + "_objective");
}

function convoy_spawn(var0) {
  level.convoy_speed_override = 12;
  var1 = scripts\engine\utility::getStruct("convoy_start_01", "targetname");
  var2 = "convoyescort-type";
  var3 = "convoy_to_escort";
  var4 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var5 = level[[var4]](var3, var2, var1, var0);
  thread convoy_settings(level);
  thread temp_start_and_stop_test();
}

function convoy_settings(var0) {
  var0 thread scripts\cp\cp_convoy_manager::set_center_compromises(0);
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
  var0 = level.all_convoys["convoy_to_escort"];

  foreach(var2 in var0.spawned_vehicles) {
    var2 vehicle_setspeedimmediate(0, 1, 1);
  }
}

function convoy_resume_all_cars() {
  var0 = level.all_convoys["convoy_to_escort"];

  foreach(var2 in var0.spawned_vehicles) {
    var2 resumespeed();
  }
}

function register_spawn_functions() {
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("building_guards", 18, 18, 18, 0.1, 0, "building_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards", &setup_manual_goalpos);
}

function setup_manual_goalpos(var0, var1) {
  var2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var2);

  switch (var0.group_name) {
    case "building_guards":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      break;
  }
}

function watchforstopwaves(var0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level waittill("end_wave_convoyescort_spawners");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function stopwaveandstartthisone(var0) {
  level notify("end_wave_convoyescort_spawners");
  wait 0.5;
  [[var0]]();
}

function suicide_bomber_combat_func() {
  self endon("death");
  var0 = get_closet_alive_player(self);
  self getenemyinfo(var0);

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

function get_closet_alive_player(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      continue;
    }

    var1 = var3;
  }

  return scripts\engine\utility::getclosest(var0.origin, var1);
}

function debug_start_convoyescort(var0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "convoyescort_debug_start_loc", 1);
}