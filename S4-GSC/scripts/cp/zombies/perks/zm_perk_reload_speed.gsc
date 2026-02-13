/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\perks\zm_perk_reload_speed.gsc
*************************************************************/

init() {
  scripts\cp\zombies\perks\zm_perks::register_perk("zm_perk_reload_speed", &"COOP_PERK_MACHINES/RELOAD_SPEED", &"COOP_PERK_MACHINES/RELOAD_SPEED_NO_FUNDS", ::perk_level_changed, "v_ui_icons_zombies_minimap_demonicfrenzy");
}

perk_level_changed(var_0, var_1) {
  var_3 = get_perk_name(var_1);

  if(isDefined(var_3)) {
    scripts\cp\utility::_id_EDCE(var_3);
  }

  var_4 = get_perk_name(var_0);

  if(isDefined(var_4)) {
    scripts\cp\utility::_id_6FC2(var_4);
  }
}

get_perk_name(var_0) {
  switch (var_0) {
    case 0:
      return undefined;
    case 1:
      return "specialty_fastreload_bonus1";
    case 2:
      return "specialty_fastreload_bonus2";
    case 3:
      return "specialty_fastreload_bonus3";
    case 4:
    default:
      return "specialty_fastreload_bonus4";
  }
}