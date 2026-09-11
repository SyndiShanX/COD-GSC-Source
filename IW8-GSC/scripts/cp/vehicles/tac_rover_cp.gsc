/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\tac_rover_cp.gsc
************************************************/

function tac_rover_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "initLate", &tac_rover_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "create", &tac_rover_cp_create);
  scripts\engine\utility::create_func_ref("tac_rover", &spawn_and_enter_tac_rover);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "spawnCallback", &tac_rover_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("tac_rover", &scripts\cp_mp\vehicles\tac_rover::tac_rover_explode);
}

function tac_rover_cp_initlate() {
  if(true) {
    return;
  }

  var_0 = scripts\engine\utility::getStructArray("tacrover_spawn", "targetname");
  thread tac_rover_cp_createfromstructs(var_0, 3);
}

function tac_rover_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_5);

      if(isDefined(var_6)) {
        level.tacrovers = scripts\engine\utility::array_add(level.tacrovers, var_6);
      }
    }

    return;
  }
}

function tac_rover_cp_create(var_0) {
  var_0.maxhealth = 750;
  var_0.health = var_0.maxhealth;
}

function spawn_and_enter_tac_rover(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function tac_rover_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &tac_rover_cp_ondeathrespawncallback;
  }

  return var_2;
}

function tac_rover_cp_ondeathrespawncallback() {
  thread tac_rover_cp_waitandspawn();
}

function tac_rover_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("tac_rover")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("tac_rover", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}