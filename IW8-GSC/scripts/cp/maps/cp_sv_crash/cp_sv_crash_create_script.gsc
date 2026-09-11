/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_crash\cp_sv_crash_create_script.gsc
*********************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_crash_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_crash_create_script");
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

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "cp_sv_crash_create_script");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "cp_sv_crash_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var_2, "cp_sv_crash_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1626.96, -1741.78, 265), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-459.33, -1548.2, 2056), (0, 314, 0), "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1024.65, 2469.29, 2056), (0, 314, 0), "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1924.47, -1537.99, 2056), (0, 314, 0), "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1725.5, 1694, 2056), (0, 314, 0), "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1966.11, 2699.37, 1330.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "56", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-511.02, 2504.84, 356), (2.56, 0.45, 0.62), "wave_veh_spawners", undefined, "default", "49 51 52 53 54 55 56 57 58", "50", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6356.33, 9558.99, 432.5), (0, 180.99, 0), "heli_spawner", undefined, undefined, "50", "49", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2277.65, 2923.27, 1520.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "55", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5112.33, 6893.1, 2766.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "51", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2638.01, 3210.01, 1932.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "54", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3203.61, 3778.36, 2312.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "53", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3920.19, 4858.77, 2708.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "52", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1718.11, 2589.37, 1226.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "57", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1486.11, 2503.37, 1090.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "58", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23875.9, 2063.41, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22327.9, 7597.41, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (17789.9, 13167.4, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (11295.9, 16007.4, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4913.9, 16853.4, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3684.1, 17073.4, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11036.1, 15083.4, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-16214.1, 10351.4, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18596.1, 3637.4, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-17756.1, -4172.6, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-15908.1, -8528.6, 3497.71), (0, 180, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-13654.1, -12016.6, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8983.24, -14621.2, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2782.96, -16801.3, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4785.04, -17957.3, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (12123, -16021.3, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (18123, -12701.3, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22047, -8275.3, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (24817, -3757.3, 3497.71), (0, 160, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2526.11, 1276.63, 1226.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "66", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (1039.02, 1139.16, 252), (2.56, 180.45, 0.62), "wave_veh_spawners", undefined, "default", "59 61 62 63 64 65 66 67 68", "60", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7000.58, 7549.47, 500.5), (0, 0.99, 0), "heli_spawner", undefined, undefined, "60", "59", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2983.65, 1436.72, 1416.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "65", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5662.34, 4678.89, 2662.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "61", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3720.01, 1871.98, 1828.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "64", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4409.61, 2457.63, 2208.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "63", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5118.2, 3485.22, 2604.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "62", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2246.11, 1196.63, 1122.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "67", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2014.11, 1140.63, 986.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "68", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3108.11, 690.63, 1668.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "76", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "mindia8";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (1621.02, 553.16, 694), (2.56, 180.45, 0.62), "wave_veh_spawners", undefined, "default", "70 71 72 73 74 75 76 77 78", "69", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7221.23, 5839.67, 574.84), (0, 0.99, 0), "heli_spawner", undefined, undefined, "69", "70", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3600.57, 890.53, 1858.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "75", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6244.37, 4092.88, 3104.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "71", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4302.01, 1285.97, 2270.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "74", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4991.61, 1871.62, 2650.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "73", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5700.21, 2899.21, 3046.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "72", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2828.11, 610.63, 1564.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "77", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2596.11, 554.63, 1428.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "78", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-502.79, -1119.91, 1392.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "86", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "mindia8";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (984.3, -982.44, 417.62), (2.56, 0.45, 0.62), "wave_veh_spawners", undefined, "default", "79 81 82 83 84 85 86 87 88", "80", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4240.58, -6016.62, 796.02), (0, 180.99, 0), "heli_spawner", undefined, undefined, "80", "79", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-960.33, -1279.99, 1582.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "85", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3639.04, -4522.16, 2828.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "81", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1696.69, -1715.25, 1994.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "84", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2386.29, -2300.9, 2374.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "83", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3094.89, -3328.49, 2770.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "82", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-222.79, -1039.91, 1288.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "87", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (9.21, -983.91, 1152.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "88", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-642.84, -114.78, 1154.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "96", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-149.7, -1524.44, 179.62), (2.56, 284.45, 0.62), "wave_veh_spawners", undefined, "default", "89 91 92 93 94 95 96 97 98", "90", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7118.01, 2933.47, 378.5), (0, 104.99, 0), "heli_spawner", undefined, undefined, "90", "89", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-908.85, 290.45, 1344.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "95", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4702.75, 2105.26, 2590.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "91", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1509.32, 899.64, 1756.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "94", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2244.4, 1427.08, 2136.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "93", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3412.89, 1866.04, 2532.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "92", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-497.48, -367.11, 1050.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "97", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-387.02, -578.67, 914.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "98", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (595.19, -4442.48, 265), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2929.49, -2683.49, 263), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2942.58, -339.54, 332.85), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1914.12, 522.58, 674.85), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-51.97, 3974.44, 744.83), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2460.07, 2085.2, 358.22), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (610.81, 34, 854), (0, 272, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}