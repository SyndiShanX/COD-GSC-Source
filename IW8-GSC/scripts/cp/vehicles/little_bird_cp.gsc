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

function little_bird_cp_create(var0) {
  var0.maxhealth = 2500;
  var0.health = var0.maxhealth;
  var0.vehicle_specific_onentervehicle = &little_bird_cp_onentervehicle;
  var0.vehicle_specific_onexitvehicle = &little_bird_cp_onexitvehicle;
  var1 = var0 getentitynumber();
  addtolittlebirdlist(var0, var1);
  thread removefromlittlebirdlistondeath(var0);
}

function little_bird_cp_initlate() {
  if(true) {
    return;
  }

  level.littlebirds = [];
  var0 = scripts\engine\utility::getStructArray("littlebird_spawn", "targetname");
  thread little_bird_cp_createfromstructs(var0, 3);
}

function little_bird_cp_createfromstructs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var5);

      if(isDefined(var6)) {
        level.littlebirds = scripts\engine\utility::array_add(level.littlebirds, var6);
      }
    }
  }

  level notify("little_birds_done_spawning");
}

function spawn_little_bird_at_location(var0, var1, var2, var3) {
  var4 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var0, var1, undefined, var2);

  if(istrue(var3)) {
    return var4;
  }
}

function spawn_and_enter_little_bird(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "pilot", var0, undefined, 1);
    return;
  }
}

function little_bird_cp_onentervehicle(var0, var1, var2, var3) {}

function little_bird_cp_onexitvehicle(var0, var1, var2, var3) {}

function addtolittlebirdlist(var0) {
  if(!isDefined(level.littlebirds)) {
    level.littlebirds = [];
  }

  level.littlebirds[var0] = self;
}

function removefromlittlebirdlistondeath(var0) {
  self waittill("death");
  level.littlebirds[var0] = undefined;
}

function little_bird_cp_spawncallback(var0, var1) {
  if(true) {
    return;
  }

  var2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &little_bird_cp_ondeathrespawncallback;
  }

  return var2;
}

function little_bird_cp_ondeathrespawncallback() {
  thread little_bird_cp_waitandspawn();
}

function little_bird_cp_waitandspawn() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("little_bird")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}