/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_fa7b94914d42b31.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-13100, 33110, 2263), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_a_tunnel");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-12392, 20741, 2196), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_a_hills");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs");
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
    cf = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  }

  switch (instancename) {
    case #"hash_fb80eef384aedc29":
      function_f9b77372acba696e(fe, us, cf);
      break;
    case #"hash_3247257a6c5f2146":
      function_21e87a86d1e409fd(fe, us, cf);
      break;
    case #"hash_d3f437d64e7a4bc7":
      function_7848286dec5cbb38(fe, us, cf);
      break;
    case #"hash_1d222be52f9d5918":
      function_31b6829014118181(fe, us, cf);
      break;
    case #"hash_e9d85e30bdb30f0f":
      function_588a2f74f57fce16(fe, us, cf);
      break;
  }
}

function function_f9b77372acba696e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-28115.2, 38220.5, 1566.5), (0, 135, 0), "obelisk_spawn", "s_unstable_rift_obelisk_a_gas", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-28115.2, 38219, 1647), (0, 45, 0), "s_unstable_rift_obelisk_a_gas", undefined, "activity_unstable_rift_obelisk_a_gas", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-28113, 38221, 1564), (0, 0, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_a_gas", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_21e87a86d1e409fd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-28169.2, 25345.5, 1271.5), (0, 135, 0), "obelisk_spawn", "s_unstable_rift_obelisk_a_train", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-28169.2, 25344, 1352), (0, 45, 0), "s_unstable_rift_obelisk_a_train", undefined, "activity_unstable_rift_obelisk_a_train", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-28167, 25346, 1269), (0, 0, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_a_train", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_7848286dec5cbb38(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-27115.2, 18101.5, 1552.5), (0, 135, 0), "obelisk_spawn", "s_unstable_rift_obelisk_a_radio", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-27115.2, 18100, 1633), (0, 45, 0), "s_unstable_rift_obelisk_a_radio", undefined, "activity_unstable_rift_obelisk_a_radio", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-27113, 18102, 1550), (0, 0, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_a_radio", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_31b6829014118181(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-15414.2, 37283.5, 2476.5), (0, 135, 0), "obelisk_spawn", "s_unstable_rift_obelisk_a_town", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-15414.2, 37282, 2557), (0, 45, 0), "s_unstable_rift_obelisk_a_town", undefined, "activity_unstable_rift_obelisk_a_town", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-15412, 37284, 2474), (0, 0, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_a_town", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_588a2f74f57fce16(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-18591.2, 18054.5, 2292.5), (0, 135, 0), "obelisk_spawn", "s_unstable_rift_obelisk_a_hill", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-18591.2, 18053, 2373), (0, 45, 0), "s_unstable_rift_obelisk_a_hill", undefined, "activity_unstable_rift_obelisk_a_hill", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-18589, 18055, 2290), (0, 0, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_a_hill", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-28117.2, 38219.5, 1696);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-28114.2, 38223.5, 1660)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_A_GAS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-28171.2, 25344.5, 1401);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-28168.2, 25348.5, 1365)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_A_TRAIN"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-27117.2, 18100.5, 1682);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-27114.2, 18104.5, 1646)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_A_RADIO"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-15416.2, 37282.5, 2606);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-15413.2, 37286.5, 2570)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_A_TOWN"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_a_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-18593.2, 18053.5, 2422);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-18590.2, 18057.5, 2386)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_A_HILL"] = instancestruct;
  return activityinstances;
}