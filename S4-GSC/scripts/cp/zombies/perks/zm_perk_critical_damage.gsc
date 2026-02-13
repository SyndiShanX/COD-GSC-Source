/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\perks\zm_perk_critical_damage.gsc
****************************************************************/

init() {
  scripts\cp\zombies\perks\zm_perks::register_perk("zm_perk_critical_damage", &"COOP_PERK_MACHINES/CRITICAL_DAMAGE", &"COOP_PERK_MACHINES/CRITICAL_DAMAGE_NO_FUNDS", ::perk_level_changed, "v_ui_icons_zombies_minimap_thirstforblood");
}

perk_level_changed(var_0, var_1) {
  _id_0945::_id_D2EB("crit_damage_increase", get_critical_damage(var_0));
}

get_critical_damage(var_0) {
  switch (var_0) {
    case 0:
      return 1.0;
    case 1:
      return 1.25;
    case 2:
      return 1.5;
    case 3:
      return 1.75;
    case 4:
    default:
      return 2.0;
  }
}