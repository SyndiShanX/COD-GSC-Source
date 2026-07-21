/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\large_transport_mp.gsc
***********************************************/

large_transport_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::large_transport_mp_spawncallback);
  large_transport_mp_initmines();
  large_transport_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", scripts\cp_mp\vehicles\large_transport::large_transport_explode);
}

large_transport_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

large_transport_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 1);
  var_0.frontextents = 100;
  var_0.backextents = 112;
  var_0.leftextents = 51;
  var_0.rightextents = 51;
  var_0.bottomextents = 38;
  var_0.distancetobottom = 53;
  var_0.loscheckoffset = (0, 0, 60);
}

large_transport_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\large_transport::large_transport_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::large_transport_mp_ondeathrespawncallback;

  return var_2;
}

large_transport_mp_ondeathrespawncallback() {
  thread large_transport_mp_waitandspawn();
}

large_transport_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_1, var_2);
}