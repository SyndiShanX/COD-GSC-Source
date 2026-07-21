/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\little_bird_cp.gsc
***********************************************/

little_bird_cp_init() {
  scripts\engine\utility::create_func_ref("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", ::spawn_and_enter_little_bird);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_8AEA073693CA16D12B", ::little_bird_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_BAF609D2739647C4853A2B", ::little_bird_cp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::little_bird_cp_spawncallback);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", scripts\cp_mp\vehicles\little_bird::little_bird_explode);
}

little_bird_cp_create(var_0) {
  var_0.maxhealth = 2500;
  var_0.health = var_0.maxhealth;
  var_0.vehicle_specific_onentervehicle = ::little_bird_cp_onentervehicle;
  var_0.vehicle_specific_onexitvehicle = ::little_bird_cp_onexitvehicle;
  var_1 = var_0 getentitynumber();
  var_0 addtolittlebirdlist(var_1);
  var_0 thread removefromlittlebirdlistondeath(var_1);
}

little_bird_cp_initlate() {
  if(1) {
    return;
  }
  level.littlebirds = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_827911362D47E8C6CA26A539197D37C116DD37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread little_bird_cp_createfromstructs(var_0, 3);
}

little_bird_cp_createfromstructs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_5);

      if(isDefined(var_6))
        level.littlebirds = scripts\engine\utility::array_add(level.littlebirds, var_6);
    }
  }

  level notify("_encstr_BD8C1BC56B09A384410973A7989953D9F1F0CD3FD86F9BD12BA857B318");
}

spawn_little_bird_at_location(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_0, var_1, undefined, var_2);

  if(istrue(var_3))
    return var_4;
}

spawn_and_enter_little_bird(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_A266062032BD7723", var_0, undefined, 1);
}

little_bird_cp_onentervehicle(var_0, var_1, var_2, var_3) {}

little_bird_cp_onexitvehicle(var_0, var_1, var_2, var_3) {}

addtolittlebirdlist(var_0) {
  if(!isDefined(level.littlebirds))
    level.littlebirds = [];

  level.littlebirds[var_0] = self;
}

removefromlittlebirdlistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.littlebirds[var_0] = undefined;
}

little_bird_cp_spawncallback(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::little_bird_cp_ondeathrespawncallback;

  return var_2;
}

little_bird_cp_ondeathrespawncallback() {
  thread little_bird_cp_waitandspawn();
}

little_bird_cp_waitandspawn() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_9A8F0CB1A5E8471BB2EB894B39C8")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}