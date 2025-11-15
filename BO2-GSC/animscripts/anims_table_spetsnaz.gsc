/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_spetsnaz.gsc
************************************************/

#include common_scripts\utility;
#include animscripts\anims_table_rusher;
#using_animtree("generic_human");

setup_spetsnaz_anim_array(animtype, array) {
  assert(isDefined(array) && isarray(array));
  array[animtype]["move"]["stand"]["rifle"]["combat_run_f"] = % ai_spetz_run_f;
  array[animtype]["move"]["stand"]["rifle"]["step_left_rh"] = array( % ai_spets_rusher_step_45l_2_run_01, % ai_spets_rusher_step_45l_2_run_02);
  array[animtype]["move"]["stand"]["rifle"]["step_left_lh"] = array( % ai_spets_rusher_step_45l_2_run_a_01, % ai_spets_rusher_step_45l_2_run_a_02);
  array[animtype]["move"]["stand"]["rifle"]["step_right_rh"] = array( % ai_spets_rusher_step_45r_2_run_01, % ai_spets_rusher_step_45r_2_run_02);
  array[animtype]["move"]["stand"]["rifle"]["step_right_lh"] = array( % ai_spets_rusher_step_45r_2_run_a_01, % ai_spets_rusher_step_45r_2_run_a_02);
  array[animtype]["move"]["stand"]["rifle"]["roll_left_rh"] = array( % ai_spets_rusher_roll_45l_2_run_01, % ai_spets_rusher_roll_45l_2_run_02);
  array[animtype]["move"]["stand"]["rifle"]["roll_left_lh"] = array( % ai_spets_rusher_roll_45l_2_run_a_01, % ai_spets_rusher_roll_45l_2_run_a_02);
  array[animtype]["move"]["stand"]["rifle"]["roll_right_rh"] = array( % ai_spets_rusher_roll_45r_2_run_01, % ai_spets_rusher_roll_45r_2_run_02);
  array[animtype]["move"]["stand"]["rifle"]["roll_right_lh"] = array( % ai_spets_rusher_roll_45r_2_run_a_01, % ai_spets_rusher_roll_45r_2_run_a_02);
  array[animtype]["move"]["stand"]["rifle"]["roll_forward_rh"] = array( % ai_spets_rusher_roll_forward_01, % ai_spets_rusher_roll_forward_02);
  array[animtype]["move"]["stand"]["rifle"]["roll_forward_lh"] = array( % ai_spets_rusher_roll_forward_01, % ai_spets_rusher_roll_forward_02);
  array[animtype]["move"]["stand"]["rifle"]["rusher_run_f_rh"] = array( % ai_spets_rusher_run_f_01, % ai_spets_rusher_run_f_02, % ai_spets_rusher_run_f_03);
  array[animtype]["move"]["stand"]["rifle"]["rusher_run_f_lh"] = array( % ai_spets_rusher_run_f_a_01, % ai_spets_rusher_run_f_a_02, % ai_spets_rusher_run_f_a_03);
  array[animtype]["move"]["stand"]["pistol"]["step_left_rh"] = array( % ai_spets_pistol_rusher_step_45l_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["step_left_lh"] = array( % ai_spets_pistol_rusher_step_45l_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["step_right_rh"] = array( % ai_spets_pistol_rusher_step_45r_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["step_right_lh"] = array( % ai_spets_pistol_rusher_step_45r_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["roll_left_rh"] = array( % ai_spets_pistol_rusher_roll_45l_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["roll_left_lh"] = array( % ai_spets_pistol_rusher_roll_45l_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["roll_right_rh"] = array( % ai_spets_pistol_rusher_roll_45r_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["roll_right_lh"] = array( % ai_spets_pistol_rusher_roll_45r_2_run_01);
  array[animtype]["move"]["stand"]["pistol"]["roll_forward_rh"] = array( % ai_spets_pistol_rusher_roll_forward_01);
  array[animtype]["move"]["stand"]["pistol"]["roll_forward_lh"] = array( % ai_spets_pistol_rusher_roll_forward_01);
  array[animtype]["move"]["stand"]["pistol"]["rusher_run_f_rh"] = array( % ai_pistol_rusher_run_f);
  array[animtype]["move"]["stand"]["pistol"]["rusher_run_f_lh"] = array( % ai_pistol_rusher_run_f);
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][1] = % ai_spets_run_2_corner_stand_l_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][2] = % ai_spets_run_2_corner_stand_l_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][3] = % ai_spets_run_2_corner_stand_l_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][4] = % ai_spets_run_2_corner_stand_l_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][6] = % ai_spets_run_2_corner_stand_l_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][7] = % ai_spets_run_2_corner_stand_l_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left"][8] = % ai_spets_run_2_corner_stand_l_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][1] = % ai_spets_run_2_corner_crouch_l_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][2] = % ai_spets_run_2_corner_crouch_l_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][3] = % ai_spets_run_2_corner_crouch_l_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][4] = % ai_spets_run_2_corner_crouch_l_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][6] = % ai_spets_run_2_corner_crouch_l_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][7] = % ai_spets_run_2_corner_crouch_l_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_left_crouch"][8] = % ai_spets_run_2_corner_crouch_l_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][1] = % ai_spets_run_2_corner_stand_r_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][2] = % ai_spets_run_2_corner_stand_r_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][3] = % ai_spets_run_2_corner_stand_r_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][4] = % ai_spets_run_2_corner_stand_r_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][6] = % ai_spets_run_2_corner_stand_r_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][8] = % ai_spets_run_2_corner_stand_r_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right"][9] = % ai_spets_run_2_corner_stand_r_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][1] = % ai_spets_run_2_corner_crouch_r_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][2] = % ai_spets_run_2_corner_crouch_r_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][3] = % ai_spets_run_2_corner_crouch_r_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][4] = % ai_spets_run_2_corner_crouch_r_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][6] = % ai_spets_run_2_corner_crouch_r_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][8] = % ai_spets_run_2_corner_crouch_r_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_right_crouch"][9] = % ai_spets_run_2_corner_crouch_r_9;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][1] = % ai_spets_run_2_crouch_cover_hide_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][2] = % ai_spets_run_2_crouch_cover_hide_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][3] = % ai_spets_run_2_crouch_cover_hide_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][4] = % covercrouch_run_in_l;
  array[animtype]["move"]["stand"]["rifle"]["arrive_crouch"][6] = % covercrouch_run_in_r;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][1] = % ai_spets_run_2_stand_cover_hide_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][2] = % ai_spets_run_2_stand_cover_hide_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][3] = % ai_spets_run_2_stand_cover_hide_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][4] = % ai_spets_run_2_stand_cover_hide_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_stand"][6] = % ai_spets_run_2_stand_cover_hide_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][1] = % corner_standr_trans_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][2] = % corner_standr_trans_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][3] = % corner_standr_trans_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][4] = % ai_spets_corner_stand_r_2_run_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][6] = % ai_spets_corner_stand_r_2_run_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][8] = % corner_standr_trans_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_right"][9] = % corner_standr_trans_out_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][1] = % cornercrr_trans_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][2] = % cornercrr_trans_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][3] = % cornercrr_trans_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][4] = % ai_spets_corner_crouch_r_2_run_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][6] = % ai_spets_corner_crouch_r_2_run_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][8] = % cornercrr_trans_out_f;
  array[animtype]["move"]["stand"]["rifle"]["exit_right_crouch"][9] = % cornercrr_trans_out_mf;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][1] = % corner_standl_trans_out_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][2] = % corner_standl_trans_out_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][3] = % corner_standl_trans_out_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][4] = % ai_spets_corner_stand_l_2_run_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][6] = % ai_spets_corner_stand_l_2_run_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][7] = % corner_standl_trans_out_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_left"][8] = % corner_standl_trans_out_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][1] = % cornercrl_trans_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][2] = % cornercrl_trans_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][3] = % cornercrl_trans_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][4] = % ai_spets_corner_crouch_l_2_run_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][6] = % ai_spets_corner_crouch_l_2_run_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][7] = % cornercrl_trans_out_mf;
  array[animtype]["move"]["stand"]["rifle"]["exit_left_crouch"][8] = % cornercrl_trans_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][1] = % covercrouch_run_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][2] = % covercrouch_run_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][3] = % covercrouch_run_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][4] = % ai_spets_crouch_cover_hide_2_run_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_crouch"][6] = % ai_spets_crouch_cover_hide_2_run_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][1] = % coverstand_trans_out_ml;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][2] = % coverstand_trans_out_m;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][3] = % coverstand_trans_out_mr;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][4] = % ai_spets_stand_cover_hide_2_run_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_stand"][6] = % ai_spets_stand_cover_hide_2_run_6;
  arrivalkeys = getarraykeys(array[animtype]["move"]["stand"]["rifle"]);

  for(i = 0; i < arrivalkeys.size; i++) {
    arrivaltype = arrivalkeys[i];

    if(isarray(array[animtype]["move"]["stand"]["rifle"][arrivaltype]))
      array[animtype]["move"]["crouch"]["rifle"][arrivaltype] = array[animtype]["move"]["stand"]["rifle"][arrivaltype];
  }

  array[animtype]["combat"]["stand"]["rifle"]["melee_0"] = % ai_spets_melee;
  array[animtype]["combat"]["stand"]["rifle"]["stand_2_melee_0"] = % ai_spets_stand_2_melee;
  array[animtype]["combat"]["stand"]["rifle"]["run_2_melee_0"] = % ai_spets_run_2_melee_charge;
  return array;
}

setup_spetsnaz_rusher_anim_array() {
  if(!isDefined(self.anim_array))
    self.anim_array = [];

  assert(isDefined(self.rushertype), "Call this function after setting the rusherType on the AI");

  if(self.rushertype == "default" || self.rushertype == "semi") {
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["run_n_gun_f"] = % ai_spets_rusher_run_f_01;
    self animscripts\anims_table_rusher::setup_default_rusher_anim_array();
  } else if(self.rushertype == "pistol")
    self animscripts\anims_table_rusher::setup_default_rusher_anim_array();
}