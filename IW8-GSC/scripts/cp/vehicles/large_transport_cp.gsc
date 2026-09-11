/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\large_transport_cp.gsc
******************************************************/

function large_transport_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "initLate", &large_transport_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "create", &large_transport_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "spawnCallback", &large_transport_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("large_transport", &scripts\cp_mp\vehicles\large_transport::large_transport_explode);
}

function large_transport_cp_initlate() {
  if(true) {
    return;
  }

  level.largetransports = [];
  var0 = scripts\engine\utility::getStructArray("largetransport_spawn", "targetname");
  thread large_transport_cp_createfromstructs(var0, 3);
}

function large_transport_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var5);

      if(isDefined(var6)) {
        level.largetransports = scripts\engine\utility::array_add(level.largetransports, var6);
      }
    }

    return;
  }
}

function large_transport_cp_create(var0) {
  var0.maxhealth = 2000;
  var0.health = var0.maxhealth;
}

function large_transport_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &large_transport_cp_ondeathrespawncallback;
  }

  return var2;
}

function large_transport_cp_ondeathrespawncallback() {
  thread large_transport_cp_waitandspawn();
}

function large_transport_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("large_transport")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("large_transport", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}