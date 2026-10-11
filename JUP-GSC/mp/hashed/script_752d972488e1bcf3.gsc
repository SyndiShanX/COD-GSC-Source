/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_752d972488e1bcf3.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_contracts_pvpve_assassination_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_contracts_pvpve_assassination_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_contracts_pvpve_assassination_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_contracts_pvpve_assassination_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_contracts_pvpve_assassination_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_contracts_pvpve_assassination_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_contracts_pvpve_assassination_cs");
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
    cf = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  }

  switch (instancename) {
    case #"hash_9b63c1c49dcbb682":
      function_cf1b92f80cce0255(fe, us, cf);
      break;
    case #"hash_d2cccf7ac49012b8":
      function_b9425c283e17a309(fe, us, cf);
      break;
    case #"hash_2cb2e8f79ab7fb9":
      function_b28eef12a1b6b2ee(fe, us, cf);
      break;
    case #"hash_89321c50d3ea4f2b":
      function_530451c5d157e758(fe, us, cf);
      break;
  }
}

function function_cf1b92f80cce0255(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "G", undefined, undefined, (-31055, -11599, 1569), (0, 147.01, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_G_HOTEL", "ASSASSINATION_G_HOTEL", undefined, undefined, (-31055, -11599, 1569), (0, 147.01, 0));
}

function function_b9425c283e17a309(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "G", undefined, undefined, (-19985.5, -36977, 2925), (0, 341.43, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_G_PALACE", "ASSASSINATION_G_PALACE", undefined, undefined, (-19985.5, -36977, 2925), (0, 341.43, 0));
}

function function_b28eef12a1b6b2ee(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "G", undefined, undefined, (-3016.5, -25771, 1756.5), (0, 302.13, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_G_GROCERY_STORE", "ASSASSINATION_G_GROCERY_STORE", undefined, undefined, (-3016.5, -25771, 1756.5), (0, 302.13, 0));
}

function function_530451c5d157e758(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "G", undefined, undefined, (-25411, -27884.5, 1754), (0, 183.99, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_G_REPAIR_CENTER", "ASSASSINATION_G_REPAIR_CENTER", undefined, undefined, (-25411, -27884.5, 1754), (0, 183.99, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-31055, -11599, 1569);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_G_HOTEL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-19985.5, -36977, 2925);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_G_PALACE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-3016.5, -25771, 1756.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_G_GROCERY_STORE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-25411, -27884.5, 1754);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_G_REPAIR_CENTER"] = instancestruct;
  return activityinstances;
}