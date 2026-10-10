/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3d1e2bb7b03b1421.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs");
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
    cf = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  }

  switch (instancename) {
    case #"hash_e1866da090ff385":
      function_9fa4aa5d1979f24(fe, us, cf);
      break;
    case #"hash_d64879d387a55a":
      function_6ae6134a8a4cafd3(fe, us, cf);
      break;
    case #"hash_602f4d3778891e5a":
      function_186e53c9f517e49(fe, us, cf);
      break;
    case #"hash_65434b545ca95c65":
      function_6748d5eb4b58268a(fe, us, cf);
      break;
    case #"hash_9ce81a4e42a1782f":
      function_a0c3fcc7bfcd3c84(fe, us, cf);
      break;
    case #"hash_20d8720f8a087e10":
      function_444b684c0f0a406d(fe, us, cf);
      break;
  }
}

function function_9fa4aa5d1979f24(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (30755.8, -11448.4, 2921.5), (0, 139.8, 0), "obelisk_spawn", "s_unstable_rift_obelisk_f_mall", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (30756, -11449.9, 3002), (0, 49.8, 0), "s_unstable_rift_obelisk_f_mall", undefined, "activity_unstable_rift_obelisk_f_mall", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (30757.8, -11447.8, 2919), (0, 4.8, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_f_mall", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6ae6134a8a4cafd3(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (40598.9, -7469.45, 2966.5), (0, 88.4, 0), "obelisk_spawn", "s_unstable_rift_obelisk_f_silo", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (40597.8, -7470.54, 3047), (0, 358.4, 0), "s_unstable_rift_obelisk_f_silo", undefined, "activity_unstable_rift_obelisk_f_silo", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (40600.6, -7470.64, 2964), (0, 313.4, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_f_silo", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_186e53c9f517e49(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (39224.9, 6331.4, 2902.5), (0, 126.5, 0), "obelisk_spawn", "s_unstable_rift_obelisk_f_radio", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (39224.7, 6329.86, 2983), (0, 36.5, 0), "s_unstable_rift_obelisk_f_radio", undefined, "activity_unstable_rift_obelisk_f_radio", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (39227, 6331.51, 2900), (0, 351.5, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_f_radio", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6748d5eb4b58268a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (43159.9, 14304.4, 3181.5), (0, 62.5, 0), "obelisk_spawn", "s_unstable_rift_obelisk_f_oil", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (43158.4, 14303.9, 3262), (0, 332.5, 0), "s_unstable_rift_obelisk_f_oil", undefined, "activity_unstable_rift_obelisk_f_oil", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (43160.9, 14302.5, 3179), (0, 287.5, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_f_oil", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_a0c3fcc7bfcd3c84(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (31369.9, 11767.4, 2062.5), (0, 48.6, 0), "obelisk_spawn", "s_unstable_rift_obelisk_f_pharm", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (31368.3, 11767.3, 2143), (0, 318.6, 0), "s_unstable_rift_obelisk_f_pharm", undefined, "activity_unstable_rift_obelisk_f_pharm", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (31370.4, 11765.3, 2060), (0, 273.6, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_f_pharm", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_444b684c0f0a406d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (26904, 961.4, 2094.5), (0, 262.9, 0), "obelisk_spawn", "s_unstable_rift_obelisk_f_dock", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (26905.2, 962.36, 2175), (0, 172.9, 0), "s_unstable_rift_obelisk_f_dock", undefined, "activity_unstable_rift_obelisk_f_dock", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (26902.4, 962.76, 2092), (0, 127.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_f_dock", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (30753.9, -11449.5, 3051);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(30756.5, -11445.4, 3015)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_F_MALL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (40596.8, -7468.66, 3096);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(40601.6, -7468.13, 3060)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_F_SILO"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (39222.8, 6330.73, 3032);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(39226.2, 6334.1, 2996)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_F_RADIO"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (43158.4, 14306, 3311);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(43162.9, 14304.4, 3275)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_F_OIL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (31368.8, 11769.3, 2192);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(31372.8, 11766.7, 2156)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_F_PHARM"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_f_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (26906, 960.42, 2224);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(26901.2, 960.32, 2188)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_F_DOCK"] = instancestruct;
  return activityinstances;
}