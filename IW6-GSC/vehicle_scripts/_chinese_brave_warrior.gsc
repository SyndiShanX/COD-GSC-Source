/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_chinese_brave_warrior.gsc
******************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("humvee", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);

  if(issubstr(var_2, "turret")) {
    maps\_vehicle::build_turret("minigun_m1a1_fast", "tag_turret", "weapon_chinese_brave_warrior_turret", undefined, "sentry", undefined, 0, 0, (0, 0, -16));
  }

  maps\_vehicle::build_deathmodel("vehicle_chinese_brave_warrior_anim", "vehicle_chinese_brave_warrior_destroyed");
  maps\_vehicle::build_unload_groups(::unload_groups);
  level._effect["gazexplode"] = loadfx("fx/explosions/vehicle_explosion_hummer_nodoors");
  level._effect["gazsmfire"] = loadfx("fx/fire/firelp_med_pm");
  maps\_vehicle::build_deathfx("fx/fire/firelp_med_pm", "tag_driver", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx("fx/explosions/vehicle_explosion_hummer_nodoors", "tag_body", "clkw_scn_ice_chase_expl", undefined, undefined, undefined, undefined);
  maps\_vehicle::build_drive( % humvee_50cal_driving_idle_forward, % humvee_50cal_driving_idle_backward, 10);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_light(var_2, "headlight_truck_left", "tag_headlight_left", "fx/misc/car_headlight_jeep_l_clk", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_right", "tag_headlight_right", "fx/misc/car_headlight_jeep_r_clk", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_right", "tag_brakelight_right", "fx/misc/car_taillight_jeep_r_clk", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_left", "tag_brakelight_left", "fx/misc/car_taillight_jeep_l_clk", "headlights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_right", "tag_brakelight_right", "fx/misc/car_brakelight_truck_R_pb", "brakelights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_left", "tag_brakelight_left", "fx/misc/car_brakelight_truck_L_pb", "brakelights");
}

init_local() {
  if(issubstr(self.vehicletype, "physics")) {
    var_0 = [];
    var_0["idle"] = % humvee_antennas_idle_movement;
    var_0["rot_l"] = % humvee_antenna_l_rotate_360;
    var_0["rot_r"] = % humvee_antenna_r_rotate_360;
    thread maps\_vehicle_code::humvee_antenna_animates(var_0);
  }
}

build_humvee_anims() {
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % bravewarr_dismount_driver_door;
  var_0[1].vehicle_getoutanim = % bravewarr_dismount_passenger_door;
  var_0[2].vehicle_getoutanim = % bravewarr_dismount_backl_door;
  var_0[3].vehicle_getoutanim = % bravewarr_dismount_backr_door;
  var_0[0].vehicle_getinanim = % bravewarr_mount_driver_door;
  var_0[1].vehicle_getinanim = % bravewarr_mount_passenger_door;
  var_0[2].vehicle_getinanim = % bravewarr_mount_backl_door;
  var_0[3].vehicle_getinanim = % bravewarr_mount_backr_door;
  var_0[0].vehicle_getoutsound = "gaz_door_open";
  var_0[1].vehicle_getoutsound = "gaz_door_open";
  var_0[2].vehicle_getoutsound = "gaz_door_open";
  var_0[3].vehicle_getoutsound = "gaz_door_open";
  var_0[0].vehicle_getinsound = "gaz_door_close";
  var_0[1].vehicle_getinsound = "gaz_door_close";
  var_0[2].vehicle_getinsound = "gaz_door_close";
  var_0[3].vehicle_getinsound = "gaz_door_close";
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
  }

  var_0[0].sittag = "tag_driver";
  var_0[0].getin = % bravewarr_mount_driver;
  var_0[0].getout = % bravewarr_dismount_driver;
  var_0[0].idle[0] = % bravewarr_idle_driver;
  var_0[0].idle[1] = % bravewarr_idle_driver;
  var_0[0].idle_alert = % clockwork_exfil_jeepride_intense_keegan;
  var_0[0].idleoccurrence[0] = 1000;
  var_0[0].idleoccurrence[1] = 100;
  var_0[0].death = % bravewarr_fallout_driver;
  var_0[1].sittag = "tag_passenger";
  var_0[1].getin = % bravewarr_mount_passenger;
  var_0[1].getout = % bravewarr_dismount_passenger;
  var_0[1].idle[0] = % bravewarr_idle_passenger;
  var_0[1].idle[1] = % bravewarr_idle_passenger;
  var_0[1].idleoccurrence[0] = 1000;
  var_0[1].idleoccurrence[1] = 100;
  var_0[1].death = % bravewarr_fallout_passenger;
  var_0[2].sittag = "tag_guy0";
  var_0[2].getin = % bravewarr_mount_backl;
  var_0[2].getout = % bravewarr_dismount_backl;
  var_0[2].idle[0] = % bravewarr_idle_backl;
  var_0[2].idle[1] = % bravewarr_idle_backl;
  var_0[2].idleoccurrence[0] = 1000;
  var_0[2].idleoccurrence[1] = 100;
  var_0[2].death = % bravewarr_fallout_backl;
  var_0[3].sittag = "tag_guy1";
  var_0[3].getin = % bravewarr_mount_backr;
  var_0[3].getout = % bravewarr_dismount_backr;
  var_0[3].idle[0] = % bravewarr_idle_backr;
  var_0[3].idle[1] = % bravewarr_idle_backr;
  var_0[3].idleoccurrence[0] = 1000;
  var_0[3].idleoccurrence[1] = 100;
  var_0[3].death = % bravewarr_fallout_backr;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["passengers"] = [];
  var_0["passenger_and_gunner"] = [];
  var_0["passenger_and_driver"] = [];
  var_0["all"] = [];
  var_1 = "passenger_and_gunner";
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 4;
  var_1 = "passenger_and_driver";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_1 = "passengers";
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}