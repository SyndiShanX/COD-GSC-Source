/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_292206d11de03240.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_activities_armored_convoy_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_activities_armored_convoy_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_activities_armored_convoy_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_activities_armored_convoy_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_activities_armored_convoy_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_activities_armored_convoy_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_ARMORED_CONVOY";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_f_ob_activities_armored_convoy_cs";
  }

  switch (instancename) {
    case #"hash_9762d30abaa87365":
      function_45e349afc16add7c(fe, us, cf);
      break;
    case #"hash_1122723d54fc2752":
      function_ea65fe9681db9bd9(fe, us, cf);
      break;
  }
}

function function_45e349afc16add7c(fe, us, cf) {
  f = &strike_additem;
}

function function_ea65fe9681db9bd9(fe, us, cf) {
  f = &strike_additem;
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_armoredconvoy";
  instancestruct.cf = "mp_jup_st_f_ob_activities_armored_convoy_cs";
  instancestruct.scriptstructorigin = (38740, -5496, 3001.41);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(42312, -8424, 2980)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [500];
  activityinstances["ARMORED_CONVOY_F_FARM_TUNNEL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_armoredconvoy";
  instancestruct.cf = "mp_jup_st_f_ob_activities_armored_convoy_cs";
  instancestruct.scriptstructorigin = (33264, -8132, 2976.38);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ARMORED_CONVOY_F_MARKET_HIGHWAY"] = instancestruct;
  return activityinstances;
}