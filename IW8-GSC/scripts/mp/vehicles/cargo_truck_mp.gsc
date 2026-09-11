/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\cargo_truck_mp.gsc
**************************************************/

function cargo_truck_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "spawnCallback", &cargo_truck_mp_spawncallback);
  cargo_truck_mp_initmines();
  cargo_truck_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("cargo_truck", &scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode);
}

function cargo_truck_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function cargo_truck_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cargo_truck", 1);
  var0.frontextents = 165;
  var0.backextents = 168;
  var0.leftextents = 57;
  var0.rightextents = 57;
  var0.bottomextents = 35;
  var0.distancetobottom = 50;
  var0.loscheckoffset = (0, 0, 70);
}

function cargo_truck_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &cargo_truck_mp_ondeathrespawncallback;
  }

  return var2;
}

function cargo_truck_mp_ondeathrespawncallback() {
  thread cargo_truck_mp_waitandspawn();
}

function cargo_truck_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("cargo_truck", var1, var2);
}