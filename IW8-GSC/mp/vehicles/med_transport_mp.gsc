/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\med_transport_mp.gsc
***********************************************/

med_transport_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::med_transport_mp_spawncallback);
  med_transport_mp_initmines();
  med_transport_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", scripts\cp_mp\vehicles\med_transport::med_transport_explode);
}

med_transport_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

med_transport_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 1);
  var_0.frontextents = 100;
  var_0.backextents = 102;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
  var_0.loscheckoffset = (0, 0, 55);
}

med_transport_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\med_transport::med_transport_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::med_transport_mp_ondeathrespawncallback;

  return var_2;
}

med_transport_mp_ondeathrespawncallback() {
  thread med_transport_mp_waitandspawn();
}

med_transport_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_1, var_2);
}