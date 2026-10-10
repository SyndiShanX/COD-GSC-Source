/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2878b0fb2a3cab6.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_activities_summon_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_activities_summon_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_activities_summon_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_activities_summon_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_activities_summon_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_activities_summon_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "map_location_2_c";
  fe[[f]](s, us, cf, (-9419.45, -39994.2, 2370.38), (0, 20.09, 4.8), "map_location_2_c", undefined, "map_location_2");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "green_console_5";
  fe[[f]](s, us, cf, (-20290.6, -36248.5, 2901.34), (359.99, 249.58, 0.23), "green_console_5", "summon_console_green_controller", "summon_consoles");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "yellow_console_3";
  fe[[f]](s, us, cf, (-18075.3, -14382.8, 2153.75), (0, 306.45, 0), "yellow_console_3", "summon_console_yellow_controller", "summon_consoles");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "map_location_1_c";
  fe[[f]](s, us, cf, (-9418.86, -39994, 2399.67), (0, 20.1, -3.2), "map_location_1_c", undefined, "map_location_1");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "map_location_3_c";
  fe[[f]](s, us, cf, (-9451.38, -39906.9, 2370.05), (0, 20.1, 2.1), "map_location_3_c", undefined, "map_location_3");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "map_location_4_c";
  fe[[f]](s, us, cf, (-9451.23, -39905.9, 2397.26), (0, 20.1, 5.9), "map_location_4_c", undefined, "map_location_4");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "green_map_pin_4_c";
  fe[[f]](s, us, cf, (-9440.5, -39936.3, 2367.31), (1.4, 21.1, 0.02), undefined, undefined, "green_map_pin_4");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "red_map_pin_2_c";
  fe[[f]](s, us, cf, (-9437.83, -39943.8, 2385.82), (1.4, 21.1, 0.02), undefined, undefined, "red_map_pin_2");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "red_map_pin_3_c";
  fe[[f]](s, us, cf, (-9436.57, -39947.3, 2382.25), (1.4, 21.1, 0.02), undefined, undefined, "red_map_pin_3");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "green_map_pin_1_c";
  fe[[f]](s, us, cf, (-9430.96, -39962.7, 2406.1), (1.4, 21.1, 0.02), undefined, undefined, "green_map_pin_1");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "green_map_pin_5_c";
  fe[[f]](s, us, cf, (-9431.56, -39960.6, 2365.61), (359.3, 21.1, 0.02), undefined, undefined, "green_map_pin_5");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "red_map_pin_1_c";
  fe[[f]](s, us, cf, (-9435.78, -39948.9, 2388.21), (1.4, 21.1, 0.02), undefined, undefined, "red_map_pin_1");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "green_map_pin_2_c";
  fe[[f]](s, us, cf, (-9442.91, -39929.7, 2402.19), (1.4, 21.1, 0.02), undefined, undefined, "green_map_pin_2");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "yellow_map_pin_1_c";
  fe[[f]](s, us, cf, (-9436.56, -39947.7, 2396.49), (1.4, 21.1, 0.02), undefined, undefined, "yellow_map_pin_1");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "yellow_map_pin_2_c";
  fe[[f]](s, us, cf, (-9436.1, -39948.1, 2372.76), (1.4, 21.1, 0.02), undefined, undefined, "yellow_map_pin_2");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "green_map_pin_3_c";
  fe[[f]](s, us, cf, (-9442.44, -39931, 2384.09), (0.7, 21.1, 0.02), undefined, undefined, "green_map_pin_3");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "yellow_map_pin_3_c";
  fe[[f]](s, us, cf, (-9432.13, -39959, 2377.56), (1.4, 21.1, 0.02), undefined, undefined, "yellow_map_pin_3");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "yellow_map_pin_4_c";
  fe[[f]](s, us, cf, (-9430.61, -39963.1, 2387.3), (1.4, 21.1, 0.02), undefined, undefined, "yellow_map_pin_4");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "refractor";
  fe[[f]](s, us, cf, (-23457.5, -10480.4, 1503.68), (0, 329.4, 0), undefined, "refractor_controller", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "ammo_crate";
  fe[[f]](s, us, cf, (-22820.5, -11152.6, 1504.76), (0, 269.4, 0), undefined, "refractor_controller", "ammo_crate", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "ammo_crate";
  fe[[f]](s, us, cf, (-22620.3, -8353.47, 1504.79), (0, 90, 0), undefined, "refractor_controller", "ammo_crate", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "refractor";
  fe[[f]](s, us, cf, (-22261.9, -10572.2, 1503.68), (0, 34.4, 0), undefined, "refractor_controller", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "refractor";
  fe[[f]](s, us, cf, (-23424.8, -9178.91, 1503.68), (0, 227.7, 0), undefined, "refractor_controller", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "refractor";
  fe[[f]](s, us, cf, (-22000.1, -9022.23, 1503.68), (0, 150.9, 0), undefined, "refractor_controller", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "refractor_controller";
  fe[[f]](s, us, cf, (-22665.3, -9848.52, 1510.34), (0, 0, 0), "refractor_controller", undefined, "refractor_set", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "worm_arena";
  fe[[f]](s, us, cf, (-23851.8, -9812.78, 1504.99), (0, 0, 0), undefined, "worm_arena_b", "deathworm_arena", undefined, undefined, (0, 0, 0), (0, 0, 0), 1200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "worm_arena";
  fe[[f]](s, us, cf, (-21591.1, -9811.78, 1504.99), (0, 0, 0), "worm_arena_b", undefined, "deathworm_arena", undefined, undefined, (0, 0, 0), (0, 0, 0), 1200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "worm_arena";
  fe[[f]](s, us, cf, (-22703.8, -10326.5, 1504.99), (0, 0, 0), undefined, "worm_arena_b", "deathworm_arena", undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_summon_cs";
  s.name = "worm_arena";
  fe[[f]](s, us, cf, (-22702.8, -9330.82, 1504.99), (0, 0, 0), undefined, "worm_arena_b", "deathworm_arena", undefined, undefined, (0, 0, 0), (0, 0, 0), 750);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_activities_summon_cs");
}