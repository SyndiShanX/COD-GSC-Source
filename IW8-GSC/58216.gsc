/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58216.gsc
***********************************************/

function ref_11D51() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "initLate", &ref_11D52);
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "create", &ref_11D4F);
  scripts\engine\utility::create_func_ref("motorcycle", &ref_134FB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "spawnCallback", &ref_11D54);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("motorcycle", &_calloutmarkerping_poolidisentity::ref_11D5D);
}

function ref_11D52() {
  if(true) {
    return;
  }

  level.ref_11D73 = [];
  var_0 = scripts\engine\utility::getStructArray("motorcycle_spawn", "targetname");
  thread ref_11D50(var_0, 3);
}

function ref_11D50(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_poolidisentity::ref_11D56(var_5);

      if(isDefined(var_6)) {
        level.ref_11D73 = scripts\engine\utility::array_add(level.ref_11D73, var_6);
      }
    }

    return;
  }
}

function ref_11D4F(var_0) {
  var_0.maxhealth = 500;
  var_0.health = var_0.maxhealth;
}

function ref_134FB(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_poolidisentity::ref_11D56(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function ref_11D54(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_poolidisentity::ref_11D56(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &ref_11D53;
  }

  return var_2;
}

function ref_11D53() {
  thread ref_11D55();
}

function ref_11D55() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("motorcycle")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("motorcycle", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}