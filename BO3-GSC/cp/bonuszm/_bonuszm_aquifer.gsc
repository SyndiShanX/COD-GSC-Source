/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_aquifer.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_util;
#using scripts\cp\bonuszm\_bonuszm;
#using scripts\cp\bonuszm\_bonuszm_sound;
#using scripts\cp\voice\voice_z_aquifer;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace namespace_f0e08494;

function autoexec init() {
  if(!sessionmodeiscampaignzombiesgame()) {
    return;
  }
  mapname = getdvarstring("mapname");
  if(mapname != "cp_mi_cairo_aquifer") {
    return;
  }
  namespace_f4f2fcc8::init_voice();
  level.bzm_aquiferdialogue1callback = & function_cd2a65c3;
  level.bzm_aquiferdialogue1_1callback = & function_5bdad1f3;
  level.bzm_aquiferdialogue1_2callback = & function_e9d362b8;
  level.bzm_aquiferdialogue1_3callback = & function_fd5dd21;
  level.bzm_aquiferdialogue1_4callback = & function_cde2412e;
  level.bzm_aquiferdialogue1_4_1callback = & function_f2c44c1e;
  level.bzm_aquiferdialogue1_5callback = & function_f3e4bb97;
  level.bzm_aquiferdialogue1_6callback = & function_81dd4c5c;
  level.bzm_aquiferdialogue1_7callback = & function_a7dfc6c5;
  level.bzm_aquiferdialogue2callback = & function_5b22f688;
  level.bzm_aquiferdialogue2_1callback = & function_3b59ac54;
  level.bzm_aquiferdialogue3callback = & function_812570f1;
  level.bzm_aquiferdialogue3_1callback = & function_7aa9c8b5;
  level.bzm_aquiferdialogue4callback = & function_3f31d4fe;
  level.bzm_aquiferdialogue4_1callback = & function_fd9ec2ee;
  level.bzm_aquiferdialogue5callback = & function_65344f67;
  level.bzm_aquiferdialogue6callback = & function_f32ce02c;
  level.bzm_aquiferdialogue7callback = & function_192f5a95;
  level.bzm_aquiferdialogue7_1callback = & function_c8750131;
  function_3a602f83();
}

function private function_3a602f83() {
  callback::on_spawned( & function_89d4327a);
}

function function_89d4327a() {}

function function_cd2a65c3() {
  level endon("bzm_sceneseqended");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_our_target_was_a_cot_0");
}

function function_f3e4bb97() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_this_was_a_routine_s_0");
}

function function_5bdad1f3() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_moved_on_the_arra_0");
}

function function_e9d362b8() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_disabling_the_comms_0");
}

function function_fd5dd21() {
  level endon("bzm_sceneseqended");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_station_disabled_0");
}

function function_cde2412e() {
  level endon("bzm_sceneseqended");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_array_was_ahead_0");
}

function function_f2c44c1e() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_ef0ce9fb("plyz_our_support_detail_n_0");
}

function function_81dd4c5c() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_with_the_comms_disab_0");
}

function function_a7dfc6c5() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_ef0ce9fb("plyz_with_their_comms_jam_0");
}

function function_5b22f688() {
  level endon("bzm_sceneseqended");
  wait(5);
  namespace_36e5bc12::function_cf21d35c("salm_tell_me_what_happene_1");
  namespace_36e5bc12::function_ef0ce9fb("plyz_our_dni_there_was_0");
  namespace_36e5bc12::function_cf21d35c("salm_what_did_you_see_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_i_saw_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_was_drowning_i_th_0");
  wait(2);
  namespace_36e5bc12::function_b4a3e925("dolo_this_is_not_your_tim_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_what_did_you_hear_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_nothing_i_coul_0");
  namespace_36e5bc12::function_b4a3e925("dolo_get_up_0");
  level flag::wait_till("inside_data_center");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_then_i_woke_up_some_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_saved_you_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_a_woman_a_guardian_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_she_said_my_work_was_0");
  namespace_36e5bc12::function_cf21d35c("salm_did_you_know_her_th_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_no_i_d_never_see_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_and_yet_she_knew_abo_0");
  namespace_36e5bc12::function_cf21d35c("salm_you_re_sure_she_was_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_why_do_you_think_i_0");
  namespace_36e5bc12::function_cf21d35c("salm_you_yourself_said_yo_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_what_you_gonna_tell_0");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_did_not_make_her_u_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_did_she_have_a_name_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_of_course_she_had_a_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_guardian_angel_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_she_said_we_had_to_m_0");
  namespace_36e5bc12::function_cf21d35c("salm_plan_b_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_plan_bomb_this_shit_0");
}

function function_3b59ac54() {
  level endon("bzm_sceneseqended");
  wait(4);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_prepped_to_breach_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_explosion_blocke_0");
}

function function_812570f1() {
  level endon("bzm_sceneseqended");
  wait(4);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_regrouped_with_ou_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_what_was_the_plan_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_khalil_would_move_on_0");
}

function function_7aa9c8b5() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_b4a3e925("dolo_go_with_her_trust_h_0");
}

function function_3f31d4fe() {
  level endon("bzm_sceneseqended");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_when_khalil_took_the_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_taylor_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_it_was_like_seeing_a_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_they_were_already_ev_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_who_did_you_go_after_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_command_informed_us_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_how_did_you_feel_abo_1");
  namespace_36e5bc12::function_ef0ce9fb("plyz_five_years_five_y_0");
}

function function_fd9ec2ee() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_ef0ce9fb("plyz_maretti_was_just_bel_0");
  namespace_36e5bc12::function_cf21d35c("salm_shortcut_0");
  namespace_36e5bc12::function_cf21d35c("plyz_a_leap_of_faith_0");
}

function function_65344f67() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_cf21d35c("salm_what_happened_with_h_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_he_was_upset_and_wh_0");
  namespace_36e5bc12::function_cf21d35c("salm_but_that_wasn_t_all_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_no_hendricks_hen_0");
  namespace_36e5bc12::function_cf21d35c("salm_in_what_way_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_in_every_way_aggres_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_how_could_you_have_k_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_listen_doc_if_we_0");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_maretti_had_locked_h_0");
}

function function_f32ce02c() {
  level endon("bzm_sceneseqended");
  wait(2);
  namespace_36e5bc12::function_cf21d35c("salm_what_happened_when_y_1");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_at_the_time_i_couldn_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_it_was_the_second_ti_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_he_kept_saying_this_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_so_i_granted_his_las_0");
}

function function_192f5a95() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_did_what_we_were_t_0");
  namespace_36e5bc12::function_cf21d35c("salm_can_you_blame_him_fo_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_was_pissed_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_what_i_channeled_inw_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_this_was_our_chance_1");
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_said_i_may_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_knocked_some_sense_0");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_sometimes_it_was_the_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_i_told_him_what_mare_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_mention_of_bisho_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_figure_this_shi_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_but_right_then_we_ha_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_egyptian_army_co_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_had_to_get_out_of_0");
}

function function_c8750131() {
  level endon("bzm_sceneseqended");
  wait(15);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_lost_taylor_but_0");
}