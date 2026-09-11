/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_create_script.gsc
*************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_cave_pm_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_cave_pm_create_script");
  var2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var0, var1, var2);

  if(!scripts\cp\so_trigger::cs_is_starttime()) {
    scripts\cp\so_trigger::endcreatescript(var2);
    return;
  }
}

function cs_return_and_wait_for_flag(var0, var1, var2, var3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var3);

  if(!isDefined(var1)) {
    var1 = "stk";
  }

  var2 scripts\cp\so_trigger::strike_setup_arrays(var1, "cp_sv_cave_pm_create_script");
  scripts\cp\so_trigger::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var2, "cp_sv_cave_pm_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var2, "cp_sv_cave_pm_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\so_trigger::strike_additem;
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-17958.6, -3963.1, 2593.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-139.33, -1860.2, 2056), (0, 314, 0), "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1970.65, -138.71, 2056), (0, 314, 0), "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3152.47, 250, 2056), (0, 314, 0), "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3655.5, 2790, 2056), (0, 314, 0), "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1957.36, -2976.24, -491.63), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2585.71, -646.98, 713.4), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1392.63, 1233.58, 823.58), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (828.59, 1943.62, 1148.71), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1888.26, 1329.27, 932.51), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (6511.24, 1150.27, 384.31), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2398.65, -2458.08, -468.83), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3881.81, -1602.27, -215.62), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-215.4, -4236.39, -423), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2452.79, 3361.89, 1327.88), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2619.43, -1408.38, 1064.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "32", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (-1758.98, -1382.84, 98), (2.56, 3.46, 0.62), "wave_veh_spawners", undefined, "default", "25 27 28 29 30 31 32", "26", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-7775.16, 206.6, 1511.08), (0, 184, 0), "heli_spawner", undefined, undefined, "26", "25", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3156.33, -1416.68, 1238.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "31", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-6921.66, -474.27, 1516.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "27", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-4122.97, -1438.75, 1418.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "30", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-4631.97, -1357.65, 1478.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "29", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-5587.74, -1200.24, 1490.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "28", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-159.07, -581.1, 960.18), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "40", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (-382.98, -1316.84, 44), (359.3, 255.43, 2.54), "wave_veh_spawners", undefined, "default", "33 35 36 37 38 39 40", "34", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (936.64, 6297.35, 3142.81), (3.28, 15.88, -1.9), "heli_spawner", undefined, undefined, "34", "33", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (59.82, 71.65, 1104.05), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "39", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1581.49, 5173.7, 3147.79), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "35", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (638.02, 1374.48, 1785.84), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "38", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1062.97, 2478.69, 2470.79), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "37", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1542.11, 3795.87, 3088.17), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "36", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1318.43, -89.12, 1040.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "48", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (969.02, -860.84, 170), (2.56, 245.46, 0.62), "wave_veh_spawners", undefined, "default", "41 43 44 45 46 47 48", "42", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1324.87, 6666.92, 3093.08), (0, 66, 0), "heli_spawner", undefined, undefined, "42", "41", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1499.16, 260.83, 1214.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "47", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2498.99, 3526.98, 3092.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "43", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1805.49, 868.69, 1714.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "46", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2148.06, 1664.03, 2382.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "45", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2511.76, 2850.02, 3034.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "44", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4858.11, 2692.63, 1106.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "56", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (3371.02, 2555.16, 132), (2.56, 180.45, 0.62), "wave_veh_spawners", undefined, "default", "49 51 52 53 54 55 56 57 58", "50", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (8755.89, 8028.01, 2543.08), (0, 0.99, 0), "heli_spawner", undefined, undefined, "50", "49", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5315.65, 2852.73, 1296.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "55", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (7994.33, 6094.9, 2542.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "51", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (6052.01, 3287.99, 1708.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "54", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (6741.61, 3873.64, 2088.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "53", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (7450.19, 4901.23, 2484.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "52", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4578.11, 2612.63, 1002.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "57", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4346.11, 2556.63, 866.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "58", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3118.08, -1457.97, 1330.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "66", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_type = "lbravo_carrier";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (-1596.98, 95.16, 364), (2.56, 57.46, 0.62), "wave_veh_spawners", undefined, "default", "59 61 62 63 64 65 66 67 68", "60", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-7695.09, 442.23, 1777.08), (0, 238, 0), "heli_spawner", undefined, undefined, "60", "59", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3850.95, -1799.21, 1504.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "65", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-7466.58, -315.49, 1782.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "61", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-4905.27, -1686.21, 1684.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "64", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-6004.06, -1384.33, 1744.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "63", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-6771.2, -921.04, 1756.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "62", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2790.08, -1335.97, 1272.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "67", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2424.08, -939.97, 1194.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "68", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3585.86, 158.44, -241.71), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-16678.6, -1659.1, 3361.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4499.34, 3391.8, 294.83), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (19873.4, 9344.9, 4009.71), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5321.03, 410.66, -69.67), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23839.9, 2099.41, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (23129.4, 6124.9, 4009.71), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}