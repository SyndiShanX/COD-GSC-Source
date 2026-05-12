/**************************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_v1_objective_mods.gsc
**************************************************************************/

get_assassin_types(param_00) {
  var_01 = [];
  switch (param_00) {
    case 0:
      var_01 = ["zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock"];
      break;

    case 1:
      var_02 = ["zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_camoflauge"];
      var_03 = ["zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_frontline"];
      var_01 = common_scripts\utility::func_7A33([var_02, var_03]);
      break;

    case 2:
      var_02 = ["zombie_assassin_shellshock", "zombie_assassin_camoflauge", "zombie_assassin_freefire", "zombie_assassin_freefire"];
      var_03 = ["zombie_assassin_shellshock", "zombie_assassin_frontline", "zombie_assassin_freefire", "zombie_assassin_camoflauge"];
      var_01 = common_scripts\utility::func_7A33([var_02, var_03]);
      break;
  }

  return common_scripts\utility::func_F92(var_01);
}