/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5cbab8669e06366a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_contracts_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_contracts_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_contracts_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_contracts_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_contracts_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_contracts_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-24322, -31558, 1954), (0.27, 352.31, 1.98), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-11326, -40069, 2294), (356.21, 108.8, -1.29), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-11326, -40069, 2294), (358.12, 110.19, -0.69), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-7075, -35572, 1944), (359.48, 164.99, -1.93), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-20411, -38316, 2902), (1.92, 286.42, 0.57), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-10932, -36884, 2046), (0.3, 188.5, -1.98), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-14896, -42639, 3158), (0.32, 189.3, -1.97), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-9506, -38430, 2510), (359.29, 20.69, 1.87), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-13360, -35774, 2350), (359.51, 165.71, -1.94), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-21442, -38897, 2902), (359.19, 156.02, -1.83), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-17099, -41720, 2822), (358.23, 62.29, 0.93), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-17231, -37332, 2467), (1.59, 307.12, 1.21), "bigbounty_spawn", "G", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-10992.8, -24013.3, 1774), (0.17, 184.84, -1.99), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-8256, -38858, 2293), (358.12, 110.19, -0.69), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-8256, -38858, 2293), (356.54, 108.86, -2.24), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-15558, -40895, 2821), (358.12, 110.19, -0.69), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-15558, -40895, 2821), (356.86, 108.91, -3.18), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-21357, -37089, 2662), (358.11, 70.86, 0.65), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-21357, -37089, 2662), (355.54, 68.04, -0.36), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-20001, -37574, 2662), (355.54, 68.04, -0.36), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-20001, -37574, 2662), (357.78, 70.9, -0.29), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-16511, -36434, 2455), (357.83, 77.1, -0.53), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-16511, -36434, 2454), (355.45, 77.54, -2.06), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-12270, -35228, 1912), (357.24, 109.66, -4.17), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-12270, -35228, 1913), (358.48, 102.44, -2.38), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-23605, -35446, 2707), (357.68, 9.98, 1.62), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-23605, -35446, 2705), (355.33, 10.56, 3.2), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-23547, -33001, 2161), (355.61, 84.13, -3.56), "bigbounty_spawn", "G", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-23547, -33001, 2162), (357.24, 73.68, -2.32), "bigbounty_spawn", "G", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-12523, -34057, 1927), (0.54, 344.38, 1.92), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-16947, -32834, 1952), (0.54, 344.38, 1.92), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-16391, -35902, 2452), (358, 91.18, -0.04), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-18585, -38185, 2720), (358.04, 79.07, 0.38), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-8977, -37351, 2298), (359.39, 17.66, 1.9), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-22507, -35977, 2705), (358.11, 71.06, 0.65), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-25288, -30948, 1957), (359.3, 20.56, 1.87), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-15927, -39911, 2802), (359.3, 20.56, 1.87), "bigbounty_spawn", "G", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-10088, -8749.5, 1990), (1.59, 232.7, -1.21), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-4240.5, -10946.5, 1284), (1.76, 298.22, 0.95), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-1723, -16687.5, 1744), (359.21, 23.09, 1.84), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-6888, -15106.5, 1722), (358.62, 43.64, 1.45), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-13691, -19282.5, 1952), (1.81, 294.97, 0.84), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-5884, -22720, 1716), (359.28, 154.65, -0.58), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-9456.5, -16315.5, 2260), (359.16, 141.37, -0.4), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-3967, -28216, 1721), (0.92, 287.88, -0.13), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-15657, -16434, 1715), (359.08, 122.6, -0.11), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-14451, -10834, 1716), (1.98, 262.16, -0.27), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-14451, -10834, 1716), (3.99, 266.5, -0.24), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-8318, -12276, 1683), (358.42, 127.8, -1.23), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-8318, -12276, 1687), (357.39, 126.65, -3.19), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-3144, -15571.5, 1761), (0.29, 188.43, -1.98), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-3137, -15572.5, 1764), (2.61, 189.1, -3.63), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-2622.5, -18468, 1711.5), (1.17, 215.68, -1.62), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-2636.5, -18407, 1715.5), (1.6, 304.51, 4.73), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-4410, -22618.5, 1567), (358.03, 81.22, 0.3), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-4410, -22618.5, 1568), (355.28, 78.52, -3.12), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-12169, -24219.5, 1772.5), (0.23, 186.72, -1.98), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-12169, -24219.5, 1774.5), (5.03, 180.37, -3.96), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-17480, -13789, 1741), (0.49, 345.86, 1.94), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-17501, -13769, 1727), (355.6, 341.29, 0.72), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-5407.5, -26334, 1722), (359.72, 76.99, -4.45), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-5406.5, -26334, 1714), (357.86, 80.42, -0.65), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-9009, -15564.5, 1710), (0.77, 313.3, 2.1), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-9021, -15571.5, 1709), (356.38, 303.85, 4.08), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-17237, -8758, 1506), (0.2, 354.33, 1.99), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-11531.5, -7588.5, 1613.5), (0.26, 352.67, 1.98), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-6680.5, -9291.5, 1436.5), (1.65, 235.64, -1.13), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-10261, -13415, 1741.5), (1.33, 318.12, 1.49), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-12184, -15768, 1742.5), (358.69, 40.9, 1.51), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-13955, -21193, 1765), (1.67, 236.63, -1.1), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-14790.5, -25487, 1734), (358.01, 83.64, 0.22), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-6593, -21310, 1745.5), (358.31, 58.06, 1.06), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-4008.5, -13135.5, 1646), (1.39, 224.12, -1.43), "bigbounty_spawn", "G1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-10992.8, -24013.3, 1774), (5.22, 182.35, -3.7), "bigbounty_spawn", "G1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-9974.25, -23615.8, 5226.5), (359.72, 171.96, -1.98), "bigbounty_spawn", "G1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-13519.3, -24551.5, 5418), (1.41, 192.59, -1.73), "bigbounty_spawn", "G1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-13519.3, -24551.5, 5418), (4.28, 186.1, 1.27), "bigbounty_spawn", "G1", "disciple");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_contracts_bigbounty_cs");
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
    cf = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_7b882c3de56a5e50":
      function_5212a30a5ff733ef(fe, us, cf);
      break;
    case #"hash_8bc8d9b0245d9611":
      function_27d3b321f55f334(fe, us, cf);
      break;
    case #"hash_8251011ba3e9d311":
      function_ccb77434f0eae3f4(fe, us, cf);
      break;
    case #"hash_b788d6eb6e160ab0":
      function_b821623997468053(fe, us, cf);
      break;
  }
}

function function_5212a30a5ff733ef(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_G_LIBRARY", "BIGBOUNTY_G_LIBRARY", undefined, undefined, (-22207, -32221, 1992.5), (0, 264.26, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_G_LIBRARY", "G", undefined, undefined, (-22207, -32221, 1992.5), (0, 264.26, 0));
}

function function_27d3b321f55f334(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_G_OFFICE", "BIGBOUNTY_G_OFFICE", undefined, undefined, (-8814.5, -35721.5, 1957), (0, 30, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_G_OFFICE", "G", undefined, undefined, (-8814.5, -35721.5, 1957), (0, 30, 0));
}

function function_ccb77434f0eae3f4(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_G_MARKET", "BIGBOUNTY_G_MARKET", undefined, undefined, (-7661.5, -22085.5, 1750.5), (0, 160.37, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_G_MARKET", "G1", undefined, undefined, (-7661.5, -22085.5, 1750.5), (0, 160.37, 0));
}

function function_b821623997468053(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_G_GROCERY", "BIGBOUNTY_G_GROCERY", undefined, undefined, (-7857, -12981, 1876.5), (0, 334.79, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_G_GROCERY", "G1", undefined, undefined, (-7857, -12981, 1876.5), (0, 334.79, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (-22207, -32221, 1992.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_G_LIBRARY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-8814.5, -35721.5, 1957);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_G_OFFICE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-7661.5, -22085.5, 1750.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_G_MARKET"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (-7857, -12981, 1876.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_G_GROCERY"] = instancestruct;
  return activityinstances;
}