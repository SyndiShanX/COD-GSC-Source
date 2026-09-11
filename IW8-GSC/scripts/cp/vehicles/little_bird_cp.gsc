/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\little_bird_cp.gsc
**************************************************/

function little_bird_cp_init() {
  scripts\engine\utility::create_func_ref("little_bird", &spawn_and_enter_little_bird);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "create", &little_bird_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "initLate", &little_bird_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "spawnCallback", &little_bird_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("little_bird", &scripts\cp_mp\vehicles\little_bird::little_bird_explode);
}

function little_bird_cp_create(var_0) {
  var_0.maxhealth = 2500;
  var_0.health = var_0.maxhealth;
  var_0.vehicle_specific_onentervehicle = &little_bird_cp_onentervehicle;
  var_0.vehicle_specific_onexitvehicle = &little_bird_cp_onexitvehicle;
  var_1 = var_0 getentitynumber();
  addtolittlebirdlist(var_0, var_1);
  thread removefromlittlebirdlistondeath(var_0);
}

function little_bird_cp_initlate() {
  if(true) {
    return;
  }

  level.littlebirds = [];
  var_0 = scripts\engine\utility::getStructArray("littlebird_spawn", "targetname");
  thread little_bird_cp_createfromstructs(var_0, 3);
}

function little_bird_cp_createfromstructs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_5);

      if(isDefined(var_6)) {
        level.littlebirds = scripts\engine\utility::array_add(level.littlebirds, var_6);
      }
    }
  }

  level notify("little_birds_done_spawning");
}

function spawn_little_bird_at_location(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_0, var_1, undefined, var_2);

  if(istrue(var_3)) {
    return var_4;
  }
}

function spawn_and_enter_little_bird(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "pilot", var_0, undefined, 1);
    return;
  }
}

function little_bird_cp_onentervehicle(var_0, var_1, var_2, var_3) {}

function little_bird_cp_onexitvehicle(var_0, var_1, var_2, var_3) {}

function addtolittlebirdlist(var_0) {
  if(!isDefined(level.littlebirds)) {
    level.littlebirds = [];
  }

  level.littlebirds[var_0] = self;
}

function removefromlittlebirdlistondeath(var_0) {
  self waittill("death");
  level.littlebirds[var_0] = undefined;
}

function little_bird_cp_spawncallback(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &little_bird_cp_ondeathrespawncallback;
  }

  return var_2;
}

function little_bird_cp_ondeathrespawncallback() {
  thread little_bird_cp_waitandspawn();
}

function little_bird_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("little_bird")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}