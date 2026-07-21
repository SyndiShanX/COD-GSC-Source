/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58217.gsc
***********************************************/

_id_120F4() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_BAF609D2739647C4853A2B", ::_id_120F5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_8AEA073693CA16D12B", ::_id_120F2);
  scripts\engine\utility::create_func_ref("_encstr_97AE0AF6E0959BEB4D2B95C1", ::_id_134FC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::_id_120F7);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_97AE0AF6E0959BEB4D2B95C1", _calloutmarkerping_poolidisloot::_id_12100);
}

_id_120F5() {
  if(1) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("_encstr_AA930FED38CA9B53ACB2E07DDC1C16BB9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_120F3(var_0, 3);
}

_id_120F3(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_poolidisloot::_id_120F9(var_5);

      if(isDefined(var_6))
        level._id_12128 = scripts\engine\utility::array_add(level._id_12128, var_6);
    }
  }
}

_id_120F2(var_0) {
  var_0.maxhealth = 750;
  var_0.health = var_0.maxhealth;
}

_id_134FC(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_poolidisloot::_id_120F9(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

_id_120F7(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_poolidisloot::_id_120F9(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::_id_120F6;

  return var_2;
}

_id_120F6() {
  thread _id_120F8();
}

_id_120F8() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_97AE0AF6E0959BEB4D2B95C1")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_97AE0AF6E0959BEB4D2B95C1", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}