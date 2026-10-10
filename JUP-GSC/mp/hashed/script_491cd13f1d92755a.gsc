/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_491cd13f1d92755a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_intel_cs_season1;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_intel_cs_season1")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_intel_cs_season1");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_intel_cs_season1");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_intel_cs_season1");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_intel_cs_season1");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_intel_cs_season1";
  s.groupid = "deadbolt";
  s.name = "deadbolt_audio_intel";
  s.season = "1";
  fe[[f]](s, us, cf, (-15374, 9109, 1727), (0, 63.8, 0), "deadbolt_audio_intel", undefined, "intel_s1_deadbolt_audio_ghostmachine");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_intel_cs_season1";
  s.groupid = "deadbolt";
  s.name = "deadbolt_audio_intel";
  s.season = "1";
  fe[[f]](s, us, cf, (15047, 3763, 1975), (0, 239.5, 0), "deadbolt_audio_intel", undefined, "intel_s1_deadbolt_audio_rav1stimpressions");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_intel_cs_season1");
}