/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_10d3f89e8b5a8742.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (30474, 33213, 1303.5), (0, 276.75, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (30725.5, 31899, 1360), (0, 237.08, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (31523.5, 40951, 928), (0, 232.58, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (30318.5, 41205.5, 1192), (0, 153.17, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (32252, 40432.5, 942), (0, 25.89, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (32247, 40425.5, 937), (0, 34.51, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (31043.5, 34515, 1192), (0, 150.94, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (31045.5, 34518, 1192), (0, 151.27, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (32181.5, 39886.5, 1181), (0, 66.28, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (34264.5, 36178, 1080), (0, 140.85, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (34264.5, 36178, 1080), (0, 143.23, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (32056, 37070, 1088.5), (0, 66.28, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (37878, 30530.5, 1764), (0, 182.11, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (37878, 30530.5, 1764), (0, 182.4, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (42775.5, 34244.5, 2576), (0, 272.36, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (30725.5, 31899, 1360), (0, 241.55, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (43945.5, 32954, 2708), (0, 233.88, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (42347, 33240.5, 2577), (0, 58.95, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (38748, 28448.5, 1785), (0, 88.86, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (38745, 28446.5, 1787), (0, 92.29, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (28970.5, 33604, 1344), (0, 329.63, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (28970.5, 33604, 1344), (0, 331.19, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (33323.5, 27941, 1896), (0, 56.7, 0), "bigbounty_spawn", "C_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (33372.5, 27907.5, 1896), (0, 55.62, 0), "bigbounty_spawn", "C_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (27693, 35581.5, 1184), (0, 358.2, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (36839.5, 31745.5, 1772), (0, 333.18, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (31766.5, 33878, 1224), (0, 31.87, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (23969, 33939, 1546.5), (0, 258.68, 0), "bigbounty_spawn", "C_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (30126.5, 36473, 1100.5), (0, 247.92, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (29649, 31536, 1344), (0, 236.46, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (26549, 33346, 1350.5), (0, 331.48, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (32652.5, 30915.5, 1349), (0, 150.37, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (36012.5, 27958, 1692), (0, 150.37, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (39306.5, 27105.5, 1779), (0, 175.63, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (41343, 29734, 1762), (0, 230.01, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (29120, 30586, 1256), (0, 241.18, 0), "bigbounty_spawn", "C_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (21164, 21780.5, 1646), (0, 242.63, 0), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (24030, 27540, 1368), (0, 274.91, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (26610.5, 20692, 1352), (0, 89.7, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (22532.5, 26648, 1361.5), (0, 343.14, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (22532.5, 26648, 1361.5), (0, 343.14, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (24030, 27540, 1368), (0, 239.04, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (23550.5, 26399.5, 1360), (0, 206.62, 0), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (28616.5, 21671, 1351.5), (0, 182.23, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (28616.5, 21671, 1351.5), (0, 178.92, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (28500, 26447.5, 1399.5), (0, 238.98, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (28500, 26447.5, 1399.5), (0, 239.17, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (27916, 27194, 1363), (0, 261.19, 0), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (24713.5, 23341.5, 1389), (0, 87.16, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (24713.5, 23341.5, 1389), (0, 85.71, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (25088, 24775, 1668), (0, 211.27, 0), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (27948.5, 23318, 1424), (0, 167.7, 0), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (27853.5, 23954.5, 1428), (0, 173.89, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (27853.5, 23954.5, 1428), (0, 181.05, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (31883.5, 23514.5, 1560), (0, 287.9, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (31883.5, 23514.5, 1561), (0, 286.45, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (31035.5, 22696.5, 1832), (359.99, 41.17, -0.65), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (25077.5, 20476.5, 1362.5), (0.64, 121.31, -0.12), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (22883, 21136, 1352), (0, 293.51, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (22883, 21136, 1352), (0, 88.35, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (28723, 21045.5, 1351), (359.35, 312.48, -0.02), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (25159.5, 21645.5, 1380), (0, 355.85, 0), "bigbounty_spawn", "C_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (25171.5, 21644.5, 1380), (0, 357.14, 0), "bigbounty_spawn", "C_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (28148, 18055, 1355.5), (0, 26.14, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (26611, 22898, 1350.5), (0, 89.06, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (23086.5, 22368.5, 1356), (0, 181.53, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (26614, 25537.5, 1354), (0, 181.53, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (24113.5, 27969, 1368), (0, 281.7, 0), "bigbounty_spawn", "C_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (24877.5, 27213.5, 1358), (0, 82.29, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (28123.5, 28832, 1322), (0, 236.74, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (28962, 25931.5, 1385.5), (0, 257.86, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (22532, 28612.5, 1358), (0, 314.02, 0), "bigbounty_spawn", "C_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_bigbounty_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_BIGBOUNTY";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_bigbounty";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_c_ob_activities_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_4c7659274c466ba7":
      function_8cd799132e0d5d08(fe, us, cf);
      break;
    case #"hash_7be0196303eaf1da":
      function_89a763120bd2d7(fe, us, cf);
      break;
    case #"hash_662265b9066b58fe":
      function_30dfab0d592ee8d3(fe, us, cf);
      break;
    case #"hash_c86d8631b810093":
      function_eced6c05f659966(fe, us, cf);
      break;
  }
}

function function_8cd799132e0d5d08(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_C_NORTH_TABLE", "BIGBOUNTY_C_NORTH_TABLE", undefined, undefined, (29906.5, 39658.5, 1152.5), (0, 187.46, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_C_NORTH_TABLE", "C_NORTH", undefined, undefined, (29906.5, 39658.5, 1152.5), (0, 187.46, 0));
}

function function_89a763120bd2d7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_C_NORTH_SERVER", "BIGBOUNTY_C_NORTH_SERVER", undefined, undefined, (36767, 31556.5, 1805), (0, 258.64, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_C_NORTH_SERVER", "C_NORTH", undefined, undefined, (36767, 31556.5, 1805), (0, 258.64, 0));
}

function function_30dfab0d592ee8d3(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_C_SOUTH_DESK", "BIGBOUNTY_C_SOUTH_DESK", undefined, undefined, (22763, 27863, 1393), (0, 7.88, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_C_SOUTH_DESK", "C_SOUTH", undefined, undefined, (22763, 27863, 1393), (0, 7.88, 0));
}

function function_eced6c05f659966(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_C_SOUTH_JAIL", "BIGBOUNTY_C_SOUTH_JAIL", undefined, undefined, (27702, 23099.5, 1467), (0, 107.24, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_C_SOUTH_JAIL", "C_SOUTH", undefined, undefined, (27702, 23099.5, 1467), (0, 107.24, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_c_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (29906.5, 39658.5, 1152.5);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(29906.5, 39658.5, 1152.5)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 187.46, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_C_NORTH_TABLE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_c_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (36767, 31556.5, 1805);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(36767, 31556.5, 1805)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 258.64, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_C_NORTH_SERVER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_c_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (22763, 27863, 1393);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(22763, 27863, 1393)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 7.88, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_C_SOUTH_DESK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_c_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (27702, 23099.5, 1467);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(27702, 23099.5, 1467)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 107.24, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_C_SOUTH_JAIL"] = instancestruct;
  return activityinstances;
}