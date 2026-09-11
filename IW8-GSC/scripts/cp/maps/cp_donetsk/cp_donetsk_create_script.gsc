/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_create_script.gsc
*******************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_create_script");
  var2 = spawnStruct();
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

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "cp_donetsk_create_script");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_create_script");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-25093.2, 20680, 549.27), undefined, "heli_spawner", undefined, undefined, "3", "1", undefined, undefined, 512, 2000, undefined);
  var3 = spawnStruct();
  var3.script_demeanor = "casual_gun";
  var3.script_function = "lbravo_carrier";
  var3.script_team = "axis";
  var3.script_unload = "1";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-23808.2, 14665.6, 56), undefined, "lay_heli_spawn", undefined, "default", "1 2", "3", undefined, undefined, 512, 2000, 40);
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-23838, 14664, 952), undefined, undefined, undefined, undefined, undefined, "2", undefined, undefined, undefined, undefined, undefined);
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-24325.2, 20512, 549.27), undefined, "heli_spawner", undefined, undefined, "4", "6", undefined, undefined, 512, 2000, undefined);
  var3 = spawnStruct();
  var3.script_demeanor = "casual_gun";
  var3.script_function = "lbravo_carrier";
  var3.script_team = "axis";
  var3.script_unload = "1";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-24334.4, 16008.2, 56), (0, 270, 0), "lay_heli_spawn", undefined, "default", "6 5", "4", undefined, undefined, 512, 2000, 40);
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-24334, 16040, 952), undefined, undefined, undefined, undefined, undefined, "5", undefined, undefined, undefined, undefined, undefined);
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-20101.2, 20440, 549.27), undefined, "heli_spawner", undefined, undefined, "9", "7", undefined, undefined, 512, 2000, undefined);
  var3 = spawnStruct();
  var3.script_demeanor = "casual_gun";
  var3.script_function = "lbravo_carrier";
  var3.script_team = "axis";
  var3.script_unload = "1";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-20454.4, 15856.2, 56), (0, 270, 0), "lay_heli_spawn", undefined, "default", "7 8", "9", undefined, undefined, 512, 2000, 40);
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (-20454, 15888, 952), undefined, undefined, undefined, undefined, undefined, "8", undefined, undefined, undefined, undefined, undefined);
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (0, 0, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}