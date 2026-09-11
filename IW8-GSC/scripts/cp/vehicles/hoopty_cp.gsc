/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\hoopty_cp.gsc
***********************************************/

function hoopty_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "initLate", &hoopty_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "create", &hoopty_cp_create);
  scripts\engine\utility::create_func_ref("hoopty", &spawn_and_enter_hoopty);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "spawnCallback", &hoopty_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("hoopty", &scripts\cp_mp\vehicles\hoopty::hoopty_explode);
}

function hoopty_cp_initlate() {
  if(true) {
    return;
  }

  level.hoopties = [];
  var_0 = scripts\engine\utility::getStructArray("hoopty_spawn", "targetname");
  thread hoopty_cp_createfromstructs(var_0, 3);
}

function hoopty_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\hoopty::hoopty_create(var_5);

      if(isDefined(var_6)) {
        level.hoopties = scripts\engine\utility::array_add(level.hoopties, var_6);
      }
    }

    return;
  }
}

function hoopty_cp_create(var_0) {
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
}

function spawn_and_enter_hoopty(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\hoopty::hoopty_create(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function hoopty_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\hoopty::hoopty_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &hoopty_cp_ondeathrespawncallback;
  }

  return var_2;
}

function hoopty_cp_ondeathrespawncallback() {
  thread hoopty_cp_waitandspawn();
}

function hoopty_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("hoopty")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("hoopty", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}