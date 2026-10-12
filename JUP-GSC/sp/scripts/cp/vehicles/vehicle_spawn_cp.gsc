/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_spawn_cp.gsc
****************************************************/



#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace vehicle_spawn_cp;

function vehicle_spawn_cp_init() {
  registersharedfunc("vehicle_spawn", "canSpawnVehicle", &vehicle_spawn_cp_canspawnvehicle);
}

function vehicle_spawn_cp_canspawnVehicle(vehicleref, owner, team) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 1) {
    return false;
  }

  if(getdvarint(@ "hash_742caa13b3c2e685", 0) == 1) {
    return false;
  }

  if(istrue(level.disable_global_vehicle_spawn)) {
    return false;
  }

  return true;
}