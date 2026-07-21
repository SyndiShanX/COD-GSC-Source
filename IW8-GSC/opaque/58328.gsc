/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58328.gsc
***********************************************/

_id_120DC() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::_id_120E0);
  _id_120DD();
  _id_120DE();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", _calloutmarkerping_predicted_isanypingactive::_id_120CB);
}

_id_120DE() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

_id_120DD() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
  var_0.frontextents = 98;
  var_0.backextents = 89;
  var_0.leftextents = 36;
  var_0.rightextents = 36;
  var_0.bottomextents = 23;
  var_0.distancetobottom = 38;
  var_0.loscheckoffset = (0, 0, 55);
}

_id_120E0(var_0, var_1) {
  var_2 = _calloutmarkerping_predicted_isanypingactive::_id_120C1(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::_id_120DF;

  return var_2;
}

_id_120DF() {
  thread _id_120E1();
}

_id_120E1() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", var_1, var_2);
}