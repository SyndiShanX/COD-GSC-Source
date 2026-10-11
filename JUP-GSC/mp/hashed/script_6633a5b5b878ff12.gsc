/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6633a5b5b878ff12.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_contracts_sabotage_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_contracts_sabotage_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_contracts_sabotage_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_contracts_sabotage_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_contracts_sabotage_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_contracts_sabotage_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_contracts_sabotage_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_SABOTAGE";
  activityinfostruct.scriptbundle = "jup_activitydef_sabotage";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_fort_ob_contracts_sabotage_cs";
  }

  switch (instancename) {
    case #"hash_30b5278e229b08d3":
      function_3cf6bb9611fc258(fe, us, cf);
      break;
  }
}

function function_3cf6bb9611fc258(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (23484, -51611, 931), (0, 14.64, 0), "activity_nexus_instance_joiner", "cspf_2_auto11925423706169286131", "SABOTAGE_FORT", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_fort_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (18709, -53895, 1462.21);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(18692, -53891.5, 1462)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [5000];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(18693.5, -53894.5, 1467)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [8000];
  instancestruct.locationorigin = [(18701, -53894, 1465)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1];
  activityinstances["SABOTAGE_FORT"] = instancestruct;
  return activityinstances;
}