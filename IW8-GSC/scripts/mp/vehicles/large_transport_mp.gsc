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
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("large_transport", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function large_transport_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("large_transport", 1);
  var0.frontextents = 100;
  var0.backextents = 112;
  var0.leftextents = 51;
  var0.rightextents = 51;
  var0.bottomextents = 38;
  var0.distancetobottom = 53;
  var0.loscheckoffset = (0, 0, 60);
}

function large_transport_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &large_transport_mp_ondeathrespawncallback;
  }

  return var2;
}

function large_transport_mp_ondeathrespawncallback() {
  thread large_transport_mp_waitandspawn();
}

function large_transport_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("large_transport", var1, var2);
}