/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2ab52a62bf9e853b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_contracts_pvpve_assassination_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_contracts_pvpve_assassination_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_contracts_pvpve_assassination_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_contracts_pvpve_assassination_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_contracts_pvpve_assassination_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_contracts_pvpve_assassination_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_contracts_pvpve_assassination_cs");
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
    cf = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  }

  switch (instancename) {
    case #"hash_5c269e019b2a8881":
      function_54d9602523a3af02(fe, us, cf);
      break;
    case #"hash_745b27f005bc24b7":
      function_fca356227e574e10(fe, us, cf);
      break;
    case #"hash_a508899d85b5b15b":
      function_ef2bfdb0a19e2bf4(fe, us, cf);
      break;
    case #"hash_414c53ad94978737":
      function_c1fddef5fba4ad5e(fe, us, cf);
      break;
  }
}

function function_54d9602523a3af02(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "C", undefined, undefined, (35075.5, 37284, 1252), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", undefined, "ASSASSINATION_C_CRANE", undefined, undefined, (35075.5, 37284, 1252), (0, 0, 0));
}

function function_fca356227e574e10(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "C", undefined, undefined, (31123.5, 22771.5, 1862.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", undefined, "ASSASSINATION_C_TRAIN_FACTORY", undefined, undefined, (31123.5, 22771.5, 1862.5), (0, 0, 0));
}

function function_ef2bfdb0a19e2bf4(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "C", undefined, undefined, (20608, 31178, 1528), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_C_RAILWAY", "ASSASSINATION_C_RAILWAY", undefined, undefined, (20608, 31178, 1528), (0, 0, 0));
}

function function_c1fddef5fba4ad5e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "assassination_region", undefined, "C", undefined, undefined, (37013, 17763, 3376.5), (0, 123.95, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "ASSASSINATION_C_CHURCH", "ASSASSINATION_C_CHURCH", undefined, undefined, (37013, 17763, 3376.5), (0, 123.95, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (35075.5, 37284, 1252);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_C_CRANE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (31123.5, 22771.5, 1862.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_C_TRAIN_FACTORY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (20608, 31178, 1528);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_C_RAILWAY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_assassination";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_pvpve_assassination_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (37013, 17763, 3376.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ASSASSINATION_C_CHURCH"] = instancestruct;
  return activityinstances;
}