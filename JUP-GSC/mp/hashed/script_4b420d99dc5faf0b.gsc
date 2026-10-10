/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4b420d99dc5faf0b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_tower_ob_features_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_tower_ob_features_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_tower_ob_features_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_tower_ob_features_cs");

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

  s cs_setup_arrays(us, "mp_jup_tower_ob_features_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_tower_ob_features_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (15784.5, 26282, 1578.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (2247.06, 22868, 2961.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (5258.81, 28265.7, 2286.56), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (2434.28, 22842.3, 1260), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "perk_machine_choice_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (15034.3, 20300.6, 1575), (0, 180, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (15933.9, 17893.6, 1727), (0, 136, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (12212.1, 26592.1, 2398.53), (0, 291.88, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (16122.6, 21340.1, 9276.75), (8.8, 73.87, -8.56));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (16492.1, 23919.6, 9115.06), (8.16, 161.53, 4.28));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (7782.5, 25315.1, 1876.15), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (8315.2, 23006.5, 2554.93), (0, 201, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  fe[[f]](s, us, cf, (7523.9, 26104, 2285.09), (0, 0, 0), "ob_floater_powerup", undefined, "insta_kill");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (13231, 26578, 2267.06), (0, 269.03, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (12131.1, 26554.6, 2392.53), (0, 291.88, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (6756.64, 25436.9, 2684.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_tower_ob_features_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (11690.3, 24065.7, 1544), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_tower_ob_features_cs");
}