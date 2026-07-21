/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\atv_cp.gsc
***********************************************/

atv_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C190467402B", "_encstr_BAF609D2739647C4853A2B", ::atv_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C190467402B", "_encstr_8AEA073693CA16D12B", ::atv_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C190467402B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::atv_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_8C190467402B", scripts\cp_mp\vehicles\atv::atv_explode);
}

atv_cp_initlate() {
  if(1) {
    return;
  }
  level.atvs = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_BE7E0A0F2843CFA3792F7B35", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread atv_cp_createfromstructs(var_0, 3);
}

atv_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\atv::atv_create(var_5);

      if(isDefined(var_6))
        level.atvs = scripts\engine\utility::array_add(level.atvs, var_6);
    }
  }
}

atv_cp_create(var_0) {
  var_0.maxhealth = 500;
  var_0.health = var_0.maxhealth;
}

atv_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\atv::atv_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::atv_cp_ondeathrespawncallback;

  return var_2;
}

atv_cp_ondeathrespawncallback() {
  thread atv_cp_waitandspawn();
}

atv_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_8C190467402B")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}