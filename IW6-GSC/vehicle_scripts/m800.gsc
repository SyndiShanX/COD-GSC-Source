/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\m800.gsc
*****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("m800", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_m800_apc", "vehicle_m800_apc_destroyed");
  maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_m800_dest", undefined, "explo_metal_rand");
  maps\_vehicle::build_drive( % m880_launcher_idle_driving_idle_forward, % m880_launcher_idle_driving_idle_forward, 10);
  maps\_vehicle::build_turret("m800_turret", "tag_turret", "vehicle_m800_apc_turret", undefined, "auto_nonai", undefined, 0);
  maps\_vehicle::build_radiusdamage((0, 0, 53), 512, 300, 20, 0);
  maps\_vehicle::build_treadfx(var_2);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
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
  return var_0;
}

setanims() {
  var_0 = [];
  return var_0;
}