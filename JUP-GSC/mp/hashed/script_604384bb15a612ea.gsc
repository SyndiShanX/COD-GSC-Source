/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_604384bb15a612ea.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_tower_ob_circle_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_tower_ob_circle_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_tower_ob_circle_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_tower_ob_circle_cs");

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

  s cs_setup_arrays(us, "mp_jup_tower_ob_circle_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_tower_ob_circle_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.height = 5000;
  fe[[f]](s, us, cf, (15307.2, 20804.4, 2004.5), (0, 0, 0), "ob_circle_ascend", undefined, undefined, undefined, undefined, undefined, undefined, 3250);
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.name = "exit_portal_ending";
  fe[[f]](s, us, cf, (16631.6, 20948.2, 4070.26), (0, 270, 0), "exit_portal_ending");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  fe[[f]](s, us, cf, (19952.1, 20005.3, 1759.65), (0, 84, 0), "ob_infil_rift_gate");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.height = 5000;
  fe[[f]](s, us, cf, (15307.2, 20804.4, 5064.5), (0, 0, 0), "ob_circle_above", undefined, undefined, undefined, undefined, undefined, undefined, 6500);
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.name = "exit_portal";
  fe[[f]](s, us, cf, (16685.6, 20967.9, 4070.26), (0, 90, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.height = 5000;
  fe[[f]](s, us, cf, (15386.2, 21255.4, 11717.5), (0, 0, 0), "ob_circle_boss", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.name = "exit_portal";
  fe[[f]](s, us, cf, (18178.4, 21430.9, 12160.7), (0, 90, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.name = "exit_portal";
  fe[[f]](s, us, cf, (11348.3, 13489.5, 273), (0, 150, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_circle_cs";
  s.height = 5000;
  fe[[f]](s, us, cf, (15307.2, 21252.4, -49.5), (0, 0, 0), "ob_circle_start", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_tower_ob_circle_cs");
}