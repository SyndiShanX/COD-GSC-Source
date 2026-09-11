/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_backlot\cp_sv_backlot_create_script.gsc
*************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_backlot_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_backlot_create_script");
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

  var2 scripts\cp\so_trigger::strike_setup_arrays(var1, "cp_sv_backlot_create_script");
  scripts\cp\so_trigger::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var2, "cp_sv_backlot_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var2, "cp_sv_backlot_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\so_trigger::strike_additem;
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-8103, 434, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2341.43, 2388.23, 196.7), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-923, -2339, 2048), (0, 314, 0), "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1072, 2014, 2048), (0, 314, 0), "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1455, -1985, 2048), (0, 314, 0), "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1744, 1460, 2048), (0, 314, 0), "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-721.62, 3220.61, 1202.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "63", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1343.25, -885.93, 1200.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "76", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (-488.16, 1829.52, 180), (2.56, 270.45, 0.62), "wave_veh_spawners", undefined, "default", "53 55 56 57 58 59 60 61 62 63 64 65", "54", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-5912.99, 7972.41, 224), (0, 90.99, 0), "heli_spawner", undefined, undefined, "54", "53", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-913.73, 3678.15, 1432.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "62", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2179.89, 5156.83, 2014.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "58", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1156.99, 4094.51, 1628.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "61", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1454.63, 4496.11, 1824.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "60", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1810.23, 4852.69, 2012.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "59", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-577.63, 2780.61, 1050.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "64", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-7079, -1614, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-6311, -3406, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-4663, -5576, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2215, -6990, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (857, -6734, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3417, -6478, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5465, -5198, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (7257, -3406, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (8025, -334, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (8281, 2482, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (8025, 5554, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5977, 8114, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2649, 8882, 1736), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-935, 9138, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3495, 8370, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-5543, 7090, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-7079, 5042, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-8615, 2482, 2048), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-489.63, 2324.61, 914.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "65", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2787.89, 5668.84, 2014.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "57", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3715.89, 6340.84, 2014.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "56", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-4771.89, 7012.85, 2014.42), (0, 180.66, 0), undefined, undefined, undefined, undefined, "55", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (47.84, -652.48, 178), (2.56, 0.45, 0.62), "wave_veh_spawners", undefined, "default", "66 68 69 70 71 72 73 74 75 76 77 78", "67", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-5421.09, -6749.28, 222), (0, 180.99, 0), "heli_spawner", undefined, undefined, "67", "66", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1738.8, -1170.04, 1430.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "75", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2875.49, -2712.19, 2012.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "71", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2089.16, -1521.3, 1626.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "74", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2366.76, -1930.94, 1822.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "73", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2629.34, -2280.53, 2010.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "72", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-903.25, -741.94, 1048.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "77", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-447.25, -653.95, 912.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "78", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3375.5, -3398.19, 2012.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "70", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3965.51, -4292.19, 2012.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "69", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-4619.52, -5450.19, 2012.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "68", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1990.93, 214.98, 1194.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "37", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (599.84, -18.48, 172), (2.56, 180.45, 0.62), "wave_veh_spawners", undefined, "default", "27 29 30 31 32 33 34 35 36 37 38 39", "28", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (6742.73, 5406.35, 216), (0, 0.99, 0), "heli_spawner", undefined, undefined, "28", "27", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2448.47, 407.08, 1424.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "36", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3927.15, 1673.25, 2006.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "32", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2864.83, 650.35, 1620.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "35", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3266.43, 947.99, 1816.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "34", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3623.01, 1303.59, 2004.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "33", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1550.93, 70.99, 1042.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "38", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1094.93, -17.01, 906.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "39", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4439.16, 2281.25, 2006.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "31", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5111.16, 3209.25, 2006.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "30", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5783.16, 4265.25, 2006.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "29", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1359.6, 2131.23, 1191.14), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "50", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (1259.84, 717.52, 178), (2.29, 256.47, 1.3), "wave_veh_spawners", undefined, "default", "40 42 43 44 45 46 47 48 49 50 51 52", "41", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2515.6, 7991.42, 128.87), (0.28, 76.97, -0.68), "heli_spawner", undefined, undefined, "41", "40", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1281.64, 2623.35, 1416.72), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "49", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (405.34, 4368.89, 1976.72), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "45", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1144.44, 3087.66, 1607.87), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "48", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (950.9, 3550.82, 1798.45), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "47", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (690.32, 3984.27, 1980.54), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "46", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1394.3, 1668.35, 1042.9), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "51", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1370.64, 1203.63, 910.06), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "52", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-60.49, 5012.88, 1967.1), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "44", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-798.02, 5889.58, 1952.92), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "43", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1659.74, 6797.29, 1937.2), (0.68, 166.64, 0.27), undefined, undefined, undefined, undefined, "42", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (51.3, -3751.57, 1204.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "115", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (-182.16, -2360.48, 182), (2.56, 90.45, 0.62), "wave_veh_spawners", undefined, "default", "105 107 108 109 110 111 112 113 114 115 116 117", "106", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5242.67, -8503.38, 226), (0, 270.99, 0), "heli_spawner", undefined, undefined, "106", "105", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (243.4, -4209.11, 1434.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "114", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1509.57, -5687.79, 2016.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "110", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (486.67, -4625.47, 1630.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "113", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (784.31, -5027.07, 1826.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "112", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1139.91, -5383.65, 2014.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "111", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-92.69, -3311.57, 1052.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "116", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-180.69, -2855.57, 916.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "117", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2117.57, -6199.8, 2016.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "109", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3045.57, -6871.8, 2016.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "108", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4101.57, -7543.82, 2016.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "107", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1090.85, -3298.02, 1191.14), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "128", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (1337.84, -1902.48, 178), (2.29, 70.46, 1.3), "wave_veh_spawners", undefined, "default", "118 120 121 122 123 124 125 126 127 128 129 130", "119", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4332.25, -9531.18, 128.87), (0.28, 250.97, -0.68), "heli_spawner", undefined, undefined, "119", "118", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1116.94, -3795.59, 1416.72), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "127", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1805.98, -5623.17, 1976.72), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "123", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1204.86, -4271.7, 1607.87), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "126", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1348.92, -4752.55, 1798.45), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "125", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1562.76, -5210.87, 1980.54), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "124", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1104.73, -2834.05, 1042.9), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "129", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1176.83, -2374.34, 910.06), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "130", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2201.94, -6312.32, 1967.1), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "122", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2843.79, -7261.32, 1952.92), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "121", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3605.9, -8254.13, 1937.2), (0.68, 340.64, 0.27), undefined, undefined, undefined, undefined, "120", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2146.6, 2690.82, 194), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2705.87, -5.63, 202), (0, 270, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3136.04, -2275.65, 194), (0, 270, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1497.91, -3737.45, 202), (0, 270, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1041.75, -4269.97, 202), (0, 90, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1442.22, -2077.83, 192.06), (0, 180, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (20.87, 3838.43, 479), (0, 270, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}