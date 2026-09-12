/********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_br_syrk\objectives\cp_quarry_defend_objective.gsc
********************************************************************************/

function registerquarryobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_objectives::registerobjective("quarry_defend_1", undefined, &startquarrydef1, undefined);
  scripts\cp\cp_objectives::registerobjective("quarry_defend_2", undefined, &startquarrydef2, undefined);
  scripts\cp\cp_objectives::registerobjective("quarry_defend_3", undefined, &startquarrydef3, undefined);
  initobjspawners();
}

function initobjspawners() {
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("quarry_def_spawners1", 10, 10, 10, 0.5, &wait_for_all_group_dead, "quarry_def_1", undefined, &getnextquarrydefensespawnmodule, undefined);
  [[var_0]]("quarry_def_spawners2", 10, 10, 10, 0.5, &wait_for_all_group_dead, "quarry_def_2", undefined, &getnextquarrydefensespawnmodule, undefined);
  [[var_0]]("quarry_def_spawners3", 10, 10, 10, 0.5, &wait_for_all_group_dead, "quarry_def_3", undefined, &getnextquarrydefensespawnmodule, undefined);
}

function waitforallplayersnearpoint(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_2 = 1;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) > 100) {
        var_2 = 0;
      }
    }

    wait 0.5;
  }
}

function startquarrydef1(var_0, var_1) {
  waitforallplayersnearpoint(var_0.iconpos[0], 100);
  level.activequarrydefense = 1;
  iprintlnbold("Defend the quarry point");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("quarry_def_spawners1");
  wait 20;
  level.activequarrydefense = undefined;
}

function startquarrydef2(var_0, var_1) {
  waitforallplayersnearpoint(var_0.iconpos[0], 100);
  level.activequarrydefense = 2;
  iprintlnbold("Defend the quarry point");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("quarry_def_spawners2");
  wait 20;
  level.activequarrydefense = undefined;
}

function startquarrydef3(var_0, var_1) {
  waitforallplayersnearpoint(var_0.iconpos[0], 100);
  level.activequarrydefense = 3;
  iprintlnbold("Defend the quarry point");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("quarry_def_spawners3");
  wait 20;
  level.activequarrydefense = undefined;
}

function getnextquarrydefensespawnmodule(var_0) {
  if(!isDefined(level.activequarrydefense)) {
    return;
  }

  var_1 = undefined;

  switch (level.activequarrydefense) {
    case 1:
      var_1 = "quarry_def_spawners1";
      break;
    case 2:
      var_1 = "quarry_def_spawners2";
      break;
    case 3:
      var_1 = "quarry_def_spawners3";
      break;
    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

function wait_for_all_group_dead(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_0 scripts\engine\utility::ref_143B9(var_1, "group_spawning_completed");
    return;
  }

  var_0 waittill("group_spawning_completed");
}