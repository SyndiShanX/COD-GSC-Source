/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_20ec388dddf52c04.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_activities_servershutdown_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_activities_servershutdown_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_activities_servershutdown_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_activities_servershutdown_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_activities_servershutdown_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_activities_servershutdown_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (9888, -38448, 2624), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-2368, -36096, 1792), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (10112, -32064, 2240), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (2112, -22080, 1536), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (16993, -37739.5, 2703.97), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (12992, -22016, 1280), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (14592, -25536, 1280), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-7232, -34752, 1472), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-3840, -31744, 1472), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-3136, -18048, 1472), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_activities_servershutdown_cs");
}