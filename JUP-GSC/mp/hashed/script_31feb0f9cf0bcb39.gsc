/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_31feb0f9cf0bcb39.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-4583, 37234, 1546), (0, 274.2, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (9052.17, 33394.9, 1618.5), (0, 74.72, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-4237.56, 27313.9, 1142.58), (0, 230.3, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (2067.2, 24318.6, 859), (0, 164.8, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (4238, 38437, 1548), (0, 88.42, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (6141, 31227, 1375), (0, 255.49, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-3284, 30015, 1009), (0, 164.88, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-6020, 22222, 1001), (0, 164.88, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (1383, 24586, 1123), (0, 343.59, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (4801, 24077, 972), (0, 180.2, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (11770, 22744, 1012), (0, 258.1, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-6600, 25036, 1154), (0, 74.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (13765, 31385, 1008), (0, 344.79, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (3726, 34544, 1200), (0, 90.09, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-8657, 35378, 1281), (0, 354.42, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.script_modelname = "t10_zm_machine_speed_cola";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-8985, 30918, 1215), (0, 250.12, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_machines_cs");
}