/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d7c98a7d021a0a8.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_TEAM_HUNT";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_team_hunt";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs";
  }

  switch (instancename) {
    case #"hash_78cc8308b834e00f":
      function_3142c0503bedf5f4(fe, us, cf);
      break;
    case #"hash_834fd6e978783aac":
      function_a17e47fdd36e7b61(fe, us, cf);
      break;
  }
}

function function_3142c0503bedf5f4(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "team_hunt_region", undefined, "D", undefined, undefined, (-31496, 3046, 1013), (0, 10, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "TEAM_HUNT_D_WAREHOUSE", "TEAM_HUNT_D_WAREHOUSE", undefined, undefined, (-31496, 3046, 1013), (0, 10, 0));
}

function function_a17e47fdd36e7b61(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "team_hunt_region", undefined, "D", undefined, undefined, (-26832, -20948, 1754), (0, 345, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "TEAM_HUNT_D_MARKET", "TEAM_HUNT_D_MARKET", undefined, undefined, (-26832, -20948, 1754), (0, 345, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-31496, 3046, 1013);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TEAM_HUNT_D_WAREHOUSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_pvpve_team_hunt_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-26832, -20948, 1754);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["TEAM_HUNT_D_MARKET"] = instancestruct;
  return activityinstances;
}