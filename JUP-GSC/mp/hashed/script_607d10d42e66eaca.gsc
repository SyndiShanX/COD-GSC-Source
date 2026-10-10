/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_607d10d42e66eaca.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_aethernest_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_aethernest_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_aethernest_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_aethernest_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_aethernest_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_aethernest_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39603.1, 28254.7, 1906.81), (3.66, 196.02, -1.82), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (27788, 23684, 1424), (0, 0, 0), "jail");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29574, 23460, 1364), (0, 0, 0), "office");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39674.6, 28265.1, 1910.5), (355.7, 13.64, -0.4), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (31848.1, 33961.7, 1329.81), (3.2, 127.56, -2.54), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.ai_faction = "zombie";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (31891, 33899.5, 1334.5), (355.88, 329.02, -1.27), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_aethernest_cs");
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
    cf = "mp_jup_st_c_ob_activities_aethernest_cs";
  }

  switch (instancename) {
    case #"hash_9ab3ebca27cf0671":
      function_f69aed2977c4864e(fe, us, cf);
      break;
    case #"hash_c0fed2ebf66e1bc8":
      function_ad149019b98e7de5(fe, us, cf);
      break;
    case #"hash_abc7f53a7deb151e":
      function_2e3897765135ee23(fe, us, cf);
      break;
    case #"hash_9075b0a06a0180ee":
      function_65c60909852a4065(fe, us, cf);
      break;
  }
}

function function_f69aed2977c4864e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (-12, 264, 100);
  s.var_74e936bbadd15418 = (188, 60, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (39480, 28524, 1812), (0, 0, 0), "aethernest_interior_trigger", "AETHERNEST_COMMSARRAY_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (168, 228, 100);
  s.var_74e936bbadd15418 = (188, 332, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (39608, 28408, 1812), (0, 0, 0), "aethernest_interior_trigger", "AETHERNEST_COMMSARRAY_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (39640.1, 28257.6, 1946.06), (0, 95.1, 0), "ceiling_spawner", "AETHERNEST_COMMSARRAY_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (39576.2, 28386, 1821.8), (359.62, 181.9, -0.05), "AETHERNEST_COMMSARRAY_CLASSROOM", "AETHERNEST_COUNTDOWN_OFFICE_1S_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39784.1, 28642, 1934), (341.95, 320.69, 115.45), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (39565.3, 28459, 1818), (0, 270.37, 0), "s_loot_cache_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39480.4, 28082.8, 1940.58), (359.62, 179.21, 133.99), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39413.4, 28363.7, 1905.86), (71.35, 92.26, 93.53), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39466.2, 28786.7, 1935.54), (21.55, 320.25, 137.12), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39610.6, 28354, 1944.44), (344.14, 206.2, -125.45), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39793.9, 28485.7, 1876.89), (38.15, 251.6, 73.64), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39687.1, 28639.5, 1940.06), (1.68, 178.18, -130.76), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39540, 28180.7, 1947.28), (317.28, 21.74, 155.67), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39323.4, 28451.2, 1861.19), (359.62, 177.9, 89.98), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39699.1, 28128.2, 1815.25), (0, 275.92, 0), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39780.5, 28371.6, 1936.18), (42.16, 243.77, 119.57), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39710.2, 28539.6, 1812.5), (0, 198.1, 0), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (39490.1, 28085.9, 1815.75), (336.01, 297.71, -7.31), "s_cyst_spawn", "AETHERNEST_COMMSARRAY_CLASSROOM", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_ad149019b98e7de5(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (31956.6, 33898.2, 1222), (0, 59.96, 0), "s_loot_cache_spawn", "AETHERNEST_MILBASE_GAS", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (31862.3, 33922, 1366), (0, 86.42, 0), "ceiling_spawner", "AETHERNEST_MILBASE_GAS", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (31866.3, 34080, 1212), (0, 76.42, 0), "AETHERNEST_MILBASE_GAS", "AETHERNEST_GAS_STATION_03", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (216, 342, 92);
  s.var_74e936bbadd15418 = (256, 668, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (31876.4, 34089.5, 1217.5), (0, 329.12, 0), "aethernest_interior_trigger", "AETHERNEST_MILBASE_GAS", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (32036.8, 34295.5, 1250.66), (335, 58.42, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (32082, 34351.9, 1294.5), (298.93, 20.99, 76.96), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (31623.3, 33822.8, 1225.55), (43.76, 334.22, 0), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (31692, 34129.3, 1294.09), (29.92, 337.84, 92.15), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (32212.5, 34183.5, 1283.5), (0, 242.42, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (31688.2, 33790, 1368), (358.5, 346.42, 180), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (31487.9, 33941.5, 1265.71), (55.76, 246.97, -89.34), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (31462, 33891.2, 1361.56), (358.94, 234.85, -129.47), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (32242.3, 34258.8, 1359), (38.74, 324.45, 144.22), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (31932.2, 34124.5, 1290.5), (0, 66.42, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (31842.4, 33658.9, 1290.87), (72.57, 248.09, 92.56), "s_cyst_spawn", "AETHERNEST_MILBASE_GAS", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_2e3897765135ee23(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25510.9, 29072.5, 1577.08), (359.64, 348, 179.89), "ceiling_zombie", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25508.4, 29073.7, 1563.06), (359.74, 18, 179.72), "ceiling_spawner", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25483.8, 28932.1, 1424.8), (359.62, 338, -0.05), "AETHERNEST_MILBASE_CLASSROOM", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25492.4, 29071.4, 1580.98), (0.32, 183, -179.8), "ceiling_zombie", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25445.1, 28680.2, 1456.81), (340.83, 152.74, 85.68), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25436.9, 28688.2, 1486.27), (319.06, 334.41, -91.14), "patch4", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25756.3, 29151.7, 1446.13), (270.38, 150.81, -88.85), "patch2", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25288, 28994.7, 1489.96), (334.99, 64.06, 89.85), "patch1", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25755.5, 29149.6, 1453.08), (359.62, 330, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25658.8, 28907.2, 1453.36), (69.95, 267.29, 111.41), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25702.3, 28723.3, 1478.91), (359.99, 242, 90.38), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25500.9, 29109.7, 1554.17), (359.76, 23, 179.7), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25279.7, 28984.6, 1496.14), (38.15, 47.7, 73.64), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25431.1, 28690.2, 1504.81), (340.83, 152.74, 85.68), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25548.9, 29106.4, 1546.29), (0.34, 178, -179.83), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25649.2, 28896.7, 1475.94), (0.76, 244.04, 89.12), "patch4", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25540.5, 29117.6, 1547.21), (0.32, 118, 179.79), "patch1", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25703.9, 28724.4, 1483.91), (89.62, 330.92, 178.92), "patch2", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25688.2, 28764.9, 1454.69), (359.62, 334, 89.98), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25692.1, 28761.4, 1461.72), (64.38, 154.04, -89.95), "patch2", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25477.1, 29209.3, 1418.64), (359.77, 279, 0.31), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25485.8, 29211, 1420.16), (0.38, 163, 0.08), "patch2", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25296, 29022.3, 1447.18), (38.15, 47.7, 73.64), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25350.2, 28862.9, 1418.69), (359.62, 334, -0.02), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25353.8, 28871, 1420.16), (0.15, 218, 0.36), "patch2", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25738.2, 29102.9, 1418.69), (359.62, 334, -0.02), "s_cyst_spawn", "AETHERNEST_MILBASE_CLASSROOM", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (25733.8, 29123, 1420.16), (0.15, 218, 0.36), "patch2", "AETHERNEST_MILBASE_CLASSROOM", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_65c60909852a4065(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29349.4, 23259.9, 1576), (0, 69.84, 180), "ceiling_zombie", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29347.8, 23257.5, 1562), (0, 99.84, 180), "ceiling_spawner", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29318.5, 23241.2, 1424), (0, 89.84, 0), "AETHERNEST_MILBASE_MULTILEVEL", "AETHERNEST_MILBASE_MULTILEVEL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29347.8, 23241.4, 1580), (0, 264.84, -180), "ceiling_zombie", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29032.5, 23596.4, 1471), (270, 102.35, 75.44), "patch2", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29133.2, 22895.9, 1497.42), (274.89, 243.61, 30.97), "patch1", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29034, 23604, 1472), (0, 93.85, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29174.8, 23640.6, 1499.09), (26.81, 13.7, 98.02), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29655.4, 23287.1, 1614), (0, 270.84, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29580.6, 23254, 1554), (360, 194.84, 180), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29104.2, 23424.3, 1606.09), (25.99, 19.28, 100.5), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29141.5, 22893.6, 1488.14), (337.29, 182.5, 85.27), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29528.1, 23268.8, 1550), (0, 349.84, -180), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29183.3, 23634.7, 1507.03), (319.3, 0.71, 89.58), "patch4", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29534.7, 23256.5, 1547), (0, 289.84, 180), "patch1", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29651.8, 23288.5, 1619), (90, 356.42, 175.59), "patch2", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29486, 23153.4, 1626), (360, 179.84, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29496.8, 23154.4, 1633), (64, 179.84, 89.99), "patch2", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29497.8, 23345, 1477), (270, 359.68, 90.19), "patch2", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29490.7, 23342.8, 1482), (0, 15.93, 90), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29081.2, 22888.4, 1516), (336.86, 178.18, 83.42), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29097.1, 23418.8, 1633.82), (317.5, 357.61, 93.45), "patch4", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29068.2, 23420.4, 1662.09), (25.99, 19.28, 100.5), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29261.7, 22890.1, 1628.11), (29.69, 179.28, 90.02), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29267.6, 22890.5, 1639.5), (86.3, 2.18, -87.36), "patch2", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29341.1, 22977.3, 1561.43), (1.31, 243.87, 2.7), "s_cyst_spawn", "AETHERNEST_MILBASE_MULTILEVEL", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_aethernest_cs";
  fe[[f]](s, us, cf, (29326, 22986.9, 1562), (0.34, 39.79, -0.72), "patch2", "AETHERNEST_MILBASE_MULTILEVEL", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_c_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (39612, 28349, 2015.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(39576, 28386, 1817)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["AETHERNEST_COMMSARRAY_CLASSROOM"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_c_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (31792, 33972, 1493);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(31903, 34126, 1224)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [850];
  activityinstances["AETHERNEST_MILBASE_GAS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_c_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (25480, 28956, 1420);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(25484, 28932, 1420)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["AETHERNEST_MILBASE_CLASSROOM"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_st_c_ob_activities_aethernest_cs";
  instancestruct.scriptstructorigin = (29422.6, 23282.9, 1424);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(29314.5, 23243.2, 1412)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["AETHERNEST_MILBASE_MULTILEVEL"] = instancestruct;
  return activityinstances;
}