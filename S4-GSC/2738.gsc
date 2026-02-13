/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2738.gsc
*************************************************/

_id_8BC4() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "spawnCallback", ::_id_8BC8);
  _id_8BC5();
  _id_8BC6();
  _id_0AC1::_id_1022A("jeep", _id_09D4::_id_8BB7);
}

_id_8BC6() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("jeep", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_8BC5() {
  var_0 = _id_09E2::_id_10144("jeep", 1);
  var_0._id_5FDC = 98;
  var_0._id_2093 = 89;
  var_0._id_919A = 36;
  var_0._id_C862 = 36;
  var_0._id_2954 = 23;
  var_0._id_4B96 = 38;
  var_0._id_98A0 = (0, 0, 55);
}

_id_8BC8(var_0, var_1) {
  var_2 = _id_09D4::_id_8BB0(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_8BC7;
  }

  return var_2;
}

_id_8BC7() {
  thread _id_8BC9();
}

_id_8BC9() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("jeep", var_1, var_2);
}