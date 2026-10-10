/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_61f40b593adbb56b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_zip_door_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_zip_door_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_zip_door_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_zip_door_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_zip_door_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_zip_door_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (35523.9, 18809.8, 3139), (0, 316, 0), "zip_door_destination", "cspf_0_auto4780828477474504615", "674");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_1_auto10583907438871018898", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_1_auto3737599740395406375", "cspf_1_auto11170290169130929106", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_1_auto11059709549162147396", "cspf_1_auto625250580259730343", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_1_auto625250580259730343", "cspf_1_auto4486163629117164502", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_1_auto4486163629117164502", "cspf_1_auto14858222856449094156", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_1_auto14858222856449094156", "cspf_1_auto13980094656917523402", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_1_auto13980094656917523402", undefined, undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_1_auto10583907438871018898", "cspf_1_auto3737599740395406375", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_1_auto11170290169130929106", "cspf_1_auto11059709549162147396", undefined, undefined, undefined, (42208.4, 31804.4, 1771), (0, 136.39, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (35661.3, 18716, 3151), (0, 136, 0), "cspf_0_auto4780828477474504615", "cspf_0_auto6632474592269012091");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (35644.7, 18698.8, 3151), (0, 136, 0), "cspf_0_auto6632474592269012091", "cspf_0_auto8547027372271769495");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (35628, 18681.5, 3151), (0, 136, 0), "cspf_0_auto8547027372271769495");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (42472, 38972.1, 1007.92), (0, 306.27, 0), "zip_door_destination", "cspf_0_auto15421572217756225534", "025");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (42554.6, 38891.9, 1027.42), (0, 126.27, 0), "cspf_0_auto15421572217756225534", "cspf_0_auto17621896376274044490");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (42535.3, 38877.8, 1027.42), (0, 126.27, 0), "cspf_0_auto17621896376274044490", "cspf_0_auto10808413570826975018");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (42515.9, 38863.6, 1027.42), (0, 126.27, 0), "cspf_0_auto10808413570826975018");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (25557.7, 32647.4, 2017.67), (0, 224.71, 0), "zip_door_destination", "cspf_0_auto8618033283432454587", "405");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (25474, 32543.5, 2037.17), (0, 44.71, 0), "cspf_0_auto8618033283432454587", "cspf_0_auto15852414518235555399");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (25460.2, 32557.5, 2037.17), (0, 44.71, 0), "cspf_0_auto15852414518235555399", "cspf_0_auto10974697121367010368");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (25445.8, 32572.1, 2037.17), (0, 44.71, 0), "cspf_0_auto10974697121367010368");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_2_auto10583907438871018898", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_2_auto3737599740395406375", "cspf_2_auto11170290169130929106", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_2_auto11059709549162147396", "cspf_2_auto625250580259730343", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_2_auto625250580259730343", "cspf_2_auto4486163629117164502", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_2_auto4486163629117164502", "cspf_2_auto14858222856449094156", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_2_auto14858222856449094156", "cspf_2_auto13980094656917523402", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_2_auto13980094656917523402", undefined, undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_2_auto10583907438871018898", "cspf_2_auto3737599740395406375", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_2_auto11170290169130929106", "cspf_2_auto11059709549162147396", undefined, undefined, undefined, (25587.6, 23150, 1655), (0, 270.83, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_zip_door_cs");
}