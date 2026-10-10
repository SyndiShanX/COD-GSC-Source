/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3eeee6ed6da9806e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_activities_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_activities_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_activities_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_activities_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_activities_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_activities_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (39783, 12666, 3224), (358, 93.21, -0.11), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (39963, 13192, 3073), (356.3, 67.81, 1.51), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (39963, 13192, 3073), (358, 88.38, 0.06), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (32854, -8346, 2968), (359.27, 158.59, -1.86), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (32270, 11503, 2063), (358.77, 37.89, 1.58), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (27144, 8163, 1853), (1.09, 213.09, -1.67), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (26842, -2164, 2500), (358.04, 78.9, 0.38), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (39953, 219, 2997), (358.44, 128.52, -1.25), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (31993, 1813, 2376), (358.44, 128.52, -1.25), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (43063, -7900, 3112), (358.11, 70.9, 0.65), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (30886, -14345, 2941), (358.2, 115.92, -0.87), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (36509, -10203, 3077), (358.2, 115.92, -0.87), "bigbounty_spawn", "F", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (27820, 9726, 1928), (0.27, 352.28, 1.98), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (27820, 9726, 1928), (359.42, 354.07, 4.08), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (34678, -1259, 2389), (0.05, 181.28, -2), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (34678, -1259, 2389), (1.04, 180.55, -3.99), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (26892, 1247, 2076), (1.91, 286.99, 0.58), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (26892, 1247, 2076), (2.71, 296.21, 3.56), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (43021, -5025, 2984), (358.24, 61.96, 0.94), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (43021, -5025, 2984), (355.02, 58.28, -0.45), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (39876, 6425, 2949), (4.14, 198.96, -2.81), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (39876, 6425, 2949), (1.53, 196.57, -1.63), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (35027, -12680, 2931), (357.74, 116.34, -4.46), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (35027, -12680, 2931), (359.22, 133.01, -2.09), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (38013, -3753, 2968), (3.68, 190.55, -3.38), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (38013, -3753, 2968), (1.41, 192.67, -1.73), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (30322, -11519, 2928), (358.21, 26.67, 1.33), "bigbounty_spawn", "F", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (30322, -11519, 2928), (354.46, 33.54, 1.12), "bigbounty_spawn", "F", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (29375, -12465, 3012), (358.14, 111.49, -0.73), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (34253, -15579, 2968), (358, 87.97, 0.07), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (37419, -5685, 2985), (0.17, 184.87, -1.99), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (32367, -835, 2245), (1.99, 263.57, -0.22), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (40375, -5315, 3012), (2, 267.57, -0.08), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (35877, 6572, 2447), (358.86, 145.19, -1.64), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (26158, -1548, 2330), (359.27, 21.26, 1.86), "bigbounty_spawn", "F", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (43781, 1748, 2961), (358.27, 119.99, -1), "bigbounty_spawn", "F", "megabomb");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_activities_bigbounty_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_BIGBOUNTY";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_bigbounty";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_f_ob_activities_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_f31c74ee032d786e":
      function_32617c713620fa17(fe, us, cf);
      break;
    case #"hash_9543fd69966f0909":
      function_2df488da15b4a03a(fe, us, cf);
      break;
    case #"hash_781a25b39d6d7df5":
      function_98f1fe0eaba8a22e(fe, us, cf);
      break;
    case #"hash_4e849afff374cfa0":
      function_f4f9734164cdef3(fe, us, cf);
      break;
  }
}

function function_32617c713620fa17(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_F_SHED", "BIGBOUNTY_F_SHED", undefined, undefined, (38497.5, -4381.5, 3012), (0, 173.48, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_F_SHED", "F", undefined, undefined, (38497.5, -4381.5, 3012), (0, 173.48, 0));
}

function function_2df488da15b4a03a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_F_GAS", "BIGBOUNTY_F_GAS", undefined, undefined, (34403, 8924, 2271.5), (0, 225.33, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_F_GAS", "F", undefined, undefined, (34403, 8924, 2271.5), (0, 225.33, 0));
}

function function_98f1fe0eaba8a22e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_F_STORAGE", "BIGBOUNTY_F_STORAGE", undefined, undefined, (41669, 6439, 3018.5), (0, 351.48, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_F_STORAGE", "F", undefined, undefined, (41669, 6439, 3018.5), (0, 351.48, 0));
}

function function_f4f9734164cdef3(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_F_HOUSE", "BIGBOUNTY_F_HOUSE", undefined, undefined, (29252, -5841, 2678), (0, 74.98, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_F_HOUSE", "F", undefined, undefined, (29252, -5841, 2678), (0, 74.98, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_f_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (38497.5, -4381.5, 3012);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_F_SHED"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_f_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (34403, 8924, 2271.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_F_GAS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_f_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (41669, 6439, 3018.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_F_STORAGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_f_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (29252, -5841, 2678);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_F_HOUSE"] = instancestruct;
  return activityinstances;
}