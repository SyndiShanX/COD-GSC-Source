/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_script_spawners.gsc
*********************************************************************/

function main() {
  level endon("game_ended");

  if(!isDefined(level.scripted_spawners)) {
    level.scripted_spawners = [];
  }

  initflags();
  thread createstructs();
  thread createtriggers();
  thread createmodels();
  thread waitforflags();
}

function initflags() {
  scripts\engine\utility::flag_init("strike_init_done");
  scripts\engine\utility::flag_init("create_script_initialized");
  scripts\engine\utility::flag_init("cs_structs_complete");
  scripts\engine\utility::flag_init("cs_models_complete");
  scripts\engine\utility::flag_init("cs_triggers_complete");
}

function waitforflags() {
  scripts\engine\utility::flag_wait("cs_structs_complete");
  scripts\engine\utility::flag_wait("cs_models_complete");
  scripts\engine\utility::flag_wait("cs_triggers_complete");
  scripts\engine\utility::flag_set("strike_init_done");
  scripts\engine\utility::flag_set("create_script_initialized");
}

function createstructs() {
  scripts\engine\utility::flag_set("cs_structs_complete");
}

function createtriggers() {
  scripts\engine\utility::flag_set("cs_triggers_complete");
}

function createmodels() {
  scripts\engine\utility::flag_set("cs_models_complete");
}