/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_sgen.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_util;
#using scripts\cp\bonuszm\_bonuszm;
#using scripts\cp\bonuszm\_bonuszm_sound;
#using scripts\cp\voice\voice_z_hypocenter;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace namespace_fc7d2b5e;

function autoexec init() {
  if(!sessionmodeiscampaignzombiesgame()) {
    return;
  }
  mapname = getdvarstring("mapname");
  if(mapname == "cp_mi_sing_sgen") {
    namespace_e15266b8::init_voice();
    level.bzm_sgendialogue1callback = &function_1304b9f1;
    level.bzm_sgendialogue1_1callback = &function_4a08b9b5;
    level.bzm_sgendialogue1_2callback = &function_700b341e;
    level.bzm_sgendialogue1_3callback = &function_960dae87;
    level flag::init("BZM_SGENDialogue1_3");
    level.bzm_sgendialogue1_3callback_waittill_done = &function_1dfa8915;
    level.bzm_sgendialogue2callback = &function_3907345a;
    level.bzm_sgendialogue2_1callback = &function_7752cc92;
    level.bzm_sgendialogue3callback = &function_5f09aec3;
    level.bzm_sgendialogue4callback = &function_850c292c;
    level.bzm_sgendialogue4_1callback = &function_1230a890;
    level.bzm_sgendialogue5callback = &function_ab0ea395;
    level.bzm_sgendialogue6callback = &function_d1111dfe;
    level.bzm_sgendialogue7callback = &function_f7139867;
    level.bzm_sgendialogue8callback = &function_bcee6c40;
    level.bzm_sgendialogue8_1callback = &function_549842dc;
    level.bzm_sgendialogue8_2callback = &function_c69fb217;
    level.bzm_sgendialogue9callback = &function_e2f0e6a9;
  }
}

function function_1304b9f1() {
  level endon("bzm_sceneseqended");
  wait(6);
  namespace_36e5bc12::function_ef0ce9fb("plyz_it_started_at_coales_0");
}

function function_4a08b9b5() {
  wait(2);
  level endon("bzm_sceneseqended");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_lost_comms_with_0");
  wait(11);
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_was_on_edg_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_undead_weren_t_o_0");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_either_way_our_trou_0");
}

function function_700b341e() {
  level endon("bzm_sceneseqended");
  wait(8);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_should_ve_known_t_0");
  wait(2);
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_had_a_bad_0");
}

function function_960dae87() {
  level endon("bzm_sceneseqended");
  wait(5);
  namespace_36e5bc12::function_ef0ce9fb("plyz_coalescence_enhanc_0");
  wait(2);
  namespace_36e5bc12::function_cf21d35c("salm_what_happened_what_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_coalescence_disa_0");
  level flag::set("BZM_SGENDialogue1_3");
}

function function_1dfa8915() {
  level flag::wait_till("BZM_SGENDialogue1_3");
}

function function_3907345a() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_cf21d35c("salm_what_was_so_special_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_nothing_it_was_supp_0");
  level flag::wait_till("data_recovered");
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_located_an_emf_so_0");
}

function function_7752cc92() {
  level endon("bzm_sceneseqended");
  wait(6);
  namespace_36e5bc12::function_ef0ce9fb("plyz_our_drone_picked_up_0");
}

function function_5f09aec3() {
  level endon("bzm_sceneseqended");
  wait(6);
  namespace_36e5bc12::function_ef0ce9fb("plyz_when_man_fled_the_vi_0");
}

function function_850c292c() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_reached_the_sil_0");
}

function function_1230a890() {
  level endon("bzm_sceneseqended");
  wait(5);
  namespace_36e5bc12::function_cf21d35c("salm_did_you_have_any_ink_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_no_in_hindsight_i_0");
}

function function_ab0ea395() {
  level endon("bzm_sceneseqended");
  namespace_36e5bc12::function_cf21d35c("salm_what_did_you_find_be_0");
  wait(0.5);
  namespace_36e5bc12::function_ef0ce9fb("plyz_a_cia_black_project_0");
  namespace_36e5bc12::function_cf21d35c("salm_why_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_it_would_have_bee_0");
  namespace_36e5bc12::function_cf21d35c("salm_is_it_such_a_bad_thi_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_didn_t_have_a_cho_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_those_who_find_fate_0");
}

function function_d1111dfe() {
  level endon("bzm_sceneseqended");
  wait(4);
  namespace_36e5bc12::function_cf21d35c("salm_the_human_testing_la_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_found_the_trut_0");
  namespace_36e5bc12::function_cf21d35c("salm_you_re_certain_of_th_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_didn_t_have_the_f_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_when_the_explosion_h_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_what_do_you_mean_ch_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_winslow_accord_a_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_61_15_changed_that_0");
  wait(0.5);
  namespace_36e5bc12::function_ef0ce9fb("plyz_you_re_both_human_a_0");
  wait(0.5);
  namespace_36e5bc12::function_cf21d35c("salm_did_you_find_taylor_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_no_but_they_d_come_0");
}

function function_f7139867() {
  level endon("bzm_sceneseqended");
  wait(2.5);
  namespace_36e5bc12::function_cf21d35c("salm_did_you_know_what_yo_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_couldn_t_have_kno_0");
}

function function_bcee6c40() {
  level endon("bzm_sceneseqended");
  wait(17);
  namespace_36e5bc12::function_cf21d35c("salm_you_killed_him_0");
  wait(0.5);
  namespace_36e5bc12::function_ef0ce9fb("plyz_he_left_us_no_choice_0");
  wait(2);
  namespace_36e5bc12::function_cf21d35c("salm_you_needed_to_find_o_0");
  wait(3);
  namespace_36e5bc12::function_ef0ce9fb("plyz_accessing_diaz_s_tho_0");
  wait(4);
  namespace_36e5bc12::function_cf21d35c("salm_knowing_what_you_kno_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_that_didn_t_matter_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_from_the_interface_0");
  wait(1);
  namespace_36e5bc12::function_cf21d35c("salm_tell_me_about_the_na_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_name_deimos_th_0");
}

function function_549842dc() {
  level endon("bzm_sceneseqended");
  wait(16);
  namespace_36e5bc12::function_ef0ce9fb("plyz_goh_xiulan_leader_o_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_the_immortals_had_wo_0");
  wait(1);
  namespace_36e5bc12::function_ef0ce9fb("plyz_they_blew_the_suppor_0");
}

function function_c69fb217() {
  level endon("bzm_sceneseqended");
  wait(10);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_needed_to_get_out_0");
}

function function_e2f0e6a9() {
  wait(13);
  namespace_36e5bc12::function_cf21d35c("salm_and_and_what_hap_0");
  wait(0.5);
  namespace_36e5bc12::function_ef0ce9fb("plyz_we_got_through_it_w_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_learned_ta_0");
  namespace_36e5bc12::function_ef0ce9fb("plyz_but_that_was_the_beg_0");
}