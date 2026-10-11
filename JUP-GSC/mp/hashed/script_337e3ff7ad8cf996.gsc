/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_337e3ff7ad8cf996.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_contracts_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_contracts_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_contracts_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_contracts_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_contracts_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_contracts_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_contracts_escort_cs");
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
    cf = "mp_jup_fort_ob_contracts_escort_cs";
  }

  switch (instancename) {
    case #"hash_aea1a4b8ea96bf33":
      function_426a472ebbf65e48(fe, us, cf);
      break;
  }
}

function function_426a472ebbf65e48(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (14569, -53874, 1010.16), (0, 90, 0), "escort_fort_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (9988.03, -51736, 680), (0, 90, 0), "ESCORT_ZOMBIES_FORT", undefined, "escort_fort", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (14942, -52174, 1361), (0, 299.87, 0), "activity_nexus_instance_joiner", undefined, "ESCORT_ZOMBIES_FORT", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (11697, -53830, 688.46), (0, 90, 0), "escort_fort_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (10315, -53104, 704), (0, 90, 0), "escort_fort_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (13890, -52781, 655.16), (0, 90, 0), "escort_fort_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (16170, -52273, 838.38), (0, 90, 0), "escort_fort_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (17826, -51302, 876.77), (0, 90, 0), "escort_fort_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (20349, -50596, 567.98), (0, 90, 0), "escort_fort_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (21203, -50635, 611.71), (0, 90, 0), "escort_fort_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (21814, -52700, 699.72), (0, 90, 0), "escort_fort_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (22178, -51004, 409.18), (0, 90, 0), "escort_fort_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (22335, -52055, 1151), (0, 90, 0), "escort_fort_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (22461, -52338, 589.24), (0, 90, 0), "escort_fort_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (22089, -51008, 434.02), (0, 90, 0), "escort_fort_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (11960, -53066, 712), (0, 90, 0), "escort_fort_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (13055, -54587, 850.13), (0, 90, 0), "escort_fort_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (13506, -53770, 782.73), (0, 90, 0), "escort_fort_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (18739, -51146, 878), (0, 90, 0), "escort_fort_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (18590, -52934, 1024), (0, 90, 0), "escort_fort_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (22509, -53817, 711.82), (0, 90, 0), "escort_fort_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (21415, -54689, 846), (0, 90, 0), "escort_fort_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (20362, -54093, 1028), (0, 90, 0), "escort_fort_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (21631, -54080, 864), (0, 358.4, 0), "ESCORT_ZOMBIES_FORT_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (19595, -52065, 955.59), (0, 90, 0), "escort_fort_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (13143, -53063, 725), (0, 90, 0), "escort_fort_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (21625, -55658, 824.44), (0, 90, 0), "escort_fort_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_fort_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (10176, -51908, 681.31);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["ESCORT_ZOMBIES_FORT"] = instancestruct;
  return activityinstances;
}