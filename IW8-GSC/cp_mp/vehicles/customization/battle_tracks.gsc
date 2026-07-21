/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\customization\battle_tracks.gsc
**********************************************************/

create_juggernaut_spawner() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_BAF609D2739647C4853A2B", ::create_keycard_for_reader);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_8AEA073693CA16D12B", ::create_heli_stuct);
  scripts\engine\utility::create_func_ref("_encstr_83F40783ADF1D14AA3", ::_id_134F5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::create_laser_trap);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_83F40783ADF1D14AA3", _calloutmarkerping_handleluinotify_mappingdeletemarker::create_script_wait_for_flags);
}

create_keycard_for_reader() {
  if(1) {
    return;
  }
  level.ctgs_comparestats = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_83F40783ADF1D14AA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread create_intel_model(var_0, 3);
}

create_intel_model(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_5);

      if(isDefined(var_6))
        level.ctgs_comparestats = scripts\engine\utility::array_add(level.ctgs_comparestats, var_6);
    }
  }
}

create_heli_stuct(var_0) {
  var_0.maxhealth = 3500;
  var_0.health = var_0.maxhealth;
}

_id_134F5(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_A266062032BD7723", var_0, undefined, 1);
}

create_laser_trap(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::create_laser_point_to_point;

  return var_2;
}

create_laser_point_to_point() {
  thread create_model_at();
}

create_model_at() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_83F40783ADF1D14AA3")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_83F40783ADF1D14AA3", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}