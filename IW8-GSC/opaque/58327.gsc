/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58327.gsc
***********************************************/

_id_11D6A() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::_id_11D6E);
  _id_11D6B();
  _id_11D6C();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_99C20BA548E9F27A61D897932B", _calloutmarkerping_poolidisentity::_id_11D5D);
}

_id_11D6C() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_99C20BA548E9F27A61D897932B", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

_id_11D6B() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_99C20BA548E9F27A61D897932B", 1);
  var_0.frontextents = 45;
  var_0.backextents = 45;
  var_0.leftextents = 28;
  var_0.rightextents = 28;
  var_0.bottomextents = 15;
  var_0.distancetobottom = 30;
  var_0.loscheckoffset = (0, 0, 30);
}

_id_11D6E(var_0, var_1) {
  var_2 = _calloutmarkerping_poolidisentity::_id_11D56(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::_id_11D6D;

  return var_2;
}

_id_11D6D() {
  thread _id_11D6F();
}

_id_11D6F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_99C20BA548E9F27A61D897932B", var_1, var_2);
}