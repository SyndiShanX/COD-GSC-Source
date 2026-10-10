/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_497b9e26c1cf1a39.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_contracts_outlast_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_OUTLAST";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydefinition_outlast";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_h_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_78899305d98ed1c2":
      function_cc3d0b6bf553becd(fe, us, cf);
      break;
    case #"hash_34c6c63328dfb840":
      function_565a5413e09dffbf(fe, us, cf);
      break;
  }
}

function function_cc3d0b6bf553becd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (125, 26, 443);
  s.var_74e936bbadd15418 = (105, 714, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (4764.4, -24341.7, 1774.5), (0, 344.48, 0), "outlast_noent_entrance_trigger", "s_outlast_h_theater", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (125, 26, 443);
  s.var_74e936bbadd15418 = (105, 714, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (4985.4, -23571.7, 1774.5), (0, 164.48, 0), "outlast_noent_entrance_trigger", "s_outlast_h_theater", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (670, 26, 443);
  s.var_74e936bbadd15418 = (320, 714, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (4964.4, -23631.7, 1774.5), (0, 344.48, 0), "outlast_noent_entrance_trigger", "s_outlast_h_theater", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (4846.83, -24019.3, 1743.5), (0, 23.97, 0), "s_outlast_h_theater_reward", "s_outlast_h_theater", "s_outlast_h_theater_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (4733, -23992.6, 1743.5), (0, 74.81, 0), "pnd", "s_outlast_h_theater", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5609.5, -25063.5, 1717.5), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_h_theater", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (4724.26, -23991, 1802), (0, 164.81, 0), "s_outlast_h_theater", "s_outlast_h_theater", "objective_outlast_h_theater", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (3611.75, -23862, 1465.75), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_h_theater", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (3633.75, -23629.2, 1940), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_h_theater", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5069, -22640.8, 1932), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_h_theater", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (3720, -23341.5, 1465.75), (0, 135, 0), "zombie_spawn_wave_2", "s_outlast_h_theater", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (4744, -25600.2, 1739.5), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_h_theater", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (15100, -21124.5, 1648.25), (0, 131.63, 0), "activity_nexus_instance_joiner", "s_outlast_h_theater", "OUTLAST_H_THEATER", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5496, -24333, 1746), (0, 80.8, 0), "ava_tablet", "s_outlast_h_theater", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (607, 51, 443);
  s.var_74e936bbadd15418 = (498, 197, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (4985.4, -23571.7, 1774.5), (0, 164.48, 0), "outlast_noent_entrance_trigger", "s_outlast_h_theater", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (607, 51, 443);
  s.var_74e936bbadd15418 = (498, 197, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (4737.4, -24490.7, 1774.5), (0, 164.48, 0), "outlast_noent_entrance_trigger", "s_outlast_h_theater", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (707, 211, 443);
  s.var_74e936bbadd15418 = (-196, 857, -89);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (4002.4, -23371.7, 1774.5), (0, 344.48, 0), "outlast_noent_entrance_trigger", "s_outlast_h_theater", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (4325.25, -23826.5, 1782), (0, 135, 0), "outlast_space", "s_outlast_h_theater", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1800);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (5990.5, -23572.5, 1717.5), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_h_theater", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_565a5413e09dffbf(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (312.75, 137.75, 241.5);
  s.var_74e936bbadd15418 = (265.75, 524, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (825.4, -36376.2, 2132.25), (0, 15.57, 0), "outlast_noent_entrance_trigger", "s_outlast_h_gym", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (181.75, 445, 95.5);
  s.var_74e936bbadd15418 = (265.75, 403.25, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (1649.15, -36746.2, 2132.25), (0, 15.57, 0), "outlast_noent_entrance_trigger", "s_outlast_h_gym", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (106.25, 148, 337.25);
  s.var_74e936bbadd15418 = (94.5, 151.5, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (636.15, -37294.7, 2132.25), (0, 15.57, 0), "outlast_noent_entrance_trigger", "s_outlast_h_gym", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (519, 329.25, 241.5);
  s.var_74e936bbadd15418 = (527.75, 524, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (948.4, -36817.7, 2132.25), (0, 15.57, 0), "outlast_noent_entrance_trigger", "s_outlast_h_gym", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (801.83, -36651.1, 2101.5), (0, 23.97, 0), "s_outlast_h_gym_reward", "s_outlast_h_gym", "s_outlast_h_gym_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (833.25, -36767.6, 2103.75), (0, 194.6, 0), "pnd", "s_outlast_h_gym", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (2789, -36052.2, 1962.75), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_h_gym", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (831.55, -36765.4, 2162.25), (0, 104.6, 0), "s_outlast_h_gym", "s_outlast_h_gym", "objective_outlast_h_gym", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (728.75, -36866.3, 2367.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_h_gym", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (120.25, 383.25, 78.5);
  s.var_74e936bbadd15418 = (94.5, 485.75, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (355.4, -37023.9, 2001.25), (0, 15, 0), "outlast_noent_entrance_trigger", "s_outlast_h_gym", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-635.75, -35052.3, 1957.75), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_h_gym", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-1258, -36704.3, 2062.5), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_h_gym", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-8988.25, -39022.4, 2325.5), (0, 19.59, 0), "activity_nexus_instance_joiner", "s_outlast_h_gym", "OUTLAST_H_GYM", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (2727.75, -34850.2, 1963.5), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_h_gym", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (536.5, -34214.6, 1949.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_h_gym", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (609, -36588, 2106), (0, 353.1, 0), "ava_tablet", "s_outlast_h_gym", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (905.75, -36866.1, 2027.75), (0, 135, 0), "outlast_space", "s_outlast_h_gym", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1600);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_h_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (4728.81, -23991.9, 1793);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(4416, -23851.8, 1842.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1800];
  activityinstances["OUTLAST_H_THEATER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_h_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (833.02, -36769.8, 2153.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(962.5, -36873.3, 2078.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["OUTLAST_H_GYM"] = instancestruct;
  return activityinstances;
}