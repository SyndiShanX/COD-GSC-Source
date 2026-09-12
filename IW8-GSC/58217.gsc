/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58217.gsc
***********************************************/

function ref_120f4() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "initLate", &ref_120f5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "create", &ref_120f2);
  scripts\engine\utility::create_func_ref("open_jeep", &ref_134fc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "spawnCallback", &ref_120f7);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("open_jeep", &_calloutmarkerping_poolidisloot::ref_12100);
}

function ref_120f5() {
  if(true) {
    return;
  }

  var_0 = scripts\engine\utility::getStructArray("openjeep_spawn", "targetname");
  thread ref_120f3(var_0, 3);
}

function ref_120f3(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_poolidisloot::ref_120f9(var_5);

      if(isDefined(var_6)) {
        level.ref_12128 = scripts\engine\utility::array_add(level.ref_12128, var_6);
      }
    }

    return;
  }
}

function ref_120f2(var_0) {
  var_0.maxhealth = 750;
  var_0.health = var_0.maxhealth;
}

function ref_134fc(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_poolidisloot::ref_120f9(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function ref_120f7(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_poolidisloot::ref_120f9(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &ref_120f6;
  }

  return var_2;
}

function ref_120f6() {
  thread ref_120f8();
}

function ref_120f8() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("open_jeep")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("open_jeep", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}