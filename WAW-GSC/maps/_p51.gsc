/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_p51.gsc
**************************************/

main(model, type) {
  if(!isDefined(type)) {
    type = "p51";
  }

  level.vehicleInitThread[type][model] = ::init_local;

  deathfx = LoadFx("explosions/large_vehicle_explosion");

  switch (model) {
    case "vehicle_p51_mustang":
      PrecacheModel("vehicle_p51_mustang");

      level.vehicle_deathmodel[model] = "vehicle_p51_mustang";
      break;
  }
  PrecacheVehicle(type);

  level.vehicle_death_fx[type] = [];

  level.vehicle_life[type] = 999;
  level.vehicle_life_range_low[type] = 500;
  level.vehicle_life_range_high[type] = 1500;

  level.vehicle_team[type] = "allies";

  level.vehicle_hasMainTurret[model] = false;

  level.vehicle_compassicon[type] = false;
}
init_local() {}