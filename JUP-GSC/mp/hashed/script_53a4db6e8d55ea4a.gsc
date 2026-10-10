/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_53a4db6e8d55ea4a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_activities_aethernest_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_activities_aethernest_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_activities_aethernest_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_activities_aethernest_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_activities_aethernest_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_activities_aethernest_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-24928.9, -864.3, 1150.81), (3.2, 127.56, -2.54), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-24886, -931.5, 1155.5), (5.08, 328.82, -1.28), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-27238.4, -18354.1, 1810.36), (3.5, 31.8, -2.17), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-27312, -18390.5, 1811.5), (4.24, 216.36, -3.07), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-24848.3, -12650.3, 1611.13), (3.37, 48.2, -2.39), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-24910.5, -12691.5, 1612), (4.34, 218.32, -2.92), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_activities_aethernest_cs");
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
    cf = "mp_jup_st_d_ob_activities_aethernest_cs";
  }

  switch (instancename) {
    case #"hash_5f5da4c8bec179b9":
      function_6ab072b077090a0(fe, us, cf);
      break;
    case #"hash_e6ebbcf27769f36f":
      function_be10018e31490546(fe, us, cf);
      break;
    case #"hash_862519de75dfe1bd":
      function_81552271a22b304a(fe, us, cf);
      break;
  }
}

function function_6ab072b077090a0(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-24911.5, -896.35, 1186), (0, 187.93, 0), "ceiling_spawner", "AETHERNEST_D_GAS_CENTRAL", undefined, undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-24898.6, -814, 1042), (0, 162.2, 0), "s_loot_cache_spawn", "AETHERNEST_D_GAS_CENTRAL", undefined, undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-25074.8, -920.77, 1036), (0, 178.13, 0), "AETHERNEST_D_GAS_CENTRAL", "AETHERNEST_GAS_STATION_03", "750", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (216, 348, 92);
  s.var_74e936bbadd15418 = (256, 668, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-25073.8, -919.33, 1056.5), (0, 72.24, 0), "aethernest_interior_trigger", "AETHERNEST_D_GAS_CENTRAL", undefined, undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25313.3, -802.25, 1070.66), (334.99, 159.92, 90), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "5", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25377.5, -770.83, 1117), (298.62, 95.97, 100.32), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "5", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24764.3, -1107.41, 1042.8), (25.63, 75.74, 0), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "1", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25080.6, -1104.53, 1114.09), (29.92, 79.36, 92.15), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "4", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25242.5, -608.9, 1078), (0, 343.93, 90), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "6", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24747.4, -1040.43, 1187), (358.5, 87.94, -180), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "2", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24853.4, -1269.25, 1083.46), (55.76, 348.48, -89.34), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "3", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24793.7, -1281.28, 1179.56), (1.11, 341.74, -135.75), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "3", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25309.3, -597.9, 1182), (35.65, 68.69, 153.04), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "6", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25113.1, -868.37, 1109.25), (0, 167.93, 90), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "4", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24644.4, -861.08, 1107.87), (72.56, 349.61, 92.55), "s_cyst_spawn", "AETHERNEST_D_GAS_CENTRAL", "2", undefined, undefined, (-10.91, 160.68, 0), (0, 0.36, 0));
}

function function_be10018e31490546(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (120, 362, 86);
  s.var_74e936bbadd15418 = (134, 338, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-24821.5, -12691.1, 1532), (0, 90.02, 0), "aethernest_interior_trigger", "AETHERNEST_D_TRAILER_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-24874.3, -12674.9, 1648), (0, 116.01, 0), "ceiling_spawner", "AETHERNEST_D_TRAILER_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-24831.9, -12703.6, 1503), (0, 106.02, 0), "AETHERNEST_D_TRAILER_CENTRAL", "AETHERNEST_OFFICE_IND_03", "400", undefined, undefined, (0, 0, 0), (0, 0, 0), 400);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-24712.8, -12694.5, 1521.32), (0, 291.36, 0), "s_loot_cache_spawn", "AETHERNEST_D_TRAILER_CENTRAL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24475.4, -12776.3, 1530.4), (356.73, 260.17, 66), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24609.4, -12828, 1596.08), (72.43, 158.74, 75.41), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25189.2, -12643.2, 1582.75), (0, 86.02, 90), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25181.5, -12570.2, 1638.59), (20.83, 51.87, 112.06), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24483.3, -12567.7, 1645.5), (321.37, 263.96, 154.84), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24917.1, -12563, 1645.5), (11.61, 359.64, 124.39), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-25066, -12828.4, 1537.21), (76.33, 93.37, 5.51), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24921, -12823.4, 1595), (320.01, 175.51, 91.06), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24769, -12804.7, 1642.51), (305.67, 171.01, 161.87), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24622.7, -12557.5, 1568), (339.6, 2.02, 89.99), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-24766.6, -12740, 1604), (0, 90.02, 90), "s_cyst_spawn", "AETHERNEST_D_TRAILER_CENTRAL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_81552271a22b304a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (120, 362, 86);
  s.var_74e936bbadd15418 = (134, 338, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-27225.8, -18399.8, 1729), (0, 76.95, 0), "aethernest_interior_trigger", "AETHERNEST_D_TRAILER_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (-27273.8, -18371.8, 1844), (0, 102.94, 0), "ceiling_spawner", "AETHERNEST_D_TRAILER_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (-27238.7, -18409.7, 1700), (0, 92.95, 0), "AETHERNEST_D_TRAILER_WEST", "AETHERNEST_OFFICE_IND_03", "400", undefined, undefined, (0, 0, 0), (0, 0, 0), 400);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-26908.3, -18560, 1725.9), (348.87, 254.94, 66.82), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-26902.7, -18550.8, 1788.25), (45.81, 254.94, 89.99), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27575.5, -18248.8, 1782), (0, 72.94, 90), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27548.1, -18200.4, 1836.09), (20.82, 38.8, 112.06), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-26870.8, -18356.5, 1839), (321.37, 250.88, 154.84), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27203.6, -18517.6, 1841.68), (22.92, 20.15, -141.53), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27489.2, -18471.9, 1721.21), (65.6, 86.26, 12.39), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27353.9, -18509.2, 1788.75), (320.01, 162.43, 91.06), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27277.3, -18254.5, 1839.96), (0, 157.94, -118.99), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27000.6, -18311.5, 1758.5), (339.6, 348.95, 89.99), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (-27189.2, -18532.8, 1840), (360, 121.95, 135), "s_cyst_spawn", "AETHERNEST_D_TRAILER_WEST", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (-27199.8, -18400.5, 1717), (0, 75.66, 0), "s_loot_cache_spawn", "AETHERNEST_D_TRAILER_WEST", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_d_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-24903.2, -972, 1324.25);
  instancestruct.scriptstructoriginoffset = (-10.91, 160.68, 0);
  instancestruct.locationorigin = [(-24911.2, -967.19, 1040)];
  instancestruct.locationoriginoffset = [(-10.91, 160.68, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0.36, 0)];
  instancestruct.locationradius = [750];
  activityinstances["AETHERNEST_D_GAS_CENTRAL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_d_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-24834.6, -12688.8, 1716.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-24834.8, -12673.1, 1503)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [650];
  activityinstances["AETHERNEST_D_TRAILER_CENTRAL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_d_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (-27262.2, -18396.7, 1921.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-27234.7, -18379.3, 1700)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [650];
  activityinstances["AETHERNEST_D_TRAILER_WEST"] = instancestruct;
  return activityinstances;
}