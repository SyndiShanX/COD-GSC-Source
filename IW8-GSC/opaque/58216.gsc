/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58216.gsc
***********************************************/

_id_11D51() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_BAF609D2739647C4853A2B", ::_id_11D52);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_8AEA073693CA16D12B", ::_id_11D4F);
  scripts\engine\utility::create_func_ref("_encstr_99C20BA548E9F27A61D897932B", ::_id_134FB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::_id_11D54);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_99C20BA548E9F27A61D897932B", _calloutmarkerping_poolidisentity::_id_11D5D);
}

_id_11D52() {
  if(1) {
    return;
  }
  level._id_11D73 = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_87D2116BDE47F627D85E6C6395AFE60EC2EEE6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_11D50(var_0, 3);
}

_id_11D50(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_poolidisentity::_id_11D56(var_5);

      if(isDefined(var_6))
        level._id_11D73 = scripts\engine\utility::array_add(level._id_11D73, var_6);
    }
  }
}

_id_11D4F(var_0) {
  var_0.maxhealth = 500;
  var_0.health = var_0.maxhealth;
}

_id_134FB(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_poolidisentity::_id_11D56(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

_id_11D54(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_poolidisentity::_id_11D56(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::_id_11D53;

  return var_2;
}

_id_11D53() {
  thread _id_11D55();
}

_id_11D55() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_99C20BA548E9F27A61D897932B")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_99C20BA548E9F27A61D897932B", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}