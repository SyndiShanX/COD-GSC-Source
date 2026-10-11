/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_16c63a7997e1925e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_tower_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_tower_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_tower_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_tower_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_tower_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_tower_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_tower_ob_contracts_outlast_cs");
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
    cf = "mp_jup_tower_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_1c274567fb887d8d":
      function_d5906f24076a2b46(fe, us, cf);
      break;
  }
}

function function_d5906f24076a2b46(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (16745.5, 21521.3, 279), (0, 225.69, 0), "zombie_spawn_wave_3", "s_outlast_tower", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (15455.2, 20855.7, 279), (0, 359.36, 0), "s_outlast_tower_reward", "s_outlast_tower", "s_outlast_tower_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (15438.9, 21108.6, 279), (0, 45, 0), "pnd", "s_outlast_tower", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (16200.3, 20214, 279), (0, 100.86, 0), "zombie_spawn_wave_3", "s_outlast_tower", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (14085.8, 20889.4, 279), (0, 50.38, 0), "zombie_spawn_wave_2", "s_outlast_tower", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (15741.5, 25813, 2478.71), (360, 41.97, 0), "activity_nexus_instance_joiner", "s_outlast_tower", "OUTLAST_TOWER", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (16716.1, 21534.2, 279), (0, 236.81, 0), "zombie_spawn_wave_1", "s_outlast_tower", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (15498, 21197.2, 279), (0, 135.8, 0), "s_outlast_tower", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (14042.8, 20956.4, 279), (0, 35.34, 0), "zombie_spawn_wave_3", "s_outlast_tower", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (15193.1, 21862.7, 415), (0, 269.22, 0), "zombie_spawn_wave_2", "s_outlast_tower", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (14070.6, 20930.5, 279), (0, 31.85, 0), "zombie_spawn_wave_1", "s_outlast_tower", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (16224.6, 20225.4, 279), (0, 92.67, 0), "zombie_spawn_wave_1", "s_outlast_tower", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (15221.2, 21853.2, 415), (0, 271.03, 0), "zombie_spawn_wave_1", "s_outlast_tower", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (16754.6, 21575.5, 279), (0, 228.59, 0), "zombie_spawn_wave_2", "s_outlast_tower", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (16267.7, 20204.7, 279), (0, 121.23, 0), "zombie_spawn_wave_2", "s_outlast_tower", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (201, 828, 259);
  s.var_74e936bbadd15418 = (810, 641, 20);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (15508, 21409.9, 281.5), (0, 90, 0), "outlast_noent_entrance_trigger", "s_outlast_tower", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (15245.6, 21858.9, 415), (0, 266.98, 0), "zombie_spawn_wave_3", "s_outlast_tower", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (15518.6, 21230.5, 279), (0, 209.5, 0), "outlast_space", "s_outlast_tower", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1000);
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (15302.3, 20809.2, 639), (0, 100.86, 0), "zombie_spawn_wave_3", "s_outlast_tower", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (47, 446, 259);
  s.var_74e936bbadd15418 = (40, 323, 20);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (15289.8, 21648.9, 281.5), (0, 90, 0), "outlast_noent_entrance_trigger", "s_outlast_tower", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (159, 118, 259);
  s.var_74e936bbadd15418 = (210, 85, 20);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (14599.3, 20816.7, 281.5), (0, 90, 0), "outlast_noent_entrance_trigger", "s_outlast_tower", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (71, 220, 259);
  s.var_74e936bbadd15418 = (88, 113, 20);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (15280.1, 20534.9, 281.5), (0, 90, 0), "outlast_noent_entrance_trigger", "s_outlast_tower", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (15283.9, 20801.5, 639), (0, 271.03, 0), "zombie_spawn_wave_1", "s_outlast_tower", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (15294.3, 20803.8, 639), (0, 228.59, 0), "zombie_spawn_wave_2", "s_outlast_tower", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_tower_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (4675.73, 21408.2, 498);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(4477.33, 21497.5, 369)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1];
  activityinstances["OUTLAST_TOWER"] = instancestruct;
  return activityinstances;
}