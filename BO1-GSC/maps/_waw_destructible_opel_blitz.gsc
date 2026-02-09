/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_waw_destructible_opel_blitz.gsc
*************************************************/

#include maps\_waw_destructible;
#using_animtree("waw_vehicles");
init_blitz() {
  set_function_pointer("explosion_anim", "dest_opel_blitz", ::get_explosion_animation);
  set_function_pointer("flattire_anim", "dest_opel_blitz", ::get_flattire_animation);
  build_destructible_radiusdamage("dest_opel_blitz", undefined, 260, 240, 40, true);
  build_destructible_deathquake("dest_opel_blitz", 0.6, 1.0, 600);
  set_pre_explosion("dest_opel_blitz", "destructibles/fx_dest_fire_car_fade_40");
  blitzes = getEntArray("broken_blitz", "script_noteworthy");
  for(i = 0; i < blitzes.size; i++) {}
}
get_explosion_animation() {
  return % v_opelblitz_explode;
}
get_flattire_animation(broken_notify) {
  if(broken_notify == "flat_tire_left_rear") {
    return % v_opelblitz_flattire_lb;
  } else if(broken_notify == "flat_tire_right_rear") {
    return % v_opelblitz_flattire_rb;
  } else if(broken_notify == "flat_tire_left_front") {
    return % v_opelblitz_flattire_lf;
  } else if(broken_notify == "flat_tire_right_front") {
    return % v_opelblitz_flattire_rf;
  }
}