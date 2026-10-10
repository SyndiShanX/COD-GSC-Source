/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1ef70583304b1eeb.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_escort_cs");
}

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
    cf = "mp_jup_st_e_ob_escort_cs";
  }

  switch (instancename) {
    case #"hash_96cec04f2eb7e2b6":
      function_b31a633578ac354d(fe, us, cf);
      break;
    case #"hash_f0c04b7a6a6673b2":
      function_c1af6e04a35d497f(fe, us, cf);
      break;
    case #"hash_589abbf66a5e6f81":
      function_7ea479f320ee401e(fe, us, cf);
      break;
    case #"hash_eff7b3f99b2c17d0":
      function_d11200d903e6ec9b(fe, us, cf);
      break;
  }
}

function function_b31a633578ac354d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20660, 2876, 1969.4), (0, 0, 0), "escort_e_lowtown_original_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (21620, 580, 2158.62), (0, 0, 0), "escort_e_lowtown_original_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20196, 1544, 1995.82), (0, 0, 0), "escort_e_lowtown_original_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19396, 200, 2007.47), (0, 0, 0), "escort_e_lowtown_original_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20268, -8, 2188), (0, 0, 0), "escort_e_lowtown_original_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19892, -1868, 2024.41), (0, 0, 0), "escort_e_lowtown_original_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19636, -2496, 1992.41), (0, 0, 0), "escort_e_lowtown_original_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20344, -3840, 2000.16), (0, 0, 0), "escort_e_lowtown_original_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19368, -4120, 1875.84), (0, 0, 0), "escort_e_lowtown_original_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20028, -5304, 1856.11), (0, 0, 0), "escort_e_lowtown_original_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (18712, -5108, 1694.08), (0, 0, 0), "escort_e_lowtown_original_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19048, -5068, 1734.07), (0, 40, 0), "ESCORT_ZOMBIES_E_LOWTOWN_ORIGINAL_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (23488, 300, 2532), (0, 0, 0), "ESCORT_ZOMBIES_E_LOWTOWN_ORIGINAL", undefined, "escort_e_lowtown_original", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (22291, -2437, 2490), (0, 237.16, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_E_LOWTOWN_ORIGINAL", "ESCORT_ZOMBIES_E_LOWTOWN_ORIGINAL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (21428, 1356, 2144.14), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (21116, 3096, 1984), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19548, 624, 2009), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20088, -1788, 2024.41), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20952, -2824, 2165.48), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (18676, -2868, 1832.18), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (17944, -5360, 1591.32), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (18104, -3436, 1815.35), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19124, -5916, 1876.86), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19376, -4580, 1772.72), (0, 0, 0), "escort_e_lowtown_original_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (19462, -3056, 1962.89), (0, 0, 0), "escort_e_lowtown_original_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (20040, 760, 1998), (0, 0, 0), "escort_e_lowtown_original_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (17826, -4170, 1688.57), (0, 0, 0), "escort_e_lowtown_original_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c1af6e04a35d497f(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10858, 8028, 1064), (0, 0, 0), "escort_e_cargo_warehouse_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-9388, 11082, 1024), (0, 0, 0), "ESCORT_ZOMBIES_E_CARGO_WAREHOUSE", undefined, "escort_e_cargo_warehouse", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-13279.5, 10988, 1308.5), (0, 99.85, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_E_CARGO_WAREHOUSE", "ESCORT_ZOMBIES_E_CARGO_WAREHOUSE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10256.5, 9509.5, 1056), (0, 0, 0), "escort_e_cargo_warehouse_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-11022, 6600, 1055), (0, 0, 0), "escort_e_cargo_warehouse_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-11552, 5526, 1064), (0, 0, 0), "escort_e_cargo_warehouse_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-11850, 5470, 1064), (0, 0, 0), "escort_e_cargo_warehouse_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10950, 4512, 1064), (0, 0, 0), "escort_e_cargo_warehouse_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-11714, 2344, 1064), (0, 0, 0), "escort_e_cargo_warehouse_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-11396, 480, 1055), (0, 0, 0), "escort_e_cargo_warehouse_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-12128, 4232, 1056), (0, 0, 0), "escort_e_cargo_warehouse_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10754, 458, 1055), (0, 216, 0), "ESCORT_ZOMBIES_E_CARGO_WAREHOUSE_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-11704, 7472, 1054), (0, 0, 0), "escort_e_cargo_warehouse_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10392, 654, 1055), (0, 0, 0), "escort_e_cargo_warehouse_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-12456, 5836, 1055), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-11202, 5390, 1064), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-12400, 5156, 1200), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10694, 7498, 1055), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10316, 8440, 1064), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10178, 1278, 1200), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-9850, 904, 1064), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-10376, -84, 1054.99), (0, 0, 0), "escort_e_cargo_warehouse_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_7ea479f320ee401e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-2036, 1668, 2008), (0, 0, 0), "ESCORT_ZOMBIES_E_OLDTOWN_BRIDGE", undefined, "escort_e_oldtown_bridge", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (2272, -4844, 2008), (0, 65, 0), "ESCORT_ZOMBIES_E_OLDTOWN_BRIDGE_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-1932, 5194, 2040), (0, 181.49, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_E_OLDTOWN_BRIDGE", "ESCORT_ZOMBIES_E_OLDTOWN_BRIDGE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (1332, 2088, 2008), (0, 0, 0), "escort_e_oldtown_bridge_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-516, 1396, 2008), (0, 0, 0), "escort_e_oldtown_bridge_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (2072, 1956, 2013), (0, 0, 0), "escort_e_oldtown_bridge_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-100, 512, 2013), (0, 0, 0), "escort_e_oldtown_bridge_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-1044, 20, 2013), (0, 0, 0), "escort_e_oldtown_bridge_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (828, -472, 2012.86), (0, 0, 0), "escort_e_oldtown_bridge_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (1428, -3132, 2012.86), (0, 0, 0), "escort_e_oldtown_bridge_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (2176, -4048, 2012.86), (0, 0, 0), "escort_e_oldtown_bridge_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (2344, -5008, 2013), (0, 0, 0), "escort_e_oldtown_bridge_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (1852, 3112, 2012), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (948, 1050, 2008), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-392, 2056, 2008), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-792, -1168, 1821), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (1224, -844, 1821), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (-652, 424, 2013), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (2248, -5668, 2013), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (1344, -2876, 2013), (0, 0, 0), "escort_e_oldtown_bridge_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (490, -1404, 2008), (0, 0, 0), "escort_e_oldtown_bridge_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (2186, 1862, 2008), (0, 0, 0), "escort_e_oldtown_bridge_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (2100, -5544, 2016), (0, 0, 0), "escort_e_oldtown_bridge_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_d11200d903e6ec9b(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8697, -3700, 2392), (0, 0, 0), "escort_e_palace_ramps_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (7828, 2368, 1624), (0, 0, 0), "ESCORT_ZOMBIES_E_PALACE_RAMPS", undefined, "escort_e_palace_ramps", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (7584, -50, 2008), (0, 0, 0), "escort_e_palace_ramps_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8754, -6788.25, 2367.93), (0, 0, 0), "escort_e_palace_ramps_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (7790, 560, 2008), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (12628.5, 5801.5, 2115.77), (0, 127.28, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_E_PALACE_RAMPS", "ESCORT_ZOMBIES_E_PALACE_RAMPS", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (9286, -1348, 2204), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8764, 1024, 2012), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (9822, -3586, 2365.13), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8284, -2710, 2392), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (9776, -2038, 2400), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8157, -7206, 2379.22), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8875.5, -4716.75, 2392), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (7507.25, -7047.75, 2392), (0, 0, 0), "escort_e_palace_ramps_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8052, 622, 2008), (0, 0, 0), "escort_e_palace_ramps_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8968, 1304, 2005.99), (0, 0, 0), "escort_e_palace_ramps_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (10028, 834, 2006.24), (0, 0, 0), "escort_e_palace_ramps_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8420, -246, 2008), (0, 0, 0), "escort_e_palace_ramps_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8502, -1762, 2208), (0, 0, 0), "escort_e_palace_ramps_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (9622, -1454, 2208), (0, 0, 0), "escort_e_palace_ramps_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8560, -3022, 2392), (0, 0, 0), "escort_e_palace_ramps_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (9610, -3234, 2392), (0, 0, 0), "escort_e_palace_ramps_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (8492, -5358, 2392), (0, 0, 0), "escort_e_palace_ramps_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (7762.75, -6335.75, 2389.33), (0, 0, 0), "escort_e_palace_ramps_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_escort_cs";
  fe[[f]](s, us, cf, (7194, -5608, 2392), (0, 88, 0), "ESCORT_ZOMBIES_E_PALACE_RAMPS_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_e_ob_escort_cs";
  instancestruct.scriptstructorigin = (23256, 224, 2536);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(20404, 1900, 1991.47), (23356, 290, 2529.38), (19612, -2132, 1987.22), (18300, -4600, 1680.92)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 750, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_E_LOWTOWN_ORIGINAL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_e_ob_escort_cs";
  instancestruct.scriptstructorigin = (-9778, 11316, 1024);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-9854, 11100, 1024), (-11108, 8678, 1056), (-11836, 5596, 1064), (-11358, 424, 1054)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_E_CARGO_WAREHOUSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_e_ob_escort_cs";
  instancestruct.scriptstructorigin = (-1936, 1632, 2008);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(1284, 2016, 2013), (-2107, 1710, 2013), (80, -536, 2013), (2188, -4364, 2013)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [750, 750, 750, 750];
  activityinstances["ESCORT_ZOMBIES_E_OLDTOWN_BRIDGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_e_ob_escort_cs";
  instancestruct.scriptstructorigin = (7582, 2244, 1656);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(8034.25, -6078.25, 2386.47), (9086, -3082, 2392), (8576, -148, 2008), (7600, 2068, 1624)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_E_PALACE_RAMPS"] = instancestruct;
  return activityinstances;
}