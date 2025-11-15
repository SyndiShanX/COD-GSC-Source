/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_player_aircraft.gsc
*****************************************************/

#include maps\_vehicle;
#include maps\_vehicle_aianim;
#using_animtree("vehicles");

main(model, type) {
  if(!isDefined(type))
    type = "player_aircraft";
  build_template("technical", model, type);
  build_localinit(::init_local);
  switch (model) {
    case "vehicle_usa_aircraft_f4ucorsair":
      build_deathmodel("vehicle_usa_aircraft_f4ucorsair", "vehicle_usa_aircraft_f4ucorsair");
      break;
    case "vehicle_p51_mustang":
      build_deathmodel("vehicle_p51_mustang", "vehicle_p51_mustang");
      break;
  }
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(999, 500, 1500);
  build_team("axis");
  level.vehicle_death_thread[type] = ::kill_driver;
}

init_local() {}
kill_driver() {
  println("******************KILLING DRIVER");
  driver = self getvehicleowner();
  if(isDefined(driver)) {
    driver DoDamage(driver.health + 1, (0, 0, 0));
  }
}