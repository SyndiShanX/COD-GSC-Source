/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_614e5dfbd86f263d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (8820, -20443, 1717), (0.1, 78.09, 0), undefined, undefined, "in_gas_station", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (13703, -35505, 2736), (0.1, 108.34, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (16445, -32976, 2752), (0, 30.98, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (1940, -41424, 2889), (0.23, 182.88, 0.04), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (2368, -32559, 1915), (0.09, 106.89, -0.22), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_choice_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (7401, -17088, 1714), (0, 254.46, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (4064, -25293, 1745), (0.09, 254.9, -0.22), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (2108.13, -32168.4, 1913), (0, 107.22, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (3476.25, -23602.7, 1520), (0, 165.42, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (884.57, -36992.4, 2146.5), (0, 105.02, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_machines_cs");
}