/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58210.gsc
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
  var_0 = scripts\engine\utility::getStructArray("cargotruckmg_spawn", "targetname");
  thread get_footstepsprint_alias(var_0, 3);
}

function get_footstepsprint_alias(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_5);

      if(isDefined(var_6)) {
        level.cargotrucks = scripts\engine\utility::array_add(level.cargotrucks, var_6);
      }
    }

    return;
  }
}

function get_footstep_alias(var_0) {
  var_0.maxhealth = 8750;
  var_0.health = var_0.maxhealth;
}

function ref_134f6(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function get_freight_lift_spawnpoints(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &cargo_truck_cp_ondeathrespawncallback;
  }

  return var_2;
}

function cargo_truck_cp_ondeathrespawncallback() {
  thread cargo_truck_cp_waitandspawn();
}

function cargo_truck_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("cargo_truck_mg")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck_mg", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}