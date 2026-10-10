/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6e97ef5abce6a2cf.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_exfil_power_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_exfil_power_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_exfil_power_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_exfil_power_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_exfil_power_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_exfil_power_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.target2 = "exfil_destination_2_exit_start";
  fe[[f]](s, us, cf, (-5799.3, 26534.3, 998.42), (0, 261.37, 0), "exfil_destination_2", "exfil_destination_2_enter_start");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (11536.5, 19431.1, 1617.09), (0, 0, 0), "exfil_content_instance_power_east", "exfil_content_location_power_east");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (-6398.6, 32335.2, 1407.66), (350.04, 251.29, 0.88), "exfil_destination_2");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.name = "exfil_content_destination_power";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-4363, 24825, 2131), (0, 0, 0), "ob_st_b_power_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (11538.1, 20096.5, 994.14), (0, 228.5, 0), "exfil_content_struct_power_east", "exfil_content_instance_power_east");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (-2121, 27355.1, 964.5), (0, 199.98, 0), "exfil_destination_2");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (-4664.7, 30020.8, 1004.53), (355, 241.37, -0), "exfil_destination_2");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.content_key = "exfil_interact";
  s.target2 = "exfil_power_west_exitpath";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-7227.1, 24497.7, 1013.41), (0, 152.45, 0), "exfil_content_struct_power_west", "exfil_content_instance_power_west");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (-2921.1, 31157.1, 3024), (0, 33.9, 0), "exfil_destination_2_exit_start", "exfil_2_auto2");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (2013, 47186, 1702), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (-1838.9, 31240.3, 3240), (0, 3.9, 0), "exfil_2_auto2", "exfil_2_auto3");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (-26575, 138, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_accel = float(75);
  s.script_speed = int(250);
  fe[[f]](s, us, cf, (-458.2, 30682.5, 3164), (0, 273.9, 0), "exfil_2_auto3", "exfil_2_auto4");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (5012.8, 20319.4, 3476), (0, 273.9, 0), "exfil_2_auto4", "exfil_2_auto5");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (5175.2, 16078.9, 3196), (0, 273.9, 0), "exfil_2_auto5", "exfil_2_auto6");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (12962.6, 13828.1, 1034.86), (0, 333.9, 0), "exfil_2_auto6");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (-893.3, 49669.3, 4008), (0, 273.9, 0), "exfil_destination_2_enter_start", "exfil_2_auto7");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (9892.7, 52960.9, 4008), (0, 273.9, 0), "exfil_2_auto7", "exfil_2_auto8");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (11689.9, 44934.5, 4008), (0, 243.9, 0), "exfil_2_auto8", "exfil_2_auto9");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (5359.6, 36290.2, 4368), (0, 258.9, 0), "exfil_2_auto9");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-7203.5, 23903.1, 1284), (0, 0, 0), "exfil_content_instance_power_west", "exfil_content_location_power_west");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-4288, 24192, 2112), (0, 0, 0), "exfil_content_location_power_east", "ob_st_b_power_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  fe[[f]](s, us, cf, (7418, 18133, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-4480, 24192, 2112), (0, 0, 0), "exfil_content_location_power_west", "ob_st_b_power_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.name = "quest_exfil_content_destination_b";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (15417, 23663, 2048), (0, 0, 0), "ob_quest_exfil_destination_b", undefined, "quest_destination");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.name = "quest_exfil_location_b";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (15417, 23343, 1856), (0, 0, 0), "quest_exfil_b", "ob_quest_exfil_destination_b");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.content_script_name = "exfil";
  s.name = "quest_exfil_content_instance_b";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (17081, 22831, 1920), (0, 0, 0), "exfil_content_instance_quest_b", "quest_exfil_b", "quest_exfil");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (15934.5, 19585, 904), (0, 280, 0), "exfil_content_struct_quest_b", "exfil_content_instance_quest_b");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-9903.6, 40243.8, 5661), (0, 279, 0), undefined, "cspf_0_auto2609890710391794286", "exfil_content_struct_quest_b");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-5799, 39514.1, 5629), (0, 311, 0), "cspf_0_auto2609890710391794286", "cspf_0_auto5959003048397189601");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-1772.8, 37919.2, 4441), (0, 41, 0), "cspf_0_auto5959003048397189601", "cspf_0_auto10410803106715820231");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (2944.8, 35210.2, 3736), (0, 311, 0), "cspf_0_auto10410803106715820231", "cspf_0_auto12563183029855691524");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (9134.1, 32618.8, 3046), (0, 41, 0), "cspf_0_auto12563183029855691524", "cspf_0_auto8805939435135378021");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (13356.8, 26618.4, 3292), (0, 311, 0), "cspf_0_auto8805939435135378021", "cspf_0_auto15780112461190099433");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (15578, 21124.3, 2000), (0, 280, 0), "cspf_0_auto15780112461190099433");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-7917, 24919, 2562), (0, 157.36, 0), "exfil_power_west_exitpath", "cspf_0_auto2062192013402504808");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-12776, 27208, 3993), (0, 145.62, 0), "cspf_0_auto2062192013402504808", "cspf_0_auto17078465516990815291");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-16931, 31267, 4812), (0, 127.83, 0), "cspf_0_auto17078465516990815291", "cspf_0_auto386229940799164453");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-19803, 36364, 5117), (0, 109.6, 0), "cspf_0_auto386229940799164453", "cspf_0_auto3874138911403757402");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_exfil_power_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-20438, 43192, 5799), (0, 96.04, 0), "cspf_0_auto3874138911403757402", "cspf_0_auto9021071661645872588");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_exfil_power_cs");
}