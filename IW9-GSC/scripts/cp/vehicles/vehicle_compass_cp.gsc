/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_compass_cp.gsc
******************************************************/

vehicle_compass_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::vehicle_compass_cp_shouldbevisibletoplayer);
}

vehicle_compass_cp_shouldbevisibletoplayer(vehicle, player) {
  return 1;
}