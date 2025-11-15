/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\s1_common_anims.gsc
*******************************************/

#using_animtree("generic_human");

initsoliders1entrance() {
  var_0 = [];
  var_0["stand"][1] = % s1_coverstand_trans_in_ml;
  var_0["stand"][2] = % s1_coverstand_trans_in_m;
  var_0["stand"][3] = % s1_coverstand_trans_in_mr;
  var_0["stand"][4] = % s1_coverstand_trans_in_l;
  var_0["stand"][6] = % s1_coverstand_trans_in_r;
  var_0["right"][1] = % s1_corner_standr_trans_in_1;
  var_0["right"][2] = % s1_corner_standr_trans_in_2;
  var_0["right"][3] = % s1_corner_standr_trans_in_3;
  var_0["right"][4] = % s1_corner_standr_trans_in_4;
  var_0["right"][6] = % s1_corner_standr_trans_in_6;
  var_0["right"][8] = % s1_corner_standr_trans_in_8;
  var_0["right"][9] = % s1_corner_standr_trans_in_9;
  var_0["right_cqb"][1] = % s1_corner_standr_trans_cqb_in_1;
  var_0["right_cqb"][2] = % s1_corner_standr_trans_cqb_in_2;
  var_0["right_cqb"][3] = % s1_corner_standr_trans_cqb_in_3;
  var_0["right_cqb"][4] = % s1_corner_standr_trans_cqb_in_4;
  var_0["right_cqb"][6] = % s1_corner_standr_trans_cqb_in_6;
  var_0["right_cqb"][8] = % s1_corner_standr_trans_cqb_in_8;
  var_0["right_cqb"][9] = % s1_corner_standr_trans_cqb_in_9;
  var_0["right_crouch"][1] = % s1_cornercrr_trans_in_ml;
  var_0["right_crouch"][2] = % s1_cornercrr_trans_in_m;
  var_0["right_crouch"][3] = % s1_cornercrr_trans_in_mr;
  var_0["right_crouch"][4] = % s1_cornercrr_trans_in_l;
  var_0["right_crouch"][6] = % s1_cornercrr_trans_in_r;
  var_0["right_crouch"][8] = % s1_cornercrr_trans_in_f;
  var_0["right_crouch"][9] = % s1_cornercrr_trans_in_mf;
  var_0["right_crouch_cqb"][1] = % s1_cornercrr_cqb_trans_in_1;
  var_0["right_crouch_cqb"][2] = % s1_cornercrr_cqb_trans_in_2;
  var_0["right_crouch_cqb"][3] = % s1_cornercrr_cqb_trans_in_3;
  var_0["right_crouch_cqb"][4] = % s1_cornercrr_cqb_trans_in_4;
  var_0["right_crouch_cqb"][6] = % s1_cornercrr_cqb_trans_in_6;
  var_0["right_crouch_cqb"][8] = % s1_cornercrr_cqb_trans_in_8;
  var_0["right_crouch_cqb"][9] = % s1_cornercrr_cqb_trans_in_9;
  var_0["left"][1] = % s1_corner_standl_trans_in_1;
  var_0["left"][2] = % s1_corner_standl_trans_in_2;
  var_0["left"][3] = % s1_corner_standl_trans_in_3;
  var_0["left"][4] = % s1_corner_standl_trans_in_4;
  var_0["left"][6] = % s1_corner_standl_trans_in_6;
  var_0["left"][7] = % s1_corner_standl_trans_in_7;
  var_0["left"][8] = % s1_corner_standl_trans_in_8;
  var_0["left_cqb"][1] = % s1_corner_standl_trans_cqb_in_1;
  var_0["left_cqb"][2] = % s1_corner_standl_trans_cqb_in_2;
  var_0["left_cqb"][3] = % s1_corner_standl_trans_cqb_in_3;
  var_0["left_cqb"][4] = % s1_corner_standl_trans_cqb_in_4;
  var_0["left_cqb"][6] = % s1_corner_standl_trans_cqb_in_6;
  var_0["left_cqb"][7] = % s1_corner_standl_trans_cqb_in_7;
  var_0["left_cqb"][8] = % s1_corner_standl_trans_cqb_in_8;
  var_0["left_crouch_cqb"][1] = % s1_cornercrl_cqb_trans_in_1;
  var_0["left_crouch_cqb"][2] = % s1_cornercrl_cqb_trans_in_2;
  var_0["left_crouch_cqb"][3] = % s1_cornercrl_cqb_trans_in_3;
  var_0["left_crouch_cqb"][4] = % s1_cornercrl_cqb_trans_in_4;
  var_0["left_crouch_cqb"][6] = % s1_cornercrl_cqb_trans_in_6;
  var_0["left_crouch_cqb"][7] = % s1_cornercrl_cqb_trans_in_7;
  var_0["left_crouch_cqb"][8] = % s1_cornercrl_cqb_trans_in_8;
  var_0["left_crouch"][1] = % s1_cornercrl_trans_in_ml;
  var_0["left_crouch"][2] = % s1_cornercrl_trans_in_m;
  var_0["left_crouch"][3] = % s1_cornercrl_trans_in_mr;
  var_0["left_crouch"][4] = % s1_cornercrl_trans_in_l;
  var_0["left_crouch"][6] = % s1_cornercrl_trans_in_r;
  var_0["left_crouch"][7] = % s1_cornercrl_trans_in_mf;
  var_0["left_crouch"][8] = % s1_cornercrl_trans_in_f;
  var_0["left_crouch_cqb"][1] = % s1_cornercrl_cqb_trans_in_1;
  var_0["left_crouch_cqb"][2] = % s1_cornercrl_cqb_trans_in_2;
  var_0["left_crouch_cqb"][3] = % s1_cornercrl_cqb_trans_in_3;
  var_0["left_crouch_cqb"][4] = % s1_cornercrl_cqb_trans_in_4;
  var_0["left_crouch_cqb"][6] = % s1_cornercrl_cqb_trans_in_6;
  var_0["left_crouch_cqb"][7] = % s1_cornercrl_cqb_trans_in_7;
  var_0["left_crouch_cqb"][8] = % s1_cornercrl_cqb_trans_in_8;
  var_0["exposed"][1] = % s1_run_2_idle_1;
  var_0["exposed"][2] = % s1_run_2_stand_f_6;
  var_0["exposed"][3] = % s1_run_2_idle_3;
  var_0["exposed"][4] = % s1_run_2_stand_90l;
  var_0["exposed"][6] = % s1_run_2_stand_90r;
  var_0["exposed"][7] = % s1_run_2_idle_7;
  var_0["exposed"][8] = % s1_run_2_stand_180l;
  var_0["exposed"][9] = % s1_run_2_idle_9;
  var_0["exposed_cqb"][1] = % cqb_stop_1;
  var_0["exposed_cqb"][2] = % cqb_stop_2;
  var_0["exposed_cqb"][3] = % cqb_stop_3;
  var_0["exposed_cqb"][4] = % cqb_stop_4;
  var_0["exposed_cqb"][6] = % cqb_stop_6;
  var_0["exposed_cqb"][7] = % cqb_stop_7;
  var_0["exposed_cqb"][8] = % cqb_stop_8;
  var_0["exposed_cqb"][9] = % cqb_stop_9;
  var_0["exposed_crouch"][1] = % s1_cqb_crouch_stop_1;
  var_0["exposed_crouch"][2] = % s1_cqb_crouch_stop_2;
  var_0["exposed_crouch"][3] = % s1_cqb_crouch_stop_3;
  var_0["exposed_crouch"][4] = % s1_cqb_crouch_stop_4;
  var_0["exposed_crouch"][6] = % s1_cqb_crouch_stop_6;
  var_0["exposed_crouch"][7] = % s1_cqb_crouch_stop_7;
  var_0["exposed_crouch"][8] = % s1_cqb_crouch_stop_8;
  var_0["exposed_crouch"][9] = % s1_cqb_crouch_stop_9;
  var_0["exposed_crouch_cqb"][1] = % s1_cqb_crouch_stop_1;
  var_0["exposed_crouch_cqb"][2] = % s1_cqb_crouch_stop_2;
  var_0["exposed_crouch_cqb"][3] = % s1_cqb_crouch_stop_3;
  var_0["exposed_crouch_cqb"][4] = % s1_cqb_crouch_stop_4;
  var_0["exposed_crouch_cqb"][6] = % s1_cqb_crouch_stop_6;
  var_0["exposed_crouch_cqb"][7] = % s1_cqb_crouch_stop_7;
  var_0["exposed_crouch_cqb"][8] = % s1_cqb_crouch_stop_8;
  var_0["exposed_crouch_cqb"][9] = % s1_cqb_crouch_stop_9;
  var_0["crouch"][1] = % s1_covercrouch_run_in_ml;
  var_0["crouch"][2] = % s1_covercrouch_run_in_m;
  var_0["crouch"][3] = % s1_covercrouch_run_in_mr;
  var_0["crouch"][4] = % s1_covercrouch_run_in_l;
  var_0["crouch"][6] = % s1_covercrouch_run_in_r;
  anim.archetypes["s1_soldier"]["cover_trans"] = var_0;
}

initsoliders1exit() {
  var_0 = [];
  var_0["right"][1] = % s1_corner_standr_trans_out_1;
  var_0["right"][2] = % s1_corner_standr_trans_out_2;
  var_0["right"][3] = % s1_corner_standr_trans_out_3;
  var_0["right"][4] = % s1_corner_standr_trans_out_4;
  var_0["right"][6] = % s1_corner_standr_trans_out_6;
  var_0["right"][8] = % s1_corner_standr_trans_out_8;
  var_0["right"][9] = % s1_corner_standr_trans_out_9;
  var_0["right_cqb"][1] = % s1_corner_standr_trans_cqb_out_1;
  var_0["right_cqb"][2] = % s1_corner_standr_trans_cqb_out_2;
  var_0["right_cqb"][3] = % s1_corner_standr_trans_cqb_out_3;
  var_0["right_cqb"][4] = % s1_corner_standr_trans_cqb_out_4;
  var_0["right_cqb"][6] = % s1_corner_standr_trans_cqb_out_6;
  var_0["right_cqb"][8] = % s1_corner_standr_trans_cqb_out_8;
  var_0["right_cqb"][9] = % s1_corner_standr_trans_cqb_out_9;
  var_0["right_crouch"][1] = % s1_cornercrr_trans_out_ml;
  var_0["right_crouch"][2] = % s1_cornercrr_trans_out_m;
  var_0["right_crouch"][3] = % s1_cornercrr_trans_out_mr;
  var_0["right_crouch"][4] = % s1_cornercrr_trans_out_l;
  var_0["right_crouch"][6] = % s1_cornercrr_trans_out_r;
  var_0["right_crouch"][8] = % s1_cornercrr_trans_out_f;
  var_0["right_crouch"][9] = % s1_cornercrr_trans_out_mf;
  var_0["right_crouch_cqb"][1] = % s1_cornercrr_cqb_trans_out_1;
  var_0["right_crouch_cqb"][2] = % s1_cornercrr_cqb_trans_out_2;
  var_0["right_crouch_cqb"][3] = % s1_cornercrr_cqb_trans_out_3;
  var_0["right_crouch_cqb"][4] = % s1_cornercrr_cqb_trans_out_4;
  var_0["right_crouch_cqb"][6] = % s1_cornercrr_cqb_trans_out_6;
  var_0["right_crouch_cqb"][8] = % s1_cornercrr_cqb_trans_out_8;
  var_0["right_crouch_cqb"][9] = % s1_cornercrr_cqb_trans_out_9;
  var_0["left"][1] = % s1_corner_standl_trans_out_1;
  var_0["left"][2] = % s1_corner_standl_trans_out_2;
  var_0["left"][3] = % s1_corner_standl_trans_out_3;
  var_0["left"][4] = % s1_corner_standl_trans_out_4;
  var_0["left"][6] = % s1_corner_standl_trans_out_6;
  var_0["left"][7] = % s1_corner_standl_trans_out_7;
  var_0["left"][8] = % s1_corner_standl_trans_out_8;
  var_0["left_cqb"][1] = % s1_corner_standl_trans_cqb_out_1;
  var_0["left_cqb"][2] = % s1_corner_standl_trans_cqb_out_2;
  var_0["left_cqb"][3] = % s1_corner_standl_trans_cqb_out_3;
  var_0["left_cqb"][4] = % s1_corner_standl_trans_cqb_out_4;
  var_0["left_cqb"][6] = % s1_corner_standl_trans_cqb_out_6;
  var_0["left_cqb"][7] = % s1_corner_standl_trans_cqb_out_7;
  var_0["left_cqb"][8] = % s1_corner_standl_trans_cqb_out_8;
  var_0["right_cqb"][1] = % s1_corner_standr_trans_cqb_out_1;
  var_0["right_cqb"][2] = % s1_corner_standr_trans_cqb_out_2;
  var_0["right_cqb"][3] = % s1_corner_standr_trans_cqb_out_3;
  var_0["right_cqb"][4] = % s1_corner_standr_trans_cqb_out_4;
  var_0["right_cqb"][6] = % s1_corner_standr_trans_cqb_out_6;
  var_0["right_cqb"][8] = % s1_corner_standr_trans_cqb_out_8;
  var_0["right_cqb"][9] = % s1_corner_standr_trans_cqb_out_9;
  var_0["left_crouch"][1] = % s1_cornercrl_trans_out_ml;
  var_0["left_crouch"][2] = % s1_cornercrl_trans_out_m;
  var_0["left_crouch"][3] = % s1_cornercrl_trans_out_mr;
  var_0["left_crouch"][4] = % s1_cornercrl_trans_out_l;
  var_0["left_crouch"][6] = % s1_cornercrl_trans_out_r;
  var_0["left_crouch"][7] = % s1_cornercrl_trans_out_mf;
  var_0["left_crouch"][8] = % s1_cornercrl_trans_out_f;
  var_0["left_crouch_cqb"][1] = % s1_cornercrl_cqb_trans_out_1;
  var_0["left_crouch_cqb"][2] = % s1_cornercrl_cqb_trans_out_2;
  var_0["left_crouch_cqb"][3] = % s1_cornercrl_cqb_trans_out_3;
  var_0["left_crouch_cqb"][4] = % s1_cornercrl_cqb_trans_out_4;
  var_0["left_crouch_cqb"][6] = % s1_cornercrl_cqb_trans_out_6;
  var_0["left_crouch_cqb"][7] = % s1_cornercrl_cqb_trans_out_7;
  var_0["left_crouch_cqb"][8] = % s1_cornercrl_cqb_trans_out_8;
  var_0["exposed_crouch"][1] = % s1_cqb_crouch_start_1;
  var_0["exposed_crouch"][2] = % s1_cqb_crouch_start_2;
  var_0["exposed_crouch"][3] = % s1_cqb_crouch_start_3;
  var_0["exposed_crouch"][4] = % s1_cqb_crouch_start_4;
  var_0["exposed_crouch"][6] = % s1_cqb_crouch_start_6;
  var_0["exposed_crouch"][7] = % s1_cqb_crouch_start_7;
  var_0["exposed_crouch"][8] = % s1_cqb_crouch_start_8;
  var_0["exposed_crouch"][9] = % s1_cqb_crouch_start_9;
  var_0["exposed_crouch_cqb"][1] = % s1_cqb_crouch_start_1;
  var_0["exposed_crouch_cqb"][2] = % s1_cqb_crouch_start_2;
  var_0["exposed_crouch_cqb"][3] = % s1_cqb_crouch_start_3;
  var_0["exposed_crouch_cqb"][4] = % s1_cqb_crouch_start_4;
  var_0["exposed_crouch_cqb"][6] = % s1_cqb_crouch_start_6;
  var_0["exposed_crouch_cqb"][7] = % s1_cqb_crouch_start_7;
  var_0["exposed_crouch_cqb"][8] = % s1_cqb_crouch_start_8;
  var_0["exposed_crouch_cqb"][9] = % s1_cqb_crouch_start_9;
  var_0["exposed"] = [];
  var_0["exposed"][1] = % cqb_start_1;
  var_0["exposed"][2] = % s1_stand_2_run_180l;
  var_0["exposed"][3] = % cqb_start_3;
  var_0["exposed"][4] = % s1_stand_2_run_l;
  var_0["exposed"][6] = % s1_stand_2_run_r;
  var_0["exposed"][7] = % cqb_start_7;
  var_0["exposed"][8] = % s1_surprise_start_v1;
  var_0["exposed"][9] = % cqb_start_9;
  var_0["exposed_cqb"][1] = % cqb_start_1;
  var_0["exposed_cqb"][2] = % cqb_start_2;
  var_0["exposed_cqb"][3] = % cqb_start_3;
  var_0["exposed_cqb"][4] = % cqb_start_4;
  var_0["exposed_cqb"][6] = % cqb_start_6;
  var_0["exposed_cqb"][7] = % cqb_start_7;
  var_0["exposed_cqb"][8] = % cqb_start_8;
  var_0["exposed_cqb"][9] = % cqb_start_9;
  var_0["crouch"][1] = % s1_covercrouch_run_out_ml;
  var_0["crouch"][2] = % s1_covercrouch_run_out_m;
  var_0["crouch"][3] = % s1_covercrouch_run_out_mr;
  var_0["crouch"][4] = % s1_covercrouch_run_out_l;
  var_0["crouch"][6] = % s1_covercrouch_run_out_r;
  var_0["stand"][1] = % s1_coverstand_trans_out_ml;
  var_0["stand"][2] = % s1_coverstand_trans_out_m;
  var_0["stand"][3] = % s1_coverstand_trans_out_mr;
  var_0["stand"][4] = % s1_coverstand_trans_out_l;
  var_0["stand"][6] = % s1_coverstand_trans_out_r;
  anim.archetypes["s1_soldier"]["cover_exit"] = var_0;
}

init_s1_animset_cover_wall() {
  var_0 = [];
  var_0["add_aim_up"] = % s1_covercrouch_aim8_add;
  var_0["add_aim_down"] = % s1_covercrouch_aim2_add;
  var_0["add_aim_left"] = % s1_covercrouch_aim4_add;
  var_0["add_aim_right"] = % s1_covercrouch_aim6_add;
  var_0["straight_level"] = % s1_covercrouch_aim5;
  var_0["hide_idle"] = % s1_covercrouch_hide_idle;
  var_0["hide_idle_twitch"] = animscripts\utility::array( % s1_covercrouch_twitch_1, % s1_covercrouch_twitch_2, % s1_covercrouch_twitch_3, % s1_covercrouch_twitch_4, % s1_covercrouch_twitch_5);
  var_0["hide_idle_flinch"] = animscripts\utility::array( % s1_covercrouch_explosion_1, % s1_covercrouch_explosion_2, % s1_covercrouch_explosion_3);
  var_0["hide_2_crouch"] = % s1_covercrouch_hide_2_aim;
  var_0["hide_2_stand"] = % s1_covercrouch_hide_2_stand;
  var_0["hide_2_lean"] = % s1_covercrouch_hide_2_lean;
  var_0["hide_2_right"] = % s1_covercrouch_hide_2_right;
  var_0["hide_2_left"] = % s1_covercrouch_hide_2_left;
  var_0["crouch_2_hide"] = % s1_covercrouch_aim_2_hide;
  var_0["stand_2_hide"] = % s1_covercrouch_stand_2_hide;
  var_0["lean_2_hide"] = % s1_covercrouch_lean_2_hide;
  var_0["right_2_hide"] = % s1_covercrouch_right_2_hide;
  var_0["left_2_hide"] = % s1_covercrouch_left_2_hide;
  var_0["crouch_aim"] = % s1_covercrouch_aim5;
  var_0["stand_aim"] = % s1_coverstand_aim_5;
  var_0["lean_aim"] = % s1_covercrouch_lean_aim5;
  var_0["fire"] = % s1_exposed_shoot_auto;
  var_0["semi2"] = % s1_exposed_shoot_semi2;
  var_0["semi3"] = % s1_exposed_shoot_semi3;
  var_0["semi4"] = % s1_exposed_shoot_semi4;
  var_0["semi5"] = % s1_exposed_shoot_semi5;
  var_0["single"] = [ % s1_exposed_shoot_semi1];
  var_0["burst2"] = % s1_exposed_shoot_burst3;
  var_0["burst3"] = % s1_exposed_shoot_burst3;
  var_0["burst4"] = % s1_exposed_shoot_burst4;
  var_0["burst5"] = % s1_exposed_shoot_burst5;
  var_0["burst6"] = % s1_exposed_shoot_burst6;
  var_0["blind_fire"] = animscripts\utility::array( % s1_covercrouch_blindfire_1, % s1_covercrouch_blindfire_2, % s1_covercrouch_blindfire_3, % s1_covercrouch_blindfire_4);
  var_0["reload"] = % s1_covercrouch_reload_hide;
  var_0["grenade_safe"] = animscripts\utility::array( % s1_covercrouch_grenadea);
  var_0["grenade_exposed"] = animscripts\utility::array( % s1_covercrouch_grenadea);
  var_0["exposed_idle"] = animscripts\utility::array( % s1_exposed_idle_alert_v1, % s1_exposed_idle_alert_v2, % s1_exposed_idle_alert_v3);
  var_0["look"] = animscripts\utility::array( % s1_covercrouch_hide_look);
  anim.archetypes["s1_soldier"]["cover_crouch"] = var_0;
  var_0 = [];
  var_0["add_aim_up"] = % s1_coverstandaim_aim8_add;
  var_0["add_aim_down"] = % s1_coverstandaim_aim2_add;
  var_0["add_aim_left"] = % s1_coverstandaim_aim4_add;
  var_0["add_aim_right"] = % s1_coverstandaim_aim6_add;
  var_0["straight_level"] = % s1_coverstand_aim_5;
  var_0["hide_idle"] = % s1_coverstand_hide_idle;
  var_0["hide_idle_twitch"] = animscripts\utility::array( % s1_coverstand_hide_idle_twitch01, % s1_coverstand_hide_idle_twitch02, % s1_coverstand_hide_idle_twitch03, % s1_coverstand_hide_idle_twitch04, % s1_coverstand_hide_idle_twitch05);
  var_0["hide_idle_flinch"] = animscripts\utility::array( % s1_coverstand_react01, % s1_coverstand_react02, % s1_coverstand_react03, % s1_coverstand_react04);
  var_0["hide_2_stand"] = % s1_coverstand_hide_2_aim;
  var_0["stand_2_hide"] = % s1_coverstand_aim_2_hide;
  var_0["hide_2_stand_tall"] = % coverstand_hide_2_aim;
  var_0["stand_tall_2_hide"] = % coverstand_aim_2_hide;
  var_0["smg_hide_2_stand"] = % smg_coverstand_hide_2_aim;
  var_0["smg_stand_2_hide"] = % smg_coverstand_aim_2_hide;
  var_0["hide_2_over"] = % s1_coverstand_2_coverstandaim;
  var_0["over_2_hide"] = % s1_coverstandaim_2_coverstand;
  var_0["over_aim"] = % s1_coverstand_aim_5;
  var_0["fire"] = % s1_coverstandaim_autofire;
  var_0["semi2"] = % s1_coverstandaim_fire;
  var_0["semi3"] = % s1_coverstandaim_fire;
  var_0["semi4"] = % s1_coverstandaim_fire;
  var_0["semi5"] = % s1_coverstandaim_fire;
  var_0["single"] = animscripts\utility::array( % s1_coverstandaim_fire);
  var_0["burst2"] = % s1_coverstandaim_autofire;
  var_0["burst3"] = % s1_coverstandaim_autofire;
  var_0["burst4"] = % s1_coverstandaim_autofire;
  var_0["burst5"] = % s1_coverstandaim_autofire;
  var_0["burst6"] = % s1_coverstandaim_autofire;
  var_0["blind_fire"] = animscripts\utility::array( % s1_coverstand_blindfire_1, % s1_coverstand_blindfire_2);
  var_0["reload"] = % s1_coverstand_reloada;
  var_0["look"] = animscripts\utility::array( % s1_coverstand_look_quick, % s1_coverstand_look_quick_v2);
  var_0["grenade_safe"] = animscripts\utility::array( % s1_coverstand_grenadea, % s1_coverstand_grenadeb);
  var_0["grenade_exposed"] = animscripts\utility::array( % s1_coverstand_grenadea, % s1_coverstand_grenadeb);
  var_0["exposed_idle"] = animscripts\utility::array( % s1_exposed_idle_alert_v1, % s1_exposed_idle_alert_v2, % s1_exposed_idle_alert_v3);
  var_0["hide_to_look"] = % s1_coverstand_look_moveup;
  var_0["look_idle"] = % s1_coverstand_look_idle;
  var_0["look_to_hide"] = % s1_coverstand_look_movedown;
  var_0["look_to_hide_fast"] = % s1_coverstand_look_movedown_fast;
  anim.archetypes["s1_soldier"]["cover_stand"] = var_0;
}

set_s1_animarray_burst_and_semi_fire_stand() {
  anim.initanimset["burst2"] = % s1_exposed_shoot_burst3;
  anim.initanimset["burst3"] = % s1_exposed_shoot_burst3;
  anim.initanimset["burst4"] = % s1_exposed_shoot_burst4;
  anim.initanimset["burst5"] = % s1_exposed_shoot_burst5;
  anim.initanimset["burst6"] = % s1_exposed_shoot_burst6;
  anim.initanimset["semi2"] = % s1_exposed_shoot_semi2;
  anim.initanimset["semi3"] = % s1_exposed_shoot_semi3;
  anim.initanimset["semi4"] = % s1_exposed_shoot_semi4;
  anim.initanimset["semi5"] = % s1_exposed_shoot_semi5;
}

init_s1_animset_melee() {
  var_0 = [];
  var_0["standard"] = % s1_melee_1;
  var_0["standard_stand_to_melee"] = % s1_stand_2_melee_1;
  var_0["standard_run_to_melee"] = % s1_run_2_melee_charge;
  var_0["aivai_exposed_attackerwins_attack"] = % s1_melee_f_awin_attack;
  var_0["aivai_exposed_attackerwins_defend"] = % s1_melee_f_awin_defend;
  var_0["aivai_exposed_attackerwins_defend_survive"] = % s1_melee_f_awin_defend_survive;
  var_0["aivai_exposed_defenderwins_attack"] = % s1_melee_f_dwin_attack;
  var_0["aivai_exposed_defenderwins_defend"] = % s1_melee_f_dwin_defend;
  var_0["aivai_wrestle_attackerwins_attack"] = % bog_melee_r_attack;
  var_0["aivai_wrestle_attackerwins_defend"] = % bog_melee_r_defend;
  var_0["aivai_wrestle_attackerwins_defend_survive"] = % bog_melee_r_backdeath2;
  var_0["aivai_behind_attackerwins_attack"] = % s1_melee_sync_attack;
  var_0["aivai_behind_attackerwins_defend"] = % s1_melee_sync_defend;
  var_0["aivai_coverleft_attackerwins_attack"] = % s1_cornersdl_melee_wina_attacker;
  var_0["aivai_coverleft_attackerwins_defend"] = % s1_cornersdl_melee_wina_defender;
  var_0["aivai_coverleft_attackerwins_defend_survive"] = % s1_cornersdl_melee_wina_defender_survive;
  var_0["aivai_coverleft_defenderwins_attack"] = % s1_cornersdl_melee_wind_attacker;
  var_0["aivai_coverleft_defenderwins_attack_survive"] = % s1_cornersdl_melee_wind_attacker_survive;
  var_0["aivai_coverleft_defenderwins_defend"] = % s1_cornersdl_melee_wind_defender;
  var_0["aivai_coverright_attackerwins_attack"] = % s1_cornersdr_melee_wina_attacker;
  var_0["aivai_coverright_attackerwins_defend"] = % s1_cornersdr_melee_wina_defender;
  var_0["aivai_coverright_defenderwins_attack"] = % s1_cornersdr_melee_wind_attacker;
  var_0["aivai_coverright_defenderwins_defend"] = % s1_cornersdr_melee_wind_defender;
  anim.archetypes["s1_soldier"]["melee"] = var_0;
}

set_s1_animarray_stance_change() {
  anim.initanimset["crouch_2_stand"] = % s1_exposed_crouch_2_stand;
  anim.initanimset["stand_2_crouch"] = % s1_exposed_stand_2_crouch;
}

init_s1_animset_default_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % s1_exposed_aim_8;
  anim.initanimset["add_aim_down"] = % s1_exposed_aim_2;
  anim.initanimset["add_aim_left"] = % s1_exposed_aim_4;
  anim.initanimset["add_aim_right"] = % s1_exposed_aim_6;
  anim.initanimset["straight_level"] = % s1_exposed_aim_5;
  anim.initanimset["fire"] = % s1_exposed_shoot_auto_v3;
  anim.initanimset["fire_corner"] = % s1_exposed_shoot_auto_v2;
  anim.initanimset["single"] = animscripts\utility::array( % s1_exposed_shoot_semi1);
  set_s1_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = [ % s1_exposed_idle_alert_v1, % s1_exposed_idle_alert_v2, % s1_exposed_idle_alert_v3, % s1_exposed_idle_alert_v4, % s1_exposed_idle_alert_v5];
  anim.initanimset["exposed_grenade"] = [ % s1_exposed_grenadethrowb, % s1_exposed_grenadethrowc];
  anim.initanimset["reload"] = [ % s1_exposed_reload, % s1_exposed_reloadc];
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array( % s1_exposed_reloadb);
  set_s1_animarray_stance_change();
  set_s1_animarray_standing_turns();
  set_s1_animarray_add_turn_aims_stand();
  anim.archetypes["s1_soldier"]["default_stand"] = anim.initanimset;
}

init_s1_animset_cover_right() {
  var_0 = [];
  var_0["alert_idle"] = % s1_corner_standr_alert_idle;
  var_0["alert_idle_twitch"] = [ % s1_corner_standr_alert_twitch01, % s1_corner_standr_alert_twitch02, % s1_corner_standr_alert_twitch04, % s1_corner_standr_alert_twitch05, % s1_corner_standr_alert_twitch06, % s1_corner_standr_alert_twitch07];
  var_0["alert_idle_flinch"] = [ % s1_corner_standr_flinch, % s1_corner_standr_flinchb];
  var_0["alert_to_C"] = % s1_corner_standr_trans_alert_2_c;
  var_0["B_to_C"] = % s1_corner_standr_trans_b_2_c;
  var_0["C_to_alert"] = % s1_corner_standr_trans_c_2_alert;
  var_0["C_to_B"] = % s1_corner_standr_trans_c_2_b;
  var_0["alert_to_A"] = [ % s1_corner_standr_trans_alert_2_a, % s1_corner_standr_trans_alert_2_a_v2];
  var_0["alert_to_B"] = [ % s1_corner_standr_trans_alert_2_b, % s1_corner_standr_trans_alert_2_b_v2, % s1_corner_standr_trans_alert_2_b_v3];
  var_0["A_to_alert"] = [ % s1_corner_standr_trans_a_2_alert_v2];
  var_0["A_to_alert_reload"] = [];
  var_0["A_to_B"] = [ % s1_corner_standr_trans_a_2_b, % s1_corner_standr_trans_a_2_b_v2];
  var_0["B_to_alert"] = [ % s1_corner_standr_trans_b_2_alert, % s1_corner_standr_trans_b_2_alert_v2, % s1_corner_standr_trans_b_2_alert_v3];
  var_0["B_to_alert_reload"] = [ % s1_corner_standr_reload_b_2_alert];
  var_0["B_to_A"] = [ % s1_corner_standr_trans_b_2_a, % s1_corner_standr_trans_b_2_a_v2];
  var_0["lean_to_alert"] = [ % s1_cornerstndr_lean_2_alert];
  var_0["alert_to_lean"] = [ % s1_cornerstndr_alert_2_lean];
  var_0["look"] = % s1_corner_standr_look;
  var_0["reload"] = [ % s1_corner_standr_reload_v1];
  var_0["grenade_exposed"] = % s1_corner_standr_grenade_a;
  var_0["grenade_safe"] = % s1_corner_standr_grenade_b;
  var_0["blind_fire"] = [ % s1_corner_standr_blindfire_v1, % s1_corner_standr_blindfire_v2];
  var_0["alert_to_look"] = % s1_corner_standr_alert_2_look;
  var_0["look_to_alert"] = % s1_corner_standr_look_2_alert;
  var_0["look_to_alert_fast"] = % s1_corner_standr_look_2_alert_fast;
  var_0["look_idle"] = % s1_corner_standr_look_idle;
  var_0["stance_change"] = % s1_cornercrr_stand_2_alert;
  var_0["lean_aim_down"] = % s1_cornerstndr_lean_aim_2;
  var_0["lean_aim_left"] = % s1_cornerstndr_lean_aim_4;
  var_0["lean_aim_straight"] = % s1_cornerstndr_lean_aim_5;
  var_0["lean_aim_right"] = % s1_cornerstndr_lean_aim_6;
  var_0["lean_aim_up"] = % s1_cornerstndr_lean_aim_8;
  var_0["lean_reload"] = % s1_cornerstndr_lean_reload;
  var_0["lean_idle"] = [ % s1_cornerstndr_lean_idle];
  var_0["lean_single"] = % s1_cornerstndr_lean_fire;
  var_0["lean_burst"] = % s1_cornerstndr_lean_autoburst;
  var_0["lean_fire"] = % s1_cornerstndr_lean_auto;
  anim.archetypes["s1_soldier"]["cover_right_stand"] = var_0;
  var_0 = [];
  var_0["alert_idle"] = % s1_cornercrr_alert_idle;
  var_0["alert_idle_twitch"] = [ % s1_cornercrr_alert_twitch_v1, % s1_cornercrr_alert_twitch_v2, % s1_cornercrr_alert_twitch_v3];
  var_0["alert_idle_flinch"] = [];
  var_0["alert_to_A"] = [ % s1_cornercrr_trans_alert_2_a];
  var_0["alert_to_B"] = [ % s1_cornercrr_trans_alert_2_b];
  var_0["A_to_alert"] = [ % s1_cornercrr_trans_a_2_alert];
  var_0["A_to_alert_reload"] = [];
  var_0["A_to_B"] = [ % s1_cornercrr_trans_a_2_b];
  var_0["B_to_alert"] = [ % s1_cornercrr_trans_b_2_alert];
  var_0["B_to_alert_reload"] = [];
  var_0["B_to_A"] = [ % s1_cornercrr_trans_b_2_a];
  var_0["lean_to_alert"] = [ % s1_cornercrr_lean_2_alert];
  var_0["alert_to_lean"] = [ % s1_cornercrr_alert_2_lean];
  var_0["reload"] = [ % s1_cornercrr_reloada, % s1_cornercrr_reloadb];
  var_0["grenade_exposed"] = % s1_cornercrr_grenadea;
  var_0["grenade_safe"] = % s1_cornercrr_grenadea;
  var_0["alert_to_over"] = [ % s1_cornercrr_alert_2_over];
  var_0["over_to_alert"] = [ % s1_cornercrr_over_2_alert];
  var_0["over_to_alert_reload"] = [];
  var_0["blind_fire"] = [];
  var_0["rambo90"] = [];
  var_0["rambo45"] = [];
  var_0["alert_to_look"] = % s1_cornercrr_alert_2_look;
  var_0["look_to_alert"] = % s1_cornercrr_look_2_alert;
  var_0["look_to_alert_fast"] = % s1_cornercrr_look_2_alert_fast;
  var_0["look_idle"] = % s1_cornercrr_look_idle;
  var_0["stance_change"] = % s1_cornercrr_alert_2_stand;
  var_0["lean_aim_down"] = % s1_cornercrr_lean_aim_2;
  var_0["lean_aim_left"] = % s1_cornercrr_lean_aim_4;
  var_0["lean_aim_straight"] = % s1_cornercrr_lean_aim_5;
  var_0["lean_aim_right"] = % s1_cornercrr_lean_aim_6;
  var_0["lean_aim_up"] = % s1_cornercrr_lean_aim_8;
  var_0["lean_reload"] = % s1_cornerstndr_lean_reload;
  var_0["lean_idle"] = [ % s1_cornercrr_lean_idle];
  var_0["lean_single"] = % s1_cornercrr_lean_fire;
  var_0["lean_fire"] = % s1_cornercrr_lean_auto;
  anim.archetypes["s1_soldier"]["cover_right_crouch"] = var_0;
}

init_s1_animset_cover_left() {
  var_0 = [];
  var_0["alert_idle"] = % s1_corner_standl_alert_idle;
  var_0["alert_idle_twitch"] = [ % s1_corner_standl_alert_twitch01, % s1_corner_standl_alert_twitch02, % s1_corner_standl_alert_twitch03, % s1_corner_standl_alert_twitch04, % s1_corner_standl_alert_twitch05, % s1_corner_standl_alert_twitch06, % s1_corner_standl_alert_twitch07];
  var_0["alert_idle_flinch"] = [ % s1_corner_standl_flinch];
  var_0["alert_to_C"] = % s1_corner_standl_trans_alert_2_c;
  var_0["B_to_C"] = % s1_corner_standl_trans_b_2_c;
  var_0["C_to_alert"] = % s1_corner_standl_trans_c_2_alert;
  var_0["C_to_B"] = % s1_corner_standl_trans_c_2_b;
  var_0["alert_to_A"] = [ % s1_corner_standl_trans_alert_2_a, % s1_corner_standl_trans_alert_2_a_v2];
  var_0["alert_to_B"] = [ % s1_corner_standl_trans_alert_2_b_v2];
  var_0["A_to_alert"] = [ % s1_corner_standl_trans_a_2_alert_v2];
  var_0["A_to_alert_reload"] = [];
  var_0["A_to_B"] = [ % s1_corner_standl_trans_a_2_b_v2];
  var_0["B_to_alert"] = [ % s1_corner_standl_trans_b_2_alert_v2];
  var_0["B_to_alert_reload"] = [ % s1_corner_standl_reload_b_2_alert];
  var_0["B_to_A"] = [ % s1_corner_standl_trans_b_2_a_v2];
  var_0["lean_to_alert"] = [ % s1_cornerstndl_lean_2_alert];
  var_0["alert_to_lean"] = [ % s1_cornerstndl_alert_2_lean];
  var_0["look"] = % s1_corner_standl_look;
  var_0["reload"] = [ % s1_corner_standl_reload_v1];
  var_0["grenade_exposed"] = % s1_corner_standl_grenade_a;
  var_0["grenade_safe"] = % s1_corner_standl_grenade_b;
  var_0["blind_fire"] = [ % s1_corner_standl_blindfire_v1, % s1_corner_standl_blindfire_v2];
  var_0["alert_to_look"] = % s1_corner_standl_alert_2_look;
  var_0["look_to_alert"] = % s1_corner_standl_look_2_alert;
  var_0["look_to_alert_fast"] = % s1_corner_standl_look_2_alert_fast_v1;
  var_0["look_idle"] = % s1_corner_standl_look_idle;
  var_0["stance_change"] = % s1_cornercrl_stand_2_alert;
  var_0["lean_aim_down"] = % s1_cornerstndl_lean_aim_2;
  var_0["lean_aim_left"] = % s1_cornerstndl_lean_aim_4;
  var_0["lean_aim_straight"] = % s1_cornerstndl_lean_aim_5;
  var_0["lean_aim_right"] = % s1_cornerstndl_lean_aim_6;
  var_0["lean_aim_up"] = % s1_cornerstndl_lean_aim_8;
  var_0["lean_reload"] = % s1_cornerstndl_lean_reload;
  var_0["lean_idle"] = [ % s1_cornerstndl_lean_idle];
  var_0["lean_single"] = % s1_cornerstndl_lean_fire;
  var_0["lean_burst"] = % s1_cornerstndl_lean_autoburst;
  var_0["lean_fire"] = % s1_cornerstndl_lean_auto;
  anim.archetypes["s1_soldier"]["cover_left_stand"] = var_0;
  var_0 = [];
  var_0["alert_idle"] = % s1_cornercrl_alert_idle;
  var_0["alert_idle_twitch"] = [];
  var_0["alert_idle_flinch"] = [];
  var_0["alert_to_A"] = [ % s1_cornercrl_trans_alert_2_a];
  var_0["alert_to_B"] = [ % s1_cornercrl_trans_alert_2_b];
  var_0["A_to_alert"] = [ % s1_cornercrl_trans_a_2_alert];
  var_0["A_to_alert_reload"] = [];
  var_0["A_to_B"] = [ % s1_cornercrl_trans_a_2_b];
  var_0["B_to_alert"] = [ % s1_cornercrl_trans_b_2_alert];
  var_0["B_to_alert_reload"] = [];
  var_0["B_to_A"] = [ % s1_cornercrl_trans_b_2_a];
  var_0["lean_to_alert"] = [ % s1_cornercrl_lean_2_alert];
  var_0["alert_to_lean"] = [ % s1_cornercrl_alert_2_lean];
  var_0["look"] = % s1_cornercrl_look_fast;
  var_0["reload"] = [ % s1_cornercrl_reloada, % s1_cornercrl_reloadb];
  var_0["grenade_safe"] = % s1_cornercrl_grenadea;
  var_0["grenade_exposed"] = % s1_cornercrl_grenadeb;
  var_0["alert_to_over"] = [ % s1_cornercrl_alert_2_over];
  var_0["over_to_alert"] = [ % s1_cornercrl_over_2_alert];
  var_0["over_to_alert_reload"] = [];
  var_0["blind_fire"] = [];
  var_0["rambo90"] = [];
  var_0["rambo45"] = [];
  var_0["alert_to_look"] = % s1_cornercrl_alert_2_look;
  var_0["look_to_alert"] = % s1_cornercrl_look_2_alert;
  var_0["look_to_alert_fast"] = % s1_cornercrl_look_2_alert;
  var_0["look_idle"] = % s1_cornercrl_alert_idle;
  var_0["stance_change"] = % s1_cornercrl_alert_2_stand;
  var_0["lean_aim_down"] = % s1_cornercrl_lean_aim_2;
  var_0["lean_aim_left"] = % s1_cornercrl_lean_aim_4;
  var_0["lean_aim_straight"] = % s1_cornercrl_lean_aim_5;
  var_0["lean_aim_right"] = % s1_cornercrl_lean_aim_6;
  var_0["lean_aim_up"] = % s1_cornercrl_lean_aim_8;
  var_0["lean_idle"] = [ % s1_cornercrl_lean_idle];
  var_0["lean_single"] = % s1_cornercrl_lean_fire;
  var_0["lean_fire"] = % s1_cornercrl_lean_auto;
  anim.archetypes["s1_soldier"]["cover_left_crouch"] = var_0;
}

init_s1_animset_run_n_gun() {
  anim.initanimset = [];
  anim.initanimset["F"] = % s1_run_n_gun_f;
  anim.initanimset["L"] = % s1_run_n_gun_l;
  anim.initanimset["R"] = % s1_run_n_gun_r;
  anim.initanimset["LB"] = % s1_run_n_gun_l_120;
  anim.initanimset["RB"] = % s1_run_n_gun_r_120;
  anim.initanimset["move_back"] = % s1_combatwalk_b;
  anim.archetypes["s1_soldier"]["run_n_gun"] = anim.initanimset;
}

init_s1_animset_default_crouch() {
  anim.initanimset = [];
  set_s1_animarray_crouch_aim();
  anim.initanimset["fire"] = % s1_exposed_crouch_shoot_auto_v2;
  anim.initanimset["single"] = animscripts\utility::array( % s1_exposed_crouch_shoot_semi1);
  set_s1_animarray_burst_and_semi_fire_crouch();
  anim.initanimset["reload"] = animscripts\utility::array( % s1_exposed_crouch_reload);
  anim.initanimset["exposed_idle"] = animscripts\utility::array( % s1_exposed_crouch_idle_alert_v1, % s1_exposed_crouch_idle_alert_v2, % s1_exposed_crouch_idle_alert_v3);
  set_s1_animarray_stance_change();
  set_s1_animarray_crouching_turns();
  set_s1_animarray_add_turn_aims_crouch();
  anim.archetypes["s1_soldier"]["default_crouch"] = anim.initanimset;
}

init_s1_animset_smg_crouch() {
  anim.initanimset = [];
  set_s1_animarray_crouch_aim();
  anim.initanimset["fire"] = % s1_exposed_crouch_shoot_auto_v2;
  anim.initanimset["single"] = animscripts\utility::array( % s1_exposed_crouch_shoot_semi1);
  set_s1_animarray_burst_and_semi_fire_crouch();
  anim.initanimset["reload"] = animscripts\utility::array( % s1_exposed_crouch_reload);
  anim.initanimset["exposed_idle"] = animscripts\utility::array( % s1_exposed_crouch_idle_alert_v1, % s1_exposed_crouch_idle_alert_v2, % s1_exposed_crouch_idle_alert_v3);
  set_s1_animarray_stance_change_smg();
  set_s1_animarray_crouching_turns();
  set_s1_animarray_add_turn_aims_crouch();
  anim.archetypes["s1_soldier"]["smg_crouch"] = anim.initanimset;
}

set_s1_animarray_stance_change_smg() {
  anim.initanimset["crouch_2_stand"] = % smg_exposed_crouch_2_stand;
  anim.initanimset["crouch_2_prone"] = % crouch_2_prone;
  anim.initanimset["stand_2_crouch"] = % smg_exposed_stand_2_crouch;
  anim.initanimset["stand_2_prone"] = % stand_2_prone;
  anim.initanimset["prone_2_crouch"] = % prone_2_crouch;
  anim.initanimset["prone_2_stand"] = % prone_2_stand;
}

set_s1_animarray_crouch_aim() {
  anim.initanimset["add_aim_up"] = % s1_exposed_crouch_aim_8;
  anim.initanimset["add_aim_down"] = % s1_exposed_crouch_aim_2;
  anim.initanimset["add_aim_left"] = % s1_exposed_crouch_aim_4;
  anim.initanimset["add_aim_right"] = % s1_exposed_crouch_aim_6;
  anim.initanimset["straight_level"] = % s1_exposed_crouch_aim_5;
}

set_s1_animarray_burst_and_semi_fire_crouch() {
  anim.initanimset["burst2"] = % s1_exposed_crouch_shoot_burst3;
  anim.initanimset["burst3"] = % s1_exposed_crouch_shoot_burst3;
  anim.initanimset["burst4"] = % s1_exposed_crouch_shoot_burst4;
  anim.initanimset["burst5"] = % s1_exposed_crouch_shoot_burst5;
  anim.initanimset["burst6"] = % s1_exposed_crouch_shoot_burst6;
  anim.initanimset["semi2"] = % s1_exposed_crouch_shoot_semi2;
  anim.initanimset["semi3"] = % s1_exposed_crouch_shoot_semi3;
  anim.initanimset["semi4"] = % s1_exposed_crouch_shoot_semi4;
  anim.initanimset["semi5"] = % s1_exposed_crouch_shoot_semi5;
}

set_s1_animarray_crouching_turns() {
  anim.initanimset["turn_left_45"] = % s1_exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_90"] = % s1_exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_135"] = % s1_exposed_crouch_turn_180_left;
  anim.initanimset["turn_left_180"] = % s1_exposed_crouch_turn_180_left;
  anim.initanimset["turn_right_45"] = % s1_exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_90"] = % s1_exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_135"] = % s1_exposed_crouch_turn_180_right;
  anim.initanimset["turn_right_180"] = % s1_exposed_crouch_turn_180_right;
}

set_s1_animarray_add_turn_aims_crouch() {
  anim.initanimset["add_turn_aim_up"] = % s1_exposed_crouch_turn_aim_8;
  anim.initanimset["add_turn_aim_down"] = % s1_exposed_crouch_turn_aim_2;
  anim.initanimset["add_turn_aim_left"] = % s1_exposed_crouch_turn_aim_4;
  anim.initanimset["add_turn_aim_right"] = % s1_exposed_crouch_turn_aim_6;
}

init_s1_animset_cqb_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % s1_exposed_aim_8;
  anim.initanimset["add_aim_down"] = % s1_exposed_aim_2;
  anim.initanimset["add_aim_left"] = % s1_exposed_aim_4;
  anim.initanimset["add_aim_right"] = % s1_exposed_aim_6;
  anim.initanimset["straight_level"] = % s1_exposed_aim_5;
  anim.initanimset["fire"] = % s1_exposed_shoot_auto_v2;
  anim.initanimset["single"] = animscripts\utility::array( % s1_exposed_shoot_semi1);
  set_s1_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = [ % s1_exposed_idle_alert_v5, % s1_exposed_idle_alert_v4, % s1_exposed_idle_alert_v1, % s1_exposed_idle_alert_v2, % s1_exposed_idle_alert_v3];
  anim.initanimset["reload"] = [ % s1_exposed_reload, % s1_exposed_reloadc];
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array( % s1_exposed_reloadb);
  set_s1_animarray_stance_change();
  set_s1_animarray_standing_turns();
  set_s1_animarray_add_turn_aims_stand();
  anim.archetypes["s1_soldier"]["cqb_stand"] = anim.initanimset;
}

init_s1_animset_run_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % s1_sprint1_loop;
  anim.initanimset["sprint_short"] = % s1_sprint1_loop;
  anim.initanimset["straight"] = % s1_run_lowready_f;
  anim.initanimset["move_f"] = % s1_combatwalk_f;
  anim.initanimset["move_l"] = % s1_combatwalk_l;
  anim.initanimset["move_r"] = % s1_combatwalk_r;
  anim.initanimset["move_b"] = % s1_combatwalk_b;
  anim.archetypes["s1_soldier"]["run"] = anim.initanimset;
}

init_s1_animset_walk_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % s1_sprint1_loop;
  anim.initanimset["sprint_short"] = % s1_run_lowready_f;
  anim.initanimset["straight"] = % s1_combatwalk_f;
  anim.initanimset["move_f"] = % s1_combatwalk_f;
  anim.initanimset["move_l"] = % s1_combatwalk_l;
  anim.initanimset["move_r"] = % s1_combatwalk_r;
  anim.initanimset["move_b"] = % s1_combatwalk_b;
  anim.initanimset["aim_2"] = % s1_combatwalk_f_aim2;
  anim.initanimset["aim_4"] = % s1_combatwalk_f_aim4;
  anim.initanimset["aim_6"] = % s1_combatwalk_f_aim6;
  anim.initanimset["aim_8"] = % s1_combatwalk_f_aim8;
  anim.archetypes["s1_soldier"]["walk"] = anim.initanimset;
}

set_s1_animarray_add_turn_aims_stand() {
  anim.initanimset["add_turn_aim_up"] = % exposed_turn_aim_8;
  anim.initanimset["add_turn_aim_down"] = % exposed_turn_aim_2;
  anim.initanimset["add_turn_aim_left"] = % exposed_turn_aim_4;
  anim.initanimset["add_turn_aim_right"] = % exposed_turn_aim_6;
}

init_s1_animset_death() {
  var_0 = [];
  var_0["running_forward"] = [ % s1_run_death_facedown, % s1_run_death_roll, % s1_run_death_fallonback, % run_death_flop];
  var_0["running_forward_f"] = [ % s1_run_death_fallonback];
  var_0["cover_stand"] = [ % s1_coverstand_death_left, % s1_coverstand_death_right];
  var_0["dying_crawl_crouch"] = [ % s1_dying_back_death_v2, % s1_dying_back_death_v3, % s1_dying_back_death_v4];
  var_0["stand_lower_body"] = [ % s1_exposed_death_groin, % s1_stand_death_leg];
  var_0["stand_lower_body_extended"] = [ % s1_exposed_death_groin, % stand_death_guts];
  var_0["stand_head"] = [ % s1_exposed_death_headtwist, % s1_exposed_death_flop];
  var_0["stand_neck"] = [ % s1_exposed_death_neckgrab];
  var_0["stand_back"] = [ % s1_exposed_death_falltoknees_02];
  var_0["stand_default"] = [ % s1_exposed_death_02, % s1_exposed_death_nerve];
  var_0["stand_default_firing"] = [ % s1_exposed_death_firing_02, % s1_exposed_death_firing];
  var_0["stand_backup_default"] = % s1_exposed_death;
  anim.archetypes["s1_soldier"]["death"] = var_0;
}

init_s1_animset_combat() {
  var_0 = [];
  var_0["surprise_stop"] = % s1_surprise_stop_v1;
  var_0["trans_to_combat"] = % s1_casual_stand_idle_trans_out;
  var_0["trans_from_crouch_r"] = % s1_cornercrr_2_exposed_crouch;
  var_0["trans_from_crouch_l"] = % s1_cornercrl_2_exposed_crouch;
  var_0["trans_to_crouch_l"] = % s1_exposed_crouch_2_cornercrl;
  var_0["trans_to_crouch_r"] = % s1_exposed_crouch_2_cornercrr;
  anim.archetypes["s1_soldier"]["combat"] = var_0;
}

init_s1_animset_pain() {
  var_0 = [];
  var_0["run_long"] = [ % s1_run_pain_leg, % s1_run_pain_shoulder, % s1_run_pain_stomach_stumble, % s1_run_pain_head, % s1_run_pain_fallonknee_02, % s1_run_pain_stomach, % s1_run_pain_stumble, % s1_run_pain_stomach_fast, % s1_run_pain_leg_fast, % s1_run_pain_fall];
  var_0["run_medium"] = [ % s1_run_pain_fallonknee_02, % s1_run_pain_stomach, % s1_run_pain_stumble, % s1_run_pain_stomach_fast, % s1_run_pain_leg_fast, % s1_run_pain_fall];
  var_0["run_short"] = [ % s1_run_pain_fallonknee, % s1_run_pain_fallonknee_03];
  var_0["cover_left_stand"] = [ % s1_corner_standl_painb, % s1_corner_standl_painc, % s1_corner_standl_paind, % s1_corner_standl_paine];
  var_0["cover_right_crouch"] = [ % s1_cornercrr_alert_paina, % s1_cornercrr_alert_painb, % s1_cornercrr_alert_painc];
  var_0["cover_right_stand_B"] = % s1_corner_standr_pain_b_2_alert;
  var_0["cover_left_stand_A"] = % s1_corner_standl_pain_a_2_alert;
  var_0["cover_left_stand_B"] = % s1_corner_standl_pain_b_2_alert;
  anim.archetypes["s1_soldier"]["pain"] = var_0;
  var_0 = [];
  var_0["prone_transition"] = [ % s1_dying_crawl_2_back];
  var_0["stand_transition"] = [ % s1_dying_stand_2_back_v1, % s1_dying_stand_2_back_v2];
  var_0["crouch_transition"] = [ % s1_dying_crouch_2_back];
  var_0["default_transition"] = % s1_dying_crawl_2_back;
  var_0["stand_2_crawl"] = [ % s1_dying_stand_2_crawl_v1, % s1_dying_stand_2_crawl_v2, % s1_dying_stand_2_crawl_v3];
  var_0["crouch_2_crawl"] = [ % s1_dying_crouch_2_crawl];
  var_0["crawl"] = % s1_dying_crawl;
  var_0["death"] = [ % s1_dying_crawl_death_v1, % s1_dying_crawl_death_v2];
  var_0["back_idle"] = % s1_dying_back_idle;
  var_0["back_crawl"] = % s1_dying_crawl_back;
  var_0["back_fire"] = % s1_dying_back_fire;
  var_0["back_death"] = [ % s1_dying_back_death_v1];
  var_0["aim_4"] = % s1_dying_back_aim_4;
  var_0["aim_6"] = % s1_dying_back_aim_6;
  anim.archetypes["s1_soldier"]["crawl_death"] = var_0;
  var_0 = [];
  var_0["premature_death"] = [ % s1_dying_back_death_v1, % s1_dying_back_death_v2, % s1_dying_back_death_v3, % s1_dying_back_death_v4];
  anim.archetypes["s1_soldier"]["corner_grenade_death"] = var_0;
}

init_s1_animset_default_move() {
  var_0 = [];
  var_0["fire"] = % s1_exposed_shoot_auto_v3;
  var_0["single"] = [ % s1_exposed_shoot_semi1];
  var_0["single_shotgun"] = [ % shotgun_stand_fire_1a, % shotgun_stand_fire_1b];
  var_0["burst2"] = % s1_exposed_shoot_burst3;
  var_0["burst3"] = % s1_exposed_shoot_burst3;
  var_0["burst4"] = % s1_exposed_shoot_burst4;
  var_0["burst5"] = % s1_exposed_shoot_burst5;
  var_0["burst6"] = % s1_exposed_shoot_burst6;
  var_0["semi2"] = % s1_exposed_shoot_semi2;
  var_0["semi3"] = % s1_exposed_shoot_semi3;
  var_0["semi4"] = % s1_exposed_shoot_semi4;
  var_0["semi5"] = % s1_exposed_shoot_semi5;
  anim.archetypes["s1_soldier"]["shoot_while_moving"] = var_0;
  var_0 = [];
  var_0["shuffle_start_from_cover_left"] = % s1_cornercrl_alert_2_shuffle;
  var_0["shuffle_start_from_cover_right"] = % s1_cornercrr_alert_2_shuffle;
  var_0["shuffle_start_left"] = % s1_covercrouch_hide_2_shufflel;
  var_0["shuffle_start_right"] = % s1_covercrouch_hide_2_shuffler;
  var_0["shuffle_to_cover_left"] = % s1_covercrouch_shufflel;
  var_0["shuffle_end_to_cover_left"] = % s1_cornercrl_shuffle_2_alert;
  var_0["shuffle_to_cover_right"] = % s1_covercrouch_shuffler;
  var_0["shuffle_end_to_cover_right"] = % s1_cornercrr_shuffle_2_alert;
  var_0["shuffle_start_left_stand_to_stand"] = % s1_coverstand_hide_2_shufflel;
  var_0["shuffle_left_stand_to_stand"] = % s1_coverstand_shufflel;
  var_0["shuffle_end_left_stand_to_stand"] = % s1_coverstand_shufflel_2_hide;
  var_0["shuffle_start_right_stand_to_stand"] = % s1_coverstand_hide_2_shuffler;
  var_0["shuffle_right_stand_to_stand"] = % s1_coverstand_shuffler;
  var_0["shuffle_end_right_stand_to_stand"] = % s1_coverstand_shuffler_2_hide;
  var_0["shuffle_to_left_crouch"] = % s1_covercrouch_shufflel;
  var_0["shuffle_end_to_left_stand"] = % s1_coverstand_shufflel_2_hide;
  var_0["shuffle_end_to_left_crouch"] = % s1_covercrouch_shufflel_2_hide;
  var_0["shuffle_to_right_crouch"] = % s1_covercrouch_shuffler;
  var_0["shuffle_end_to_right_stand"] = % s1_coverstand_shuffler_2_hide;
  var_0["shuffle_end_to_right_crouch"] = % s1_covercrouch_shuffler_2_hide;
  anim.archetypes["s1_soldier"]["shuffle"] = var_0;
}

init_s1_animset_idle() {
  var_0 = [];
  var_0["stand"][0] = [ % s1_casual_stand_idle, % s1_casual_stand_idle_twitch, % s1_casual_stand_idle_twitchb];
  var_0["stand"][1] = [ % s1_casual_stand_idle_twitch, % s1_casual_stand_idle_twitch, % s1_casual_stand_v2_twitch_talk, % s1_casual_stand_v2_twitch_talk];
  var_0["stand_cqb"][0] = [ % cqb_stand_idle, % cqb_stand_twitch];
  var_0["crouch"][0] = [ % casual_crouch_idle];
  anim.archetypes["s1_soldier"]["idle"] = var_0;
  var_0 = [];
  var_0["stand"][0] = [2, 1, 1];
  var_0["stand"][1] = [10, 0, 0, 4];
  var_0["stand_cqb"][0] = [2, 1];
  var_0["crouch"][0] = [6];
  anim.archetypes["s1_soldier"]["idle_weights"] = var_0;
  var_0 = [];
  var_0["stand"] = % s1_casual_stand_idle_trans_in;
  var_0["crouch"] = % s1_casual_crouch_idle_in;
  var_0["stand_smg"] = % smg_casual_stand_idle_trans_in;
  anim.archetypes["s1_soldier"]["idle_transitions"] = var_0;
}

init_s1_moving_turn_animations() {
  anim.initanimset = [];
  anim.initanimset[0] = % s1_run_turn_180;
  anim.initanimset[1] = % s1_run_turn_l135;
  anim.initanimset[2] = % s1_run_turn_l90;
  anim.initanimset[3] = % s1_run_turn_l45;
  anim.initanimset[5] = % s1_run_turn_r45;
  anim.initanimset[6] = % s1_run_turn_r90;
  anim.initanimset[7] = % s1_run_turn_r135;
  anim.initanimset[8] = % s1_run_turn_180;
  anim.archetypes["s1_soldier"]["run_turn"] = anim.initanimset;
  anim.initanimset = [];
  anim.initanimset[0] = % s1_run_turn_180;
  anim.initanimset[1] = % s1_run_turn_l135;
  anim.initanimset[2] = % s1_run_turn_l90;
  anim.initanimset[3] = % s1_run_turn_l45;
  anim.initanimset[5] = % s1_run_turn_r45;
  anim.initanimset[6] = % s1_run_turn_r90;
  anim.initanimset[7] = % s1_run_turn_r135;
  anim.initanimset[8] = % s1_run_turn_180;
  anim.archetypes["s1_soldier"]["walk_turn"] = anim.initanimset;
}

set_s1_animarray_standing_turns() {
  anim.initanimset["turn_left_45"] = % s1_exposed_tracking_turn45l;
  anim.initanimset["turn_left_90"] = % s1_exposed_tracking_turn90l;
  anim.initanimset["turn_left_135"] = % s1_exposed_tracking_turn135l;
  anim.initanimset["turn_left_180"] = % s1_exposed_tracking_turn180l;
  anim.initanimset["turn_right_45"] = % s1_exposed_tracking_turn45r;
  anim.initanimset["turn_right_90"] = % s1_exposed_tracking_turn90r;
  anim.initanimset["turn_right_135"] = % s1_exposed_tracking_turn135r;
  anim.initanimset["turn_right_180"] = % s1_exposed_tracking_turn180r;
}

init_s1_coverstand_turn_animations() {
  anim.initanimset = [];
  anim.initanimset["turn_left_45"] = % s1_coverstand_tracking_turn45l;
  anim.initanimset["turn_left_90"] = % s1_coverstand_tracking_turn90l;
  anim.initanimset["turn_left_135"] = % s1_coverstand_tracking_turn135l;
  anim.initanimset["turn_left_180"] = % s1_coverstand_tracking_turn180l;
  anim.initanimset["turn_right_45"] = % s1_coverstand_tracking_turn45r;
  anim.initanimset["turn_right_90"] = % s1_coverstand_tracking_turn90r;
  anim.initanimset["turn_right_135"] = % s1_coverstand_tracking_turn135r;
  anim.initanimset["turn_right_180"] = % s1_coverstand_tracking_turn180r;
  anim.archetypes["s1_soldier"]["coverstand_turn"] = anim.initanimset;
}

init_s1_exposed_turn_animations() {
  anim.initanimset = [];
  anim.initanimset["turn_left_45"] = % s1_exposed_tracking_turn45l;
  anim.initanimset["turn_left_90"] = % s1_exposed_tracking_turn90l;
  anim.initanimset["turn_left_135"] = % s1_exposed_tracking_turn135l;
  anim.initanimset["turn_left_180"] = % s1_exposed_tracking_turn180l;
  anim.initanimset["turn_right_45"] = % s1_exposed_tracking_turn45r;
  anim.initanimset["turn_right_90"] = % s1_exposed_tracking_turn90r;
  anim.initanimset["turn_right_135"] = % s1_exposed_tracking_turn135r;
  anim.initanimset["turn_right_180"] = % s1_exposed_tracking_turn180r;
  anim.archetypes["s1_soldier"]["exposed_turn"] = anim.initanimset;
  anim.initanimset = [];
  anim.initanimset["turn_left_45"] = % s1_exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_90"] = % s1_exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_135"] = % s1_exposed_crouch_turn_180_left;
  anim.initanimset["turn_left_180"] = % s1_exposed_crouch_turn_180_left;
  anim.initanimset["turn_right_45"] = % s1_exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_90"] = % s1_exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_135"] = % s1_exposed_crouch_turn_180_right;
  anim.initanimset["turn_right_180"] = % s1_exposed_crouch_turn_180_right;
  anim.archetypes["s1_soldier"]["exposed_turn_crouch"] = anim.initanimset;
}