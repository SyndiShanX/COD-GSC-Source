/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_65dd0b052916545e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_ambient_mimics_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_ambient_mimics_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_ambient_mimics_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_ambient_mimics_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_ambient_mimics_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_ambient_mimics_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-13576.5, -19691, 1952), (0, 44.56, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-13686, -34088, 1907.64), (0, 19.09, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-6498.5, -19106, 1696.97), (0, 141.59, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-12953, -36699.5, 1909.17), (0, 19.14, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-8998.5, -11296.5, 1715), (0, 227.86, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-4874.5, -31093.5, 1749.63), (0, 150.18, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-18918.5, -36322, 2629.5), (0, 81.42, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-2663, -21447.5, 1696.97), (0, 297.05, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-6612.5, -17723.5, 1696.97), (0, 23.45, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-16804.5, -28535, 4424.91), (0, 86.14, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-8561, -40372.5, 2293.5), (0, 109.54, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-5872, -27252.5, 1719.97), (0, 346.94, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-23523, -31944.5, 1952.5), (0, 76.81, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-3091, -17167.5, 1708.98), (0, 225.28, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-15709.5, -8199, 1508), (0, 178.32, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-17273, -21034, 4424.91), (0, 314.81, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-5299.5, -18867, 1696.97), (0, 52.85, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-7178.5, -12073.5, 1720), (0, 300.82, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-11201, -41444.5, 2517.5), (0, 19.51, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-20904.5, -27040, 1735.97), (0, 61.28, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-13867.5, -9381, 1712.9), (0, 348, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-16220.5, -24752, 1736), (0, 63.76, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-8991.5, -38372, 2295.5), (0, 19.89, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-18413, -30002, 1853.84), (0, 148.3, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (907, -15024, 1707.81), (0, 270.31, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-8341, -20335, 1712), (0, 141.19, 0), undefined, undefined, "ambient_mimic_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_ambient_mimics_cs");
}