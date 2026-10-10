/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5c25478a39093031.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_exfil_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_exfil_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_exfil_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_exfil_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_exfil_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_exfil_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.name = "exfil_content_destination_suburbs";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (15550, -39621, 1740), (0, 0, 0), "ob_st_h_suburbs_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (54706, 97, 8674), (0, 188, 0), undefined, "cspf_0_auto14313916688326357309", "exfil_content_struct_suburbs_east");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-2178, -44251, 2835), (1.2, 274.66, -2.8), "exfil_content_struct_suburbs_south", "exfil_content_instance_suburbs_south");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (21223, -23668, 2981), (0, 237.6, 0.4), "exfil_content_struct_suburbs_east", "exfil_content_instance_suburbs_east");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.name = "quest_exfil_content_destination_h";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (11507, -16275, 1776.16), (0, 0, 0), "ob_quest_exfil_destination_h", undefined, "quest_destination");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (20082.5, -23330.9, 3116), (0, 314.57, 0), "exfil_content_instance_suburbs_east", "exfil_tile_h_suburbs_location");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (15290, -39279, 1594), (0, 0, 0), "exfil_tile_h_suburbs_location", "ob_st_h_suburbs_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-691.5, -44803.9, 3381), (0, 314.57, 0), "exfil_content_instance_suburbs_south", "exfil_tile_h_suburbs_location");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (48830, -1644, 7348), (0, 216, 0), "cspf_0_auto14313916688326357309", "cspf_0_auto16224233239575921426");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (45278, -7795, 6053), (0, 222, 0), "cspf_0_auto16224233239575921426", "cspf_0_auto6692501476402266143");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-2662, -22209, 1719), (0, 257.76, 0), "exfil_content_struct_city", "exfil_content_instance_city");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (38478, -12162, 6002), (0, 192, 0), "cspf_0_auto6692501476402266143", "cspf_0_auto2693661772574983650");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (31401, -12219, 4974.32), (0, 186, 0), "cspf_0_auto2693661772574983650", "cspf_0_auto9029198867502437631");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (25244, -15187, 4924), (0, 234, 0), "cspf_0_auto9029198867502437631", "cspf_0_auto8683934307983270366");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (22882, -20906, 4805), (0, 270, 0), "cspf_0_auto8683934307983270366");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (-36640, -34114, 8360), (0, 346.97, 0), undefined, "cspf_0_auto16746420466925583280", "exfil_content_struct_suburbs_south");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (-27976, -32196, 7200), (0, 346.97, 0), "cspf_0_auto16746420466925583280", "cspf_0_auto12637035262748204755");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (-22268, -33706, 4880), (0, 346.97, 0), "cspf_0_auto12637035262748204755", "cspf_0_auto1824318020665989052");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (-16290, -38110, 4414), (0, 346.97, 0), "cspf_0_auto1824318020665989052", "cspf_0_auto4593166247493901700");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (-8252, -39292, 3830), (0, 346.97, 0), "cspf_0_auto4593166247493901700", "cspf_0_auto13426077406421079566");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (-3812, -43802, 3530), (0, 346.97, 0), "cspf_0_auto13426077406421079566");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-1338.5, -21855.9, 2354), (0, 314.57, 0), "exfil_content_instance_city", "exfil_tile_h_suburbs_location");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (23384, -43138, 8360), (0, 134.97, 0), undefined, "cspf_0_auto4517769017578611781", "exfil_content_struct_city");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (16872, -36796, 7200), (0, 116.97, 0), "cspf_0_auto4517769017578611781", "cspf_0_auto11574789463764004885");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (15550, -28094, 4880), (0, 114.97, 0), "cspf_0_auto11574789463764004885", "cspf_0_auto17744289812492081288");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (10054, -20312, 4414), (0, 140.97, 0), "cspf_0_auto17744289812492081288", "cspf_0_auto14381404119542518188");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (4548, -17942, 3830), (0, 174.97, 0), "cspf_0_auto14381404119542518188", "cspf_0_auto1650108241136053916");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (-480, -19788, 3530), (0, 224.97, 0), "cspf_0_auto1650108241136053916");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.name = "quest_exfil_location_h";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (13062, -15715, 1918), (0, 0, 0), "quest_exfil_h", "ob_quest_exfil_destination_h");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.name = "quest_exfil_content_instance_h";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (12504.5, -15476.9, 1903), (0, 314.57, 0), "exfil_content_instance_quest_h", "quest_exfil_h", "quest_exfil");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (12685.7, -24523.1, 1711.72), (0, 90, 0), "exfil_content_struct_quest_h", "exfil_content_instance_quest_h");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (28611, -62753.6, 8674), (0, 163, 0), undefined, "cspf_0_auto2797634607654483659", "exfil_content_struct_quest_h");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (22404, -60698.6, 7348), (0, 126, 0), "cspf_0_auto2797634607654483659", "cspf_0_auto18156297526654001057");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (18945, -56058.6, 6053), (0, 132, 0), "cspf_0_auto18156297526654001057", "cspf_0_auto1454824276288008168");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (16319, -49554.6, 5845), (0, 102, 0), "cspf_0_auto1454824276288008168", "cspf_0_auto15347674575350175201");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (14412, -43089.6, 4974.32), (0, 96, 0), "cspf_0_auto15347674575350175201", "cspf_0_auto3849509805991415510");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (15194, -34444.5, 3767), (0, 106, 0), "cspf_0_auto3849509805991415510", "cspf_0_auto1208640630513436484");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_exfil_cs";
  s.script_speed = "60";
  fe[[f]](s, us, cf, (12671, -25295.6, 3000), (0, 90, 0), "cspf_0_auto1208640630513436484");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_exfil_cs");
}