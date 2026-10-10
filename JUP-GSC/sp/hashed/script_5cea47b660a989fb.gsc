/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5cea47b660a989fb.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace namespace_4c0bc0cafd66edf2;

function autoexec main() {
  level.var_7bf42d565645a485 = 1;
  function_c0b3ddc9a6bdcc46("veh_jup_blima", &function_99154a866980515f);
}

function private function_99154a866980515f() {
  callbacks = [];
  callbacks["spawn"] = &function_cbf697bfc601a8bc;
  function_8497e7e46b5e397("veh_jup_blima", callbacks);
}

function private function_cbf697bfc601a8bc(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh_jup_blima", spawndata, faildata);

  if(!isDefined(vehicle)) {
    return undefined;
  }

  if(istrue(spawndata.initai)) {
    vehicle.unload_hover_offset = 537;
    vehicle.unload_land_offset = 165;
    vehicle.script_badplace = 0;
    vehicle.vehiclesetuprope = 1;
    vehicle vehicle_setspeed(60, 20, 10);
    vehicle.preventrespawn = 1;
    vehicle.var_a8f4bb03b366aa80 = 1;
    vehicle.deathfunc = &vehicle_death;
    vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_a91927df280e94e4();
  }

  return vehicle;
}