/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_truck.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("truck", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_pickup_roobars", "vehicle_pickup_roobars_destroyed", 2);
  build_deathmodel("vehicle_pickup_4door", "vehicle_pickup_technical_destroyed", 2);
  build_deathmodel("vehicle_opfor_truck", "vehicle_pickup_technical_destroyed", 2);

  build_deathfx("fire/firelp_med_pm", "tag_body", "smallfire", undefined, undefined, true, 0, true);
  build_deathfx("explosions/small_vehicle_explosion", undefined, "car_explode", undefined, undefined, undefined, 1.9, true);
  build_deathfx("fire/firelp_small_pm_a", "tag_fx_tire_right_r", "smallfire", undefined, undefined, true, 2, true);
  build_deathfx("fire/firelp_med_pm", "tag_fx_cab", "smallfire", undefined, undefined, true, 2.01, true);
  build_deathfx("fire/firelp_small_pm_a", "tag_engine_left", "smallfire", undefined, undefined, true, 2.01, true);

  build_drive(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);

  build_treadfx();
  build_life(999, 500, 1500);
  build_team("allies");
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::Unload_Groups);

  build_light(model, "headlight_truck_left", "tag_headlight_left", "misc/car_headlight_truck_L", "headlights");
  build_light(model, "headlight_truck_right", "tag_headlight_right", "misc/car_headlight_truck_R", "headlights");
  build_light(model, "parkinglight_truck_left_f", "tag_parkinglight_left_f", "misc/car_parkinglight_truck_LF", "headlights");
  build_light(model, "parkinglight_truck_right_f", "tag_parkinglight_right_f", "misc/car_parkinglight_truck_RF", "headlights");
  build_light(model, "taillight_truck_right", "tag_taillight_right", "misc/car_taillight_truck_R", "headlights");
  build_light(model, "taillight_truck_left", "tag_taillight_left", "misc/car_taillight_truck_L", "headlights");

  build_light(model, "brakelight_truck_right", "tag_taillight_right", "misc/car_brakelight_truck_R", "brakelights");
  build_light(model, "brakelight_truck_left", "tag_taillight_left", "misc/car_brakelight_truck_L", "brakelights");
  build_compassicon("automobile", false);

  build_radiusdamage((0, 0, 32), 200, 150, 0, false, 2);
}

init_local() {}

set_vehicle_anims(positions) {
  positions[0].vehicle_getoutanim = % door_pickup_driver_climb_out;
  positions[1].vehicle_getoutanim = % door_pickup_passenger_climb_out;
  positions[2].vehicle_getoutanim = % door_pickup_passenger_RR_climb_out;
  positions[3].vehicle_getoutanim = % door_pickup_passenger_RL_climb_out;

  positions[0].vehicle_getoutanim_clear = false;
  positions[1].vehicle_getoutanim_clear = false;
  positions[2].vehicle_getoutanim_clear = false;
  positions[3].vehicle_getoutanim_clear = false;

  positions[0].vehicle_getinanim = % door_pickup_driver_climb_in;
  positions[1].vehicle_getinanim = % door_pickup_passenger_climb_in;

  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 6; i++)
    positions[i] = spawnStruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy1";
  positions[3].sittag = "tag_guy0";
  positions[4].sittag = "tag_guy3";
  positions[5].sittag = "tag_guy4";

  positions[0].idle = % technical_driver_idle;
  positions[1].idle = % technical_passenger_idle;
  positions[2].idle = % pickup_passenger_RR_idle;
  positions[3].idle = % pickup_passenger_RR_idle;
  positions[4].idle = % pickup_passenger_RR_idle;
  positions[5].idle = % pickup_passenger_RR_idle;

  positions[0].getout = % pickup_driver_climb_out;
  positions[1].getout = % pickup_passenger_climb_out;
  positions[2].getout = % pickup_passenger_RR_climb_out;
  positions[3].getout = % pickup_passenger_RL_climb_out;
  positions[4].getout = % pickup_passenger_RR_climb_out;
  positions[5].getout = % pickup_passenger_RL_climb_out;

  positions[0].getin = % pickup_driver_climb_in;
  positions[1].getin = % pickup_passenger_climb_in;

  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["passengers"] = [];
  unload_groups["all"] = [];

  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;

  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;

  unload_groups["default"] = unload_groups["all"];

  return unload_groups;
}