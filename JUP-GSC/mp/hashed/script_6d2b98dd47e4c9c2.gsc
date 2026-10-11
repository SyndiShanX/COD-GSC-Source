/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6d2b98dd47e4c9c2.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_activities_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_activities_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_activities_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_activities_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_activities_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_activities_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-26298.5, -23011, 1724), (359.09, 152.91, -1.78), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-25113, -24755.5, 1698), (355.93, 84.97, -0.65), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-25113, -24755.5, 1698), (357.81, 75.38, -0.46), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-29474.5, 14511.5, 1089), (1.94, 256.4, -0.47), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-25877.5, -16243.5, 1544), (0.47, 346.52, 1.94), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-29807.5, -11073, 1542.5), (1.22, 322.32, 1.58), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-20581.5, -7231, 1506), (0.21, 186.03, -1.99), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-24493, 973, 1017), (0.34, 189.86, -1.97), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-32787.5, 2981, 1105), (0.2, 354.14, 1.99), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-27887.5, 10229.5, 1560), (358.01, 95.23, -0.18), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-32756, 14796, 1087), (358.75, 141.18, -1.56), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-13933.5, -13947.5, 1966), (0.41, 191.88, -1.96), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-22730.5, -9835.5, 1505), (358.01, 90.7, -1.02), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-22730, -9835.5, 1504.5), (355.98, 88.83, -0.92), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-13574, -10907.5, 1712), (0.89, 176.82, -2.05), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-13574, -10907.5, 1711), (1.81, 177.36, -4.09), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-14042.5, -13943.5, 2101), (1.35, 296.27, 1.78), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-14043.5, -13941.5, 2102), (2.07, 298.7, 4.55), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-33327.5, 7009.5, 997), (358.56, 6.36, 3.86), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-33326.5, 7009.5, 989.5), (357.64, 11.63, 1.55), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-32784.5, 12182, 968), (357.85, 4.42, 1.84), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-32784.5, 12182, 968), (358.41, 8.58, 3.8), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-26472.5, 4309, 1034), (3.73, 281.2, 1.76), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-26463.5, 4318.5, 1032), (1.49, 279.21, 3.28), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-26290.5, 10404, 1150), (3.12, 183.72, -1.8), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-26290.5, 10404, 1150), (2.19, 182.68, -3.9), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-28044, 14257, 1157), (2.41, 261.68, 2.68), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-28044, 14257, 1157), (4.32, 263.46, 2.52), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-29376.5, 10300, 1000.5), (358.01, 92.4, -0.08), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-25568, 8311, 1118), (0.27, 187.63, -1.98), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-21071, 1704, 1312.5), (1.33, 318.27, 1.49), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-24179, -9836.5, 1505), (359.95, 1.47, 1.99), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-16203, -14740, 1707.5), (358.49, 130.83, -1.31), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-30506, -16359.5, 1337), (358.07, 74.71, 0.52), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-20407.5, -24448, 1714.5), (358.16, 66.91, 0.78), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-14276, -8201.5, 1651), (358.41, 127.33, -1.21), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-12767.5, -7989.5, 1713), (1.9, 251.8, -0.62), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-22948, -14170, 1538.5), (358.21, 116.42, -0.89), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-21408, -25302.5, 1719), (358, 89.77, 0.01), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-25481, -27941, 1714), (358, 89.77, 0.01), "bigbounty_spawn", "D1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-28500, -21289, 1699), (358, 91.52, -0.05), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-20630.5, -13526.5, 1509), (358.23, 117.61, -0.93), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-19886.5, -7683.5, 1505), (358.02, 96.85, -0.24), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-27230.5, -14332, 1528.5), (358.07, 75.54, 0.5), "bigbounty_spawn", "D1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-14047.5, -9399.5, 1718), (1.41, 192.36, -1.74), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-14047.5, -9399.5, 1721), (2.74, 191.19, -3.53), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-18029.5, -19849, 1650), (357.94, 40.66, 0.86), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-18029.5, -19849, 1650), (355.15, 39, 1.22), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-30021, -11455, 1544.5), (359.88, 150.28, -2.23), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-30021, -11455, 1546.5), (1.57, 151.16, -5.43), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-25665, -19757.5, 1698), (357.84, 77.92, -0.56), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-25665, -19757.5, 1698), (355.04, 78.01, -4.05), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-22538.5, -12643.5, 1505), (0.41, 164.1, -2.2), "bigbounty_spawn", "D1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-22538.5, -12643.5, 1505), (4.21, 159.33, -5.85), "bigbounty_spawn", "D1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-32863.5, 10806, 960), (1.96, 280.67, 0.37), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-27998.5, 6976, 1456), (1.39, 315.94, 1.44), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-27006, 2355, 1456), (358, 90.11, -0.01), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-27514, 15409.5, 1171.5), (0.55, 195.88, -1.92), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-18865.5, 5028.5, 1415), (359.26, 158.29, -1.86), "bigbounty_spawn", "D", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-29449.5, 4905.5, 1037.5), (1.96, 280.2, 0.35), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-27518.5, 820.5, 1023.5), (358.2, 115.43, -0.86), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-24684, -382, 1010), (359.19, 155.99, -1.82), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-24568.5, 12712.5, 1543.5), (1.21, 217.27, -1.59), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-17742.5, 7908, 1273.5), (358.16, 67.4, 0.77), "bigbounty_spawn", "D", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-22777, -1267, 1010), (2.41, 261.68, 2.68), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-22777, -1267, 1010), (4.32, 263.46, 2.52), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-22325, 3083, 1221), (3.28, 238.26, 1.5), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-22331, 3083, 1220), (5.6, 232.91, 0.77), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-36221, -1020, 1008), (356.57, 15.6, 1.12), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-36221, -1020, 1008), (354.08, 16.44, 2.42), "bigbounty_spawn", "D", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-31993.5, 2456.5, 960.5), (358.64, 101.47, -3.33), "bigbounty_spawn", "D", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-31993.5, 2456.5, 960.5), (356.94, 98.78, -6.53), "bigbounty_spawn", "D", "disciple");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_activities_bigbounty_cs");
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
    cf = "mp_jup_st_d_ob_activities_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_415e9be25eef7f22":
      function_ec143242f908dc85(fe, us, cf);
      break;
    case #"hash_a89cdd76185027e2":
      function_2afd09f5394781fd(fe, us, cf);
      break;
    case #"hash_13f683881d914fb3":
      function_2b6e4bc8d2e9572e(fe, us, cf);
      break;
    case #"hash_da38f779cf0d6d2f":
      function_332bc58d32624108(fe, us, cf);
      break;
  }
}

function function_ec143242f908dc85(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (-14, 0, 6), (0, 201.9, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_D_KITCHEN", "BIGBOUNTY_D_KITCHEN", undefined, undefined, (-29907, -10469, 1583.5), (0, 112.89, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (2, -52, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_D_KITCHEN", "D1", undefined, undefined, (-29907, -10469, 1583.5), (0, 112.89, 0));
}

function function_2afd09f5394781fd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_D_TOY", "BIGBOUNTY_D_TOY", undefined, undefined, (-18801.5, -8542, 1554.5), (0, 190.05, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_D_TOY", "D1", undefined, undefined, (-18801.5, -8542, 1554.5), (0, 190.05, 0));
}

function function_2b6e4bc8d2e9572e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_D_DESK", "BIGBOUNTY_D_DESK", undefined, undefined, (-23269.5, 3480.5, 1276.92), (0, 173.36, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_D_DESK", "D", undefined, undefined, (-23269.5, 3480.5, 1276.92), (0, 173.36, 0));
}

function function_332bc58d32624108(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_D_STORAGE", "BIGBOUNTY_D_STORAGE", undefined, undefined, (-35071, 11333.5, 996), (0, 330.58, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_D_STORAGE", "D", undefined, undefined, (-35071, 11333.5, 996), (0, 330.58, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_d_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (2, -52, 0);
  instancestruct.scriptstructoriginoffset = (-29907, -10469, 1583.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_D_KITCHEN"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_d_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-18801.5, -8542, 1554.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_D_TOY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_d_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-23269.5, 3480.5, 1276.92);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_D_DESK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_d_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (-35071, 11333.5, 996);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_D_STORAGE"] = instancestruct;
  return activityinstances;
}