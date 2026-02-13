/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2746.gsc
*************************************************/

_id_FFA7() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("van", "spawnCallback", ::_id_FFAB);
  _id_FFA8();
  _id_FFA9();
  _id_0AC1::_id_1022A("van", _id_09DC::_id_FF8B);
}

_id_FFA9() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("van", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_FFA8() {
  var_0 = _id_09E2::_id_10144("van", 1);
  var_0._id_5FDC = 117;
  var_0._id_2093 = 105;
  var_0._id_919A = 42;
  var_0._id_C862 = 42;
  var_0._id_2954 = 12;
  var_0._id_4B96 = 27;
  var_0._id_98A0 = (0, 0, 55);
}

_id_FFAB(var_0, var_1) {
  var_2 = _id_09DC::_id_FF81(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_FFAA;
  }

  return var_2;
}

_id_FFAA() {
  thread _id_FFAC();
}

_id_FFAC() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("van", var_1, var_2);
}