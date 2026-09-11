/*****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer_cs.gsc
*****************************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_safehouse_armsdealer_cs")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_safehouse_armsdealer_cs");
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

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "cp_donetsk_safehouse_armsdealer_cs");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_safehouse_armsdealer_cs");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_donetsk_safehouse_armsdealer_cs");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18360.7, 1475.66, -137.77), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18410, 1542.62, -138.89), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18325.6, 1527.95, -139.84), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-19013.2, 2356.2, -299), undefined, undefined, undefined, "armsdealer_spawn_atv", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18821.9, 2332.02, -319), undefined, undefined, undefined, "armsdealer_spawn_atv", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18135.5, 1263.09, -104.43), (0, 124.73, 0), "armsdealer_safehouse_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18888.7, 8375.32, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18888.6, 8312.23, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18823.6, 8375.35, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18906.5, 8405.77, -223.51), (0, 270, 0), "armsdealer_safehouse_return_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18824.5, 8311.87, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-19045.6, 8319.36, -222.48), (0, 330, 0), "armsdealer_return_silencer_interaction", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18355, 1611.21, -139.26), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.angles = (0, 0, 0);
  var_3.model = "cnd_paper_cia_01";
  var_3.origin = (-18455.8, 1483.51, -116.91);
  var_3.targetname = "mission_select_armsdealer";
  var_3.classname = "script_model";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 0, 0);
  var_3.model = "com_office_book_beige_paper_folder";
  var_3.origin = (-18455.6, 1486.89, -117.53);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 0, 0);
  var_3.model = "cnd_paper_cia_01";
  var_3.origin = (-18935.8, 8224.71, -222.08);
  var_3.targetname = "mission_select_armsdealer_return";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 0, 0);
  var_3.model = "com_office_book_beige_paper_folder";
  var_3.origin = (-18935.6, 8228.1, -222.71);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}