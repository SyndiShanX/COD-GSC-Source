/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5d6ed014c2d8f225.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_contracts_outlast_cs");
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
    cf = "mp_jup_st_a_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_d8a88716f7628b56":
      function_67513f24ddc4a0ef(fe, us, cf);
      break;
    case #"hash_93b1e158b795272f":
      function_bf89fe441d231e26(fe, us, cf);
      break;
    case #"hash_ed7db5b52705e02e":
      function_5b51c7f81eb1826f(fe, us, cf);
      break;
  }
}

function function_67513f24ddc4a0ef(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-29920.5, 32267.8, 1377.75), (0, 265, 0), "ava_tablet", "s_outlast_a_atrium", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-29932, 31991.2, 1372.5), (0, 337.22, 0), "s_outlast_a_atrium_reward", "s_outlast_a_atrium", "s_outlast_a_atrium_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-29763.5, 31853.4, 1439.5), (0, 208.06, 0), "pnd", "s_outlast_a_atrium", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-28738, 31080.5, 1436.5), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_a_atrium", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-29765.6, 31855.1, 1498), (0, 118.06, 0), "s_outlast_a_atrium", "s_outlast_a_atrium", "objective_outlast_a_atrium", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-31075, 31001.5, 1371), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_a_atrium", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-30283.5, 32588.5, 1436), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_a_atrium", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-29301, 30781, 1434.5), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_a_atrium", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-34178, 29149.5, 1179.25), (0, 52.74, 0), "activity_nexus_instance_joiner", "s_outlast_a_atrium", "OUTLAST_A_ATRIUM", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (1046.5, 1695, 253.5);
  s.var_74e936bbadd15418 = (729.5, 414, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-29197.1, 31817.8, 1407.5), (0, 118.64, 0), "outlast_noent_entrance_trigger", "s_outlast_a_atrium", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-29542, 31688.5, 1558), (0, 135, 0), "outlast_space", "s_outlast_a_atrium", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 2200);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-29532.5, 33157.5, 1436), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_a_atrium", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_bf89fe441d231e26(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (60.5, 120, 228.5);
  s.var_74e936bbadd15418 = (174.5, 70, 76);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-22597.1, 21511.8, 1898.5), (0, 90.04, 0), "outlast_noent_entrance_trigger", "s_outlast_a_dealership", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-22378, 21204.2, 1734.5), (0, 283.32, 0), "s_outlast_a_dealership_reward", "s_outlast_a_dealership", "s_outlast_a_dealership_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-22372.1, 21303.3, 1732.5), (0, 0.46, 0), "pnd", "s_outlast_a_dealership", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-20583, 20998.5, 1732.5), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_a_dealership", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-22371, 21300.8, 1791), (0, 270.46, 0), "s_outlast_a_dealership", "s_outlast_a_dealership", "objective_outlast_a_dealership", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-20695, 21965.5, 1724), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_a_dealership", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-21639, 23338.5, 1709), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_a_dealership", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-24114.5, 22716.5, 1666), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_a_dealership", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-23864, 20339, 1676.5), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_a_dealership", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-17847.5, 17752.5, 2336.75), (0, 131.24, 0), "activity_nexus_instance_joiner", "s_outlast_a_dealership", "OUTLAST_A_DEALERSHIP", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (546.5, 841, 228.5);
  s.var_74e936bbadd15418 = (630.5, 634, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-22597.1, 21511.8, 1762.5), (0, 90.04, 0), "outlast_noent_entrance_trigger", "s_outlast_a_dealership", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-22728.5, 21520, 1735), (0, 135, 0), "outlast_space", "s_outlast_a_dealership", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1300);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-22185.5, 19679.5, 1655), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_a_dealership", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-22621.5, 21021.8, 1734.75), (0, 265, 0), "ava_tablet", "s_outlast_a_dealership", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5b51c7f81eb1826f(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15447.5, 34090.8, 1423.75), (0, 88.32, 0), "s_outlast_a_tunnel_reward", "s_outlast_a_tunnel", "s_outlast_a_tunnel_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15052.1, 34170.3, 1424), (0, 180.46, 0), "pnd", "s_outlast_a_tunnel", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-14184, 34192, 1424), (0, 30, 0), "zombie_spawn_wave_1", "s_outlast_a_tunnel", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15062.5, 34166.8, 1482.5), (0, 270.46, 0), "s_outlast_a_tunnel", "s_outlast_a_tunnel", "objective_outlast_a_tunnel", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15484, 34392, 1256), (0, 320, 0), "zombie_spawn_wave_3", "s_outlast_a_tunnel", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-14952.5, 33488.3, 1608), (0, 310.12, 0), "zombie_spawn_wave_3", "s_outlast_a_tunnel", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15254, 34394.8, 1253.5), (0, 229.16, 0), "zombie_spawn_wave_2", "s_outlast_a_tunnel", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15494, 33497.5, 1608), (0, 261.88, 0), "zombie_spawn_wave_2", "s_outlast_a_tunnel", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-16167, 31325.8, 2840), (0, 269.17, 0), "activity_nexus_instance_joiner", "s_outlast_a_tunnel", "OUTLAST_A_TUNNEL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (278.5, 907, 310.5);
  s.var_74e936bbadd15418 = (452.5, 1082, 4);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-15288.3, 34115.3, 1428), (0, 90.04, 0), "outlast_noent_entrance_trigger", "s_outlast_a_tunnel", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15181, 34113.5, 1426.5), (0, 135, 0), "outlast_space", "s_outlast_a_tunnel", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1050);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-17015.3, 34048.8, 1248), (0, 44.11, 0), "zombie_spawn_wave_1", "s_outlast_a_tunnel", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-15117.5, 34356.6, 1428), (0, 270.37, 0), "ava_tablet", "s_outlast_a_tunnel", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (-29700.7, 31724.2, 1522);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-29689.2, 31736.8, 1511.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2200];
  activityinstances["OUTLAST_A_ATRIUM"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (-22371.3, 21305.4, 1782);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-22660, 21523, 1715.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1300];
  activityinstances["OUTLAST_A_DEALERSHIP"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (-15062.8, 34171.4, 1473.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-15079, 34152, 1415), (-14475, 34152, 1415), (-15903, 34144, 1415), (-15623, 34152, 1415)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [400, 400, 400, 400];
  activityinstances["OUTLAST_A_TUNNEL"] = instancestruct;
  return activityinstances;
}