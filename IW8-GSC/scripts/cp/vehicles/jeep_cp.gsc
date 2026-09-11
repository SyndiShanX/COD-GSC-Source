/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\jeep_cp.gsc
***********************************************/

function jeep_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "initLate", &jeep_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "create", &jeep_cp_create);
  scripts\engine\utility::create_func_ref("jeep", &spawn_and_enter_jeep);
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "spawnCallback", &jeep_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("jeep", &scripts\cp_mp\vehicles\jeep::jeep_explode);
}

function jeep_cp_initlate() {
  if(true) {
    return;
  }

  level.jeeps = [];
  var0 = scripts\engine\utility::getStructArray("jeep_spawn", "targetname");
  thread jeep_cp_createfromstructs(var0, 3);
}

function jeep_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\jeep::jeep_create(var5);

      if(isDefined(var6)) {
        level.jeeps = scripts\engine\utility::array_add(level.jeeps, var6);
      }
    }

    return;
  }
}

function jeep_cp_create(var0) {
  var0.maxhealth = 1500;
  var0.health = var0.maxhealth;
}

function spawn_and_enter_jeep(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = scripts\cp_mp\vehicles\jeep::jeep_create(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function jeep_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\jeep::jeep_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &jeep_cp_ondeathrespawncallback;
  }

  return var2;
}

function jeep_cp_ondeathrespawncallback() {
  thread jeep_cp_waitandspawn();
}

function jeep_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("jeep")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("jeep", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}