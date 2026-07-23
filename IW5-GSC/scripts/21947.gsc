/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\21947.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("uaz", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_destructible("vehicle_uaz_winter_destructible", "vehicle_uaz_winter");
  maps\_vehicle::build_destructible("vehicle_uaz_open_destructible", "vehicle_uaz_open");
  maps\_vehicle::build_bulletshield(0);
  maps\_vehicle::build_deathmodel("vehicle_uaz_light", "vehicle_uaz_light_dsr");
  maps\_vehicle::build_deathmodel("vehicle_uaz_winter", "vehicle_uaz_winter_destroy");
  maps\_vehicle::build_deathmodel("vehicle_uaz_fabric", "vehicle_uaz_fabric_dsr");
  maps\_vehicle::build_deathmodel("vehicle_uaz_hardtop", "vehicle_uaz_hardtop_dsr");
  maps\_vehicle::build_deathmodel("vehicle_uaz_open", "vehicle_uaz_open_dsr");
  maps\_vehicle::build_deathmodel("vehicle_uaz_hardtop_thermal", "vehicle_uaz_hardtop_thermal");
  maps\_vehicle::build_deathmodel("vehicle_uaz_open_for_ride");
  maps\_vehicle::build_deathfx("explosions/small_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_radiusdamage((0, 0, 32), 300, 200, 100, 0);
  maps\_vehicle::build_drive(%uaz_driving_idle_forward, %uaz_driving_idle_backward, 10);
  maps\_vehicle::build_deathquake(1, 1.6, 500);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(2500, 2400, 2600);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_unload_groups(::unload_groups);
}

init_local() {
  self.clear_anims_on_death = 1;

  if(!isDefined(self.script_allow_rider_deaths)) {
    self.script_allow_rider_deaths = 0;
  }
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % uaz_driver_exit_into_stand_door;
  var_0[1].vehicle_getoutanim = % uaz_passenger_exit_into_stand_door;
  var_0[2].vehicle_getoutanim = % uaz_rear_driver_exit_into_stand_door;
  var_0[3].vehicle_getoutanim = % uaz_passenger2_exit_into_stand_door;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getinanim = % uaz_driver_enter_from_huntedrun_door;
  var_0[1].vehicle_getinanim = % uaz_passenger_enter_from_huntedrun_door;
  var_0[2].vehicle_getinanim = % uaz_rear_driver_enter_from_huntedrun_door;
  var_0[3].vehicle_getinanim = % uaz_passenger2_enter_from_huntedrun_door;
  var_0[0].vehicle_getoutsound = "uaz_door_open";
  var_0[1].vehicle_getoutsound = "uaz_door_open";
  var_0[2].vehicle_getoutsound = "uaz_door_open";
  var_0[3].vehicle_getoutsound = "uaz_door_open";
  var_0[0].vehicle_getinsound = "uaz_door_open";
  var_0[1].vehicle_getinsound = "uaz_door_open";
  var_0[2].vehicle_getinsound = "uaz_door_open";
  var_0[3].vehicle_getinsound = "uaz_door_open";
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_guy0";
  var_0[3].sittag = "tag_guy1";
  var_0[4].sittag = "tag_guy2";
  var_0[5].sittag = "tag_guy3";
  var_0[0].idle = % uaz_driver_idle_drive;
  var_0[1].idle = % uaz_passenger_idle_drive;
  var_0[2].idle = % uaz_rear_driver_idle;
  var_0[3].idle = % uaz_passenger2_idle;
  var_0[4].idle = % uaz_rear_driver_idle;
  var_0[5].idle = % uaz_passenger2_idle;
  var_0[0].getout = % uaz_driver_exit_into_stand;
  var_0[1].getout = % uaz_passenger_exit_into_stand;
  var_0[2].getout = % uaz_rear_driver_exit_into_stand;
  var_0[3].getout = % uaz_passenger2_exit_into_stand;
  var_0[0].getin = % uaz_driver_enter_from_huntedrun;
  var_0[1].getin = % uaz_passenger_enter_from_huntedrun;
  var_0[2].getin = % uaz_rear_driver_enter_from_huntedrun;
  var_0[3].getin = % uaz_passenger2_enter_from_huntedrun;
  var_0[0].death = % uaz_driver_death;
  var_0[1].death = % uaz_rear_driver_death;
  var_0[2].death = % uaz_rear_driver_death;
  var_0[3].death = % uaz_rear_driver_death;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].death_no_ragdoll = 1;
  var_0[3].death_no_ragdoll = 1;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["front_passenger"] = [];
  var_0["all"] = [];
  var_1 = "front_passenger";
  var_0[var_1][var_0[var_1].size] = 1;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0["default"] = var_0["all"];
  return var_0;
}