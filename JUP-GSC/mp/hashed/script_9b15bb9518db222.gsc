/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_9b15bb9518db222.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_interactions_aether_tear_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_interactions_aether_tear_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_interactions_aether_tear_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_interactions_aether_tear_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_interactions_aether_tear_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_interactions_aether_tear_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_interactions_aether_tear_cs");
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
    cf = "mp_jup_sira_ob_interactions_aether_tear_cs";
  }

  switch (instancename) {
    case #"hash_f1073726d641552b":
      function_8e4b53ac550b4c26(fe, us, cf);
      break;
    case #"hash_3275601d42db3b5b":
      function_e81cb5e284123692(fe, us, cf);
      break;
    case #"hash_fdda1616bddfd668":
      function_65dfff9be8c818f3(fe, us, cf);
      break;
  }
}

function function_8e4b53ac550b4c26(fe, us, cf) {
  f = &strike_additem;
}

function function_e81cb5e284123692(fe, us, cf) {
  f = &strike_additem;
}

function function_65dfff9be8c818f3(fe, us, cf) {
  f = &strike_additem;
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_sira_ob_interactions_aether_tear_cs";
  instancestruct.scriptstructorigin = (-29933.9, -20981.2, 264);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_SIRA_MALL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_sira_ob_interactions_aether_tear_cs";
  instancestruct.scriptstructorigin = (21527, -30818.8, 400);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_SIRA_SW_BEACH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_sira_ob_interactions_aether_tear_cs";
  instancestruct.scriptstructorigin = (-24191.3, -24649.5, 258);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_SIRA_EAST_GARAGE"] = instancestruct;
  return activityinstances;
}