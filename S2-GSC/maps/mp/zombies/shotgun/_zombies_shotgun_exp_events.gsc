/*******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_exp_events.gsc
*******************************************************************/

completed_an_objective() {
  lib_054D::giveplayersexp("dlc3_exp_ref_0");
}

individual_escape_bonus(param_00) {
  lib_054D::giveplayersexp("dlc3_exp_ref_1", param_00);
}

group_escape_bonus() {
  lib_054D::giveplayersexp("dlc3_exp_ref_2");
  if(!function_0371()) {
    lib_054D::giveplayersexp("dlc3_exp_ref_2");
  }
}

boss_defeated_bonus() {
  lib_054D::giveplayersexp("dlc3_exp_ref_3");
}

award_exp_small() {
  lib_054D::giveplayersexp("shardroom");
}

award_exp_smallish() {
  lib_054D::giveplayersexp("truevoice");
}

award_exp_med() {
  lib_054D::giveplayersexp("escortclaw");
}

award_exp_large() {
  lib_054D::giveplayersexp("brutefinale");
}