/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_25d5af9df677cbe.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_interactions_aether_tear_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_interactions_aether_tear_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_interactions_aether_tear_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_interactions_aether_tear_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_interactions_aether_tear_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_interactions_aether_tear_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_interactions_aether_tear_cs");
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
    cf = "mp_jup_fort_ob_interactions_aether_tear_cs";
  }

  switch (instancename) {
    case #"hash_ef6a81c407363531":
      function_71c71a27f5e5e55a(fe, us, cf);
      break;
    case #"hash_106915065bdb1327":
      function_dbf4a86fe36505ca(fe, us, cf);
      break;
    case #"hash_2515352c2c3ff544":
      function_4cd7bf2945275a6b(fe, us, cf);
      break;
  }
}

function function_71c71a27f5e5e55a(fe, us, cf) {
  f = &strike_additem;
}

function function_dbf4a86fe36505ca(fe, us, cf) {
  f = &strike_additem;
}

function function_4cd7bf2945275a6b(fe, us, cf) {
  f = &strike_additem;
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_fort_ob_interactions_aether_tear_cs";
  instancestruct.scriptstructorigin = (18592, -55424, 652);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_FORT_CISTERN"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_fort_ob_interactions_aether_tear_cs";
  instancestruct.scriptstructorigin = (8808, -54768, 403);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_FORT_SW_BEACH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
  instancestruct.cf = "mp_jup_fort_ob_interactions_aether_tear_cs";
  instancestruct.scriptstructorigin = (22169, -55997, 704);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["AETHERTEAR_FORT_EAST_GARAGE"] = instancestruct;
  return activityinstances;
}