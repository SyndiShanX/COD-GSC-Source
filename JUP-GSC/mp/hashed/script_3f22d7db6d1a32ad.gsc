/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3f22d7db6d1a32ad.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_doghouse_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_doghouse_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_doghouse_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_doghouse_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_doghouse_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_doghouse_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_doghouse_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_DOGHOUSE";
  activityinfostruct.scriptbundle = "jup_activitydefinition_doghouse";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_c_ob_activities_doghouse_cs";
  }

  switch (instancename) {
    case #"hash_f912aeab501ca73e":
      function_a8d715b336525105(fe, us, cf);
      break;
    case #"hash_38ac242ba55f570e":
      function_60e5ab5ececba433(fe, us, cf);
      break;
  }
}

function function_a8d715b336525105(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_doghouse_cs";
  s.name = "doghouse_scriptable_struct";
  fe[[f]](s, us, cf, (57, 0, 0), (0, 0, 0), "doghouse_scriptable_struct", "DOGHOUSE_C_CEMETERY", undefined, undefined, undefined, (34335, 20077, 3073.5), (0, 301.92, 0));
}

function function_60e5ab5ececba433(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_doghouse_cs";
  s.name = "doghouse_scriptable_struct";
  fe[[f]](s, us, cf, (57, 0, 0), (0, 0, 0), "doghouse_scriptable_struct", "DOGHOUSE_C_BAY", undefined, undefined, undefined, (27659, 39932.5, 960), (0, 330.75, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
  instancestruct.cf = "mp_jup_st_c_ob_activities_doghouse_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (34335, 20077, 3073.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["DOGHOUSE_C_CEMETERY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
  instancestruct.cf = "mp_jup_st_c_ob_activities_doghouse_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (27659, 39932.5, 960);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["DOGHOUSE_C_BAY"] = instancestruct;
  return activityinstances;
}