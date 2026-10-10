/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2afa9ba5690e2eef.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_essence_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_essence_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_essence_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_essence_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_essence_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_essence_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-6354, 35479, 1691), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-1595, 37666, 2824), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (7933, 36085, 2210), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (3317, 32268, 1569), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (13585, 32250, 1484), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (8393, 29112, 1544), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (7445, 23442, 1391), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (5024, 17865, 1416), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-205, 24429, 1271), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-5354, 22949, 1469), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-2564, 29229, 1335), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-8630, 28234, 1326), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-13886, 34289, 2837), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_essence_cs");
}