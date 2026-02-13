/***************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\perks\zm_perk_hp_regen_speed.gsc
***************************************************************/

init() {
  scripts\cp\zombies\perks\zm_perks::register_perk("zm_perk_hp_regen_speed", &"COOP_PERK_MACHINES/HP_REGEN_SPEED", &"COOP_PERK_MACHINES/HP_REGEN_SPEED_NO_FUNDS", ::perk_level_changed, "v_ui_icons_zombies_minimap_fountainofrevival");
}

perk_level_changed(var_0, var_1) {
  _id_0945::_id_D2EB("regen_time_scalar", get_hp_regen_speed(var_0));
}

get_hp_regen_speed(var_0) {
  switch (var_0) {
    case 0:
      return 1.0;
    case 1:
      return 0.75;
    case 2:
      return 0.6;
    case 3:
      return 0.45;
    case 4:
    default:
      return 0.3;
  }
}