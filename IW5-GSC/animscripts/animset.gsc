/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\animset.gsc
**************************************/

init_anim_sets() {
  anim.animsets = spawnStruct();
  anim.animsets.move = [];
  init_animset_default_stand();
  init_animset_cqb_stand();
  init_animset_pistol_stand();
  init_animset_rpg_stand();
  init_animset_shotgun_stand();
  init_animset_heat_stand();
  init_animset_default_crouch();
  init_animset_rpg_crouch();
  init_animset_shotgun_crouch();
  init_animset_default_prone();
  init_animset_run_move();
  init_animset_walk_move();
  init_animset_cqb_move();
  init_animset_heat_run_move();
  init_moving_turn_animations();
}

#using_animtree("generic_human");

init_animset_run_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % sprint_loop_distant;
  anim.initanimset["sprint_short"] = % sprint1_loop;
  anim.initanimset["prone"] = % prone_crawl;
  anim.initanimset["straight"] = % run_lowready_f;
  anim.initanimset["move_f"] = % walk_forward;
  anim.initanimset["move_l"] = % walk_left;
  anim.initanimset["move_r"] = % walk_right;
  anim.initanimset["move_b"] = % walk_backward;
  anim.initanimset["crouch"] = % crouch_fastwalk_f;
  anim.initanimset["crouch_l"] = % crouch_fastwalk_l;
  anim.initanimset["crouch_r"] = % crouch_fastwalk_r;
  anim.initanimset["crouch_b"] = % crouch_fastwalk_b;
  anim.initanimset["stairs_up"] = % traverse_stair_run_01;
  anim.initanimset["stairs_down"] = % traverse_stair_run_down;
  anim.animsets.move["run"] = anim.initanimset;
}

init_animset_heat_run_move() {
  anim.initanimset = anim.animsets.move["run"];
  anim.initanimset["straight"] = % heat_run_loop;
  anim.animsets.move["heat_run"] = anim.initanimset;
}

init_animset_walk_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % sprint_loop_distant;
  anim.initanimset["sprint_short"] = % sprint1_loop;
  anim.initanimset["prone"] = % prone_crawl;
  anim.initanimset["straight"] = % walk_cqb_f;
  anim.initanimset["move_f"] = % walk_cqb_f;
  anim.initanimset["move_l"] = % walk_left;
  anim.initanimset["move_r"] = % walk_right;
  anim.initanimset["move_b"] = % walk_backward;
  anim.initanimset["crouch"] = % crouch_fastwalk_f;
  anim.initanimset["crouch_l"] = % crouch_fastwalk_l;
  anim.initanimset["crouch_r"] = % crouch_fastwalk_r;
  anim.initanimset["crouch_b"] = % crouch_fastwalk_b;
  anim.initanimset["stairs_up"] = % traverse_stair_run;
  anim.initanimset["stairs_down"] = % traverse_stair_run_down_01;
  anim.animsets.move["walk"] = anim.initanimset;
}

init_animset_cqb_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % sprint_loop_distant;
  anim.initanimset["sprint_short"] = % sprint1_loop;
  anim.initanimset["straight"] = % run_cqb_f_search_v1;
  anim.initanimset["move_f"] = % walk_cqb_f;
  anim.initanimset["move_l"] = % walk_left;
  anim.initanimset["move_r"] = % walk_right;
  anim.initanimset["move_b"] = % walk_backward;
  anim.initanimset["stairs_up"] = % traverse_stair_run;
  anim.initanimset["stairs_down"] = % traverse_stair_run_down_01;
  anim.animsets.move["cqb"] = anim.initanimset;
}

init_animset_pistol_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % pistol_stand_aim_8_add;
  anim.initanimset["add_aim_down"] = % pistol_stand_aim_2_add;
  anim.initanimset["add_aim_left"] = % pistol_stand_aim_4_add;
  anim.initanimset["add_aim_right"] = % pistol_stand_aim_6_add;
  anim.initanimset["straight_level"] = % pistol_stand_aim_5;
  anim.initanimset["fire"] = % pistol_stand_fire_a;
  anim.initanimset["single"] = animscripts\utility::array(%pistol_stand_fire_a);
  anim.initanimset["reload"] = animscripts\utility::array(%pistol_stand_reload_a);
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array();
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  set_animarray_standing_turns_pistol();
  anim.initanimset["add_turn_aim_up"] = % pistol_stand_aim_8_alt;
  anim.initanimset["add_turn_aim_down"] = % pistol_stand_aim_2_alt;
  anim.initanimset["add_turn_aim_left"] = % pistol_stand_aim_4_alt;
  anim.initanimset["add_turn_aim_right"] = % pistol_stand_aim_6_alt;
  anim.animsets.pistolstand = anim.initanimset;
}

init_animset_rpg_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % rpg_stand_aim_8;
  anim.initanimset["add_aim_down"] = % rpg_stand_aim_2;
  anim.initanimset["add_aim_left"] = % rpg_stand_aim_4;
  anim.initanimset["add_aim_right"] = % rpg_stand_aim_6;
  anim.initanimset["straight_level"] = % rpg_stand_aim_5;
  anim.initanimset["fire"] = % rpg_stand_fire;
  anim.initanimset["single"] = animscripts\utility::array(%exposed_shoot_semi1);
  anim.initanimset["reload"] = animscripts\utility::array(%rpg_stand_reload);
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array();
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%rpg_stand_idle);
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.animsets.rpgstand = anim.initanimset;
}

init_animset_shotgun_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % shotgun_aim_8;
  anim.initanimset["add_aim_down"] = % shotgun_aim_2;
  anim.initanimset["add_aim_left"] = % shotgun_aim_4;
  anim.initanimset["add_aim_right"] = % shotgun_aim_6;
  anim.initanimset["straight_level"] = % shotgun_aim_5;
  anim.initanimset["fire"] = % exposed_shoot_auto_v3;
  anim.initanimset["single"] = animscripts\utility::array(%shotgun_stand_fire_1a, %shotgun_stand_fire_1b);
  set_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  anim.initanimset["reload"] = animscripts\utility::array(%shotgun_stand_reload_a, %shotgun_stand_reload_b, %shotgun_stand_reload_c, %shotgun_stand_reload_c, %shotgun_stand_reload_c);
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array(%shotgun_stand_reload_a, %shotgun_stand_reload_b);
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.animsets.shotgunstand = anim.initanimset;
}

init_animset_cqb_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % cqb_stand_aim8;
  anim.initanimset["add_aim_down"] = % cqb_stand_aim2;
  anim.initanimset["add_aim_left"] = % cqb_stand_aim4;
  anim.initanimset["add_aim_right"] = % cqb_stand_aim6;
  anim.initanimset["straight_level"] = % cqb_stand_aim5;
  anim.initanimset["fire"] = % exposed_shoot_auto_v3;
  anim.initanimset["single"] = animscripts\utility::array(%exposed_shoot_semi1);
  set_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  anim.initanimset["reload"] = animscripts\utility::array(%cqb_stand_reload_steady);
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array(%cqb_stand_reload_knee);
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.animsets.cqbstand = anim.initanimset;
}

init_animset_heat_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % heat_stand_aim_8;
  anim.initanimset["add_aim_down"] = % heat_stand_aim_2;
  anim.initanimset["add_aim_left"] = % heat_stand_aim_4;
  anim.initanimset["add_aim_right"] = % heat_stand_aim_6;
  anim.initanimset["straight_level"] = % heat_stand_aim_5;
  anim.initanimset["fire"] = % heat_stand_fire_auto;
  anim.initanimset["single"] = animscripts\utility::array(%heat_stand_fire_single);
  set_animarray_custom_burst_and_semi_fire_stand(%heat_stand_fire_burst);
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%heat_stand_idle, %heat_stand_scana, %heat_stand_scanb);
  anim.initanimset["reload"] = animscripts\utility::array(%heat_exposed_reload);
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array();
  set_animarray_stance_change();
  anim.initanimset["turn_left_45"] = % heat_stand_turn_l;
  anim.initanimset["turn_left_90"] = % heat_stand_turn_l;
  anim.initanimset["turn_left_135"] = % heat_stand_turn_180;
  anim.initanimset["turn_left_180"] = % heat_stand_turn_180;
  anim.initanimset["turn_right_45"] = % heat_stand_turn_r;
  anim.initanimset["turn_right_90"] = % heat_stand_turn_r;
  anim.initanimset["turn_right_135"] = % heat_stand_turn_180;
  anim.initanimset["turn_right_180"] = % heat_stand_turn_180;
  set_animarray_add_turn_aims_stand();
  anim.animsets.heatstand = anim.initanimset;
}

init_animset_default_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % exposed_aim_8;
  anim.initanimset["add_aim_down"] = % exposed_aim_2;
  anim.initanimset["add_aim_left"] = % exposed_aim_4;
  anim.initanimset["add_aim_right"] = % exposed_aim_6;
  anim.initanimset["straight_level"] = % exposed_aim_5;
  anim.initanimset["fire"] = % exposed_shoot_auto_v3;
  anim.initanimset["single"] = animscripts\utility::array(%exposed_shoot_semi1);
  set_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  anim.initanimset["exposed_grenade"] = animscripts\utility::array(%exposed_grenadethrowb, %exposed_grenadethrowc);
  anim.initanimset["reload"] = animscripts\utility::array(%exposed_reload);
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array(%exposed_reloadb);
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.animsets.defaultstand = anim.initanimset;
}

init_animset_default_crouch() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % exposed_crouch_aim_8;
  anim.initanimset["add_aim_down"] = % exposed_crouch_aim_2;
  anim.initanimset["add_aim_left"] = % exposed_crouch_aim_4;
  anim.initanimset["add_aim_right"] = % exposed_crouch_aim_6;
  anim.initanimset["straight_level"] = % exposed_crouch_aim_5;
  anim.initanimset["fire"] = % exposed_crouch_shoot_auto_v2;
  anim.initanimset["single"] = animscripts\utility::array(%exposed_crouch_shoot_semi1);
  set_animarray_burst_and_semi_fire_crouch();
  anim.initanimset["reload"] = animscripts\utility::array(%exposed_crouch_reload);
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  set_animarray_stance_change();
  set_animarray_crouching_turns();
  set_animarray_add_turn_aims_crouch();
  anim.animsets.defaultcrouch = anim.initanimset;
}

init_animset_rpg_crouch() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % rpg_crouch_aim_8;
  anim.initanimset["add_aim_down"] = % rpg_crouch_aim_2;
  anim.initanimset["add_aim_left"] = % rpg_crouch_aim_4;
  anim.initanimset["add_aim_right"] = % rpg_crouch_aim_6;
  anim.initanimset["straight_level"] = % rpg_crouch_aim_5;
  anim.initanimset["fire"] = % rpg_crouch_fire;
  anim.initanimset["single"] = animscripts\utility::array(%rpg_crouch_fire);
  anim.initanimset["reload"] = animscripts\utility::array(%rpg_crouch_reload);
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%rpg_crouch_idle);
  set_animarray_stance_change();
  set_animarray_crouching_turns();
  set_animarray_add_turn_aims_crouch();
  anim.animsets.rpgcrouch = anim.initanimset;
}

init_animset_shotgun_crouch() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % exposed_crouch_aim_8;
  anim.initanimset["add_aim_down"] = % exposed_crouch_aim_2;
  anim.initanimset["add_aim_left"] = % exposed_crouch_aim_4;
  anim.initanimset["add_aim_right"] = % exposed_crouch_aim_6;
  anim.initanimset["straight_level"] = % exposed_crouch_aim_5;
  anim.initanimset["fire"] = % exposed_crouch_shoot_auto_v2;
  anim.initanimset["single"] = animscripts\utility::array(%shotgun_crouch_fire);
  set_animarray_burst_and_semi_fire_crouch();
  anim.initanimset["reload"] = animscripts\utility::array(%shotgun_crouch_reload);
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  set_animarray_stance_change();
  set_animarray_crouching_turns();
  set_animarray_add_turn_aims_crouch();
  anim.animsets.shotguncrouch = anim.initanimset;
}

init_animset_default_prone() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % prone_aim_8_add;
  anim.initanimset["add_aim_down"] = % prone_aim_2_add;
  anim.initanimset["add_aim_left"] = % prone_aim_4_add;
  anim.initanimset["add_aim_right"] = % prone_aim_6_add;
  anim.initanimset["straight_level"] = % prone_aim_5;
  anim.initanimset["fire"] = % prone_fire_1;
  anim.initanimset["single"] = animscripts\utility::array(%prone_fire_1);
  anim.initanimset["reload"] = animscripts\utility::array(%prone_reload);
  anim.initanimset["burst2"] = % prone_fire_burst;
  anim.initanimset["burst3"] = % prone_fire_burst;
  anim.initanimset["burst4"] = % prone_fire_burst;
  anim.initanimset["burst5"] = % prone_fire_burst;
  anim.initanimset["burst6"] = % prone_fire_burst;
  anim.initanimset["semi2"] = % prone_fire_burst;
  anim.initanimset["semi3"] = % prone_fire_burst;
  anim.initanimset["semi4"] = % prone_fire_burst;
  anim.initanimset["semi5"] = % prone_fire_burst;
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  set_animarray_stance_change();
  anim.animsets.defaultprone = anim.initanimset;
}

init_animset_complete_custom_stand(var_0) {
  self.combatstandanims = var_0;
}

init_animset_custom_stand(var_0, var_1, var_2, var_3) {
  anim.initanimset = anim.animsets.defaultstand;

  if(isDefined(var_1)) {
    anim.initanimset["straight_level"] = var_1;
  }
  if(isDefined(var_0)) {
    anim.initanimset["fire"] = var_0;
    anim.initanimset["single"] = animscripts\utility::array(var_0);
    set_animarray_custom_burst_and_semi_fire_stand(var_0);
  }

  if(isDefined(var_2)) {
    anim.initanimset["exposed_idle"] = animscripts\utility::array(var_2);
  }
  if(isDefined(var_3)) {
    anim.initanimset["reload"] = animscripts\utility::array(var_3);
    anim.initanimset["reload_crouchhide"] = animscripts\utility::array(var_3);
  }

  self.combatstandanims = anim.initanimset;
}

init_animset_complete_custom_crouch(var_0) {
  self.combatcrouchanims = var_0;
}

init_animset_custom_crouch(var_0, var_1, var_2) {
  anim.initanimset = anim.animsets.defaultcrouch;

  if(isDefined(var_0)) {
    anim.initanimset["fire"] = var_0;
    anim.initanimset["single"] = animscripts\utility::array(var_0);
    set_animarray_custom_burst_and_semi_fire_crouch(var_0);
  }

  if(isDefined(var_1)) {
    anim.initanimset["exposed_idle"] = animscripts\utility::array(var_1);
  }
  if(isDefined(var_2)) {
    anim.initanimset["reload"] = animscripts\utility::array(var_2);
  }
  self.combatcrouchanims = anim.initanimset;
}

clear_custom_animset() {
  self.custommoveanimset = undefined;
  self.customidleanimset = undefined;
  self.combatstandanims = undefined;
  self.combatcrouchanims = undefined;
}

set_animarray_standing_turns_pistol(var_0) {
  anim.initanimset["turn_left_45"] = % pistol_stand_turn45l;
  anim.initanimset["turn_left_90"] = % pistol_stand_turn90l;
  anim.initanimset["turn_left_135"] = % pistol_stand_turn90l;
  anim.initanimset["turn_left_180"] = % pistol_stand_turn180l;
  anim.initanimset["turn_right_45"] = % pistol_stand_turn45r;
  anim.initanimset["turn_right_90"] = % pistol_stand_turn90r;
  anim.initanimset["turn_right_135"] = % pistol_stand_turn90r;
  anim.initanimset["turn_right_180"] = % pistol_stand_turn180l;
}

set_animarray_standing_turns() {
  anim.initanimset["turn_left_45"] = % exposed_tracking_turn45l;
  anim.initanimset["turn_left_90"] = % exposed_tracking_turn90l;
  anim.initanimset["turn_left_135"] = % exposed_tracking_turn135l;
  anim.initanimset["turn_left_180"] = % exposed_tracking_turn180l;
  anim.initanimset["turn_right_45"] = % exposed_tracking_turn45r;
  anim.initanimset["turn_right_90"] = % exposed_tracking_turn90r;
  anim.initanimset["turn_right_135"] = % exposed_tracking_turn135r;
  anim.initanimset["turn_right_180"] = % exposed_tracking_turn180r;
}

set_animarray_crouching_turns() {
  anim.initanimset["turn_left_45"] = % exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_90"] = % exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_135"] = % exposed_crouch_turn_180_left;
  anim.initanimset["turn_left_180"] = % exposed_crouch_turn_180_left;
  anim.initanimset["turn_right_45"] = % exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_90"] = % exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_135"] = % exposed_crouch_turn_180_right;
  anim.initanimset["turn_right_180"] = % exposed_crouch_turn_180_right;
}

set_animarray_stance_change() {
  anim.initanimset["crouch_2_stand"] = % exposed_crouch_2_stand;
  anim.initanimset["crouch_2_prone"] = % crouch_2_prone;
  anim.initanimset["stand_2_crouch"] = % exposed_stand_2_crouch;
  anim.initanimset["stand_2_prone"] = % stand_2_prone;
  anim.initanimset["prone_2_crouch"] = % prone_2_crouch;
  anim.initanimset["prone_2_stand"] = % prone_2_stand;
}

set_animarray_burst_and_semi_fire_stand() {
  anim.initanimset["burst2"] = % exposed_shoot_burst3;
  anim.initanimset["burst3"] = % exposed_shoot_burst3;
  anim.initanimset["burst4"] = % exposed_shoot_burst4;
  anim.initanimset["burst5"] = % exposed_shoot_burst5;
  anim.initanimset["burst6"] = % exposed_shoot_burst6;
  anim.initanimset["semi2"] = % exposed_shoot_semi2;
  anim.initanimset["semi3"] = % exposed_shoot_semi3;
  anim.initanimset["semi4"] = % exposed_shoot_semi4;
  anim.initanimset["semi5"] = % exposed_shoot_semi5;
}

set_animarray_custom_burst_and_semi_fire_stand(var_0) {
  anim.initanimset["burst2"] = var_0;
  anim.initanimset["burst3"] = var_0;
  anim.initanimset["burst4"] = var_0;
  anim.initanimset["burst5"] = var_0;
  anim.initanimset["burst6"] = var_0;
  anim.initanimset["semi2"] = var_0;
  anim.initanimset["semi3"] = var_0;
  anim.initanimset["semi4"] = var_0;
  anim.initanimset["semi5"] = var_0;
}

set_animarray_burst_and_semi_fire_crouch() {
  anim.initanimset["burst2"] = % exposed_crouch_shoot_burst3;
  anim.initanimset["burst3"] = % exposed_crouch_shoot_burst3;
  anim.initanimset["burst4"] = % exposed_crouch_shoot_burst4;
  anim.initanimset["burst5"] = % exposed_crouch_shoot_burst5;
  anim.initanimset["burst6"] = % exposed_crouch_shoot_burst6;
  anim.initanimset["semi2"] = % exposed_crouch_shoot_semi2;
  anim.initanimset["semi3"] = % exposed_crouch_shoot_semi3;
  anim.initanimset["semi4"] = % exposed_crouch_shoot_semi4;
  anim.initanimset["semi5"] = % exposed_crouch_shoot_semi5;
}

set_animarray_custom_burst_and_semi_fire_crouch(var_0) {
  anim.initanimset["burst2"] = var_0;
  anim.initanimset["burst3"] = var_0;
  anim.initanimset["burst4"] = var_0;
  anim.initanimset["burst5"] = var_0;
  anim.initanimset["burst6"] = var_0;
  anim.initanimset["semi2"] = var_0;
  anim.initanimset["semi3"] = var_0;
  anim.initanimset["semi4"] = var_0;
  anim.initanimset["semi5"] = var_0;
}

set_animarray_add_turn_aims_stand() {
  anim.initanimset["add_turn_aim_up"] = % exposed_turn_aim_8;
  anim.initanimset["add_turn_aim_down"] = % exposed_turn_aim_2;
  anim.initanimset["add_turn_aim_left"] = % exposed_turn_aim_4;
  anim.initanimset["add_turn_aim_right"] = % exposed_turn_aim_6;
}

set_animarray_add_turn_aims_crouch() {
  anim.initanimset["add_turn_aim_up"] = % exposed_crouch_turn_aim_8;
  anim.initanimset["add_turn_aim_down"] = % exposed_crouch_turn_aim_2;
  anim.initanimset["add_turn_aim_left"] = % exposed_crouch_turn_aim_4;
  anim.initanimset["add_turn_aim_right"] = % exposed_crouch_turn_aim_6;
}

set_animarray_standing() {
  if(animscripts\utility::usingsidearm()) {
    self.a.array = anim.animsets.pistolstand;
  } else if(isDefined(self.combatstandanims)) {
    self.a.array = self.combatstandanims;
  } else if(isDefined(self.heat)) {
    self.a.array = anim.animsets.heatstand;
  } else if(animscripts\utility::usingrocketlauncher()) {
    self.a.array = anim.animsets.rpgstand;
  } else if(isDefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun()) {
    self.a.array = anim.animsets.shotgunstand;
  } else if(animscripts\utility::iscqbwalking()) {
    self.a.array = anim.animsets.cqbstand;
  } else {
    self.a.array = anim.animsets.defaultstand;
  }
}

set_animarray_crouching() {
  if(animscripts\utility::usingsidearm()) {
    animscripts\shared::placeweaponon(self.primaryweapon, "right");
  }
  if(isDefined(self.combatcrouchanims)) {
    self.a.array = self.combatcrouchanims;
  } else if(animscripts\utility::usingrocketlauncher()) {
    self.a.array = anim.animsets.rpgcrouch;
  } else if(isDefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun()) {
    self.a.array = anim.animsets.shotguncrouch;
  } else {
    self.a.array = anim.animsets.defaultcrouch;
  }
}

set_animarray_prone() {
  if(animscripts\utility::usingsidearm()) {
    animscripts\shared::placeweaponon(self.primaryweapon, "right");
  }
  self.a.array = anim.animsets.defaultprone;
}

init_moving_turn_animations() {
  anim.runturnanims["L90"] = % run_turn_l90;
  anim.runturnanims["R90"] = % run_turn_r90;
  anim.runturnanims["L45"] = % run_turn_l45;
  anim.runturnanims["R45"] = % run_turn_r45;
  anim.runturnanims["L135"] = % run_turn_l135;
  anim.runturnanims["R135"] = % run_turn_r135;
  anim.runturnanims["180"] = % run_turn_180;
  anim.cqbturnanims["L90"] = % cqb_walk_turn_4;
  anim.cqbturnanims["R90"] = % cqb_walk_turn_6;
  anim.cqbturnanims["L45"] = % cqb_walk_turn_7;
  anim.cqbturnanims["R45"] = % cqb_walk_turn_9;
  anim.cqbturnanims["L135"] = % cqb_walk_turn_1;
  anim.cqbturnanims["R135"] = % cqb_walk_turn_3;
  anim.cqbturnanims["180"] = % cqb_walk_turn_2;
}

set_animset_run_n_gun() {
  self.maxrunngunangle = 130;
  self.runnguntransitionpoint = 0.461538;
  self.runngunincrement = 0.3;
  self.runngunanims["F"] = % run_n_gun_f;
  self.runngunanims["L"] = % run_n_gun_l;
  self.runngunanims["R"] = % run_n_gun_r;
  self.runngunanims["LB"] = % run_n_gun_l_120;
  self.runngunanims["RB"] = % run_n_gun_r_120;
}

set_ambush_sidestep_anims() {
  self.a.moveanimset["move_l"] = % combatwalk_l;
  self.a.moveanimset["move_r"] = % combatwalk_r;
  self.a.moveanimset["move_b"] = % combatwalk_b;
}

heat_reload_anim() {
  if(self.weapon != self.primaryweapon) {
    return animscripts\utility::animarraypickrandom("reload");
  }
  if(isDefined(self.node)) {
    if(self nearclaimnodeandangle()) {
      var_0 = undefined;

      if(self.node.type == "Cover Left") {
        var_0 = % heat_cover_reload_r;
      } else if(self.node.type == "Cover Right") {
        var_0 = % heat_cover_reload_l;
      }
      if(isDefined(var_0)) {
        return var_0;
      }
    }
  }

  return % heat_exposed_reload;
}