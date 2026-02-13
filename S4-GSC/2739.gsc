/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2739.gsc
*************************************************/

_id_8EDB() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "spawnCallback", ::_id_8EDF);
  _id_8EDC();
  _id_8EDD();
  _id_0AC1::_id_1022A("large_transport", _id_09D5::_id_8ECE);
}

_id_8EDD() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("large_transport", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_8EDC() {
  var_0 = _id_09E2::_id_10144("large_transport", 1);
  var_0._id_5FDC = 100;
  var_0._id_2093 = 112;
  var_0._id_919A = 51;
  var_0._id_C862 = 51;
  var_0._id_2954 = 38;
  var_0._id_4B96 = 53;
  var_0._id_98A0 = (0, 0, 60);
}

_id_8EDF(var_0, var_1) {
  var_2 = _id_09D5::_id_8EC7(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_8EDE;
  }

  return var_2;
}

_id_8EDE() {
  thread _id_8EE0();
}

_id_8EE0() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("large_transport", var_1, var_2);
}