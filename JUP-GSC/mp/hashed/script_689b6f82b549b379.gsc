/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_689b6f82b549b379.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (41406, -26536, 3243), (359.94, 180.01, -0.08));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (38066, -18859, 3040), (0, 156.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (26419, -39866, 3118), (0.32, 38.06, -0.01));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (22404.5, -17817, 2915), (0, 314.6, 0), undefined, undefined, "in_gas_station");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (19205, -23068, 2734), (357.2, 339.81, 0.72));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (29219, -27661, 3228), (0, 328.06, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (42997, -29001, 3123), (0, 105.09, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "perk_machine_choice_spawn";
  s.name = "perk_wunderfizz";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (22728, -21545, 2882), (0, 106.97, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (26944, -34152, 3500), (0, 203.56, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (32315, -34983, 3056), (0, 202.01, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_machines_cs");
}