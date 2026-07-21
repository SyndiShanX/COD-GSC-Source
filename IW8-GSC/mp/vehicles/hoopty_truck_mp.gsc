/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\hoopty_truck_mp.gsc
***********************************************/

hoopty_truck_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::hoopty_truck_mp_spawncallback);
  hoopty_truck_mp_initmines();
  hoopty_truck_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_8BAA0D68183D43A35319057A93B767", scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_explode);
}

hoopty_truck_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8BAA0D68183D43A35319057A93B767", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

hoopty_truck_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_8BAA0D68183D43A35319057A93B767", 1);
  var_0.frontextents = 69;
  var_0.backextents = 102;
  var_0.leftextents = 30;
  var_0.rightextents = 30;
  var_0.bottomextents = 22;
  var_0.distancetobottom = 37;
  var_0.loscheckoffset = (0, 0, 55);
}

hoopty_truck_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::hoopty_truck_mp_ondeathrespawncallback;

  return var_2;
}

hoopty_truck_mp_ondeathrespawncallback() {
  thread hoopty_truck_mp_waitandspawn();
}

hoopty_truck_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_8BAA0D68183D43A35319057A93B767", var_1, var_2);
}