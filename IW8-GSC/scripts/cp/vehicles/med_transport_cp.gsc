/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\med_transport_cp.gsc
****************************************************/

function med_transport_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "initLate", &med_transport_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "create", &med_transport_cp_create);
  scripts\engine\utility::create_func_ref("medium_transport", &spawn_and_enter_med_transport);
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "spawnCallback", &med_transport_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("medium_transport", &scripts\cp_mp\vehicles\med_transport::med_transport_explode);
}

function med_transport_cp_initlate() {
  if(true) {
    return;
  }

  level.medtransports = [];
  var0 = scripts\engine\utility::getStructArray("mediumtransport_spawn", "targetname");
  thread med_transport_cp_createfromstructs(var0, 3);
}

function med_transport_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var5);

      if(isDefined(var6)) {
        level.medtransports = scripts\engine\utility::array_add(level.medtransports, var6);
      }
    }

    return;
  }
}

function med_transport_cp_create(var0) {
  var0.maxhealth = 2000;
  var0.health = var0.maxhealth;
}

function spawn_and_enter_med_transport(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function med_transport_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &med_transport_cp_ondeathrespawncallback;
  }

  return var2;
}

function med_transport_cp_ondeathrespawncallback() {
  thread med_transport_cp_waitandspawn();
}

function med_transport_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("medium_transport")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("medium_transport", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}