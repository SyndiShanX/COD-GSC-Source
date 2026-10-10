/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_723f6e47953a77ac.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_wallbuys_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_wallbuys_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_wallbuys_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_wallbuys_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_wallbuys_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_wallbuys_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (-6470, 10603, 1096), (0, 124, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (-14541, 12415, 1271.96), (0, 63.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (-11542, 4648, 1055), (0, 70.5, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (-3795, 1592, 2008), (0, 195, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (1216, 8061, 1624), (0, 225, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (-4252, -6995, 1417), (0, 225, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (2876, -3837, 2010), (0, 225, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (8186, 3137, 1624), (0, 45, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (15534, 6757, 1971), (0, 148.47, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (11751, -331, 1712), (0, 33.67, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_wallbuys_cs");
}