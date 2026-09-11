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
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("quarry_def_spawners1", 10, 10, 10, 0.5, &wait_for_all_group_dead, "quarry_def_1", undefined, &getnextquarrydefensespawnmodule, undefined);
  [[var0]]("quarry_def_spawners2", 10, 10, 10, 0.5, &wait_for_all_group_dead, "quarry_def_2", undefined, &getnextquarrydefensespawnmodule, undefined);
  [[var0]]("quarry_def_spawners3", 10, 10, 10, 0.5, &wait_for_all_group_dead, "quarry_def_3", undefined, &getnextquarrydefensespawnmodule, undefined);
}

function waitforallplayersnearpoint(var0, var1) {
  var2 = 0;

  while(!var2) {
    var2 = 1;

    foreach(var4 in level.players) {
      if(distance(var4.origin, var0) > 100) {
        var2 = 0;
      }
    }

    wait 0.5;
  }
}

function startquarrydef1(var0, var1) {
  waitforallplayersnearpoint(var0.iconpos[0], 100);
  level.activequarrydefense = 1;
  iprintlnbold("Defend the quarry point");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("quarry_def_spawners1");
  wait 20;
  level.activequarrydefense = undefined;
}

function startquarrydef2(var0, var1) {
  waitforallplayersnearpoint(var0.iconpos[0], 100);
  level.activequarrydefense = 2;
  iprintlnbold("Defend the quarry point");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("quarry_def_spawners2");
  wait 20;
  level.activequarrydefense = undefined;
}

function startquarrydef3(var0, var1) {
  waitforallplayersnearpoint(var0.iconpos[0], 100);
  level.activequarrydefense = 3;
  iprintlnbold("Defend the quarry point");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("quarry_def_spawners3");
  wait 20;
  level.activequarrydefense = undefined;
}

function getnextquarrydefensespawnmodule(var0) {
  if(!isDefined(level.activequarrydefense)) {
    return;
  }

  var1 = undefined;

  switch (level.activequarrydefense) {
    case 1:
      var1 = "quarry_def_spawners1";
      break;
    case 2:
      var1 = "quarry_def_spawners2";
      break;
    case 3:
      var1 = "quarry_def_spawners3";
      break;
    default:
      var1 = undefined;
      break;
  }

  return var1;
}

function wait_for_all_group_dead(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    var0 scripts\engine\utility::ref_143b9(var1, "group_spawning_completed");
    return;
  }

  var0 waittill("group_spawning_completed");
}