/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2acf4da10896bd21.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_intel_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_intel_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_intel_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_intel_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_intel_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_intel_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_d_marina_building_10";
  fe[[f]](s, us, cf, (-31667.4, 8286.45, 1364.6), (0, 97.63, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_d_house_md_03";
  fe[[f]](s, us, cf, (-21595.8, 8742.5, 2553), (0, 217.63, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_d_house_md_08";
  fe[[f]](s, us, cf, (-32976, 14796.3, 1108.72), (359.93, 277.8, -3.86), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_d_house_md_08_2";
  fe[[f]](s, us, cf, (-19164.8, 9348.75, 2135.5), (0.23, 62.49, -4.12), "terminus_audio_intel_warlord");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_intel_cs");
}