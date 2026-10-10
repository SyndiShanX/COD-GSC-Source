/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3a535b44f9ecc6df.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#namespace namespace_60a636790355dd76;

function main() {
  function_c0b3ddc9a6bdcc46("veh9_sedan_hatchback_1985", &function_2c9651adad47c81f);
}

function private function_2c9651adad47c81f() {
  if(!function_9697379150687859("veh9_sedan_hatchback_1985")) {
    return;
  }

  registersharedfunc("veh9_sedan_hatchback_1985_nitrous", "spawn", &function_87c1d62f952bef20);
  function_8497e7e46b5e397("veh9_sedan_hatchback_1985");
}

function private function_87c1d62f952bef20(spawndata, faildata) {
  spawndata = function_37480e9c9c701cf2("veh9_sedan_hatchback_1985", spawndata);
  spawndata.vehicletype = "veh9_sedan_hatchback_1985_physics_nitrous_mp";
  vehicle = _spawnVehicle(spawndata, faildata);

  if(!isDefined(vehicle)) {
    return undefined;
  }

  vehicle_create(vehicle, "veh9_sedan_hatchback_1985", spawndata);
  vehicle.objweapon = makeweapon(function_7aaa7ae503292f43("veh9_sedan_hatchback_1985"));
  vehicle_compass_registerinstance(vehicle);
  vehicle_createlate(vehicle, spawndata);
  vehicle thread vehicle_watchflipped();
  vehicle thread function_1b69321ff9937fc5();

  if(issharedfuncdefined("veh9_sedan_hatchback_1985", "create")) {
    [[getsharedfunc("veh9_sedan_hatchback_1985", "create")]](vehicle);
  }

  return vehicle;
}