/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58217.gsc
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

  var0 = scripts\engine\utility::getStructArray("openjeep_spawn", "targetname");
  thread ref_120f3(var0, 3);
}

function ref_120f3(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_poolidisloot::ref_120f9(var5);

      if(isDefined(var6)) {
        level.ref_12128 = scripts\engine\utility::array_add(level.ref_12128, var6);
      }
    }

    return;
  }
}

function ref_120f2(var0) {
  var0.maxhealth = 750;
  var0.health = var0.maxhealth;
}

function ref_134fc(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_poolidisloot::ref_120f9(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function ref_120f7(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_poolidisloot::ref_120f9(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &ref_120f6;
  }

  return var2;
}

function ref_120f6() {
  thread ref_120f8();
}

function ref_120f8() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("open_jeep")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("open_jeep", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}