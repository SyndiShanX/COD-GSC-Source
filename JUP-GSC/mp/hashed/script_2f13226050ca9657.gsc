/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f13226050ca9657.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_zip_door_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_zip_door_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_zip_door_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_zip_door_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_zip_door_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_zip_door_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (-5876.47, -2631.4, 1123), (0, 104, 0), "zip_door_destination", "cspf_0_auto4780828477474504615", "761");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.objectid = "zip_door";
  fe[[f]](s, us, cf, (3, 0, 0), (90, 0, 0), "zip_door_entry", "cspf_1_auto10583907438871018898", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 46), (-90, 0, 0), "cspf_1_auto3737599740395406375", "cspf_1_auto11170290169130929106", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, -13, 106), (-90, 0, 0), "cspf_1_auto11059709549162147396", "cspf_1_auto625250580259730343", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 17, 106), (-90, 0, 0), "cspf_1_auto625250580259730343", "cspf_1_auto4486163629117164502", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 78), (-90, 0, 0), "cspf_1_auto4486163629117164502", "cspf_1_auto14858222856449094156", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 46), (-90, 0, 0), "cspf_1_auto14858222856449094156", "cspf_1_auto13980094656917523402", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-0.5, 35, 14), (-90, 0, 0), "cspf_1_auto13980094656917523402", undefined, undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 14.5), (-90, 0, 0), "cspf_1_auto10583907438871018898", "cspf_1_auto3737599740395406375", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  fe[[f]](s, us, cf, (-1.5, -36, 78), (-90, 0, 0), "cspf_1_auto11170290169130929106", "cspf_1_auto11059709549162147396", undefined, undefined, undefined, (7113.45, -6955.87, 2416.34), (0, 45.07, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-5943.31, -2479.04, 1135), (0, 284, 0), "cspf_0_auto4780828477474504615", "cspf_0_auto6632474592269012091", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-5920.03, -2473.24, 1135), (0, 284, 0), "cspf_0_auto6632474592269012091", "cspf_0_auto8547027372271769495", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-5896.74, -2467.43, 1135), (0, 284, 0), "cspf_0_auto8547027372271769495", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (22399.6, -505.52, 2805.5), (0, 157.93, 0), "zip_door_destination", "cspf_0_auto13235118757902831664", "602");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (22240.8, -471.64, 2825.5), (0, 339.24, 0), "cspf_0_auto13235118757902831664", "cspf_0_auto17696718172150803151", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (22248.3, -451.75, 2825.5), (0, 339.24, 0), "cspf_0_auto17696718172150803151", "cspf_0_auto31658548977360551", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (22255.6, -432.54, 2825.5), (0, 339.24, 0), "cspf_0_auto31658548977360551", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (12534.7, 10318.9, 4451.5), (0, 242.7, 0), "zip_door_destination", "cspf_0_auto11620425912464635802", "206");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (12527.3, 10226.4, 4423.5), (0.35, 78.92, -0.95), "cspf_0_auto11620425912464635802", "cspf_0_auto16426705045094135273", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (12509.1, 10230.6, 4425), (0, 79.06, 0), "cspf_0_auto16426705045094135273", "cspf_0_auto2782011490349007383", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (12491.5, 10228.4, 4424), (0, 112.7, 0), "cspf_0_auto2782011490349007383", undefined, "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination";
  fe[[f]](s, us, cf, (-5395.39, 10353.9, 1809.75), (0, 274, 0), "zip_door_destination", "cspf_0_auto11525386333510966823", "356");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-5370.97, 10261.8, 1809.75), (0.35, 88.72, -0.95), "cspf_0_auto11525386333510966823", "cspf_0_auto7762986383221714178", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-5389.62, 10261.9, 1810.25), (0, 99.86, 0), "cspf_0_auto7762986383221714178", "cspf_0_auto13313007968025539554", "000");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_zip_door_cs";
  s.name = "Zip Destination Digit";
  fe[[f]](s, us, cf, (-5406.88, 10257.3, 1810.25), (0, 115.5, 0), "cspf_0_auto13313007968025539554", undefined, "000");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_zip_door_cs");
}