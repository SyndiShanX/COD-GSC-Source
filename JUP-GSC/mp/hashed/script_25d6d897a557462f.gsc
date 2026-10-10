/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_25d6d897a557462f.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_essence_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_essence_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_essence_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_essence_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_essence_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_essence_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (41841, -26080, 3674), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (30316, -22085, 3418), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (29267, -30924, 4118), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (28714, -35611, 3332), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (34762, -29076, 3107), (0.02, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (38067, -18864, 3293), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (19223, -30624, 3880), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_essence_cs";
  s.content_key = "essence_large_spawn";
  s.name = "essence_container_large";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (22232, -21742, 2998), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_essence_cs");
}