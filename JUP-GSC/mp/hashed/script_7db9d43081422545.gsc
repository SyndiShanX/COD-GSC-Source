/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7db9d43081422545.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (33269.1, 28149.9, 1895), (0, 331.52, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (43366, 33070, 2576), (0, 195.12, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (25103.8, 23319, 1519), (0, 269.6, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (29486.2, 40989.3, 1384), (0, 328.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (32091, 34759, 1193), (0, 240.4, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (42249, 29661, 1764), (0, 125.49, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (32394, 23434, 1560), (0, 180, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (25200, 20847, 1356), (0, 270, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (37612, 19035, 3340), (0, 36.79, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (26808, 27802, 1357), (0, 180.67, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (24355, 31704, 1544), (0, 59.78, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (31953, 28990, 1343), (0, 150.31, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (36490, 31757, 1767), (0, 150.78, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (31569, 40670, 928), (0, 60.11, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (21965, 27956, 1357), (0, 1.57, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_machines_cs");
}