/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_light_ceiling_fluorescent.gsc
******************************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

main() {
  destructible_create("toy_light_ceiling_fluorescent", "tag_origin", 150, undefined, 32, "no_melee");
  destructible_splash_damage_scaler(15);
  destructible_fx("tag_fx", "fx/misc/light_fluorescent_blowout_runner");
  destructible_fx("tag_swing_fx", "fx/misc/light_blowout_swinging_runner");
  destructible_lights_out(16);
  destructible_explode(20, 2000, 64, 64, 40, 80);
  destructible_anim( % light_fluorescent_swing, #animtree, "setanimknob", undefined, 0, "light_fluorescent_swing");
  destructible_sound("fluorescent_light_fall", undefined, 0);
  destructible_sound("fluorescent_light_bulb", undefined, 0);

  destructible_anim( % light_fluorescent_swing_02, #animtree, "setanimknob", undefined, 1, "light_fluorescent_swing_02");
  destructible_sound("fluorescent_light_fall", undefined, 1);
  destructible_sound("fluorescent_light_bulb", undefined, 1);

  destructible_anim( % light_fluorescent_null, #animtree, "setanimknob", undefined, 2, "light_fluorescent_null");
  destructible_state(undefined, "me_lightfluohang_double_destroyed", undefined, undefined, "no_melee");
}