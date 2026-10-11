/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3be3ff925752d886.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_activities_aethernest_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_activities_aethernest_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_activities_aethernest_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_activities_aethernest_cs");

  if(!cs_is_starttime()) {
    endcreatescript(s);
  }
}

function cs_return_and_wait_for_flag(us, s, cf) {
  level endon("game_ended");
  wait_for_cs_flag(cf);

  if(!isDefined(us)) {
    us = "pfx";
  }

  s cs_setup_arrays(us, "mp_jup_st_a_ob_activities_aethernest_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_activities_aethernest_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-32790, 30711, 1483.5), (3.2, 208.23, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-32727, 30743, 1486.5), (351.67, 42.61, -2.13), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-22430.5, 24994.5, 1839.51), (3.19, 341.46, -0.27), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-22497, 25018.5, 1842.5), (351.6, 175.82, -1.86), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35303.3, 41724, 1728.79), (3, 240.89, -1.84), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35267.5, 41785, 1731.5), (351.4, 75.11, -0.28), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-21088.3, 37215, 2184.79), (3, 240.89, -1.84), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-21055.5, 37280, 2189.5), (356.29, 88.07, -2.2), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_activities_aethernest_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_AETHERNEST";
  activityinfostruct.scriptbundle = "jup_activitydef_aethernest";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_a_ob_activities_aethernest_cs";
  }

  switch (instancename) {
    case #"hash_33360d75dd7baa9f":
      function_78f6cfea2e06390e(fe, us, cf);
      break;
    case #"hash_70ae37851c4d1e3e":
      function_1490a3595d24d927(fe, us, cf);
      break;
    case #"hash_988e98dfbc6d6150":
      function_eb7efa80b3030cef(fe, us, cf);
      break;
    case #"hash_4441fffe07abe991":
      function_1856af1af68609da(fe, us, cf);
      break;
  }
}

function function_78f6cfea2e06390e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-35558, 41885.4, 1764.75), (26.98, 72.73, 142.46), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-34855.2, 41718.6, 1679.25), (359.74, 308.22, 89.25), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-35460, 41932.5, 1640), (0, 220.16, 0), "s_loot_cache_spawn", "AETHERNEST_A_DELI_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-35275.1, 41750.4, 1768), (0, 142.07, -0), "ceiling_spawner", "AETHERNEST_A_DELI_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-35350.7, 42059.4, 1654), (32, 40.18, 90), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-34892.5, 41439.4, 1682.75), (83.09, 131.69, -48.22), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-35190.4, 42119.1, 1716.44), (310.89, 129.65, -90.84), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (344, 220, 88);
  s.var_74e936bbadd15418 = (380, 252, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-35194.6, 41706.4, 1641), (0, 130.18, 0), "aethernest_interior_trigger", "AETHERNEST_A_DELI_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-34920.7, 41792.4, 1760.75), (359.74, 308.22, 118.81), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-34970, 41539.8, 1727.37), (359.26, 131.26, 89.36), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-34998.1, 41343.4, 1761.5), (294.05, 141.41, 167.74), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-35225.3, 41374.1, 1723.25), (30.04, 127.28, 84.22), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-35042.6, 41921.7, 1759.5), (315, 220.18, 135), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-35523.8, 41735.3, 1705.31), (0, 130.18, 93.04), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-35480.5, 41698.1, 1764.75), (2.15, 85.22, 137.15), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-35206.5, 41883.6, 1772.75), (0, 15.17, -180), "s_cyst_spawn", "AETHERNEST_A_DELI_WEST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-35175.9, 41724.9, 1625), (0, 310.18, 0), "AETHERNEST_A_DELI_WEST", "AETHERNEST_STORE_ABANDONED_SM_08", "500", undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
}

function function_1490a3595d24d927(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-22547, 25026.5, 1734.5), (0, 250.16, 0), "s_loot_cache_spawn", "AETHERNEST_A_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-22462.7, 25013.1, 1878.5), (0, 275.72, 0), "ceiling_spawner", "AETHERNEST_A_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-22444.6, 24848.9, 1747.75), (0, 265.92, 0), "AETHERNEST_A_GAS_SOUTH", "AETHERNEST_GAS_STATION_03", "750", undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (216, 356, 92);
  s.var_74e936bbadd15418 = (256, 668, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-22446, 24850, 1735.5), (0, 160.03, 0), "aethernest_interior_trigger", "AETHERNEST_A_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22573.9, 24615.7, 1764.66), (334.99, 247.72, 90), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22608, 24548.3, 1808.5), (298.93, 210.3, 76.95), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22251.8, 25155.2, 1733.55), (9.71, 163.53, -0), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22266.9, 24834, 1816.09), (29.92, 167.15, 92.15), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22762.2, 24694.8, 1799), (0, 71.72, 90), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22317.9, 25172.2, 1883), (358.5, 175.73, -180), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22093.3, 25057, 1778.21), (55.76, 76.27, -89.34), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22078.2, 25110.2, 1872.06), (359.7, 69.63, -121.2), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22779.5, 24620.9, 1870), (38.75, 153.76, 144.22), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22544.1, 24685.1, 1870), (0, 255.73, 114.68), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-22493.2, 25271.2, 1803.87), (72.57, 77.4, 92.56), "s_cyst_spawn", "AETHERNEST_A_GAS_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_eb7efa80b3030cef(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-32680, 30750.5, 1396.66), (0, 117.96, 0), "s_loot_cache_spawn", "AETHERNEST_A_TRAILER_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (120, 362, 86);
  s.var_74e936bbadd15418 = (134, 338, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-32709.3, 30745, 1408), (0, 118.07, 0), "aethernest_interior_trigger", "AETHERNEST_A_TRAILER_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-32753.7, 30722.9, 1523), (0, 144.07, 0), "ceiling_spawner", "AETHERNEST_A_TRAILER_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-32712.6, 30729, 1379), (0, 134.07, 0), "AETHERNEST_A_TRAILER_WEST", "AETHERNEST_OFFICE_IND_03", "400", undefined, undefined, (0, 0, 0), (0, 0, 0), 400);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32457.1, 30720.2, 1468.91), (303.25, 211.84, 82.73), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32367.6, 30841.7, 1466), (45.8, 296.06, 90), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-33066, 30616.3, 1460.5), (0, 114.07, 90), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-33085.9, 30686.3, 1516.09), (25.46, 65.58, 106.4), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32469.5, 31012, 1519.5), (321.37, 292.01, 154.85), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32611.5, 30674.3, 1518.27), (43.48, 56.71, -140.53), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32854.1, 30514.7, 1406.71), (8.67, 220.91, 72.23), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32740.6, 30573.9, 1469), (320.01, 203.56, 91.06), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32724.4, 30878.4, 1406.71), (296.34, 31, 24.6), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32598.8, 30958.7, 1446.75), (339.6, 30.07, 90), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-32640.2, 30731.2, 1480), (0, 118.07, 90), "s_cyst_spawn", "AETHERNEST_A_TRAILER_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1856af1af68609da(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-20942.1, 36967.3, 2218), (26.98, 212.45, 142.46), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21373.6, 37516.1, 2161.75), (72.02, 85.62, 87.57), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-21044.5, 36980.2, 2096), (0, 359.96, 0), "s_loot_cache_spawn", "AETHERNEST_A_DELI_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-21070, 37245.4, 2224), (0, 281.79, -0), "ceiling_spawner", "AETHERNEST_A_DELI_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-20996.2, 36960.8, 2102.25), (21.51, 155.72, 39.28), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21161.3, 37727.2, 2139), (69.55, 255.84, -68.94), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21373.3, 37008.3, 2177.19), (310.89, 269.37, -90.84), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (344, 220, 88);
  s.var_74e936bbadd15418 = (380, 252, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-21103, 37331, 2097), (0, 269.9, 0), "aethernest_interior_trigger", "AETHERNEST_A_DELI_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21366.2, 37438.1, 2218), (359.74, 87.94, 126.21), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21172.5, 37603.4, 2190.37), (359.26, 270.98, 89.36), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21008.1, 37736.4, 2184), (0, 359.9, 90), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-20869.3, 37565.6, 2178.5), (0, 269.9, 85), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21358.2, 37265, 2215.5), (315, 359.9, 135), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-20870.8, 37090.1, 2166.56), (0, 269.9, 93.04), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-20883.9, 37158.2, 2217), (2.15, 224.94, 137.15), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-21134.3, 37144.1, 2220.75), (345.18, 159.5, 145.63), "s_cyst_spawn", "AETHERNEST_A_DELI_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-21124.1, 37335.1, 2092.25), (0, 89.9, 0), "AETHERNEST_A_DELI_CENTRAL", "AETHERNEST_STORE_ABANDONED_SM_08", "500", undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_a_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-35190.8, 41693.4, 1845.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-35197, 41669, 1632)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [650];
  activityinstances["AETHERNEST_A_DELI_WEST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_a_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-22380.3, 24998.3, 2017.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-22391.9, 25010.6, 1734)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [750];
  activityinstances["AETHERNEST_A_GAS_SOUTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_a_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-32725.3, 30729.6, 1578.41);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-32729.6, 30754.6, 1379)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [650];
  activityinstances["AETHERNEST_A_TRAILER_WEST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_a_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-21099.4, 37340.9, 2274.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-21077, 37358, 2091)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [650];
  activityinstances["AETHERNEST_A_DELI_CENTRAL"] = instancestruct;
  return activityinstances;
}