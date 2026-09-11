/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\customization\battle_tracks.gsc
******************************************************************/

function create_juggernaut_spawner() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_bt", "initLate", &create_keycard_for_reader);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_bt", "create", &create_heli_stuct);
  scripts\engine\utility::create_func_ref("veh_bt", &ref_134f5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_bt", "spawnCallback", &create_laser_trap);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("veh_bt", &_calloutmarkerping_handleluinotify_mappingdeletemarker::create_script_wait_for_flags);
}

function create_keycard_for_reader() {
  if(true) {
    return;
  }

  level.ctgs_comparestats = [];
  var_0 = scripts\engine\utility::getStructArray("veh_bt", "targetname");
  thread create_intel_model(var_0, 3);
}

function create_intel_model(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_5);

      if(isDefined(var_6)) {
        level.ctgs_comparestats = scripts\engine\utility::array_add(level.ctgs_comparestats, var_6);
      }
    }

    return;
  }
}

function create_heli_stuct(var_0) {
  var_0.maxhealth = 3500;
  var_0.health = var_0.maxhealth;
}

function ref_134f5(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "pilot", var_0, undefined, 1);
    return;
  }
}

function create_laser_trap(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &create_laser_point_to_point;
  }

  return var_2;
}

function create_laser_point_to_point() {
  thread create_model_at();
}

function create_model_at() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("veh_bt")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("veh_bt", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}