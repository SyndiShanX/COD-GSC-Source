/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_781468633d2206e0.gsc
*************************************************/

#using scripts\cp_mp\vehicles\vehicle;
#namespace namespace_a8bb5c49b9f32539;

function autoexec main() {
  level.var_7bf42d565645a485 = 1;
  function_c0b3ddc9a6bdcc46("veh_jup_ru_heli_transport", &function_1836611c4ec791a2);
}

function private function_1836611c4ec791a2() {
  callbacks = [];
  callbacks["spawn"] = &function_7c332db718c995af;
  function_8497e7e46b5e397("veh_jup_ru_heli_transport", callbacks);
}

function private function_7c332db718c995af(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh_jup_ru_heli_transport", spawndata, faildata);

  if(!isDefined(vehicle)) {
    return undefined;
  }

  if(istrue(spawndata.initai)) {
    vehicle vehicle_setspeed(60, 20, 10);
    vehicle.preventrespawn = 1;
    vehicle.var_a8f4bb03b366aa80 = 1;
    vehicle.deathfunc = &vehicle_death;
  }

  return vehicle;
}