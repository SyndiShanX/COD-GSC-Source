/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5dd2b8658977af92.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_exfil_lowtown_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_exfil_lowtown_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_exfil_lowtown_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_exfil_lowtown_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_exfil_lowtown_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_exfil_lowtown_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.target2 = "exfil_destination_1_exit_start";
  fe[[f]](s, us, cf, (21154.7, -6767.71, 2298), (0, 21.37, 0), "exfil_lowtown_landing_destination_1", "exfil_destination_1_enter_start");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.name = "quest_exfil_content_destination_e1";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-1142, -12581, 2048), (0, 0, 0), "ob_quest_exfil_destination_e1", undefined, "quest_destination");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.name = "exfil_content_destination_lowtown";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (19594.5, -5267.5, 3378), (0, 0, 0), "ob_st_e_lowtown_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.console_gen = "baseSpec,highSpec,lowSpec";
  s.content_key = "exfil_interact";
  s.target2 = "exfil_lowtown_landing_destination_1";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (21133.1, -6731.08, 2297.38), (3.2, 44.57, -0), "exfil_lowtown", "exfil_content_instance_lowtown");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.name = "quest_exfil_content_destination_e2";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (-14376, 7547, 2048), (0, 0, 0), "ob_quest_exfil_destination_e2", undefined, "quest_destination");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.content_script_name = "exfil";
  s.name = "quest_exfil_content_instance_e2";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (-12979, 7447, 2032), (0, 0, 0), "exfil_content_instance_quest_e2", "quest_exfil_e2", "quest_exfil");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.content_script_name = "exfil";
  s.name = "quest_exfil_content_instance_e1";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (1033, -13418, 2032), (0, 0, 0), "exfil_content_instance_quest_e1", "quest_exfil_e1", "quest_exfil");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  fe[[f]](s, us, cf, (23840.1, -7336.71, 3897), (0, 333.9, 0), "exfil_1_auto2", "exfil_1_auto3");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_accel = float(75);
  s.script_speed = int(250);
  fe[[f]](s, us, cf, (24756.8, -7726.53, 3589), (0, 273.9, 0), "exfil_1_auto3", "exfil_1_auto4");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  fe[[f]](s, us, cf, (30227.8, -18089.6, 3901), (0, 273.9, 0), "exfil_1_auto4", "exfil_1_auto5");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  fe[[f]](s, us, cf, (30390.2, -22330.1, 3621), (0, 273.9, 0), "exfil_1_auto5", "exfil_1_auto6");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  fe[[f]](s, us, cf, (38177.6, -24580.9, 1459.86), (0, 333.9, 0), "exfil_1_auto6");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(45);
  fe[[f]](s, us, cf, (24321.7, 11260.3, 4433), (0, 18.9, 0), "exfil_destination_1_enter_start", "exfil_1_auto7");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(45);
  fe[[f]](s, us, cf, (28491.7, 6471.9, 4433), (0, 273.9, 0), "exfil_1_auto7", "exfil_1_auto8");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(45);
  fe[[f]](s, us, cf, (30424.9, 2125.54, 4433), (0, 243.9, 0), "exfil_1_auto8", "exfil_1_auto9");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  fe[[f]](s, us, cf, (30574.6, -2118.8, 4793), (0, 258.9, 0), "exfil_1_auto9");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-44772.6, -35551.2, 5661), (0, 1, 0), undefined, "cspf_0_auto2609890710391794286", "exfil_content_struct_quest_e1");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-35980, -35452.9, 5629), (0, 311, 0), "cspf_0_auto2609890710391794286", "cspf_0_auto5959003048397189601");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.console_gen = "baseSpec,highSpec,lowSpec";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (21037.5, -5617.39, 3209.5), (0, 314.57, 0), "exfil_content_instance_lowtown", "core_features_lowtown_location");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (19587.5, -5611.5, 3232), (0, 0, 0), "core_features_lowtown_location", "ob_st_e_lowtown_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-27617.8, -31843.8, 4441), (0, 41, 0), "cspf_0_auto5959003048397189601", "cspf_0_auto10410803106715820231");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-20655.2, -29351.8, 3736), (0, 311, 0), "cspf_0_auto10410803106715820231", "cspf_0_auto12563183029855691524");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-13243.9, -24638.2, 3420), (0, 41, 0), "cspf_0_auto12563183029855691524", "cspf_0_auto8805939435135378021");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-7079.2, -19910.6, 3292), (0, 311, 0), "cspf_0_auto8805939435135378021", "cspf_0_auto15780112461190099433");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-2150, -15567.7, 3000), (0, 35, 0), "cspf_0_auto15780112461190099433");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.name = "quest_exfil_location_e1";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (861, -12829, 2040), (0, 0, 0), "quest_exfil_e1", "ob_quest_exfil_destination_e1");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-334, -14353.6, 1773.66), (0, 35, 0), "exfil_content_struct_quest_e1", "exfil_content_instance_quest_e1");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.name = "quest_exfil_location_e2";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (-13231, 7685, 2040), (0, 0, 0), "quest_exfil_e2", "ob_quest_exfil_destination_e2");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-13515, 6881, 1081), (0, 35, 0), "exfil_content_struct_quest_e2", "exfil_content_instance_quest_e2");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-57490.6, -14200.2, 5661), (0, 1, 0), undefined, "cspf_0_auto7718535788367446403", "exfil_content_struct_quest_e2");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-48698, -14101.9, 5629), (0, 311, 0), "cspf_0_auto7718535788367446403", "cspf_0_auto16216266111810573933");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-40335.8, -10492.8, 4441), (0, 41, 0), "cspf_0_auto16216266111810573933", "cspf_0_auto18186809293691799417");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-33373.2, -8000.8, 3736), (0, 311, 0), "cspf_0_auto18186809293691799417", "cspf_0_auto6837851791040329975");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-25961.9, -3287.2, 3460), (0, 41, 0), "cspf_0_auto6837851791040329975", "cspf_0_auto392005846486107093");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-19797.2, 1440.4, 3292), (0, 311, 0), "cspf_0_auto392005846486107093", "cspf_0_auto9280954647457990606");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-14725, 5998.3, 3000), (0, 35, 0), "cspf_0_auto9280954647457990606");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.name = "quest_exfil_content_destination_e3";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (148, 16044, 2048), (0, 0, 0), "ob_quest_exfil_destination_e3", undefined, "quest_destination");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.content_script_name = "exfil";
  s.name = "quest_exfil_content_instance_e3";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (1545, 15944, 2032), (0, 0, 0), "exfil_content_instance_quest_e3", "quest_exfil_e3", "quest_exfil");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.name = "quest_exfil_location_e3";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (1293, 16182, 2040), (0, 0, 0), "quest_exfil_e3", "ob_quest_exfil_destination_e3");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (1580, 15208.3, 1033.74), (0, 25, 0), "exfil_content_struct_quest_e3", "exfil_content_instance_quest_e3");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-44051.6, -5993.2, 5661), (0, 1, 0), undefined, "cspf_0_auto18140742514066541192", "exfil_content_struct_quest_e3");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-35259, -5894.9, 5629), (0, 311, 0), "cspf_0_auto18140742514066541192", "cspf_0_auto14028723020407919914");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-26896.8, -2285.8, 4441), (0, 41, 0), "cspf_0_auto14028723020407919914", "cspf_0_auto722790395949215326");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-19934.2, 206.2, 3736), (0, 311, 0), "cspf_0_auto722790395949215326", "cspf_0_auto7075720877336334746");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-12522.9, 4919.8, 3460), (0, 41, 0), "cspf_0_auto7075720877336334746", "cspf_0_auto16451229348982866010");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-6574.4, 10021.8, 3292), (0, 39, 0), "cspf_0_auto16451229348982866010", "cspf_0_auto10869967102940530168");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_lowtown_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (-1105, 14057.3, 3000), (0, 25, 0), "cspf_0_auto10869967102940530168");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_exfil_lowtown_cs");
}