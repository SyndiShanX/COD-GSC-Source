/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_btr80.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("btr80", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_btr80", "vehicle_btr80_d", 0.1);
  maps\_vehicle::build_deathmodel("vehicle_btr80_snow", "vehicle_btr80_snow_d");
  maps\_vehicle::build_deathmodel("vehicle_btr80_low", "vehicle_btr80_d");
  var_3 = [];
  var_3["vehicle_btr80"] = "fx/explosions/vehicle_explosion_btr80";
  var_3["vehicle_btr80_snow"] = "fx/explosions/vehicle_explosion_btr80_snow";
  var_3["vehicle_btr80_low"] = "fx/explosions/vehicle_explosion_btr80";
  maps\_vehicle::build_deathfx("fx/fire/firelp_med_pm", "TAG_CARGOFIRE", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx(var_3[var_0], "tag_deathfx", "exp_armor_vehicle");
  maps\_vehicle::build_light(var_2, "headlight_L", "TAG_FRONT_LIGHT_LEFT", "fx/misc/car_headlight_btr80", "running", 0.0);
  maps\_vehicle::build_light(var_2, "taillight_L", "TAG_REAR_LIGHT_LEFT", "fx/misc/car_taillight_btr80", "running", 0.1);
  maps\_vehicle::build_light(var_2, "taillight_R", "TAG_REAR_LIGHT_RIGHT", "fx/misc/car_taillight_btr80", "running", 0.1);
  maps\_vehicle::build_light(var_2, "brakeight_R", "TAG_REAR_LIGHT_RIGHT", "fx/misc/car_brakelight_btr80", "brake", 0.0);
  maps\_vehicle::build_light(var_2, "brakelight_L", "TAG_REAR_LIGHT_LEFT", "fx/misc/car_brakelight_btr80", "brake", 0.0);
  maps\_vehicle::build_light(var_2, "spotlight", "TAG_FRONT_LIGHT_RIGHT", "fx/misc/spotlight_btr80", "spotlight", 0.2);
  maps\_vehicle::build_light(var_2, "spotlight_turret", "TAG_TURRET_LIGHT", "fx/misc/spotlight_btr80", "spotlight_turret", 0.0);
  maps\_vehicle::build_drive( % btr80_movement, % btr80_movement_backwards, 10);

  if(issubstr(var_0, "_snow"))
    maps\_vehicle::build_turret("btr80_turret2", "tag_turret2", "vehicle_btr80_machine_gun_snow");
  else if(issubstr(var_2, "_ac130"))
    maps\_vehicle::build_turret("btr80_ac130_turret", "tag_turret2", "vehicle_btr80_machine_gun");
  else
    maps\_vehicle::build_turret("btr80_turret2", "tag_turret2", "vehicle_btr80_machine_gun");

  maps\_vehicle::build_radiusdamage((0, 0, 53), 512, 300, 20, 0);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_frontarmor(0.33);
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_grenadeshield(1);
}

init_local() {
  maps\_utility::ent_flag_init("no_riders_until_unload");
  maps\_vehicle::vehicle_lights_on("running");
}

test_brake_lights() {
  self endon("death");

  for(;;) {
    wait 5;
    maps\_vehicle::vehicle_lights_on("brake");
    wait 3;
    maps\_vehicle::vehicle_lights_on("brake");
  }
}

unload_groups() {
  var_0 = [];
  var_0["driver_and_rider"] = [];
  var_0["two_riders"] = [];
  var_0["all"] = [];
  var_1 = "driver_and_rider";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_1 = "two_riders";
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % btr80_doorsl_open;
  var_0[1].vehicle_getoutanim = % btr80_doorsr_open;
  var_0[2].vehicle_getoutanim = % btr80_doorsl_open;
  var_0[3].vehicle_getoutanim = % btr80_doorsr_open;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "tag_detach";
  var_0[1].sittag = "tag_detach";
  var_0[2].sittag = "tag_detach";
  var_0[3].sittag = "tag_detach";
  var_0[0].idle = % btr80_crew_idle;
  var_0[1].idle = % btr80_crew_idle;
  var_0[2].idle = % btr80_crew_idle;
  var_0[3].idle = % btr80_crew_idle;
  var_0[0].getout = % btr80_exit_1;
  var_0[1].getout = % btr80_exit_2;
  var_0[2].getout = % btr80_exit_3;
  var_0[3].getout = % btr80_exit_4;
  var_0[0].getin = % humvee_driver_climb_in;
  var_0[1].getin = % humvee_passenger_in_l;
  var_0[2].getin = % humvee_passenger_in_r;
  var_0[3].getin = % humvee_passenger_in_r;
  return var_0;
}