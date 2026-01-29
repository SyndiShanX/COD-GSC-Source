/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\animset.gsc
*****************************************************/

init_anim_sets() {
  if(isDefined(anim.archetypes)) {
    return;
  }
  anim.archetypes = [];
  anim.archetypes["soldier"] = [];
  animscripts\cover_left::init_animset_cover_left();
  animscripts\cover_right::init_animset_cover_right();
  animscripts\cover_prone::init_animset_cover_prone();
  animscripts\cover_multi::init_animset_cover_multi();
  animscripts\cover_wall::init_animset_cover_wall();
  animscripts\reactions::init_animset_reactions();
  animscripts\pain::init_animset_pain();
  animscripts\death::init_animset_death();
  animscripts\combat::init_animset_combat();
  animscripts\move::init_animset_move();
  animscripts\flashed::init_animset_flashed();
  animscripts\stop::init_animset_idle();
  animscripts\melee::init_animset_melee();
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
  init_exposed_turn_animations();
  init_animset_heat_reload();
  init_grenade_animations();
  init_animset_run_n_gun();
  init_animset_ambush();
}

registerarchetype(var_0, var_1, var_2) {
  init_anim_sets();
  anim.archetypes[var_0] = var_1;

  if(isDefined(var_1["flashed"]))
    anim.flashanimindex[var_0] = 0;

  if(isDefined(var_2) && var_2)
    animscripts\init_move_transitions::getsplittimes(var_0);
}

archetypeexists(var_0) {
  return isDefined(anim.archetypes[var_0]);
}

#using_animtree("generic_human");

init_animset_run_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % sprint_loop_distant;
  anim.initanimset["sprint_short"] = % sprint1_loop;
  anim.initanimset["prone"] = % prone_crawl;
  anim.initanimset["straight"] = % run_lowready_f;
  anim.initanimset["straight_twitch"] = [%run_twitch_guncheck, %run_twitch_aim_straight, %run_twitch_aim_above, %run_twitch_lookbehind_a, %run_twitch_lookbehind_b];
  anim.initanimset["move_f"] = % walk_forward;
  anim.initanimset["move_l"] = % walk_left;
  anim.initanimset["move_r"] = % walk_right;
  anim.initanimset["move_b"] = % walk_backward;
  anim.initanimset["crouch"] = % crouch_fastwalk_f;
  anim.initanimset["crouch_l"] = % crouch_fastwalk_l;
  anim.initanimset["crouch_r"] = % crouch_fastwalk_r;
  anim.initanimset["crouch_b"] = % crouch_fastwalk_b;
  anim.initanimset["stairs_up"] = % run_stairs_up;
  anim.initanimset["stairs_up_in"] = % run_stairs_up_in;
  anim.initanimset["stairs_up_out"] = % run_stairs_up_out;
  anim.initanimset["stairs_down"] = % traverse_stair_run_down;
  anim.initanimset["reload"] = [%run_reload_a, %run_reload_b];
  anim.archetypes["soldier"]["run"] = anim.initanimset;
}

init_animset_heat_run_move() {
  anim.initanimset = anim.archetypes["soldier"]["run"];
  anim.initanimset["straight"] = % heat_run_loop;
  anim.archetypes["soldier"]["heat_run"] = anim.initanimset;
}

init_animset_walk_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % sprint_loop_distant;
  anim.initanimset["sprint_short"] = % sprint1_loop;
  anim.initanimset["prone"] = % prone_crawl;
  anim.initanimset["straight"] = % cqb_walk_iw6;
  anim.initanimset["move_f"] = % cqb_walk_iw6;
  anim.initanimset["move_l"] = % walk_left;
  anim.initanimset["move_r"] = % walk_right;
  anim.initanimset["move_b"] = % walk_backward;
  anim.initanimset["crouch"] = % crouch_fastwalk_f;
  anim.initanimset["crouch_l"] = % crouch_fastwalk_l;
  anim.initanimset["crouch_r"] = % crouch_fastwalk_r;
  anim.initanimset["crouch_b"] = % crouch_fastwalk_b;
  anim.initanimset["aim_2"] = % walk_aim_2;
  anim.initanimset["aim_4"] = % walk_aim_4;
  anim.initanimset["aim_6"] = % walk_aim_6;
  anim.initanimset["aim_8"] = % walk_aim_8;
  anim.initanimset["stairs_up"] = % traverse_stair_run;
  anim.initanimset["stairs_down"] = % traverse_stair_run_down_01;
  anim.archetypes["soldier"]["walk"] = anim.initanimset;
}

init_animset_cqb_move() {
  anim.initanimset = [];
  anim.initanimset["sprint"] = % sprint_loop_distant;
  anim.initanimset["sprint_short"] = % sprint1_loop;
  anim.initanimset["straight"] = % run_cqb_f_search_v1;
  anim.initanimset["straight_twitch"] = [%cqb_run_twitch_a_iw6, %cqb_run_twitch_b_iw6, %cqb_run_twitch_c_iw6, %cqb_run_twitch_d_iw6];
  anim.initanimset["move_f"] = % cqb_walk_iw6;
  anim.initanimset["move_l"] = % walk_left;
  anim.initanimset["move_r"] = % walk_right;
  anim.initanimset["move_b"] = % walk_backward;
  anim.initanimset["aim_2"] = % cqb_run_aim_2;
  anim.initanimset["aim_4"] = % cqb_run_aim_4;
  anim.initanimset["aim_5"] = % cqb_run_aim_5;
  anim.initanimset["aim_6"] = % cqb_run_aim_6;
  anim.initanimset["aim_8"] = % cqb_run_aim_8;
  anim.initanimset["stairs_up"] = % traverse_stair_run;
  anim.initanimset["stairs_down_in"] = % cqb_stairs_down_in_m;
  anim.initanimset["stairs_down"] = % cqb_stairs_down;
  anim.initanimset["stairs_down_out"] = % cqb_stairs_down_out_m;
  anim.initanimset["shotgun_pullout"] = % shotgun_cqbrun_pullout;
  anim.initanimset["shotgun_putaway"] = % shotgun_cqbrun_putaway;
  anim.initanimset["reload"] = [%cqb_run_reload_a_iw6, %cqb_run_reload_b_iw6];
  anim.archetypes["soldier"]["cqb"] = anim.initanimset;
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
  anim.initanimset["reload_crouchhide"] = [];
  anim.initanimset["exposed_idle"] = [%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3];
  set_animarray_standing_turns_pistol();
  anim.initanimset["add_turn_aim_up"] = % pistol_stand_aim_8_alt;
  anim.initanimset["add_turn_aim_down"] = % pistol_stand_aim_2_alt;
  anim.initanimset["add_turn_aim_left"] = % pistol_stand_aim_4_alt;
  anim.initanimset["add_turn_aim_right"] = % pistol_stand_aim_6_alt;
  anim.archetypes["soldier"]["pistol_stand"] = anim.initanimset;
}

init_animset_rpg_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % rpg_stand_aim_8;
  anim.initanimset["add_aim_down"] = % rpg_stand_aim_2;
  anim.initanimset["add_aim_left"] = % rpg_stand_aim_4;
  anim.initanimset["add_aim_right"] = % rpg_stand_aim_6;
  anim.initanimset["straight_level"] = % rpg_stand_aim_5;
  anim.initanimset["fire"] = % rpg_stand_fire;
  anim.initanimset["single"] = [%exposed_shoot_semi1];
  anim.initanimset["reload"] = [%rpg_stand_reload];
  anim.initanimset["reload_crouchhide"] = [];
  anim.initanimset["exposed_idle"] = [%rpg_stand_idle];
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.archetypes["soldier"]["rpg_stand"] = anim.initanimset;
}

init_animset_shotgun_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % shotgun_aim_8;
  anim.initanimset["add_aim_down"] = % shotgun_aim_2;
  anim.initanimset["add_aim_left"] = % shotgun_aim_4;
  anim.initanimset["add_aim_right"] = % shotgun_aim_6;
  anim.initanimset["straight_level"] = % shotgun_aim_5;
  anim.initanimset["fire"] = % exposed_shoot_auto_v3;
  anim.initanimset["single"] = [%shotgun_stand_fire_1a, %shotgun_stand_fire_1b];
  set_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = [%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3];
  anim.initanimset["reload"] = [%shotgun_stand_reload_a, %shotgun_stand_reload_b, %shotgun_stand_reload_c, %shotgun_stand_reload_c, %shotgun_stand_reload_c];
  anim.initanimset["reload_crouchhide"] = [%shotgun_stand_reload_a, %shotgun_stand_reload_b];
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.archetypes["soldier"]["shotgun_stand"] = anim.initanimset;
}

init_animset_cqb_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % cqb_stand_aim8;
  anim.initanimset["add_aim_down"] = % cqb_stand_aim2;
  anim.initanimset["add_aim_left"] = % cqb_stand_aim4;
  anim.initanimset["add_aim_right"] = % cqb_stand_aim6;
  anim.initanimset["straight_level"] = % cqb_stand_aim5;
  anim.initanimset["fire"] = % exposed_shoot_auto_v3;
  anim.initanimset["single"] = [%exposed_shoot_semi1];
  set_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = [%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3];
  anim.initanimset["reload"] = [%cqb_stand_reload_steady];
  anim.initanimset["reload_crouchhide"] = [%cqb_stand_reload_knee];
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.archetypes["soldier"]["cqb_stand"] = anim.initanimset;
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
  anim.archetypes["soldier"]["heat_stand"] = anim.initanimset;
}

init_animset_heat_reload() {
  anim.initanimset = [];
  anim.initanimset["reload_cover_left"] = % heat_cover_reload_r;
  anim.initanimset["reload_cover_right"] = % heat_cover_reload_l;
  anim.initanimset["reload_default"] = % heat_cover_reload_l;
  anim.archetypes["soldier"]["heat_reload"] = anim.initanimset;
}

init_animset_default_stand() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % exposed_aim_8;
  anim.initanimset["add_aim_down"] = % exposed_aim_2;
  anim.initanimset["add_aim_left"] = % exposed_aim_4;
  anim.initanimset["add_aim_right"] = % exposed_aim_6;
  anim.initanimset["straight_level"] = % exposed_aim_5;
  anim.initanimset["fire"] = % exposed_shoot_auto_v3;
  anim.initanimset["fire_corner"] = % exposed_shoot_auto_v2;
  anim.initanimset["single"] = animscripts\utility::array(%exposed_shoot_semi1);
  set_animarray_burst_and_semi_fire_stand();
  anim.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  anim.initanimset["exposed_grenade"] = animscripts\utility::array(%exposed_grenadethrowb, %exposed_grenadethrowc);
  anim.initanimset["reload"] = animscripts\utility::array(%exposed_reload);
  anim.initanimset["reload_crouchhide"] = animscripts\utility::array(%exposed_reloadb);
  set_animarray_stance_change();
  set_animarray_standing_turns();
  set_animarray_add_turn_aims_stand();
  anim.archetypes["soldier"]["default_stand"] = anim.initanimset;
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
  anim.archetypes["soldier"]["default_crouch"] = anim.initanimset;
}

init_animset_rpg_crouch() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % rpg_crouch_aim_8;
  anim.initanimset["add_aim_down"] = % rpg_crouch_aim_2;
  anim.initanimset["add_aim_left"] = % rpg_crouch_aim_4;
  anim.initanimset["add_aim_right"] = % rpg_crouch_aim_6;
  anim.initanimset["straight_level"] = % rpg_crouch_aim_5;
  anim.initanimset["fire"] = % rpg_crouch_fire;
  anim.initanimset["single"] = [%rpg_crouch_fire];
  anim.initanimset["reload"] = [%rpg_crouch_reload];
  anim.initanimset["exposed_idle"] = [%rpg_crouch_idle];
  set_animarray_stance_change();
  set_animarray_crouching_turns();
  set_animarray_add_turn_aims_crouch();
  anim.archetypes["soldier"]["rpg_crouch"] = anim.initanimset;
}

init_animset_shotgun_crouch() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % exposed_crouch_aim_8;
  anim.initanimset["add_aim_down"] = % exposed_crouch_aim_2;
  anim.initanimset["add_aim_left"] = % exposed_crouch_aim_4;
  anim.initanimset["add_aim_right"] = % exposed_crouch_aim_6;
  anim.initanimset["straight_level"] = % exposed_crouch_aim_5;
  anim.initanimset["fire"] = % exposed_crouch_shoot_auto_v2;
  anim.initanimset["single"] = [%shotgun_crouch_fire];
  set_animarray_burst_and_semi_fire_crouch();
  anim.initanimset["reload"] = [%shotgun_crouch_reload];
  anim.initanimset["exposed_idle"] = [%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3];
  set_animarray_stance_change();
  set_animarray_crouching_turns();
  set_animarray_add_turn_aims_crouch();
  anim.archetypes["soldier"]["shotgun_crouch"] = anim.initanimset;
}

init_animset_default_prone() {
  anim.initanimset = [];
  anim.initanimset["add_aim_up"] = % prone_aim_8_add;
  anim.initanimset["add_aim_down"] = % prone_aim_2_add;
  anim.initanimset["add_aim_left"] = % prone_aim_4_add;
  anim.initanimset["add_aim_right"] = % prone_aim_6_add;
  anim.initanimset["straight_level"] = % prone_aim_5;
  anim.initanimset["fire"] = % prone_fire_1;
  anim.initanimset["single"] = [%prone_fire_1];
  anim.initanimset["reload"] = [%prone_reload];
  anim.initanimset["burst2"] = % prone_fire_burst;
  anim.initanimset["burst3"] = % prone_fire_burst;
  anim.initanimset["burst4"] = % prone_fire_burst;
  anim.initanimset["burst5"] = % prone_fire_burst;
  anim.initanimset["burst6"] = % prone_fire_burst;
  anim.initanimset["semi2"] = % prone_fire_burst;
  anim.initanimset["semi3"] = % prone_fire_burst;
  anim.initanimset["semi4"] = % prone_fire_burst;
  anim.initanimset["semi5"] = % prone_fire_burst;
  anim.initanimset["exposed_idle"] = [%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3];
  set_animarray_stance_change();
  anim.archetypes["soldier"]["default_prone"] = anim.initanimset;
}

init_animset_complete_custom_stand(var_0) {
  self.combatstandanims = var_0;
}

init_animset_custom_stand(var_0, var_1, var_2, var_3) {
  anim.initanimset = animscripts\utility::lookupanimarray("default_stand");

  if(isDefined(var_1))
    anim.initanimset["straight_level"] = var_1;

  if(isDefined(var_0)) {
    anim.initanimset["fire"] = var_0;
    anim.initanimset["single"] = animscripts\utility::array(var_0);
    set_animarray_custom_burst_and_semi_fire_stand(var_0);
  }

  if(isDefined(var_2))
    anim.initanimset["exposed_idle"] = animscripts\utility::array(var_2);

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
  anim.initanimset = animscripts\utility::lookupanimarray("default_crouch");

  if(isDefined(var_0)) {
    anim.initanimset["fire"] = var_0;
    anim.initanimset["single"] = animscripts\utility::array(var_0);
    set_animarray_custom_burst_and_semi_fire_crouch(var_0);
  }

  if(isDefined(var_1))
    anim.initanimset["exposed_idle"] = animscripts\utility::array(var_1);

  if(isDefined(var_2))
    anim.initanimset["reload"] = animscripts\utility::array(var_2);

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
  if(animscripts\utility::usingsidearm())
    self.a.array = animscripts\utility::lookupanimarray("pistol_stand");
  else if(isDefined(self.combatstandanims))
    self.a.array = self.combatstandanims;
  else if(isDefined(self.heat))
    self.a.array = animscripts\utility::lookupanimarray("heat_stand");
  else if(animscripts\utility::usingrocketlauncher())
    self.a.array = animscripts\utility::lookupanimarray("rpg_stand");
  else if(isDefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun())
    self.a.array = animscripts\utility::lookupanimarray("shotgun_stand");
  else if(animscripts\utility::iscqbwalking())
    self.a.array = animscripts\utility::lookupanimarray("cqb_stand");
  else
    self.a.array = animscripts\utility::lookupanimarray("default_stand");
}

set_animarray_crouching() {
  if(animscripts\utility::usingsidearm())
    animscripts\shared::placeweaponon(self.primaryweapon, "right");

  if(isDefined(self.combatcrouchanims))
    self.a.array = self.combatcrouchanims;
  else if(animscripts\utility::usingrocketlauncher())
    self.a.array = animscripts\utility::lookupanimarray("rpg_crouch");
  else if(isDefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun())
    self.a.array = animscripts\utility::lookupanimarray("shotgun_crouch");
  else
    self.a.array = animscripts\utility::lookupanimarray("default_crouch");
}

set_animarray_prone() {
  if(animscripts\utility::usingsidearm())
    animscripts\shared::placeweaponon(self.primaryweapon, "right");

  self.a.array = animscripts\utility::lookupanimarray("default_prone");
}

init_moving_turn_animations() {
  anim.initanimset = [];
  anim.initanimset[0] = % run_turn_180;
  anim.initanimset[1] = % run_turn_l135;
  anim.initanimset[2] = % run_turn_l90;
  anim.initanimset[3] = % run_turn_l45;
  anim.initanimset[5] = % run_turn_r45;
  anim.initanimset[6] = % run_turn_r90;
  anim.initanimset[7] = % run_turn_r135;
  anim.initanimset[8] = % run_turn_180;
  anim.archetypes["soldier"]["run_turn"] = anim.initanimset;
  anim.initanimset = [];
  anim.initanimset[0] = % cqb_walk_turn_2;
  anim.initanimset[1] = % cqb_walk_turn_1;
  anim.initanimset[2] = % cqb_walk_turn_4;
  anim.initanimset[3] = % cqb_walk_turn_7;
  anim.initanimset[5] = % cqb_walk_turn_9;
  anim.initanimset[6] = % cqb_walk_turn_6;
  anim.initanimset[7] = % cqb_walk_turn_3;
  anim.initanimset[8] = % cqb_walk_turn_2;
  anim.archetypes["soldier"]["cqb_turn"] = anim.initanimset;
  anim.initanimset = [];
  anim.initanimset[0] = % cqb_run_turn_180_iw6;
  anim.initanimset[1] = % cqb_run_turn_l135_iw6;
  anim.initanimset[2] = % cqb_run_turn_l90_iw6;
  anim.initanimset[3] = % cqb_run_turn_l45_iw6;
  anim.initanimset[5] = % cqb_run_turn_r45_iw6;
  anim.initanimset[6] = % cqb_run_turn_r90_iw6;
  anim.initanimset[7] = % cqb_run_turn_r135_iw6;
  anim.initanimset[8] = % cqb_run_turn_180_iw6;
  anim.archetypes["soldier"]["cqb_run_turn"] = anim.initanimset;
}

init_exposed_turn_animations() {
  anim.initanimset = [];
  anim.initanimset["turn_left_45"] = % exposed_tracking_turn45l;
  anim.initanimset["turn_left_90"] = % exposed_tracking_turn90l;
  anim.initanimset["turn_left_135"] = % exposed_tracking_turn135l;
  anim.initanimset["turn_left_180"] = % exposed_tracking_turn180l;
  anim.initanimset["turn_right_45"] = % exposed_tracking_turn45r;
  anim.initanimset["turn_right_90"] = % exposed_tracking_turn90r;
  anim.initanimset["turn_right_135"] = % exposed_tracking_turn135r;
  anim.initanimset["turn_right_180"] = % exposed_tracking_turn180r;
  anim.archetypes["soldier"]["exposed_turn"] = anim.initanimset;
  anim.initanimset = [];
  anim.initanimset["turn_left_45"] = % exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_90"] = % exposed_crouch_turn_90_left;
  anim.initanimset["turn_left_135"] = % exposed_crouch_turn_180_left;
  anim.initanimset["turn_left_180"] = % exposed_crouch_turn_180_left;
  anim.initanimset["turn_right_45"] = % exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_90"] = % exposed_crouch_turn_90_right;
  anim.initanimset["turn_right_135"] = % exposed_crouch_turn_180_right;
  anim.initanimset["turn_right_180"] = % exposed_crouch_turn_180_right;
  anim.archetypes["soldier"]["exposed_turn_crouch"] = anim.initanimset;
}

init_grenade_animations() {
  anim.initanimset = [];
  anim.initanimset["cower_squat"] = % exposed_squat_down_grenade_f;
  anim.initanimset["cower_squat_idle"] = % exposed_squat_idle_grenade_f;
  anim.initanimset["cower_dive_back"] = % exposed_dive_grenade_b;
  anim.initanimset["cower_dive_front"] = % exposed_dive_grenade_f;
  anim.initanimset["return_throw_short"] = [%grenade_return_running_throw_forward, %grenade_return_standing_throw_forward_1];
  anim.initanimset["return_throw_long"] = [%grenade_return_running_throw_forward, %grenade_return_standing_throw_overhand_forward];
  anim.initanimset["return_throw_default"] = [%grenade_return_standing_throw_overhand_forward];
  anim.archetypes["soldier"]["grenade"] = anim.initanimset;
}

init_animset_run_n_gun() {
  anim.initanimset = [];
  anim.initanimset["F"] = % run_n_gun_f;
  anim.initanimset["L"] = % run_n_gun_l;
  anim.initanimset["R"] = % run_n_gun_r;
  anim.initanimset["LB"] = % run_n_gun_l_120;
  anim.initanimset["RB"] = % run_n_gun_r_120;
  anim.initanimset["move_back"] = % combatwalk_b;
  anim.archetypes["soldier"]["run_n_gun"] = anim.initanimset;
}

setup_run_n_gun() {
  self.maxrunngunangle = 130;
  self.runnguntransitionpoint = 0.461538;
  self.runngunincrement = 0.3;
}

init_animset_ambush() {
  anim.initanimset = [];
  anim.initanimset["move_l"] = % combatwalk_l;
  anim.initanimset["move_r"] = % combatwalk_r;
  anim.initanimset["move_b"] = % combatwalk_b;
  anim.archetypes["soldier"]["ambush"] = anim.initanimset;
}

set_ambush_sidestep_anims() {
  self.a.moveanimset["move_l"] = animscripts\utility::lookupanim("ambush", "move_l");
  self.a.moveanimset["move_r"] = animscripts\utility::lookupanim("ambush", "move_r");
  self.a.moveanimset["move_b"] = animscripts\utility::lookupanim("ambush", "move_b");
}

heat_reload_anim() {
  if(self.weapon != self.primaryweapon)
    return animscripts\utility::animarraypickrandom("reload");

  if(isDefined(self.node)) {
    if(self nearclaimnodeandangle()) {
      var_0 = undefined;

      if(self.node.type == "Cover Left")
        var_0 = animscripts\utility::lookupanim("heat_reload", "reload_cover_left");
      else if(self.node.type == "Cover Right")
        var_0 = animscripts\utility::lookupanim("heat_reload", "reload_cover_right");

      if(isDefined(var_0))
        return var_0;
    }
  }

  return animscripts\utility::lookupanim("heat_reload", "reload_default");
}