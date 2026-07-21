/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\van_mp.gsc
***********************************************/

van_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_911904464232", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::van_mp_spawncallback);
  van_mp_initmines();
  van_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_911904464232", scripts\cp_mp\vehicles\van::van_explode);
}

van_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_911904464232", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

van_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_911904464232", 1);
  var_0.frontextents = 117;
  var_0.backextents = 105;
  var_0.leftextents = 42;
  var_0.rightextents = 42;
  var_0.bottomextents = 12;
  var_0.distancetobottom = 27;
  var_0.loscheckoffset = (0, 0, 55);
}

van_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\van::van_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::van_mp_ondeathrespawncallback;

  return var_2;
}

van_mp_ondeathrespawncallback() {
  thread van_mp_waitandspawn();
}

van_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_911904464232", var_1, var_2);
}