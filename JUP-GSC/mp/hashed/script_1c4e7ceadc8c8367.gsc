/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c4e7ceadc8c8367.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_zip_door_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_zip_door_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_zip_door_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_zip_door_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_zip_door_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_zip_door_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (44861.7, 1371.46, 3016), (0, 88.56, 0), "zip_door_destination", "cspf_0_auto4780828477474504615", "215");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44840.5, 1511.99, 3070), (0, 269.14, 0), "cspf_0_auto4780828477474504615", "cspf_0_auto6632474592269012091", "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44864.5, 1511.56, 3070), (0, 269.14, 0), "cspf_0_auto6632474592269012091", "cspf_0_auto8547027372271769495", "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44888.5, 1511.24, 3070), (0, 269.14, 0), "cspf_0_auto8547027372271769495", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (31884.3, -14872.9, 3152), (0, 62, 0), "zip_door_destination", "cspf_0_auto9938239913269228477", "507");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (31922.6, -14744, 3164), (0, 242, 0), "cspf_0_auto9938239913269228477", "cspf_0_auto10127109814567136998", "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (31943.8, -14755.2, 3164), (0, 242, 0), "cspf_0_auto10127109814567136998", "cspf_0_auto14729230588033784835", "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (31965, -14766.5, 3164), (0, 242, 0), "cspf_0_auto14729230588033784835", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (44359.7, -14226.5, 3557), (0, 99.8, 0), "zip_door_destination", "cspf_0_auto1723349495608264191", "514");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_1_auto10583907438871018898", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_1_auto3737599740395406375", "cspf_1_auto11170290169130929106", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_1_auto11059709549162147396", "cspf_1_auto625250580259730343", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_1_auto625250580259730343", "cspf_1_auto4486163629117164502", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_1_auto4486163629117164502", "cspf_1_auto14858222856449094156", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_1_auto14858222856449094156", "cspf_1_auto13980094656917523402", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_1_auto13980094656917523402", undefined, undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_1_auto10583907438871018898", "cspf_1_auto3737599740395406375", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_1_auto11170290169130929106", "cspf_1_auto11059709549162147396", undefined, undefined, undefined, (31667.5, 3261.5, 2168), (0, 207.96, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44229.9, -14128.2, 3600.26), (6.1, 348.29, -0.15), "cspf_0_auto1723349495608264191", "cspf_0_auto2588797503913367650", "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44310.1, -14052.7, 3601.75), (6.6, 287, -0), "cspf_0_auto2588797503913367650", "cspf_0_auto12740746848519738941", "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44414.7, -14083.3, 3600.65), (6.3, 224, -0), "cspf_0_auto12740746848519738941", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_2_auto10583907438871018898", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_2_auto3737599740395406375", "cspf_2_auto11170290169130929106", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_2_auto11059709549162147396", "cspf_2_auto625250580259730343", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_2_auto625250580259730343", "cspf_2_auto4486163629117164502", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_2_auto4486163629117164502", "cspf_2_auto14858222856449094156", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_2_auto14858222856449094156", "cspf_2_auto13980094656917523402", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_2_auto13980094656917523402", undefined, undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_2_auto10583907438871018898", "cspf_2_auto3737599740395406375", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_2_auto11170290169130929106", "cspf_2_auto11059709549162147396", undefined, undefined, undefined, (23945.4, -5166.69, 3026.75), (0, 31.8, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_zip_door_cs");
}