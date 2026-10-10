/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2159cce514a7e373.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activity_oldtown_doghouse_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activity_oldtown_doghouse_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activity_oldtown_doghouse_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activity_oldtown_doghouse_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activity_oldtown_doghouse_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activity_oldtown_doghouse_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activity_oldtown_doghouse_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_DOGHOUSE";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_doghouse";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_activity_oldtown_doghouse_cs";
  }

  switch (instancename) {
    case #"hash_402c3fab4b737383":
      function_1cfb67008605a820(fe, us, cf);
      break;
    case #"hash_fd656bb542a95183":
      function_bad8ee5ad7e11452(fe, us, cf);
      break;
  }
}

function function_1cfb67008605a820(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_doghouse_cs";
  s.name = "doghouse_scriptable_struct";
  fe[[f]](s, us, cf, (57, 0, 0), (0, 0, 0), "doghouse_scriptable_struct", "DOGHOUSE_E_HILL", undefined, undefined, undefined, (-6121, 1388, 2207.5), (0, 330.51, 0));
}

function function_bad8ee5ad7e11452(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activity_oldtown_doghouse_cs";
  s.name = "doghouse_scriptable_struct";
  fe[[f]](s, us, cf, (57, 0, 0), (0, 0, 0), "doghouse_scriptable_struct", "DOGHOUSE_E_NORTH", undefined, undefined, undefined, (11217.8, 9229.25, 2643.43), (355.97, 5.52, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_doghouse_cs";
  instancestruct.scriptstructorigin = (57, 0, 0);
  instancestruct.scriptstructoriginoffset = (-6121, 1388, 2207.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["DOGHOUSE_E_HILL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
  instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_doghouse_cs";
  instancestruct.scriptstructorigin = (57, 0, 0);
  instancestruct.scriptstructoriginoffset = (11217.8, 9229.25, 2643.43);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["DOGHOUSE_E_NORTH"] = instancestruct;
  return activityinstances;
}