/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2742.gsc
*************************************************/

_id_9CF9() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "spawnCallback", ::_id_9CFD);
  _id_9CFA();
  _id_9CFB();
  _id_0AC1::_id_1022A("medium_transport", _id_09D8::_id_9CEC);
}

_id_9CFB() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("medium_transport", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_9CFA() {
  var_0 = _id_09E2::_id_10144("medium_transport", 1);
  var_0._id_5FDC = 100;
  var_0._id_2093 = 102;
  var_0._id_919A = 38;
  var_0._id_C862 = 38;
  var_0._id_2954 = 20;
  var_0._id_4B96 = 35;
  var_0._id_98A0 = (0, 0, 55);
}

_id_9CFD(var_0, var_1) {
  var_2 = _id_09D8::_id_9CE5(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_9CFC;
  }

  return var_2;
}

_id_9CFC() {
  thread _id_9CFE();
}

_id_9CFE() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("medium_transport", var_1, var_2);
}