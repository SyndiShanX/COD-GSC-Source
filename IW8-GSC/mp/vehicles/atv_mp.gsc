/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\atv_mp.gsc
***********************************************/

atv_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C190467402B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::atv_mp_spawncallback);
  atv_mp_initmines();
  atv_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_8C190467402B", scripts\cp_mp\vehicles\atv::atv_explode);
}

atv_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8C190467402B", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

atv_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_8C190467402B", 1);
  var_0.frontextents = 45;
  var_0.backextents = 45;
  var_0.leftextents = 28;
  var_0.rightextents = 28;
  var_0.bottomextents = 15;
  var_0.distancetobottom = 30;
  var_0.loscheckoffset = (0, 0, 30);
}

atv_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\atv::atv_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::atv_mp_ondeathrespawncallback;

  return var_2;
}

atv_mp_ondeathrespawncallback() {
  thread atv_mp_waitandspawn();
}

atv_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_8C190467402B", var_1, var_2);
}