/******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler\cp_smuggler_safehouse_createscript.gsc
******************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_smuggler_safehouse_createscript")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_smuggler_safehouse_createscript");
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

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "cp_smuggler_safehouse_createscript");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_smuggler_safehouse_createscript");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_smuggler_safehouse_createscript");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (22523.5, 29032, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (22472, 29032, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (22482, 29096, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (22526, 29096, 1217.38), (0, 90, 0), "smuggler_safehouse_2_player_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (22463, 29257, 1264.25), (0, 270, 0), "smuggler_safehouse_2_regroup_pos", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (22466, 29131, 1134.38), (0, 270, 0), "smuggler_safehouse_2_edit_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 90, 0);
  var3.origin = (22432.8, 29376.2, 1217.38);
  var3.targetname = "smuggler_safehouse_2_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 345, 0);
  var3.origin = (22408.8, 29397.5, 1217.38);
  var3.targetname = "smuggler_safehouse_2_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 90, 0);
  var3.origin = (22443.3, 29346.3, 1217.38);
  var3.targetname = "smuggler_safehouse_2_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 135, 0);
  var3.model = "container_ammo_box_01_nophysics";
  var3.origin = (22427, 29313, 1217.38);
  var3.targetname = "smuggler_safehouse_2_loot";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}