/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58214.gsc
***********************************************/

start_safehouse_restart() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_BAF609D2739647C4853A2B", ::start_safehouse_return);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_8AEA073693CA16D12B", ::start_safehouse_regroup);
  scripts\engine\utility::create_func_ref("_encstr_BE820B53A080CF0245ADFC77B7", ::_id_134F9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::start_silo_elevator_menu);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_BE820B53A080CF0245ADFC77B7", _calloutmarkerping_onpingchallenge::start_trap_room_combat);
}

start_safehouse_return() {
  if(1) {
    return;
  }
  level.startvipteamuav = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_885F0EECB234D7C2620CB4DCC8A5CE7B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread start_safehouse_regroup_objective(var_0, 3);
}

start_safehouse_regroup_objective(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_5);

      if(isDefined(var_6))
        level.startvipteamuav = scripts\engine\utility::array_add(level.startvipteamuav, var_6);
    }
  }
}

start_safehouse_regroup(var_0) {
  var_0.maxhealth = 3500;
  var_0.health = var_0.maxhealth;
}

_id_134F9(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_A266062032BD7723", var_0, undefined, 1);
}

start_silo_elevator_menu(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::start_silo_elevator;

  return var_2;
}

start_silo_elevator() {
  thread start_silo_jump();
}

start_silo_jump() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_BE820B53A080CF0245ADFC77B7")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_BE820B53A080CF0245ADFC77B7", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}