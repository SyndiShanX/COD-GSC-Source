/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6b6dc597273d9061.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_mysteryboxes_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_mysteryboxes_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_mysteryboxes_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_mysteryboxes_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_mysteryboxes_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_mysteryboxes_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-19609, 9299, 1993), (0, 64.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-25593, 5350, 1047), (0, 194.3, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-31559, 9961, 976), (0, 9.99, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-21217, -1558, 1019), (0, 271.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-24754, -9920, 1520), (0, 270.9, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_mysteryboxes_cs");
}