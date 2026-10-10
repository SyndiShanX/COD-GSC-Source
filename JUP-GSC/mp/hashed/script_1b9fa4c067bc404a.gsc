/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1b9fa4c067bc404a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_ambient_mimics_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_ambient_mimics_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_ambient_mimics_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_ambient_mimics_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_ambient_mimics_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_ambient_mimics_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (18850, -2209.5, 2004), (0, 174.94, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-15646.5, 7104, 1271.97), (0, 43.1, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (17820, -7069.5, 1909.92), (0, 314.52, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (21481.5, -4140.5, 2036), (0, 191.22, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-12075, 6542, 1064), (0, 341.08, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (265.5, 3080, 1816), (0, 237.33, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (7386, -3983, 2392), (0, 17.55, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (17993.5, -7512.5, 1919.94), (0, 186.26, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (11607, 1550, 1752), (0, 17.55, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-819.5, -8948.5, 1633.48), (0, 43.01, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (5106, -3358, 2072.5), (0, 135.32, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-3000.5, 5358, 2014.75), (0, 359.95, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (15383.5, 5203.5, 2230.27), (0, 238.97, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (21056, -3599.5, 2277.74), (0, 190.08, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (14659.5, 907, 1744), (0, 303.97, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (8537, -1594, 2208), (0, 315.22, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (2104.5, -365.5, 1816.15), (0, 269.3, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-18031, 4833.5, 1273.01), (0, 359.97, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-6206.5, 10612, 1055), (0, 302.32, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (20504, -2473, 2335.48), (0, 259.13, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (14558, -721.5, 1520), (0, 303.94, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (15107.5, 1864.5, 1766.17), (0, 123.27, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (1865, 4555, 2034), (0, 180.79, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (2160, -8314.5, 2023.25), (0, 338.51, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (15226.5, -13054.5, 1875.5), (0, 303.39, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (18656, -3246.5, 1864), (0, 67.31, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (13386.5, -1004.5, 1720), (0, 303.75, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (9661.5, 168, 2012), (0, 180.55, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (6276, -1588.5, 2008), (0, 44.56, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (3118, 8241, 1444), (0, 44.89, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-11010, 12795.5, 1268.35), (0, 269.68, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-5250, 11515, 1056), (0, 122.55, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (3066, 10537, 1444), (0, 314.41, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (1418, -1108, 1816), (0, 135.84, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (6583, 439.5, 2012), (0, 348.28, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (13167.5, 1007.5, 1626), (0, 123.21, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (14253.5, -4782, 1426.76), (0, 321.87, 0), undefined, undefined, "ambient_mimic_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_ambient_mimics_cs");
}