/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2734.gsc
*************************************************/

_id_3D43() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "spawnCallback", ::_id_3D47);
  _id_3D44();
  _id_3D45();
  _id_0AC1::_id_1022A("cop_car", _id_09D1::_id_3D36);
}

_id_3D45() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cop_car", 1);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("cop_car");
  var_0.class = "medium_light";
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_3D44() {
  var_0 = _id_09E2::_id_10144("cop_car", 1);
  var_0._id_5FDC = 92;
  var_0._id_2093 = 95;
  var_0._id_919A = 30;
  var_0._id_C862 = 30;
  var_0._id_2954 = 10;
  var_0._id_4B96 = 25;
  var_0._id_98A0 = (0, 0, 37);
}

_id_3D47(var_0, var_1) {
  var_2 = _id_09D1::_id_3D2F(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_3D46;
  }

  return var_2;
}

_id_3D46() {
  thread _id_3D48();
}

_id_3D48() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("cop_car", var_1, var_2);
}