/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\map_downtown_patrol_path.gsc
*******************************************************************/

function main(var0, var1) {
  level endon("game_ended");
  var2 = spawnStruct();
  scripts\engine\utility::flag_init("map_downtown_patrol_path");
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

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "map_downtown_patrol_path");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "map_downtown_patrol_path");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "map_downtown_patrol_path");
}

function createstructs(var0, var1, var2) {
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (17424, -21871.8, -164), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "1 3", "2");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (19880, -19231.8, -112.01), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "2 4", "3");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (22528, -22103.9, -113.33), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "3 1", "4");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (17600, -16903.8, -176), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "5 12", "6");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (17544.1, -12319.8, -265.9), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "6 7", "5");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (20135.9, -24695.8, -235.86), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "2 4", "1");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (20688.1, -9383.86, -354.17), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "5 8", "7");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (21032.1, -12647.8, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "7 9", "8");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (22768.1, -12727.9, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "8 10", "9");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (22776, -16359.9, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "9 11", "10");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (21344, -17711.9, -169.91), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "10 12", "11");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (19952, -19119.8, -112.03), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "11 6", "12");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (26320, -16575.9, -210), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "14 15", "13");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (26272, -18559.9, -223.02), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "13 16", "15");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (22808, -22007.9, -114.8), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "15 17", "16");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (20040, -19207.8, -112), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "16 14", "17");
  var3 = spawnStruct();
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2, (22856, -16375.9, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "13 17", "14");
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}