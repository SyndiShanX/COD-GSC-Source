/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_52aee4f1767a29b9.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (31866.2, -8947.4, 3169.06), (0, 287.98, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (32258.7, 11353.1, 2061.74), (0, 228.68, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (41854.6, 6001.54, 2967.06), (0, 242.78, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (34351, 9567, 2224), (0, 215.38, 0), undefined, undefined, "in_gas_station");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (41331, 12379, 3077), (0, 120.48, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (27861, 698, 2082), (0, 235.08, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (45621.5, -2850, 3091), (0, 354.98, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (32688, -12287, 2937), (0, 13.68, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (33227.3, 2821.95, 2401), (0, 206.18, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "perk_machine_choice_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (29536, 5878, 2228), (0, 94, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_machines_cs";
  s.content_key = "perk_machine_choice_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (42206, -4076, 3128), (0, 270, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_machines_cs");
}