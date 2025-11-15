/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_wall_fan.gsc
*************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

main() {
  destructible_create("toy_wall_fan", "tag_swivel", 0, undefined, 32);
  destructible_anim( % wall_fan_rotate, #animtree, "setanimknob", undefined, undefined, "wall_fan_rotate");
  destructible_loopsound("wall_fan_fanning");
  destructible_state("tag_wobble", "cs_wallfan1", 150);
  destructible_anim( % wall_fan_stop, #animtree, "setanimknob", undefined, undefined, "wall_fan_wobble");
  destructible_fx("tag_fx", "fx/explosions/wallfan_explosion_dmg");
  destructible_sound("wall_fan_sparks");
  destructible_state("tag_wobble", "cs_wallfan1", 150, undefined, "no_melee");
  destructible_fx("tag_fx", "fx/explosions/wallfan_explosion_des");
  destructible_sound("wall_fan_break");
  destructible_state(undefined, "cs_wallfan1_dmg", undefined, undefined, "no_melee");
}