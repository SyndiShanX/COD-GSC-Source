/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_467ae73e5873ec84.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_activities_armored_convoy_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_activities_armored_convoy_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_activities_armored_convoy_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_activities_armored_convoy_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_activities_armored_convoy_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_activities_armored_convoy_cs");
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
    cf = "mp_jup_st_h_ob_activities_armored_convoy_cs";
  }

  switch (instancename) {
    case #"hash_46a9641c7a76b484":
      function_8798a7d75c763cc3(fe, us, cf);
      break;
    case #"hash_7d33fb898dfb6330":
      function_7d9c82d91b034c45(fe, us, cf);
      break;
  }
}

function function_8798a7d75c763cc3(fe, us, cf) {
  f = &strike_additem;
}

function function_7d9c82d91b034c45(fe, us, cf) {
  f = &strike_additem;
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_armoredconvoy";
  instancestruct.cf = "mp_jup_st_h_ob_activities_armored_convoy_cs";
  instancestruct.scriptstructorigin = (-156, -38828, 2516);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ARMORED_CONVOY_H_GYM_PARK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_armoredconvoy";
  instancestruct.cf = "mp_jup_st_h_ob_activities_armored_convoy_cs";
  instancestruct.scriptstructorigin = (8672, -26576, 1712);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ARMORED_CONVOY_H_OPERA_DRIVE"] = instancestruct;
  return activityinstances;
}