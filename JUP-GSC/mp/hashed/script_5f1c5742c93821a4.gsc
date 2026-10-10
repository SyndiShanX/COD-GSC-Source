/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5f1c5742c93821a4.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_activities_servershutdown_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_activities_servershutdown_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_activities_servershutdown_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_activities_servershutdown_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_activities_servershutdown_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_activities_servershutdown_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-29504, -19456, 1280), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-29696, -28864, 1280), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-23872, -36608, 2432), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-20224, -32256, 1792), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (-22720, -9792, 1280), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_activities_servershutdown_cs");
}