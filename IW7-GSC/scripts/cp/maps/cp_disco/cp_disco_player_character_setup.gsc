/************************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_player_character_setup.gsc
************************************************************************/

init_player_characters() {
  scripts\cp\zombies\zombies_loadout::register_player_character(1, "yes", "zmb_body_hero_disco_chick", "viewmodel_zmb_hero_disco_chick", "zmb_head_hero_disco_chick", undefined, "p1_", "_p1", "iw7_pap_zm_jock", "ges_zombies_revive_hoff", 0, "iw7_valleygirlcard_zm", "mus_zombies_valley_girl", "iw7_loadout_zm_disco_chick", "iw7_knife_zm_disco", undefined);
  scripts\cp\zombies\zombies_loadout::register_player_character(2, "yes", "body_zmb_hero_punk", "viewmodel_zmb_hero_punk", "head_zmb_hero_punk", undefined, "p2_", "_p2", "iw7_pap_zm_jock", "ges_zombies_revive_hoff", 1, "iw7_nerdcard_zm", "mus_zombies_nerd", "iw7_loadout_zm_punk", "iw7_knife_zm_disco", undefined);
  scripts\cp\zombies\zombies_loadout::register_player_character(3, "yes", "body_zmb_hero_political_activist", "zmb_hero_political_activist_viewmodel_arms", "head_zmb_hero_political_activist", undefined, "p3_", "_p3", "iw7_pap_zm_jock", "ges_zombies_revive_hoff", 2, "iw7_rappercard_zm", "mus_zombies_rapper", "iw7_loadout_zm_panther", "iw7_knife_zm_disco", undefined);
  scripts\cp\zombies\zombies_loadout::register_player_character(4, "yes", "body_zmb_hero_sleaze_bag", "cp_disco_male_hero_pusher_viewmodel_arms", "head_zmb_hero_sleaze_bag", undefined, "p4_", "_p4", "iw7_pap_zm_jock", "ges_zombies_revive_hoff", 3, "iw7_jockcard_zm", "mus_zombies_jock", "iw7_loadout_zm_pusher", "iw7_knife_zm_disco", undefined);
  var_0 = "iw7_loadout_zm_pam";
  var_1 = randomintrange(1, 5);
  switch (var_1) {
    case 1:
      var_0 = "iw7_loadout_zm_pam_crane";
      break;

    case 2:
      var_0 = "iw7_loadout_zm_pam_snake";
      break;

    case 3:
      var_0 = "iw7_loadout_zm_pam_tiger";
      break;

    case 4:
      var_0 = "iw7_loadout_zm_pam_dragon";
      break;

    default:
      var_0 = "iw7_loadout_zm_pam";
      break;
  }

  scripts\cp\zombies\zombies_loadout::register_player_character(5, "no", "cp_disco_female_boss_pam_grier_hero", "cp_disco_female_boss_pam_grier_viewmodel_arms", undefined, undefined, "p5_", "_p5", "iw7_pap_zm_jock", "ges_zombies_revive_hoff", 4, "iw7_hoffcard_zm", "mus_zombies_pam_grier", var_0, "iw7_knife_zm_disco", ::post_pam_setup_func);
}

post_pam_setup_func(var_0) {
  if(!isDefined(level.special_character_count)) {
    level.special_character_count = 1;
    return;
  }

  level.special_character_count++;
}