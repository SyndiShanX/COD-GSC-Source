/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5861420373326790.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_wallbuys_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_wallbuys_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_wallbuys_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_wallbuys_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_wallbuys_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_wallbuys_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (24075, 20300, 1356), (0, 90, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (27821, 36689, 1184), (0, 180, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (33134, 27977, 1544), (0, 240, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (38522, 28876, 1761), (0, 180, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (39999, 33167, 1764), (0, 10, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (25449, 28626, 1357), (0, 270, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (31260, 38905, 1047), (0, 60.2, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (43490.9, 35040, 2570.84), (0, 14.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (24100, 33572, 1544), (0, 330, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (31066, 31399, 1344), (0, 150, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (26441, 26043, 1352), (0, 163.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (33033, 35185, 1032), (0, 150, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (29374, 25883, 1380), (0, 261.85, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_wallbuys_cs";
  s.content_key = "wallbuy_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (0, 0, 55), (0, 0, 0), undefined, undefined, "random_ob", undefined, undefined, (31652, 22575, 1512), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_wallbuys_cs");
}