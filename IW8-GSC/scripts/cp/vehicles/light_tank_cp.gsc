/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\light_tank_cp.gsc
*************************************************/

function light_tank_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "create", &light_tank_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "initLate", &light_tank_cp_initlate);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitgameinstances("light_tank", 6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "spawnCallback", &light_tank_cp_spawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "spawnCallback", &light_tank_cp_spawncallback);
  scripts\engine\utility::create_func_ref("light_tank", &spawn_and_enter_light_tank);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("light_tank", &scripts\cp_mp\vehicles\light_tank::light_tank_explode);
  var_0 = scripts\cp_mp\vehicles\light_tank::light_tank_getleveldata();
  var_0.showheadicontoenemy = 1;
}

function light_tank_cp_initlate() {
  if(true) {
    return;
  }

  level.largetransports = [];
  var_0 = scripts\engine\utility::getStructArray("lighttank_spawn", "targetname");
  thread light_tank_cp_createfromstructs(var_0, 3);
}

function light_tank_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      level.lighttanks = scripts\engine\utility::array_add(level.lighttanks, scripts\cp_mp\vehicles\light_tank::light_tank_create(var_4.origin, var_4.angles));
    }

    return;
  }
}

function light_tank_cp_create(var_0) {
  var_0.maxhealth = 3000;
  var_0.health = var_0.maxhealth;
  var_0.vehicle_specific_onentervehicle = &light_tank_cp_onentervehicle;
  var_0.vehicle_specific_onexitvehicle = &light_tank_cp_onexitvehicle;
}

function spawn_and_enter_light_tank(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles;
  var_1.owner = var_0;
  var_1.team = var_0.team;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_1.spawnmethod = "place_at_position_unsafe";
  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "driver", var_0);
    return;
  }
}

function light_tank_cp_onentervehicle(var_0, var_1, var_2, var_3) {
  level notify("tank_enter", var_0);
}

function light_tank_cp_onexitvehicle(var_0, var_1, var_2, var_3) {
  level notify("tank_exit", var_0);
}

function light_tank_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &light_tank_cp_ondeathrespawncallback;
  }

  return var_2;
}

function light_tank_cp_ondeathrespawncallback() {
  thread light_tank_cp_waitandspawn();
}

function light_tank_cp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  scripts\cp_mp\vehicles\light_tank::light_tank_copyspawndata(var_0, var_1);
  var_2 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("light_tank")) {
      var_3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("light_tank", var_1, var_2);

      if(!isDefined(var_3)) {
        continue;
      }

      break;
    }
  }
}