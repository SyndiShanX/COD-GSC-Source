/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\large_transport_cp.gsc
***********************************************/

large_transport_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_BAF609D2739647C4853A2B", ::large_transport_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_8AEA073693CA16D12B", ::large_transport_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::large_transport_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", scripts\cp_mp\vehicles\large_transport::large_transport_explode);
}

large_transport_cp_initlate() {
  if(1) {
    return;
  }
  level.largetransports = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_9AF01563B09CB395A39358E6B9E0DB39A3FAE6C116DDCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread large_transport_cp_createfromstructs(var_0, 3);
}

large_transport_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var_5);

      if(isDefined(var_6))
        level.largetransports = scripts\engine\utility::array_add(level.largetransports, var_6);
    }
  }
}

large_transport_cp_create(var_0) {
  var_0.maxhealth = 2000;
  var_0.health = var_0.maxhealth;
}

large_transport_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::large_transport_cp_ondeathrespawncallback;

  return var_2;
}

large_transport_cp_ondeathrespawncallback() {
  thread large_transport_cp_waitandspawn();
}

large_transport_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}