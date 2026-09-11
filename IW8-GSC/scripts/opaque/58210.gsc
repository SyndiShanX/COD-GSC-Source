/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58210.gsc
***********************************************/

function get_force_push_direction() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_mg", "initLate", &get_forest_combat_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_mg", "create", &get_footstep_alias);
  scripts\engine\utility::create_func_ref("cargo_truck_mg", &ref_134f6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_mg", "spawnCallback", &get_freight_lift_spawnpoints);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("cargo_truck_mg", &_calloutmarkerping_isdropcrate::get_gunshot_alias);
}

function get_forest_combat_logic() {
  if(true) {
    return;
  }

  level.cargotrucks = [];
  var0 = scripts\engine\utility::getStructArray("cargotruckmg_spawn", "targetname");
  thread get_footstepsprint_alias(var0, 3);
}

function get_footstepsprint_alias(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var5);

      if(isDefined(var6)) {
        level.cargotrucks = scripts\engine\utility::array_add(level.cargotrucks, var6);
      }
    }

    return;
  }
}

function get_footstep_alias(var0) {
  var0.maxhealth = 8750;
  var0.health = var0.maxhealth;
}

function ref_134f6(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function get_freight_lift_spawnpoints(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &cargo_truck_cp_ondeathrespawncallback;
  }

  return var2;
}

function cargo_truck_cp_ondeathrespawncallback() {
  thread cargo_truck_cp_waitandspawn();
}

function cargo_truck_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("cargo_truck_mg")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck_mg", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}