/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_35832c8f24f352a6.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_contracts_sabotage_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_contracts_sabotage_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_contracts_sabotage_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_contracts_sabotage_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_contracts_sabotage_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_contracts_sabotage_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_contracts_sabotage_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_SABOTAGE";
  activityinfostruct.scriptbundle = "jup_activitydef_sabotage_sira";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_sira_ob_contracts_sabotage_cs";
  }

  switch (instancename) {
    case #"hash_7c89d84ca6e9b3bb":
      function_827c64c8fda06bec(fe, us, cf);
      break;
  }
}

function function_827c64c8fda06bec(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (-24896.3, -21013.7, 1597.59), (0, 201.21, 0), "activity_nexus_instance_joiner", "cspf_2_auto11925423706169286131", "SABOTAGE_SIRA", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage_sira";
  instancestruct.cf = "mp_jup_sira_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (-30164.5, -20980, 263.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-30164.5, -20979.9, 264)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [5000];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-30164.2, -20979.9, 264)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [5500];
  instancestruct.locationorigin = [(-30164.5, -20979.9, 264)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1];
  activityinstances["SABOTAGE_SIRA"] = instancestruct;
  return activityinstances;
}