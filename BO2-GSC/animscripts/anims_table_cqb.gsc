/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_cqb.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include animscripts\anims_table;
#include animscripts\utility;
#include animscripts\anims;
#using_animtree("generic_human");

setup_cqb_anim_array() {
  if(!(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))) {
    return;
  }
  self animscripts\anims::clearanimcache();

  if(!isDefined(self.anim_array))
    self.anim_array = [];

  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["exposed_idle"] = array( % cqb_stand_exposed_idle);
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["straight_level"] = % cqb_stand_aim5;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_up"] = % cqb_stand_aim8;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_down"] = % cqb_stand_aim2;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_left"] = % cqb_stand_aim4;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["add_aim_right"] = % cqb_stand_aim6;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["reload"] = array( % cqb_stand_reload_steady);
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["reload_crouchhide"] = array( % cqb_stand_reload_knee);
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_45"] = % ai_cqb_exposed_turn_l_45;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_90"] = % ai_cqb_exposed_turn_l_90;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_135"] = % ai_cqb_exposed_turn_l_135;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_left_180"] = % ai_cqb_exposed_turn_l_180;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_45"] = % ai_cqb_exposed_turn_r_45;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_90"] = % ai_cqb_exposed_turn_r_90;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_135"] = % ai_cqb_exposed_turn_r_135;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["turn_right_180"] = % ai_cqb_exposed_turn_r_180;
}

reset_cqb_anim_array() {
  if(isDefined(self.heat) && self.heat) {
    reset_heat_anim_array();
    setup_heat_anim_array();
  } else
    self.anim_array = undefined;
}

set_cqb_run_anim(runanim, walkanim, sprintanim) {
  if(!(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))) {
    return;
  }
  self animscripts\anims::clearanimcache();

  if(!isDefined(self.anim_array))
    self.anim_array = [];

  if(isDefined(runanim))
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["cqb_run_f"] = array(runanim);

  if(isDefined(walkanim))
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["cqb_walk_f"] = array(walkanim);

  if(isDefined(sprintanim))
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["cqb_sprint_f"] = array(sprintanim);
}

clear_cqb_run_anim() {
  if(!(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))) {
    return;
  }
  self animscripts\anims::clearanimcache();

  if(!isDefined(self.anim_array)) {
    return;
  }
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["cqb_run_f"] = undefined;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["cqb_walk_f"] = undefined;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["cqb_sprint_f"] = undefined;
}

setup_default_cqb_anim_array(animtype, array) {
  array[animtype]["stop"]["stand"]["rifle"]["idle_cqb"] = array(array( % cqb_stand_idle, % cqb_stand_idle, % cqb_stand_twitch));
  array[animtype]["move"]["stand"]["rifle"]["cqb_reload_walk"] = % ai_cqb_walk_f_reload;
  array[animtype]["move"]["stand"]["rifle"]["cqb_reload_run"] = % ai_cqb_run_f_reload;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_bR_cqb"] = % ai_cqb_run_f_2_b_right;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_bL_cqb"] = % ai_cqb_run_f_2_b_left;
  array[animtype]["move"]["stand"]["rifle"]["cqb_sprint_f"] = % ai_cqb_sprint;
  array[animtype]["move"]["stand"]["rifle"]["cqb_walk_f"] = array( % walk_cqb_f, % walk_cqb_f_search_v1, % walk_cqb_f_search_v2);
  array[animtype]["move"]["stand"]["rifle"]["cqb_walk_r"] = % walk_left;
  array[animtype]["move"]["stand"]["rifle"]["cqb_walk_l"] = % walk_right;
  array[animtype]["move"]["stand"]["rifle"]["cqb_walk_b"] = % walk_backward;
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_f"] = array( % run_cqb_f_search_v1);
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_r"] = % walk_left;
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_l"] = % walk_right;
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_b"] = % walk_backward;
  array[animtype]["move"]["stand"]["rifle"]["cqb_f_aim_up"] = % walk_aim_8;
  array[animtype]["move"]["stand"]["rifle"]["cqb_f_aim_down"] = % walk_aim_2;
  array[animtype]["move"]["stand"]["rifle"]["cqb_f_aim_left"] = % walk_aim_4;
  array[animtype]["move"]["stand"]["rifle"]["cqb_f_aim_right"] = % walk_aim_6;
  array[animtype]["move"]["stand"]["rifle"]["start_cqb_run_f"] = % run_cqb_f_search_v1;
  array[animtype]["move"]["crouch"]["rifle"]["start_cqb_run_f"] = % run_cqb_f_search_v1;
  array[animtype]["move"]["prone"]["rifle"]["start_cqb_run_f"] = % run_cqb_f_search_v1;
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_n_gun_f"] = % run_cqb_f_search_v1;
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_n_gun_r"] = % ai_cqb_run_r;
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_n_gun_l"] = % ai_cqb_run_l;
  array[animtype]["move"]["stand"]["rifle"]["cqb_run_n_gun_b"] = % run_n_gun_b;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_f_aim_up"] = % walk_aim_8;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_f_aim_down"] = % walk_aim_2;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_f_aim_left"] = % walk_aim_4;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_f_aim_right"] = % walk_aim_6;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_l_aim_up"] = % ai_cqb_run_l_aim_8;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_l_aim_down"] = % ai_cqb_run_l_aim_2;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_l_aim_left"] = % ai_cqb_run_l_aim_4;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_l_aim_right"] = % ai_cqb_run_l_aim_6;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_r_aim_up"] = % ai_cqb_run_r_aim_8;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_r_aim_down"] = % ai_cqb_run_r_aim_2;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_r_aim_left"] = % ai_cqb_run_r_aim_4;
  array[animtype]["move"]["stand"]["rifle"]["cqb_add_r_aim_right"] = % ai_cqb_run_r_aim_6;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_45_cqb"] = % cqb_walk_turn_7;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_90_cqb"] = % cqb_walk_turn_4;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_135_cqb"] = % cqb_walk_turn_1;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_180_cqb"] = % cqb_walk_turn_2;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_45_cqb"] = % cqb_walk_turn_9;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_90_cqb"] = % cqb_walk_turn_6;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_135_cqb"] = % cqb_walk_turn_3;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_180_cqb"] = % cqb_walk_turn_2;
  array[animtype]["turn"]["stand"]["rifle"]["turn_b_l_180_cqb"] = % ai_cqb_run_b_2_f_left;
  array[animtype]["turn"]["stand"]["rifle"]["turn_b_r_180_cqb"] = % ai_cqb_run_b_2_f_right;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_cqb"][1] = % corner_standr_trans_cqb_in_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_cqb"][2] = % corner_standr_trans_cqb_in_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_cqb"][3] = % corner_standr_trans_cqb_in_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_cqb"][4] = % corner_standr_trans_cqb_in_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_cqb"][6] = % corner_standr_trans_cqb_in_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_cqb"][8] = % corner_standr_trans_cqb_in_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_cqb"][9] = % corner_standr_trans_cqb_in_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch_cqb"][1] = % cornercrr_cqb_trans_in_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch_cqb"][2] = % cornercrr_cqb_trans_in_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch_cqb"][3] = % cornercrr_cqb_trans_in_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch_cqb"][4] = % cornercrr_cqb_trans_in_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch_cqb"][6] = % cornercrr_cqb_trans_in_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch_cqb"][8] = % cornercrr_cqb_trans_in_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch_cqb"][9] = % cornercrr_cqb_trans_in_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_cqb"][1] = % corner_standl_trans_cqb_in_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_cqb"][2] = % corner_standl_trans_cqb_in_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_cqb"][3] = % corner_standl_trans_cqb_in_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_cqb"][4] = % corner_standl_trans_cqb_in_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_cqb"][6] = % corner_standl_trans_cqb_in_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_cqb"][7] = % corner_standl_trans_cqb_in_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_cqb"][8] = % corner_standl_trans_cqb_in_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch_cqb"][1] = % cornercrl_cqb_trans_in_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch_cqb"][2] = % cornercrl_cqb_trans_in_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch_cqb"][3] = % cornercrl_cqb_trans_in_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch_cqb"][4] = % cornercrl_cqb_trans_in_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch_cqb"][6] = % cornercrl_cqb_trans_in_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch_cqb"][7] = % cornercrl_cqb_trans_in_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch_cqb"][8] = % cornercrl_cqb_trans_in_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][1] = % cqb_stop_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][2] = % cqb_stop_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][3] = % cqb_stop_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][4] = % cqb_stop_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][6] = % cqb_stop_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][7] = % cqb_stop_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][8] = % cqb_stop_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_cqb"][9] = % cqb_stop_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][1] = % cqb_crouch_stop_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][2] = % cqb_crouch_stop_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][3] = % cqb_crouch_stop_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][4] = % cqb_crouch_stop_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][6] = % cqb_crouch_stop_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][7] = % cqb_crouch_stop_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][8] = % cqb_crouch_stop_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed_crouch_cqb"][9] = % cqb_crouch_stop_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_cqb"][1] = % corner_standr_trans_cqb_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_cqb"][2] = % corner_standr_trans_cqb_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_cqb"][3] = % corner_standr_trans_cqb_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_cqb"][4] = % corner_standr_trans_cqb_out_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_cqb"][6] = % corner_standr_trans_cqb_out_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_cqb"][8] = % corner_standr_trans_cqb_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_cqb"][9] = % corner_standr_trans_cqb_out_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch_cqb"][1] = % cornercrr_cqb_trans_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch_cqb"][2] = % cornercrr_cqb_trans_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch_cqb"][3] = % cornercrr_cqb_trans_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch_cqb"][4] = % cornercrr_cqb_trans_out_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch_cqb"][6] = % cornercrr_cqb_trans_out_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch_cqb"][8] = % cornercrr_cqb_trans_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch_cqb"][9] = % cornercrr_cqb_trans_out_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_cqb"][1] = % corner_standl_trans_cqb_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_cqb"][2] = % corner_standl_trans_cqb_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_cqb"][3] = % corner_standl_trans_cqb_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_cqb"][4] = % corner_standl_trans_cqb_out_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_cqb"][6] = % corner_standl_trans_cqb_out_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_cqb"][7] = % corner_standl_trans_cqb_out_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_cqb"][8] = % corner_standl_trans_cqb_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch_cqb"][1] = % cornercrl_cqb_trans_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch_cqb"][2] = % cornercrl_cqb_trans_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch_cqb"][3] = % cornercrl_cqb_trans_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch_cqb"][4] = % cornercrl_cqb_trans_out_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch_cqb"][6] = % cornercrl_cqb_trans_out_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch_cqb"][7] = % cornercrl_cqb_trans_out_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch_cqb"][8] = % cornercrl_cqb_trans_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][1] = % cqb_start_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][2] = % cqb_start_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][3] = % cqb_start_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][4] = % cqb_start_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][6] = % cqb_start_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][7] = % cqb_start_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][8] = % cqb_start_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_cqb"][9] = % cqb_start_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][1] = % cqb_crouch_start_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][2] = % cqb_crouch_start_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][3] = % cqb_crouch_start_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][4] = % cqb_crouch_start_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][6] = % cqb_crouch_start_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][7] = % cqb_crouch_start_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][8] = % cqb_crouch_start_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed_crouch_cqb"][9] = % cqb_crouch_start_9;
  return array;
}