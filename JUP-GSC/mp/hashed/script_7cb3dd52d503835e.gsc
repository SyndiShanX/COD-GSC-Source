/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7cb3dd52d503835e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_activities_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_activities_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_activities_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_activities_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_activities_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_activities_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-31093, 42102, 1533), (1.94, 284.42, 0.5), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-17140.3, 26294.8, 2966.5), (358.17, 113.89, -0.81), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-35969.5, 43360.5, 1765.5), (2.89, 313.71, 2.76), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-35969.5, 43360.5, 1765.5), (1.42, 314.69, 1.41), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-38014.5, 42887.5, 1737.5), (1.66, 303.63, 1.11), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-22597, 41075, 2104), (359.05, 28.39, 1.76), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-14420, 36861, 2480), (359.69, 171.11, -1.98), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-16627.5, 27466.5, 3065), (0.12, 183.37, -1.99), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-23067, 17772, 1656), (1.57, 308.22, 1.24), "bigbounty_spawn", "A", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-29120, 22170, 1554), (358.56, 133.82, -1.38), "bigbounty_spawn", "A", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-30718, 27612.5, 1386), (358.25, 119.13, -0.97), "bigbounty_spawn", "A", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-32138, 35286.5, 1387.5), (358.18, 65.3, 0.83), "bigbounty_spawn", "A", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-28975, 31488, 1442), (0.81, 335.99, 1.83), "bigbounty_spawn", "A", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-25525, 42252, 1890), (1.87, 249.38, -0.7), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-25522, 42243, 1893), (4.08, 247.93, -0.58), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-15873.5, 34247, 2704), (359.92, 177.75, -2), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-15877.5, 34245, 2704), (2.01, 180.08, -3.99), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-16627.5, 27466.5, 3065), (3.12, 180.72, -3.91), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-15556.5, 26316.5, 3064.25), (0.29, 188.45, -1.98), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-22265.5, 21239.5, 1736), (1.73, 321.12, 3.74), "bigbounty_spawn", "A", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-22265.5, 21239.5, 1736), (0.6, 317.94, 2.15), "bigbounty_spawn", "A", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-30397.5, 23252, 1272.5), (358.24, 25.29, 1.38), "bigbounty_spawn", "A", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-30397.5, 23252, 1271.5), (357.34, 26.17, 3.15), "bigbounty_spawn", "A", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-29500.5, 31825, 1424), (357.34, 26.17, 3.15), "bigbounty_spawn", "A", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-29503.5, 31824, 1424), (357.34, 25.31, 0.95), "bigbounty_spawn", "A", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-34356.5, 35604.5, 1372), (355.98, 88.73, -0.91), "bigbounty_spawn", "A", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-34356.5, 35604.5, 1373), (357.81, 86.23, -2.86), "bigbounty_spawn", "A", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-24926.5, 33912.5, 1440), (359.45, 114.85, -3.56), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-24926.5, 33896.5, 1439), (355.96, 88.8, -1.91), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-34016, 39464.5, 1482), (0.58, 343.24, 1.91), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-25936, 38908, 1564.5), (1.67, 236.76, -1.09), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-18232.5, 38159.5, 2154), (359.39, 162.09, -1.9), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-15556.5, 26316.5, 3064.25), (2.54, 187.04, -3.68), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-26696, 20922.5, 1522.5), (358.41, 52.57, 1.21), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-22891, 31699, 1878), (1.93, 255.28, -0.51), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-28026.5, 18250, 1244.5), (358.23, 62.17, 0.93), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-27785, 45380, 1880.5), (0.61, 342.09, 1.9), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-35725.5, 44070, 1908), (1.86, 291.71, 0.74), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-27669.5, 43925, 2048), (358.49, 49.09, 1.31), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-18926.5, 37427.5, 2099), (359.79, 173.88, -1.99), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-14511, 36232, 2480), (359.79, 173.88, -1.99), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-18012, 39869, 2183.5), (1.48, 227.71, -1.34), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-32374.5, 39599, 1497), (1.42, 314.63, 1.4), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-31662.5, 45920, 1744.5), (359.9, 2.7, 2), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-23372, 43086.5, 2040), (1.19, 323.48, 1.61), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-33893, 42666, 1570), (1.92, 286, 0.55), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-23033, 37983.5, 1892.5), (359.96, 178.92, -2), "bigbounty_spawn", "A1", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-32429, 44833, 1737.5), (1.99, 274.38, 0.15), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-32429, 44833, 1736.5), (3.88, 273.16, 2.21), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-28744, 40733.5, 1551), (1.77, 242.54, -0.92), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-28744, 40733.5, 1550), (4.89, 244.89, 1.01), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-18649, 39910, 2183.5), (1.92, 253.86, -0.55), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-18649, 39910, 2183.5), (5.08, 251.19, 2.49), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-15442.5, 36772.5, 2476), (1.99, 266.82, -0.11), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-15442.5, 36772.5, 2476), (3.95, 270.69, 5.04), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-33541, 30697, 1400), (358, 91.14, -0.04), "bigbounty_spawn", "A", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-20432, 37825.5, 2091), (358.62, 115.22, -1.76), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-20432, 37825.5, 2091), (358.51, 111.89, -7.05), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-20798.5, 21618, 1896), (1.35, 222.59, -1.47), "bigbounty_spawn", "A", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-14877.3, 27534.3, 3064), (358.12, 109.44, -0.67), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-30070, 25075, 1273), (359.1, 26.65, 1.78), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-25915.5, 28912.5, 1408.5), (1.99, 272.19, 0.08), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-21655.5, 20672.5, 1721), (358, 90.1, -0), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-36908, 36149, 1258), (1.55, 309.01, 1.26), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-30353, 37938.5, 1557), (359.7, 171.38, -1.97), "bigbounty_spawn", "A", "megabomb");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-15991.8, 27367.8, 3199), (358.89, 33.72, 1.66), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-15482.3, 29275.8, 3062.25), (1.99, 265.36, -0.16), "bigbounty_spawn", "A1", "mimic");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-18178.8, 28834.5, 3001.75), (0.63, 341.69, 1.9), "bigbounty_spawn", "A1", "mangler");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-18178.8, 28834.5, 3001.75), (359.92, 332.44, 4.47), "bigbounty_spawn", "A1", "disciple");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-17502.3, 25879.5, 3285.5), (1.42, 314.63, 1.4), "bigbounty_spawn", "A1", "mimic");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_activities_bigbounty_cs");
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
    cf = "mp_jup_st_a_ob_activities_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_a5d28e85406c30dc":
      function_25b1e36d60ef2671(fe, us, cf);
      break;
    case #"hash_cbde946de35fac13":
      function_6071556975096fae(fe, us, cf);
      break;
    case #"hash_fbbeca1ba01c083a":
      function_1eedfe3e89d285db(fe, us, cf);
      break;
    case #"hash_677fcc7ec6740852":
      function_c2115d281eb34053(fe, us, cf);
      break;
  }
}

function function_25b1e36d60ef2671(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_A_AUTO", "BIGBOUNTY_A_AUTO", undefined, undefined, (-34944, 41488.5, 1680.5), (0, 230.64, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_A_AUTO", "A1", undefined, undefined, (-34944, 41488.5, 1680.5), (0, 230.64, 0));
}

function function_6071556975096fae(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_A_OFFICE", "BIGBOUNTY_A_OFFICE", undefined, undefined, (-17372, 39296, 2231), (0, 0.51, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_A_OFFICE", "A1", undefined, undefined, (-17372, 39296, 2231), (0, 0.51, 0));
}

function function_1eedfe3e89d285db(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (-10.5, 0, 0), (0, 181.4, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_A_BURGER", "BIGBOUNTY_A_BURGER", undefined, undefined, (-30733.5, 23949, 1319), (0, 310.68, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_A_BURGER", "A", undefined, undefined, (-30733.5, 23949, 1319), (0, 310.68, 0));
}

function function_c2115d281eb34053(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_A_BASE", "BIGBOUNTY_A_BASE", undefined, undefined, (-15369, 29127.8, 3102.75), (0, 296.53, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_A_BASE", "A", undefined, undefined, (-15369, 29127.8, 3102.75), (0, 296.53, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_a_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (-34944, 41488.5, 1680.5);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_A_AUTO"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_a_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (-17372, 39296, 2231);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_A_OFFICE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_a_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (-30733.5, 23949, 1319);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_A_BURGER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_a_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (-1255.5, -87, 0);
  instancestruct.scriptstructoriginoffset = (-15369, 29127.8, 3102.75);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_A_BASE"] = instancestruct;
  return activityinstances;
}