/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2745.gsc
*************************************************/

_id_EFFA() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "spawnCallback", ::_id_EFFE);
  _id_EFFB();
  _id_0AC1::_id_1022A("technical", _id_09DB::_id_EFE6);
}

_id_EFFC() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("technical", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

_id_EFFB() {
  var_0 = _id_09E2::_id_10144("technical", 1);
  var_0._id_5FDC = 90;
  var_0._id_2093 = 115;
  var_0._id_919A = 38;
  var_0._id_C862 = 38;
  var_0._id_2954 = 20;
  var_0._id_4B96 = 35;
  var_0._id_98A0 = (0, 0, 37);
}

_id_EFFE(var_0, var_1) {
  var_2 = _id_09DB::_id_EFD9(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_EFFD;
  }

  return var_2;
}

_id_EFFD() {
  thread _id_EFFF();
}

_id_EFFF() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_1._id_C189 = var_0._id_C189;
  var_1._id_BFC5 = var_0._id_BFC5;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("technical", var_1, var_2);

  if(isDefined(var_3)) {
    if(isDefined(var_1._id_C189) && istrue(level._id_FEAF) && level._id_FEAF != 2) {
      var_3._id_C189 = var_1._id_C189;
      var_3.maxhealth = int(max(var_3.maxhealth, var_1._id_BFC5));
      var_3.health = var_3.maxhealth;
      _id_0808::_id_BFC7(var_3);
    }
  }
}