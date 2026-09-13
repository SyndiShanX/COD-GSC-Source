/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_spawn_cp.gsc
****************************************************/

vehicle_spawn_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "canSpawnVehicle", ::vehicle_spawn_cp_canspawnvehicle);
}

vehicle_spawn_cp_canspawnVehicle(_id_7731ADEF63E19B0C, owner, team) {
  if(getdvarint("r_reflectionprobegenerate", 0) == 1)
    return 0;

  if(getdvarint("dvar_742CAA13B3C2E685", 0) == 1)
    return 0;

  if(istrue(level.disable_global_vehicle_spawn))
    return 0;

  return 1;
}