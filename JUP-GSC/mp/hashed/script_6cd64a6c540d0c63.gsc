/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6cd64a6c540d0c63.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_contracts_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_contracts_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_contracts_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_contracts_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_contracts_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_contracts_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_contracts_escort_cs");
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
    cf = "mp_jup_st_g_ob_contracts_escort_cs";
  }

  switch (instancename) {
    case #"hash_92030038b7211392":
      function_2225a0fabdf130d3(fe, us, cf);
      break;
    case #"hash_7cda81a7ce9a8174":
      function_a4d03edb6ed622c9(fe, us, cf);
      break;
    case #"hash_f110255666714fa":
      function_1bf22a0aba45dfb1(fe, us, cf);
      break;
  }
}

function function_2225a0fabdf130d3(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31724, -16294, 1217.95), (0, 0, 0), "escort_g_beach_hotel_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32480, -19376, 1203.54), (0, 0, 0), "ESCORT_ZOMBIES_G_BEACH_HOTEL", undefined, "escort_g_beach_hotel", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28586.5, -16227.5, 1608), (0, 0, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_G_BEACH_HOTEL", "ESCORT_ZOMBIES_G_BEACH_HOTEL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29514, -9326, 1526.96), (0, 0, 0), "ESCORT_ZOMBIES_G_BEACH_HOTEL_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33482, -16881, 956.15), (0, 0, 0), "escort_g_beach_hotel_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31657, -14697, 1418.52), (0, 0, 0), "escort_g_beach_hotel_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32673, -15151, 1177.98), (0, 0, 0), "escort_g_beach_hotel_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31965, -13391, 1476.92), (0, 0, 0), "escort_g_beach_hotel_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31308, -13205, 1526.96), (0, 0, 0), "escort_g_beach_hotel_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30172, -11861, 1545), (0, 0, 0), "escort_g_beach_hotel_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29470, -10715, 1544.5), (0, 0, 0), "escort_g_beach_hotel_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29498, -9182, 1526.98), (0, 0, 0), "escort_g_beach_hotel_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30301, -9807, 1526.96), (0, 0, 0), "escort_g_beach_hotel_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29386, -12046, 1528.61), (0, 0, 0), "escort_g_beach_hotel_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30594, -14052, 1481.73), (0, 0, 0), "escort_g_beach_hotel_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30655, -9897, 1526.95), (0, 0, 0), "escort_g_beach_hotel_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30001, -16370, 1401.19), (0, 0, 0), "escort_g_beach_hotel_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31632, -14620, 1413.62), (0, 0, 0), "escort_g_beach_hotel_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30805, -11437, 1544.5), (0, 0, 0), "escort_g_beach_hotel_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31341, -12735, 1526.96), (0, 0, 0), "escort_g_beach_hotel_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29461, -10542, 1543.5), (0, 0, 0), "escort_g_beach_hotel_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28742, -8812, 1529.8), (0, 0, 0), "escort_g_beach_hotel_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30985, -10219, 1526.96), (0, 0, 0), "escort_g_beach_hotel_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_a4d03edb6ed622c9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6987, -19325, 1696.97), (0, 0, 0), "escort_g_firehouse_canal_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-16049.5, -10576.5, 1535.04), (0, 166, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_G_FIREHOUSE_CANAL", "ESCORT_ZOMBIES_G_FIREHOUSE_CANAL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-11059, -13366, 1712), (0, 0, 0), "ESCORT_ZOMBIES_G_FIREHOUSE_CANAL", undefined, "escort_g_firehouse_canal", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8975, -15835, 1706.95), (0, 0, 0), "escort_g_firehouse_canal_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-3519, -22073, 1548), (0, 0, 0), "escort_g_firehouse_canal_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9438, -16050, 1720), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10698, -14964, 1720), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10122, -16032, 1720), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5602, -19124, 1696.97), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7392, -19086, 1726.41), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7242, -17876, 1740), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5564, -21750, 1548), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-4774, -21464, 1712), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-3848, -21670, 1712), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-3632, -23262, 1707.95), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5398, -23166, 1707.95), (0, 0, 0), "escort_g_firehouse_canal_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10112, -14752, 1751.9), (0, 0, 0), "escort_g_firehouse_canal_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-4250, -22712, 1568), (0, 102, 0), "ESCORT_ZOMBIES_G_FIREHOUSE_CANAL_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8760, -13782, 1708), (0, 0, 0), "escort_g_firehouse_canal_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9140, -15452, 1706.95), (0, 0, 0), "escort_g_firehouse_canal_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9120, -16986, 1707.97), (0, 0, 0), "escort_g_firehouse_canal_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7262, -15548, 1708), (0, 0, 0), "escort_g_firehouse_canal_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-5200, -17250, 1709.97), (0, 0, 0), "escort_g_firehouse_canal_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6636, -18726, 1696.97), (0, 0, 0), "escort_g_firehouse_canal_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6442, -20584, 1708), (0, 0, 0), "escort_g_firehouse_canal_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7486, -21882, 1708), (0, 0, 0), "escort_g_firehouse_canal_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-6420, -22522, 1715.96), (0, 0, 0), "escort_g_firehouse_canal_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-4356, -22550, 1564), (0, 0, 0), "escort_g_firehouse_canal_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1bf22a0aba45dfb1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-12252, -41904.5, 2417.5), (0, 250.24, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_G_MED_CENTER", "ESCORT_ZOMBIES_G_MED_CENTER", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7722, -41986, 2400), (0, 0, 0), "ESCORT_ZOMBIES_G_MED_CENTER", undefined, "escort_g_med_center", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-11192, -40210, 2300), (0, 0, 0), "escort_g_med_center_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-15180, -41114, 2820), (0, 186, 0), "ESCORT_ZOMBIES_G_MED_CENTER_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9276, -39160, 2300), (0, 0, 0), "escort_g_med_center_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-16600, -42154, 2819.98), (0, 0, 0), "escort_g_med_center_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8428, -40090, 2294), (0, 0, 0), "escort_g_med_center_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9310, -38394, 2294), (0, 0, 0), "escort_g_med_center_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7932, -37116, 2154.67), (0, 0, 0), "escort_g_med_center_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10788, -38878, 2293.5), (0, 0, 0), "escort_g_med_center_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-12148, -38076, 2165.5), (0, 0, 0), "escort_g_med_center_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-13094, -39178, 2301.73), (0, 0, 0), "escort_g_med_center_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-16660, -42504, 2829.5), (0, 0, 0), "escort_g_med_center_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-14112, -41210, 2597.5), (0, 0, 0), "escort_g_med_center_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-16346, -40282, 2810.43), (0, 0, 0), "escort_g_med_center_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-16936, -41528, 2819.98), (0, 0, 0), "escort_g_med_center_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-15302, -39782, 2807.06), (0, 0, 0), "escort_g_med_center_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-8894, -39388, 2293.5), (0, 0, 0), "escort_g_med_center_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-7866, -39472, 2292), (0, 0, 0), "escort_g_med_center_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-9980, -37234, 2165.5), (0, 0, 0), "escort_g_med_center_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-10174, -38516, 2293.5), (0, 0, 0), "escort_g_med_center_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-11678, -39312, 2292.97), (0, 0, 0), "escort_g_med_center_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-14080, -39588, 2448.88), (0, 0, 0), "escort_g_med_center_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-14538, -40392, 2649.46), (0, 0, 0), "escort_g_med_center_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-16580, -42148, 2819.98), (0, 0, 0), "escort_g_med_center_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-33270, -19486, 1130);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-30889, -15383, 1340.62), (-32899, -19263, 1130.35), (-29934, -12408, 1527.18), (-29679, -9448, 1527)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_G_BEACH_HOTEL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-11058, -13172, 1720);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-11018, -13614, 1722), (-8822, -15880, 1710), (-6318, -18428, 1708), (-4397, -22402, 1567)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_G_FIREHOUSE_CANAL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-8008, -42032, 2400);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-8204, -38674, 2292.96), (-7782, -41960, 2400), (-11768, -39126, 2292.97), (-15642, -41422, 2826)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_G_MED_CENTER"] = instancestruct;
  return activityinstances;
}