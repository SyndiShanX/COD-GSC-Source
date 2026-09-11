/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\med_transport_mp.gsc
****************************************************/

function med_transport_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "spawnCallback", &med_transport_mp_spawncallback);
  med_transport_mp_initmines();
  med_transport_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("medium_transport", &scripts\cp_mp\vehicles\med_transport::med_transport_explode);
}

function med_transport_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("medium_transport", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function med_transport_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("medium_transport", 1);
  var0.frontextents = 100;
  var0.backextents = 102;
  var0.leftextents = 38;
  var0.rightextents = 38;
  var0.bottomextents = 20;
  var0.distancetobottom = 35;
  var0.loscheckoffset = (0, 0, 55);
}

function med_transport_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &med_transport_mp_ondeathrespawncallback;
  }

  return var2;
}

function med_transport_mp_ondeathrespawncallback() {
  thread med_transport_mp_waitandspawn();
}

function med_transport_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("medium_transport", var1, var2);
}