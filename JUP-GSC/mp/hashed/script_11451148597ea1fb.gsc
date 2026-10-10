/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_11451148597ea1fb.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_contracts_bounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_contracts_bounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_contracts_bounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_contracts_bounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_contracts_bounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_contracts_bounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-37211.8, -13974.1, 257.94), (0, 19, 0), "bigbounty_spawn", "SIRA", "mimic");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-25594.9, -15958.7, 350.73), (0, 199, 0), "bigbounty_spawn", "SIRA", "mimic");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-31677.8, -24674.3, 256), (0, 19.2, 0), "bigbounty_spawn", "SIRA", "mimic");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-27380.2, -23965.6, 261.97), (0, 108, 0), "bigbounty_spawn", "SIRA", "mimic");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-21859.4, -21833.5, 568), (0, 174.04, 0), "bigbounty_spawn", "SIRA", "mangler");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-26806.6, -22192.2, 256), (0, 0, 0), "bigbounty_spawn", "SIRA", "disciple");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-33041.9, -28538.5, 18.86), (0, 0, 0), "bigbounty_spawn", "SIRA", "mangler");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-22532.1, -22336, 784), (0, 0, 0), "bigbounty_spawn", "SIRA", "disciple");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-34922.5, -21659.1, 264), (0, 0, 0), "bigbounty_spawn", "SIRA", "mangler");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-35337.5, -17645.8, 262.96), (0, 0, 0), "bigbounty_spawn", "SIRA", "disciple");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-31599.1, -15717, 256), (0, 0, 0), "bigbounty_spawn", "SIRA", "mangler");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-29819.3, -13167.7, 1001.86), (0, 0, 0), "bigbounty_spawn", "SIRA", "disciple");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-21958.2, -26833.5, 19.67), (0, 0, 0), "bigbounty_spawn", "SIRA", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-35406.8, -17558.4, 262.96), (0, 0, 0), "bigbounty_spawn", "SIRA", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-27756.8, -18008.7, 393.97), (0, 0, 0), "bigbounty_spawn", "SIRA", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-43175.7, -27378.7, -197.92), (0, 0, 0), "bigbounty_spawn", "SIRA", "megabomb");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_contracts_bounty_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_BIGBOUNTY";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_bigbounty";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_sira_ob_contracts_bounty_cs";
  }

  switch (instancename) {
    case #"hash_222eb192327463ae":
      function_1b76e7df6dfedc07(fe, us, cf);
      break;
  }
}

function function_1b76e7df6dfedc07(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  fe[[f]](s, us, cf, (-43926, -17071, 432), (0, 254.92, 0), "activity_nexus_instance_joiner", undefined, "BIGBOUNTY_SIRA_COURTYARD", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_bounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (-43917.6, -17100, 392), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_SIRA_COURTYARD", "SIRA", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_sira_ob_contracts_bounty_cs";
  instancestruct.scriptstructorigin = (-43943.6, -17106.2, 392);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_SIRA_COURTYARD"] = instancestruct;
  return activityinstances;
}