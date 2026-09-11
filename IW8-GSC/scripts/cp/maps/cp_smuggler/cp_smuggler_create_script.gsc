/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler\cp_smuggler_create_script.gsc
*********************************************************************/

function main(var0, var1) {
  level endon("game_ended");
  var2 = spawnStruct();
  scripts\engine\utility::flag_init("cp_smuggler_create_script");
  thread cs_return_and_wait_for_flag(level, var0, var1, var2);

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime()) {
    scripts\cp\cp_create_script_utility::endcreatescript(var2);
    return;
  }
}

function cs_return_and_wait_for_flag(var0, var1, var2, var3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var3);

  if(!isDefined(var1)) {
    var1 = "stk";
  }

  scripts\cp\cp_create_script_utility::strike_setup_arrays(var1);
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_smuggler_create_script");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_smuggler_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = (0, 0, 0);
  scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}