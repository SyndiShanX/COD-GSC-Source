/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\hoopty_truck_cp.gsc
***********************************************/

hoopty_truck_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_BAF609D2739647C4853A2B", ::hoopty_truck_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_8AEA073693CA16D12B", ::hoopty_truck_cp_create);
  scripts\engine\utility::create_func_ref("_encstr_8BAA0D68183D43A35319057A93B767", ::spawn_and_enter_hoopty_truck);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::hoopty_truck_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_8BAA0D68183D43A35319057A93B767", scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_explode);
}

hoopty_truck_cp_initlate() {
  if(1) {
    return;
  }
  level.hooptytrucks = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_A25612D42F20D32B9B9B2B7BFFF2D1D347E853F6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread hoopty_truck_cp_createfromstructs(var_0, 3);
}

hoopty_truck_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_create(var_5);

      if(isDefined(var_6))
        level.hooptytrucks = scripts\engine\utility::array_add(level.hooptytrucks, var_6);
    }
  }
}

hoopty_truck_cp_create(var_0) {
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
}

spawn_and_enter_hoopty_truck(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_create(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

hoopty_truck_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::hoopty_truck_cp_ondeathrespawncallback;

  return var_2;
}

hoopty_truck_cp_ondeathrespawncallback() {
  thread hoopty_truck_cp_waitandspawn();
}

hoopty_truck_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_8BAA0D68183D43A35319057A93B767")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8BAA0D68183D43A35319057A93B767", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}