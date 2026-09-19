/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_exp_events.gsc
***************************************************************************/

completed_an_objective() {
  _id_054D::giveplayersexp("dlc3_exp_ref_0");
}

individual_escape_bonus(var_0) {
  _id_054D::giveplayersexp("dlc3_exp_ref_1", var_0);
}

group_escape_bonus() {
  _id_054D::giveplayersexp("dlc3_exp_ref_2");

  if(!_func_371())
    _id_054D::giveplayersexp("dlc3_exp_ref_2");
}

boss_defeated_bonus() {
  _id_054D::giveplayersexp("dlc3_exp_ref_3");
}

award_exp_small() {
  _id_054D::giveplayersexp("shardroom");
}

award_exp_smallish() {
  _id_054D::giveplayersexp("truevoice");
}

award_exp_med() {
  _id_054D::giveplayersexp("escortclaw");
}

award_exp_large() {
  _id_054D::giveplayersexp("brutefinale");
}