/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_60659e03a44888ce.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_circle_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_circle_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_circle_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_circle_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_circle_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_circle_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (19368, -55554, 1855), (0, 90, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (16371, -53632, 766), (0, 270, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (18940, -45704, 511), (0, 0, 0), "ob_infil_rift_gate");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (36530, -58880, -255.84), (0, 0, 0), "ob_vista_worm");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (33982, -51942, -255.84), (0, 0, 0), "ob_vista_worm");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (35814, -63894, -255.84), (0, 0, 0), "ob_vista_worm");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (10906, -72138, -255.84), (0, 0, 0), "ob_vista_worm");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (3418, -64268, -255.84), (0, 0, 0), "ob_vista_worm");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (-202, -55748, -255.84), (0, 0, 0), "ob_vista_worm");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (19544, -67256, -255.84), (0, 0, 0), "ob_vista_worm");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_circle_cs";
  fe[[f]](s, us, cf, (17024, -53584, 928), (0, 0, 0), "ob_circle_start", undefined, undefined, undefined, undefined, undefined, undefined, 10000);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_circle_cs");
}