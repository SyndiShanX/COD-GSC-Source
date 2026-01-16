/************************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_player_character_setup.gsc
************************************************************************/

init_player_characters() {
  register_player_character(1, "yes", "body_zmb_hero_sally_dlc4", "viewmodel_zmb_hero_sally_dlc4", "head_zmb_hero_sally_dlc4", undefined, "p1_", "_p1", "iw7_dlc4pap_zm", "ges_zombies_revive_nerd", 0, "iw7_dlc4card_zm", "mus_zombies_generic_char", "iw7_dlc4loadin_zm", "iw7_knife_zm_rapper");
  register_player_character(2, "yes", "body_zmb_hero_dexter_dlc4", "viewmodel_zmb_hero_dexter_dlc4", "head_zmb_hero_dexter_dlc4", undefined, "p2_", "_p2", "iw7_dlc4pap_zm", "ges_zombies_revive_nerd", 1, "iw7_dlc4card_zm", "mus_zombies_generic_char", "iw7_dlc4loadin_zm", "iw7_knife_zm_rapper");
  register_player_character(3, "yes", "body_zmb_hero_andre_dlc4", "viewmodel_zmb_hero_andre_dlc4", "head_zmb_hero_andre_dlc4", undefined, "p3_", "_p3", "iw7_dlc4pap_zm", "ges_zombies_revive_nerd", 2, "iw7_dlc4card_zm", "mus_zombies_generic_char", "iw7_dlc4loadin_zm", "iw7_knife_zm_rapper");
  register_player_character(4, "yes", "body_zmb_hero_aj_dlc4", "viewmodel_zmb_hero_aj_dlc4", "head_zmb_hero_aj_dlc4", undefined, "p4_", "_p4", "iw7_dlc4pap_zm", "ges_zombies_revive_nerd", 3, "iw7_dlc4card_zm", "mus_zombies_generic_char", "iw7_dlc4loadin_zm", "iw7_knife_zm_rapper");
}

register_player_character(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  var_10 = spawnStruct();
  var_10.body_model = var_2;
  var_10.view_model = var_3;
  var_10.head_model = var_4;
  var_10.hair_model = var_5;
  var_10.vo_prefix = var_6;
  var_10.vo_suffix = var_7;
  var_10.pap_gesture = var_8;
  var_10.revive_gesture = var_9;
  var_10.photo_index = var_10;
  var_10.fate_card_weapon = var_11;
  var_10.intro_music = var_12;
  var_10.intro_gesture = var_13;
  var_10.melee_weapon = var_14;
  var_10.post_setup_func = var_15;
  if(!isDefined(level.player_character_info)) {
    level.player_character_info = [];
  }

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  level.player_character_info[var_0] = var_10;
  if(var_1 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = var_0;
  }
}