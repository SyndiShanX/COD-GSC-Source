/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_11ffb1532922c825.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_contracts_outlast_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_OUTLAST";
  activityinfostruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_df585cc536a42a3":
      function_4ebbbbfefab72698(fe, us, cf);
      break;
    case #"hash_a3c15a945117197b":
      function_716c35caf6976bee(fe, us, cf);
      break;
    case #"hash_60723a0ddc748d77":
      function_859f33c1851d5fd0(fe, us, cf);
      break;
  }
}

function function_4ebbbbfefab72698(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-12125, 5868, 1066), (0, 296.2, 0), "ava_tablet", "s_outlast_e_warehouse", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-11714.7, 6070.46, 1062), (0, 22.9, 0), "s_outlast_e_warehouse_reward", "s_outlast_e_warehouse", "s_outlast_e_warehouse_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-11568.2, 5997.79, 1063.5), (0, 71.1, 0), "pnd", "s_outlast_e_warehouse", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-10566.5, 5327.25, 1050.5), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_e_warehouse", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-11565.5, 5998, 1119), (0, 341.1, 0), "s_outlast_e_warehouse", undefined, "objective_outlast_e_warehouse", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-11826.8, 7402, 1062), (0, 142.8, 0), "zombie_spawn_wave_3", "s_outlast_e_warehouse", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-12294.2, 7202.5, 1051.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_e_warehouse", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-13184.2, 4806.5, 1053.75), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_e_warehouse", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-12803, 5886.25, 1037), (0, 342.6, 0), "zombie_spawn_wave_2", "s_outlast_e_warehouse", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-10358.2, 6359.25, 1061.5), (0, 209, 0), "zombie_spawn_wave_1", "s_outlast_e_warehouse", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-14760, 12524, 1324), (0, 333, 0), "activity_nexus_instance_joiner", "s_outlast_e_warehouse", "OUTLAST_E_WAREHOUSE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-12356, 5420.5, 1339.5), (0, 162.5, 0), "outlast_entrance", "s_outlast_e_warehouse", "outlast_entrance", undefined, undefined, (0, 0, 0), (0, 0, 0), 75);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-12265.8, 3996.5, 1075.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_e_warehouse", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (1084, 968, 241);
  s.var_74e936bbadd15418 = (825, 11, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-11449.9, 5359.8, 1081), (0, 70.4, 0), "outlast_noent_entrance_trigger", "s_outlast_e_warehouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-11823.2, 5494.75, 1077), (0, 135, 0), "outlast_space", "s_outlast_e_warehouse", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1600);
}

function function_716c35caf6976bee(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (672.5, 386, 334);
  s.var_74e936bbadd15418 = (-7.5, 11, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (6467.86, -6482.3, 2466.5), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_dome", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (6386, -5578, 2410), (0, 136.8, 0), "ava_tablet", "s_outlast_e_dome", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5847.39, -5639.89, 2405.5), (0, 267.18, 0), "s_outlast_e_dome_reward", "s_outlast_e_dome", "s_outlast_e_dome_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5991.07, -5661.84, 2407.5), (0, 224.75, 0), "pnd", "s_outlast_e_dome", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (8280.11, -5098.46, 2389.5), (0, 238.74, 0), "zombie_spawn_wave_1", "s_outlast_e_dome", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5988.56, -5660.82, 2463), (0, 134.75, 0), "s_outlast_e_dome", "s_outlast_e_dome", "objective_outlast_e_dome", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (7053.07, -6739.77, 2387), (0, 116.53, 0), "zombie_spawn_wave_3", "s_outlast_e_dome", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (3846.48, -4936.94, 2390.5), (0, 108.74, 0), "zombie_spawn_wave_3", "s_outlast_e_dome", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (4308.17, -7376.56, 2348.5), (0, 238.74, 0), "zombie_spawn_wave_2", "s_outlast_e_dome", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5585.1, -7832.58, 2385), (0, 316.34, 0), "zombie_spawn_wave_2", "s_outlast_e_dome", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (7844.62, -3887.52, 2385.5), (0, 182.74, 0), "zombie_spawn_wave_1", "s_outlast_e_dome", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (11405, -8105.25, 1905.5), (0, 34.65, 0), "activity_nexus_instance_joiner", "s_outlast_e_dome", "OUTLAST_E_DOME", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (749, 1065, 402.5);
  s.var_74e936bbadd15418 = (243, 11, 72.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (6205.86, -6212.3, 2466.5), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_dome", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (6017.08, -5717.59, 2566), (0, 108.74, 0), "outlast_space", "s_outlast_e_dome", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1600);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (672.5, 386, 334);
  s.var_74e936bbadd15418 = (-7.5, 11, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (5505.36, -5490.3, 2466.5), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_dome", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (123, 378, 277.5);
  s.var_74e936bbadd15418 = (-15.5, 11, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (5753.86, -6230.3, 2446), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_dome", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_859f33c1851d5fd0(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (-411.5, 302, 216.25);
  s.var_74e936bbadd15418 = (775.25, 378.25, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (2199.11, 7214.7, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (671.5, 810.5, 404.75);
  s.var_74e936bbadd15418 = (775.25, 891.5, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (2339.61, 7333.7, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (2857.25, 7363.5, 1664.75), (0, 136.8, 0), "ava_tablet", "s_outlast_e_bathhouse", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (1989.39, 6999.11, 1895.25), (0, 267.18, 0), "s_outlast_e_bathhouse_reward", "s_outlast_e_bathhouse", "s_outlast_e_bathhouse_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (2093.79, 7100.31, 1895.75), (0, 134.62, 0), "pnd", "s_outlast_e_bathhouse", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (3950.86, 8082.54, 1436.5), (0, 238.74, 0), "zombie_spawn_wave_1", "s_outlast_e_bathhouse", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (2094.81, 7102.82, 1951.25), (0, 44.62, 0), "s_outlast_e_bathhouse", "s_outlast_e_bathhouse", "objective_outlast_e_bathhouse", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (1286.82, 8356.23, 1625.75), (0, 116.53, 0), "zombie_spawn_wave_3", "s_outlast_e_bathhouse", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (588.23, 7235.06, 1620), (0, 108.74, 0), "zombie_spawn_wave_3", "s_outlast_e_bathhouse", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (1333.42, 5599.94, 1619.75), (0, 238.74, 0), "zombie_spawn_wave_2", "s_outlast_e_bathhouse", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (3043.1, 5299.92, 1619), (0, 316.34, 0), "zombie_spawn_wave_2", "s_outlast_e_bathhouse", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (2490.62, 8999.48, 1441), (0, 182.74, 0), "zombie_spawn_wave_1", "s_outlast_e_bathhouse", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (3541.75, 3242.75, 1606), (0, 267.86, 0), "activity_nexus_instance_joiner", "s_outlast_e_bathhouse", "OUTLAST_E_BATHHOUSE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (92.25, 283.25, 164.5);
  s.var_74e936bbadd15418 = (304.5, 251.25, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (3253.61, 7353.45, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (2469.33, 7224.66, 1700), (0, 108.74, 0), "outlast_space", "s_outlast_e_bathhouse", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1900);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (92.25, 480.75, 164.5);
  s.var_74e936bbadd15418 = (304.5, 251.25, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (2765.86, 8032.2, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (92.25, 480.75, 164.5);
  s.var_74e936bbadd15418 = (191.75, 251.25, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (2001.36, 7956.7, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (73.5, 316, 164.5);
  s.var_74e936bbadd15418 = (97.5, -87.75, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (2422.11, 8092.95, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (266.5, 165.25, 164.5);
  s.var_74e936bbadd15418 = (394.25, 251.25, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (1469.86, 7853.7, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (1020, 308.5, 364.25);
  s.var_74e936bbadd15418 = (394.25, 206, 64.5);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (2930.61, 6259.7, 1657.75), (0, 44.14, 0), "outlast_noent_entrance_trigger", "s_outlast_e_bathhouse", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (-11570, 5999.17, 1110);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-11786.5, 5515.75, 1066.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1600];
  activityinstances["OUTLAST_E_WAREHOUSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (5992.08, -5663.88, 2454);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(6110.95, -5802.06, 2421.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["OUTLAST_E_DOME"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (2091.75, 7099.31, 1942.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(2542.2, 7247.94, 1676)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1800];
  activityinstances["OUTLAST_E_BATHHOUSE"] = instancestruct;
  return activityinstances;
}