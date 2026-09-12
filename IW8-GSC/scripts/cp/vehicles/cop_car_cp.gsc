/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cop_car_cp.gsc
***********************************************/

function cop_car_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "initLate", &cop_car_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "create", &cop_car_cp_create);
  scripts\engine\utility::create_func_ref("cop_car", &spawn_and_enter_cop_car);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "spawnCallback", &cop_car_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("cop_car", &scripts\cp_mp\vehicles\cop_car::cop_car_explode);
}

function cop_car_cp_initlate() {
  if(true) {
    return;
  }

  level.copcars = [];
  var_0 = scripts\engine\utility::getStructArray("copcar_spawn", "targetname");
  thread cop_car_cp_createfromstructs(var_0, 3);
}

function cop_car_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_5);

      if(isDefined(var_6)) {
        level.copcars = scripts\engine\utility::array_add(level.copcars, var_6);
      }
    }

    return;
  }
}

function cop_car_cp_create(var_0) {
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
}

function spawn_and_enter_cop_car(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function cop_car_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &cop_car_cp_ondeathrespawncallback;
  }

  return var_2;
}

function cop_car_cp_ondeathrespawncallback() {
  thread cop_car_cp_waitandspawn();
}

function cop_car_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("cop_car")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cop_car", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}