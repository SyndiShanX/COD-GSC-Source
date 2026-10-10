/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7a52363b125e8646.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_ambient_mimics_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_ambient_mimics_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_ambient_mimics_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_ambient_mimics_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_ambient_mimics_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_ambient_mimics_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-18526.5, -19082, 1654.97), (0, 36.05, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-18611.5, 4370.5, 1270.74), (0, 178.75, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-21301, 2500.5, 1307.64), (0, 319.84, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-27754, 12761.5, 1153.5), (0, 187.79, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-26743.5, -20546, 1709), (0, 348.43, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-31701.5, 13518.5, 955.43), (0, 359.17, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-23439, 263, 1007.17), (0, 194.78, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-27441, -13904.5, 1534.2), (0, 52.01, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-21983.5, -25273.5, 1699), (0, 135.29, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-31158, 3409, 968), (0, 189.87, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-33059.5, 15185.5, 1086.75), (0, 189.61, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-19109, 5203, 1261.98), (0, 90.9, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-24814.5, -1301, 1018), (0, 250.19, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-31194.5, -25972.5, 1568), (0, 161.17, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-32874, 2120.5, 959.98), (0, 99.26, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-27567.5, -6469.5, 1740), (0, 10.99, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-16138.5, -22189.5, 1759.97), (0, 253.21, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-30411.5, -13152.5, 1533.5), (0, 86.87, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-24730.5, -25607.5, 2028), (0, 167.05, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-32752.5, 3146.5, 1105), (0, 189.13, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-32392.5, 11288.5, 960), (0, 189.45, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-25098.5, 4332.5, 1456), (0, 194.1, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-23276, -12776, 1504.99), (0, 359.57, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-12591.5, -8163, 1713), (0, 358.13, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (-34697, 8445, 959.97), (0, 98.57, 0), undefined, undefined, "ambient_mimic_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_ambient_mimics_cs");
}