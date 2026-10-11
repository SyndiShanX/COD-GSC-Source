/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_71baa084f5c3e987.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_contracts_pvpve_assassination_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_contracts_pvpve_assassination_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_contracts_pvpve_assassination_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_contracts_pvpve_assassination_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_contracts_pvpve_assassination_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_contracts_pvpve_assassination_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_contracts_pvpve_assassination_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_ASSASSINATION";
  activityinfostruct.scriptbundle = "jup_activitydefinition_assassination";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_i_ob_contracts_pvpve_assassination_cs";
  }

  switch (instancename) {
    case #"hash_805c56ae635bcd23":
      function_2166ab1b4cad00c0(fe, us, cf);
      break;
    case #"hash_2bcca8173bd06aa8":
      function_a315d9f681e49ae7(fe, us, cf);
      break;
  }
}

function function_2166ab1b4cad00c0(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "I", undefined, undefined, (34904.5, -28955, 3009), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_I_ISLAND_GASSTATION", "ASSASSINATION_I_ISLAND_GASSTATION", undefined, undefined, (34904.5, -28955, 3009), (0, 0, 0));
}

function function_a315d9f681e49ae7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "I", undefined, undefined, (35501, -20847, 3107.5), (0, 162.06, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_I_ISLAND_MEWS", "ASSASSINATION_I_ISLAND_MEWS", undefined, undefined, (35501, -20847, 3107.5), (0, 162.06, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_i_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (34904.5, -28955, 3009);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_I_ISLAND_GASSTATION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_i_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (35501, -20847, 3107.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_I_ISLAND_MEWS"] = instancestruct;
  return activityinstances;
}