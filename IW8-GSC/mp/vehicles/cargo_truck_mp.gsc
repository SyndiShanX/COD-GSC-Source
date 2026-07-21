/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\cargo_truck_mp.gsc
***********************************************/

cargo_truck_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::cargo_truck_mp_spawncallback);
  cargo_truck_mp_initmines();
  cargo_truck_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode);
}

cargo_truck_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

cargo_truck_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

cargo_truck_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::cargo_truck_mp_ondeathrespawncallback;

  return var_2;
}

cargo_truck_mp_ondeathrespawncallback() {
  thread cargo_truck_mp_waitandspawn();
}

cargo_truck_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", var_1, var_2);
}