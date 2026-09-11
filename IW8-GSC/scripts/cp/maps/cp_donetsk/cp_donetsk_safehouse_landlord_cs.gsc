/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_landlord_cs.gsc
***************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_donetsk_safehouse_landlord_cs")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_donetsk_safehouse_landlord_cs");
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

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "cp_donetsk_safehouse_landlord_cs");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_safehouse_landlord_cs");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_donetsk_safehouse_landlord_cs");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16358.6, -4457.42, 1616), undefined, "landlord_safehouse_player_start", undefined, "landlord_safehouse_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16359.8, -4325.35, 1616), (0, 360, 0), "landlord_safehouse_player_start", undefined, "landlord_safehouse_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16437.3, -4270.75, 1616), (0, 360, 0), "landlord_safehouse_player_start", undefined, "landlord_safehouse_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16440.3, -4418.11, 1616), undefined, "landlord_safehouse_player_start", undefined, "landlord_safehouse_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16455.8, -3052.46, -476), (0, 134.46, 0), undefined, undefined, "landlord_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16736, -3317.91, -496), (0, 133.98, 0), undefined, undefined, "landlord_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16426.8, -4557.43, -1197.65), undefined, "landlord_safehouse_loadout_change", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19480, 3392, -479.44), (0, 45, 0), "landlord_safehouse_regroup_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19448, 3408, -480.9), (0, 45, 0), "landlord_safehouse_regroup_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19512, 3352, -480.63), (0, 45, 0), "landlord_safehouse_regroup_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19552, 3320, -479.76), (0, 45, 0), "landlord_safehouse_regroup_player_start", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (15663.7, -460.3, -504), (0, 314.46, 0), undefined, undefined, "landlord_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16304, -4232, 1652), undefined, "landlord_safehouse_loadout", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (15535.6, -583.28, -504), (0, 314.46, 0), undefined, undefined, "landlord_atv_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "50";
  var4.script_decel = "50";
  var0[[var3]](var4, var1, var2, (47150.4, 23041.7, 845.5), (0, 249, 0), "lbravoAlphaAdvancedPath", "auto3194", undefined, undefined, undefined, undefined, undefined, undefined, 90, 1);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_delete = "1";
  var0[[var3]](var4, var1, var2, (28911.4, -18908.9, 1619), (0, 314.99, 0), "auto3208", undefined, undefined, undefined, undefined, undefined, undefined, 200, 100, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (41594.2, 11046.8, 943), (0, 238, 0), "auto3172", "auto3173", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (39941.1, 8584.2, 921), (0, 237, 0), "auto3173", "auto3182", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (36867.5, 4526.2, 641), (0, 233, 0), "auto3182", "auto3209", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "40";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (20925, -4841.2, 498), (0, 173.99, 0), "auto3185", "auto3214", undefined, undefined, undefined, undefined, undefined, 400, 50, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (44889.3, 18339.6, 769), (0, 236, 0), "auto3194", "auto3216", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (16745.3, -3054.23, -492), (0, 142, 0), "auto3195", "auto3202", undefined, undefined, undefined, undefined, undefined, 200, 20, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (16451.5, -2748.47, 189.5), (0, 130.99, 0), "auto3202", "auto3204", undefined, undefined, undefined, undefined, undefined, 200, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (17895.6, -4286.8, 39), (0, 130.99, 0), "auto3188", "auto3195", undefined, undefined, undefined, undefined, undefined, 150, 20, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var0[[var3]](var4, var1, var2, (15175.3, -2862.26, 895), (0, 179.99, 0), "auto3204", "auto3206", undefined, undefined, undefined, undefined, undefined, 200, 100, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var0[[var3]](var4, var1, var2, (15893.2, -7581.9, 1739), (0, 304.99, 0), "auto3206", "auto3208", undefined, undefined, undefined, undefined, undefined, 200, 100, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.modelscale = "0.990799";
  var4.name = "alpha";
  var4.script_team = "allies";
  var0[[var3]](var4, var1, var2, (16690.1, -2996.62, -492), (0, 135, 0), "cp_infil", "auto3207", "infil_lbravo", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16747.2, -3054.26, -492), (0, 135, 0), "auto3207", "lbravoAlphaAdvancedPath", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (34252.6, -70.9, 429), (0, 221.85, 0), "auto3209", "auto3212", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (24824.9, -3562.8, 541), (0, 163.38, 0), "auto3211", "auto3185", undefined, undefined, undefined, undefined, undefined, 500, 55, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (27547.3, -3400.9, 425), (0, 157.26, 0), "auto3212", "auto3211", undefined, undefined, undefined, undefined, undefined, 400, 70, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "40";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (19854.4, -5119.3, 482), (0, 154.99, 0), "auto3214", "auto3188", undefined, undefined, undefined, undefined, undefined, 150, 40, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.ishelistruct = 1;
  var4.lookahead = "1";
  var4.script_accel = "20";
  var4.script_decel = "20";
  var4.script_goalyaw = "true";
  var0[[var3]](var4, var1, var2, (43228.7, 14685, 841), (0, 248, 0), "auto3216", "auto3172", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (23495.5, 8243.25, -424.56), (0, 15, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (26900.5, 9325, -415), (0, 2.16, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (23159.5, 8123.25, -424.82), (0, 15, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19461.5, 7521.25, -424.82), (0, 341, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (19171.5, 7633.25, -424.82), (0, 323, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (18372, 6443, -209), (0, 341, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (18314.5, 6313, -204.5), (0, 321.87, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (17786.3, 9212.59, -357.99), (0, 5.5, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (17476, 9194.25, -307.81), (0, 347.5, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (31029.5, 6043.25, -635.85), (0, 137, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (33969.5, 2251.25, -766.89), (0, 133, 0), "overwatch_atv_spawner_early", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16590.5, -4424.04, -1232), undefined, undefined, undefined, "landlord_safehouse", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 134, 0);
  var3.origin = (15990.5, -4093.55, 408);
  var3.targetname = "landlord_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 90, 0);
  var3.origin = (15986.5, -4068.3, 408);
  var3.targetname = "landlord_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 38, 0);
  var3.origin = (15992.5, -4121.5, 429.5);
  var3.targetname = "landlord_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 86, 0);
  var3.model = "container_ammo_box_01_nophysics";
  var3.origin = (15988.2, -4149.78, 429.5);
  var3.targetname = "landlord_safehouse_loot";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 205.14, 0);
  var3.origin = (16405, -5254.11, 808);
  var3.targetname = "landlord_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 106.59, 0);
  var3.origin = (16320.4, -5253.4, 808);
  var3.targetname = "landlord_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var3 = spawnStruct();
  var3.classname = "script_model";
  var3.angles = (0, 171.86, 0);
  var3.origin = (16362.6, -5259.13, 808);
  var3.targetname = "landlord_safehouse_loot";
  var3.model = "container_ammo_box_01_nophysics";
  var0 scripts\cp\cp_create_script_utility::strike_additem(var3, var1, var2);
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}