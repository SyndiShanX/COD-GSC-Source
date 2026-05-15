/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_uaz.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");

main(model, type, no_death) {
  build_template("uaz", model, type);
  build_localinit(::init_local);

  build_destructible("vehicle_uaz_winter_destructible", "vehicle_uaz_winter");
  build_destructible("vehicle_uaz_open_destructible", "vehicle_uaz_open");

  build_bulletshield(false);

  if(!isDefined(no_death)) {
    build_deathmodel("vehicle_uaz_light", "vehicle_uaz_light_dsr");
    build_deathmodel("vehicle_uaz_winter", "vehicle_uaz_winter_destroy");
    build_deathmodel("vehicle_uaz_fabric", "vehicle_uaz_fabric_dsr");
    build_deathmodel("vehicle_uaz_hardtop", "vehicle_uaz_hardtop_dsr");
    build_deathmodel("vehicle_uaz_open", "vehicle_uaz_open_dsr");
    build_deathmodel("vehicle_uaz_hardtop_thermal", "vehicle_uaz_hardtop_thermal");
    build_deathmodel("vehicle_uaz_open_for_ride");
    build_deathfx("explosions/small_vehicle_explosion", undefined, "explo_metal_rand");
  }

  build_radiusdamage((0, 0, 32), 300, 200, 100, false);
  build_drive(%uaz_driving_idle_forward, %uaz_driving_idle_backward, 10);
  build_deathquake(1, 1.6, 500);

  build_treadfx();
  build_life(2500, 2400, 2600);

  build_team("axis");
  build_aianims(::setanims, ::set_vehicle_anims);
  build_compassicon("uaz", false);
}

init_local() {
  self.clear_anims_on_death = true;
  if(!isDefined(self.script_allow_rider_deaths)) {
    self.script_allow_rider_deaths = false;
  }
}

set_vehicle_anims(positions) {
  positions[0].vehicle_getoutanim = % uaz_driver_exit_into_stand_door;
  positions[1].vehicle_getoutanim = % uaz_passenger_exit_into_stand_door;
  positions[2].vehicle_getoutanim = % uaz_rear_driver_exit_into_stand_door;
  positions[3].vehicle_getoutanim = % uaz_passenger2_exit_into_stand_door;

  positions[0].vehicle_getoutanim_clear = false;
  positions[1].vehicle_getoutanim_clear = false;
  positions[2].vehicle_getoutanim_clear = false;
  positions[3].vehicle_getoutanim_clear = false;

  positions[0].vehicle_getinanim = % uaz_driver_enter_from_huntedrun_door;
  positions[1].vehicle_getinanim = % uaz_passenger_enter_from_huntedrun_door;
  positions[2].vehicle_getinanim = % uaz_rear_driver_enter_from_huntedrun_door;
  positions[3].vehicle_getinanim = % uaz_passenger2_enter_from_huntedrun_door;

  positions[0].vehicle_getoutsound = "uaz_door_open";
  positions[1].vehicle_getoutsound = "uaz_door_open";
  positions[2].vehicle_getoutsound = "uaz_door_open";
  positions[3].vehicle_getoutsound = "uaz_door_open";

  positions[0].vehicle_getinsound = "uaz_door_open";
  positions[1].vehicle_getinsound = "uaz_door_open";
  positions[2].vehicle_getinsound = "uaz_door_open";
  positions[3].vehicle_getinsound = "uaz_door_open";

  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 6; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy0";
  positions[3].sittag = "tag_guy1";
  positions[4].sittag = "tag_guy2";
  positions[5].sittag = "tag_guy3";

  positions[0].idle = % uaz_driver_idle_drive;
  positions[1].idle = % uaz_passenger_idle_drive;
  positions[2].idle = % uaz_rear_driver_idle;
  positions[3].idle = % uaz_passenger2_idle;
  positions[4].idle = % uaz_rear_driver_idle;
  positions[5].idle = % uaz_passenger2_idle;

  positions[0].getout = % uaz_driver_exit_into_stand;
  positions[1].getout = % uaz_passenger_exit_into_stand;
  positions[2].getout = % uaz_rear_driver_exit_into_stand;
  positions[3].getout = % uaz_passenger2_exit_into_stand;

  positions[0].getin = % uaz_driver_enter_from_huntedrun;
  positions[1].getin = % uaz_passenger_enter_from_huntedrun;
  positions[2].getin = % uaz_rear_driver_enter_from_huntedrun;
  positions[3].getin = % uaz_passenger2_enter_from_huntedrun;

  positions[0].death = % UAZ_driver_death;
  positions[1].death = % UAZ_rear_driver_death;
  positions[2].death = % UAZ_rear_driver_death;
  positions[3].death = % UAZ_rear_driver_death;

  positions[0].death_no_ragdoll = true;
  positions[1].death_no_ragdoll = true;
  positions[2].death_no_ragdoll = true;
  positions[3].death_no_ragdoll = true;

  return positions;
}