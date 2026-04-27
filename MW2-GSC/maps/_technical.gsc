/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_technical.gsc
********************************************************/

#include maps\_vehicle;
#include maps\_vehicle_aianim;
#using_animtree("vehicles");
main(model, type) {
  build_template("technical", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_pickup_technical", "vehicle_pickup_technical_destroyed", 3);

  turret = "50cal_turret_technical";

  build_turret(turret, "tag_50cal", "weapon_m2_50cal_center", undefined, "auto_ai", 0.5, 20, -14);

  build_drive(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);

  build_deathfx("fire/firelp_med_pm", "tag_fx_tank", "smallfire", undefined, undefined, true, 0);
  build_deathfx("explosions/ammo_cookoff", "tag_fx_bed", undefined, undefined, undefined, undefined, 0.5);

  build_deathfx("explosions/Vehicle_Explosion_Pickuptruck", "tag_deathfx", "car_explode", undefined, undefined, undefined, 2.9);
  build_deathfx("fire/firelp_small_pm_a", "tag_fx_tire_right_r", "smallfire", undefined, undefined, true, 3);
  build_deathfx("fire/firelp_med_pm", "tag_fx_cab", "fire_metal_medium", undefined, undefined, true, 3.01);
  build_deathfx("fire/firelp_small_pm_a", "tag_engine_left", "smallfire", undefined, undefined, true, 3.01);

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

  build_death_badplace(.5, 3, 512, 700, "axis", "allies");
  build_death_jolt(2.9);
}

set_vehicle_anims(positions) {
  return positions;
}

init_local() {
  if(!isDefined(self.script_allow_rider_deaths))
    self.script_allow_rider_deaths = true;
  if(!isDefined(self.script_allow_driver_death))
    self.script_allow_driver_death = true;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 3; i++)
    positions[i] = spawnStruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_gunner";
  positions[2].sittag = "tag_passenger";

  positions[0].idle[0] = % technical_driver_idle;
  positions[0].idle[1] = % technical_driver_duck;
  positions[0].idleoccurrence[0] = 1000;
  positions[0].idleoccurrence[1] = 100;

  positions[0].death = % technical_driver_fallout;
  positions[2].death = % technical_passenger_fallout;

  positions[0].unload_ondeath = .9;
  positions[1].unload_ondeath = .9;
  positions[2].unload_ondeath = .9;

  positions[2].idle[0] = % technical_passenger_idle;
  positions[2].idle[1] = % technical_passenger_duck;
  positions[2].idleoccurrence[0] = 1000;
  positions[2].idleoccurrence[1] = 100;

  positions[0].getout = % technical_driver_climb_out;

  positions[2].getout = % technical_passenger_climb_out;

  positions[1].mgturret = 0;

  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["passengers"] = [];
  unload_groups["passenger_and_gunner"] = [];
  unload_groups["all"] = [];

  group = "passenger_and_gunner";
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;

  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;

  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups["default"] = unload_groups["all"];

  return unload_groups;
}