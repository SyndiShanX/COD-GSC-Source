/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f273db30ed6be4a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_ambient_mimics_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_ambient_mimics_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_ambient_mimics_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_ambient_mimics_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_ambient_mimics_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_ambient_mimics_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-37199, 43167, 1770), (0, 303.78, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-33175.5, 44566, 1752), (0, 103.77, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-30661, 44771, 2160), (0, 269.32, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-29623.5, 42361, 1695), (0, 64.71, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-22005.5, 40923.5, 2104), (0, 225, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-30171, 31072, 1440), (0, 117.61, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-31005.5, 28309.5, 1380), (0, 29.04, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-34091, 31715, 1536), (0, 206.52, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-22813, 17813.5, 1928), (0, 181.09, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-22891, 19872, 1664), (0, 222.84, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-19213.5, 39837.5, 2183.5), (0, 74.48, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-31458.5, 41217.5, 1636), (0, 244.31, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-32687.5, 39135, 1485.16), (0, 63.96, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-23062, 36408.5, 1965.63), (0, 88.98, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-23096.5, 23294, 1726.01), (0, 1.28, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-33500.5, 24339.5, 1376), (0, 40.43, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-27751, 16745.5, 1156.52), (0, 164.97, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-19919.5, 39281.5, 2179.38), (0, 253.08, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-33662.5, 28442.5, 1115.67), (0, 263.71, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-34222.5, 34234.5, 1372.19), (0, 147.92, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-22825.5, 40058.5, 2096), (0, 207.1, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-15461.5, 36850.5, 2476.18), (0, 215.13, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-14022.5, 34282, 2664), (0, 180, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-18343, 26865, 3008.03), (0, 9.8, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-25655, 17588, 1504.64), (0, 178.89, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-31050, 34143.5, 1376.12), (0, 117.41, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-24934.5, 38142.5, 1784), (0, 140.08, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-16528.5, 32364.5, 2778.02), (0, 224.44, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-32508.5, 28524, 1344), (0, 296.27, 0), undefined, undefined, "ambient_mimic_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_ambient_mimics_cs");
}