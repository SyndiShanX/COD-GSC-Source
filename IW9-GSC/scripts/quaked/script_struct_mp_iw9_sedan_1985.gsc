/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_sedan_1985.gsc
**************************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_sedan_hatchback_1985", ::_id_2C9651ADAD47C81F);
}

_id_2C9651ADAD47C81F() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_sedan_hatchback_1985")) {
    return;
  }
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_sedan_hatchback_1985_nitrous", "spawn", ::_id_87C1D62F952BEF20);
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_sedan_hatchback_1985");
}

_id_87C1D62F952BEF20(spawndata, _id_EE8DA5624236DC89) {
  spawndata = scripts\cp_mp\vehicles\vehicle_spawn::_id_37480E9C9C701CF2("veh9_sedan_hatchback_1985", spawndata);
  spawndata.vehicletype = "veh9_sedan_hatchback_1985_physics_nitrous_mp";
  vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::vehicle_create(vehicle, "veh9_sedan_hatchback_1985", spawndata);
  vehicle.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::_id_7AAA7AE503292F43("veh9_sedan_hatchback_1985"));
  scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_registerinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle::vehicle_createlate(vehicle, spawndata);
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
  vehicle thread scripts\cp_mp\vehicles\vehicle::_id_1B69321FF9937FC5();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_sedan_hatchback_1985", "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_sedan_hatchback_1985", "create")]](vehicle);

  return vehicle;
}