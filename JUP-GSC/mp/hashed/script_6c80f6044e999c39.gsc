/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6c80f6044e999c39.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_intel_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_intel_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_intel_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_intel_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_intel_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_intel_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_car_dealership_01";
  fe[[f]](s, us, cf, (-10597, -12182.6, 1919.02), (0, 222.31, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_university_building_01";
  fe[[f]](s, us, cf, (-12732, -40048.9, 2641.52), (0, 19.75, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_clinic_01";
  fe[[f]](s, us, cf, (-14881.4, -42233.8, 3181.58), (0, 108.16, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_apartment_02";
  fe[[f]](s, us, cf, (-5909.61, -12987.4, 2022.11), (0, 226.74, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_apartment_21";
  fe[[f]](s, us, cf, (-2237.79, -19755.1, 1883.97), (0, 54.28, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_restaurant_02";
  fe[[f]](s, us, cf, (-6929.32, -18226.2, 1901.66), (0, 54.08, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_station_house_01";
  fe[[f]](s, us, cf, (-28011.7, -15103.5, 1748.88), (0, 253.37, 0), "terminus_audio_intel_warlord");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_intel_cs";
  s.groupid = "stronghold";
  s.name = "terminus_audio_intel_stronghold_g_apartment_18";
  fe[[f]](s, us, cf, (-18730.3, -31277.2, 2226.05), (0, 270.83, 0), "terminus_audio_intel_warlord");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_intel_cs");
}