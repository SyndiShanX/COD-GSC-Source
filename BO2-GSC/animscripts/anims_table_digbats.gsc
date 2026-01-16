/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_digbats.gsc
***********************************************/

#include common_scripts\utility;
#include animscripts\anims;
#using_animtree("generic_human");

setup_digbat_anim_array(animtype, array) {
  assert(isDefined(array) && isarray(array));
  array[animtype]["stop"]["stand"]["rifle"]["idle"] = array(array( % ai_digbat_casual_stand_idle, % ai_digbat_casual_stand_idle, % ai_digbat_casual_stand_idle_twitch, % ai_digbat_casual_stand_idle_twitchb), array( % ai_digbat_casual_stand_v2_idle, % ai_digbat_casual_stand_v2_twitch_shift));
  array[animtype]["combat"]["stand"]["rifle"]["idle_trans_out"] = % ai_digbat_casual_stand_idle_trans_in;
  array[animtype]["combat"]["stand"]["rifle"]["exposed_idle"] = array( % ai_digbat_exposed_idle_alert_v2, % ai_digbat_exposed_idle_alert_v3);
  array[animtype]["combat"]["stand"]["rifle"]["fire"] = % ai_digbat_exposed_shoot_auto_v3;
  array[animtype]["combat"]["stand"]["rifle"]["single"] = array( % ai_digbat_exposed_shoot_semi2);
  array[animtype]["combat"]["stand"]["rifle"]["burst2"] = % ai_digbat_exposed_shoot_burst3;
  array[animtype]["combat"]["stand"]["rifle"]["burst3"] = % ai_digbat_exposed_shoot_burst3;
  array[animtype]["combat"]["stand"]["rifle"]["burst4"] = % ai_digbat_exposed_shoot_burst4;
  array[animtype]["combat"]["stand"]["rifle"]["burst5"] = % ai_digbat_exposed_shoot_burst5;
  array[animtype]["combat"]["stand"]["rifle"]["burst6"] = % ai_digbat_exposed_shoot_burst6;
  array[animtype]["combat"]["stand"]["rifle"]["semi2"] = % ai_digbat_exposed_shoot_semi2;
  array[animtype]["combat"]["stand"]["rifle"]["semi3"] = % ai_digbat_exposed_shoot_semi3;
  array[animtype]["combat"]["stand"]["rifle"]["semi4"] = % ai_digbat_exposed_shoot_semi4;
  array[animtype]["combat"]["stand"]["rifle"]["semi5"] = % ai_digbat_exposed_shoot_semi5;
  array[animtype]["combat"]["stand"]["rifle"]["exposed_rambo"] = array( % ai_digbat_stand_exposed_rambo_2, % ai_digbat_stand_exposed_rambo_3);
  array[animtype]["combat"]["stand"]["rifle"]["reload"] = array( % ai_digbat_exposed_reload);
  array[animtype]["combat"]["stand"]["rifle"]["reload_crouchhide"] = array( % ai_digbat_exposed_reload);
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_45"] = % ai_digbat_exposed_tracking_turn45l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_90"] = % ai_digbat_exposed_tracking_turn90l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_135"] = % ai_digbat_exposed_tracking_turn135l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_left_180"] = % ai_digbat_exposed_tracking_turn180l;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_45"] = % ai_digbat_exposed_tracking_turn45r;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_90"] = % ai_digbat_exposed_tracking_turn90r;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_135"] = % ai_digbat_exposed_tracking_turn135r;
  array[animtype]["combat"]["stand"]["rifle"]["turn_right_180"] = % ai_digbat_exposed_tracking_turn180l;
  array[animtype]["combat"]["stand"]["rifle"]["straight_level"] = % ai_digbat_exposed_aim_5;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_up"] = % ai_digbat_exposed_aim_8;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_down"] = % ai_digbat_exposed_aim_2;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_left"] = % ai_digbat_exposed_aim_4;
  array[animtype]["combat"]["stand"]["rifle"]["add_aim_right"] = % ai_digbat_exposed_aim_6;
  array[animtype]["combat"]["stand"]["rifle"]["grenade_throw_1"] = % ai_digbat_exposed_grenadethrowb;
  array[animtype]["combat"]["stand"]["rifle"]["grenade_throw_2"] = % ai_digbat_exposed_grenadethrowb;
  array[animtype]["combat"]["stand"]["rifle"]["crouch_2_stand"] = % ai_digbat_exposed_crouch_2_stand;
  array[animtype]["combat"]["crouch"]["rifle"]["crouch_2_stand"] = % ai_digbat_exposed_crouch_2_stand;
  array[animtype]["death"]["crouch"]["rifle"]["front"] = % ai_digbat_exposed_crouch_death_fetal;
  array[animtype]["death"]["crouch"]["rifle"]["front_2"] = % ai_digbat_exposed_crouch_death_twist;
  array[animtype]["death"]["crouch"]["rifle"]["front_3"] = % ai_digbat_exposed_crouch_death_flip;
  array[animtype]["pain"]["stand"]["rifle"]["big"] = % ai_digbat_exposed_pain_dropgun;
  array[animtype]["pain"]["stand"]["rifle"]["drop_gun"] = % ai_digbat_exposed_pain_dropgun;
  array[animtype]["pain"]["stand"]["rifle"]["chest"] = % ai_digbat_exposed_pain_back;
  array[animtype]["pain"]["stand"]["rifle"]["groin"] = % ai_digbat_exposed_pain_groin;
  array[animtype]["pain"]["stand"]["rifle"]["left_arm"] = % ai_digbat_exposed_pain_left_arm;
  array[animtype]["pain"]["stand"]["rifle"]["right_arm"] = % ai_digbat_exposed_pain_right_arm;
  array[animtype]["pain"]["stand"]["rifle"]["leg"] = % ai_digbat_exposed_pain_leg;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][1] = % ai_digbat_exposed_arrival_1;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][2] = % ai_digbat_exposed_arrival_2;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][3] = % ai_digbat_exposed_arrival_3;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][4] = % ai_digbat_exposed_arrival_4;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][6] = % ai_digbat_exposed_arrival_6;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][7] = % ai_digbat_exposed_arrival_7;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][8] = % ai_digbat_exposed_arrival_8;
  array[animtype]["move"]["stand"]["rifle"]["arrive_exposed"][9] = % ai_digbat_exposed_arrival_9;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][1] = % ai_digbat_exposed_exit_1;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][2] = % ai_digbat_exposed_exit_2;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][3] = % ai_digbat_exposed_exit_3;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][4] = % ai_digbat_exposed_exit_4;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][6] = % ai_digbat_exposed_exit_6;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][7] = % ai_digbat_exposed_exit_7;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][8] = % ai_digbat_exposed_exit_8;
  array[animtype]["move"]["stand"]["rifle"]["exit_exposed"][9] = % ai_digbat_exposed_exit_9;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_f"] = % ai_digbat_run_lowready_f;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_r"] = % ai_digbat_run_lowready_r;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_l"] = % ai_digbat_run_lowready_l;
  array[animtype]["move"]["stand"]["rifle"]["combat_run_b"] = % ai_digbat_run_lowready_b;
  array[animtype]["move"]["stand"]["rifle"]["reload"] = array( % ai_digbat_run_twitch_1, % ai_digbat_run_twitch_2, % run_lowready_reload);
  return array;
}

setup_melee_digbat_anim_array() {
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