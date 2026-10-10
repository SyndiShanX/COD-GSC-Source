/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_10c0558c277bd286.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_interactions_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_interactions_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_interactions_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_interactions_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_interactions_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_interactions_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-37107.6, -19349.2, 264), (0.06, 126.99, 0.08));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-35202, -15073.2, 264), (0.09, 127.24, 0.03));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-27943.7, -24098.5, 264), (0, 268.77, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-25720, -22425, 352), (0.03, 88.38, -0.23));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-26723.2, -24508.1, 272), (0.02, 89.19, -0.24));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_choice_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-34964, -26658, 258), (0, 289.15, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-37051.9, -26925.5, 304), (0.21, 296.3, -0.1));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-24894.7, -16022.4, 352), (0, 0.82, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-45602.1, -20230.8, 256), (0, 62, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-36782.2, -22491.6, 704), (0, 25.02, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_interactions_machines_cs");
}