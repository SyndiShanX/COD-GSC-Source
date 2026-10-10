/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_30da38c9cc521925.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_intel_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_intel_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_intel_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_intel_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_intel_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_intel_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_a_store_abandoned_lg_02";
  fe[[f]](s, us, cf, (-23108.5, 17638.6, 1669.8), (0, 138.73, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_a_apartment_abandoned_md_02";
  fe[[f]](s, us, cf, (-23778.7, 39317.3, 2268.83), (0, 45, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_a_apartment_abandoned_24";
  fe[[f]](s, us, cf, (-28559.6, 42105.8, 1717.84), (0, 244.93, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_a_store_abandoned_md_01_2";
  fe[[f]](s, us, cf, (-32262.1, 23458.3, 1454.59), (0, 117.63, 0), "terminus_audio_intel_warlord");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_intel_cs");
}