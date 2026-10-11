/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3ade1cbc20d053f2.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_activities_aethernest_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_activities_aethernest_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_activities_aethernest_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_activities_aethernest_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_activities_aethernest_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_activities_aethernest_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (5362.11, -14786.1, 1767.83), (4.21, 124.25, -1.29), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (5377.63, -14855.5, 1772.43), (4.2, 295.84, -2.54), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-74.33, -26907.3, 1797.96), (4.38, 196.09, -0.92), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4.82, -26914.8, 1800.93), (2.9, 349.94, -3.95), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-7516.6, -42703.5, 2562.96), (4.38, 33.45, -0.92), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-7580.2, -42729, 2564.93), (4.63, 221.63, -1.63), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (8913.79, -20854.9, 1842.15), (4.21, 230.39, -1.29), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (8976.16, -20820.7, 1846.76), (4.2, 41.98, -2.54), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_activities_aethernest_cs");
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
    cf = "mp_jup_st_h_ob_activities_aethernest_cs";
  }

  switch (instancename) {
    case #"hash_81714b1a93ef3abd":
      function_a8069d7662eb200(fe, us, cf);
      break;
    case #"hash_429462031075618f":
      function_9e19113b95b028fe(fe, us, cf);
      break;
    case #"hash_3800a3c5bed8f3c4":
      function_6c3fa55b56738ebb(fe, us, cf);
      break;
    case #"hash_8c842b89e1e8555a":
      function_b8c3a6e3425ae1c1(fe, us, cf);
      break;
  }
}

function function_a8069d7662eb200(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-7547.72, -42717.9, 2603.25), (0, 53.06, 0), "ceiling_spawner", "AETHERNEST_H_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-7426.99, -42549.4, 2449.25), (0, 43.06, 0), "AETHERNEST_H_GAS_SOUTH", "AETHERNEST_GAS_STATION_03", "750", undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-7369.74, -42742.1, 2458.92), (0, 21.07, 0), "s_loot_cache_spawn", "AETHERNEST_H_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (215, 344, 92);
  s.var_74e936bbadd15418 = (280, 668, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-7433.55, -42578, 2454.75), (0, 296.19, 0), "aethernest_interior_trigger", "AETHERNEST_H_GAS_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7181.57, -42472.3, 2487.91), (335, 3.4, 90), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7116.35, -42446.9, 2534.75), (298.92, 337.28, 76.95), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7796.17, -42635.7, 2459.3), (345.41, 193.49, -29.92), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-7542.37, -42455.2, 2553.34), (29.92, 282.82, 92.15), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7111.99, -42662.2, 2528.75), (360, 187.4, 90), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7762.68, -42697.8, 2605.5), (358.5, 291.41, -180), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7839.64, -42457.4, 2505.46), (55.76, 191.95, -113.12), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7892.41, -42485.5, 2588.31), (334.14, 211.43, -94.68), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7040.97, -42620.9, 2595.5), (38.75, 288.64, 144.22), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7374.93, -42563.1, 2525), (360, 23.22, 90), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-7699.23, -42890.1, 2526.87), (72.56, 207.82, 92.56), "s_cyst_spawn", "AETHERNEST_H_GAS_SOUTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_9e19113b95b028fe(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (8939.58, -20838.6, 1884), (0, 14.88, 0), "ceiling_spawner", "AETHERNEST_H_GAS_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (9127.05, -20782.2, 1735), (0, 4.88, 0), "AETHERNEST_H_GAS_NORTH", "AETHERNEST_GAS_STATION_03", "750", undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (222, 724, 92);
  s.var_74e936bbadd15418 = (256, 668, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (9102.94, -20798.9, 1757.5), (0, 257.57, 0), "aethernest_interior_trigger", "AETHERNEST_H_GAS_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (9033.45, -20994.4, 1739.95), (0, 341.32, 0), "s_loot_cache_spawn", "AETHERNEST_H_GAS_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (9348.82, -20888, 1773.66), (335, 346.87, 90), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (9418.38, -20910.7, 1818.75), (298.93, 309.45, 76.95), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (8766.97, -20645.8, 1743.3), (18.11, 262.68, -0), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (9082.29, -20611.4, 1817.09), (29.92, 266.3, 92.15), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (9273.4, -21084.9, 1820.75), (0, 170.88, 90), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (8759.29, -20715.2, 1889), (358.5, 274.88, -180), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (8841.09, -20474.4, 1780.71), (55.76, 175.43, -89.34), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (8787.29, -20467.2, 1880.56), (357, 169.19, -132.17), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (9366.64, -21093.4, 1880.25), (38.75, 252.91, 144.22), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (9142.28, -20845, 1805.75), (0, 354.88, 90), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (8682.22, -20898.1, 1813.12), (72.56, 176.56, 92.56), "s_cyst_spawn", "AETHERNEST_H_GAS_NORTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6c3fa55b56738ebb(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (5368.48, -14816.9, 1811.75), (0, 288.28, 0), "ceiling_spawner", "AETHERNEST_H_TIRESHOP_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (5474.16, -14854.4, 1676), (0, 24.42, 0), "AETHERNEST_H_TIRESHOP_NORTH", "AETHERNEST_STORE_14", "400", undefined, undefined, (0, 0, 0), (0, 0, 0), 400);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (186, 382, 106);
  s.var_74e936bbadd15418 = (236, 108, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (5395.86, -14870.5, 1681.5), (0, 277.12, 0), "aethernest_interior_trigger", "AETHERNEST_H_TIRESHOP_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5440.4, -14733.3, 1748.5), (360, 96.63, 90), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5348.9, -15074.8, 1752), (360, 187.91, 90), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5501.65, -15049.1, 1808), (360, 187.91, 135), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5318.74, -14754.1, 1684.95), (0, 40.49, 0), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5617.15, -14997.8, 1774.5), (360, 97.91, 90), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5304.65, -14933.6, 1807), (45, 277.9, -149.31), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5590.4, -14612.8, 1803.25), (360, 330.48, 122.63), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5684.45, -14594.3, 1800.03), (26.71, 349.44, 91.66), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5772.9, -14738.6, 1803.5), (0, 276.63, 113.38), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (5654.11, -14916.3, 1682.95), (24.08, 268.68, -6.57), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_NORTH", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (5377.2, -15043.8, 1684), (0, 8.53, 0), "s_loot_cache_spawn", "AETHERNEST_H_TIRESHOP_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_b8c3a6e3425ae1c1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-41.09, -26899.9, 1838), (0, 268.45, 0), "ceiling_spawner", "AETHERNEST_H_TIRESHOP_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (43.06, -26989.4, 1700), (0, 5.81, 0), "AETHERNEST_H_TIRESHOP_CENTRAL", "AETHERNEST_STORE_14", "400", undefined, undefined, (0, 0, 0), (0, 0, 0), 400);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (186, 386, 106);
  s.var_74e936bbadd15418 = (236, 108, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-36.28, -26979.7, 1705.5), (0, 258.5, 0), "aethernest_interior_trigger", "AETHERNEST_H_TIRESHOP_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (45.03, -26866.1, 1775), (360, 78.02, 90), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-150.01, -27161.8, 1776.25), (360, 169.3, 90), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (4.23, -27182.2, 1832), (360, 169.3, 135), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-73.17, -26844.4, 1709.45), (0, 21.87, 0), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (130.74, -27169.8, 1798.25), (360, 79.3, 90), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-141.42, -27006.1, 1831), (45, 259.29, -135.01), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (232.48, -26798.6, 1828), (3.99, 311.19, 104.53), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (392.61, -26829.6, 1791.5), (0, 303.31, 90.45), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (359.94, -26976.2, 1835.75), (3.78, 258.62, 131.36), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (189.59, -27106.6, 1710), (16.49, 246.52, -10.88), "s_cyst_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-106.05, -27138.3, 1710), (0, 347.78, 0), "s_loot_cache_spawn", "AETHERNEST_H_TIRESHOP_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_h_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-7602.5, -42607.5, 2727.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-7392.53, -42559.1, 2461.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [850];
  activityinstances["AETHERNEST_H_GAS_SOUTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_h_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (8947.75, -20732.1, 2003);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(9145.97, -20812.6, 1747)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [850];
  activityinstances["AETHERNEST_H_GAS_NORTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_h_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (5453.81, -14849.5, 1904);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(5467, -14849, 1688)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [400];
  activityinstances["AETHERNEST_H_TIRESHOP_NORTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_h_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (42.88, -26977.2, 1921);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(38, -26982, 1712)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [400];
  activityinstances["AETHERNEST_H_TIRESHOP_CENTRAL"] = instancestruct;
  return activityinstances;
}