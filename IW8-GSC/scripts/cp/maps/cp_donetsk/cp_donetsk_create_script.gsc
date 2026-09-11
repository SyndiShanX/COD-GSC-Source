/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_create_script.gsc
*******************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_create_script");
  var_2 = spawnStruct();
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

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "cp_donetsk_create_script");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_create_script");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-25093.2, 20680, 549.27), undefined, "heli_spawner", undefined, undefined, "3", "1", undefined, undefined, 512, 2000, undefined);
  var_3 = spawnStruct();
  var_3.script_demeanor = "casual_gun";
  var_3.script_function = "lbravo_carrier";
  var_3.script_team = "axis";
  var_3.script_unload = "1";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-23808.2, 14665.6, 56), undefined, "lay_heli_spawn", undefined, "default", "1 2", "3", undefined, undefined, 512, 2000, 40);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-23838, 14664, 952), undefined, undefined, undefined, undefined, undefined, "2", undefined, undefined, undefined, undefined, undefined);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-24325.2, 20512, 549.27), undefined, "heli_spawner", undefined, undefined, "4", "6", undefined, undefined, 512, 2000, undefined);
  var_3 = spawnStruct();
  var_3.script_demeanor = "casual_gun";
  var_3.script_function = "lbravo_carrier";
  var_3.script_team = "axis";
  var_3.script_unload = "1";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-24334.4, 16008.2, 56), (0, 270, 0), "lay_heli_spawn", undefined, "default", "6 5", "4", undefined, undefined, 512, 2000, 40);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-24334, 16040, 952), undefined, undefined, undefined, undefined, undefined, "5", undefined, undefined, undefined, undefined, undefined);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-20101.2, 20440, 549.27), undefined, "heli_spawner", undefined, undefined, "9", "7", undefined, undefined, 512, 2000, undefined);
  var_3 = spawnStruct();
  var_3.script_demeanor = "casual_gun";
  var_3.script_function = "lbravo_carrier";
  var_3.script_team = "axis";
  var_3.script_unload = "1";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-20454.4, 15856.2, 56), (0, 270, 0), "lay_heli_spawn", undefined, "default", "7 8", "9", undefined, undefined, 512, 2000, 40);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-20454, 15888, 952), undefined, undefined, undefined, undefined, undefined, "8", undefined, undefined, undefined, undefined, undefined);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (0, 0, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}