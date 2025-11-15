/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: destructible_scripts\vehicle_bm21.gsc
*************************************************/

#using_animtree("destructibles");

vehicle_bm21(var_0, var_1) {
  common_scripts\_destructible::destructible_create(var_0, "tag_body", 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_deathfx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
  common_scripts\_destructible::destructible_state(undefined, var_1, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  var_2 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_2, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_2 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_2 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_2, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_2 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_2 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_2, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_2 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_2 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_2, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_2 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
}