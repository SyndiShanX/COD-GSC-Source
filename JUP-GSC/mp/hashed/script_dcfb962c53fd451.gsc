/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_dcfb962c53fd451.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_puzzles;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_puzzles")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_puzzles");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_puzzles");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_puzzles");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_puzzles");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_obelisk";
  fe[[f]](s, us, cf, (782.05, 5495.34, 2007.35), (0, 269.88, 0), "spatial_fire_obelisk");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_reward";
  fe[[f]](s, us, cf, (977.25, 5500, 2007.35), (0, 182, 0), "spatial_fire_reward");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_runes";
  fe[[f]](s, us, cf, (-1241.27, 1464.37, 2254.5), (0, 90, 0), undefined, undefined, "spatial_fire_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_runes";
  fe[[f]](s, us, cf, (-1590.02, 2711.37, 2302.5), (0, 316, 0), undefined, undefined, "spatial_fire_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_runes";
  fe[[f]](s, us, cf, (-271.02, 1914.88, 2023.5), (0, 180, 0), undefined, undefined, "spatial_fire_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_negotiator";
  fe[[f]](s, us, cf, (877.3, 5616.09, 1624), (0, 271.78, 0), "spatial_fire_negotiator");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_orb";
  fe[[f]](s, us, cf, (1060.75, 4939, 1869.5), (0, 90, 0), "spatial_fire_orb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_obelisk";
  fe[[f]](s, us, cf, (7306.7, -2285.71, 2616), (0, 224.14, 0), "spatial_toxic_obelisk");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_reward";
  fe[[f]](s, us, cf, (7584.61, -2474.8, 2616), (0, 134.14, 0), "spatial_toxic_reward");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_runes";
  fe[[f]](s, us, cf, (9465.92, -3767.65, 2431), (0, 141.58, 0), undefined, undefined, "spatial_toxic_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_runes";
  fe[[f]](s, us, cf, (9506.85, -1933.58, 2335), (0, 180.28, 0), undefined, undefined, "spatial_toxic_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_runes";
  fe[[f]](s, us, cf, (8306.45, -2936.93, 2565.5), (0, 44.76, 0), undefined, undefined, "spatial_toxic_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_negotiator";
  fe[[f]](s, us, cf, (7607.95, -2483.71, 2616), (0, 135.83, 0), "spatial_toxic_negotiator");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_orb";
  fe[[f]](s, us, cf, (7983.57, -2271.16, 2474.75), (0, 224.14, 0), "spatial_toxic_orb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_obelisk";
  fe[[f]](s, us, cf, (7572.49, 1100.94, 2357), (0, 270, 0), "spatial_ice_obelisk");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_reward";
  fe[[f]](s, us, cf, (7594.5, 885.25, 2357), (0, 90, 0), "spatial_ice_reward");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_runes";
  fe[[f]](s, us, cf, (6637.28, 66.54, 2236.75), (0, 223.04, 0), undefined, undefined, "spatial_ice_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_runes";
  fe[[f]](s, us, cf, (5479.98, -1647.63, 2435.25), (0, 45.2, 0), undefined, undefined, "spatial_ice_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_runes";
  fe[[f]](s, us, cf, (6655.58, -1720.3, 2285.25), (0, 135.08, 0), undefined, undefined, "spatial_ice_runes");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_negotiator";
  fe[[f]](s, us, cf, (7111.99, 1121.19, 2371.25), (0, 0.75, 0), "spatial_ice_negotiator");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_orb";
  fe[[f]](s, us, cf, (7699.77, 496.76, 2244.75), (0, 90, 0), "spatial_ice_orb");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_fire_InitStandSpot";
  fe[[f]](s, us, cf, (-818.75, 1862, 2034.75), (0, 90, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_ice_InitStandSpot";
  fe[[f]](s, us, cf, (6478.48, -1170.98, 2008), (0, 11.85, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_puzzles";
  s.name = "spatial_toxic_InitStandSpot";
  fe[[f]](s, us, cf, (9142.95, -2902.43, 2392), (0, 224.14, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_puzzles");
}