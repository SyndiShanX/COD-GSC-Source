/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_raid\cp_sv_raid_create_script.gsc
*******************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_raid_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_raid_create_script");
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

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "cp_sv_raid_create_script");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);
  thread createmodels(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_sv_raid_create_script");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "cp_sv_raid_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3513.76, -10018.7, 1027.24), (1, 0, 0), "heli_spawner", undefined, undefined, "5", "6", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2400.92, 3112.32, 446.31), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2502.2, -1212.7, 1621.67), undefined, undefined, undefined, undefined, undefined, "9", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3123.8, -5536.7, 2849.67), undefined, undefined, undefined, undefined, undefined, "10", undefined, undefined, 1028, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "lbravo_carrier";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-551.04, -151.24, 377.6), (359.77, 180, 0.17), "wave_veh_spawners", undefined, "default", "lz_334::2911 lz_334::2912 lz_334::2913", "lz_334", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "lbravo_carrier";
  var_4.script_unload = "default";
  var_4.ref_12f92 = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-2655.53, 1353.98, 377.63), (0, 95, 0), "wave_veh_spawners", undefined, "default", "6 7 9", "5", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-157.68, 1423.95, 407.64), (1.75, 180, 0.01), "wave_veh_spawners", undefined, "default", "lz_215::2021 lz_215::2022", "lz_215", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "lbravo_carrier";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-1181.64, 2439.22, 373.24), (359.26, 53.99, 0.45), "wave_veh_spawners", undefined, "default", "lz_172::1684 lz_172::1685 lz_172::1686 lz_172::1687 lz_172::1688", "lz_184", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "lbravo_carrier";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (702.98, -428.16, 369.9), (2.56, 143.01, 0.62), "wave_veh_spawners", undefined, "default", "1 3 4 10 11", "2", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3600.84, -9514.82, 298.08), (1, 0, 0), "heli_spawner", undefined, undefined, "2", "1", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3484.46, -7219.7, 2902.42), (1, 0, 0), undefined, undefined, undefined, undefined, "4", undefined, undefined, 1028, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3572.46, -9049.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "3", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8255.01, 2575, 1742.45), (1, 0, 0), "heli_spawner", undefined, undefined, "lz_184", "lz_172::1684", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3392.75, 1494.85, 430.38), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6287.25, 2178.89, 2894.45), (1, 0, 0), undefined, undefined, undefined, undefined, "lz_172::1685", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8261.13, -7296.14, 2327.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5600.2, 1775.91, 2895.5), (1, 0, 0), undefined, undefined, undefined, undefined, "lz_172::1686", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4660.97, 1652.45, 2895.5), (1, 0, 0), undefined, undefined, undefined, undefined, "lz_172::1687", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-9669.13, -5152.14, 2345.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_goalyaw = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-4191.47, 1439.65, 2435.5), (0, 20, 0), undefined, undefined, undefined, undefined, "lz_172::1688", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-10981.1, -2176.14, 2345.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (12017.8, -174.6, 692.06), (1, 180, -0), "heli_spawner", undefined, undefined, "lz_215", "lz_215::2021", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5706.38, 1782.89, 3094.68), (1, 180, -0), undefined, undefined, undefined, undefined, "lz_215::2022", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11013.1, 1631.86, 2385.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2481.16, -1147.49, 382.14), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3408.2, -6608.7, 2951.67), undefined, undefined, undefined, undefined, undefined, "7", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-9637.1, 5311.86, 2367.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7973.1, 8959.86, 2261.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5669.1, 10911.9, 2205.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2341.1, 12607.9, 2077.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (8981.47, 4380.8, 696.06), (1, 0, 0), "heli_spawner", undefined, undefined, "lz_334", "lz_334::2911", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7716.4, 3706.23, 2483.16), (1, 0, 0), undefined, undefined, undefined, undefined, "lz_334::2912", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1316.8, 139.73, 2326.09), (1, 0, 0), undefined, undefined, undefined, undefined, "lz_334::2913", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3706.9, 11295.9, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2719.8, -3362.7, 1941.67), undefined, undefined, undefined, undefined, undefined, "11", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6397.13, -10572.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (644.52, -3402.94, 411.9), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "lbravo_carrier";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-1084.74, 4154.4, 383.38), (2.56, 269.02, 0.62), "wave_veh_spawners", undefined, "default", "12 14 15 16", "13", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1929.9, 13952.9, 917.84), undefined, "heli_spawner", undefined, undefined, "13", "12", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1902.2, 12691.3, 2849.67), undefined, undefined, undefined, undefined, undefined, "14", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1368.2, 8631.3, 2601.67), undefined, undefined, undefined, undefined, undefined, "15", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_goalyaw = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-1250.2, 6693.3, 2025.67), (0, 272, 0), undefined, undefined, undefined, undefined, "16", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (12906.9, 10009.9, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16142.9, 6329.9, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (17020.9, 115.9, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (15720.9, -5752.1, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (12298.9, -9250.1, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6602.9, -11544.1, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (64.9, -12214.1, 1929.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "lbravo_carrier";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-101.26, 4073.6, 395.38), (358.22, 319.03, -1.95), "wave_veh_spawners", undefined, "default", "17 19 20 21 22", "18", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8101.81, 10202.1, 976), undefined, "heli_spawner", undefined, undefined, "18", "17", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7446.2, 9305.3, 2849.67), undefined, undefined, undefined, undefined, undefined, "19", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3316.2, 6425.3, 2475.67), undefined, undefined, undefined, undefined, undefined, "21", undefined, undefined, 1028, 750, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_goalyaw = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-1726.2, 5291.3, 2073.67), (0, 324, 0), undefined, undefined, undefined, undefined, "22", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5156.2, 7827.3, 2849.67), undefined, undefined, undefined, undefined, undefined, "20", undefined, undefined, 1028, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3575.12, 349.5, 823.94), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3707.46, 2065.67, 1792), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5970.81, 1875.27, 1992), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3514.47, 5241.45, 431.13), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6349.79, 5426.6, 448), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4575.17, 7040.46, 448), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-719.69, 6569.75, 447.56), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2336.17, 5241.53, 446.61), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (628.69, -862.38, 628.84), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (133.51, 97.09, 774), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1070.88, 956.72, 778.72), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-763.92, 1686.84, 1499.89), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2051.73, 1630.18, 796.17), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1829.78, 2893.07, 890.03), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2662.31, 2893.28, 798.14), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3106.09, 3620.54, 837.77), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (26.78, 3360.79, 784), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (650.5, 4126.6, 1164.75), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-642.69, 503.78, 779.84), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1327.48, -692.14, 802.24), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2408.8, -536.62, 734.14), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3432.71, -996.92, 1196), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6791.17, -1098.27, 433.72), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6600.13, 3693.35, 500.15), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10360.6, 2134.1, 390.33), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (9876.09, -2375.45, 419.03), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1255.39, -7163.99, 386.56), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4466.32, -5490.93, 415.03), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (826, -600, 2056), undefined, "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2502, -600, 2056), undefined, "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (570, 4008, 2056), undefined, "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1990, 4008, 2056), undefined, "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}