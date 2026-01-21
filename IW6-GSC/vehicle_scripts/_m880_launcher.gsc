/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_m880_launcher.gsc
**********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("m880_launcher", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel(var_0, var_0);
  maps\_vehicle::build_drive(%m880_launcher_idle_driving_idle_forward, %m880_launcher_idle_driving_idle_forward, 10);
  maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
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