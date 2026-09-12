/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_spawn_cp.gsc
****************************************************/

function vehicle_spawn_cp_init() {
  var_0 = getdvarint("scr_max_vehicles", 128);
  var_1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
  var_1.maxinstancecount = var_0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "canSpawnVehicle", &vehicle_spawn_cp_canspawnvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", &vehicle_spawn_cp_gamemodesupportsrespawn);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsAbandonedTimeout", &ref_14213);
}

function vehicle_spawn_cp_canspawnVehicle(var_0, var_1, var_2) {
  if(getdvarint("r_reflectionProbeGenerate", 0) == 1) {
    return false;
  }

  if(istrue(level.disable_global_vehicle_spawn)) {
    return false;
  }

  return true;
}

function vehicle_spawn_cp_gamemodesupportsrespawn() {
  if(level.gametype != "cp_survival" || level.gametype != "pvpve") {
    return false;
  }

  return true;
}

function ref_14213() {
  if(level.gametype != "cp_survival" || level.gametype != "pvpve") {
    return false;
  }

  return true;
}