/**********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_v1_objective_mods.gsc
**********************************************************************************/

get_assassin_types(var_0) {
  var_1 = [];

  switch (var_0) {
    case 0:
      var_1 = ["zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock"];
      break;
    case 1:
      var_2 = ["zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_camoflauge"];
      var_3 = ["zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_shellshock", "zombie_assassin_frontline"];
      var_1 = common_scripts\utility::random([var_2, var_3]);
      break;
    case 2:
      var_2 = ["zombie_assassin_shellshock", "zombie_assassin_camoflauge", "zombie_assassin_freefire", "zombie_assassin_freefire"];
      var_3 = ["zombie_assassin_shellshock", "zombie_assassin_frontline", "zombie_assassin_freefire", "zombie_assassin_camoflauge"];
      var_1 = common_scripts\utility::random([var_2, var_3]);
      break;
  }

  return common_scripts\utility::array_randomize(var_1);
}