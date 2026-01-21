/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\vehicle_small_hatch.gsc
********************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

vehicle_small_hatch(color) {
  destructible_create("vehicle_small_hatch_" + color, "tag_body", 250, undefined, 32, "no_melee");

  destructible_loopfx("tag_hood_fx", "fx/smoke/car_damage_whitesmoke", 0.4);
  destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
  destructible_loopfx("tag_hood_fx", "fx/smoke/car_damage_blacksmoke", 0.4);
  destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
  destructible_loopfx("tag_hood_fx", "fx/smoke/car_damage_blacksmoke_fire", 0.4);
  destructible_sound("fire_vehicle_flareup_med");
  destructible_loopsound("fire_vehicle_med");
  destructible_healthdrain(15, 0.25, 150, "allies");
  destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
  destructible_loopsound("fire_vehicle_med");
  destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
  destructible_fx("tag_death_fx", "fx/explosions/small_vehicle_explosion", false);
  destructible_sound("car_explode");
  destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, undefined, 0.3, 500);
  destructible_anim(%vehicle_80s_sedan1_destroy, #animtree, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
  destructible_state(undefined, "vehicle_small_hatch_" + color + "_destroyed", undefined, 32, "no_melee");

  tag = "tag_hood";
  destructible_part(tag, "vehicle_small_hatch_" + color + "_hood", 800, undefined, undefined, undefined, 1.0, 1.5);

  destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
  destructible_anim(%vehicle_80s_sedan1_flattire_LF, #animtree, "setanim");
  destructible_sound("veh_tire_deflate", "bullet");
  destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
  destructible_anim(%vehicle_80s_sedan1_flattire_LB, #animtree, "setanim");
  destructible_sound("veh_tire_deflate", "bullet");
  destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
  destructible_anim(%vehicle_80s_sedan1_flattire_RF, #animtree, "setanim");
  destructible_sound("veh_tire_deflate", "bullet");
  destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
  destructible_anim(%vehicle_80s_sedan1_flattire_RB, #animtree, "setanim");
  destructible_sound("veh_tire_deflate", "bullet");

  destructible_part("tag_door_left_front", "vehicle_small_hatch_" + color + "_door_LF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  destructible_part("tag_door_right_front", "vehicle_small_hatch_" + color + "_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);

  tag = "tag_glass_front";
  destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, true);
  destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, true);
  destructible_fx("tag_glass_front_fx", "fx/props/car_glass_large");
  destructible_sound("veh_glass_break_large");
  destructible_state(undefined);

  tag = "tag_glass_back";
  destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, true);
  destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, true);
  destructible_fx("tag_glass_back_fx", "fx/props/car_glass_large");
  destructible_sound("veh_glass_break_large");
  destructible_state(undefined);

  tag = "tag_glass_left_front";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, true);
  destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, true);
  destructible_fx("tag_glass_left_front_fx", "fx/props/car_glass_med");
  destructible_sound("veh_glass_break_large");
  destructible_state(undefined);

  tag = "tag_glass_right_front";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, true);
  destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, true);
  destructible_fx("tag_glass_right_front_fx", "fx/props/car_glass_med");
  destructible_sound("veh_glass_break_large");
  destructible_state(undefined);

  tag = "tag_glass_left_back";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, true);
  destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, true);
  destructible_fx("tag_glass_left_back_fx", "fx/props/car_glass_med");
  destructible_sound("veh_glass_break_large");
  destructible_state(undefined);

  tag = "tag_glass_right_back";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, true);
  destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, true);
  destructible_fx("tag_glass_right_back_fx", "fx/props/car_glass_med");
  destructible_sound("veh_glass_break_large");
  destructible_state(undefined);

  tag = "tag_light_left_front";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
  destructible_fx(tag, "fx/props/car_glass_headlight");
  destructible_sound("veh_glass_break_small");
  destructible_state(tag + "_d");

  tag = "tag_light_right_front";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
  destructible_fx(tag, "fx/props/car_glass_headlight");
  destructible_sound("veh_glass_break_small");
  destructible_state(tag + "_d");

  tag = "tag_light_left_back";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
  destructible_fx(tag, "fx/props/car_glass_brakelight");
  destructible_sound("veh_glass_break_small");
  destructible_state(tag + "_d");

  tag = "tag_light_right_back";
  destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
  destructible_fx(tag, "fx/props/car_glass_brakelight");
  destructible_sound("veh_glass_break_small");
  destructible_state(tag + "_d");

  destructible_part("tag_bumper_front", undefined, undefined, undefined, undefined, undefined, 1.0);
  destructible_part("tag_bumper_back", undefined, undefined, undefined, undefined, undefined, 0.5);

  destructible_part("tag_mirror_left", "vehicle_small_hatch_" + color + "_mirror_L", 40, undefined, undefined, undefined, undefined, 1.0);
  destructible_physics();
  destructible_part("tag_mirror_right", "vehicle_small_hatch_" + color + "_mirror_R", 40, undefined, undefined, undefined, undefined, 1.0);
  destructible_physics();
}