/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_spawn_mp.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace vehicle_spawn_mp;

function vehicle_spawn_mp_init() {
  registersharedfunc("vehicle_spawn", "canSpawnVehicle", &vehicle_spawn_mp_canspawnvehicle);
}

function vehicle_spawn_mp_canspawnVehicle(vehicleref, owner, team) {
  if(!getmatchrulesdata("commonOption", "allowVehicles")) {
    return false;
  }

  if(getdvarint(hashcat(@ "hash_e4fa5e1677f011e4", vehicleref), 1) == 0) {
    return false;
  }

  return true;
}