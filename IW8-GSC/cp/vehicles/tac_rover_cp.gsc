/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\tac_rover_cp.gsc
***********************************************/

tac_rover_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_BAF609D2739647C4853A2B", ::tac_rover_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_8AEA073693CA16D12B", ::tac_rover_cp_create);
  scripts\engine\utility::create_func_ref("_encstr_9A120A1D8536F5E4ED3BB293", ::spawn_and_enter_tac_rover);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::tac_rover_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_9A120A1D8536F5E4ED3BB293", scripts\cp_mp\vehicles\tac_rover::tac_rover_explode);
}

tac_rover_cp_initlate() {
  if(1) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B910F8E2C36937BD956E47DCDC10BEECD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread tac_rover_cp_createfromstructs(var_0, 3);
}

tac_rover_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_5);

      if(isDefined(var_6))
        level.tacrovers = scripts\engine\utility::array_add(level.tacrovers, var_6);
    }
  }
}

tac_rover_cp_create(var_0) {
  var_0.maxhealth = 750;
  var_0.health = var_0.maxhealth;
}

spawn_and_enter_tac_rover(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

tac_rover_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::tac_rover_cp_ondeathrespawncallback;

  return var_2;
}

tac_rover_cp_ondeathrespawncallback() {
  thread tac_rover_cp_waitandspawn();
}

tac_rover_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_9A120A1D8536F5E4ED3BB293")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A120A1D8536F5E4ED3BB293", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}