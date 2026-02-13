/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2743.gsc
*************************************************/

_id_B0A0() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "spawnCallback", ::_id_B0A4);
  _id_B0A1();
  _id_B0A2();
  _id_0AC1::_id_1022A("pickup_truck", _id_09D9::_id_B093);
}

_id_B0A2() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("pickup_truck", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_B0A1() {
  var_0 = _id_09E2::_id_10144("pickup_truck", 1);
  var_0._id_5FDC = 110;
  var_0._id_2093 = 112;
  var_0._id_919A = 38;
  var_0._id_C862 = 38;
  var_0._id_2954 = 25;
  var_0._id_4B96 = 40;
  var_0._id_98A0 = (0, 0, 55);
}

_id_B0A4(var_0, var_1) {
  var_2 = _id_09D9::_id_B08C(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_B0A3;
  }

  return var_2;
}

_id_B0A3() {
  thread _id_B0A5();
}

_id_B0A5() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("pickup_truck", var_1, var_2);
}