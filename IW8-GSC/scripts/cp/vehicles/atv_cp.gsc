/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\atv_cp.gsc
***********************************************/

function atv_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "initLate", &atv_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "create", &atv_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "spawnCallback", &atv_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("atv", &scripts\cp_mp\vehicles\atv::atv_explode);
}

function atv_cp_initlate() {
  if(true) {
    return;
  }

  level.atvs = [];
  var0 = scripts\engine\utility::getStructArray("atv_spawn", "targetname");
  thread atv_cp_createfromstructs(var0, 3);
}

function atv_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\atv::atv_create(var5);

      if(isDefined(var6)) {
        level.atvs = scripts\engine\utility::array_add(level.atvs, var6);
      }
    }

    return;
  }
}

function atv_cp_create(var0) {
  var0.maxhealth = 500;
  var0.health = var0.maxhealth;
}

function atv_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\atv::atv_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &atv_cp_ondeathrespawncallback;
  }

  return var2;
}

function atv_cp_ondeathrespawncallback() {
  thread atv_cp_waitandspawn();
}

function atv_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("atv")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}