/****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_suburbs11_cs.gsc
****************************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_safehouse_suburbs11_cs")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_safehouse_suburbs11_cs");
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

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "cp_donetsk_safehouse_suburbs11_cs");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_safehouse_suburbs11_cs");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_safehouse_suburbs11_cs");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3863.61, 33462.9, 222.5), (0, 330, 0), "safehouse_s11_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3814.44, 33436.3, 222.5), (0, 330, 0), "safehouse_s11_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3834.17, 33513.1, 222.46), (0, 330, 0), "safehouse_s11_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3783.77, 33488.3, 222), (0, 330, 0), "safehouse_s11_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3685.42, 33355.2, 222), (0, 150, 0), "safehouse_s11_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1357.5, 28893, -168.67), (0, 163.79, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1888.5, 27905, 21.49), (0, 325.93, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8805.25, 33836, 21.35), (0, 114.89, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4960.5, 28613, 204.11), (0, 130.93, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5578.25, 31154.3, 412.11), (0, 333.76, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (8296.5, 31169, 1536.22), (0, 85.92, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6988.5, 26789, 521.25), (0, 25.92, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5011, 25976.5, 4.69), (0, 319.28, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6143.75, 24405.5, -9.5), (0, 319.28, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3664, 33426, 251), (0, 60, 0), "smuggler_safehouse1_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2352.5, 31737, 238.01), (0, 341.92, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4927.5, 30899.3, 392.2), (0, 291.79, 0), "smuggler_tacrover_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2509.5, 29937, -97.78), (0, 343.79, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3544.5, 34025, 206.71), (0, 219.79, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3484.5, 33989, 206.71), (0, 223.79, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3436.5, 33929, 206.71), (0, 229.79, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3364.5, 33869, 206.71), (0, 249.79, 0), "smuggler_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}