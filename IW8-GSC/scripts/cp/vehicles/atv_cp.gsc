/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\atv_cp.gsc
***********************************************/

function atv_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "initLate", &atv_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "create", &atv_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "spawnCallback", &atv_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("atv", &scripts\cp_mp\vehicles\atv::atv_explode);
}

function atv_cp_initlate() {
  if(true) {
    return;
  }

  level.atvs = [];
  var_0 = scripts\engine\utility::getStructArray("atv_spawn", "targetname");
  thread atv_cp_createfromstructs(var_0, 3);
}

function atv_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\atv::atv_create(var_5);

      if(isDefined(var_6)) {
        level.atvs = scripts\engine\utility::array_add(level.atvs, var_6);
      }
    }

    return;
  }
}

function atv_cp_create(var_0) {
  var_0.maxhealth = 500;
  var_0.health = var_0.maxhealth;
}

function atv_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\atv::atv_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &atv_cp_ondeathrespawncallback;
  }

  return var_2;
}

function atv_cp_ondeathrespawncallback() {
  thread atv_cp_waitandspawn();
}

function atv_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("atv")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}