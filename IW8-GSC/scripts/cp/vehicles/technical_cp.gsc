/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\technical_cp.gsc
************************************************/

function technical_cp_init() {
  if(!isDefined(level.technicals)) {
    level.technicals = [];
  }

  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "create", &technical_cp_create);
  scripts\engine\utility::create_func_ref("technical", &spawn_and_enter_technical);
  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "spawnCallback", &technical_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("technical", &scripts\cp_mp\vehicles\technical::technical_explode);
}

function technical_cp_initlate() {
  if(true) {
    return;
  }

  var_0 = getdvarint("scr_allow_technicals", 1) > 0;
  var_1 = getdvarint("scr_allow_vehicles", 1) > 0;
  var_2 = getdvarint("scr_runlean_max_technicals", 40);
  level.technicals = [];

  if(var_0) {
    return;
  }

  var_3 = scripts\engine\utility::getStructArray("technical_spawn", "targetname");
  thread technical_cp_createfromstructs(var_3, 3);
}

function technical_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\technical::technical_create(var_5);

      if(isDefined(var_6)) {
        level.technicals = scripts\engine\utility::array_add(level.technicals, var_6);
      }
    }

    return;
  }
}

function spawn_technical_at_location(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.team = var_2;
  var_5 = scripts\cp_mp\vehicles\technical::technical_create(var_4);
  level.technicals = scripts\engine\utility::array_add(level.technicals, var_5);

  if(istrue(var_3)) {
    return var_5;
  }
}

function technical_cp_create(var_0) {
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
}

function spawn_and_enter_technical(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\technical::technical_create(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0, undefined, 1);
    return;
  }
}

function technical_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\technical::technical_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &technical_cp_ondeathrespawncallback;
  }

  return var_2;
}

function technical_cp_ondeathrespawncallback() {
  thread technical_cp_waitandspawn();
}

function technical_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("technical")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("technical", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}