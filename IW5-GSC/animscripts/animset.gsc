/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\animset.gsc
**************************************/

_id_0C64() {
  anim._id_0C65 = spawnStruct();
  anim._id_0C65._id_0C66 = [];
  _id_0C77();
  _id_0C73();
  _id_0C6C();
  _id_0C6F();
  _id_0C71();
  _id_0C75();
  _id_0C79();
  _id_0C7B();
  _id_0C7D();
  _id_0C7F();
  _id_0C67();
  _id_0C6A();
  _id_0C6B();
  _id_0C69();
  _id_0C9D();
}

#using_animtree("generic_human");

_id_0C67() {
  anim._id_0C68 = [];
  anim._id_0C68["sprint"] = % sprint_loop_distant;
  anim._id_0C68["sprint_short"] = % sprint1_loop;
  anim._id_0C68["prone"] = % prone_crawl;
  anim._id_0C68["straight"] = % run_lowready_f;
  anim._id_0C68["move_f"] = % walk_forward;
  anim._id_0C68["move_l"] = % walk_left;
  anim._id_0C68["move_r"] = % walk_right;
  anim._id_0C68["move_b"] = % walk_backward;
  anim._id_0C68["crouch"] = % crouch_fastwalk_f;
  anim._id_0C68["crouch_l"] = % crouch_fastwalk_l;
  anim._id_0C68["crouch_r"] = % crouch_fastwalk_r;
  anim._id_0C68["crouch_b"] = % crouch_fastwalk_b;
  anim._id_0C68["stairs_up"] = % traverse_stair_run_01;
  anim._id_0C68["stairs_down"] = % traverse_stair_run_down;
  anim._id_0C65._id_0C66["run"] = anim._id_0C68;
}

_id_0C69() {
  anim._id_0C68 = anim._id_0C65._id_0C66["run"];
  anim._id_0C68["straight"] = % heat_run_loop;
  anim._id_0C65._id_0C66["heat_run"] = anim._id_0C68;
}

_id_0C6A() {
  anim._id_0C68 = [];
  anim._id_0C68["sprint"] = % sprint_loop_distant;
  anim._id_0C68["sprint_short"] = % sprint1_loop;
  anim._id_0C68["prone"] = % prone_crawl;
  anim._id_0C68["straight"] = % walk_cqb_f;
  anim._id_0C68["move_f"] = % walk_cqb_f;
  anim._id_0C68["move_l"] = % walk_left;
  anim._id_0C68["move_r"] = % walk_right;
  anim._id_0C68["move_b"] = % walk_backward;
  anim._id_0C68["crouch"] = % crouch_fastwalk_f;
  anim._id_0C68["crouch_l"] = % crouch_fastwalk_l;
  anim._id_0C68["crouch_r"] = % crouch_fastwalk_r;
  anim._id_0C68["crouch_b"] = % crouch_fastwalk_b;
  anim._id_0C68["stairs_up"] = % traverse_stair_run;
  anim._id_0C68["stairs_down"] = % traverse_stair_run_down_01;
  anim._id_0C65._id_0C66["walk"] = anim._id_0C68;
}

_id_0C6B() {
  anim._id_0C68 = [];
  anim._id_0C68["sprint"] = % sprint_loop_distant;
  anim._id_0C68["sprint_short"] = % sprint1_loop;
  anim._id_0C68["straight"] = % run_cqb_f_search_v1;
  anim._id_0C68["move_f"] = % walk_cqb_f;
  anim._id_0C68["move_l"] = % walk_left;
  anim._id_0C68["move_r"] = % walk_right;
  anim._id_0C68["move_b"] = % walk_backward;
  anim._id_0C68["stairs_up"] = % traverse_stair_run;
  anim._id_0C68["stairs_down"] = % traverse_stair_run_down_01;
  anim._id_0C65._id_0C66["cqb"] = anim._id_0C68;
}

_id_0C6C() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % pistol_stand_aim_8_add;
  anim._id_0C68["add_aim_down"] = % pistol_stand_aim_2_add;
  anim._id_0C68["add_aim_left"] = % pistol_stand_aim_4_add;
  anim._id_0C68["add_aim_right"] = % pistol_stand_aim_6_add;
  anim._id_0C68["straight_level"] = % pistol_stand_aim_5;
  anim._id_0C68["fire"] = % pistol_stand_fire_a;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%pistol_stand_fire_a);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%pistol_stand_reload_a);
  anim._id_0C68["reload_crouchhide"] = animscripts\utility::_id_0C6D();
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  _id_0C8A();
  anim._id_0C68["add_turn_aim_up"] = % pistol_stand_aim_8_alt;
  anim._id_0C68["add_turn_aim_down"] = % pistol_stand_aim_2_alt;
  anim._id_0C68["add_turn_aim_left"] = % pistol_stand_aim_4_alt;
  anim._id_0C68["add_turn_aim_right"] = % pistol_stand_aim_6_alt;
  anim._id_0C65._id_0C6E = anim._id_0C68;
}

_id_0C6F() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % rpg_stand_aim_8;
  anim._id_0C68["add_aim_down"] = % rpg_stand_aim_2;
  anim._id_0C68["add_aim_left"] = % rpg_stand_aim_4;
  anim._id_0C68["add_aim_right"] = % rpg_stand_aim_6;
  anim._id_0C68["straight_level"] = % rpg_stand_aim_5;
  anim._id_0C68["fire"] = % rpg_stand_fire;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%exposed_shoot_semi1);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%rpg_stand_reload);
  anim._id_0C68["reload_crouchhide"] = animscripts\utility::_id_0C6D();
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%rpg_stand_idle);
  _id_0C8D();
  _id_0C8B();
  _id_0C92();
  anim._id_0C65._id_0C70 = anim._id_0C68;
}

_id_0C71() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % shotgun_aim_8;
  anim._id_0C68["add_aim_down"] = % shotgun_aim_2;
  anim._id_0C68["add_aim_left"] = % shotgun_aim_4;
  anim._id_0C68["add_aim_right"] = % shotgun_aim_6;
  anim._id_0C68["straight_level"] = % shotgun_aim_5;
  anim._id_0C68["fire"] = % exposed_shoot_auto_v3;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%shotgun_stand_fire_1a, %shotgun_stand_fire_1b);
  _id_0C8E();
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%shotgun_stand_reload_a, %shotgun_stand_reload_b, %shotgun_stand_reload_c, %shotgun_stand_reload_c, %shotgun_stand_reload_c);
  anim._id_0C68["reload_crouchhide"] = animscripts\utility::_id_0C6D(%shotgun_stand_reload_a, %shotgun_stand_reload_b);
  _id_0C8D();
  _id_0C8B();
  _id_0C92();
  anim._id_0C65._id_0C72 = anim._id_0C68;
}

_id_0C73() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % cqb_stand_aim8;
  anim._id_0C68["add_aim_down"] = % cqb_stand_aim2;
  anim._id_0C68["add_aim_left"] = % cqb_stand_aim4;
  anim._id_0C68["add_aim_right"] = % cqb_stand_aim6;
  anim._id_0C68["straight_level"] = % cqb_stand_aim5;
  anim._id_0C68["fire"] = % exposed_shoot_auto_v3;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%exposed_shoot_semi1);
  _id_0C8E();
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%cqb_stand_reload_steady);
  anim._id_0C68["reload_crouchhide"] = animscripts\utility::_id_0C6D(%cqb_stand_reload_knee);
  _id_0C8D();
  _id_0C8B();
  _id_0C92();
  anim._id_0C65._id_0C74 = anim._id_0C68;
}

_id_0C75() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % heat_stand_aim_8;
  anim._id_0C68["add_aim_down"] = % heat_stand_aim_2;
  anim._id_0C68["add_aim_left"] = % heat_stand_aim_4;
  anim._id_0C68["add_aim_right"] = % heat_stand_aim_6;
  anim._id_0C68["straight_level"] = % heat_stand_aim_5;
  anim._id_0C68["fire"] = % heat_stand_fire_auto;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%heat_stand_fire_single);
  _id_0C8F(%heat_stand_fire_burst);
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%heat_stand_idle, %heat_stand_scana, %heat_stand_scanb);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%heat_exposed_reload);
  anim._id_0C68["reload_crouchhide"] = animscripts\utility::_id_0C6D();
  _id_0C8D();
  anim._id_0C68["turn_left_45"] = % heat_stand_turn_l;
  anim._id_0C68["turn_left_90"] = % heat_stand_turn_l;
  anim._id_0C68["turn_left_135"] = % heat_stand_turn_180;
  anim._id_0C68["turn_left_180"] = % heat_stand_turn_180;
  anim._id_0C68["turn_right_45"] = % heat_stand_turn_r;
  anim._id_0C68["turn_right_90"] = % heat_stand_turn_r;
  anim._id_0C68["turn_right_135"] = % heat_stand_turn_180;
  anim._id_0C68["turn_right_180"] = % heat_stand_turn_180;
  _id_0C92();
  anim._id_0C65._id_0C76 = anim._id_0C68;
}

_id_0C77() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % exposed_aim_8;
  anim._id_0C68["add_aim_down"] = % exposed_aim_2;
  anim._id_0C68["add_aim_left"] = % exposed_aim_4;
  anim._id_0C68["add_aim_right"] = % exposed_aim_6;
  anim._id_0C68["straight_level"] = % exposed_aim_5;
  anim._id_0C68["fire"] = % exposed_shoot_auto_v3;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%exposed_shoot_semi1);
  _id_0C8E();
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  anim._id_0C68["exposed_grenade"] = animscripts\utility::_id_0C6D(%exposed_grenadethrowb, %exposed_grenadethrowc);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%exposed_reload);
  anim._id_0C68["reload_crouchhide"] = animscripts\utility::_id_0C6D(%exposed_reloadb);
  _id_0C8D();
  _id_0C8B();
  _id_0C92();
  anim._id_0C65._id_0C78 = anim._id_0C68;
}

_id_0C79() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % exposed_crouch_aim_8;
  anim._id_0C68["add_aim_down"] = % exposed_crouch_aim_2;
  anim._id_0C68["add_aim_left"] = % exposed_crouch_aim_4;
  anim._id_0C68["add_aim_right"] = % exposed_crouch_aim_6;
  anim._id_0C68["straight_level"] = % exposed_crouch_aim_5;
  anim._id_0C68["fire"] = % exposed_crouch_shoot_auto_v2;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%exposed_crouch_shoot_semi1);
  _id_0C90();
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%exposed_crouch_reload);
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  _id_0C8D();
  _id_0C8C();
  _id_0C93();
  anim._id_0C65._id_0C7A = anim._id_0C68;
}

_id_0C7B() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % rpg_crouch_aim_8;
  anim._id_0C68["add_aim_down"] = % rpg_crouch_aim_2;
  anim._id_0C68["add_aim_left"] = % rpg_crouch_aim_4;
  anim._id_0C68["add_aim_right"] = % rpg_crouch_aim_6;
  anim._id_0C68["straight_level"] = % rpg_crouch_aim_5;
  anim._id_0C68["fire"] = % rpg_crouch_fire;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%rpg_crouch_fire);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%rpg_crouch_reload);
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%rpg_crouch_idle);
  _id_0C8D();
  _id_0C8C();
  _id_0C93();
  anim._id_0C65._id_0C7C = anim._id_0C68;
}

_id_0C7D() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % exposed_crouch_aim_8;
  anim._id_0C68["add_aim_down"] = % exposed_crouch_aim_2;
  anim._id_0C68["add_aim_left"] = % exposed_crouch_aim_4;
  anim._id_0C68["add_aim_right"] = % exposed_crouch_aim_6;
  anim._id_0C68["straight_level"] = % exposed_crouch_aim_5;
  anim._id_0C68["fire"] = % exposed_crouch_shoot_auto_v2;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%shotgun_crouch_fire);
  _id_0C90();
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%shotgun_crouch_reload);
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  _id_0C8D();
  _id_0C8C();
  _id_0C93();
  anim._id_0C65._id_0C7E = anim._id_0C68;
}

_id_0C7F() {
  anim._id_0C68 = [];
  anim._id_0C68["add_aim_up"] = % prone_aim_8_add;
  anim._id_0C68["add_aim_down"] = % prone_aim_2_add;
  anim._id_0C68["add_aim_left"] = % prone_aim_4_add;
  anim._id_0C68["add_aim_right"] = % prone_aim_6_add;
  anim._id_0C68["straight_level"] = % prone_aim_5;
  anim._id_0C68["fire"] = % prone_fire_1;
  anim._id_0C68["single"] = animscripts\utility::_id_0C6D(%prone_fire_1);
  anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(%prone_reload);
  anim._id_0C68["burst2"] = % prone_fire_burst;
  anim._id_0C68["burst3"] = % prone_fire_burst;
  anim._id_0C68["burst4"] = % prone_fire_burst;
  anim._id_0C68["burst5"] = % prone_fire_burst;
  anim._id_0C68["burst6"] = % prone_fire_burst;
  anim._id_0C68["semi2"] = % prone_fire_burst;
  anim._id_0C68["semi3"] = % prone_fire_burst;
  anim._id_0C68["semi4"] = % prone_fire_burst;
  anim._id_0C68["semi5"] = % prone_fire_burst;
  anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
  _id_0C8D();
  anim._id_0C65._id_0C80 = anim._id_0C68;
}

_id_0C81(var_0) {
  self._id_0C82 = var_0;
}

_id_0C83(var_0, var_1, var_2, var_3) {
  anim._id_0C68 = anim._id_0C65._id_0C78;

  if(isDefined(var_1)) {
    anim._id_0C68["straight_level"] = var_1;
  }
  if(isDefined(var_0)) {
    anim._id_0C68["fire"] = var_0;
    anim._id_0C68["single"] = animscripts\utility::_id_0C6D(var_0);
    _id_0C8F(var_0);
  }

  if(isDefined(var_2)) {
    anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(var_2);
  }
  if(isDefined(var_3)) {
    anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(var_3);
    anim._id_0C68["reload_crouchhide"] = animscripts\utility::_id_0C6D(var_3);
  }

  self._id_0C82 = anim._id_0C68;
}

_id_0C84(var_0) {
  self._id_0C85 = var_0;
}

_id_0C86(var_0, var_1, var_2) {
  anim._id_0C68 = anim._id_0C65._id_0C7A;

  if(isDefined(var_0)) {
    anim._id_0C68["fire"] = var_0;
    anim._id_0C68["single"] = animscripts\utility::_id_0C6D(var_0);
    _id_0C91(var_0);
  }

  if(isDefined(var_1)) {
    anim._id_0C68["exposed_idle"] = animscripts\utility::_id_0C6D(var_1);
  }
  if(isDefined(var_2)) {
    anim._id_0C68["reload"] = animscripts\utility::_id_0C6D(var_2);
  }
  self._id_0C85 = anim._id_0C68;
}

_id_0C87() {
  self._id_0C88 = undefined;
  self._id_0C89 = undefined;
  self._id_0C82 = undefined;
  self._id_0C85 = undefined;
}

_id_0C8A(var_0) {
  anim._id_0C68["turn_left_45"] = % pistol_stand_turn45l;
  anim._id_0C68["turn_left_90"] = % pistol_stand_turn90l;
  anim._id_0C68["turn_left_135"] = % pistol_stand_turn90l;
  anim._id_0C68["turn_left_180"] = % pistol_stand_turn180l;
  anim._id_0C68["turn_right_45"] = % pistol_stand_turn45r;
  anim._id_0C68["turn_right_90"] = % pistol_stand_turn90r;
  anim._id_0C68["turn_right_135"] = % pistol_stand_turn90r;
  anim._id_0C68["turn_right_180"] = % pistol_stand_turn180l;
}

_id_0C8B() {
  anim._id_0C68["turn_left_45"] = % exposed_tracking_turn45l;
  anim._id_0C68["turn_left_90"] = % exposed_tracking_turn90l;
  anim._id_0C68["turn_left_135"] = % exposed_tracking_turn135l;
  anim._id_0C68["turn_left_180"] = % exposed_tracking_turn180l;
  anim._id_0C68["turn_right_45"] = % exposed_tracking_turn45r;
  anim._id_0C68["turn_right_90"] = % exposed_tracking_turn90r;
  anim._id_0C68["turn_right_135"] = % exposed_tracking_turn135r;
  anim._id_0C68["turn_right_180"] = % exposed_tracking_turn180r;
}

_id_0C8C() {
  anim._id_0C68["turn_left_45"] = % exposed_crouch_turn_90_left;
  anim._id_0C68["turn_left_90"] = % exposed_crouch_turn_90_left;
  anim._id_0C68["turn_left_135"] = % exposed_crouch_turn_180_left;
  anim._id_0C68["turn_left_180"] = % exposed_crouch_turn_180_left;
  anim._id_0C68["turn_right_45"] = % exposed_crouch_turn_90_right;
  anim._id_0C68["turn_right_90"] = % exposed_crouch_turn_90_right;
  anim._id_0C68["turn_right_135"] = % exposed_crouch_turn_180_right;
  anim._id_0C68["turn_right_180"] = % exposed_crouch_turn_180_right;
}

_id_0C8D() {
  anim._id_0C68["crouch_2_stand"] = % exposed_crouch_2_stand;
  anim._id_0C68["crouch_2_prone"] = % crouch_2_prone;
  anim._id_0C68["stand_2_crouch"] = % exposed_stand_2_crouch;
  anim._id_0C68["stand_2_prone"] = % stand_2_prone;
  anim._id_0C68["prone_2_crouch"] = % prone_2_crouch;
  anim._id_0C68["prone_2_stand"] = % prone_2_stand;
}

_id_0C8E() {
  anim._id_0C68["burst2"] = % exposed_shoot_burst3;
  anim._id_0C68["burst3"] = % exposed_shoot_burst3;
  anim._id_0C68["burst4"] = % exposed_shoot_burst4;
  anim._id_0C68["burst5"] = % exposed_shoot_burst5;
  anim._id_0C68["burst6"] = % exposed_shoot_burst6;
  anim._id_0C68["semi2"] = % exposed_shoot_semi2;
  anim._id_0C68["semi3"] = % exposed_shoot_semi3;
  anim._id_0C68["semi4"] = % exposed_shoot_semi4;
  anim._id_0C68["semi5"] = % exposed_shoot_semi5;
}

_id_0C8F(var_0) {
  anim._id_0C68["burst2"] = var_0;
  anim._id_0C68["burst3"] = var_0;
  anim._id_0C68["burst4"] = var_0;
  anim._id_0C68["burst5"] = var_0;
  anim._id_0C68["burst6"] = var_0;
  anim._id_0C68["semi2"] = var_0;
  anim._id_0C68["semi3"] = var_0;
  anim._id_0C68["semi4"] = var_0;
  anim._id_0C68["semi5"] = var_0;
}

_id_0C90() {
  anim._id_0C68["burst2"] = % exposed_crouch_shoot_burst3;
  anim._id_0C68["burst3"] = % exposed_crouch_shoot_burst3;
  anim._id_0C68["burst4"] = % exposed_crouch_shoot_burst4;
  anim._id_0C68["burst5"] = % exposed_crouch_shoot_burst5;
  anim._id_0C68["burst6"] = % exposed_crouch_shoot_burst6;
  anim._id_0C68["semi2"] = % exposed_crouch_shoot_semi2;
  anim._id_0C68["semi3"] = % exposed_crouch_shoot_semi3;
  anim._id_0C68["semi4"] = % exposed_crouch_shoot_semi4;
  anim._id_0C68["semi5"] = % exposed_crouch_shoot_semi5;
}

_id_0C91(var_0) {
  anim._id_0C68["burst2"] = var_0;
  anim._id_0C68["burst3"] = var_0;
  anim._id_0C68["burst4"] = var_0;
  anim._id_0C68["burst5"] = var_0;
  anim._id_0C68["burst6"] = var_0;
  anim._id_0C68["semi2"] = var_0;
  anim._id_0C68["semi3"] = var_0;
  anim._id_0C68["semi4"] = var_0;
  anim._id_0C68["semi5"] = var_0;
}

_id_0C92() {
  anim._id_0C68["add_turn_aim_up"] = % exposed_turn_aim_8;
  anim._id_0C68["add_turn_aim_down"] = % exposed_turn_aim_2;
  anim._id_0C68["add_turn_aim_left"] = % exposed_turn_aim_4;
  anim._id_0C68["add_turn_aim_right"] = % exposed_turn_aim_6;
}

_id_0C93() {
  anim._id_0C68["add_turn_aim_up"] = % exposed_crouch_turn_aim_8;
  anim._id_0C68["add_turn_aim_down"] = % exposed_crouch_turn_aim_2;
  anim._id_0C68["add_turn_aim_left"] = % exposed_crouch_turn_aim_4;
  anim._id_0C68["add_turn_aim_right"] = % exposed_crouch_turn_aim_6;
}

_id_0C94() {
  if(animscripts\utility::_id_0C95()) {
    self.a._id_0C6D = anim._id_0C65._id_0C6E;
  } else if(isDefined(self._id_0C82)) {
    self.a._id_0C6D = self._id_0C82;
  } else if(isDefined(self._id_0C96)) {
    self.a._id_0C6D = anim._id_0C65._id_0C76;
  } else if(animscripts\utility::_id_0BB6()) {
    self.a._id_0C6D = anim._id_0C65._id_0C70;
  } else if(isDefined(self.weapon) && animscripts\utility::_id_0C97()) {
    self.a._id_0C6D = anim._id_0C65._id_0C72;
  } else if(animscripts\utility::_id_0C98()) {
    self.a._id_0C6D = anim._id_0C65._id_0C74;
  } else {
    self.a._id_0C6D = anim._id_0C65._id_0C78;
  }
}

_id_0C99() {
  if(animscripts\utility::_id_0C95()) {
    animscripts\shared::_id_0C9B(self.primaryweapon, "right");
  }
  if(isDefined(self._id_0C85)) {
    self.a._id_0C6D = self._id_0C85;
  } else if(animscripts\utility::_id_0BB6()) {
    self.a._id_0C6D = anim._id_0C65._id_0C7C;
  } else if(isDefined(self.weapon) && animscripts\utility::_id_0C97()) {
    self.a._id_0C6D = anim._id_0C65._id_0C7E;
  } else {
    self.a._id_0C6D = anim._id_0C65._id_0C7A;
  }
}

_id_0C9C() {
  if(animscripts\utility::_id_0C95()) {
    animscripts\shared::_id_0C9B(self.primaryweapon, "right");
  }
  self.a._id_0C6D = anim._id_0C65._id_0C80;
}

_id_0C9D() {
  anim._id_0C9E["L90"] = % run_turn_l90;
  anim._id_0C9E["R90"] = % run_turn_r90;
  anim._id_0C9E["L45"] = % run_turn_l45;
  anim._id_0C9E["R45"] = % run_turn_r45;
  anim._id_0C9E["L135"] = % run_turn_l135;
  anim._id_0C9E["R135"] = % run_turn_r135;
  anim._id_0C9E["180"] = % run_turn_180;
  anim._id_0C9F["L90"] = % cqb_walk_turn_4;
  anim._id_0C9F["R90"] = % cqb_walk_turn_6;
  anim._id_0C9F["L45"] = % cqb_walk_turn_7;
  anim._id_0C9F["R45"] = % cqb_walk_turn_9;
  anim._id_0C9F["L135"] = % cqb_walk_turn_1;
  anim._id_0C9F["R135"] = % cqb_walk_turn_3;
  anim._id_0C9F["180"] = % cqb_walk_turn_2;
}

_id_0CA0() {
  self._id_0CA1 = 130;
  self._id_0CA2 = 0.461538;
  self._id_0CA3 = 0.3;
  self._id_0CA4["F"] = % run_n_gun_f;
  self._id_0CA4["L"] = % run_n_gun_l;
  self._id_0CA4["R"] = % run_n_gun_r;
  self._id_0CA4["LB"] = % run_n_gun_l_120;
  self._id_0CA4["RB"] = % run_n_gun_r_120;
}

_id_0CA5() {
  self.a._id_0CA6["move_l"] = % combatwalk_l;
  self.a._id_0CA6["move_r"] = % combatwalk_r;
  self.a._id_0CA6["move_b"] = % combatwalk_b;
}

_id_0CA7() {
  if(self.weapon != self.primaryweapon) {
    return animscripts\utility::_id_0CA8("reload");
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