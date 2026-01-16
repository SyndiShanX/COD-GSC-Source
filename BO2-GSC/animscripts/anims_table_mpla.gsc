/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_mpla.gsc
********************************************/

#include common_scripts\utility;
#include animscripts\anims_table_digbats;
#include animscripts\anims;

setup_mpla_anim_array(animtype, array) {
  return animscripts\anims_table_digbats::setup_digbat_anim_array(animtype, array);
}

#using_animtree("generic_human");

setup_melee_mpla_anim_array() {
  self animscripts\anims::clearanimcache();

  if(!isDefined(self.anim_array))
    self.anim_array = [];

  self.anim_array[self.animtype]["combat"]["stand"]["none"]["melee_0"] = % ai_digbat_melee_1;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["stand_2_melee_0"] = % ai_digbat_stand_2_melee_1;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["run_2_melee_0"] = % ai_digbat_run_2_melee_1;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["melee_1"] = % ai_digbat_melee_1;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["stand_2_melee_1"] = % ai_digbat_stand_2_melee_1;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["run_2_melee_1"] = % ai_digbat_run_2_melee_1;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["run_n_gun_f"] = % ai_digbat_melee_run_f;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["combat_run_f"] = % ai_digbat_melee_run_f;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["combat_run_r"] = % ai_digbat_melee_run_f;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["combat_run_l"] = % ai_digbat_melee_run_f;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["combat_run_b"] = % ai_digbat_melee_run_f;
  self.anim_array[self.animtype]["stop"]["stand"]["none"]["idle_trans_in"] = % ai_digbat_melee_casual_idle;
  self.anim_array[self.animtype]["stop"]["stand"]["none"]["idle"] = array(array( % ai_digbat_melee_casual_idle));
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["exposed_idle"] = array( % ai_digbat_melee_idle);
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["straight_level"] = % ai_digbat_melee_fake_aim;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["tactical_walk_f"] = % ai_digbat_melee_run_f;
  self.anim_array[self.animtype]["move"]["stand"]["none"]["start_stand_run_f"] = % ai_digbat_melee_run_f;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_left_45"] = % ai_digbat_melee_tracking_turn45l;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_left_90"] = % ai_digbat_melee_tracking_turn90l;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_left_135"] = % ai_digbat_melee_tracking_turn135l;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_left_180"] = % ai_digbat_melee_tracking_turn180l;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_right_45"] = % ai_digbat_melee_tracking_turn45r;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_right_90"] = % ai_digbat_melee_tracking_turn90r;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_right_135"] = % ai_digbat_melee_tracking_turn135r;
  self.anim_array[self.animtype]["combat"]["stand"]["none"]["turn_right_180"] = % ai_digbat_melee_tracking_turn180l;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_45"] = % ai_digbat_melee_run_f_turn_45_l;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_90"] = % ai_digbat_melee_run_f_turn_90_l;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_135"] = % ai_digbat_melee_run_f_turn_135_l;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_180"] = % ai_digbat_melee_run_f_turn_180_l;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_45"] = % ai_digbat_melee_run_f_turn_45_r;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_90"] = % ai_digbat_melee_run_f_turn_90_r;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_135"] = % ai_digbat_melee_run_f_turn_135_r;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_180"] = % ai_digbat_melee_run_f_turn_180_r;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_b_l_180"] = % ai_digbat_melee_run_f_turn_180_l;
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_b_r_180"] = % ai_digbat_melee_run_f_turn_180_r;
  self.anim_array[self.animtype]["flashed"]["stand"]["none"]["flashed"] = array( % ai_digbat_melee_idle_pain_01, % ai_digbat_melee_idle_pain_02);
  self.anim_array[self.animtype]["flashed"]["crouch"]["none"]["flashed"] = array( % ai_digbat_melee_idle_pain_01, % ai_digbat_melee_idle_pain_02);
  self.anim_array[self.animtype]["flashed"]["prone"]["none"]["flashed"] = array( % ai_digbat_melee_idle_pain_01, % ai_digbat_melee_idle_pain_02);
}