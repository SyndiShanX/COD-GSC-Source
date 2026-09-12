/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\pickup_truck_mp.gsc
***************************************************/

function pickup_truck_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "spawnCallback", &pickup_truck_mp_spawncallback);
  pickup_truck_mp_initmines();
  pickup_truck_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("pickup_truck", &scripts\cp_mp\vehicles\pickup_truck::pickup_truck_explode);
}

function pickup_truck_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("pickup_truck", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function pickup_truck_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("pickup_truck", 1);
  var_0.frontextents = 110;
  var_0.backextents = 112;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 25;
  var_0.distancetobottom = 40;
  var_0.loscheckoffset = (0, 0, 55);
}

function pickup_truck_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &pickup_truck_mp_ondeathrespawncallback;
  }

  return var_2;
}

function pickup_truck_mp_ondeathrespawncallback() {
  thread pickup_truck_mp_waitandspawn();
}

function pickup_truck_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("pickup_truck", var_1, var_2);
}