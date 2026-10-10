/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2e445b403a12d74d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_bigmap_ob_rift_gate_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_bigmap_ob_rift_gate_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_bigmap_ob_rift_gate_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_bigmap_ob_rift_gate_cs");

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

  s cs_setup_arrays(us, "mp_jup_bigmap_ob_rift_gate_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_bigmap_ob_rift_gate_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  fe[[f]](s, us, cf, (6250, -12231, 1415), (1.9, 285, 1.9), "electric", "s1_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  fe[[f]](s, us, cf, (5851.14, -12232.5, 1432.38), (1.65, 254.99, 3.55), "toxic", "s1_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  fe[[f]](s, us, cf, (5552, -12050, 1465), (0.56, 224.72, 1), "ice", "s1_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  fe[[f]](s, us, cf, (6550, -12048, 1443), (1.1, 314.95, -2.5), "fire", "s1_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  fe[[f]](s, us, cf, (6050, -11446, 1495), (0, 179.4, 0), "s1_rift_gate", undefined, "ob_rift_gate");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  s.script_label = "low";
  fe[[f]](s, us, cf, (5856, -11488, 1548), (0, 0, 90), "s1_rift_token_prompt", "s1_rift_gate", "ob_rift_token_prompt");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  s.script_label = "high";
  fe[[f]](s, us, cf, (6244, -11404, 1548), (0, 180, 90), "s1_rift_token_prompt", "s1_rift_gate", "ob_rift_token_prompt");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  fe[[f]](s, us, cf, (6053, -11503, 1503), (0, 268.5, 0), "s1_rift_encounter", "s1_rift_gate", "ob_rift_encounter");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_rift_gate_cs";
  fe[[f]](s, us, cf, (6051, -11899, 1502), (0, 270, 0), "s1_rift_gate_reward", "s1_rift_gate", "ob_rift_gate_reward");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_bigmap_ob_rift_gate_cs");
}