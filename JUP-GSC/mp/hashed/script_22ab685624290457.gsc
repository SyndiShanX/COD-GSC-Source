/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_22ab685624290457.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_zip_door_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_zip_door_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_zip_door_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_zip_door_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_zip_door_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_zip_door_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-30305, 32570.3, 2725.57), (0, 297.9, 0), "zip_door_destination", "cspf_0_auto4780828477474504615", "617");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_1_auto10583907438871018898", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_1_auto3737599740395406375", "cspf_1_auto11170290169130929106", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_1_auto11059709549162147396", "cspf_1_auto625250580259730343", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_1_auto625250580259730343", "cspf_1_auto4486163629117164502", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_1_auto4486163629117164502", "cspf_1_auto14858222856449094156", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_1_auto14858222856449094156", "cspf_1_auto13980094656917523402", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_1_auto13980094656917523402", undefined, undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_1_auto10583907438871018898", "cspf_1_auto3737599740395406375", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_1_auto11170290169130929106", "cspf_1_auto11059709549162147396", undefined, undefined, undefined, (-32105.2, 43025.1, 1696), (0, 65, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-30231.5, 32463.5, 2691.57), (0, 117.9, 0), "cspf_0_auto4780828477474504615", "cspf_0_auto6632474592269012091", "000");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-30252.7, 32452.3, 2691.57), (0, 117.9, 0), "cspf_0_auto6632474592269012091", "cspf_0_auto8547027372271769495", "000");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-30274, 32441, 2691.57), (0, 117.9, 0), "cspf_0_auto8547027372271769495", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-15081.4, 34262.8, 1494.07), (0, 90.9, 0), "zip_door_destination", "cspf_0_auto17789116632048991749", "725");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-15098.4, 34391.4, 1510.07), (0, 270.9, 0), "cspf_0_auto17789116632048991749", "cspf_0_auto14487502342771067596", "000");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-15074.4, 34391.7, 1510.07), (0, 270.9, 0), "cspf_0_auto14487502342771067596", "cspf_0_auto3561028083368378644", "000");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.name = "Zip";
  fe[[f]](s, us, cf, (-15050.3, 34392.1, 1510.07), (0, 270.9, 0), "cspf_0_auto3561028083368378644", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_2_auto10583907438871018898", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_2_auto3737599740395406375", "cspf_2_auto11170290169130929106", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_2_auto11059709549162147396", "cspf_2_auto625250580259730343", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_2_auto625250580259730343", "cspf_2_auto4486163629117164502", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_2_auto4486163629117164502", "cspf_2_auto14858222856449094156", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_2_auto14858222856449094156", "cspf_2_auto13980094656917523402", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_2_auto13980094656917523402", undefined, undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_2_auto10583907438871018898", "cspf_2_auto3737599740395406375", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_2_auto11170290169130929106", "cspf_2_auto11059709549162147396", undefined, undefined, undefined, (-14465, 35778.3, 1255.5), (0, 268.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_3_auto10583907438871018898", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_3_auto3737599740395406375", "cspf_3_auto11170290169130929106", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_3_auto11059709549162147396", "cspf_3_auto625250580259730343", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_3_auto625250580259730343", "cspf_3_auto4486163629117164502", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_3_auto4486163629117164502", "cspf_3_auto14858222856449094156", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_3_auto14858222856449094156", "cspf_3_auto13980094656917523402", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_3_auto13980094656917523402", undefined, undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_3_auto10583907438871018898", "cspf_3_auto3737599740395406375", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_3_auto11170290169130929106", "cspf_3_auto11059709549162147396", undefined, undefined, undefined, (-23071.8, 21522.5, 1869), (0, 178.71, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_zip_door_cs");
}