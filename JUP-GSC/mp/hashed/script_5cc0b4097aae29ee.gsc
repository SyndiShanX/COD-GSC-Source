/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5cc0b4097aae29ee.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_activities_bigbounty_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_activities_bigbounty_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_activities_bigbounty_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_activities_bigbounty_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_activities_bigbounty_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_activities_bigbounty_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (949.5, 21785.5, 998.5), (0, 0, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (9238.5, 23376.5, 1002), (0, 198.66, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (4580.5, 21349.5, 898.5), (0, 69.97, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (4576.5, 21340.5, 898.5), (0, 69.97, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-7579, 29733, 1081.5), (0, 280.77, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (9238.5, 23376.5, 1002), (0, 233.18, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (8832.5, 21590.5, 1002), (0, 126.09, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (8832.5, 21590.5, 1002), (0, 125.39, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (4476, 27679.5, 997.5), (0, 275.25, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (4475, 27683.5, 997.5), (0, 262.25, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-2453.5, 25781, 1134), (0, 341.61, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-2449.5, 25788, 1134), (0, 340.37, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (1462.5, 22884.5, 999), (0, 257.78, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (1467, 22885, 1003), (0, 263.67, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-6404, 25672.5, 1003), (0, 67.21, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-6409.5, 25662, 1002), (0, 69.97, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-6406, 25661.5, 1004), (0, 69.97, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-8873, 29956.5, 1197.5), (0, 69.97, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-8868, 29945.5, 1197.5), (0, 83.22, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-610.5, 21149, 999.5), (0, 64.88, 0), "bigbounty_spawn", "B_SOUTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-613.5, 21146, 999.5), (0, 70.03, 0), "bigbounty_spawn", "B_SOUTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (8863, 25760, 1007), (0, 264.77, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (1345, 19085.5, 1000), (0, 170.19, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-9571.5, 23832, 1187.5), (0, 315.61, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-9610.5, 33143.5, 1546.5), (0, 2.32, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-2306.5, 31496.5, 1175), (0, 337.08, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (2549.5, 30027, 1025.5), (0, 329.47, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-5061.5, 21921.5, 1000), (0, 67.21, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-9875, 31094.5, 1229), (0, 339.22, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-8021.5, 31031.5, 1182), (0, 346.58, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (602.5, 29527.5, 1010.5), (0, 227.71, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-870, 22462, 1033), (0, 0, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (7079, 25246, 1024), (0, 68.4, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (11158.5, 21014, 1019), (0, 285.17, 0), "bigbounty_spawn", "B_SOUTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (7140.5, 18506.5, 1124), (0, 29.7, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-5627, 32227.5, 1377), (0, 349.08, 0), "bigbounty_spawn", "B_SOUTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (13248, 30910.5, 1008), (0, 208.36, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (13249, 30912.5, 1008), (0, 208.36, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (10355, 31309, 1211), (0, 30.7, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (13249, 30912.5, 1008), (0, 208.36, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-9718.5, 32745.5, 1551), (0, 0, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (10244, 28011, 1096), (0, 61.02, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (10253, 28006, 1096), (0, 54.23, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (12485.5, 27491.5, 1009), (0, 113.96, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (11536.5, 36065.5, 1313), (0, 272.32, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (11536.5, 36069.5, 1314), (0, 269.89, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (11137, 35939, 1377), (0, 105.86, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (6677.5, 32997, 1216), (0, 158.84, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (6276.5, 33697, 1227), (0, 157.86, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (6283.5, 33696, 1227), (0, 158.71, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (4193, 39234, 1404), (0, 271.77, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (4198, 39250.5, 1404), (0, 257.31, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (3905.5, 38509.5, 1404), (0, 191.84, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (455.5, 32888, 1242), (0, 230.73, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (284, 36835, 1528), (0, 184.23, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-999.5, 36960, 1320), (0, 4.33, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-999.5, 36960, 1320), (0, 3.95, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mimic_spawn";
  fe[[f]](s, us, cf, (-7512.5, 37722.5, 1497), (0, 183.18, 0), "bigbounty_spawn", "B_NORTH", "mimic", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-7538.5, 37438, 1353), (0, 267.07, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-7547.5, 37438, 1353), (0, 266.99, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-2318.5, 33074, 1496), (0, 356.72, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-2347.5, 33083, 1499), (0, 0.92, 0), "bigbounty_spawn", "B_NORTH", "mangler", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "mangler_spawn";
  fe[[f]](s, us, cf, (-4552.5, 36949, 1544), (0, 305.6, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "disciple_spawn";
  fe[[f]](s, us, cf, (-4554.5, 36957, 1544), (0, 336.4, 0), "bigbounty_spawn", "B_NORTH", "disciple", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-7063.5, 32454, 1455.5), (0, 0, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (3.5, 34245, 1216.5), (0, 264.28, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-2048, 31423, 1160), (0, 345.1, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (-753.5, 31560, 1096.5), (0, 151.87, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (2293.5, 30108, 989.5), (0, 160, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (6073, 29267, 1011), (0, 158.09, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (11394.5, 32813, 1094.5), (0, 282.02, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.groupid = "Spawn";
  s.name = "megabomb_spawn";
  fe[[f]](s, us, cf, (5241, 34591, 1215.5), (0, 266.76, 0), "bigbounty_spawn", "B_NORTH", "megabomb", undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_activities_bigbounty_cs");
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
    cf = "mp_jup_st_b_ob_activities_bigbounty_cs";
  }

  switch (instancename) {
    case #"hash_d764b6db6084d852":
      function_2a479d90bb07c395(fe, us, cf);
      break;
    case #"hash_9d24ecd440e8a82b":
      function_2c50550994d08aa6(fe, us, cf);
      break;
    case #"hash_88307bd4ed047232":
      function_3062176ab3d276a7(fe, us, cf);
      break;
    case #"hash_8e26ffe6c64ede45":
      function_37cc1c7cabe9ec42(fe, us, cf);
      break;
    case #"hash_ef430b025532e3e2":
      function_c5b49e6b17ca3ea9(fe, us, cf);
      break;
  }
}

function function_2a479d90bb07c395(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_B_SOUTH_COUNTER", "BIGBOUNTY_B_SOUTH_COUNTER", undefined, undefined, (7116, 25202.5, 1055), (0, 185.92, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_B_SOUTH_COUNTER", "B_SOUTH", undefined, undefined, (7116, 25202.5, 1055), (0, 185.92, 0));
}

function function_2c50550994d08aa6(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_B_SOUTH_DESK", "BIGBOUNTY_B_SOUTH_DESK", undefined, undefined, (132, 25218.5, 940), (0, 348.94, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_B_SOUTH_DESK", "B_SOUTH", undefined, undefined, (132, 25218.5, 940), (0, 348.94, 0));
}

function function_3062176ab3d276a7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_B_SOUTH_OFFICE", "B_SOUTH", undefined, undefined, (-6749, 25927, 1194), (0, 189.53, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_B_SOUTH_OFFICE", "BIGBOUNTY_B_SOUTH_OFFICE", undefined, undefined, (-6749, 25927, 1194), (0, 189.53, 0));
}

function function_37cc1c7cabe9ec42(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_B_NORTH_BOX", "BIGBOUNTY_B_NORTH_BOX", undefined, undefined, (9173, 33841, 1430), (0, 284.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_B_NORTH_BOX", "B_NORTH", undefined, undefined, (9173, 33841, 1430), (0, 284.71, 0));
}

function function_c5b49e6b17ca3ea9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  s.name = "region";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "bigbounty_region", "BIGBOUNTY_B_NORTH_BENCH", "B_NORTH", undefined, undefined, (14805.5, 33267, 1028.5), (0, 217.82, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_bigbounty_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "activity_nexus_instance_joiner", "BIGBOUNTY_B_NORTH_BENCH", "BIGBOUNTY_B_NORTH_BENCH", undefined, undefined, (14805.5, 33267, 1028.5), (0, 217.82, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_b_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (7116, 25202.5, 1055);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(7116, 25202.5, 1055)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 185.92, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_B_SOUTH_COUNTER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_b_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (132, 25218.5, 940);
  instancestruct.locationorigin = [];
  instancestruct.locationoriginoffset = [];
  instancestruct.var_45283ef87b6e04b6 = [];
  instancestruct.locationradius = [];
  activityinstances["BIGBOUNTY_B_SOUTH_DESK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_b_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (-6749, 25927, 1194);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(-6749, 25927, 1194)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 189.53, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_B_SOUTH_OFFICE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_b_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (9173, 33841, 1430);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(9173, 33841, 1430)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 284.71, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_B_NORTH_BOX"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_bigbounty";
  instancestruct.cf = "mp_jup_st_b_ob_activities_bigbounty_cs";
  instancestruct.scriptstructorigin = (0, 0, 0);
  instancestruct.scriptstructoriginoffset = (14805.5, 33267, 1028.5);
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(14805.5, 33267, 1028.5)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 217.82, 0)];
  instancestruct.locationradius = [1000];
  activityinstances["BIGBOUNTY_B_NORTH_BENCH"] = instancestruct;
  return activityinstances;
}