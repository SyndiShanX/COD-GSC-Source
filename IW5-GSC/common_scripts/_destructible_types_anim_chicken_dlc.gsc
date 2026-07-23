/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_destructible_types_anim_chicken_dlc.gsc
*******************************************************************/

#using_animtree("destructibles");

main() {
  level._destructible_preanims["chicken_cage_death"] = % chicken_cage_death;
  level._destructible_preanims["chicken_cage_death_02"] = % chicken_cage_death_02;
  add_chicken_anims();
}

#using_animtree("chicken");

add_chicken_anims() {
  level._destructible_preanims["Chicken_cage_pecking_idle"] = % chicken_cage_pecking_idle;
  level._destructible_preanims["Chicken_cage_seated_idle"] = % chicken_cage_seated_idle;
}