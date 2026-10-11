/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6d8344cb6e0a90b8.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_interactions_aethertear_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_interactions_aethertear_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_interactions_aethertear_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_interactions_aethertear_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_interactions_aethertear_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_interactions_aethertear_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_interactions_aethertear_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_AETHERTEAR";
  activityinfostruct.scriptbundle = "jup_activitydefinition_aethertear";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_b_ob_interactions_aethertear_cs";
  }

  switch (instancename) {
    case #"hash_8812b35e0b1c9197":
      function_78b92685ccd0d318(fe, us, cf);
      break;
    case #"hash_22fb721cca917183":
      function_2b8b7a6e77cfad46(fe, us, cf);
      break;
    case #"hash_80d42be3ad61ca2b":
      function_c9592d4e49fba5a0(fe, us, cf);
      break;
  }
}

function function_78b92685ccd0d318(fe, us, cf) {
  f = &strike_additem;
}

function function_2b8b7a6e77cfad46(fe, us, cf) {
  f = &strike_additem;
}

function function_c9592d4e49fba5a0(fe, us, cf) {
  f = &strike_additem;
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_aethertear_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-17621, 31540.5, 2801.07);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_B_EAST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_aethertear_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-3263, 16745.5, 1786);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_B_SOUTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_aethertear_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (13642.8, 18727.3, 944.75);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_B_ISLAND"] = instancestruct;
  return activityinstances;
}