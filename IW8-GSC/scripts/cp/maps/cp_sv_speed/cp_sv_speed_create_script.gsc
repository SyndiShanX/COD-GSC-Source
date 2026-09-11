/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_speed\cp_sv_speed_create_script.gsc
*********************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_speed_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_speed_create_script");
  var_2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var_0, var_1, var_2);

  if(!scripts\cp\so_trigger::cs_is_starttime()) {
    scripts\cp\so_trigger::endcreatescript(var_2);
    return;
  }
}

function cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1)) {
    var_1 = "stk";
  }

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "cp_sv_speed_create_script");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "cp_sv_speed_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var_2, "cp_sv_speed_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1215.96, -3045.33, 60.85), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1875.33, 275.8, 2056), (0, 314, 0), "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1250.65, 2893.29, 2056), (0, 314, 0), "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-199.53, 1058.01, 2056), (0, 314, 0), "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (335.5, 3470, 2056), (0, 314, 0), "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2540, -21724, 2592), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-24668, -3696, 3132), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1288.54, -289.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "8", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "mindia8";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-1016.02, 479.84, 139.5), (2.56, 11.79, 0.62), "wave_veh_spawners", undefined, "default", "1 3 4 5 6 7 8", "2", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3806.66, -4407.82, 1105.08), (1, 0, 0), "heli_spawner", undefined, undefined, "2", "1", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1288.54, -777.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "7", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2885.04, -3556.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "3", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1374.04, -1261.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "6", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1523.04, -1739.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "5", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1916.04, -2387.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "4", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2577.51, 4632.55, 195.48), (0, 125, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2866.57, 5542.47, 58.55), (0, 170, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4767.78, -747.32, 194.66), (0, 310, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (120.53, 5919.25, 35.5), (0, 235, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2842.82, 1523.91, 185.27), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4641.59, 2122.76, 282.82), (0, 90, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3320.09, -2680.73, 236.25), (0, 280, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (202.25, 98.3, 1228.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "32", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-759.63, 510.73, 80), (2.56, 199.46, 0.62), "wave_veh_spawners", undefined, "default", "25 27 28 29 30 31 32", "26", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1560.75, -4876.12, 1101.08), (0, 316, 0), "heli_spawner", undefined, undefined, "26", "25", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (582.97, -273.29, 1402.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "31", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2263.75, -3775.52, 1680.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "27", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1242.33, -969.59, 1582.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "30", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1526.66, -1406.57, 1642.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "29", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1995.55, -2219.36, 1654.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "28", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1074.49, 2826.35, 1193.82), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "58", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-204.34, 3073.48, 148), (2.61, 156.77, -0.34), "wave_veh_spawners", undefined, "default", "51 53 54 55 56 57 58", "52", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6173.29, 7800.11, 960), undefined, "heli_spawner", undefined, undefined, "52", "51", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1575.77, 2939.83, 1384.28), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "57", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23552, 7332, 2592), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2516, 24744, 3132), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5924.17, 6523.49, 1950.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "53", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2816.41, 3322.2, 1614.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "56", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4437.93, 4132.42, 1949.49), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "55", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5487.06, 5099.81, 1949.71), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "54", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-560.76, 3959.63, 1396.42), (0, 156, 0), undefined, undefined, undefined, undefined, "66", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "mindia8";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-795.98, 3207.16, 146), (2.56, 353.79, 0.62), "wave_veh_spawners", undefined, "default", "59 61 62 63 64 65 66", "60", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3307.2, 8488.76, 1360.08), (1, 156, -0), "heli_spawner", undefined, undefined, "60", "59", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-368.27, 4389.43, 1578.42), (0, 156, 0), undefined, undefined, undefined, undefined, "65", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1614.38, 7779.83, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "61", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-254.53, 4937.06, 1718.42), (0, 156, 0), undefined, undefined, undefined, undefined, "64", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-206.16, 5572.37, 1838.42), (0, 156, 0), undefined, undefined, undefined, undefined, "63", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-592.29, 6629.1, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "62", undefined, undefined, 512, 45, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}