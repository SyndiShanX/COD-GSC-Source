/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7398ba6921cea192.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_activities_aethernest_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_activities_aethernest_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_activities_aethernest_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_activities_aethernest_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_activities_aethernest_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_activities_aethernest_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-9615, -29579.6, 1849.96), (4.29, 118.44, -1.3), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-9591, -29641.2, 1852.93), (4.63, 311.63, -1.63), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-11079, -10716.6, 1841.96), (4.29, 118.44, -1.3), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-11055, -10778.2, 1844.93), (4.63, 311.63, -1.63), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-24354.2, -31606.4, 2041.21), (4.31, 287.57, -1.2), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-24369.5, -31540.1, 2040.93), (4.63, 119.5, -1.63), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4209.65, -20852.6, 1789.21), (4.31, 197.57, -1.2), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4143.35, -20837.2, 1788.93), (4.63, 29.5, -1.63), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_activities_aethernest_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_AETHERNEST";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydef_aethernest";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_g_ob_activities_aethernest_cs";
  }

  switch (instancename) {
    case #"hash_52fbcf6164477886":
      function_48eb442230c1e22f(fe, us, cf);
      break;
    case #"hash_f84c0921ee4e1ff8":
      function_c3b63fc3f1eb7753(fe, us, cf);
      break;
    case #"hash_5e8a0210ea2cb7a0":
      function_4e160ec6635452d9(fe, us, cf);
      break;
    case #"hash_b73dcd8c0c9b9334":
      function_9d02c93d7fed7171(fe, us, cf);
      break;
  }
}

function function_48eb442230c1e22f(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (182, 340, 86);
  s.var_74e936bbadd15418 = (184, 334, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-24305.7, -31708.3, 1965), (0, 166.95, 0), "aethernest_interior_trigger", "AETHERNEST_G_CONVENIENCE_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-24357, -31569, 2081.5), (0, 192.94, 0), "ceiling_spawner", "AETHERNEST_G_CONVENIENCE_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-24322.7, -31713.3, 1950.53), (3.03, 181, -0.7), "AETHERNEST_G_CONVENIENCE_SOUTH", "AETHERNEST_STORE_10", "450", undefined, undefined, (0, 0, 0), (0, 0, 0), 450);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24061.5, -31424, 2032), (0, 302.94, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24097.5, -31451.2, 1946.25), (0, 18.02, 0), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24256, -31424.5, 1949.25), (1.25, 285.55, -4.49), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24433.8, -31404, 2013), (0, 76.95, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24411.5, -31349, 2080), (0, 31.95, 135), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24137.5, -31801, 2013), (0, 256.95, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24210.5, -32076, 2078), (0, 211.95, 135), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24416.2, -31656.3, 2077.36), (2.98, 347.29, 102.97), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24406.6, -31891.4, 1959.24), (0, 73.1, 45), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24382.2, -31785, 1958.25), (308.4, 212.56, -26.58), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "7", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24131.5, -31704.5, 2076), (0, 205.69, 132.49), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24554, -32000.5, 2068.5), (2.01, 129.21, 107.75), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24538.5, -31882, 2025), (0, 76.95, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-24264.5, -31847.2, 1953.5), (0, 256.75, 0), "s_loot_cache_spawn", "AETHERNEST_G_CONVENIENCE_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c3b63fc3f1eb7753(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (182, 340, 86);
  s.var_74e936bbadd15418 = (184, 334, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-4314.23, -20898.6, 1723), (0, 74.63, 0), "aethernest_interior_trigger", "AETHERNEST_G_CONVENIENCE_EAST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-4172.97, -20853, 1828.5), (0, 100.62, 0), "ceiling_spawner", "AETHERNEST_G_CONVENIENCE_EAST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-4453.5, -20934.2, 1700.5), (0, 164.94, 0), "s_loot_cache_spawn", "AETHERNEST_G_CONVENIENCE_EAST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-4318.54, -20881.4, 1708.53), (3.03, 88.69, -0.7), "AETHERNEST_G_CONVENIENCE_EAST", "AETHERNEST_STORE_10", "450", undefined, undefined, (0, 0, 0), (0, 0, 0), 450);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4039.37, -21159.9, 1762), (0, 210.63, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4067.33, -21112, 1694.5), (0, 285.7, 0), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4034.26, -20962.2, 1695), (0, 193.28, 0), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-3997.56, -20786.2, 1763), (0, 344.63, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-3954.45, -20811.9, 1820), (0, 299.63, 135), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4457.6, -20799, 1780.51), (0, 164.63, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4683.22, -20976, 1825.75), (0, 119.63, 135), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4627.09, -20756.6, 1819.67), (360, 22.71, 106.19), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4486.29, -20793.3, 1704.25), (0, 334.9, 45), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4383.08, -20826.1, 1694.5), (349.02, 107.21, -7.17), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "7", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4317.59, -21076.8, 1818), (356.66, 113.23, 118.18), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4601.6, -20639.5, 1816), (360, 53.01, 112.88), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-4479, -20661.5, 1766.5), (0, 344.63, 90), "s_cyst_spawn", "AETHERNEST_G_CONVENIENCE_EAST", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_4e160ec6635452d9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-11072.2, -10752.2, 1884), (0, 72.2, 0), "ceiling_spawner", "AETHERNEST_G_GAS_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-11023.4, -10594.5, 1734), (0, 62.41, 0), "AETHERNEST_G_GAS_CENTRAL", "AETHERNEST_GAS_STATION_03", "750", undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (244, 362, 92);
  s.var_74e936bbadd15418 = (256, 664, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-11022.5, -10596, 1754.5), (0, 316.52, 0), "aethernest_interior_trigger", "AETHERNEST_G_GAS_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-10792.5, -10666.7, 1740), (0, 47.17, 0), "s_loot_cache_spawn", "AETHERNEST_G_GAS_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-10807.1, -10425, 1773.66), (334.99, 44.21, 90), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-10753.6, -10384, 1812.5), (298.93, 6.79, 76.95), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-11318.8, -10788.5, 1739.05), (19.96, 320.02, -0), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-11178.9, -10501, 1816.09), (29.91, 323.64, 92.15), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-10667.1, -10576, 1802), (0, 228.21, 90), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-11265, -10830.5, 1885.5), (358.5, 332.21, 180), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-11425.3, -10638.4, 1783.71), (55.76, 232.76, -89.34), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-11459.5, -10678.1, 1876.06), (0.28, 226.08, -114.88), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-10625.3, -10518.9, 1874), (38.76, 310.25, 144.22), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-10959.5, -10582.7, 1811.25), (0, 52.21, 90), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-11149.5, -10995.8, 1808.37), (72.56, 233.89, 92.55), "s_cyst_spawn", "AETHERNEST_G_GAS_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_9d02c93d7fed7171(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-9603.32, -29608.1, 1892), (0, 184.54, 0), "ceiling_spawner", "AETHERNEST_G_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-9797.88, -29629.9, 1738), (0, 174.55, 0), "AETHERNEST_G_GAS_SOUTH", "AETHERNEST_GAS_STATION_03", "750", undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (240, 338, 92);
  s.var_74e936bbadd15418 = (256, 668, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-9771.18, -29617.8, 1760.5), (0, 67.24, 0), "aethernest_interior_trigger", "AETHERNEST_G_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9997.07, -29486, 1776.66), (334.99, 156.54, 90), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-10059.9, -29451.3, 1820.5), (298.93, 119.12, 76.95), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9466.8, -29825.9, 1745.05), (12.85, 72.35, -0), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9784.45, -29806, 1820.09), (29.92, 75.97, 92.15), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9878.78, -29312.8, 1825.25), (0, 340.54, 90), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9448.09, -29761.8, 1895.75), (358.5, 84.55, -180), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9574.18, -29977.2, 1791.71), (55.76, 345.1, -89.34), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9520.52, -29999.8, 1882.56), (15.7, 337.24, -111.07), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9988.91, -29283.3, 1882), (38.75, 62.57, 144.22), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9790.54, -29573.1, 1811.25), (0, 164.55, 90), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-9339.44, -29586.6, 1814.87), (72.56, 346.22, 92.56), "s_cyst_spawn", "AETHERNEST_G_GAS_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-9772.8, -29383.7, 1748), (0, 158.5, 0), "s_loot_cache_spawn", "AETHERNEST_G_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_g_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-24306.8, -31763.2, 2160.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-24326.3, -31717.2, 1949.37)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [450];
  activityinstances["AETHERNEST_G_CONVENIENCE_SOUTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_g_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-4374.89, -20910.7, 1905.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-4322.29, -20877.7, 1707.37)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [450];
  activityinstances["AETHERNEST_G_CONVENIENCE_EAST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_g_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-11138, -10675.8, 2031);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-11136.2, -10721.7, 1738)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [750];
  activityinstances["AETHERNEST_G_GAS_CENTRAL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_g_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-9642.88, -29684.6, 2029.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-9811.03, -29596.6, 1750)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [850];
  activityinstances["AETHERNEST_G_GAS_SOUTH"] = instancestruct;
  return activityinstances;
}