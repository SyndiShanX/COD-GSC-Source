/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\pickup_truck_mp.gsc
***********************************************/

pickup_truck_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::pickup_truck_mp_spawncallback);
  pickup_truck_mp_initmines();
  pickup_truck_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_8FD60D6AA0EAB34083F7C423A0213B", scripts\cp_mp\vehicles\pickup_truck::pickup_truck_explode);
}

pickup_truck_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

pickup_truck_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1);
  var_0.frontextents = 110;
  var_0.backextents = 112;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 25;
  var_0.distancetobottom = 40;
  var_0.loscheckoffset = (0, 0, 55);
}

pickup_truck_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::pickup_truck_mp_ondeathrespawncallback;

  return var_2;
}

pickup_truck_mp_ondeathrespawncallback() {
  thread pickup_truck_mp_waitandspawn();
}

pickup_truck_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_8FD60D6AA0EAB34083F7C423A0213B", var_1, var_2);
}