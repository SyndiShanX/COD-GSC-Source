/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\technical_cp.gsc
***********************************************/

technical_cp_init() {
  if(!isDefined(level.technicals))
    level.technicals = [];

  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_8AEA073693CA16D12B", ::technical_cp_create);
  scripts\engine\utility::create_func_ref("_encstr_84D70A6B2BEF3C9B30A67164", ::spawn_and_enter_technical);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::technical_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_84D70A6B2BEF3C9B30A67164", scripts\cp_mp\vehicles\technical::technical_explode);
}

technical_cp_initlate() {
  if(1) {
    return;
  }
  var_0 = getdvarint("_encstr_B879157F1AB2C8CA4AA967EFFE6D3A07F3533C3AC16947", 1) > 0;
  var_1 = getdvarint("_encstr_87EF136FB8EBF7BA6981651B6035B298D010ABBFA0", 1) > 0;
  var_2 = getdvarint("_encstr_8A6F1BB9C627BEC9EACD632B0B9BD7DA2C0FBEA3563643B92D36B08DE6", 40);
  level.technicals = [];

  if(var_0) {
    return;
  }
  var_3 = scripts\engine\utility::getStructArray("_encstr_BA6A107318F7349308AE797CA89333BE37B8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread technical_cp_createfromstructs(var_3, 3);
}

technical_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\technical::technical_create(var_5);

      if(isDefined(var_6))
        level.technicals = scripts\engine\utility::array_add(level.technicals, var_6);
    }
  }
}

spawn_technical_at_location(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.team = var_2;
  var_5 = scripts\cp_mp\vehicles\technical::technical_create(var_4);
  level.technicals = scripts\engine\utility::array_add(level.technicals, var_5);

  if(istrue(var_3))
    return var_5;
}

technical_cp_create(var_0) {
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
}

spawn_and_enter_technical(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\technical::technical_create(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

technical_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\technical::technical_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::technical_cp_ondeathrespawncallback;

  return var_2;
}

technical_cp_ondeathrespawncallback() {
  thread technical_cp_waitandspawn();
}

technical_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_84D70A6B2BEF3C9B30A67164")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_84D70A6B2BEF3C9B30A67164", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}