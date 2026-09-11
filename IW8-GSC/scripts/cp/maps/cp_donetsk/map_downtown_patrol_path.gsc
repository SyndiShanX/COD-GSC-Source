/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\map_downtown_patrol_path.gsc
*******************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");
  var_2 = spawnStruct();
  scripts\engine\utility::flag_init("map_downtown_patrol_path");
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

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "map_downtown_patrol_path");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "map_downtown_patrol_path");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "map_downtown_patrol_path");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (17424, -21871.8, -164), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "1 3", "2");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (19880, -19231.8, -112.01), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "2 4", "3");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22528, -22103.9, -113.33), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "3 1", "4");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (17600, -16903.8, -176), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "5 12", "6");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (17544.1, -12319.8, -265.9), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "6 7", "5");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (20135.9, -24695.8, -235.86), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "2 4", "1");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (20688.1, -9383.86, -354.17), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "5 8", "7");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (21032.1, -12647.8, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "7 9", "8");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22768.1, -12727.9, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "8 10", "9");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22776, -16359.9, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "9 11", "10");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (21344, -17711.9, -169.91), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "10 12", "11");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (19952, -19119.8, -112.03), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "11 6", "12");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (26320, -16575.9, -210), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "14 15", "13");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (26272, -18559.9, -223.02), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "13 16", "15");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22808, -22007.9, -114.8), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "15 17", "16");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (20040, -19207.8, -112), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "16 14", "17");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22856, -16375.9, -208), (0, 270, 0), "dwn_twn_patrol_structs", undefined, undefined, "13 17", "14");
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}