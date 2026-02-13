/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\perks\zm_perk_hp.gsc
***************************************************/

init() {
  scripts\cp\zombies\perks\zm_perks::register_perk("zm_perk_hp", &"COOP_PERK_MACHINES/HP", &"COOP_PERK_MACHINES/HP_NO_FUNDS", ::perk_level_changed, "v_ui_icons_zombies_minimap_heartofhealth");
}

perk_level_changed(var_0, var_1) {
  var_2 = var_0 > var_1;
  self._id_AFAA["max_health"] = get_max_health(var_0);
  self.maxhealth = self._id_AFAA["max_health"];
  self.health = int(min(self.health, self.maxhealth));

  if(var_2) {
    self.health = self.maxhealth;
    self notify("health_perk_upgrade");
  }
}

get_max_health(var_0) {
  switch (var_0) {
    case 0:
      return 100;
    case 1:
      return 150;
    case 2:
      return 200;
    case 3:
      return 250;
    case 4:
    default:
      return 300;
  }
}