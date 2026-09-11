/*****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_petrograd\cp_sv_petrograd_create_script.gsc
*****************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_petrograd_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_petrograd_create_script");
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

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "cp_sv_petrograd_create_script");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_sv_petrograd_create_script");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_sv_petrograd_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (306.46, -3370.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "8", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-4396.63, -5985.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_type = "mindia8";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (284.98, -2034.66, 259.5), (2.56, 89.79, 0.62), "wave_veh_spawners", undefined, "default", "1 3 4 5 6 7 8", "2", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-2211.66, -7488.32, 1105.08), (1, 0, 0), "heli_spawner", undefined, undefined, "2", "1", undefined, undefined, 512, 55, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (306.46, -3858.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "7", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1290.04, -6636.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "3", undefined, undefined, 512, 55, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (220.96, -4341.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "6", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5367.63, -12782.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2493.5, -2766, 2056), undefined, "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-600.5, -2438, 2056), undefined, "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2381.5, 2580, 2056), undefined, "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (21.5, 2664, 2056), undefined, "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-695.43, -1499.57, 851), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (71.96, -4820.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "5", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-321.04, -5468.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "4", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1664.92, 2403.97, 1191.76), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "16", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_type = "lbravo_carrier";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (1900.98, 1153.34, 256), (359.16, 289.76, 2.5), "wave_veh_spawners", undefined, "default", "9 11 12 13 14 15 16", "10", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1011.93, 6180.2, 940), undefined, "heli_spawner", undefined, undefined, "10", "9", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1276.31, 2832.14, 1351.18), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "15", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-388.99, 5202.11, 1673.28), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "11", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (871.72, 3297.22, 1470.06), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "14", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (549.26, 3697.39, 1661.01), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "13", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (242.58, 4156.32, 1755.3), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "12", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2652.66, -1603.08, 1228.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "32", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (1795.02, -1618.84, 258), (2.56, 179.46, 0.62), "wave_veh_spawners", undefined, "default", "25 27 28 29 30 31 32", "26", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7085.41, -4237.67, 1101.08), undefined, "heli_spawner", undefined, undefined, "26", "25", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3184.65, -1605.9, 1402.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "31", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (6826.56, -2957.62, 1680.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "27", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4142.65, -1648.75, 1582.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "30", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4650.73, -1765.57, 1642.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "29", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (5552.63, -2024.52, 1654.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "28", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2274.2, 296.46, 1214.42), (0, 90, 0), undefined, undefined, undefined, undefined, "40", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (1699.16, 646.48, 256), (2.56, 179.79, 0.62), "wave_veh_spawners", undefined, "default", "41 43 44 45 46 47 48 49 50", "42", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (10843.3, 884.84, 1402.08), undefined, "heli_spawner", undefined, undefined, "42", "41", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4234.2, -307.54, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "47", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (10298.2, -137.54, 1454.42), (0, 90, 0), undefined, undefined, undefined, undefined, "43", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (5856.2, -747.54, 1470.42), (0, 90, 0), undefined, undefined, undefined, undefined, "46", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7900.2, -1077.54, 1470.42), (0, 90, 0), undefined, undefined, undefined, undefined, "45", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (9254.2, -735.54, 1470.42), (0, 90, 0), undefined, undefined, undefined, undefined, "44", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3866.2, 68.46, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "48", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3434.2, 316.46, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "49", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2986.2, 508.46, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "50", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5068.63, -4057.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5572.63, -2193.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5828.63, 390.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5660.63, 2622.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-4948.63, 4502.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-3524.63, 6230.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1396.63, 7110.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (715.37, 7230.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2987.37, 7110.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-425.66, -2723.68, 1041), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4451.37, 6950.9, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-498.75, 2519.17, 1091.52), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-2516.63, -7049.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-580.63, -7425.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1715.37, -7233.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3483.37, -6513.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (5307.37, -5393.1, 2081.71), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-580.87, 701.94, 945.96), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1292.49, 1423.17, 1024.84), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1022.63, 114.63, 867.76), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1342.46, -1980, 1045.76), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3669.02, 876.89, 279.76), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2413.49, 2495.85, 1193.82), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "58", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (1048.66, 2742.98, 432), (2.61, 156.77, -0.34), "wave_veh_spawners", undefined, "default", "51 53 54 55 56 57 58", "52", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7512.29, 7469.61, 960), undefined, "heli_spawner", undefined, undefined, "52", "51", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2914.77, 2609.33, 1384.28), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "57", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7263.17, 6192.99, 1950.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "53", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4155.41, 2991.7, 1614.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "56", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (5776.93, 3801.92, 1949.49), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "55", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (6826.06, 4769.31, 1949.71), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "54", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (996.24, 3915.13, 1396.42), (0, 156, 0), undefined, undefined, undefined, undefined, "66", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_type = "mindia8";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (465.02, 2666.66, 260), (2.56, 245.79, 0.62), "wave_veh_spawners", undefined, "default", "59 61 62 63 64 65 66", "60", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1750.2, 8444.26, 1360.08), (1, 156, -0), "heli_spawner", undefined, undefined, "60", "59", undefined, undefined, 512, 60, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1188.73, 4344.93, 1578.42), (0, 156, 0), undefined, undefined, undefined, undefined, "65", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-57.38, 7735.33, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "61", undefined, undefined, 512, 55, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1302.47, 4892.56, 1718.42), (0, 156, 0), undefined, undefined, undefined, undefined, "64", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1350.84, 5527.87, 1838.42), (0, 156, 0), undefined, undefined, undefined, undefined, "63", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (964.71, 6584.6, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "62", undefined, undefined, 512, 45, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}