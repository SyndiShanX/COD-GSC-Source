/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_175e783b3edb414a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_contracts_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_contracts_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_contracts_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_contracts_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_contracts_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_contracts_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (2774, -15736.5, 1713.5), (358.55, 46.36, 1.38), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (3998.5, -17303, 1717), (3.77, 250.53, -1.33), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (3996.5, -17288, 1716), (1.91, 253.19, -0.58), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (12101, -23658.5, 1707), (359.99, 179.56, -2), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (6180.5, -19853.5, 1872), (0.37, 349.29, 1.96), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (5527, -14691, 1687), (1.99, 275.59, 0.2), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-624, -23413.5, 1720), (0.86, 334.49, 1.8), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (8870, -20818.5, 1745), (358.78, 37.49, 1.58), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (13803, -25460.5, 1712), (358.01, 94.73, -0.17), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (15313, -22033, 1706), (2, 270.72, 0.03), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (3289, -24449.5, 1488), (0.38, 349.04, 1.96), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (11236.5, -25502.5, 1756), (1.94, 283.69, 0.47), "bigbounty_spawn", "H1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (7546, -17480.5, 1709), (1.91, 253.19, -0.58), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (7549, -17474.5, 1710), (3.77, 250.53, -1.33), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (6514.5, -20229, 1736), (358.04, 78.99, 0.38), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (6514.5, -20229, 1736), (355.88, 78.34, -0.17), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (3389, -23619, 1519), (0.56, 343.65, 1.92), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (3391, -23613, 1522), (0.18, 343.46, 4.12), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (8694.5, -24163, 1768), (358.01, 85.42, 0.16), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (8694.5, -24163, 1768), (355.94, 85.72, -0.7), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (14785.5, -23157, 1688.5), (0.01, 180.39, -2), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (14785.5, -23156, 1689.5), (1.17, 182.38, -3.95), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (3541, -23619, 1944), (358.9, 164.01, -3.84), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (3539, -23619, 1944), (0.38, 163.07, -2.2), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (11310, -24150, 1709), (357.74, 34.38, 3.3), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (11310, -24150, 1709), (358.15, 29.28, 1.25), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (16257.5, -21775, 1714), (0.24, 183.47, -3.99), "bigbounty_spawn", "H1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (16257.5, -21775, 1714), (2.05, 181.4, -1.95), "bigbounty_spawn", "H1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (9808.5, -18817, 1708), (359.74, 7.53, 1.98), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (7637.5, -21933.5, 1776), (1.93, 254.97, -0.52), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (7020, -26412, 1707), (1.98, 262.99, -0.24), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (1408, -25493, 1710.5), (358.12, 70.65, 0.66), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (2408.5, -21330.5, 1720), (358.11, 70.96, 0.65), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (3314, -18135.5, 1707), (0.52, 344.98, 1.93), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (564, -15859, 1706.5), (1.8, 244.06, -0.87), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (4736, -15458, 1677), (0.68, 340.04, 1.88), "bigbounty_spawn", "H1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (2440, -27369, 1882), (0.4, 191.46, -1.96), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (5753.5, -27889, 2466), (358.84, 144.56, -1.63), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (8198, -27095.5, 1865), (1.46, 226.92, -1.36), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-1999, -31055, 1962), (2, 268.77, -0.04), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (3161, -31803, 1945), (358, 89.25, 0.03), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (17099.5, -33281, 2895), (358.08, 105.94, -0.55), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (6742.5, -35572.5, 2805), (0.31, 351.15, 1.98), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-1649.5, -38392, 2227.5), (358.09, 107.39, -0.6), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (4641, -38443, 2868), (1.97, 279.32, 0.32), "bigbounty_spawn", "H", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (1969, -35049, 1970), (0.56, 196.28, -1.92), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (1968, -35051, 1971), (2.95, 194.71, -3.36), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (584, -35315, 1960), (358.29, 103.56, -1.44), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (13609.5, -38090.5, 2988.5), (358.5, 131.32, -1.32), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (13608.5, -38093.5, 2988.5), (359.25, 134.56, -4.94), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (13225.5, -33403.5, 2523), (358.5, 131.32, -1.32), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (13225.5, -33401.5, 2526), (359.95, 134.57, -5.65), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-3736.5, -37674.5, 2211), (359.59, 11.91, 1.95), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-3739.5, -37675.5, 2201), (353.82, 23.75, 1.65), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (1786.5, -32008.5, 1913), (359.59, 11.91, 1.95), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (1786.5, -32008.5, 1914), (352.9, 23.8, 1.24), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-742, -26730, 1703.5), (1.98, 263.37, -0.23), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-742, -26730, 1707.5), (5.25, 259.37, -2.86), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (6213.5, -27813.5, 1929.5), (1.94, 256.58, -0.46), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (6213.5, -27813.5, 1929.5), (4.91, 247.14, -2.98), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (5172, -29464, 1964.5), (358.01, 93.9, -0.14), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (5172, -29464, 1963.5), (354.34, 93.19, -0.46), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (8951, -27654.5, 1712.5), (359.85, 176.98, -5.68), "bigbounty_spawn", "H", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (8951, -27654.5, 1712.5), (0.66, 170.59, -2.13), "bigbounty_spawn", "H", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-2883, -35540.5, 1949.5), (358.51, 15.32, 1.66), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (4429.5, -33596.5, 1915), (358.31, 104.28, -1.46), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (4495.5, -28493.5, 1959), (0.83, 175.36, -2.07), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (1082, -28074.5, 1920.5), (357.89, 82.98, -0.75), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (1379.5, -25579.5, 1706), (2.21, 251.99, 0.33), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (7006.5, -26393.5, 1706.5), (2.06, 266.1, 0.86), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-804.5, -38737.5, 2478), (358.39, 19.71, 1.54), "bigbounty_spawn", "H", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (11949.5, -35769.5, 2735.5), (1.66, 201.43, -1.49), "bigbounty_spawn", "H", "megabomb");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_contracts_bigbounty_cs");
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
    cf = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_8b0d62875efb57b1":
      function_7ac05738b1e213dc(fe, us, cf);
      break;
    case #"hash_2c610299fb64c2d3":
      function_1be3990e5d694dcc(fe, us, cf);
      break;
    case #"hash_3445b07972afd5eb":
      function_a0d941066c654eba(fe, us, cf);
      break;
    case #"hash_f53bb949569b1317":
      function_5fb7ed93d3ece510(fe, us, cf);
      break;
  }
}

function function_7ac05738b1e213dc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_H_AUTO", "BIGBOUNTY_H_AUTO", undefined, undefined, (3646.5, -16892.5, 1756), (0, 271.14, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_H_AUTO", "H1", undefined, undefined, (3646.5, -16892.5, 1756), (0, 271.14, 0));
}

function function_1be3990e5d694dcc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_H_LAUNDRY", "BIGBOUNTY_H_LAUNDRY", undefined, undefined, (10883, -23111, 1764), (0, 6.74, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_H_LAUNDRY", "H1", undefined, undefined, (10883, -23111, 1764), (0, 6.74, 0));
}

function function_a0d941066c654eba(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_H_CAFE", "BIGBOUNTY_H_CAFE", undefined, undefined, (7900, -37081, 2847), (0, 341.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_H_CAFE", "H", undefined, undefined, (7900, -37081, 2847), (0, 341.07, 0));
}

function function_5fb7ed93d3ece510(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_H_BAR", "BIGBOUNTY_H_BAR", undefined, undefined, (-1877, -31136.5, 1840.5), (0, 181.68, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_H_BAR", "H", undefined, undefined, (-1877, -31136.5, 1840.5), (0, 181.68, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (3646.5, -16892.5, 1756);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_H_AUTO"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (10883, -23111, 1764);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_H_LAUNDRY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (7900, -37081, 2847);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_H_CAFE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_h_ob_contracts_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-1877, -31136.5, 1840.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_H_BAR"] = instancestruct;
  return activityinstances;
}