/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: destructible_scripts\vehicle_uaz_fabric.gsc
*******************************************************/

#using_animtree("destructibles");

main() {
  common_scripts\_destructible::destructible_create("vehicle_uaz_fabric", "tag_body", 250, undefined, 32, "no_melee");
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
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_fabric_dsr", undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  var_0 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_0, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_0, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_0 + "_d");
  var_0 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_0, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_0 + "_d");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 40, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 40, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
}