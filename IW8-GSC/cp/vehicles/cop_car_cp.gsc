/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\cop_car_cp.gsc
***********************************************/

cop_car_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_BAF609D2739647C4853A2B", ::cop_car_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_8AEA073693CA16D12B", ::cop_car_cp_create);
  scripts\engine\utility::create_func_ref("_encstr_8FE608B268BFF756987D", ::spawn_and_enter_cop_car);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::cop_car_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_8FE608B268BFF756987D", scripts\cp_mp\vehicles\cop_car::cop_car_explode);
}

cop_car_cp_initlate() {
  if(1) {
    return;
  }
  level.copcars = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_B26E0D5E6883E36A4ECFA7A39BF4A2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread cop_car_cp_createfromstructs(var_0, 3);
}

cop_car_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_5);

      if(isDefined(var_6))
        level.copcars = scripts\engine\utility::array_add(level.copcars, var_6);
    }
  }
}

cop_car_cp_create(var_0) {
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
}

spawn_and_enter_cop_car(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

cop_car_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::cop_car_cp_ondeathrespawncallback;

  return var_2;
}

cop_car_cp_ondeathrespawncallback() {
  thread cop_car_cp_waitandspawn();
}

cop_car_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_8FE608B268BFF756987D")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8FE608B268BFF756987D", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}