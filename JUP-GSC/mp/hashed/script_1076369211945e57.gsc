/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1076369211945e57.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_contracts_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_contracts_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_contracts_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_contracts_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_contracts_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_contracts_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_contracts_escort_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_ESCORT_ZOMBIES";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydef_escort";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_b_ob_contracts_escort_cs";
  }

  switch (instancename) {
    case #"hash_5f13b7dd41ae1709":
      function_78d610a1c85e720c(fe, us, cf);
      break;
    case #"hash_f94789eca9fc95f0":
      function_13d897f8f0a195a7(fe, us, cf);
      break;
  }
}

function function_78d610a1c85e720c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5026.56, 38173.2, 1317.09), (0, 0, 0), "escort_b_factory_ambush_1", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7590.5, 35542, 1263.45), (0, 304.43, 0), "ESCORT_ZOMBIES_B_FACTORY_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-4899, 39452, 1498), (0, 0, 0), "escort_b_factory_ambush_1", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5688.29, 39065.6, 1430.48), (0, 0, 0), "escort_b_factory_ambush_2", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5493.73, 37735.1, 1366.02), (0, 0, 0), "escort_b_factory_ambush_2", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7217.51, 38595, 1362.94), (0, 0, 0), "escort_b_factory_ambush_3", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6252.75, 37395.7, 1339.34), (0, 0, 0), "escort_b_factory_ambush_3", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8436.13, 37574.5, 1354.15), (0, 0, 0), "escort_b_factory_ambush_4", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8169.91, 38665.9, 1429.66), (0, 0, 0), "escort_b_factory_ambush_4", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8517.33, 37025.3, 1340.47), (0, 0, 0), "escort_b_factory_ambush_5", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9208.46, 39095.2, 1649.93), (0, 0, 0), "escort_b_factory_ambush_5", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8437.73, 36422, 1392.45), (0, 0, 0), "escort_b_factory_ambush_6", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9687.91, 36266, 1295.89), (0, 0, 0), "escort_b_factory_ambush_6", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6925.06, 37019.2, 1358.14), (0, 0, 0), "escort_b_factory_ambush_7", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7511.99, 35993.9, 1321.54), (0, 0, 0), "escort_b_factory_ambush_7", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5674.75, 36927.6, 1358.58), (0, 0, 0), "escort_b_factory_ambush_8", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7021.15, 35299.8, 1252.85), (0, 0, 0), "escort_b_factory_ambush_8", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6184.09, 37476.9, 1350.54), (0, 0, 0), "escort_b_factory_ambush_9", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5281.34, 36876.4, 1337.3), (0, 0, 0), "escort_b_factory_ambush_9", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5155.51, 35730.6, 1332.7), (0, 0, 0), "escort_b_factory_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7270.8, 34715.7, 1175.68), (0, 0, 0), "escort_b_factory_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8292.88, 35643.8, 1261.11), (0, 0, 0), "escort_b_factory_ambush_11", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6962.55, 33874, 1149.29), (0, 0, 0), "escort_b_factory_ambush_11", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6954.17, 38200.4, 1355.88), (0, 0, 0), "escort_b_factory_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7216.35, 38973.7, 1448.96), (0, 0, 0), "escort_b_factory_crystal_spawn_1", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7262.58, 37474.8, 1352.96), (0, 0, 0), "escort_b_factory_crystal_spawn_1", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6826.71, 37296.1, 1354.99), (0, 0, 0), "escort_b_factory_crystal_spawn_1", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5732.08, 36909.1, 1359.51), (0, 0, 0), "escort_b_factory_crystal_spawn_1", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6705.68, 39469.5, 1758.21), (0, 0, 0), "escort_b_factory_crystal_spawn_1", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7438.77, 36900.4, 1341.76), (0, 0, 0), "escort_b_factory_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6810.12, 37231, 1360.46), (0, 0, 0), "escort_b_factory_crystal_spawn_2", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8005.29, 36010.5, 1384.46), (0, 0, 0), "escort_b_factory_crystal_spawn_2", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6281.37, 36543.6, 1353.52), (0, 0, 0), "escort_b_factory_crystal_spawn_2", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7631.11, 37360.3, 1352.52), (0, 0, 0), "escort_b_factory_crystal_spawn_2", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6737.21, 33696.5, 1195.33), (0, 0, 0), "escort_b_factory_crystal_spawn_3", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8549.72, 33827.8, 1198.94), (0, 0, 0), "escort_b_factory_crystal_spawn_3", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9065.88, 35941.6, 1275.94), (0, 0, 0), "escort_b_factory_crystal_spawn_3", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7157.59, 36864.8, 1341.68), (0, 0, 0), "escort_b_factory_crystal_spawn_3", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7825.92, 35265.3, 1260.95), (0, 0, 0), "escort_b_factory_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-2640, 38797, 1388.76), (0, 0, 0), "ESCORT_ZOMBIES_B_FACTORY", undefined, "ESCORT_ZOMBIES_B_FACTORY", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (2367.5, 37596, 1444.5), (1.4, 51.08, -0.86), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_B_FACTORY", "ESCORT_ZOMBIES_B_FACTORY", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_13d897f8f0a195a7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7976, 23520, 999.7), (0, 0, 0), "escort_b_construction_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5768, 30012, 1024), (0, 0, 0), "ESCORT_ZOMBIES_B_CONSTRUCTION", undefined, "escort_b_construction", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6644, 23504, 1000), (0, 130, 0), "ESCORT_ZOMBIES_B_CONSTRUCTION_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6952, 23160, 1000), (0, 0, 0), "escort_b_construction_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6396, 24716, 1001.5), (0, 0, 0), "escort_b_construction_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5572, 23640, 1008.55), (0, 0, 0), "escort_b_construction_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8736, 26312, 1043.86), (0, 0, 0), "escort_b_construction_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7924, 28408, 1027.46), (0, 0, 0), "escort_b_construction_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9328, 26680, 1046.77), (0, 0, 0), "escort_b_construction_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8020, 26424, 1027.79), (0, 0, 0), "escort_b_construction_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10448, 29880, 1201.52), (0, 0, 0), "escort_b_construction_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9968, 31056, 1216), (0, 0, 0), "escort_b_construction_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8524, 29456, 1183.27), (0, 0, 0), "escort_b_construction_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7192, 30976, 1220), (0, 0, 0), "escort_b_construction_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7516, 29276, 1065.32), (0, 0, 0), "escort_b_construction_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8072, 30908, 1177.5), (0, 0, 0), "escort_b_construction_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8324, 29980, 1183.27), (0, 0, 0), "escort_b_construction_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9524, 30244, 1198.33), (0, 0, 0), "escort_b_construction_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9740, 28868, 1198.33), (0, 0, 0), "escort_b_construction_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10556, 29116, 1244.77), (0, 0, 0), "escort_b_construction_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10660, 28080, 1182.49), (0, 0, 0), "escort_b_construction_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8780, 27724, 1026.91), (0, 0, 0), "escort_b_construction_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7116, 27288, 1094.55), (0, 0, 0), "escort_b_construction_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7080, 26368, 1002), (0, 0, 0), "escort_b_construction_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8184, 26136, 1034.22), (0, 0, 0), "escort_b_construction_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8560, 25316, 1006.27), (0, 0, 0), "escort_b_construction_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8000, 24568, 997.9), (0, 0, 0), "escort_b_construction_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7036, 23960, 880.01), (0, 0, 0), "escort_b_construction_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9948, 30152, 1210.25), (0, 0, 0), "escort_b_construction_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-942.75, 29239.5, 1065.75), (0, 18.17, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_B_CONSTRUCTION", "ESCORT_ZOMBIES_B_CONSTRUCTION", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8300, 27746, 1036.91), (0, 0, 0), "escort_b_construction_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7016, 23034, 1004.09), (0, 0, 0), "escort_b_construction_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_b_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-2607, 38759, 1389.82);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-8387.14, 36922, 1393), (-2596.5, 38716.5, 1385.36), (-7237, 35068.6, 1301.15), (-6175.8, 38364.3, 1353.53)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_B_FACTORY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_b_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-5672, 30120, 1004);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-9356, 30100, 1208.73), (-5220, 30376, 1034.62), (-8784, 27680, 1036.91), (-7012, 23468, 1009.97)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_B_CONSTRUCTION"] = instancestruct;
  return activityinstances;
}