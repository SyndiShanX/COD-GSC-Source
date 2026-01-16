/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_destructible_types.gsc
**************************************************/

maketype(var_0) {
  var_1 = getinfoindex(var_0);

  if(var_1 >= 0)
    return var_1;

  switch (var_0) {
    case "vehicle_80s_sedan1_green":
      vehicle_80s_sedan1("green");
      break;
    case "vehicle_80s_sedan1_red":
      vehicle_80s_sedan1("red");
      break;
    case "vehicle_80s_sedan1_silv":
      vehicle_80s_sedan1("silv");
      break;
    case "vehicle_80s_sedan1_tan":
      vehicle_80s_sedan1("tan");
      break;
    case "vehicle_80s_sedan1_yel":
      vehicle_80s_sedan1("yel");
      break;
    case "vehicle_80s_sedan1_brn":
      vehicle_80s_sedan1("brn");
      break;
    case "vehicle_80s_sedan1_green_side":
      vehicle_80s_sedan1_side("green");
      break;
    case "vehicle_80s_sedan1_red_side":
      vehicle_80s_sedan1_side("red");
      break;
    case "vehicle_80s_sedan1_silv_side":
      vehicle_80s_sedan1_side("silv");
      break;
    case "vehicle_80s_sedan1_tan_side":
      vehicle_80s_sedan1_side("tan");
      break;
    case "vehicle_80s_sedan1_yel_side":
      vehicle_80s_sedan1_side("yel");
      break;
    case "vehicle_80s_sedan1_brn_side":
      vehicle_80s_sedan1_side("brn");
      break;
    case "vehicle_bus_destructible":
      vehicle_bus_destructible();
      break;
    case "vehicle_80s_wagon1_green":
      vehicle_80s_wagon1("green");
      break;
    case "vehicle_80s_wagon1_red":
      vehicle_80s_wagon1("red");
      break;
    case "vehicle_80s_wagon1_silv":
      vehicle_80s_wagon1("silv");
      break;
    case "vehicle_80s_wagon1_tan":
      vehicle_80s_wagon1("tan");
      break;
    case "vehicle_80s_wagon1_yel":
      vehicle_80s_wagon1("yel");
      break;
    case "vehicle_80s_wagon1_brn":
      vehicle_80s_wagon1("brn");
      break;
    case "vehicle_80s_wagon1_decayed_green":
      vehicle_80s_wagon1("decayed_green");
      break;
    case "vehicle_80s_wagon1_decayed_red":
      vehicle_80s_wagon1("decayed_red");
      break;
    case "vehicle_80s_wagon1_decayed_silv":
      vehicle_80s_wagon1("decayed_silv");
      break;
    case "vehicle_80s_wagon1_decayed_white":
      vehicle_80s_wagon1("decayed_white");
      break;
    case "vehicle_80s_wagon1_decayed_yel":
      vehicle_80s_wagon1("decayed_yel");
      break;
    case "vehicle_80s_wagon1_decayed_brn":
      vehicle_80s_wagon1("decayed_brn");
      break;
    case "vehicle_80s_hatch1_green":
      vehicle_80s_hatch1("green");
      break;
    case "vehicle_80s_hatch1_red":
      vehicle_80s_hatch1("red");
      break;
    case "vehicle_80s_hatch1_silv":
      vehicle_80s_hatch1("silv");
      break;
    case "vehicle_80s_hatch1_tan":
      vehicle_80s_hatch1("tan");
      break;
    case "vehicle_80s_hatch1_yel":
      vehicle_80s_hatch1("yel");
      break;
    case "vehicle_80s_hatch1_brn":
      vehicle_80s_hatch1("brn");
      break;
    case "vehicle_80s_hatch1_decayed_green":
      vehicle_80s_hatch1("decayed_green");
      break;
    case "vehicle_80s_hatch1_decayed_red":
      vehicle_80s_hatch1("decayed_red");
      break;
    case "vehicle_80s_hatch1_decayed_silv":
      vehicle_80s_hatch1("decayed_silv");
      break;
    case "vehicle_80s_hatch1_decayed_white":
      vehicle_80s_hatch1("decayed_white");
      break;
    case "vehicle_80s_hatch1_decayed_yel":
      vehicle_80s_hatch1("decayed_yel");
      break;
    case "vehicle_80s_hatch1_decayed_brn":
      vehicle_80s_hatch1("decayed_brn");
      break;
    case "vehicle_80s_hatch2_green":
      vehicle_80s_hatch2("green");
      break;
    case "vehicle_80s_hatch2_red":
      vehicle_80s_hatch2("red");
      break;
    case "vehicle_80s_hatch2_silv":
      vehicle_80s_hatch2("silv");
      break;
    case "vehicle_80s_hatch2_tan":
      vehicle_80s_hatch2("tan");
      break;
    case "vehicle_80s_hatch2_yel":
      vehicle_80s_hatch2("yel");
      break;
    case "vehicle_80s_hatch2_brn":
      vehicle_80s_hatch2("brn");
      break;
    case "vehicle_small_wagon_blue":
      vehicle_small_wagon("blue");
      break;
    case "vehicle_small_wagon_green":
      vehicle_small_wagon("green");
      break;
    case "vehicle_small_wagon_turq":
      vehicle_small_wagon("turq");
      break;
    case "vehicle_small_wagon_white":
      vehicle_small_wagon("white");
      break;
    case "vehicle_small_hatch_blue":
      vehicle_small_hatch("blue");
      break;
    case "vehicle_small_hatch_green":
      vehicle_small_hatch("green");
      break;
    case "vehicle_small_hatch_turq":
      vehicle_small_hatch("turq");
      break;
    case "vehicle_small_hatch_white":
      vehicle_small_hatch("white");
      break;
    case "vehicle_bm21_cover":
      vehicle_bm21(var_0, "_cover", "vehicle_bm21_mobile_cover_dstry");
      break;
    case "vehicle_bm21_cover_under":
      vehicle_bm21(var_0, "_cover_under", "vehicle_bm21_mobile_cover_dstry");
      break;
    case "vehicle_bm21_mobile_bed":
      vehicle_bm21(var_0, "_mobile_bed", "vehicle_bm21_mobile_bed_dstry");
      break;
    case "vehicle_bm21_bed_under":
      vehicle_bm21(var_0, "_bed_under", "vehicle_bm21_mobile_bed_dstry");
      break;
    case "vehicle_uaz_fabric":
      vehicle_uaz_fabric(var_0);
      break;
    case "vehicle_uaz_open":
      vehicle_uaz_open(var_0);
      break;
    case "vehicle_uaz_light":
      vehicle_uaz_light(var_0);
      break;
    case "vehicle_uaz_hardtop":
      vehicle_uaz_hardtop(var_0);
      break;
    case "vehicle_pickup":
      vehicle_pickup(var_0);
      break;
    case "vehicle_80s_hatch1_thermal":
      vehicle_80s_hatch1_thermal("thermal");
      break;
    case "vehicle_80s_hatch2_thermal":
      vehicle_80s_hatch2_thermal("thermal");
      break;
    case "vehicle_80s_sedan1_thermal":
      vehicle_80s_sedan1_thermal("thermal");
      break;
    case "vehicle_80s_wagon1_thermal":
      vehicle_80s_wagon1_thermal("thermal");
      break;
    case "vehicle_luxurysedan_thermal":
      vehicle_luxurysedan_thermal("thermal");
      break;
    case "vehicle_small_hatch_thermal":
      vehicle_small_hatch_thermal("thermal");
      break;
    case "vehicle_80s_hatch1_lowres_brn":
      vehicle_80s_hatch1_lowres(var_0, "brn");
      break;
    case "vehicle_80s_hatch2_lowres_green":
      vehicle_80s_hatch2_lowres(var_0, "green");
      break;
    case "vehicle_small_hatchback_lowres_turq":
      vehicle_small_hatchback_lowres(var_0, "turq");
      break;
    case "vehicle_80s_sedan1_lowres_red":
      vehicle_80s_sedan1_lowres_red(var_0);
      break;
    case "vehicle_80s_sedan1_lowres_green":
      vehicle_80s_sedan1_lowres(var_0, "green");
      break;
    case "vehicle_80s_wagon1_lowres_silv":
      vehicle_80s_wagon1_lowres(var_0, "silv");
      break;
    case "vehicle_luxurysedan_lowres":
      vehicle_luxurysedan_lowres(var_0, undefined);
      break;
    case "vehicle_tanker_truck":
      vehicle_tanker_truck(var_0);
      break;
    case "vehicle_80s_sedan1_silv_nofire":
      vehicle_80s_sedan1_nofire("silv");
      break;
    case "vehicle_80s_sedan1_tan_nofire":
      vehicle_80s_sedan1_nofire("tan");
      break;
    case "vehicle_80s_wagon1_red_nofire":
      vehicle_80s_wagon1_nofire("red");
      break;
    default:
      break;
  }

  var_1 = getinfoindex(var_0);
  return var_1;
}

getinfoindex(var_0) {
  if(!isdefined(level.destructible_type))
    return -1;

  if(level.destructible_type.size == 0)
    return -1;

  for (var_1 = 0; var_1 < level.destructible_type.size; var_1++) {
    if(var_0 == level.destructible_type[var_1].v["type"])
      return var_1;
  }

  return -1;
}

#using_animtree("vehicles");

vehicle_80s_sedan1(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 2.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_hood_dam");
  var_1 = "tag_trunk";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_trunk", 1000, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_trunk_dam", 2000);
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 2.3, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_80s_sedan1_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_80s_sedan1_" + var_0 + "_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_sedan1_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_80s_sedan1_" + var_0 + "_door_RB", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_sedan1_" + var_0 + "_bumper_F", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_sedan1_" + var_0 + "_bumper_B", undefined, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_sedan1_" + var_0 + "_mirror_L", 10);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_sedan1_" + var_0 + "_mirror_R", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
}

vehicle_80s_sedan1_side(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + var_0 + "_side", 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 2.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_hood_dam");
  var_1 = "tag_trunk";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_trunk", 1000, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_trunk_dam", 2000);
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_80s_sedan1_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_80s_sedan1_" + var_0 + "_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_sedan1_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_80s_sedan1_" + var_0 + "_door_RB", undefined, undefined, undefined, undefined, undefined, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_sedan1_" + var_0 + "_bumper_F", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_sedan1_" + var_0 + "_bumper_B", undefined, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_sedan1_" + var_0 + "_mirror_L", 10);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_sedan1_" + var_0 + "_mirror_R", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
}

vehicle_bus_destructible() {
  common_scripts\_destructible::destructible_create("vehicle_bus_destructible");
  var_0 = "tag_window_front_left";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_fl", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_fl_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_front_left", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_front_right";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_fr", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_fr_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_front_right", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_driver";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_driver", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_driver_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_driver", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_back";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_back", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_back_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_back", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_1";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_1", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_2";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_2", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_3";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_3", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_4";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_4", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_5";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_5", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_6";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_6", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_7";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_7", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_8";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_8", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_9";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_9", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_10";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_10", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_0 = "tag_window_side_11";
  common_scripts\_destructible::destructible_part(var_0, "vehicle_bus_glass_side", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_0, "vehicle_bus_glass_side_dest", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_window_side_11", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
}

vehicle_80s_wagon1(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 1.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_hood_dam");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_80s_wagon1_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_80s_wagon1_" + var_0 + "_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_wagon1_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_80s_wagon1_" + var_0 + "_door_RB", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_F", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_B", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_LF", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_RF", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_LB", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_RB", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back2";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_LB2", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back2";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_RB2", 200, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_wagon1_" + var_0 + "_bumper_F", undefined, undefined, undefined, undefined, 1.0, 0.7);
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_wagon1_" + var_0 + "_bumper_B", undefined, undefined, undefined, undefined, undefined, 0.6);
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_wagon1_" + var_0 + "_mirror_L", 10);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_wagon1_" + var_0 + "_mirror_R", 10);
  common_scripts\_destructible::destructible_physics();
}

vehicle_80s_hatch1(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_hatch1_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 1.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_" + var_0 + "_hood_dam");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_hatch1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_hatch1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_hatch1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_hatch1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_80s_hatch1_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_hatch1_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_LB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_RB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch1_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_hatch1_" + var_0 + "_bumper_F");
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_hatch1_" + var_0 + "_bumper_B");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_hatch1_" + var_0 + "_mirror_L", 10);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_hatch1_" + var_0 + "_mirror_R", 10);
  common_scripts\_destructible::destructible_physics();
}

vehicle_80s_hatch2(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_hatch2_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 1.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_" + var_0 + "_hood_dam");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_hatch2_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_hatch2_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_hatch2_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_hatch2_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_80s_hatch2_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_hatch2_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_LB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_RB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_hatch2_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_hatch2_" + var_0 + "_bumper_F");
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_hatch2_" + var_0 + "_bumper_B");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_hatch2_" + var_0 + "_mirror_L", 10);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_hatch2_" + var_0 + "_mirror_R", 10);
  common_scripts\_destructible::destructible_physics();
}

vehicle_small_wagon(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_small_wagon_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_wagon_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_wagon_" + var_0 + "_destructible", 100, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_wagon_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_wagon_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_wagon_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 1.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_" + var_0 + "_hood_dam");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_small_wagon_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_small_wagon_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_small_wagon_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_small_wagon_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_small_wagon_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_state("tag_door_left_front", "vehicle_small_wagon_" + var_0 + "_door_lf_dam");
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_small_wagon_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_state("tag_door_right_front", "vehicle_small_wagon_" + var_0 + "_door_rf_dam");
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_" + var_0 + "_light_LB", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_wagon_" + var_0 + "_light_RB", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_wagon_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_small_wagon_" + var_0 + "_bumper_F", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_small_wagon_" + var_0 + "_bumper_B", undefined, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_small_wagon_" + var_0 + "_mirror_L", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_small_wagon_" + var_0 + "_mirror_R", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
}

vehicle_small_hatch(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_small_hatch_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 1.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_" + var_0 + "_hood_dam");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_small_hatch_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_small_hatch_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_small_hatch_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_small_hatch_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_small_hatch_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_small_hatch_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_" + var_0 + "_light_LB", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_small_hatch_" + var_0 + "_light_RB", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_small_hatch_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_small_hatch_" + var_0 + "_bumper_F", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_small_hatch_" + var_0 + "_bumper_B", undefined, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_small_hatch_" + var_0 + "_mirror_L", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_small_hatch_" + var_0 + "_mirror_R", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
}

vehicle_80s_wagon1_thermal(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 800, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\large_vehicle_explosion_IR");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destroyed");
}

vehicle_80s_hatch1_thermal(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_hatch1_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_0 + "_destructible", 800, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\large_vehicle_explosion_IR");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_0 + "_destroyed");
}

vehicle_80s_hatch2_thermal(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_hatch2_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_0 + "_destructible", 800, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\large_vehicle_explosion_IR");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_0 + "_destroyed");
}

vehicle_80s_sedan1_thermal(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 800, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\large_vehicle_explosion_IR");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destroyed");
}

vehicle_small_hatch_thermal(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_small_hatch_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + var_0 + "_destructible", 800, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\large_vehicle_explosion_IR");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + var_0 + "_destroyed");
}

vehicle_luxurysedan_thermal(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_luxurysedan_" + var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_luxurysedan_" + var_0 + "_static", 800, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\large_vehicle_explosion_IR");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_luxurysedan_" + var_0 + "_destroy");
}

vehicle_80s_hatch1_lowres(var_0, var_1) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_1, 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\small_vehicle_explosion_airlift");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + var_1 + "_destroyed");
}

vehicle_80s_hatch2_lowres(var_0, var_1) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_1, 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\small_vehicle_explosion_airlift");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + var_1 + "_destroyed");
}

vehicle_small_hatchback_lowres(var_0, var_1) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatchback_" + var_1, 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\small_vehicle_explosion_airlift");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatchback_d_" + var_1);
}

vehicle_80s_sedan1_lowres_red(var_0) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_red_low", 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\small_vehicle_explosion_airlift");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_red_destroyed");
}

vehicle_80s_sedan1_lowres(var_0, var_1) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_1, 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\small_vehicle_explosion_airlift");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  var_2 = undefined;

  if(var_1 == "green")
    var_2 = "dest";
  else
    var_2 = "_destroyed";

  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_1 + var_2);
}

vehicle_80s_wagon1_lowres(var_0, var_1) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_1, 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\small_vehicle_explosion_airlift");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_1 + "_destroyed");
}

vehicle_luxurysedan_lowres(var_0, var_1) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_luxurysedan", 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\small_vehicle_explosion_airlift");
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_luxurysedan_destroy");
}

vehicle_tanker_truck(var_0) {
  common_scripts\_destructible::destructible_create(var_0, 600, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_tanker_truck_static_low", 800, "no_ai", 32, "no_melee");
  common_scripts\_destructible::destructible_fx(undefined, "fx\explosions\tanker_explosion");
  common_scripts\_destructible::destructible_sound("exp_tanker_vehicle");
  common_scripts\_destructible::destructible_explode(4000, 5000, 768, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_tanker_truck_d2");
}

vehicle_bm21(var_0, var_1, var_2) {
  common_scripts\_destructible::destructible_create("vehicle_bm21" + var_1, 1500, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_bm21" + var_1 + "_destructible", 100, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_origin", "fx\explosions\large_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_bm21_mobile_bed_dstry");
  var_3 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_3, "vehicle_bm21_glass_F", 800, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_3, "vehicle_bm21_glass_F_dam", 800, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_3 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_3, "vehicle_bm21_glass_B", 250, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_3, "vehicle_bm21_glass_B_dam", 400, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_3 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_3, "vehicle_bm21_glass_LF", 250, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_3, "vehicle_bm21_glass_LF_dam", 400, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_3 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_3, "vehicle_bm21_glass_RF", 250, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_3, "vehicle_bm21_glass_RF_dam", 400, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_bm21_wheel_LF", 0, undefined, undefined, undefined, undefined);
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_bm21_wheel_LF", 0, undefined, undefined, undefined);
  common_scripts\_destructible::destructible_part("left_wheel_03_jnt", "vehicle_bm21_wheel_LF", 0, undefined, undefined, undefined);
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_bm21_wheel_RF", 0, undefined, undefined, undefined, undefined);
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_bm21_wheel_RF", 0, undefined, undefined, undefined, undefined);
  common_scripts\_destructible::destructible_part("right_wheel_03_jnt", "vehicle_bm21_wheel_RF", 0, undefined, undefined, undefined, undefined);
}

vehicle_uaz_fabric(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_uaz_fabric", 550, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_fabric_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_fabric_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_fabric_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_fabric_destructible", 100, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_origin", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_fabric_dsr");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee", undefined, undefined);
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee", undefined, undefined);
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_uaz_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_uaz_door_RF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_uaz_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_uaz_door_RB", undefined, undefined, undefined, undefined, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_fabric_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_fabric_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_LF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_RF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_RF_dam");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 99);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 99);
  common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_open(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_uaz_open", 550, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_open_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_open_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_open_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_open_destructible", 100, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_origin", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_open_dsr");
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee", undefined);
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee", undefined);
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_uaz_open_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_uaz_open_door_RF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_uaz_open_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_uaz_open_door_RB", undefined, undefined, undefined, undefined, 1.0);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_LF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_RF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_RF_dam");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 99);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 99);
  common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_light(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_uaz_light", 350, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_light_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_light_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_light_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_light_destructible", 100, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_origin", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_light_dsr");
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee", undefined);
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee", undefined);
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_uaz_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_uaz_door_RF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_uaz_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_uaz_door_RB", undefined, undefined, undefined, undefined, 1.0);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_LF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_RF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_RF_dam");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 99);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 99);
  common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_hardtop(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_uaz_hardtop", 550, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_hardtop_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_hardtop_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_hardtop_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_hardtop_destructible", 100, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_origin", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_hardtop_dsr");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_uaz_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_uaz_door_RF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_uaz_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_uaz_door_RB", undefined, undefined, undefined, undefined, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back2";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_LB2", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_LB2_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back2";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_RB2", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_RB2_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee", undefined);
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF", 20, undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee", undefined);
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF", 20, undefined, undefined, "no_melee");
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_LF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_light_RF", 99, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_light_RF_dam");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 99);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 99);
  common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_open_for_ride(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_uaz_open_for_ride", 550, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_open_destructible", 100, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_origin", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_uaz_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_uaz_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
}

vehicle_80s_sedan1_nofire(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + var_0 + "_nofire", 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion_nofire", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 2.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_hood_dam");
  var_1 = "tag_trunk";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_trunk", 1000, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_trunk_dam", 2000);
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_sedan1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_80s_sedan1_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_80s_sedan1_" + var_0 + "_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_sedan1_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_80s_sedan1_" + var_0 + "_door_RB", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_sedan1_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_sedan1_" + var_0 + "_bumper_F", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_sedan1_" + var_0 + "_bumper_B", undefined, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_sedan1_" + var_0 + "_mirror_L", 10);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_sedan1_" + var_0 + "_mirror_R", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
}

vehicle_80s_wagon1_nofire(var_0) {
  common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + var_0 + "_nofire", 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion_nofire", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + var_0 + "_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_hood", 800, undefined, undefined, undefined, 1.0, 1.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_hood_dam");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_wagon1_" + var_0 + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_80s_wagon1_" + var_0 + "_door_LF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_80s_wagon1_" + var_0 + "_door_LB", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_wagon1_" + var_0 + "_door_RF", undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_80s_wagon1_" + var_0 + "_door_RB", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back2";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_LB2", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_LB2_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back2";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_glass_RB2", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_glass_RB2_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RF_dam");
  var_1 = "tag_light_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_LB_dam");
  var_1 = "tag_light_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RB", 10);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_brakelight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_80s_wagon1_" + var_0 + "_light_RB_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_wagon1_" + var_0 + "_bumper_F", undefined, undefined, undefined, undefined, 1.0, 0.7);
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_wagon1_" + var_0 + "_bumper_B", undefined, undefined, undefined, undefined, undefined, 0.6);
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_wagon1_" + var_0 + "_mirror_L", 10);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_wagon1_" + var_0 + "_mirror_R", 10);
  common_scripts\_destructible::destructible_physics();
}

vehicle_pickup(var_0) {
  common_scripts\_destructible::destructible_create(var_0, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_whitesmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_pickup_destructible", 200, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke", 0.4);
  common_scripts\_destructible::destructible_state(undefined, "vehicle_pickup_destructible", 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "fx\smoke\car_damage_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_pickup_destructible", 300, "player_only", 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_pickup_destructible", 400, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx\explosions\small_vehicle_explosion", 0);
  common_scripts\_destructible::destructible_sound("car_explode");
  common_scripts\_destructible::destructible_sound("fire_vehicle_small");
  common_scripts\_destructible::destructible_explode(4000, 5000, 200, 150, 300);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_destroy, #animtree, "setanimknob");
  common_scripts\_destructible::destructible_state(undefined, "vehicle_pickup_destroyed", undefined, 32, "no_melee");
  var_1 = "tag_hood";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_hood", 800, undefined, undefined, undefined, 1.0, 2.5);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_hood_dam");
  common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_pickup_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_pickup_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_lb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_pickup_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rf, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_pickup_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 0, undefined, 1);
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_rb, #animtree, "setanim");
  common_scripts\_destructible::destructible_anim( % vehicle_80s_sedan1_flattire_tire, #animtree, "setanim", 1);
  common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
  common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_pickup_door_LF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_pickup_door_RF", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_part("tag_rear_tailgate", "vehicle_pickup_rear_tailgate", undefined, undefined, undefined, undefined, 1.0, 1.0);
  var_1 = "tag_glass_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_glass_F", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_glass_F_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_glass_B", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_glass_B_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "fx\props\car_glass_large");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_glass_LF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_glass_LF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_glass_RF", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_glass_RF_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_left_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_glass_LB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_glass_LB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_glass_right_back";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_glass_RB", 10, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_glass_RB_dam", 200, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "fx\props\car_glass_med");
  common_scripts\_destructible::destructible_sound("veh_glass_break_large");
  common_scripts\_destructible::destructible_state(undefined);
  var_1 = "tag_light_left_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_light_LF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_light_LF_dam");
  var_1 = "tag_light_right_front";
  common_scripts\_destructible::destructible_part(var_1, "vehicle_pickup_light_RF", 10, undefined, undefined, undefined, 0.5);
  common_scripts\_destructible::destructible_fx(var_1, "fx\props\car_glass_headlight");
  common_scripts\_destructible::destructible_sound("veh_glass_break_small");
  common_scripts\_destructible::destructible_state(var_1, "vehicle_pickup_light_RF_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_pickup_bumper_F", undefined, undefined, undefined, undefined, 1.0, 1.0);
  common_scripts\_destructible::destructible_state("tag_bumper_front", "vehicle_pickup_bumper_f_dam");
  common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_pickup_bumper_B", undefined, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_state("tag_bumper_back", "vehicle_pickup_bumper_b_dam");
  common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_pickup_mirror_L", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_pickup_mirror_R", 10, undefined, undefined, undefined, undefined, 1.0);
  common_scripts\_destructible::destructible_physics();
}