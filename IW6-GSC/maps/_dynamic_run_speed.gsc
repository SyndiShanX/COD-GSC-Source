/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dynamic_run_speed.gsc
***************************************/

#using_animtree("generic_human");

main(var_0) {
  if(isDefined(var_0)) {
    level.dynamic_run_speed_dialogue = var_0;

    foreach(var_2 in var_0)
    level.scr_radio[var_2] = var_2;
  }

  level.scr_anim["generic"]["DRS_sprint"] = % sprint1_loop;
  level.scr_anim["generic"]["DRS_combat_jog"] = % combat_jog;
  level.scr_anim["generic"]["DRS_run_2_stop"] = % run_2_crouch_f;
  level.scr_anim["generic"]["DRS_stop_idle"][0] = % exposed_crouch_aim_5;
  level.scr_anim["generic"]["signal_go"] = % cqb_stand_wave_go_v1;
  level.drs_ahead_test = maps\_utility_code::dynamic_run_ahead_test;
}