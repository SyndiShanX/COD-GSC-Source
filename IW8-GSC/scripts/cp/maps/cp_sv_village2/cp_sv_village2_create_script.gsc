/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_village2\cp_sv_village2_create_script.gsc
***************************************************************************/

function main(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("cp_sv_village2_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_village2_create_script");
  var_2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var_1, var_2);

  if(!scripts\cp\so_trigger::cs_is_starttime()) {
    scripts\cp\so_trigger::endcreatescript(var_2);
    return;
  }
}

function cs_return_and_wait_for_flag(var_0, var_1, var_2) {
  level endon("game_ended");
  scripts\cp\so_trigger::wait_for_cs_flag(var_2);

  if(!isDefined(var_0)) {
    var_0 = "stk";
  }

  var_1 scripts\cp\so_trigger::initbunkerdoor(var_0, "cp_sv_village2_create_script");
  scripts\cp\so_trigger::initbunkerbackwallkeypads(var_1);
  thread createstructs(level, var_1, var_0);
  level thread scripts\cp\so_trigger::wait_for_flags(var_1, "cp_sv_village2_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2858.04, -5807.33, 1088.85), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1245.33, -2424.2, 2472), (0, 314, 0), "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-994.65, 2325.29, 2472), (0, 314, 0), "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1698.47, -2975.99, 2472), (0, 314, 0), "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (913.5, 3020, 2472), (0, 314, 0), "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1548, -27432, 3168), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-23676, -4520, 1466), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1096.54, -2601.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "8", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "mindia8";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (-824.02, -1832.16, 555.5), (2.56, 11.79, 0.62), "wave_veh_spawners", undefined, "default", "1 3 4 5 6 7 8", "2", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3614.66, -6719.82, 1521.08), (1, 0, 0), "heli_spawner", undefined, undefined, "2", "1", undefined, undefined, 512, 55);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1096.54, -3089.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "7", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2693.04, -5868.2, 2398.42), undefined, undefined, undefined, undefined, undefined, "3", undefined, undefined, 512, 55);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1182.04, -3573.2, 2398.42), undefined, undefined, undefined, undefined, undefined, "6", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1331.04, -4051.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "5", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1724.04, -4699.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "4", undefined, undefined, 512, 45);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2131.98, 4430.75, 246.84), (0, 125, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1874.57, 4718.47, 668.55), (0, 170, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3377.78, -2841.32, 678.66), (0, 310, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-27.53, 4373.41, 533.37), (0, 235, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3568.94, 1333.97, 272.14), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3331.59, 636.76, 648.82), (0, 90, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2707.05, -1199.64, 970.71), (0, 280, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1760.25, -3101.71, 1748.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "32", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (798.37, -2689.27, 600), (2.56, 139.46, 0.62), "wave_veh_spawners", undefined, "default", "25 27 28 29 30 31 32", "26", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3118.75, -8076.12, 1621.08), (0, 316, 0), "heli_spawner", undefined, undefined, "26", "25", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2140.97, -3473.29, 1922.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "31", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3821.75, -6975.52, 2200.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "27", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2800.33, -4169.59, 2102.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "30", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3084.66, -4606.57, 2162.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "29", undefined, undefined, 512, 45);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3553.55, -5419.36, 2174.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "28", undefined, undefined, 512, 50);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2508.49, 392.35, 1681.82), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "58", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (1217.66, 565.48, 636), (2.61, 214.77, -0.34), "wave_veh_spawners", undefined, "default", "51 53 54 55 56 57 58", "52", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7607.29, 5366.11, 1448), undefined, "heli_spawner", undefined, undefined, "52", "51", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3009.77, 505.83, 1872.28), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "57", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (24544, 6788, 1618), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1790, 34712, 3548), undefined, "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7358.17, 4089.49, 2438.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "53", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4250.41, 888.2, 2102.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "56", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5871.93, 1698.42, 2437.49), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "55", undefined, undefined, 512, 45);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6921.06, 2665.81, 2437.71), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "54", undefined, undefined, 512, 50);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-318.79, 2541.65, 1786.42), (0, 210, 0), undefined, undefined, undefined, undefined, "66", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "default";
  var_4.script_function = "escalation_heli_spawn";
  var_4.script_goalyaw = "1";
  var_4.script_team = "axis";
  var_4.script_type = "mindia8";
  var_4.script_unload = "default";
  var_0[[var_3]](var_4, var_1, var_2, (135.72, 1877.07, 544), (2.56, 349.79, 0.62), "wave_veh_spawners", undefined, "default", "59 61 62 63 64 65 66", "60", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5597.25, 2981.9, 1750.08), (1, 210, -0), "heli_spawner", undefined, undefined, "60", "59", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-553.36, 2950.01, 1968.42), (0, 210, 0), undefined, undefined, undefined, undefined, "65", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4028.7, 3934.72, 2372.42), (0, 210, 0), undefined, undefined, undefined, undefined, "61", undefined, undefined, 512, 55);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-929.54, 3363.92, 2108.42), (0, 210, 0), undefined, undefined, undefined, undefined, "64", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1415.09, 3776.48, 2228.42), (0, 210, 0), undefined, undefined, undefined, undefined, "63", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2496.96, 4085.22, 2372.42), (0, 210, 0), undefined, undefined, undefined, undefined, "62", undefined, undefined, 512, 45);
  var_0 scripts\engine\utility::ent_flag_set("cs_objects_created");
}