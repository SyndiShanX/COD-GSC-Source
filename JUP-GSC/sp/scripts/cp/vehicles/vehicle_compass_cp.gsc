/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\vehicles\vehicle_compass_cp.gsc
*********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\engine\utility;
#namespace vehicle_compass_cp;

function vehicle_compass_cp_init() {
  registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", &vehicle_compass_cp_shouldbevisibletoplayer);
}

function vehicle_compass_cp_shouldbevisibletoplayer(vehicle, player) {
  if(function_a2a780464918dc3a() && getdvarint(@ "hash_b7d46b36430341a5", 0)) {
    if(isDefined(vehicle)) {
      return player function_80f8ad4df1927d77(vehicle.origin);
    }
  }

  return 1;
}