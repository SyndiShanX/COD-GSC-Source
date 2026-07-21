/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58210.gsc
***********************************************/

get_force_push_direction() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_BAF609D2739647C4853A2B", ::get_forest_combat_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_8AEA073693CA16D12B", ::get_footstep_alias);
  scripts\engine\utility::create_func_ref("_encstr_BAC20FBEE6F88945F163A37BD68409923B", ::_id_134F6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::get_freight_lift_spawnpoints);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_BAC20FBEE6F88945F163A37BD68409923B", _calloutmarkerping_isdropcrate::get_gunshot_alias);
}

get_forest_combat_logic() {
  if(1) {
    return;
  }
  level.cargotrucks = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_8CA71382101B81CD957678373BC8F05F339BD65B7D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread get_footstepsprint_alias(var_0, 3);
}

get_footstepsprint_alias(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_5);

      if(isDefined(var_6))
        level.cargotrucks = scripts\engine\utility::array_add(level.cargotrucks, var_6);
    }
  }
}

get_footstep_alias(var_0) {
  var_0.maxhealth = 8750;
  var_0.health = var_0.maxhealth;
}

_id_134F6(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

get_freight_lift_spawnpoints(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::cargo_truck_cp_ondeathrespawncallback;

  return var_2;
}

cargo_truck_cp_ondeathrespawncallback() {
  thread cargo_truck_cp_waitandspawn();
}

cargo_truck_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}