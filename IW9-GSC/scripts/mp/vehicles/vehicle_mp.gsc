/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_mp.gsc
***********************************************/

vehicle_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "create", ::vehicle_mp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createLate", ::vehicle_mp_createlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrame", ::vehicle_mp_deletenextframe);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrameLate", ::vehicle_mp_deletenextframelate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createHint", scripts\mp\gameobjects::createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_interact", "init", scripts\mp\vehicles\vehicle_interact_mp::vehicle_interact_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "init", scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_mines", "init", scripts\mp\vehicles\vehicle_mines_mp::vehicle_mines_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "init", scripts\mp\vehicles\vehicle_spawn_mp::vehicle_spawn_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "init", scripts\mp\vehicles\vehicle_compass_mp::vehicle_compass_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "init", scripts\mp\vehicles\vehicle_damage_mp::vehicle_damage_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_upgrade", "init", _id_4384ABBF498DF6A7::_runpurchasemenu);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophy", "init", scripts\mp\equipment\trophy_system::trophy_watchprotection);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophyDestroyTarget", "init", scripts\mp\equipment\trophy_system::_id_477783276EA16601);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophyCreateExplosion", "init", scripts\mp\equipment\trophy_system::trophy_createexplosion);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_trophyExplode", "init", scripts\mp\equipment\trophy_system::trophy_explode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "init", scripts\mp\vehicles\light_tank_mp::light_tank_mp_init);
  scripts\mp\vehicles\damage::init();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_init();
}

vehicle_mp_create(vehicle, spawndata) {
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  scripts\mp\outofbounds::registerentforoob(vehicle, "vehicle");
  vehicle enableplayermarks("killstreak");
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_updatemarkfilter(vehicle);
}

vehicle_mp_createlate(vehicle, spawndata) {}

vehicle_mp_deletenextframe(vehicle) {
  scripts\mp\outofbounds::clearoob(vehicle, 1);
}

vehicle_mp_deletenextframelate(vehicle) {}

_id_DD9423AA2B333DF5(vehicle) {
  if(!isDefined(vehicle) || !isDefined(vehicle.vehiclename))
    return 0;

  switch (vehicle.vehiclename) {
    case "veh9_suv_1996":
    case "veh9_sedan_hatchback_1985":
    case "veh9_pickup_2014":
    case "veh9_hummer":
      return 1;
    default:
      return 0;
  }
}