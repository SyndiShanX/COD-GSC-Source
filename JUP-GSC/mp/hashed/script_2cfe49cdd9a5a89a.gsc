/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2cfe49cdd9a5a89a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_hydro_ob_contracts_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_hydro_ob_contracts_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_hydro_ob_contracts_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_hydro_ob_contracts_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_hydro_ob_contracts_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_hydro_ob_contracts_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_hydro_ob_contracts_escort_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_ESCORT_ZOMBIES";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_hydro_ob_contracts_escort_cs";
  }

  switch (instancename) {
    case #"hash_aef08d50c7c6da08":
      function_78c6ee6bda307001(fe, us, cf);
      break;
  }
}

function function_78c6ee6bda307001(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6683.71, 7097.03, 308.05), (0, 90, 0), "escort_hydro_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5498.92, 5954.34, 375.75), (0, 90, 0), "escort_hydro_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-1579.86, 8378.5, 845.32), (0, 90, 0), "ESCORT_ZOMBIES_HYDRO", undefined, "escort_hydro", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-4048.54, 6989.3, 1024), (0, 0, 0), "activity_nexus_instance_joiner", undefined, "ESCORT_ZOMBIES_HYDRO", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8279.53, 4529.64, 426), (0, 90, 0), "escort_hydro_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-3853.91, 8322.43, 578.91), (0, 90, 0), "escort_hydro_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-2560.17, 6613.59, 576.76), (0, 90, 0), "escort_hydro_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-3088.56, 8133.41, 574.97), (0, 90, 0), "escort_hydro_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5604.31, 6243.49, 337.62), (0, 90, 0), "escort_hydro_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-8349.51, 4356.6, 403.55), (0, 90, 0), "escort_hydro_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-4851.71, 4956.97, 447.28), (0, 90, 0), "escort_hydro_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6093.74, 4785.29, 415.24), (0, 90, 0), "escort_hydro_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7297.57, 5975.41, 327.46), (0, 90, 0), "escort_hydro_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9460.23, 4189.31, 363.04), (0, 90, 0), "escort_hydro_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-2923.42, 6262.44, 605.75), (0, 90, 0), "escort_hydro_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6542.8, 7053.4, 306.92), (0, 90, 0), "escort_hydro_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-10779.2, 5334.2, 361.05), (0, 90, 0), "escort_hydro_horde_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10647.5, 5212.91, 385.12), (0, 90, 0), "escort_hydro_neutralize_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10565, 5318.59, 361), (0, 358.4, 0), "ESCORT_ZOMBIES_HYDRO_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-3140.05, 6056.81, 589.06), (0, 90, 0), "escort_hydro_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_hydro_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-1526.01, 8323.1, 845.34);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ESCORT_ZOMBIES_HYDRO"] = instancestruct;
  return activityinstances;
}