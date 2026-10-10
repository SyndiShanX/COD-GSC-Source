/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_59f7d012e2751223.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_intel_cs_season2;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_intel_cs_season2")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_intel_cs_season2");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_intel_cs_season2");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_intel_cs_season2");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_intel_cs_season2");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_intel_cs_season2";
  s.groupid = "deadbolt";
  s.name = "deadbolt_audio_intel";
  s.season = "2";
  fe[[f]](s, us, cf, (-8232, 37364, 1376), (0, 89.37, 0), "deadbolt_audio_intel", undefined, "intel_s2_deadbolt_audio_comfort");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_intel_cs_season2";
  s.groupid = "deadbolt";
  s.name = "deadbolt_radio_intel";
  fe[[f]](s, us, cf, (13812, 18157, 916), (0, 115.7, 0), "deadbolt_radio_intel", undefined, "intel_s2_deadbolt_radio_containment");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_intel_cs_season2");
}