/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\crate_drops\cp_crate_drops_cs.gsc
********************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_crate_drops_cs")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_crate_drops_cs");
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

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "cp_crate_drops_cs");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_crate_drops_cs");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_crate_drops_cs");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (33722.4, 2443.68, -774.13), (0, 90, 90), "crate_spawn", undefined, "stadium_3", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (30266.2, -2672.16, -823.87), (0, 90, 90), "crate_spawn", undefined, "stadium_4", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (27178.3, -1900.91, -728.69), (0, 90, 90), "crate_spawn", undefined, "stadium_5", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (24293.3, 8279.66, -446.88), (360, 327, 90), "crate_spawn", undefined, "stadium_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-20391.7, 15738.1, -62.88), (360, 327, 90), "crate_spawn", undefined, "hijack_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-17924.8, 21607.7, -449.75), (360, 327, 90), "crate_spawn", undefined, "hijack_2", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-27095.2, -6273.19, -14.53), (360, 327, 84.6), "crate_spawn", undefined, "hijack_3", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-26105.3, -9970.42, -38.81), (360, 90, 85.9), "crate_spawn", undefined, "hijack_4", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-10961.7, 1267.69, -318.88), (360, 327, 90), "crate_spawn", undefined, "apc_escort_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11174.5, 6604.94, -398.88), (360, 327, 90), "crate_spawn", undefined, "apc_escort_2", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-13940.3, 10607.7, -399), (360, 327, 90), "crate_spawn", undefined, "apc_escort_3", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-23108.3, 3372.55, -312.88), (360, 327, 90), "crate_spawn", undefined, "morales_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2018.8, 45793.4, 1404.53), (360, 327, 90), "crate_spawn", undefined, "milbase_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1659.41, 48980.2, 1136.78), (360, 327, 90), "crate_spawn", undefined, "milbase_2", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5538.43, 46126.4, 1128.45), (360, 327, 90), "crate_spawn", undefined, "milbase_5", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6792.52, 46996.8, 1029), (360, 327, 90), "crate_spawn", undefined, "milbase_3", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6020.94, 49549.2, 1033), (360, 327, 90), "crate_spawn", undefined, "milbase_4", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (534.1, 30310.2, -67.6), (360, 327, 90), "crate_spawn", undefined, "cache_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5356.95, 30635.6, 353.41), (360, 327, 90), "crate_spawn", undefined, "cache_2b", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4552.3, 31312.1, 395.56), (360, 327, 101.81), "crate_spawn", undefined, "cache_2a", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (32517.4, 37053.1, 739.9), (0, 327, 99.7), "crate_spawn", undefined, "quarry_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (32384.7, 42457, 720.78), (0, 90, 90), "crate_spawn", undefined, "quarry_2", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (31818.2, 6740.83, -629.53), (360, 90, 81.3), "crate_spawn", undefined, "stadium_2", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}