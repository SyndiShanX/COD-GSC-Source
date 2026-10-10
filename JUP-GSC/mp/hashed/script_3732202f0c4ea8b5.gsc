/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3732202f0c4ea8b5.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_UNSTABLE_RIFT_OBELISK";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  }

  switch (instancename) {
    case #"hash_1aa3aa0fdd95f499":
      function_bc21572ee5284ffa(fe, us, cf);
      break;
    case #"hash_d4e68748a5983384":
      function_d3c86c91e409fdfd(fe, us, cf);
      break;
    case #"hash_6f180d18b43dde91":
      function_17490c231fbf2bc4(fe, us, cf);
      break;
    case #"hash_55f5f3df308355f8":
      function_bdab8d954c96e0df(fe, us, cf);
      break;
    case #"hash_8292cf3bd70c48af":
      function_b8fbb6d2a2aac070(fe, us, cf);
      break;
  }
}

function function_bc21572ee5284ffa(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (16237.8, -19983.2, 1477.5), (0, 87.1, 0), "obelisk_spawn", "s_unstable_rift_obelisk_h_river", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (16236.8, -19984.1, 1558), (0, 357.1, 0), "s_unstable_rift_obelisk_h_river", undefined, "activity_unstable_rift_obelisk_h_river", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (16239.7, -19984.4, 1475), (0, 312.1, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_h_river", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_d3c86c91e409fdfd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (16523.6, -32043.8, 2755.5), (0, 262.8, 0), "obelisk_spawn", "s_unstable_rift_obelisk_h_construction", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (16524.7, -32043, 2836), (0, 172.79, 0), "s_unstable_rift_obelisk_h_construction", undefined, "activity_unstable_rift_obelisk_h_construction", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (16521.9, -32042.5, 2753), (0, 127.8, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_h_construction", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_17490c231fbf2bc4(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (3559.63, -42962.8, 2919.5), (0, 275.89, 0), "obelisk_spawn", "s_unstable_rift_obelisk_h_farm", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (3560.49, -42961.7, 3000), (0, 185.9, 0), "s_unstable_rift_obelisk_h_farm", undefined, "activity_unstable_rift_obelisk_h_farm", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (3557.6, -42962, 2917), (0, 140.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_h_farm", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_bdab8d954c96e0df(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (7318.65, -15348.8, 1704.5), (0, 259.99, 0), "obelisk_spawn", "s_unstable_rift_obelisk_h_canal", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (7319.77, -15348, 1785), (0, 169.99, 0), "s_unstable_rift_obelisk_h_canal", undefined, "activity_unstable_rift_obelisk_h_canal", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (7316.92, -15347.4, 1702), (0, 125, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_h_canal", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_b8fbb6d2a2aac070(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-904.3, -27108.9, 1705.5), (0, 168.89, 0), "obelisk_spawn", "s_unstable_rift_obelisk_h_parking", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-903.52, -27110, 1786), (0, 78.89, 0), "s_unstable_rift_obelisk_h_parking", undefined, "activity_unstable_rift_obelisk_h_parking", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-902.87, -27107.2, 1703), (0, 33.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_h_parking", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (16235.7, -19982.2, 1607);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(16240.7, -19981.8, 1571)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_H_RIVER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (16525.6, -32045, 2885);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(16520.6, -32045, 2849)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_H_CONSTRUCTION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (3561.84, -42963.5, 3049);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(3556.94, -42964.6, 3013)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_H_FARM"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (7320.58, -15350.1, 1834);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(7315.57, -15349.8, 1798)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_H_CANAL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_h_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-905.64, -27110.8, 1835);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-905.24, -27105.8, 1799)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_H_PARKING"] = instancestruct;
  return activityinstances;
}