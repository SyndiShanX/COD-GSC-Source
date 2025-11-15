/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\destructible_vehicle_city_car_water.gsc
************************************************************************/

main() {
  destructible_vehicle_city_car();
}

destructible_vehicle_city_car() {
  common_scripts\_destructible::destructible_create("destructible_vehicle_city_car_water", "tag_body", 250, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  var_0 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0 + "_fx", "fx/props/car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_0, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0 + "_fx", "fx/props/car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0 + "_fx", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0 + "_fx", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "TAG_GLASS_LEFT_MID";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0 + "_fx", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "TAG_GLASS_RIGHT_MID";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0 + "_fx", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "TAG_GLASS_SKY";
  common_scripts\_destructible::destructible_part(var_0, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0 + "_d", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0 + "_fx", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_left_front_light";
  common_scripts\_destructible::destructible_part(var_0, undefined, 60, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0, "fx/props/car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_right_front_light";
  common_scripts\_destructible::destructible_part(var_0, undefined, 60, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0, "fx/props/car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_left_back_light";
  common_scripts\_destructible::destructible_part(var_0, undefined, 60, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0, "fx/props/car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_glass_right_back_light";
  common_scripts\_destructible::destructible_part(var_0, undefined, 60, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_0, "fx/props/car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(undefined);
}