/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_14c0c0fe8f807d31.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (2376, -829, 1812), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_e_bus");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (16771, 4744, 1905), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_e_doublebridge");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (25377, -5081, 3059.92), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_e_townhill");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (20112, 11727, 1650), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_e_construction");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs");
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
    cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  }

  switch (instancename) {
    case #"hash_4e0636091417df3b":
      function_166fd55705b01aea(fe, us, cf);
      break;
    case #"hash_e5b00817d626f4eb":
      function_a18a23193e81c354(fe, us, cf);
      break;
    case #"hash_196a04b5a86674be":
      function_b56c01a98a320bfb(fe, us, cf);
      break;
    case #"hash_eae09f5df21e65e8":
      function_f5b97120556f1ba7(fe, us, cf);
      break;
    case #"hash_16e037b220531d2d":
      function_ec295d1cc03b9e50(fe, us, cf);
      break;
    case #"hash_1aac8bee86f152f4":
      function_7e61bfacaf354b45(fe, us, cf);
      break;
    case #"hash_c7a59150c9d3c5b7":
      function_179013bbaa5437a(fe, us, cf);
      break;
    case #"hash_f470bfbb06fcf204":
      function_6f95cb45438b9fd(fe, us, cf);
      break;
    case #"hash_72bbd8a192f263f6":
      function_9749fcdd5a94e181(fe, us, cf);
      break;
    case #"hash_63fb8af41315205c":
      function_4d7a29eee2f8ed39(fe, us, cf);
      break;
    case #"hash_c7c48350c9ebb493":
      function_182073bbaaf6f5a(fe, us, cf);
      break;
  }
}

function function_166fd55705b01aea(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (11973, 9470.62, 2648.5), (0, 160.9, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_hill", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (11973.7, 9469.27, 2729), (0, 70.9, 0), "s_unstable_rift_obelisk_e_hill", undefined, "activity_unstable_rift_obelisk_e_hill", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (11974.7, 9471.96, 2646), (0, 25.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_hill", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_a18a23193e81c354(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (23372.9, -11819.5, 3154.5), (0, 141.5, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_radio", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (23373.1, -11821, 3235), (0, 51.5, 0), "s_unstable_rift_obelisk_e_radio", undefined, "activity_unstable_rift_obelisk_e_radio", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (23375, -11818.8, 3152), (0, 6.5, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_radio", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_b56c01a98a320bfb(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-16113, 7018.62, 1269.5), (0, 133.7, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_police", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-16113, 7017.1, 1350), (0, 43.7, 0), "s_unstable_rift_obelisk_e_police", undefined, "activity_unstable_rift_obelisk_e_police", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-16110.9, 7019.03, 1267), (0, 358.7, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_police", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_f5b97120556f1ba7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (15578.9, -117.47, 1644.5), (0, 122, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_parking", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (15578.6, -118.96, 1725), (0, 32, 0), "s_unstable_rift_obelisk_e_parking", undefined, "activity_unstable_rift_obelisk_e_parking", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (15581.2, -117.55, 1642), (0, 347, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_parking", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_ec295d1cc03b9e50(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-4690.94, -6036.39, 1420.5), (0, 104.1, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_bridge", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-4691.69, -6037.7, 1501), (0, 14.1, 0), "s_unstable_rift_obelisk_e_bridge", undefined, "activity_unstable_rift_obelisk_e_bridge", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-4688.85, -6037.14, 1418), (0, 329.1, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_bridge", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_7e61bfacaf354b45(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (21496, 960.57, 2149.5), (0, 48.4, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_town", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (21494.5, 960.45, 2230), (0, 318.4, 0), "s_unstable_rift_obelisk_e_town", undefined, "activity_unstable_rift_obelisk_e_town", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (21496.6, 958.42, 2147), (0, 273.4, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_town", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_179013bbaa5437a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-10687, 494.62, 1054.5), (0, 160.9, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_dock", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-10686.3, 493.27, 1135), (0, 70.9, 0), "s_unstable_rift_obelisk_e_dock", undefined, "activity_unstable_rift_obelisk_e_dock", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-10685.3, 495.96, 1052), (0, 25.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_dock", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6f95cb45438b9fd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-2562.02, 12811.6, 1053.5), (0, 180.1, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_tracks", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-2560.91, 12810.6, 1134), (0, 90.1, 0), "s_unstable_rift_obelisk_e_tracks", undefined, "activity_unstable_rift_obelisk_e_tracks", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-2560.85, 12813.4, 1051), (0, 45.1, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_tracks", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_9749fcdd5a94e181(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-623, 7368.6, 1623.5), (0, 241.3, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_cliff", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-621.55, 7369.04, 1704), (0, 151.3, 0), "s_unstable_rift_obelisk_e_cliff", undefined, "activity_unstable_rift_obelisk_e_cliff", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-624.02, 7370.56, 1621), (0, 106.3, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_cliff", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_4d7a29eee2f8ed39(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-4839.03, 1041.62, 2007.5), (0, 147.9, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_castle", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (-4838.67, 1040.15, 2088), (0, 57.9, 0), "s_unstable_rift_obelisk_e_castle", undefined, "activity_unstable_rift_obelisk_e_castle", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (-4837.01, 1042.53, 2005), (0, 12.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_castle", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_182073bbaaf6f5a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (6146.01, -7268.44, 2394.5), (0, 49.4, 0), "obelisk_spawn", "s_unstable_rift_obelisk_e_dome", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (6144.5, -7268.58, 2475), (0, 319.4, 0), "s_unstable_rift_obelisk_e_dome", undefined, "activity_unstable_rift_obelisk_e_dome", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (6146.6, -7270.57, 2392), (0, 274.4, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_e_dome", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (11971.6, 9468.87, 2778);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(11972.6, 9473.75, 2742)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_HILL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (23371, -11820.6, 3284);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(23373.6, -11816.4, 3248)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_RADIO"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-16115, 7017.71, 1399);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-16111.9, 7021.59, 1363)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_POLICE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (15576.8, -117.95, 1774);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(15580.6, -114.77, 1738)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_PARKING"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-4693.16, -6036.17, 1550);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-4688.55, -6034.32, 1514)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_BRIDGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (21495, 962.52, 2279);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(21499.1, 959.76, 2243)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_TOWN"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-10688.4, 492.87, 1184);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-10687.4, 497.75, 1148)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_DOCK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-2562.77, 12809.5, 1183);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-2563.43, 12814.4, 1147)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_TRACKS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-621.51, 7366.92, 1753);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-626.15, 7368.7, 1717)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_CLIFF"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (-4840.79, 1040.24, 2137);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-4838.74, 1044.77, 2101)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_CASTLE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_e_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (6144.9, -7266.5, 2524);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(6149.08, -7269.19, 2488)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_E_DOME"] = instancestruct;
  return activityinstances;
}