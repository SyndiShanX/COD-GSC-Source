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

  var0 = getdvarint("scr_allow_technicals", 1) > 0;
  var1 = getdvarint("scr_allow_vehicles", 1) > 0;
  var2 = getdvarint("scr_runlean_max_technicals", 40);
  level.technicals = [];

  if(var0) {
    return;
  }

  var3 = scripts\engine\utility::getStructArray("technical_spawn", "targetname");
  thread technical_cp_createfromstructs(var3, 3);
}

function technical_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\technical::technical_create(var5);

      if(isDefined(var6)) {
        level.technicals = scripts\engine\utility::array_add(level.technicals, var6);
      }
    }

    return;
  }
}

function spawn_technical_at_location(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.origin = var0;
  var4.angles = var1;
  var4.team = var2;
  var5 = scripts\cp_mp\vehicles\technical::technical_create(var4);
  level.technicals = scripts\engine\utility::array_add(level.technicals, var5);

  if(istrue(var3)) {
    return var5;
  }
}

function technical_cp_create(var0) {
  var0.maxhealth = 1000;
  var0.health = var0.maxhealth;
}

function spawn_and_enter_technical(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = scripts\cp_mp\vehicles\technical::technical_create(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0, undefined, 1);
    return;
  }
}

function technical_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\technical::technical_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &technical_cp_ondeathrespawncallback;
  }

  return var2;
}

function technical_cp_ondeathrespawncallback() {
  thread technical_cp_waitandspawn();
}

function technical_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("technical")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("technical", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}