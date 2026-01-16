/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_uaz.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("uaz", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_destructible("vehicle_uaz_hardtop_destructible", "vehicle_uaz_hardtop");
  maps\_vehicle::build_destructible("vehicle_uaz_light_destructible", "vehicle_uaz_light");
  maps\_vehicle::build_destructible("vehicle_uaz_open_destructible", "vehicle_uaz_open");
  maps\_vehicle::build_destructible("vehicle_uaz_open_for_ride", "vehicle_uaz_open");
  maps\_vehicle::build_destructible("vehicle_uaz_fabric_destructible", "vehicle_uaz_fabric");
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_deathmodel("vehicle_uaz_fabric", "vehicle_uaz_fabric_dsr");
  maps\_vehicle::build_deathmodel("vehicle_uaz_hardtop", "vehicle_uaz_hardtop_dsr");
  maps\_vehicle::build_deathmodel("vehicle_uaz_open", "vehicle_uaz_open_dsr");
  maps\_vehicle::build_deathmodel("vehicle_uaz_hardtop_thermal", "vehicle_uaz_hardtop_thermal");
  maps\_vehicle::build_deathmodel("vehicle_uaz_open_for_ride");
  maps\_vehicle::build_deathfx("fx\explosions\small_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_radiusdamage((0, 0, 32), 300, 200, 100, 0);
  maps\_vehicle::build_drive( % uaz_driving_idle_forward, % uaz_driving_idle_backward, 10);
  maps\_vehicle::build_deathquake(1, 1.6, 500);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {
  self.clear_anims_on_death = 1;
}

set_vehicle_anims(var_0) {
  if(getdvarint("use_old_uaz_anims") == 1) {
    var_0[0].vehicle_getoutanim = % uaz_driver_exit_into_run_door;
    var_0[1].vehicle_getoutanim = % uaz_passenger_exit_into_run_door;
  } else {
    var_0[0].vehicle_getoutanim = % h1_uaz_driver_exit_into_idle_door;
    var_0[1].vehicle_getoutanim = % h1_uaz_passenger_exit_into_idle_door;
  }

  var_0[0].vehicle_getinanim = % uaz_driver_enter_from_huntedrun_door;
  var_0[1].vehicle_getinanim = % uaz_passenger_enter_from_huntedrun_door;
  var_0[0].vehicle_getoutsoundtag = "front_door_left_jnt";
  var_0[1].vehicle_getoutsoundtag = "front_door_right_jnt";
  var_0[2].vehicle_getoutsoundtag = "rear_door_left_jnt";
  var_0[3].vehicle_getoutsoundtag = "rear_door_right_jnt";
  var_0[0].vehicle_getinsound = "truck_door_open";
  var_0[1].vehicle_getinsound = "truck_door_open";
  var_0[2].vehicle_getinsound = "truck_door_open";
  var_0[3].vehicle_getinsound = "truck_door_open";
  var_0[0].vehicle_getinsoundtag = "front_door_left_jnt";
  var_0[1].vehicle_getinsoundtag = "front_door_right_jnt";
  var_0[2].vehicle_getinsoundtag = "rear_door_left_jnt";
  var_0[3].vehicle_getinsoundtag = "rear_door_right_jnt";
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 6; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_guy0";
  var_0[3].sittag = "tag_guy1";
  var_0[4].sittag = "tag_guy2";
  var_0[5].sittag = "tag_guy3";
  var_0[0].idle = % uaz_driver_idle_drive;
  var_0[1].idle = % uaz_passenger_idle_drive;
  var_0[2].idle = % uaz_passenger_idle_drive;
  var_0[3].idle = % uaz_passenger_idle_drive;
  var_0[4].idle = % uaz_passenger_idle_drive;
  var_0[5].idle = % uaz_passenger_idle_drive;

  if(getdvarint("use_old_uaz_anims") == 1) {
    var_0[0].getout = % uaz_driver_exit_into_run;
    var_0[1].getout = % uaz_passenger_exit_into_run;
    var_0[2].getout = % uaz_driver_exit_into_run;
    var_0[3].getout = % uaz_passenger_exit_into_run;
  } else {
    var_0[0].getout = % h1_uaz_driver_exit_into_idle;
    var_0[0].getout_ik = 1;
    var_0[1].getout = % h1_uaz_passenger_exit_into_idle;
    var_0[1].getout_ik = 1;
    var_0[2].getout = % h1_uaz_driver_exit_into_idle;
    var_0[2].getout_ik = 1;
    var_0[3].getout = % h1_uaz_passenger_exit_into_idle;
    var_0[3].getout_ik = 1;
  }

  var_0[0].getin = % uaz_driver_enter_from_huntedrun;
  var_0[1].getin = % uaz_passenger_enter_from_huntedrun;
  return var_0;
}