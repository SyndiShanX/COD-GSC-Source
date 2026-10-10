/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_ac3fa8a0758d391.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_exfil_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_exfil_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_exfil_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_exfil_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_exfil_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_exfil_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.name = "exfil_content_destination_city";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-16320, -24405, 1861), (0, 0, 0), "ob_st_g_city_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-23846, -9828, 1512.98), (0, 352.1, 0), "exfil_content_struct_city_north", "exfil_content_instance_city_north");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-33485, -23174, 1053), (2.15, 278.27, 4.79), "exfil_content_struct_city_west", "exfil_content_instance_city_west");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-33507.5, -25107.9, 2324), (0, 314.57, 0), "exfil_content_instance_city_west", "exfil_tile_g_city_location");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-9667, -41001, 6209), (0, 45, 0), "cspf_0_auto1718046735724674455", "cspf_0_auto3063436830039019767");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-16311, -25301, 1715), (0, 0, 0), "exfil_tile_g_city_location", "ob_st_g_city_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-23862.5, -11061.9, 1544), (0, 314.57, 0), "exfil_content_instance_city_north", "exfil_tile_g_city_location");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-6459.4, -46755.4, 9136.95), (0, 45, 0), undefined, "cspf_0_auto1718046735724674455", "exfil_content_struct_city_west");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-12775, -36160, 5179), (0, 45, 0), "cspf_0_auto3063436830039019767", "cspf_0_auto9406022202759137786");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-18363, -29380, 5205), (0, 45, 0), "cspf_0_auto9406022202759137786", "cspf_0_auto17823848510433847463");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-23934, -23589, 3815), (0, 45, 0), "cspf_0_auto17823848510433847463", "cspf_0_auto17359795474774515200");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-32840, -24143, 3368), (0, 135, 0), "cspf_0_auto17359795474774515200");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-39366, 10568, 5230), (0, 315, 0), "cspf_0_auto17924790180327488746", "cspf_0_auto15465439923567109171");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-48185.4, 15158.4, 2789.95), (0, 315, 0), undefined, "cspf_0_auto17924790180327488746", "exfil_content_struct_city_north");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-31318, 5241, 4270), (0, 315, 0), "cspf_0_auto15465439923567109171", "cspf_0_auto17130210361914018235");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-28277, 1405, 3416), (0, 315, 0), "cspf_0_auto17130210361914018235", "cspf_0_auto506403365432265501");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-23587, -2603, 3365), (0, 315, 0), "cspf_0_auto506403365432265501", "cspf_0_auto9630662781863314531");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-23117, -8608, 3314), (0, 315, 0), "cspf_0_auto9630662781863314531");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-33208, -34192, 2197), (356.75, 234.09, 0.4), "exfil_content_struct_hidden_st_g", "exfil_content_instance_hidden_st_g");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.name = "ob_st_g_hidden_exfil_destination";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-35392, -35557, 3798), (0, 0, 0), "exfil_tile_g_hiddeen_destination");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-33225, -35087, 3132), (0, 0, 0), "exfil_content_instance_hidden_st_g", "exfil_tile_g_hidden_location");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.name = "ob_st_g_hidden_exfil_location";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-35406, -36220, 3660), (0, 0, 0), "exfil_tile_g_hidden_location", "exfil_tile_g_hiddeen_destination");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(100);
  fe[[f]](s, us, cf, (-38464, -6001, 7518), (0, 338.23, 0), undefined, "cspf_0_auto10951929346202955095", "exfil_content_struct_hidden_st_g");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-26147.8, -12728.7, 6659), (0, 318.26, 0), "cspf_0_auto10951929346202955095", "cspf_0_auto5548243177672795488");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-21823, -19663, 5514), (0, 275.36, 0), "cspf_0_auto5548243177672795488", "cspf_0_auto5576780170962902564");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-23544.3, -25641.3, 4678), (0, 226.9, 0), "cspf_0_auto5576780170962902564", "cspf_0_auto9632386344492273108");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-29626, -27766.4, 4180), (0, 223.26, 0), "cspf_0_auto9632386344492273108", "cspf_0_auto7016108639043159546");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-32310, -32700, 3522), (0, 242.26, 0), "cspf_0_auto7016108639043159546");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_exfil_cs");
}