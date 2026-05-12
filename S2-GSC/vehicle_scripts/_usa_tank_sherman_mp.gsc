/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: vehicle_scripts\_usa_tank_sherman_mp.gsc
****************************************************/

func_00F9(param_00, param_01, param_02) {
  maps\mp\gametypes\_vehicle::func_1D26(param_01, param_00, param_01, param_02);
  maps\mp\gametypes\_vehicle::func_1D16(::func_51FB);
  maps\mp\gametypes\_vehicle::func_1D20("tank_rumble", 0.15, 4.5, 600, 1, 1);
  if(0) {}

  if(1) {
    maps\mp\gametypes\_vehicle::func_1D01("vehicle_usa_tank_sherman_75mm_no_turret", "vehicle_usa_tank_sherman_urban_b_des");
    maps\mp\gametypes\_vehicle::func_1D02(1, 1.6, 500);
    maps\mp\gametypes\_vehicle::func_1D1D((0, 0, 32), 300, 300, 0, 0);
    maps\mp\gametypes\_vehicle::func_1CFE("vfx/map/mp_raid_tank/mp_raid_tank_panzer_death", "TAG_DEATH_FX");
    maps\mp\gametypes\_vehicle::func_1CFA([["vfx/vehicle/vehicle_tank_zone4_tread_r_damage_1_lightsmoke", "vfx/vehicle/vehicle_tank_zone4_tread_r_damage_2_heavysmoke", "vfx/vehicle/vehicle_tank_zone4_tread_r_damage_3_lightfire", "vfx/vehicle/vehicle_tank_zone4_tread_r_damage_4_heavyfire"], ["vfx/vehicle/vehicle_tank_zone3_tread_l_damage_1_lightsmoke", "vfx/vehicle/vehicle_tank_zone3_tread_l_damage_2_heavysmoke", "vfx/vehicle/vehicle_tank_zone3_tread_l_damage_3_lightfire", "vfx/vehicle/vehicle_tank_zone3_tread_l_damage_4_heavyfire"], ["vfx/vehicle/vehicle_tank_zone2_side_r_damage_1_lightsmoke", "vfx/vehicle/vehicle_tank_zone2_side_r_damage_2_heavysmoke", "vfx/vehicle/vehicle_tank_zone2_side_r_damage_3_lightfire", "vfx/vehicle/vehicle_tank_zone2_side_r_damage_4_heavyfire"], ["vfx/vehicle/vehicle_tank_zone1_side_l_damage_1_lightsmoke", "vfx/vehicle/vehicle_tank_zone1_side_l_damage_2_heavysmoke", "vfx/vehicle/vehicle_tank_zone1_side_l_damage_3_lightfire", "vfx/vehicle/vehicle_tank_zone1_side_l_damage_4_heavyfire"], ["vfx/vehicle/vehicle_tank_engine_damage_1_lightsmoke", "vfx/vehicle/vehicle_tank_engine_damage_2_heavysmoke_mp", "vfx/vehicle/vehicle_tank_engine_damage_3_lightfire", "vfx/vehicle/vehicle_tank_engine_damage_4_heavyfire"]], [[1, 0.7, 0.5, 0.3], [1, 0.7, 0.5, 0.3], [1, 0.7, 0.5, 0.3], [1, 0.7, 0.5, 0.3], [1, 0.7, 0.5, 0.3]], [["right_wheel_01_jnt", "right_wheel_02_jnt", "right_wheel_03_jnt", "right_wheel_04_jnt", "right_wheel_05_jnt", "right_wheel_06_jnt", "right_wheel_07_jnt", "right_wheel_08_jnt"], ["left_wheel_01_jnt", "left_wheel_02_jnt", "left_wheel_03_jnt", "left_wheel_04_jnt", "left_wheel_05_jnt", "left_wheel_06_jnt", "left_wheel_07_jnt", "left_wheel_08_jnt"], ["tag_brakelight_right_d", "tag_headlight_right_d"], ["tag_brakelight_left_d", "tag_headlight_left_d"], ["tag_engine", "tag_engine"]], [60, 60, 130, 130, undefined], undefined, 10, 15);
  }

  if(1) {
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "headlight_L", "TAG_HEADLIGHT_LEFT_D", "vfx/lights/headlight_kubelwagen_bright_lt", "running", 0);
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "headlight_R", "TAG_HEADLIGHT_RIGHT_D", "vfx/lights/headlight_kubelwagen_bright_rt", "running", 0);
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "brakelight_L", "TAG_BRAKELIGHT_LEFT_D", "vfx/lights/headlight_kubelwagen_bright_lt", "running", 0);
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "brakelight_R", "TAG_BRAKELIGHT_RIGHT_D", "vfx/lights/headlight_kubelwagen_bright_rt", "running", 0);
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "headlight_L", "TAG_HEADLIGHT_LEFT_D", "vfx/lights/headlight_kubelwagen_bright_lt", "headlights", 0);
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "headlight_R", "TAG_HEADLIGHT_RIGHT_D", "vfx/lights/headlight_kubelwagen_bright_rt", "headlights", 0);
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "brakelight_L", "TAG_BRAKELIGHT_LEFT_D", "vfx/lights/taillight_vrap_bright_lt", "headlights", 0);
    maps\mp\gametypes\_vehicle::func_1D14(param_02, "brakelight_R", "TAG_BRAKELIGHT_RIGHT_D", "vfx/lights/taillight_vrap_bright_rt", "headlights", 0);
  }
}

func_764D() {}

func_51FB() {
  self.var_2A88 = 1;
}

func_526A() {}