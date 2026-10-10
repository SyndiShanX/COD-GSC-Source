/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2b15a0bac31ce30.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_activities_servershutdown_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_activities_servershutdown_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_activities_servershutdown_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_activities_servershutdown_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_activities_servershutdown_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_activities_servershutdown_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (26112, -20864, 2880), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (39808, -21120, 2944), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (39168, -25472, 2816), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (27072, -27456, 3008), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (20928, -24064, 2624), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (22720, -27648, 3008), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (20832, -36000, 2944), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (26496, -36224, 2880), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_servershutdown_cs";
  s.height = 4096;
  fe[[f]](s, us, cf, (41216, -29376, 2880), (0, 0, 0), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_activities_servershutdown_cs");
}