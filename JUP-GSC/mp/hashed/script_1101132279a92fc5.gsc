/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1101132279a92fc5.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-34378, 3743, 969), (0, 190, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-22900, 957, 1241), (0, 100.59, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-23360, 12051, 2083), (0, 126.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-32554, 11895, 960), (0, 280.06, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-32797.8, 12504.2, 1104), (0, 100.7, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-27680, -2264, 1729), (0, 190.9, 2));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_machines_cs");
}