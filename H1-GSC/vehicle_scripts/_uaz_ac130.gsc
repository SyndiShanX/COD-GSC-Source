/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_uaz_ac130.gsc
******************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("uaz_ac130", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_uaz_hardtop_thermal", "vehicle_uaz_hardtop_thermal");
  maps\_vehicle::build_radiusdamage((0, 0, 32), 300, 200, 100, 0);
  maps\_vehicle::build_deathfx("fx\explosions\small_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_drive( % uaz_driving_idle_forward, % uaz_driving_idle_backward, 10);
  maps\_vehicle::build_deathquake(1, 1.6, 500);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {
  vehicle_scripts\_uaz::init_local();
}

set_vehicle_anims(var_0) {
  return vehicle_scripts\_uaz::set_vehicle_anims(var_0);
}

setanims() {
  return vehicle_scripts\_uaz::setanims();
}