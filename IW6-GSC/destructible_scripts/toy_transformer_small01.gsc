/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_transformer_small01.gsc
************************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

main() {
  destructible_create("toy_transformer_small01", "tag_origin", 75, undefined, 32, "no_melee");
  destructible_splash_damage_scaler(15);
  destructible_loopfx("tag_fx", "fx/smoke/car_damage_whitesmoke", 0.4);
  destructible_state(undefined, undefined, 75, undefined, 32, "no_melee");
  destructible_loopfx("tag_fx", "fx/smoke/car_damage_blacksmoke", 0.4);
  destructible_state(undefined, undefined, 150, undefined, 32, "no_melee");
  destructible_loopfx("tag_fx", "fx/explosions/transformer_spark_runner", .5);
  destructible_loopsound("transformer_spark_loop");
  destructible_healthdrain(24, 0.2);
  destructible_state(undefined, undefined, 250, undefined, 32, "no_melee");
  destructible_loopfx("tag_fx", "fx/explosions/transformer_spark_runner", .5);
  destructible_loopfx("tag_fx", "fx/fire/transformer_small_blacksmoke_fire", .4);
  destructible_sound("transformer01_flareup_med");
  destructible_loopsound("transformer_spark_loop");
  destructible_healthdrain(24, 0.2, 150, "allies");
  destructible_state(undefined, undefined, 400, undefined, 5, "no_melee");
  destructible_fx("tag_fx", "fx/explosions/transformer_explosion", false);
  destructible_fx("tag_fx", "fx/fire/firelp_small_pm");
  destructible_sound("transformer01_explode");
  destructible_explode(7000, 8000, 150, 256, 16, 100, undefined, 0);
  destructible_state(undefined, "utility_transformer_small01_dest", undefined, undefined, "no_melee");
}