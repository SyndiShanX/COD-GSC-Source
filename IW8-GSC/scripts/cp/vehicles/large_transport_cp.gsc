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
  var_0 = scripts\engine\utility::getStructArray("largetransport_spawn", "targetname");
  thread large_transport_cp_createfromstructs(var_0, 3);
}

function large_transport_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var_5);

      if(isDefined(var_6)) {
        level.largetransports = scripts\engine\utility::array_add(level.largetransports, var_6);
      }
    }

    return;
  }
}

function large_transport_cp_create(var_0) {
  var_0.maxhealth = 2000;
  var_0.health = var_0.maxhealth;
}

function large_transport_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &large_transport_cp_ondeathrespawncallback;
  }

  return var_2;
}

function large_transport_cp_ondeathrespawncallback() {
  thread large_transport_cp_waitandspawn();
}

function large_transport_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("large_transport")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("large_transport", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}