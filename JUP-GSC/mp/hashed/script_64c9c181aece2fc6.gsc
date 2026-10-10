/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_64c9c181aece2fc6.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_ambient_mimics_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_ambient_mimics_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_ambient_mimics_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_ambient_mimics_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_ambient_mimics_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_ambient_mimics_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (38210.5, 19663, 3349), (0, 111.55, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (26768.5, 33939.5, 1344), (0, 329.8, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (24121, 23501.5, 1350.2), (0, 90.12, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (41907, 34705.5, 2576), (0, 105.26, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (37441, 18655.5, 3342), (0, 126.51, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (26537.5, 35314.5, 1184), (0, 298.36, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (27737, 28919.5, 1349.49), (357.21, 276.19, -0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (27103, 20993.5, 1350.08), (0, 102.83, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (36764.5, 28646, 1764), (0, 276.19, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (32048.5, 39630.5, 1041), (0, 204.46, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_turret";
  s.name = "mimic_spawns_turret";
  s.proplist = "mimicproplist:jup_mimic_prop_list_turrettraps";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (34165.5, 18094.5, 3073.52), (0, 44.93, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (27145, 35296.5, 1184), (0, 358.87, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (31787.5, 22601.5, 1560.5), (0, 89.59, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_safe";
  s.name = "mimic_spawns_safe";
  s.proplist = "mimicproplist:jup_mimic_prop_list_safes";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (39273.5, 32852.5, 1778), (0, 178.73, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (32467.5, 26875.5, 1544), (0, 150.36, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (29802.5, 41407.5, 928), (0, 150.62, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (26244, 20126.5, 1356), (0, 90.65, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_perk";
  s.name = "mimic_spawns_perk";
  s.proplist = "mimicproplist:jup_mimic_prop_list_perkmachines";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (35422, 26306.5, 1544), (0, 150.62, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (30826, 30632, 1362), (0, 329.99, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (32911, 26774.5, 1575), (0, 149.26, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (38986.5, 28383, 1778), (0, 89.58, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (27307.5, 35185.5, 1184), (0, 0.51, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_cache";
  s.name = "mimic_spawns_cache";
  s.proplist = "mimicproplist:jup_mimic_prop_list_caches";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (27755, 23999, 1596), (0, 270.65, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (30109, 33183, 1344), (0, 194.59, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (33610, 36877.5, 1032), (0, 330.49, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_buystation";
  s.name = "mimic_spawns_buystation";
  s.proplist = "mimicproplist:jup_mimic_prop_list_buystations";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (31530.5, 22568.5, 1512), (0, 269.43, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (30473.5, 23582.5, 1438), (0, 179.66, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (23179, 25098, 1351), (0, 358.68, 0), undefined, undefined, "ambient_mimic_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_ambient_mimics_cs";
  s.groupid = "mimic_spawns_ammodepot";
  s.name = "mimic_spawns_ammodepot";
  s.proplist = "mimicproplist:jup_mimic_prop_list_ammodepots";
  s.variantname = "mimic_spawn_point";
  fe[[f]](s, us, cf, (43087.5, 31963, 2576), (0, 15.82, 0), undefined, undefined, "ambient_mimic_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_ambient_mimics_cs");
}