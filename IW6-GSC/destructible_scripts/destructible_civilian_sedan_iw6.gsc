/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\destructible_civilian_sedan_iw6.gsc
********************************************************************/

main() {
  destructible_civilian_sedan_iw6(self.script_noteworthy);
}

#using_animtree("destructibles");

destructible_civilian_sedan_iw6(var_0) {
  common_scripts\_destructible::destructible_create("destructible_civilian_sedan_iw6", "tag_body", 250, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx/smoke/car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx/smoke/car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx/smoke/car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("TAG_DEATH_FX", "fx/explosions/vehicle_explosion_medium", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
  common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_destroy, #animtree, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_civilian_sedan_" + var_0 + "_destroy_iw6", undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee", 1.0, 1.0);
  common_scripts\_destructible::destructible_anim(%vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
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
  var_1 = "TAG_LIGHT_LEFT_FRONT";
  common_scripts\_destructible::destructible_part(var_1, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1, "fx/props/car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "TAG_LIGHT_RIGHT_FRONT";
  common_scripts\_destructible::destructible_part(var_1, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1 + "_D", undefined, 60, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx(var_1, "fx/props/car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(undefined);
}