/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2430.gsc
*************************************************/

_id_1026E() {
  var_0 = getdvarint("#x34ad90f355ba0d2af", 128);
  var_1 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10275();
  var_1._id_9C7B = var_0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "canSpawnVehicle", ::_id_1026B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", ::_id_1026D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsAbandonedTimeout", ::_id_1026C);
}

_id_1026B(var_0, var_1, var_2) {
  if(getdvarint("#x3a8fb0620196c6263", 0) == 1) {
    return 0;
  }

  if(istrue(level._id_4A04)) {
    return 0;
  }

  return 1;
}

_id_1026D() {
  if(level.gametype != "cp_survival" || level.gametype != "pvpve") {
    return 0;
  }

  return 1;
}

_id_1026C() {
  if(level.gametype != "cp_survival" || level.gametype != "pvpve") {
    return 0;
  }

  return 1;
}