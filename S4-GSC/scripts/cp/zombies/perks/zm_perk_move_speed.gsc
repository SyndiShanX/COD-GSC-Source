/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\perks\zm_perk_move_speed.gsc
***********************************************************/

init() {
  scripts\cp\zombies\perks\zm_perks::register_perk("zm_perk_move_speed", &"COOP_PERK_MACHINES/MOVE_SPEED", &"COOP_PERK_MACHINES/MOVE_SPEED_NO_FUNDS", ::perk_level_changed, "v_ui_icons_zombies_minimap_hasteforhell");
}

perk_level_changed(var_0, var_1) {
  _id_0945::_id_D2EB("move_speed_increase", get_move_speed_increase(var_0));
  _id_073C::_id_FCCC();
}

get_move_speed_increase(var_0) {
  switch (var_0) {
    case 0:
      return 0.0;
    case 1:
      return 0.08;
    case 2:
      return 0.16;
    case 3:
      return 0.24;
    case 4:
    default:
      return 0.32;
  }
}