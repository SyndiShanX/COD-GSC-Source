/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2730.gsc
*************************************************/

_id_1E5C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "spawnCallback", ::_id_1E60);
  _id_1E5D();
  _id_1E5E();
  _id_0AC1::_id_1022A("atv", _id_09CD::_id_1E49);
}

_id_1E5E() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("atv", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_1E5D() {
  var_0 = _id_09E2::_id_10144("atv", 1);
  var_0._id_5FDC = 45;
  var_0._id_2093 = 45;
  var_0._id_919A = 28;
  var_0._id_C862 = 28;
  var_0._id_2954 = 15;
  var_0._id_4B96 = 30;
  var_0._id_98A0 = (0, 0, 30);
}

_id_1E60(var_0, var_1) {
  var_2 = _id_09CD::_id_1E3E(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_1E5F;
  }

  return var_2;
}

_id_1E5F() {
  thread _id_1E61();
}

_id_1E61() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("atv", var_1, var_2);
}