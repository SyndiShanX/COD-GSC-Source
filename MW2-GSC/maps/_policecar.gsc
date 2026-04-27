/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_policecar.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("policecar", model, type);
  build_localinit(::init_local);

  build_destructible("vehicle_policecar_lapd_destructible", "vehicle_policecar");
  build_destructible("vehicle_policecar_russia_destructible", "vehicle_policecar_russia");

  build_deathmodel("vehicle_policecar_lapd_destructible", "vehicle_policecar_lapd_destroy");
  build_deathmodel("vehicle_policecar_russia_destructible", "vehicle_policecar_russia_destroy");

  build_drive(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);

  build_treadfx();
  build_life(999, 500, 1500);
  build_team("allies");
  build_aianims(::setanims, ::set_vehicle_anims);
  build_compassicon("automobile", false);
}

init_local() {}
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

  positions[0].vehicle_getinsound = "truck_door_open";
  positions[1].vehicle_getinsound = "truck_door_open";
  positions[2].vehicle_getinsound = "truck_door_open";
  positions[3].vehicle_getinsound = "truck_door_open";

  return positions;
}

#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 6; i++)
    positions[i] = spawnStruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy0";
  positions[3].sittag = "tag_guy1";

  positions[0].idle = % uaz_driver_idle_drive;
  positions[1].idle = % uaz_passenger_idle_drive;
  positions[2].idle = % uaz_rear_driver_idle;
  positions[3].idle = % uaz_passenger2_idle;

  positions[0].getout = % uaz_driver_exit_into_stand;
  positions[1].getout = % uaz_passenger_exit_into_stand;
  positions[2].getout = % uaz_rear_driver_exit_into_stand;
  positions[3].getout = % uaz_passenger2_exit_into_stand;

  positions[0].getin = % uaz_driver_enter_from_huntedrun;
  positions[1].getin = % uaz_passenger_enter_from_huntedrun;
  positions[2].getin = % uaz_rear_driver_enter_from_huntedrun;
  positions[3].getin = % uaz_passenger2_enter_from_huntedrun;

  return positions;
}