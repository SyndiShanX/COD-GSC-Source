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
  var0 = scripts\cp_mp\vehicles\light_tank::light_tank_getleveldata();
  var0.showheadicontoenemy = 1;
}

function light_tank_cp_initlate() {
  if(true) {
    return;
  }

  level.largetransports = [];
  var0 = scripts\engine\utility::getStructArray("lighttank_spawn", "targetname");
  thread light_tank_cp_createfromstructs(var0, 3);
}

function light_tank_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      level.lighttanks = scripts\engine\utility::array_add(level.lighttanks, scripts\cp_mp\vehicles\light_tank::light_tank_create(var4.origin, var4.angles));
    }

    return;
  }
}

function light_tank_cp_create(var0) {
  var0.maxhealth = 3000;
  var0.health = var0.maxhealth;
  var0.vehicle_specific_onentervehicle = &light_tank_cp_onentervehicle;
  var0.vehicle_specific_onexitvehicle = &light_tank_cp_onexitvehicle;
}

function spawn_and_enter_light_tank(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles;
  var1.owner = var0;
  var1.team = var0.team;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var1);
  var1.spawnmethod = "place_at_position_unsafe";
  var2 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "driver", var0);
    return;
  }
}

function light_tank_cp_onentervehicle(var0, var1, var2, var3) {
  level notify("tank_enter", var0);
}

function light_tank_cp_onexitvehicle(var0, var1, var2, var3) {
  level notify("tank_exit", var0);
}

function light_tank_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &light_tank_cp_ondeathrespawncallback;
  }

  return var2;
}

function light_tank_cp_ondeathrespawncallback() {
  thread light_tank_cp_waitandspawn();
}

function light_tank_cp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  scripts\cp_mp\vehicles\light_tank::light_tank_copyspawndata(var0, var1);
  var2 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("light_tank")) {
      var3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("light_tank", var1, var2);

      if(!isDefined(var3)) {
        continue;
      }

      break;
    }
  }
}