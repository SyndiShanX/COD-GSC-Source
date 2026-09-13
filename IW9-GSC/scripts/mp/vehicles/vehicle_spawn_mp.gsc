/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_spawn_mp.gsc
****************************************************/

vehicle_spawn_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "canSpawnVehicle", ::vehicle_spawn_mp_canspawnvehicle);
}

vehicle_spawn_mp_canspawnVehicle(_id_7731ADEF63E19B0C, owner, team) {
  if(getdvarint("dvar_E4FA721677F03DE0", 1) == 0)
    return 0;

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", _id_7731ADEF63E19B0C), 1) == 0)
    return 0;

  return 1;
}