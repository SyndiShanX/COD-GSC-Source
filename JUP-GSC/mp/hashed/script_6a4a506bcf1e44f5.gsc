/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6a4a506bcf1e44f5.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_intel_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_intel_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_intel_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_intel_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_intel_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_intel_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_b_office_lg_01";
  fe[[f]](s, us, cf, (7848.92, 24942.2, 1198), (0, 343.03, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_b_coalplant_office_02";
  fe[[f]](s, us, cf, (-8485.59, 35103.4, 1452.8), (0.99, 84.1, -0.1), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_b_store_abandoned_md_01";
  fe[[f]](s, us, cf, (-9188.75, 19172.2, 1672), (0.36, 90.1, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_b_factory_md_3s_01";
  fe[[f]](s, us, cf, (5812.57, 31310.2, 1408.6), (0.73, 346.2, -0.24), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_b_station_house_01_a";
  fe[[f]](s, us, cf, (10766.2, 36134.7, 1486.62), (1, 85.8, -0.07), "terminus_audio_intel_warlord");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_intel_cs");
}