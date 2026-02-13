/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2733.gsc
*************************************************/

_id_328E() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "spawnCallback", ::_id_3293);
  _id_3290();
  _id_3291();
  _id_0AC1::_id_1022A("cargo_truck", _id_09D0::_id_3281);
}

_id_3291() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_3290() {
  var_0 = _id_09E2::_id_10144("cargo_truck", 1);
  var_0._id_5FDC = 165;
  var_0._id_2093 = 168;
  var_0._id_919A = 57;
  var_0._id_C862 = 57;
  var_0._id_2954 = 35;
  var_0._id_4B96 = 50;
  var_0._id_98A0 = (0, 0, 70);
}

_id_3293(var_0, var_1) {
  var_2 = _id_09D0::_id_327A(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_3292;
  }

  return var_2;
}

_id_3292() {
  thread _id_3294();
}

_id_3294() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("cargo_truck", var_1, var_2);
}