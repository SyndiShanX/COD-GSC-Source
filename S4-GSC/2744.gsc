/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2744.gsc
*************************************************/

_id_ECDD() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "spawnCallback", ::_id_ECE0);
  _id_ED25();
  _id_ECDE();
  _id_0AC1::_id_1022A("tac_rover", _id_09DA::_id_ECD0);
}

_id_ECDE() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("tac_rover", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_ED25() {
  var_0 = _id_09E2::_id_10144("tac_rover", 1);
  var_0._id_5FDC = 90;
  var_0._id_2093 = 115;
  var_0._id_919A = 38;
  var_0._id_C862 = 38;
  var_0._id_2954 = 20;
  var_0._id_4B96 = 35;
  var_0._id_98A0 = (0, -8, 50);
}

_id_ECE0(var_0, var_1) {
  var_2 = _id_09DA::_id_ECC9(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_ECDF;
  }

  return var_2;
}

_id_ECDF() {
  thread _id_ECE1();
}

_id_ECE1() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("tac_rover", var_1, var_2);
}