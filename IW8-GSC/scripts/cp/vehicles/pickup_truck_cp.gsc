/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\pickup_truck_cp.gsc
***************************************************/

function pickup_truck_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "initLate", &pickup_truck_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "create", &pickup_truck_cp_create);
  scripts\engine\utility::create_func_ref("pickup_truck", &spawn_and_enter_pickup_truck);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "spawnCallback", &pickup_truck_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("pickup_truck", &scripts\cp_mp\vehicles\pickup_truck::pickup_truck_explode);
}

function pickup_truck_cp_initlate() {
  if(true) {
    return;
  }

  level.pickuptrucks = [];
  var0 = scripts\engine\utility::getStructArray("pickuptruck_spawn", "targetname");
  thread pickup_truck_cp_createfromstructs(var0, 3);
}

function pickup_truck_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var5);

      if(isDefined(var6)) {
        level.pickuptrucks = scripts\engine\utility::array_add(level.pickuptrucks, var6);
      }
    }

    return;
  }
}

function pickup_truck_cp_create(var0) {
  var0.maxhealth = 1000;
  var0.health = var0.maxhealth;
}

function spawn_and_enter_pickup_truck(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function pickup_truck_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &pickup_truck_cp_ondeathrespawncallback;
  }

  return var2;
}

function pickup_truck_cp_ondeathrespawncallback() {
  thread pickup_truck_cp_waitandspawn();
}

function pickup_truck_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("pickup_truck")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("pickup_truck", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}