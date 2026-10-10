/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1404745c166293f3.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_zip_door_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_zip_door_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_zip_door_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_zip_door_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_zip_door_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_zip_door_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (3724.95, -23137.3, 1759), (0, 75.5, 0), "zip_door_destination", "cspf_0_auto4780828477474504615", "420");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (3728.86, -23059.9, 1762), (0, 254.91, 0), "cspf_0_auto4780828477474504615", "cspf_0_auto6632474592269012091", "000");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (3748.04, -23065.1, 1762), (0, 254.91, 0), "cspf_0_auto6632474592269012091", "cspf_0_auto8547027372271769495", "000");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (3767.22, -23070.2, 1762), (0, 254.91, 0), "cspf_0_auto8547027372271769495", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (8345.72, -32707.6, 2275.91), (0, 29.9, 0), "zip_door_destination", "cspf_0_auto3894382367053011497", "054");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_1_auto10583907438871018898", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_1_auto3737599740395406375", "cspf_1_auto11170290169130929106", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_1_auto11059709549162147396", "cspf_1_auto625250580259730343", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_1_auto625250580259730343", "cspf_1_auto4486163629117164502", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_1_auto4486163629117164502", "cspf_1_auto14858222856449094156", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_1_auto14858222856449094156", "cspf_1_auto13980094656917523402", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_1_auto13980094656917523402", undefined, undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_1_auto10583907438871018898", "cspf_1_auto3737599740395406375", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_1_auto11170290169130929106", "cspf_1_auto11059709549162147396", undefined, undefined, undefined, (974.16, -37252.7, 2104), (0, 14.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (8463.5, -32615.2, 2276.91), (0, 213.01, 0), "cspf_0_auto3894382367053011497", "cspf_0_auto15429112901040766582", "000");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (8474.32, -32631.8, 2276.91), (0, 213.01, 0), "cspf_0_auto15429112901040766582", "cspf_0_auto18105370616589597014", "000");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (8485.15, -32648.5, 2276.91), (0, 213.01, 0), "cspf_0_auto18105370616589597014", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_2_auto10583907438871018898", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_2_auto3737599740395406375", "cspf_2_auto11170290169130929106", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_2_auto11059709549162147396", "cspf_2_auto625250580259730343", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_2_auto625250580259730343", "cspf_2_auto4486163629117164502", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_2_auto4486163629117164502", "cspf_2_auto14858222856449094156", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_2_auto14858222856449094156", "cspf_2_auto13980094656917523402", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_2_auto13980094656917523402", undefined, undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_2_auto10583907438871018898", "cspf_2_auto3737599740395406375", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_2_auto11170290169130929106", "cspf_2_auto11059709549162147396", undefined, undefined, undefined, (6671.94, -18238.1, 1986), (0, 75.03, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_zip_door_cs");
}