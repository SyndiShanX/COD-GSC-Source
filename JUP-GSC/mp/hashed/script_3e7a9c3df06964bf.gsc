/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e7a9c3df06964bf.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_essence_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_essence_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_essence_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_essence_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_essence_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_essence_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-27440, 22416, 1608), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-14362, 36634, 2906), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-24928, 37616, 2271), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-29392, 31776, 1492), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-29344, 42496, 2120), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-25139, 29133, 1841), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-22016, 20928, 2064), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-17222.9, 25956.3, 3285), (0, 190, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-34362, 25912, 1548), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-18842, 31808, 2467), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-34456, 31775, 1689), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-36287, 42888, 2367), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_essence_cs");
}