/**************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\destructible_civilian_sedan_water_iw6.gsc
**************************************************************************/

main() {
  destructible_civilian_sedan_iw6(self.script_noteworthy);
}

destructible_civilian_sedan_iw6(var_0) {
  common_scripts\_destructible::destructible_create("destructible_civilian_sedan_water_iw6", "tag_body", 250, undefined, 32, "no_melee");
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
  var_1 = "TAG_GLASS_FRONT";
  common_scripts\_destructible::destructible_part(var_1, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1 + "_FX", "fx/props/car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "TAG_GLASS_BACK";
  common_scripts\_destructible::destructible_part(var_1, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1 + "_FX", "fx/props/car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "TAG_GLASS_LEFT_FRONT";
  common_scripts\_destructible::destructible_part(var_1, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1 + "_FX", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "TAG_GLASS_RIGHT_FRONT";
  common_scripts\_destructible::destructible_part(var_1, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1 + "_FX", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "TAG_GLASS_LEFT_BACK";
  common_scripts\_destructible::destructible_part(var_1, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1 + "_FX", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "TAG_GLASS_RIGHT_BACK";
  common_scripts\_destructible::destructible_part(var_1, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1 + "_FX", "fx/props/car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
}