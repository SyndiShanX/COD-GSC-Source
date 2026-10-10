/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_525d800963056427.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_zip_door_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_zip_door_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_zip_door_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_zip_door_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_zip_door_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_zip_door_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (30765, -30256.3, 3099), (0, 203.9, 0), "zip_door_destination", "cspf_0_auto4780828477474504615", "234");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (30640.5, -30323.4, 3082), (0, 23.9, 0), "cspf_0_auto4780828477474504615", "cspf_0_auto6632474592269012091", "000");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (30630.7, -30301.4, 3082), (0, 23.9, 0), "cspf_0_auto6632474592269012091", "cspf_0_auto8547027372271769495", "000");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (30621, -30279.5, 3082), (0, 23.9, 0), "cspf_0_auto8547027372271769495", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (44198, -30364.7, 3141.51), (0, 56.6, 0), "zip_door_destination", "cspf_0_auto9819767579108367625", "372");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_1_auto10583907438871018898", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_1_auto3737599740395406375", "cspf_1_auto11170290169130929106", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_1_auto11059709549162147396", "cspf_1_auto625250580259730343", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_1_auto625250580259730343", "cspf_1_auto4486163629117164502", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_1_auto4486163629117164502", "cspf_1_auto14858222856449094156", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_1_auto14858222856449094156", "cspf_1_auto13980094656917523402", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_1_auto13980094656917523402", undefined, undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_1_auto10583907438871018898", "cspf_1_auto3737599740395406375", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_1_auto11170290169130929106", "cspf_1_auto11059709549162147396", undefined, undefined, undefined, (34124, -34739, 3296), (0, 202.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44283.5, -30192.2, 3154.51), (0, 238.7, 0), "cspf_0_auto9819767579108367625", "cspf_0_auto13170057833861355640", "000");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44301.5, -30203, 3154.51), (0, 238.7, 0), "cspf_0_auto13170057833861355640", "cspf_0_auto11642802417402089927", "000");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (44319.4, -30213.9, 3154.51), (0, 238.7, 0), "cspf_0_auto11642802417402089927", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_2_auto10583907438871018898", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_2_auto3737599740395406375", "cspf_2_auto11170290169130929106", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_2_auto11059709549162147396", "cspf_2_auto625250580259730343", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_2_auto625250580259730343", "cspf_2_auto4486163629117164502", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_2_auto4486163629117164502", "cspf_2_auto14858222856449094156", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_2_auto14858222856449094156", "cspf_2_auto13980094656917523402", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_2_auto13980094656917523402", undefined, undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_2_auto10583907438871018898", "cspf_2_auto3737599740395406375", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_2_auto11170290169130929106", "cspf_2_auto11059709549162147396", undefined, undefined, undefined, (25323.4, -40424.4, 3247.44), (0, 219.71, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_zip_door_cs");
}