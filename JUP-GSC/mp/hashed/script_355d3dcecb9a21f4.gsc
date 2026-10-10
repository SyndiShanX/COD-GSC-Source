/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_355d3dcecb9a21f4.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_ambient_blockers_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_ambient_blockers_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_ambient_blockers_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_ambient_blockers_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_ambient_blockers_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_ambient_blockers_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (23520, -49342, 351.49), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 250);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (24248, -55127, 614.49), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (418, -43266, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (24301, -54697, 411.82), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (9019, -45951, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (21138, -53053, 873), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 250);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (15097, -42978, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 5000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (20900, -44048, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (21988, -57659, 355.92), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (21106, -57794, 440.08), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 350);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (20788, -58590, 440.08), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (18026, -34552, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 5000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (-14362, -48741, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (19517, -58426, 335.46), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 250);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (-11101, -35158, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (19524, -47722, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 250);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (19952, -47674, 414.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 250);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (20443, -47588, 391.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 400);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (21186, -48067, 330.67), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (21156, -48700, 309.67), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 250);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (14062, -57108, 660.37), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (8167, -33206, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (28511, -38778, 398.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (18902, -46315, 491.7), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_ambient_blockers_cs";
  fe[[f]](s, us, cf, (20876, -47751, 277.67), (0, 0, 0), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_ambient_blockers_cs");
}