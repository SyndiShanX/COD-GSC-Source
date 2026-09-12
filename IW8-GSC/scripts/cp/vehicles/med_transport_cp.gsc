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
  var_0 = scripts\engine\utility::getStructArray("mediumtransport_spawn", "targetname");
  thread med_transport_cp_createfromstructs(var_0, 3);
}

function med_transport_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var_5);

      if(isDefined(var_6)) {
        level.medtransports = scripts\engine\utility::array_add(level.medtransports, var_6);
      }
    }

    return;
  }
}

function med_transport_cp_create(var_0) {
  var_0.maxhealth = 2000;
  var_0.health = var_0.maxhealth;
}

function spawn_and_enter_med_transport(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function med_transport_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &med_transport_cp_ondeathrespawncallback;
  }

  return var_2;
}

function med_transport_cp_ondeathrespawncallback() {
  thread med_transport_cp_waitandspawn();
}

function med_transport_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("medium_transport")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("medium_transport", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}