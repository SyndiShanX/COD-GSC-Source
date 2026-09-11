/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58214.gsc
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
  var0 = scripts\engine\utility::getStructArray("veh_a10indigo", "targetname");
  thread start_safehouse_regroup_objective(var0, 3);
}

function start_safehouse_regroup_objective(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var5);

      if(isDefined(var6)) {
        level.startvipteamuav = scripts\engine\utility::array_add(level.startvipteamuav, var6);
      }
    }

    return;
  }
}

function start_safehouse_regroup(var0) {
  var0.maxhealth = 3500;
  var0.health = var0.maxhealth;
}

function ref_134f9(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "pilot", var0, undefined, 1);
    return;
  }
}

function start_silo_elevator_menu(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &start_silo_elevator;
  }

  return var2;
}

function start_silo_elevator() {
  thread start_silo_jump();
}

function start_silo_jump() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("veh_indigo")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("veh_indigo", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}