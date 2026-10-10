/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_419394a994aff1cd.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (22480, 36660, 962), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_c_beach");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (18156, 25062, 1956), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_c_radio");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs");
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
    cf = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  }

  switch (instancename) {
    case #"hash_1b6a7f7cb79354a5":
      function_64a702424e3070d8(fe, us, cf);
      break;
    case #"hash_2d1300edb0a22043":
      function_42628b3547229438(fe, us, cf);
      break;
    case #"hash_e052520349f351c9":
      function_aeeaeb4d3acd86fc(fe, us, cf);
      break;
    case #"hash_d25ce7f97b7d5aa3":
      function_a5f7233772635bb4(fe, us, cf);
      break;
    case #"hash_baca6e3d099b3d9f":
      function_60f96c94b81dd5ea(fe, us, cf);
      break;
    case #"hash_6324bc53754eade9":
      function_b25b5f013dc76ada(fe, us, cf);
      break;
  }
}

function function_64a702424e3070d8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (30449.2, 40339.3, 1001.5), (0, 152.4, 0), "obelisk_spawn", "s_unstable_rift_obelisk_c_port", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (30449.7, 40337.9, 1082), (0, 62.4, 0), "s_unstable_rift_obelisk_c_port", undefined, "activity_unstable_rift_obelisk_c_port", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (30451.1, 40340.4, 999), (0, 17.4, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_c_port", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_42628b3547229438(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (32335.5, 33330.2, 1189.5), (0, 306.5, 0), "obelisk_spawn", "s_unstable_rift_obelisk_c_gas", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (32335.7, 33331.6, 1270), (0, 216.5, 0), "s_unstable_rift_obelisk_c_gas", undefined, "activity_unstable_rift_obelisk_c_gas", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (32333.3, 33330, 1187), (0, 171.5, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_c_gas", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_aeeaeb4d3acd86fc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (39770.4, 32618.4, 1763.5), (0, 229.9, 0), "obelisk_spawn", "s_unstable_rift_obelisk_c_military", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (39771.8, 32618.5, 1844), (0, 139.9, 0), "s_unstable_rift_obelisk_c_military", undefined, "activity_unstable_rift_obelisk_c_military", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (39769.7, 32620.5, 1761), (0, 94.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_c_military", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_a5f7233772635bb4(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (44630.4, 34600.5, 2656.5), (0, 192.9, 0), "obelisk_spawn", "s_unstable_rift_obelisk_c_satellite", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (44631.5, 34599.7, 2737), (0, 102.9, 0), "s_unstable_rift_obelisk_c_satellite", undefined, "activity_unstable_rift_obelisk_c_satellite", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (44631.1, 34602.6, 2654), (0, 57.9, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_c_satellite", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_60f96c94b81dd5ea(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (26621.5, 21537.2, 1354.5), (0, 270.8, 0), "obelisk_spawn", "s_unstable_rift_obelisk_c_rotary", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (26622.5, 21538.2, 1435), (0, 180.8, 0), "s_unstable_rift_obelisk_c_rotary", undefined, "activity_unstable_rift_obelisk_c_rotary", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (26619.6, 21538.3, 1352), (0, 135.8, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_c_rotary", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_b25b5f013dc76ada(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (18494.3, 24464.4, 1976.5), (0, 306.8, 0), "obelisk_spawn", "s_unstable_rift_obelisk_c_radio", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (18494.5, 24465.8, 2057), (0, 216.8, 0), "s_unstable_rift_obelisk_c_radio", undefined, "activity_unstable_rift_obelisk_c_radio", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (18492.1, 24464.2, 1974), (0, 171.8, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_c_radio", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (30447.6, 40337.8, 1131);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(30449.3, 40342.4, 1095)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_C_PORT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (32337.6, 33330.8, 1319);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(32334.1, 33327.4, 1283)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_C_GAS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (39771.5, 32616.5, 1893);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(39767.3, 32619.1, 1857)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_C_MILITARY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (44630.1, 34598.3, 2786);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(44628.3, 34602.9, 2750)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_C_SATELLITE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (26623.6, 21536.4, 1484);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(26618.8, 21535.7, 1448)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_C_ROTARY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_c_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (18496.5, 24465, 2106);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(18493, 24461.6, 2070)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_C_RADIO"] = instancestruct;
  return activityinstances;
}