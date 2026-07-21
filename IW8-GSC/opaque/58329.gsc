/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58329.gsc
***********************************************/

_id_1210B() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::_id_1210E);
  _id_12127();
  _id_1210C();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_97AE0AF6E0959BEB4D2B95C1", _calloutmarkerping_poolidisloot::_id_12100);
}

_id_1210C() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

_id_12127() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
  var_0.frontextents = 90;
  var_0.backextents = 115;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
  var_0.loscheckoffset = (0, -8, 50);
}

_id_1210E(var_0, var_1) {
  var_2 = _calloutmarkerping_poolidisloot::_id_120F9(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::_id_1210D;

  return var_2;
}

_id_1210D() {
  thread _id_1210F();
}

_id_1210F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_97AE0AF6E0959BEB4D2B95C1", var_1, var_2);
}