/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7e681eb8fbdc4f5e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_contracts_outlast_cs");
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
    cf = "mp_jup_sira_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_f1fa6b40a1f2f7f5":
      function_1c879a87cf6224(fe, us, cf);
      break;
    case #"hash_6945356d170a73a0":
      function_741a8c082e97c3c1(fe, us, cf);
      break;
  }
}

function function_1c879a87cf6224(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-31005.7, -25609.7, 252), (0, 338.62, 0), "zombie_spawn_wave_3", "s_outlast_sira", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-30216.8, -26300.2, 256), (0, 289, 0), "s_outlast_sira_reward", "s_outlast_sira", "s_outlast_sira_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-30110.7, -26603.9, 256), (0, 200, -0), "pnd", "s_outlast_sira", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-29715.6, -25565.5, 252), (0, 220.44, 0), "zombie_spawn_wave_2", "s_outlast_sira", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-36698.7, -24080.4, 1024), (0, 193.56, 0), "activity_nexus_instance_joiner", "s_outlast_sira", "OUTLAST_SIRA", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-29966.6, -25239.6, 252), (0, 236.9, 0), "zombie_spawn_wave_1", "s_outlast_sira", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-30162, -26415, 256), (0, 291.68, 0), "s_outlast_sira", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-30981.6, -25893.8, 252), (0, 20.61, 0), "zombie_spawn_wave_2", "s_outlast_sira", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-30961.2, -26310.6, 250), (0, 347.64, 0), "zombie_spawn_wave_1", "s_outlast_sira", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-31019.8, -26634.4, 250.11), (0, 14.07, 0), "zombie_spawn_wave_2", "s_outlast_sira", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-30435.8, -27387.3, 252), (0, 72.77, 0), "zombie_spawn_wave_1", "s_outlast_sira", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-30049.5, -27430.2, 250.12), (0, 96.43, 0), "zombie_spawn_wave_1", "s_outlast_sira", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-29702.7, -27313.5, 250.07), (0, 120.5, 0), "zombie_spawn_wave_3", "s_outlast_sira", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-29414.4, -27072.9, 250.08), (0, 133.37, 0), "zombie_spawn_wave_2", "s_outlast_sira", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-29362, -26050.1, 250.11), (0, 199.52, 0), "zombie_spawn_wave_1", "s_outlast_sira", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (421.25, 927, 178);
  s.var_74e936bbadd15418 = (338.75, -458.75, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-30162, -26472, 256), (0, 18.9, 0), "outlast_noent_entrance_trigger", "s_outlast_sira", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-29582.6, -25880.3, 252), (0, 214.44, 0), "zombie_spawn_wave_3", "s_outlast_sira", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-30162, -26415, 256), (0, 291.5, 0), "outlast_space", "s_outlast_sira", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1500);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 195;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-30164, -26415, 256), (0, 20, 0), "outlast_noent_entrance_trigger", "s_outlast_sira", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 508);
}

function function_741a8c082e97c3c1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-36545.2, -16812.7, 252), (0, 338.62, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-36311.6, -18051.8, 251.5), (0, 214.44, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-35836.5, -16872.7, 315), (0, 315.72, 0), "s_outlast_sira_reward", "s_outlast_s2_5_mission_stadium", "s_outlast_sira_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "PND";
  fe[[f]](s, us, cf, (-35850.2, -16974.9, 316), (0, 217.12, -0), "pnd", "s_outlast_s2_5_mission_stadium", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-35189.1, -16660, 252), (0, 220.44, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-35137.2, -8430.9, 1725.5), (0, 193.56, 0), "activity_nexus_instance_joiner", "s_outlast_s2_5_mission_stadium", "OUTLAST_SIRA", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-35446.6, -16406.6, 252), (0, 236.9, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "s_outlast_s2_5_mission_stadium";
  fe[[f]](s, us, cf, (-35464, -17428.5, 345), (0, 291.68, 0), "s_outlast_s2_5_mission_stadium", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-36455.1, -16988.3, 252), (0, 20.61, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-36441.2, -17477.6, 250), (0, 347.64, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-36493.3, -17728.9, 250.11), (0, 14.07, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-35915.8, -18554.3, 252), (0, 72.77, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-35529.5, -18597.2, 250.12), (0, 96.43, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-35242.2, -18516.5, 250.07), (0, 120.5, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-34887.9, -18167.4, 250.08), (0, 133.37, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-34842, -17217.1, 250.11), (0, 199.52, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (609.25, 823, 178);
  s.var_74e936bbadd15418 = (1946.75, 1069.25, 32);
  s.height = 128;
  s.length = "128";
  s.name = "noent_volume_trigger_box";
  s.width = "128";
  fe[[f]](s, us, cf, (-35134.5, -16816, 205.5), (0, 37.08, 0), "outlast_noent_entrance_trigger", "s_outlast_s2_5_mission_stadium", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-35122.1, -17083.3, 252), (0, 214.44, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.name = "outlast_space";
  fe[[f]](s, us, cf, (-35658.5, -17314, 256), (0, 291.5, 0), "outlast_space", "s_outlast_s2_5_mission_stadium", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1000);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 195;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-35654.5, -17269.5, 256), (0, 20, 0), "outlast_noent_entrance_trigger", "s_outlast_s2_5_mission_stadium", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_sira_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (-30165, -26417.7, 256);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-30162, -26415, 256)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["OUTLAST_SIRA"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast_s2_5_mission_stadium";
  instancestruct.cf = "mp_jup_sira_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (-35876, -16911.7, 384.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-35468.5, -17417.5, 256)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1200];
  activityinstances["OUTLAST_S2_5_MISSION_STADIUM"] = instancestruct;
  return activityinstances;
}