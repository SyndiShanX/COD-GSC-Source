/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_piccadilly\cp_piccadilly_create_script.gsc
*************************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_piccadilly_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_piccadilly_create_script");
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

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "cp_piccadilly_create_script");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "cp_piccadilly_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var_2, "cp_piccadilly_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (685.24, -3298.7, 1533.74), (1, 148, -0), "heli_spawner", undefined, undefined, "16", "13", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5120, 6144, 3072), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (329.3, -2742.35, 1593.83), (1, 88, 0), undefined, undefined, undefined, undefined, "14", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-19.19, -2197.52, 1564.03), (359.17, 145.69, 0.56), undefined, undefined, undefined, undefined, "15", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4352, 4608, 3072), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "true";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-2393.78, 525.22, 260), (0.87, 43.2, 0.49), "wave_veh_spawners", undefined, "default", "1 2 3 4 5", "6", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-13568, -256, 3072), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (0, -9984, 3072), (0, 262.2, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6656, -1024, 3072), (0, 262.2, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-12288, -9216, 3072), (0, 262.2, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "true";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (8.6, -394.74, 219.41), (0.74, 323.99, -0.67), "wave_veh_spawners", undefined, "default", "20 22 23 24 25 26", "21", undefined, undefined, 1024, 20, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "true";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (2047.4, -1607.6, 212.19), (1, 228, -0), "wave_veh_spawners", undefined, "default", "7 8 9 10 11", "12", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7717.01, 5407, 1254.95), (1, 278, 0), "heli_spawner", undefined, undefined, "6", "1", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "true";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (1878.96, 887.45, 258.01), (0.83, 214, 0.56), "wave_veh_spawners", undefined, "default", "17 18 29 30 31 32", "19", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6991.25, 3422.89, 1158.95), (1, 296, -0), undefined, undefined, undefined, undefined, "2", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "true";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-1846.67, -1500.02, 192.64), (1, 176, -0), "wave_veh_spawners", undefined, "default", "13 14 15 27 28", "16", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3977.2, 829.91, 1145), (1, 344, 0), undefined, undefined, undefined, undefined, "3", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3264.97, 525.45, 1147), (0.95, 350.4, 0.31), undefined, undefined, undefined, undefined, "4", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-580.48, -5901.85, 1107), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (-2704.47, 471.65, 712), (0.09, 24.7, 0.99), undefined, undefined, undefined, undefined, "5", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3014.48, -6261.85, 1275), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (1896.3, 4081.46, 1658.24), (1, 260, -0), "heli_spawner", undefined, undefined, "19", "17", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (2215.38, 3131.89, 1621.18), (1, 214, -0), undefined, undefined, undefined, undefined, "18", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-350.48, -2387.85, 1327), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1337.1, -5424.1, 1385.34), (0.64, 50.1, 0.77), "heli_spawner", undefined, undefined, "12", "7", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2640.8, -3625.7, 1113.17), (0.01, 93.2, 1), undefined, undefined, undefined, undefined, "8", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2626.4, -2853.3, 829.78), (359.54, 97.19, 0.89), undefined, undefined, undefined, undefined, "9", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2496, -2085.4, 865.18), (1, 112.4, 0), undefined, undefined, undefined, undefined, "10", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (1989.1, -1519.8, 780.18), (1, 206.6, 0), undefined, undefined, undefined, undefined, "11", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3195.52, -3041.85, 1252), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (-2584.9, 4354.4, 1305.54), (1, 258.9, -0), "heli_spawner", undefined, undefined, "21", "20", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2740.6, 1807.23, 1775.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "23", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4352, -11008, 3072), (0, 262.2, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3010.57, 300.63, 1422), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1461.05, -470.44, 1176), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (287.05, 1231.34, 800), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2977.92, -420.01, 1328), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2658.86, -2987.42, 1280), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2741.83, -4124.87, 1001.48), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3153.76, -1923.16, 1130), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5577.75, 141.96, 1528), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6457.88, -2112.42, 1296), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2647.06, -8039.41, 1387.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (42.16, -7745.1, 1232.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-620.25, -4189.54, 1048.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2081.33, -4385.16, 1112.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1741.78, -2903.44, 1316.36), (0, 90, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2888.04, -1229.23, 1215.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (177.31, 257.3, 1137.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2413.71, 1650.34, 1483.81), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5038.42, 2999.46, 1259.81), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2109.13, 3249.36, 1544), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1693.81, 1403.05, 1104), (0, 285, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3571.79, 2788.07, 1061), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (265.46, 3036.71, 1254.5), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4047.18, 690.27, 1648.5), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4680.55, 1151.56, 1392), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1990, 680, 2056), undefined, "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1850, 936, 2056), undefined, "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (570, -1368, 2056), undefined, "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1734, -2648, 2056), undefined, "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2774.6, 2783.23, 1773.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "22", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-698.6, -56.77, 1367.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "26", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2414.6, 899.23, 1765.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "24", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1566.6, 397.23, 1573.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "25", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-211.19, -1775.52, 1548.03), (359.17, 145.69, 0.56), undefined, undefined, undefined, undefined, "27", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-381.19, -1541.52, 1528.03), (359.17, 145.69, 0.56), undefined, undefined, undefined, undefined, "28", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (2440.92, 1235.36, 1160.38), (1.15, 192, -0.35), undefined, undefined, undefined, undefined, "32", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (2345.38, 2665.89, 1553.18), (1, 214, -0), undefined, undefined, undefined, undefined, "29", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (2381.38, 2177.89, 1413.18), (1, 214, -0), undefined, undefined, undefined, undefined, "30", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "true";
  var_0[[var_3]](var_4, var_1, var_2, (2435.38, 1719.89, 1271.18), (1, 214, -0), undefined, undefined, undefined, undefined, "31", undefined, undefined, 512, 20, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.is_cs_trigger = 1;
  var_3.height = 210;
  var_3.origin = (524, -1452, -104);
  var_3.radius = 256;
  var_3.targetname = "survival_out_bounds";
  var_0 scripts\cp\so_trigger::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.is_cs_trigger = 1;
  var_3.height = 210;
  var_3.origin = (380, -1432, -104);
  var_3.radius = 96;
  var_3.targetname = "survival_out_bounds";
  var_0 scripts\cp\so_trigger::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.is_cs_trigger = 1;
  var_3.height = 128;
  var_3.origin = (-1848, -52, -16);
  var_3.radius = 176.418;
  var_3.targetname = "survival_out_bounds";
  var_0 scripts\cp\so_trigger::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}