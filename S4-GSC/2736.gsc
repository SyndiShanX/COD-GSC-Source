/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2736.gsc
*************************************************/

_id_7A08() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "spawnCallback", ::_id_7A0C);
  _id_7A09();
  _id_7A0A();
  _id_0AAF::_id_D42B("hoopty", 6);
  _id_0AAF::_id_D1AC("hoopty", _id_09D2::_id_79F5);
  _id_0AC1::_id_1022A("hoopty", _id_09D2::_id_79FB);
}

_id_7A0A() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("hoopty", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_7A09() {
  var_0 = _id_09E2::_id_10144("hoopty", 1);
  var_0._id_5FDC = 90;
  var_0._id_2093 = 115;
  var_0._id_919A = 38;
  var_0._id_C862 = 38;
  var_0._id_2954 = 20;
  var_0._id_4B96 = 35;
  var_0._id_98A0 = (0, 0, 37);
}

_id_7A0C(var_0, var_1) {
  var_2 = _id_09D2::_id_79F4(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_7A0B;
  }

  return var_2;
}

_id_7A0B() {
  thread _id_7A0D();
}

_id_7A0D() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("hoopty", var_1, var_2);
}