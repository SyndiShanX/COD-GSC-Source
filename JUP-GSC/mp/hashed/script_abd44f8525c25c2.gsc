/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_abd44f8525c25c2.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activities_summon_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activities_summon_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activities_summon_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activities_summon_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activities_summon_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activities_summon_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_summon_cs";
  s.name = "red_console_2";
  fe[[f]](s, us, cf, (12544, 1664, 1629), (0, 307.86, 0), "red_console_2", "summon_console_red_controller", "summon_consoles");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_summon_cs";
  s.name = "red_console_3";
  fe[[f]](s, us, cf, (5703.25, -4828.75, 2824), (0, 225.4, 0), "red_console_3", "summon_console_red_controller", "summon_consoles");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_summon_cs";
  s.name = "red_console_1";
  fe[[f]](s, us, cf, (3567.75, 6613.25, 2144), (0, 131.95, 0), "red_console_1", "summon_console_red_controller", "summon_consoles");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activities_summon_cs");
}