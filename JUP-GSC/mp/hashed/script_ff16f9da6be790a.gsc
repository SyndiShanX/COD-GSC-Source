/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_ff16f9da6be790a.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_hydro_ob_activities_doghouse_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_hydro_ob_activities_doghouse_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_hydro_ob_activities_doghouse_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_hydro_ob_activities_doghouse_cs");

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

  s cs_setup_arrays(us, "mp_jup_hydro_ob_activities_doghouse_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_hydro_ob_activities_doghouse_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_hydro_ob_activities_doghouse_cs");
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
    cf = "mp_jup_hydro_ob_activities_doghouse_cs";
  }

  switch (instancename) {
    case #"hash_9601e367f2193bde":
      function_6ce4ce19a6ffba5b(fe, us, cf);
      break;
  }
}

function function_6ce4ce19a6ffba5b(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_activities_doghouse_cs";
  s.name = "doghouse_scriptable_struct";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "doghouse_scriptable_struct", "DOGHOUSE_HYDRO", undefined, undefined, undefined, (-15368.1, 6466.68, 625.44), (0, 330, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
  instancestruct.cf = "mp_jup_hydro_ob_activities_doghouse_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-15368.1, 6466.68, 625.44);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["DOGHOUSE_HYDRO"] = instancestruct;
  return activityinstances;
}