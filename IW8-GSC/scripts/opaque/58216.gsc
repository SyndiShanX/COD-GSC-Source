/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58216.gsc
***********************************************/

function ref_11d51() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "initLate", &ref_11d52);
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "create", &ref_11d4f);
  scripts\engine\utility::create_func_ref("motorcycle", &ref_134fb);
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "spawnCallback", &ref_11d54);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("motorcycle", &_calloutmarkerping_poolidisentity::ref_11d5d);
}

function ref_11d52() {
  if(true) {
    return;
  }

  level.ref_11d73 = [];
  var0 = scripts\engine\utility::getStructArray("motorcycle_spawn", "targetname");
  thread ref_11d50(var0, 3);
}

function ref_11d50(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_poolidisentity::ref_11d56(var5);

      if(isDefined(var6)) {
        level.ref_11d73 = scripts\engine\utility::array_add(level.ref_11d73, var6);
      }
    }

    return;
  }
}

function ref_11d4f(var0) {
  var0.maxhealth = 500;
  var0.health = var0.maxhealth;
}

function ref_134fb(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_poolidisentity::ref_11d56(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function ref_11d54(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_poolidisentity::ref_11d56(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &ref_11d53;
  }

  return var2;
}

function ref_11d53() {
  thread ref_11d55();
}

function ref_11d55() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("motorcycle")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("motorcycle", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}