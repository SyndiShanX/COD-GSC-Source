/**********************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_player_character_setup.gsc
**********************************************************************/

init_player_characters() {
  register_player_character(1, "yes", "body_zmb_hero_schoolgirl", "viewmodel_arms_zmb_hero_schoolgirl", "head_zmb_hero_schoolgirl", undefined, "p1_", "_p1", "iw7_pap_zm_school_girl", "ges_zombies_revive_nerd", 0, "iw7_schoolgirlcard_zm", "mus_zombies_valley_girl", "iw7_loadoutschoolgirl_zm", "iw7_knife_zm_schoolgirl");
  register_player_character(2, "yes", "body_zmb_hero_scientist", "viewmodel_arms_zmb_hero_scientist", "head_zmb_hero_scientist", undefined, "p2_", "_p2", "iw7_pap_zm_scientist", "ges_zombies_revive_nerd", 1, "iw7_scientistcard_zm", "mus_zombies_nerd", "iw7_loadoutscientist_zm", "iw7_knife_zm_scientist");
  register_player_character(3, "yes", "body_zmb_hero_soldier", "viewmodel_zmb_hero_soldier", "head_zmb_hero_soldier", undefined, "p3_", "_p3", "iw7_pap_zm_soldier", "ges_zombies_revive_nerd", 2, "iw7_soldiercard_zm", "mus_zombies_rapper", "iw7_loadoutsoldier_zm", "iw7_knife_zm_soldier");
  register_player_character(4, "yes", "body_zmb_hero_rebel", "viewmodel_arms_zmb_hero_rebel", "head_zmb_hero_rebel", undefined, "p4_", "_p4", "iw7_pap_zm_rebel", "ges_zombies_revive_nerd", 3, "iw7_rebelcard_zm", "mus_zombies_jock", "iw7_loadoutrebel_zm", "iw7_knife_zm_rebel");
  register_player_character(5, "no", "fullbody_zmb_hero_elvira_player", "viewmodel_zmb_hero_elvira", undefined, undefined, "p5_", "_p5", "iw7_pap_zm_elvira", "ges_zombies_revive_nerd", 4, "iw7_elviracard_zm", "mus_zombies_elvira", "iw7_loadoutelvira_zm", "iw7_knife_zm_elvira", ::post_elvira_setup_func);
}

register_player_character(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F) {
  var_10 = spawnStruct();
  var_10.body_model = param_02;
  var_10.view_model = param_03;
  var_10.head_model = param_04;
  var_10.hair_model = param_05;
  var_10.vo_prefix = param_06;
  var_10.vo_suffix = param_07;
  var_10.pap_gesture = param_08;
  var_10.revive_gesture = param_09;
  var_10.photo_index = param_0A;
  var_10.fate_card_weapon = param_0B;
  var_10.intro_music = param_0C;
  var_10.intro_gesture = param_0D;
  var_10.melee_weapon = param_0E;
  var_10.post_setup_func = param_0F;
  if(!isDefined(level.player_character_info)) {
    level.player_character_info = [];
  }

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  level.player_character_info[param_00] = var_10;
  if(param_01 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = param_00;
  }
}

post_elvira_setup_func(param_00) {
  param_00 scripts\cp\zombies\achievement::update_achievement("MISTRESS_OF_DARK", 1);
  if(!isDefined(level.special_character_count)) {
    level.special_character_count = 1;
    return;
  }

  level.special_character_count++;
}

post_el_setup_func(param_00) {
  if(!isDefined(level.special_character_count)) {
    level.special_character_count = 1;
    return;
  }

  level.special_character_count++;
}