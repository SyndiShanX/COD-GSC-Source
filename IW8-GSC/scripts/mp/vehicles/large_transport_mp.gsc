/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\large_transport_mp.gsc
******************************************************/

function large_transport_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "spawnCallback", &large_transport_mp_spawncallback);
  large_transport_mp_initmines();
  large_transport_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("large_transport", &scripts\cp_mp\vehicles\large_transport::large_transport_explode);
}

function large_transport_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("large_transport", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function large_transport_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("large_transport", 1);
  var_0.frontextents = 100;
  var_0.backextents = 112;
  var_0.leftextents = 51;
  var_0.rightextents = 51;
  var_0.bottomextents = 38;
  var_0.distancetobottom = 53;
  var_0.loscheckoffset = (0, 0, 60);
}

function large_transport_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &large_transport_mp_ondeathrespawncallback;
  }

  return var_2;
}

function large_transport_mp_ondeathrespawncallback() {
  thread large_transport_mp_waitandspawn();
}

function large_transport_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("large_transport", var_1, var_2);
}