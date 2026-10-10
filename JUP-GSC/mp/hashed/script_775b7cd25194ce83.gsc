/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_775b7cd25194ce83.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_s5_attunement_diary_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_s5_attunement_diary_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_s5_attunement_diary_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_s5_attunement_diary_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_s5_attunement_diary_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_s5_attunement_diary_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_starter";
  fe[[f]](s, us, cf, (-21507.5, 30242.7, 2317.18), (19.2, 35.88, 32.72), "s5_attunement_diary_starter", undefined, "s5_attunement_diary_starter");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_entrance_fail";
  fe[[f]](s, us, cf, (5552.65, 23654.9, 949.98), (0, 325.64, 0), "s5_attunement_diary_jump_aethertear_entrance_fail", undefined, "s5_attunement_diary_jump_aethertear_entrance_fail");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_perk_spawn";
  fe[[f]](s, us, cf, (-21507.5, 30242.7, 2327.18), (0, 155.87, 0), "s5_attunement_diary_perk_spawn", undefined, "s5_attunement_diary_perk_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_setdressing_zombie";
  fe[[f]](s, us, cf, (-21496.8, 30210.3, 2288.42), (322.77, 347, -9.12), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", undefined, "zombie_setdressing_sat1");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (130, 50, 32);
  s.var_74e936bbadd15418 = (128, 46, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_attunement_diary_jump_target_trigger";
  s.width = "128";
  fe[[f]](s, us, cf, (6421.14, 23323, 1129.96), (0, 347, 0), "s5_attunement_diary_jump_target_trigger", undefined, "s5_attunement_diary_jump_target_trigger");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_exit_1";
  fe[[f]](s, us, cf, (4717.03, 24752.9, 3804.01), (0, 22, 0), "s5_attunement_diary_jump_aethertear_exit_1", undefined, "s5_attunement_diary_jump_aethertear_exit_1");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_entrance";
  fe[[f]](s, us, cf, (-21828.9, 30399.5, 2224.68), (0, 154, 0), "s5_attunement_diary_jump_aethertear_entrance", undefined, "s5_attunement_diary_jump_aethertear_entrance");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_exit_2";
  fe[[f]](s, us, cf, (4753.45, 24761.8, 3803.67), (0, 22, 0), "s5_attunement_diary_jump_aethertear_exit_2", undefined, "s5_attunement_diary_jump_aethertear_exit_2");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_exit_3";
  fe[[f]](s, us, cf, (4789.25, 24769.5, 3803.71), (0, 22, 0), "s5_attunement_diary_jump_aethertear_exit_3", undefined, "s5_attunement_diary_jump_aethertear_exit_3");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_exit_4";
  fe[[f]](s, us, cf, (4827.43, 24774.8, 3803.73), (0, 22, 0), "s5_attunement_diary_jump_aethertear_exit_4", undefined, "s5_attunement_diary_jump_aethertear_exit_4");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_exit_6";
  fe[[f]](s, us, cf, (4907.34, 24781.3, 3803.03), (0, 22, 0), "s5_attunement_diary_jump_aethertear_exit_6", undefined, "s5_attunement_diary_jump_aethertear_exit_6");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_s5_attunement_diary_cs";
  s.name = "s5_attunement_diary_jump_aethertear_exit_5";
  fe[[f]](s, us, cf, (4867.5, 24779.6, 3803.06), (0, 22, 0), "s5_attunement_diary_jump_aethertear_exit_5", undefined, "s5_attunement_diary_jump_aethertear_exit_5");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_s5_attunement_diary_cs");
}