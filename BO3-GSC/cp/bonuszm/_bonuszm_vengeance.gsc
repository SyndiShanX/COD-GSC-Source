/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_vengeance.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_util;
#using scripts\cp\bonuszm\_bonuszm;
#using scripts\cp\bonuszm\_bonuszm_sound;
#using scripts\cp\voice\voice_z_vengeance;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace namespace_7c492a31;

function autoexec init() {
  if(!sessionmodeiscampaignzombiesgame()) {
    return;
  }
  mapname = getdvarstring("mapname");
  if(mapname != "cp_mi_sing_vengeance") {
    return;
  }
  namespace_10893d25::init_voice();
  level.bzm_vengeancedialogue1callback = &function_f3907da8;
  level.bzm_vengeancedialogue2callback = &function_6597ece3;
  level.bzm_vengeancedialogue2_1callback = &function_ed743e53;
  level.bzm_vengeancedialogue3callback = &function_3f95727a;
  level.bzm_vengeancedialogue3_1callback = &function_ae2421f2;
  level.bzm_vengeancedialogue4callback = &function_b19ce1b5;
  level.bzm_vengeancedialogue5callback = &function_8b9a674c;
  level.bzm_vengeancedialogue6callback = &function_fda1d687;
  level.bzm_vengeancedialogue6_1callback = &function_3c7cab4f;
  level.bzm_vengeancedialogue6_2callback = &function_ca753c14;
  level.bzm_vengeancedialogue7callback = &function_d79f5c1e;
  level.bzm_vengeancedialogue7_1callback = &function_75eb7a4e;
  level.bzm_vengeancedialogue8callback = &function_e97f24c9;
  level.bzm_vengeancedialogue9callback = &function_c37caa60;
  function_1c8c2a72();
}

function private function_1c8c2a72() {
  callback::on_spawned(&function_2aefb731);
}

function function_2aefb731() {}

function function_f3907da8() {
  level endon("bzm_sceneseqended");
  wait(8);
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_vultures_sadist_0");
  wait(4);
  namespace_36e5bc12::function_cf21d35c("salm_when_forced_against_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_this_was_more_than_i_0");
}

function function_6597ece3() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_had_a_bad_feeling_0");
}

function function_ed743e53() {
  level endon("bzm_sceneseqended");
  wait(5);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_vultures_of_sing_0");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_need_to_take_th_0");
}

function function_3f95727a() {
  level endon("bzm_sceneseqended");
  wait(5);
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_took_point_0");
}

function function_ae2421f2() {
  level endon("bzm_sceneseqended");
  level flag::wait_till("start_hendricks_open_alley_door_01");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_overwatch_confirmed_0");
}

function function_b19ce1b5() {
  level endon("bzm_sceneseqended");
  wait(14);
  namespace_36e5bc12::function_cf21d35c("salm_curious_the_vultu_0");
  wait(4);
  namespace_36e5bc12::function_ef0ce9fb("plyz_don_t_think_of_them_0");
}

function function_8b9a674c() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_scavengers_began_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_safehouse_was_be_0");
}

function function_fda1d687() {
  level endon("bzm_sceneseqended");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_vultures_ahead_had_a_0");
}

function function_3c7cab4f() {
  level endon("bzm_sceneseqended");
  wait(12);
  namespace_36e5bc12::function_cf21d35c("salm_what_was_the_purpose_0");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_territorial_vulture_0");
}

function function_ca753c14() {
  level endon("bzm_sceneseqended");
  wait(6);
  namespace_36e5bc12::function_ef0ce9fb("plyz_a_malfunctioning_a_s_0");
}

function function_d79f5c1e() {
  level endon("bzm_sceneseqended");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_vultures_beat_us_0");
}

function function_75eb7a4e() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_cleared_the_plaza_0");
  wait(10);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_blast_knocked_us_0");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_didn_t_thi_0");
  namespace_36e5bc12::function_cf21d35c("salm_but_you_pushed_back_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_needed_that_dossi_0");
}

function function_e97f24c9() {
  level endon("bzm_sceneseqended");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_who_did_you_find_in_0");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_her_our_guardian_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_had_no_idea_what_s_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_goh_xiulan_we_later_0");
  wait(1);
  namespace_36e5bc12::function_b4a3e925("dolo_do_it_kill_her_kil_0");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("salm_did_you_kill_her_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_struggled_pani_0");
}

function function_c37caa60() {
  level endon("bzm_sceneseqended");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_and_the_file_on_deim_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_most_likely_it_was_r_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_got_our_tr_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_but_we_needed_a_few_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_truth_proved_mor_0");
}