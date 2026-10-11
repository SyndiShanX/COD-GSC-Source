/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_514a13029018133.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_hydro_ob_contracts_bounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_hydro_ob_contracts_bounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_hydro_ob_contracts_bounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_hydro_ob_contracts_bounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_hydro_ob_contracts_bounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_hydro_ob_contracts_bounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-15627.5, 8737.17, 507.53), (0, 19, 0), "bigbounty_spawn", "HYDRO", "mimic");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-7995.12, 14026.5, 544.77), (0, 19, 0), "bigbounty_spawn", "HYDRO", "mimic");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-8068.32, 14087.1, 544.64), (0, 0, 0), "bigbounty_spawn", "HYDRO", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-8020.62, 14163.8, 543.97), (0, 174.04, 0), "bigbounty_spawn", "HYDRO", "mangler");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-7963.02, 14105.9, 544.1), (0, 0, 0), "bigbounty_spawn", "HYDRO", "disciple");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-15656, 8792.74, 505.29), (0, 0, 0), "bigbounty_spawn", "HYDRO", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-15699.8, 8767.85, 503.33), (0, 174.04, 0), "bigbounty_spawn", "HYDRO", "mangler");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-15668, 8846.09, 503.08), (0, 0, 0), "bigbounty_spawn", "HYDRO", "disciple");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_hydro_ob_contracts_bounty_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_BIGBOUNTY";
  activityinfostruct.scriptbundle = "jup_activitydefinition_bigbounty";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_hydro_ob_contracts_bounty_cs";
  }

  switch (instancename) {
    case #"hash_1d5af655983d8a8b":
      function_1cb01751d89d8290(fe, us, cf);
      break;
  }
}

function function_1cb01751d89d8290(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  fe[[f]](s, us, cf, (-12201.6, 12386.4, 546), (0, 0, 0), "activity_nexus_instance_joiner", undefined, "BIGBOUNTY_HYDRO", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_bounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (-12247.3, 12290.6, 506), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_HYDRO", "HYDRO", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_hydro_ob_contracts_bounty_cs";
  instancestruct.scriptstructorigin = (-12334.6, 12312.4, 506);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_HYDRO"] = instancestruct;
  return activityinstances;
}