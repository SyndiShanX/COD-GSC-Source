/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_703357e28ba98a55.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_mysteryboxes_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_mysteryboxes_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_mysteryboxes_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_mysteryboxes_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_mysteryboxes_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_mysteryboxes_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-33672, 34440, 1392), (0, 188, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-14853, 36242, 2491), (0, 90, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_mysteryboxes_cs";
  s.content_key = "magicbox_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-22756, 21461, 2020), (0, 90, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_mysteryboxes_cs");
}