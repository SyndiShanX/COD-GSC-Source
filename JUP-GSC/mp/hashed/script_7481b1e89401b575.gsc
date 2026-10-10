/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7481b1e89401b575.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_exfil_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_exfil_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_exfil_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_exfil_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_exfil_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_exfil_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-34576, 27802, 1002), (5.09, 222.19, 5.47), "exfil_content_struct_resort_west", "exfil_content_instance_resort_west");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-19159, 15531, 2405), (2.26, 193.28, 1.67), "exfil_content_struct_resort_east", "exfil_content_instance_resort_east");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-38412, 42781, 1768), (359.82, 115.13, 0.06), "exfil_content_struct_hidden_st_a", "exfil_content_instance_hidden_st_a");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-34438, 26605.1, 3314), (0, 0, 0), "exfil_content_instance_resort_west", "exfil_tile_a_resort_location");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-13676, 14451, 1715), (0, 0, 0), "exfil_tile_a_resort_location", "ob_st_a_resort_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-19204.5, 14327.6, 3314), (0, 0, 0), "exfil_content_instance_resort_east", "exfil_tile_a_resort_location");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.name = "ob_st_a_hidden_exfil_destination";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-40987, 41789, 2429), (0, 0, 0), "exfil_tile_a_hiddeen_destination");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.name = "exfil_content_destination_resort";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-13672, 15454, 1853), (0, 0, 0), "ob_st_a_resort_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-38351, 41795, 2233), (0, 0, 0), "exfil_content_instance_hidden_st_a", "exfil_tile_a_hidden_location");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.name = "ob_st_a_hidden_exfil_location";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-41001, 41126, 2291), (0, 0, 0), "exfil_tile_a_hidden_location", "exfil_tile_a_hiddeen_destination");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(100);
  fe[[f]](s, us, cf, (-44180, 17442, 6885), (0, 29.23, 0), undefined, "cspf_0_auto10951929346202955095", "exfil_content_struct_hidden_st_a");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-37726, 21214, 6026), (0, 46, 0), "cspf_0_auto10951929346202955095", "cspf_0_auto5548243177672795488");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-33802, 27218, 4881), (0, 76, 0), "cspf_0_auto5548243177672795488", "cspf_0_auto5576780170962902564");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-33243, 33280, 4045), (0, 96, 0), "cspf_0_auto5576780170962902564", "cspf_0_auto9632386344492273108");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(100);
  fe[[f]](s, us, cf, (-44500, 22694, 7162), (0, 7, 0), "cspf_0_auto4566037470417340589", "cspf_0_auto3737551195232145970");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-49062, 23130, 7756), (0, 7, 0), undefined, "cspf_0_auto4566037470417340589", "exfil_content_struct_resort_east");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(100);
  fe[[f]](s, us, cf, (-39270, 22134, 5882), (0, 7, 0), "cspf_0_auto3737551195232145970", "cspf_0_auto6973495417216749373");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-29220, 22712, 4674), (0, 7, 0), "cspf_0_auto6973495417216749373", "cspf_0_auto5131935656012688077");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-22952, 25404, 4604), (0, 7, 0), "cspf_0_auto5131935656012688077", "cspf_0_auto15363615639178673823");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-18788, 24472, 4072), (0, 337, 0), "cspf_0_auto15363615639178673823", "cspf_0_auto2148769145528080023");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-17050, 18424, 3852), (0, 247, 0), "cspf_0_auto2148769145528080023");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-35626, 38874, 3226), (0, 121, 0), "cspf_0_auto9632386344492273108", "cspf_0_auto7016108639043159546");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-37579, 41613, 2889), (0, 124, 0), "cspf_0_auto7016108639043159546");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(100);
  fe[[f]](s, us, cf, (-27348, 58498, 9426), (0, 277, 0), undefined, "cspf_0_auto17849228441239332363", "exfil_content_struct_resort_west");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-24710, 46290, 5844), (0, 277, 0), "cspf_0_auto17849228441239332363", "cspf_0_auto8615636623963457309");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-25350, 38620, 4700), (0, 277, 0), "cspf_0_auto8615636623963457309", "cspf_0_auto16325975068534820133");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-28158, 32502, 4222), (0, 211, 0), "cspf_0_auto16325975068534820133", "cspf_0_auto2191188203456202783");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-33610, 28336, 2864), (0, 211, 0), "cspf_0_auto2191188203456202783");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_exfil_cs");
}