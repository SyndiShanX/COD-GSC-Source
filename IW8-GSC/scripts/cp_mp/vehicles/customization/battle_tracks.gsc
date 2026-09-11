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
  var0 = scripts\engine\utility::getStructArray("veh_bt", "targetname");
  thread create_intel_model(var0, 3);
}

function create_intel_model(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var5);

      if(isDefined(var6)) {
        level.ctgs_comparestats = scripts\engine\utility::array_add(level.ctgs_comparestats, var6);
      }
    }

    return;
  }
}

function create_heli_stuct(var0) {
  var0.maxhealth = 3500;
  var0.health = var0.maxhealth;
}

function ref_134f5(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "pilot", var0, undefined, 1);
    return;
  }
}

function create_laser_trap(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &create_laser_point_to_point;
  }

  return var2;
}

function create_laser_point_to_point() {
  thread create_model_at();
}

function create_model_at() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("veh_bt")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("veh_bt", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}