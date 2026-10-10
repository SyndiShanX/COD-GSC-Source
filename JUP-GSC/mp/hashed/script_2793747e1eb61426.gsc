/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2793747e1eb61426.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_bigmap_ob_s3_rift_gate_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_bigmap_ob_s3_rift_gate_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_bigmap_ob_s3_rift_gate_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_bigmap_ob_s3_rift_gate_cs");

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

  s cs_setup_arrays(us, "mp_jup_bigmap_ob_s3_rift_gate_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_bigmap_ob_s3_rift_gate_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  fe[[f]](s, us, cf, (-2740.54, 3073.63, 2011.29), (0, 90, 0), "ob_s3_story_mission_portal", undefined, "ob_s3_story_mission_portal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 4600;
  s.name = "SM_VO_trigger_approach";
  fe[[f]](s, us, cf, (-2740.54, 3073.63, 423.25), (0, 0, 0), "SM_VO_trigger_approach", undefined, "SM_VO_trigger_approach", undefined, undefined, undefined, undefined, 13900, undefined, 512);
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 3000;
  s.name = "SM_VO_trigger_arrive";
  fe[[f]](s, us, cf, (-2740.54, 3073.63, 2011.29), (0, 0, 0), "SM_VO_trigger_arrive", undefined, "SM_VO_trigger_arrive", undefined, undefined, undefined, undefined, 6000, undefined, 512);
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  fe[[f]](s, us, cf, (-1680.97, 3511.76, 2014.19), (1.24, 45, 2.38), "giraffe", "s3_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  fe[[f]](s, us, cf, (-1671.37, 2640.59, 2013.82), (3.67, 315, 1.36), "crayon", "s3_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  fe[[f]](s, us, cf, (-2546.48, 2639.6, 2015.34), (0.84, 225, -0.78), "laptop", "s3_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  fe[[f]](s, us, cf, (-2554.88, 3518.46, 2013.3), (2.71, 135, 0.35), "journal", "s3_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  s.name = "s3_rift_gate";
  fe[[f]](s, us, cf, (-1238.79, 3073.63, 2011.29), (0, 90, 0), "s3_rift_gate", undefined, "s3_rift_gate");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  s.script_label = "high";
  fe[[f]](s, us, cf, (-1195.18, 2879, 2063.74), (0, 270, 270), "s3_rift_token_prompt", "s3_rift_gate", "ob_rift_token_prompt");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  s.script_label = "low";
  fe[[f]](s, us, cf, (-1282.67, 3268.13, 2064.32), (0, 270, 90), "s3_rift_token_prompt", "s3_rift_gate", "ob_rift_token_prompt");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  fe[[f]](s, us, cf, (-1291.04, 3073.63, 2012), (0, 180, 0), "s3_rift_encounter", "s3_rift_gate", "ob_rift_encounter");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_rift_gate_cs";
  fe[[f]](s, us, cf, (-1717.42, 3075.89, 2012), (0, 180, 0), "s3_rift_gate_reward", "s3_rift_gate", "ob_rift_gate_reward");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_bigmap_ob_s3_rift_gate_cs");
}