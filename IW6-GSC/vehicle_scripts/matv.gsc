/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\matv.gsc
*****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("matv", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  var_3 = [];

  if(var_2 == "script_vehicle_matv_noturret") {
    maps\_vehicle::build_deathmodel("vehicle_matv_no_top", "vehicle_matv_no_top");
    var_3["vehicle_matv_no_top"] = "fx/explosions/vehicle_explosion_hummer";
  } else {
    maps\_vehicle::build_deathmodel("vehicle_matv", "vehicle_matv");
    var_3["vehicle_matv"] = "fx/explosions/vehicle_explosion_hummer";
  }

  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_deathfx("fx/fire/firelp_med_pm", "TAG_PASSENGER", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx(var_3[var_0], "tag_death_fx", "car_explode");
  maps\_vehicle::build_drive( % humvee_50cal_driving_idle_forward, % humvee_50cal_driving_idle_backward, 10);
  maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/tread_dust_default");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  var_4 = ::setanims;
  maps\_vehicle::build_aianims(var_4, ::set_vehicle_anims);
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

unload_groups() {
  var_0 = [];
  var_1 = "passengers";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "rear_driver_side";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % matv_driver_out_door;
  var_0[1].vehicle_getoutanim = % matv_passenger_out_door;
  var_0[2].vehicle_getoutanim = % humvee_dismount_backl_door;
  var_0[3].vehicle_getoutanim = % humvee_dismount_backr_door;
  var_0[0].vehicle_getinanim = % matv_driver_in_m_door;
  var_0[1].vehicle_getinanim = % matv_passenger_in_m_door;
  var_0[2].vehicle_getinanim = % humvee_mount_backl_door;
  var_0[3].vehicle_getinanim = % humvee_mount_backr_door;
  var_0[0].vehicle_getoutsound = "hummer_door_open";
  var_0[1].vehicle_getoutsound = "hummer_door_open";
  var_0[2].vehicle_getoutsound = "hummer_door_open";
  var_0[3].vehicle_getoutsound = "hummer_door_open";
  var_0[0].vehicle_getinsound = "hummer_door_close";
  var_0[1].vehicle_getinsound = "hummer_door_close";
  var_0[2].vehicle_getinsound = "hummer_door_close";
  var_0[3].vehicle_getinsound = "hummer_door_close";
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_guy0";
  var_0[3].sittag = "tag_guy1";
  var_0[0].bhasgunwhileriding = 0;
  var_0[0].idle[0] = % matv_driver_idle;
  var_0[0].idle[1] = % matv_driver_twitch_steerl;
  var_0[0].idle[2] = % matv_driver_twitch_steerr;
  var_0[0].idleoccurrence[0] = 500;
  var_0[0].idleoccurrence[1] = 100;
  var_0[0].idleoccurrence[2] = 100;
  var_0[1].idle[0] = % matv_passenger_idle;
  var_0[1].idle[1] = % matv_passenger_twitch_a;
  var_0[1].idle[2] = % matv_passenger_twitch_b;
  var_0[1].idleoccurrence[0] = 500;
  var_0[1].idleoccurrence[1] = 100;
  var_0[1].idleoccurrence[2] = 100;
  var_0[2].idle = % humvee_idle_backl;
  var_0[3].idle = % humvee_idle_backr;
  var_0[0].getout = % matv_driver_out;
  var_0[1].getout = % matv_passenger_out;
  var_0[2].getout = % humvee_passenger_out_l;
  var_0[3].getout = % humvee_passenger_out_r;
  var_0[0].getin = % matv_driver_in_m;
  var_0[1].getin = % matv_passenger_in_m;
  var_0[2].getin = % humvee_mount_backl;
  var_0[3].getin = % humvee_mount_backr;
  return var_0;
}