/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_chicken_common.gsc
*******************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

toy_chicken_common(version) {
  destructible_create("toy_chicken" + version, "tag_origin", 0, undefined, 32);
  destructible_anim( % chicken_cage_loop_01, #animtree, "setanimknob", undefined, 0, "chicken_cage_loop_01", 1.6);
  destructible_anim( % chicken_cage_loop_02, #animtree, "setanimknob", undefined, 1, "chicken_cage_loop_02", 1.6);
  destructible_loopsound("animal_chicken_idle_loop");
  destructible_state("tag_origin", "chicken" + version, 25);
  destructible_fx("tag_origin", "fx/props/chicken_exp" + version);
  destructible_anim( % chicken_cage_death, #animtree, "setanimknob", undefined, 0, "chicken_cage_death");
  destructible_anim( % chicken_cage_death_02, #animtree, "setanimknob", undefined, 1, "chicken_cage_death_02");
  destructible_sound("animal_chicken_death");
  destructible_state(undefined, "chicken" + version, undefined, undefined, "no_melee");
}