/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2737.gsc
*************************************************/

_id_7A2C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty_truck", "spawnCallback", ::_id_7A30);
  _id_7A2D();
  _id_7A2E();
  _id_0AC1::_id_1022A("hoopty_truck", _id_09D3::_id_7A1F);
}

_id_7A2E() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("hoopty_truck", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_7A2D() {
  var_0 = _id_09E2::_id_10144("hoopty_truck", 1);
  var_0._id_5FDC = 69;
  var_0._id_2093 = 102;
  var_0._id_919A = 30;
  var_0._id_C862 = 30;
  var_0._id_2954 = 22;
  var_0._id_4B96 = 37;
  var_0._id_98A0 = (0, 0, 55);
}

_id_7A30(var_0, var_1) {
  var_2 = _id_09D3::_id_7A18(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_7A2F;
  }

  return var_2;
}

_id_7A2F() {
  thread _id_7A31();
}

_id_7A31() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("hoopty_truck", var_1, var_2);
}