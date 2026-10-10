/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_43ec7beab1d3ec4d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-20795, 10177, 2275), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_a_deck");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs");
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
    cf = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  }

  switch (instancename) {
    case #"hash_c6cc0097dbdcc706":
      function_12e4faea94896d5b(fe, us, cf);
      break;
    case #"hash_ca4e1ad682158b60":
      function_16cac6f06ba6a251(fe, us, cf);
      break;
    case #"hash_eae33a8ccb65fbaa":
      function_337564d76e179355(fe, us, cf);
      break;
    case #"hash_6cead0b4e5e2b2ae":
      function_4f37c70bf9df2d53(fe, us, cf);
      break;
    case #"hash_e887b0a286d510a5":
      function_eed9eb11200e2250(fe, us, cf);
      break;
  }
}

function function_12e4faea94896d5b(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-36866.2, 483.44, 1004.5), (0, 183.4, 0), "obelisk_spawn", "s_unstable_rift_obelisk_d_dock", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-36865.1, 482.45, 1085), (0, 93.4, 0), "s_unstable_rift_obelisk_d_dock", undefined, "activity_unstable_rift_obelisk_d_dock", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-36865.1, 485.42, 1002), (0, 48.4, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_d_dock", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_16cac6f06ba6a251(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-31628, 15538.6, 975.5), (0, 232.1, 0), "obelisk_spawn", "s_unstable_rift_obelisk_d_construction", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-31626.5, 15538.8, 1056), (0, 142.1, 0), "s_unstable_rift_obelisk_d_construction", undefined, "activity_unstable_rift_obelisk_d_construction", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-31628.7, 15540.7, 973), (0, 97.1, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_d_construction", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_337564d76e179355(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-26417.2, 10408.4, 1149.5), (0, 180.6, 0), "obelisk_spawn", "s_unstable_rift_obelisk_d_storage", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-26416.1, 10407.3, 1230), (0, 90.6, 0), "s_unstable_rift_obelisk_d_storage", undefined, "activity_unstable_rift_obelisk_d_storage", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-26416, 10410.2, 1147), (0, 45.6, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_d_storage", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_4f37c70bf9df2d53(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-23222.2, 4879.4, 1122.5), (0, 180.6, 0), "obelisk_spawn", "s_unstable_rift_obelisk_d_valley", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-23221.1, 4878.3, 1203), (0, 90.6, 0), "s_unstable_rift_obelisk_d_valley", undefined, "activity_unstable_rift_obelisk_d_valley", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-23221, 4881.2, 1120), (0, 45.6, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_d_valley", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_eed9eb11200e2250(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-23041, -2265.11, 1002.5), (0, 264.2, 0), "obelisk_spawn", "s_unstable_rift_obelisk_d_fire", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-23039.8, -2264.14, 1083), (0, 174.2, 0), "s_unstable_rift_obelisk_d_fire", undefined, "activity_unstable_rift_obelisk_d_fire", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-23042.7, -2263.72, 1000), (0, 129.2, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_d_fire", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-36866.8, 481.29, 1134);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-36867.8, 486.18, 1098)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_D_DOCK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-31626.8, 15536.7, 1105);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-31631.1, 15539.2, 1069)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_D_CONSTRUCTION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-26418, 10406.2, 1279);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-26418.7, 10411.2, 1243)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_D_STORAGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-23223, 4877.2, 1252);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-23223.7, 4882.2, 1216)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_D_VALLEY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_d_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-23038.9, -2266.15, 1132);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-23044, -2266.29, 1096)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_D_FIRE"] = instancestruct;
  return activityinstances;
}