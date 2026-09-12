/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58214.gsc
***********************************************/

function start_safehouse_restart() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_indigo", "initLate", &start_safehouse_return);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_indigo", "create", &start_safehouse_regroup);
  scripts\engine\utility::create_func_ref("veh_indigo", &ref_134f9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_indigo", "spawnCallback", &start_silo_elevator_menu);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("veh_indigo", &_calloutmarkerping_onpingchallenge::start_trap_room_combat);
}

function start_safehouse_return() {
  if(true) {
    return;
  }

  level.startvipteamuav = [];
  var_0 = scripts\engine\utility::getStructArray("veh_a10indigo", "targetname");
  thread start_safehouse_regroup_objective(var_0, 3);
}

function start_safehouse_regroup_objective(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_5);

      if(isDefined(var_6)) {
        level.startvipteamuav = scripts\engine\utility::array_add(level.startvipteamuav, var_6);
      }
    }

    return;
  }
}

function start_safehouse_regroup(var_0) {
  var_0.maxhealth = 3500;
  var_0.health = var_0.maxhealth;
}

function ref_134f9(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "pilot", var_0, undefined, 1);
    return;
  }
}

function start_silo_elevator_menu(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &start_silo_elevator;
  }

  return var_2;
}

function start_silo_elevator() {
  thread start_silo_jump();
}

function start_silo_jump() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("veh_indigo")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("veh_indigo", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}