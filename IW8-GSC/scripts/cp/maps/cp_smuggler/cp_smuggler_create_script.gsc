/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler\cp_smuggler_create_script.gsc
*********************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");
  var_2 = spawnStruct();
  scripts\engine\utility::flag_init("cp_smuggler_create_script");
  thread cs_return_and_wait_for_flag(level, var_0, var_1, var_2);

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime()) {
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
    return;
  }
}

function cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1)) {
    var_1 = "stk";
  }

  scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1);
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_smuggler_create_script");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_smuggler_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = (0, 0, 0);
  scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}