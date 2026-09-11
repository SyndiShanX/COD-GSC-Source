/******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler\cp_smuggler_safehouse_createscript.gsc
******************************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_smuggler_safehouse_createscript")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_smuggler_safehouse_createscript");
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

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "cp_smuggler_safehouse_createscript");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_smuggler_safehouse_createscript");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_smuggler_safehouse_createscript");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22523.5, 29032, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22472, 29032, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22482, 29096, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22526, 29096, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22463, 29257, 1264.25), (0, 270, 0), "smuggler_safehouse_2_regroup_pos", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22466, 29131, 1134.38), (0, 270, 0), "smuggler_safehouse_2_edit_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 90, 0);
  var_3.origin = (22432.8, 29376.2, 1217.38);
  var_3.targetname = "smuggler_safehouse_2_loot";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 345, 0);
  var_3.origin = (22408.8, 29397.5, 1217.38);
  var_3.targetname = "smuggler_safehouse_2_loot";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 90, 0);
  var_3.origin = (22443.3, 29346.3, 1217.38);
  var_3.targetname = "smuggler_safehouse_2_loot";
  var_3.model = "container_ammo_box_01_nophysics";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "script_model";
  var_3.angles = (0, 135, 0);
  var_3.model = "container_ammo_box_01_nophysics";
  var_3.origin = (22427, 29313, 1217.38);
  var_3.targetname = "smuggler_safehouse_2_loot";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}