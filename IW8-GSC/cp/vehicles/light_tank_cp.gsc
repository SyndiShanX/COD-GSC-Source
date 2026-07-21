/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\light_tank_cp.gsc
***********************************************/

light_tank_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_8AEA073693CA16D12B", ::light_tank_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BAF609D2739647C4853A2B", ::light_tank_cp_initlate);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitgameinstances("_encstr_AF390B295782C3585F1B21D8C4", 6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::light_tank_cp_spawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::light_tank_cp_spawncallback);
  scripts\engine\utility::create_func_ref("_encstr_AF390B295782C3585F1B21D8C4", ::spawn_and_enter_light_tank);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_AF390B295782C3585F1B21D8C4", scripts\cp_mp\vehicles\light_tank::light_tank_explode);
  var_0 = scripts\cp_mp\vehicles\light_tank::light_tank_getleveldata();
  var_0.showheadicontoenemy = 1;
}

light_tank_cp_initlate() {
  if(1) {
    return;
  }
  level.largetransports = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_843D107B1B7442B41899357C7608F86AD4BD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread light_tank_cp_createfromstructs(var_0, 3);
}

light_tank_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0)
    level.lighttanks = scripts\engine\utility::array_add(level.lighttanks, scripts\cp_mp\vehicles\light_tank::light_tank_create(var_4.origin, var_4.angles));
  }
}

light_tank_cp_create(var_0) {
  var_0.maxhealth = 3000;
  var_0.health = var_0.maxhealth;
  var_0.vehicle_specific_onentervehicle = ::light_tank_cp_onentervehicle;
  var_0.vehicle_specific_onexitvehicle = ::light_tank_cp_onexitvehicle;
}

spawn_and_enter_light_tank(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles;
  var_1.owner = var_0;
  var_1.team = var_0.team;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_1.spawnmethod = "_encstr_B813195051C942790FB923A7D920974723C3159399431857D9BFB5";
  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0);
}

light_tank_cp_onentervehicle(var_0, var_1, var_2, var_3) {
  level notify("_encstr_84570B6BEF82BA5965A6ACDFFB", var_0);
}

light_tank_cp_onexitvehicle(var_0, var_1, var_2, var_3) {
  level notify("_encstr_8A7E0A6080CA9F6F559390F1", var_0);
}

light_tank_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::light_tank_cp_ondeathrespawncallback;

  return var_2;
}

light_tank_cp_ondeathrespawncallback() {
  thread light_tank_cp_waitandspawn();
}

light_tank_cp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  scripts\cp_mp\vehicles\light_tank::light_tank_copyspawndata(var_0, var_1);
  var_2 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_AF390B295782C3585F1B21D8C4")) {
      var_3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_AF390B295782C3585F1B21D8C4", var_1, var_2);

      if(!isDefined(var_3)) {
        continue;
      }
      break;
    }
  }
}