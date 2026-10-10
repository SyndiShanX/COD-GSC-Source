/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4b13b59dbb4394e1.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (20308, -14821, 3376), (0, 0, 0), "unstable_rift_portal", undefined, "unstable_rift_portal_i_hills");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs");
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
    cf = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  }

  switch (instancename) {
    case #"hash_60496c08d6585497":
      function_3e3f1c09b0fa92c(fe, us, cf);
      break;
    case #"hash_1ffed5771d057c2c":
      function_5e52aa8695e7efc5(fe, us, cf);
      break;
    case #"hash_193c67dcacdd775c":
      function_714a531480eb471f(fe, us, cf);
      break;
    case #"hash_fb1a1e60f61fbb1":
      function_cc3655d0587ab820(fe, us, cf);
      break;
    case #"hash_c6c731be91721c99":
      function_880d469321de8968(fe, us, cf);
      break;
  }
}

function function_3e3f1c09b0fa92c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (24978.8, -33398.1, 3371.5), (0, 70.4, 0), "obelisk_spawn", "s_unstable_rift_obelisk_i_court", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (24977.6, -33398.6, 3452), (0, 340.4, 0), "s_unstable_rift_obelisk_i_court", undefined, "activity_unstable_rift_obelisk_i_court", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (24980.3, -33399.7, 3369), (0, 295.4, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_i_court", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_5e52aa8695e7efc5(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (44358.8, -26104.1, 3123.5), (0, 76.6, 0), "obelisk_spawn", "s_unstable_rift_obelisk_i_yard", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (44357.7, -26104.7, 3204), (0, 346.6, 0), "s_unstable_rift_obelisk_i_yard", undefined, "activity_unstable_rift_obelisk_i_yard", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (44360.5, -26105.5, 3121), (0, 301.6, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_i_yard", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_714a531480eb471f(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (27804, -25885.2, 3103.5), (0, 145.09, 0), "obelisk_spawn", "s_unstable_rift_obelisk_i_guest", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (27804.2, -25886.4, 3184), (0, 55.1, 0), "s_unstable_rift_obelisk_i_guest", undefined, "activity_unstable_rift_obelisk_i_guest", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (27806, -25884.1, 3101), (0, 10.1, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_i_guest", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_cc3655d0587ab820(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (22197, -20666.2, 2880.5), (0, 108.5, 0), "obelisk_spawn", "s_unstable_rift_obelisk_i_repair", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (22196.5, -20667.3, 2961), (0, 18.5, 0), "s_unstable_rift_obelisk_i_repair", undefined, "activity_unstable_rift_obelisk_i_repair", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (22199.3, -20666.5, 2878), (0, 333.5, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_i_repair", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_880d469321de8968(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (34099, -33819.2, 3098.5), (0, 182.79, 0), "obelisk_spawn", "s_unstable_rift_obelisk_i_island", "obelisk_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  fe[[f]](s, us, cf, (34099.9, -33820, 3179), (0, 92.8, 0), "s_unstable_rift_obelisk_i_island", undefined, "activity_unstable_rift_obelisk_i_island", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 128;
  fe[[f]](s, us, cf, (34099.9, -33817.1, 3096), (0, 47.8, 0), "obelisk_kill_radius", "s_unstable_rift_obelisk_i_island", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 512);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (24977.1, -33396.5, 3501);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(24982, -33397.6, 3465)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_I_COURT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (44356.9, -26102.7, 3253);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(44361.9, -26103.3, 3217)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_I_YARD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (27802, -25886.4, 3233);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(27804.4, -25882, 3197)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_I_GUEST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (22194.7, -20666, 3010);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(22199.3, -20663.9, 2974)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_I_REPAIR"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
  instancestruct.cf = "mp_jup_st_i_ob_activities_unstable_rift_obelisk_cs";
  instancestruct.scriptstructorigin = (34098.1, -33821.4, 3228);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(34097.3, -33816.4, 3192)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["UNSTABLE_RIFT_OBELISK_I_ISLAND"] = instancestruct;
  return activityinstances;
}