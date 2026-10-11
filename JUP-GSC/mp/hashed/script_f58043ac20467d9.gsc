/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_f58043ac20467d9.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activity_lowtown_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activity_lowtown_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activity_lowtown_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (15424, -13191.5, 1874.5), (359.07, 67.79, 0.38), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (17028, -6385, 1590), (359.38, 38.56, 0.78), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (19389, -3790, 2007), (359.31, 159.73, -1.88), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (14209, -11001, 1871), (358.44, 51.09, 1.25), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (15412, -5870.5, 1429), (1.2, 323.22, 1.6), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (15714, -3501, 1449.5), (358.44, 51.33, 1.25), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (21985, -78.5, 2156), (2, 268.12, -0.06), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (21179.5, -5727.5, 2431.5), (358.3, 58.22, 1.05), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (15424, -13191, 1874), (359.07, 67.79, 0.38), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (15424, -13190.5, 1873.5), (359.07, 67.79, 0.38), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (14219.5, -7100.5, 1590.5), (358.44, 51.09, 1.25), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (14205.5, -7074.5, 1588.5), (359.07, 67.79, 0.38), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (14221.5, -7109, 1601), (359.07, 67.79, 0.38), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (15713.5, -3500, 1449), (358.44, 51.33, 1.25), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (16737.5, -4198.5, 1692), (358.4, 53.14, 1.2), "bigbounty_spawn", "LOWTOWN", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (16797.5, -4221.5, 1690), (357.66, 51.31, 1.87), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (16801.5, -4209.5, 1690), (356.88, 51.28, 2.5), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (19289.5, -972, 1951), (359.3, 166.55, -2.92), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (19289.5, -972, 1951), (359.07, 166.57, -3.89), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (21264.5, 398, 2150.5), (1.2, 216.78, -1.6), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (21264.5, 398.5, 2150), (1.2, 216.78, -1.6), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (21706, -4047.5, 2257), (1.4, 315.68, 1.43), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (21706, -4047.5, 2267), (2.09, 315.71, 2.15), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (17927.5, -5452.5, 1593.5), (0.39, 348.64, 1.96), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (17921.5, -5451.5, 1593.5), (0.59, 348.65, 2.94), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (17059.5, -7863, 1866.5), (359.95, 1.36, 2), "bigbounty_spawn", "LOWTOWN", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (17014.5, -7881, 1865.5), (0.55, 343.97, 1.92), "bigbounty_spawn", "LOWTOWN", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (14545.5, -12298, 1825.5), (358.06, 104.13, -0.49), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (15035, -9901, 1828.5), (358.94, 148.09, -1.7), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (13441.5, -6995.5, 1598.5), (2, 267.34, -0.09), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (17239.5, -3627.5, 1698), (358.67, 138.41, -1.5), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (22696, 815.5, 2392.5), (359.41, 162.83, -1.91), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (19965.5, -10050.5, 2239.5), (0.61, 197.79, -1.9), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (17116.5, -13185, 1984), (0.85, 205.08, -1.81), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (23944, 2786, 2076.5), (358.12, 109.61, -0.67), "bigbounty_spawn", "LOWTOWN", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (23824.5, 52.5, 2590.5), (1.83, 246.6, -0.79), "bigbounty_spawn", "LOWTOWN", "megabomb");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activity_lowtown_bigbounty_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_BIGBOUNTY";
  activityinfostruct.scriptbundle = "jup_activitydefinition_bigbounty";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_6f170e6ebbf43ccf":
      function_b8a28a313460d9c8(fe, us, cf);
      break;
    case #"hash_4ab118cff10afa52":
      function_4c61d18d41ee39a5(fe, us, cf);
      break;
  }
}

function function_b8a28a313460d9c8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_LOWTOWN_COURTYARD", "BIGBOUNTY_LOWTOWN_COURTYARD", undefined, undefined, (20869, -1343, 2190.46), (359.86, 287.34, -0.05));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_LOWTOWN_COURTYARD", "LOWTOWN", undefined, undefined, (20869, -1343, 2190.46), (359.86, 287.34, -0.05));
}

function function_4c61d18d41ee39a5(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_LOWTOWN_PORCH", "LOWTOWN", undefined, undefined, (14859, -11210, 1900), (0, 276.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_LOWTOWN_PORCH", "BIGBOUNTY_LOWTOWN_PORCH", undefined, undefined, (14859, -11210, 1900), (0, 276.8, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (20869, -1343, 2190.46);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(20869, -1343, 2190.46)];
  instancestruct.var_45283ef87b6e04b6 = [(359.86, 287.34, -0.05)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_LOWTOWN_COURTYARD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_e_ob_activity_lowtown_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (14859, -11210, 1900);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_LOWTOWN_PORCH"] = instancestruct;
  return activityinstances;
}