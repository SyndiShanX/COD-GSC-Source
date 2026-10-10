/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5761ed026f7742b7.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_ESCORT_ZOMBIES";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs";
  }

  switch (instancename) {
    case #"hash_6ce3b2fe3ef8b360":
      function_b173bc35b4e80085(fe, us, cf);
      break;
  }
}

function function_b173bc35b4e80085(fe, us, cf) {
  f = &strike_additem;
  s = s();
  fe[[f]](s, us, cf, (20801, 2071, 7), undefined, undefined, undefined, undefined, undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (22263.1, -6151.77, 2339), (0, 198, 0), "s_escort_zombies_lowtown", undefined, "escort_lowtown", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (26063, -993, 2493), (0, 270, 0), "escort_favela_2_zombie_escort_6", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (24048, 953, 2445.78), (0, 270, 0), "escort_favela_2_zombie_escort_9", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (25871, 4926, 2476.41), (0, 270, 0), "escort_favela_2_zombie_escort_13", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  fe[[f]](s, us, cf, (25165, 5342, 2435.97), (0, 270, 0), "escort_favela_2_zombie_escort_14", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  fe[[f]](s, us, cf, (25383, 5944, 2420.48), (0, 270, 0), "escort_favela_2_zombie_escort_15", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  fe[[f]](s, us, cf, (26543, 4046, 2587.63), (0, 270, 0), "escort_favela_2_zombie_escort_16", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (26496, 5059, 2609.94), (0, 270, 0), "escort_favela_2_zombie_escort_16", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (23566, -4512, 2373.13), (0, 270, 0), "escort_favela_2_neutralize_site_1", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (22949, -6492, 2386.13), (0, 270, 0), "escort_favela_2_zombie_escort_1", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (22633, -5930, 2380.08), (0, 270, 0), "escort_favela_2_zombie_escort_1", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (23698, -5130, 2375.16), (0, 270, 0), "escort_favela_2_zombie_escort_4", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (22675, -4886, 2312.51), (0, 270, 0), "escort_favela_2_zombie_escort_3", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  fe[[f]](s, us, cf, (23313, -5446, 2402.36), (0, 270, 0), "escort_favela_2_zombie_escort_3", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (25495, -1383, 2493), (0, 270, 0), "escort_favela_2_zombie_escort_5", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 400);
  s = s();
  fe[[f]](s, us, cf, (24888, -901, 2417.68), (0, 270, 0), "escort_favela_2_zombie_escort_6", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (24631, -119, 2445), (0, 270, 0), "escort_favela_2_zombie_escort_7", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (24979, 121, 2444.21), (0, 270, 0), "escort_favela_2_zombie_escort_8", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (24930, 1841, 2418.58), (0, 270, 0), "escort_favela_2_zombie_escort_9", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  fe[[f]](s, us, cf, (24972, 2739, 2389.39), (0, 270, 0), "escort_favela_2_zombie_escort_10", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (22988, -4615, 2307.27), (0, 270, 0), "escort_favela_2_zombie_escort_4", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (24917, -1063, 2395.12), (0, 270, 0), "escort_favela_2_zombie_escort_5", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (25420, -250, 2465), (0, 270, 0), "escort_favela_2_zombie_escort_7", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (24317, -475, 2429), (0, 270, 0), "escort_favela_2_zombie_escort_8", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (24136, 2684, 2318.4), (0, 270, 0), "escort_favela_2_zombie_escort_11", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (24354, 2755, 2369.75), (0, 270, 0), "escort_favela_2_zombie_escort_12", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 100);
  s = s();
  fe[[f]](s, us, cf, (24623, 3961, 2384.05), (0, 270, 0), "escort_favela_2_zombie_escort_13", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  fe[[f]](s, us, cf, (23996, 2317, 2296.41), (0, 270, 0), "escort_favela_2_zombie_escort_10", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (22203.2, -6171.24, 2288.67), (0, 198, 0), "atv_spawn", undefined, "escort_lowtown", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (22219, -6166.09, 2299.87), (0, 288, 0), "escort_package", undefined, "escort_lowtown", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (22251.9, -6154.98, 2289), (0, 17, 0), "interact_escort", undefined, "escort_lowtown", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (23748, -4378, 2378.45), (0, 270, 0), "escort_favela_2_neutralize_site_1", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (24171, 2037, 2342.45), (0, 270, 0), "escort_favela_2_neutralize_site_2", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (26029, 5012, 2494.61), (0, 270, 0), "escort_favela_2_zombie_escort_15", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 300);
  s = s();
  fe[[f]](s, us, cf, (27734, 4059, 2839.44), (0, 270, 0), "escort_favela_2_zombie_escort_17", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (27757, 4028, 2846.54), (0, 270, 0), "escort_favela_2_zombie_escort_18", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (27811, 3217, 2936.32), (0, 270, 0), "escort_favela_2_zombie_escort_19", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (28200, 4512, 2952.08), (0, 270, 0), "escort_favela_2_zombie_escort_20", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (28402, 5236, 2837.33), (0, 270, 0), "escort_favela_2_zombie_escort_21", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (28447, 5481, 2772.36), (0, 270, 0), "escort_favela_2_zombie_escort_22", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (27163, 4081, 2684.91), (0, 270, 0), "escort_favela_2_zombie_escort_17", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (27143, 3776, 2722.1), (0, 270, 0), "escort_favela_2_zombie_escort_18", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (28532, 4494, 2920.63), (0, 270, 0), "escort_favela_2_zombie_escort_20", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (28640, 4896, 2854.31), (0, 270, 0), "escort_favela_2_zombie_escort_21", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (28803, 5605, 2669.18), (0, 270, 0), "escort_favela_2_zombie_escort_22", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 200);
  s = s();
  fe[[f]](s, us, cf, (23611, -4304, 2373.09), (0, 270, 0), "escort_favela_2_neutralize_site_1", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (23804, -4519, 2377.05), (0, 270, 0), "escort_favela_2_neutralize_site_1", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (24291, 2098, 2354.73), (0, 270, 0), "escort_favela_2_neutralize_site_2", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (24087, 1917, 2351.52), (0, 270, 0), "escort_favela_2_neutralize_site_2", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (28270, 5425, 2822.34), (0, 270, 0), "escort_favela_2_neutralize_site_3", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (28177, 5327, 2837), (0, 270, 0), "escort_favela_2_neutralize_site_3", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (28156, 5167, 2843.44), (0, 270, 0), "escort_favela_2_neutralize_site_3", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (23495, -4438, 2378), (0, 270, 0), "escort_favela_2_neutralize_site_1", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (23622, -4653, 2375.51), (0, 270, 0), "escort_favela_2_neutralize_site_1", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (24355, 1908, 2386.58), (0, 270, 0), "escort_favela_2_neutralize_site_2", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (24321, 2006, 2368.81), (0, 270, 0), "escort_favela_2_neutralize_site_2", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (24177, 1850, 2383.9), (0, 270, 0), "escort_favela_2_neutralize_site_2", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (28449, 5346, 2789.32), (0, 270, 0), "escort_favela_2_neutralize_site_3", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (28440, 5259, 2803.98), (0, 270, 0), "escort_favela_2_neutralize_site_3", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (28335, 5088, 2846.02), (0, 270, 0), "escort_favela_2_neutralize_site_3", undefined, "escort_favela_2_dafx", undefined, undefined, (0, 0, 0));
  s = s();
  fe[[f]](s, us, cf, (24610, 4089, 2394.71), (0, 270, 0), "escort_favela_2_zombie_escort_horde", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 500);
  s = s();
  fe[[f]](s, us, cf, (25108, 4266, 2427.24), (0, 270, 0), "escort_favela_2_zombie_escort_horde", undefined, undefined, undefined, undefined, (0, 0, 0), undefined, 500);
  s = s();
  fe[[f]](s, us, cf, (28258, 5399, 2833.72), (0, 225, 0), "s_escort_zombies_lowtown_reward", undefined, undefined, undefined, undefined, (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.cf = "mp_jup_st_e_ob_objectives_lowtown_zombies_escort_cs";
  instancestruct.locationorigin = [(21761, -6505, 2314)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["ESCORT_ZOMBIES_LOWTOWN"] = instancestruct;
  return activityinstances;
}