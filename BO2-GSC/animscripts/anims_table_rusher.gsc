/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_rusher.gsc
**********************************************/

#include common_scripts\utility;
#include animscripts\anims_table_spetsnaz;
#include animscripts\anims;

setup_rusher_anims() {
  switch (self.animtype) {
    case "spetsnaz":
      self animscripts\anims_table_spetsnaz::setup_spetsnaz_rusher_anim_array();
      break;
    default:
      self setup_default_rusher_anim_array();
      break;
  }

  self animscripts\anims::clearanimcache();
}

reset_rusher_anims() {
  switch (self.animtype) {
    case "default":
    case "spetsnaz":
    case "vc":
      self reset_default_rusher_anim_array();
      break;
  }

  self animscripts\anims::clearanimcache();
}

#using_animtree("generic_human");

setup_default_rusher_anim_array() {
  if(!isDefined(self.anim_array))
    self.anim_array = [];

  assert(isDefined(self.rushertype), "Call this function after setting the rusherType on the AI");

  if(self.rushertype == "default" || self.rushertype == "semi") {
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["step_left_rh"] = array( % ai_spets_rusher_step_45l_2_run_01, % ai_spets_rusher_step_45l_2_run_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["step_left_lh"] = array( % ai_spets_rusher_step_45l_2_run_a_01, % ai_spets_rusher_step_45l_2_run_a_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["step_right_rh"] = array( % ai_spets_rusher_step_45r_2_run_01, % ai_spets_rusher_step_45r_2_run_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["step_right_lh"] = array( % ai_spets_rusher_step_45r_2_run_a_01, % ai_spets_rusher_step_45r_2_run_a_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["roll_left_rh"] = array( % ai_spets_rusher_roll_45l_2_run_01, % ai_spets_rusher_roll_45l_2_run_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["roll_left_lh"] = array( % ai_spets_rusher_roll_45l_2_run_a_01, % ai_spets_rusher_roll_45l_2_run_a_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["roll_right_rh"] = array( % ai_spets_rusher_roll_45r_2_run_01, % ai_spets_rusher_roll_45r_2_run_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["roll_right_lh"] = array( % ai_spets_rusher_roll_45r_2_run_a_01, % ai_spets_rusher_roll_45r_2_run_a_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["roll_forward_rh"] = array( % ai_spets_rusher_roll_forward_01, % ai_spets_rusher_roll_forward_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["roll_forward_lh"] = array( % ai_spets_rusher_roll_forward_01, % ai_spets_rusher_roll_forward_02);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["rusher_run_f_rh"] = array( % ai_spets_rusher_run_f_01, % ai_spets_rusher_run_f_02, % ai_spets_rusher_run_f_03);
    self.anim_array[self.animtype]["move"]["stand"]["rifle"]["rusher_run_f_lh"] = array( % ai_spets_rusher_run_f_a_01, % ai_spets_rusher_run_f_a_02, % ai_spets_rusher_run_f_a_03);
  } else if(self.rushertype == "pistol") {
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["step_left_rh"] = array( % ai_spets_pistol_rusher_step_45l_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["step_left_lh"] = array( % ai_spets_pistol_rusher_step_45l_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["step_right_rh"] = array( % ai_spets_pistol_rusher_step_45r_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["step_right_lh"] = array( % ai_spets_pistol_rusher_step_45r_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["roll_left_rh"] = array( % ai_spets_pistol_rusher_roll_45l_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["roll_left_lh"] = array( % ai_spets_pistol_rusher_roll_45l_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["roll_right_rh"] = array( % ai_spets_pistol_rusher_roll_45r_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["roll_right_lh"] = array( % ai_spets_pistol_rusher_roll_45r_2_run_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["roll_forward_rh"] = array( % ai_spets_pistol_rusher_roll_forward_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["roll_forward_lh"] = array( % ai_spets_pistol_rusher_roll_forward_01);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["rusher_run_f_rh"] = array( % ai_pistol_rusher_run_f);
    self.anim_array[self.animtype]["move"]["stand"]["pistol"]["rusher_run_f_lh"] = array( % ai_pistol_rusher_run_f);
  }
}

reset_default_rusher_anim_array() {
  assert(isDefined(self.anim_array));
  assert(self.rusher == 1, "This AI is not a rusher.");
}