/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_aniyah\cp_sv_aniyah_create_script.gsc
***********************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_aniyah_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_aniyah_create_script");
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

  var2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var1, "cp_sv_aniyah_create_script");
  scripts\cp\cp_create_script_utility::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);
  thread createmodels(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_sv_aniyah_create_script");
    return;
  }

  scripts\cp\cp_create_script_utility::wait_for_flags(var2, "cp_sv_aniyah_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\cp_create_script_utility::strike_additem;
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1397.5, -18773.5, 1705), undefined, "heli_spawner", undefined, undefined, "lz01", "1", undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-7152.5, -8886, 2372), undefined, undefined, undefined, undefined, undefined, "2", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-32893.5, 5969.5, 1705), undefined, "heli_spawner", undefined, undefined, "lz04", "13", undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-7152.5, -8886, 2372), undefined, undefined, undefined, undefined, undefined, "2", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-9028, -2657.5, 1833), undefined, undefined, undefined, undefined, undefined, "3", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-7129, 851.5, 1577), undefined, undefined, undefined, undefined, undefined, "4", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "casual_gun";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "true";
  var4.script_team = "axis";
  var4.script_type = "lbravo_carrier,mindia8";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (-5303.45, 2120.42, 370.04), (0, 191.41, 0), "wave_veh_spawners", undefined, "default", "13 14 15 16", "lz04", undefined, undefined, 512, 2000, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "casual_gun";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "true";
  var4.script_team = "axis";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (-5805.45, -1013.58, 370.04), (0, 260.3, 0), "wave_veh_spawners", undefined, "default", "1 2 3 4", "lz01", undefined, undefined, 512, 2000, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-55842.7, 41483, 3881), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-58433.7, 16432.5, 2905), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (13072, -105.5, 3652), (0, 180.12, 0), undefined, undefined, undefined, "lz023", "10", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2613.5, -19788.5, 1466), undefined, "heli_spawner", undefined, undefined, "lz07", "25", undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-55842.7, 41483, 3881), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-58433.7, 16432.5, 2905), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (13072, -105.5, 3652), (0, 180.12, 0), undefined, undefined, undefined, "lz023", "10", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (10883, 3796.94, 3113), (0, 180.12, 0), undefined, undefined, undefined, undefined, "11", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-18353, 8395.5, 2601.5), undefined, undefined, undefined, undefined, undefined, "14", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1137, 3237.5, 2372), (0, 180.12, 0), undefined, undefined, undefined, undefined, "6", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16588.3, 30702.4, 508.5), (0, 180.12, 0), "heli_spawner", undefined, undefined, "lz02", "5", undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1137, 3237.5, 2372), (0, 180.12, 0), undefined, undefined, undefined, undefined, "6", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-3040.46, 44.94, 2345), (0, 180.12, 0), undefined, undefined, undefined, undefined, "7", undefined, undefined, 253.44, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-780.11, -2897.53, 2089), (0, 180.12, 0), undefined, undefined, undefined, undefined, "8", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "casual_gun";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "true";
  var4.script_team = "axis";
  var4.script_type = "lbravo_carrier,mindia8";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (126.94, 703.77, 370.04), (0, 77.36, 0), "wave_veh_spawners", undefined, "default", "5 6 7 8", "lz02", undefined, undefined, 512, 2000, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (46401.3, 9163.5, 4185), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (46401.3, 9163.5, 4185), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (6152.89, 2345.47, 3113), (0, 180.12, 0), undefined, undefined, undefined, undefined, "12", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (13072, -105.5, 1092), (0, 180.12, 0), undefined, undefined, undefined, "lz023", "10", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5702.5, 5327.5, 2601.5), undefined, undefined, undefined, undefined, undefined, "15", undefined, undefined, 498.872, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1734.5, 2895.5, 2537.5), undefined, undefined, undefined, undefined, undefined, "16", undefined, undefined, 730.398, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (29832.5, -245.5, 2000), undefined, "heli_spawner", undefined, undefined, "lz05", "17", undefined, undefined, 269.377, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_delay_spawn = "5";
  var4.script_demeanor = "casual_gun";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "true";
  var4.script_team = "axis";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (8338.55, 1044.92, 390.04), (0, 260.3, 0), "wave_veh_spawners", undefined, "default", "17 18 19 20", "lz05", undefined, undefined, 512, 2000, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (16771, 3444.94, 3609), (0, 180.12, 0), undefined, undefined, undefined, undefined, "18", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (12636.5, 6364.94, 2692), (0, 180.12, 0), undefined, undefined, undefined, undefined, "19", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (8506, 4470.44, 2905), (0, 180.12, 0), undefined, undefined, undefined, undefined, "20", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (14753.3, -11001.1, 737), (0, 180.12, 0), "heli_spawner", undefined, undefined, "lz03", "9", undefined, undefined, 512, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3662.5, -20694.5, 763), undefined, "heli_spawner", undefined, undefined, "lz06", "21", undefined, undefined, 269.377, 2000, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "casual_gun";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "true";
  var4.script_team = "axis";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (392.42, 3600.45, 363.54), (0, 202.53, 0), "wave_veh_spawners", undefined, "default", "21 22 23 24", "lz06", undefined, undefined, 512, 2000, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3383.5, 1015.94, 2987), (0, 180.12, 0), undefined, undefined, undefined, undefined, "22", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4034, 3417.9, 2987), (0, 180.12, 0), undefined, undefined, undefined, undefined, "23", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2502.5, 4425.4, 2987), (0, 180.12, 0), undefined, undefined, undefined, undefined, "24", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (13072, -105.5, 1092), (0, 180.12, 0), undefined, undefined, undefined, "lz023", "10", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (10883, 3796.94, 4393), (0, 180.12, 0), undefined, undefined, undefined, undefined, "11", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (6152.89, 2345.47, 2601), (0, 180.12, 0), undefined, undefined, undefined, undefined, "12", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "casual_gun";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "true";
  var4.script_team = "axis";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (6009.35, -924.35, 372.53), (0, 269, 0), "wave_veh_spawners", undefined, "default", "9 10 11 12", "lz03", undefined, undefined, 512, 2000, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var4.script_demeanor = "casual_gun";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "true";
  var4.script_team = "axis";
  var4.script_type = "lbravo_carrier,minidia8";
  var4.script_unload = "1";
  var0[[var3]](var4, var1, var2, (-294.58, -1339.05, 369.54), (0, 259.74, 0), "wave_veh_spawners", undefined, "default", "25 26 27 28", "lz07", undefined, undefined, 512, 2000, 40);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1362.11, -9334.5, 2511), (0, 180.12, 0), undefined, undefined, undefined, undefined, "26", undefined, undefined, 498.872, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-3953.61, -2176.5, 2511), (0, 180.12, 0), undefined, undefined, undefined, undefined, "27", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-122.11, 937.5, 2120), (0, 180.12, 0), undefined, undefined, undefined, undefined, "28", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-6290.54, -3043.73, 382.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1135.61, -9700.5, 2511), (0, 180.12, 0), undefined, undefined, undefined, undefined, "26", undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-7987.44, -2094.29, 380.69), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-7353.34, 629.36, 369.63), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-8370.84, 3038.3, 348.04), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5883.58, 4742.17, 320.91), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-3717.28, 5366.77, 334.08), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-412.26, 6132.96, 307.06), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2330.83, 5413.7, 392.08), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7751.29, 5405.7, 355.98), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (10917.4, 3564.14, 303.38), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (11712.1, 23.08, 171.4), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (10125.8, -2683.48, 457.21), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7487.05, -5017.68, 371.36), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3256.01, -4870.42, 470.12), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (522.97, -7618.66, 340.41), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-2543.56, -5238.77, 413.94), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-4848.83, -4670.84, 437.11), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4845.61, 5743.8, 379.47), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-5136.25, 1131.6, 721.53), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-3723.66, 1187.54, 727.93), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-1737.52, -1958.12, 671.93), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-2499.22, 2293.43, 825), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1700.46, -39.8, 1180.53), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2840.34, -46.29, 1575.7), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (3850.32, -48.63, 927.7), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (4044.63, 2396.2, 747.7), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2379.36, 3323.32, 673.7), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-785.9, 1651.83, 767.7), (0, 300, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (596.34, -9.23, 879.7), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (8250, -344, 2056), undefined, "auto5", "auto6", "heli_search", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (5255.75, 21.16, 733), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7683.6, 821.51, 673), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (6210.08, 931.31, 709), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (6175.35, 232.36, 632.5), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-4294, -600, 2056), undefined, "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (7994, 1960, 2056), undefined, "auto4", "auto5", "heli_search", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (-4294, 1960, 2056), undefined, "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (1850, 2984, 2056), undefined, "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var4 = scripts\cp\cp_create_script_utility::s();
  var0[[var3]](var4, var1, var2, (2362, -1368, 2056), undefined, "auto6", "auto1", "heli_search", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}

function createmodels(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_models_complete");
}