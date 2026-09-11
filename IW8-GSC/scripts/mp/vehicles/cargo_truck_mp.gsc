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
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function cargo_truck_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cargo_truck", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

function cargo_truck_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &cargo_truck_mp_ondeathrespawncallback;
  }

  return var_2;
}

function cargo_truck_mp_ondeathrespawncallback() {
  thread cargo_truck_mp_waitandspawn();
}

function cargo_truck_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("cargo_truck", var_1, var_2);
}