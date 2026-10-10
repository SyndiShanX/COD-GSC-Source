/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_fc3b3ba6dd4e0ce.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_summon_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_summon_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_summon_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_summon_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_summon_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_summon_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "map_location_2_a";
  fe[[f]](s, us, cf, (33588.3, 27607.2, 1805.18), (0.08, 60.39, -0.09), "map_location_2_a", "map_controller", "map_location_2");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "map_controller";
  fe[[f]](s, us, cf, (33547.7, 27629.2, 1779.84), (0, 62, 0), "map_controller");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "map_location_1_a";
  fe[[f]](s, us, cf, (33587.9, 27606, 1832.85), (0.01, 60.7, -4.8), "map_location_1_a", "map_controller", "map_location_1");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "map_location_3_a";
  fe[[f]](s, us, cf, (33505.4, 27653.7, 1807.94), (0.19, 59.01, 7), "map_location_3_a", "map_controller", "map_location_3");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "map_location_4_a";
  fe[[f]](s, us, cf, (33506.8, 27653.3, 1834.99), (359.98, 59.4, -1), "map_location_4_a", "map_controller", "map_location_4");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "red_map_pin_2_a";
  fe[[f]](s, us, cf, (33541.1, 27633, 1821.81), (1.5, 62.1, 0.06), undefined, undefined, "red_map_pin_2");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "yellow_map_pin_1_a";
  fe[[f]](s, us, cf, (33544.3, 27631.1, 1832.48), (0, 62, 0), undefined, undefined, "yellow_map_pin_1");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "red_map_pin_3_a";
  fe[[f]](s, us, cf, (33544.1, 27631.3, 1818.27), (0, 62, 0), undefined, undefined, "red_map_pin_3");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "green_map_pin_2_a";
  fe[[f]](s, us, cf, (33527.7, 27640.7, 1837.78), (0, 60.7, 0), undefined, undefined, "green_map_pin_2");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "green_map_pin_3_a";
  fe[[f]](s, us, cf, (33529.1, 27640, 1819.98), (0, 62, 0), undefined, undefined, "green_map_pin_3");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "green_map_pin_4_a";
  fe[[f]](s, us, cf, (33533.6, 27637.4, 1802.98), (0, 62, 0), undefined, undefined, "green_map_pin_4");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "green_console_2";
  fe[[f]](s, us, cf, (41943, 33108, 2460), (0, 195.6, 0), "green_console_2", "summon_console_green_controller", "summon_consoles");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "green_map_pin_1_a";
  fe[[f]](s, us, cf, (33558.1, 27623.1, 1842.19), (0.6, 60.9, -0), undefined, undefined, "green_map_pin_1");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "yellow_map_pin_2_a";
  fe[[f]](s, us, cf, (33544.8, 27630.8, 1808.71), (0, 59.9, 0), undefined, undefined, "yellow_map_pin_2");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "green_map_pin_5_a";
  fe[[f]](s, us, cf, (33556.2, 27624.2, 1801.43), (0, 62, 0), undefined, undefined, "green_map_pin_5");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "yellow_map_pin_3_a";
  fe[[f]](s, us, cf, (33554.8, 27625, 1813.65), (0, 62, 0), undefined, undefined, "yellow_map_pin_3");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "yellow_map_pin_4_a";
  fe[[f]](s, us, cf, (33558.4, 27622.9, 1823.32), (0, 60.3, 0), undefined, undefined, "yellow_map_pin_4");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_summon_cs";
  s.name = "red_map_pin_1_a";
  fe[[f]](s, us, cf, (33545.3, 27630.5, 1824.22), (0.9, 62, -0), undefined, undefined, "red_map_pin_1");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_summon_cs");
}