/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_706234467ff54045.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_exfil_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_exfil_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_exfil_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_exfil_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_exfil_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_exfil_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.name = "exfil_content_destination_rural";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (36407, 9685, 1740), (0, 0, 0), "ob_st_f_rural_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (46601.3, 29155.1, 8616), (0, 270, 0), undefined, "cspf_0_auto10965750822533952074", "exfil_content_struct_rural_east_x");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (26859, 701, 2124), (357.4, 290.5, -4.89), "exfil_content_struct_rural_west", "exfil_content_instance_rural_west");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (41562, -7472, 2988), (1.09, 319.59, -0.98), "exfil_content_struct_rural_east", "exfil_content_instance_rural_east");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (41539, -8289, 3457), (0, 0, 0), "exfil_content_instance_rural_east", "exfil_tile_f_rural_location");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (36404, 9005, 1594), (0, 0, 0), "exfil_tile_f_rural_location", "ob_st_f_rural_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (26822, -191, 2509), (0, 0, 0), "exfil_content_instance_rural_west", "exfil_tile_f_rural_location");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.name = "quest_exfil_content_destination_f";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (25516, 9103, 2897), (0, 0, 0), "ob_quest_exfil_destination_f", undefined, "quest_destination");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (40121, 19867, 5550), (0, 270, 0), "cspf_0_auto10965750822533952074", "cspf_0_auto14603906406385873093");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (37037, 8545, 4823), (0, 270, 0), "cspf_0_auto14603906406385873093", "cspf_0_auto17629067927054141135");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (38108, 429, 4772), (0, 270, 0), "cspf_0_auto17629067927054141135", "cspf_0_auto15284366767761695482");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (40272, -5752, 4721), (0, 311.64, 0), "cspf_0_auto15284366767761695482");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (45468.8, 24629.7, 8917), (0, 221, 0), undefined, "cspf_0_auto1605561612560922000", "exfil_content_struct_rural_west");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (44120.1, 18489.1, 8051), (0, 281, 0), "cspf_0_auto1605561612560922000", "cspf_0_auto13314983640605432713");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (45287.8, 14459.9, 7436), (0, 221, 0), "cspf_0_auto13314983640605432713", "cspf_0_auto10707508237355882815");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (43873, 9618.59, 6786), (0, 221, 0), "cspf_0_auto10707508237355882815", "cspf_0_auto8022498153921463783");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (39989.2, 7801.33, 6167), (0, 221, 0), "cspf_0_auto8022498153921463783", "cspf_0_auto5326624477778625392");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (34765.9, 8918.28, 3958), (0, 221, 0), "cspf_0_auto5326624477778625392", "cspf_0_auto3090631084245555859");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (30446.4, 8130.32, 3907), (0, 221, 0), "cspf_0_auto3090631084245555859", "cspf_0_auto10595340800207326816");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (26970.2, 4123.03, 3374), (0, 221, 0), "cspf_0_auto10595340800207326816");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.name = "quest_exfil_location_f";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (25502, 8392, 3272.83), (0, 0, 0), "quest_exfil_f", "ob_quest_exfil_destination_f");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.name = "quest_exfil_content_instance_f";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (23727, 8393, 3318.95), (0, 314.57, 0), "exfil_content_instance_quest_f", "quest_exfil_f", "quest_exfil");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (21944, 9372.2, 1674.3), (0, 291, 0), "exfil_content_struct_quest_f", "exfil_content_instance_quest_f");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (47676.1, 39266.6, 9139), (0, 221, 0), undefined, "cspf_0_auto2609890710391794286", "exfil_content_struct_quest_f");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (34049.4, 34066.1, 8051), (0, 221, 0), "cspf_0_auto2609890710391794286", "cspf_0_auto5959003048397189601");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (27402.1, 30695.8, 7436), (0, 221, 0), "cspf_0_auto5959003048397189601", "cspf_0_auto9082695559636412093");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (22934.3, 25717.5, 6093), (0, 221, 0), "cspf_0_auto9082695559636412093", "cspf_0_auto10410803106715820231");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (20461.5, 17893.2, 4848), (0, 221, 0), "cspf_0_auto10410803106715820231", "cspf_0_auto15780112461190099433");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (48717.1, 22349.6, 9139), (0, 221, 0), undefined, "cspf_0_auto16504301922310580396", "exfil_content_struct_quest_f2");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.name = "quest_exfil_content_destination_f2";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (20553, -5999, 2897), (0, 0, 0), "ob_quest_exfil_destination_f2", undefined, "quest_destination");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (21310.7, 11219.2, 3000), (0, 291, 0), "cspf_0_auto15780112461190099433");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.name = "quest_exfil_location_f2";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (20539, -6710, 3272.83), (0, 0, 0), "quest_exfil_f2", "ob_quest_exfil_destination_f2");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.name = "quest_exfil_content_instance_f2";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (21382, -6910, 3318.95), (0, 314.57, 0), "exfil_content_instance_quest_f2", "quest_exfil_f2", "quest_exfil");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.script_parameters = "b_disabled";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (22234.7, -6537.8, 2275.74), (0, 271, 0), "exfil_content_struct_quest_f2", "exfil_content_instance_quest_f2");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (35090.4, 17149.1, 8051), (0, 221, 0), "cspf_0_auto16504301922310580396", "cspf_0_auto10268608891028420541");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (28443.1, 13778.8, 7436), (0, 221, 0), "cspf_0_auto10268608891028420541", "cspf_0_auto3375302172264922219");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (23975.3, 8800.5, 6093), (0, 221, 0), "cspf_0_auto3375302172264922219", "cspf_0_auto9434646737470545905");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (21502.5, 976.2, 4848), (0, 221, 0), "cspf_0_auto9434646737470545905", "cspf_0_auto12553808424222430034");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (22338.7, -4910.8, 4000), (0, 271, 0), "cspf_0_auto12553808424222430034");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_exfil_cs");
}