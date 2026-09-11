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
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("pickup_truck", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function pickup_truck_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("pickup_truck", 1);
  var0.frontextents = 110;
  var0.backextents = 112;
  var0.leftextents = 38;
  var0.rightextents = 38;
  var0.bottomextents = 25;
  var0.distancetobottom = 40;
  var0.loscheckoffset = (0, 0, 55);
}

function pickup_truck_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &pickup_truck_mp_ondeathrespawncallback;
  }

  return var2;
}

function pickup_truck_mp_ondeathrespawncallback() {
  thread pickup_truck_mp_waitandspawn();
}

function pickup_truck_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("pickup_truck", var1, var2);
}