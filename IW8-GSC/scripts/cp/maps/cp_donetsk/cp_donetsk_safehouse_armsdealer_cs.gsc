/*****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer_cs.gsc
*****************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_safehouse_armsdealer_cs")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_safehouse_armsdealer_cs");
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

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "cp_donetsk_safehouse_armsdealer_cs");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_safehouse_armsdealer_cs");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_safehouse_armsdealer_cs");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18360.7, 1475.66, -137.77), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18410, 1542.62, -138.89), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18325.6, 1527.95, -139.84), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-19013.2, 2356.2, -299), undefined, undefined, undefined, "armsdealer_spawn_atv", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18821.9, 2332.02, -319), undefined, undefined, undefined, "armsdealer_spawn_atv", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18135.5, 1263.09, -104.43), (0, 124.73, 0), "armsdealer_safehouse_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18888.7, 8375.32, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18888.6, 8312.23, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18823.6, 8375.35, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18906.5, 8405.77, -223.51), (0, 270, 0), "armsdealer_safehouse_return_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18824.5, 8311.87, -256), (0, 180, 0), "armsdealer_safehouse_return_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-19045.6, 8319.36, -222.48), (0, 330, 0), "armsdealer_return_silencer_interaction", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18355, 1611.21, -139.26), (0, 180, 0), "armsdealer_safehouse_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var3 = spawnStruct();
  var3.angles = (0, 0, 0);
  var3.model = "cnd_paper_cia_01";
  var3.origin = (-18455.8, 1483.51, -116.91);
  var3.targetname = "mission_select_armsdealer";
  var3.classname = "script_model";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 0, 0);
  var3.model = "com_office_book_beige_paper_folder";
  var3.origin = (-18455.6, 1486.89, -117.53);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 0, 0);
  var3.model = "cnd_paper_cia_01";
  var3.origin = (-18935.8, 8224.71, -222.08);
  var3.targetname = "mission_select_armsdealer_return";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 0, 0);
  var3.model = "com_office_book_beige_paper_folder";
  var3.origin = (-18935.6, 8228.1, -222.71);
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}