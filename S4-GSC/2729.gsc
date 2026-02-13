/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2729.gsc
*************************************************/

_id_1996() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "spawnCallback", ::_id_199A);
  _id_1997();
  _id_1998();
  _id_0AC1::_id_1022A("apc_russian", _id_09CC::_id_1986);
}

_id_1998() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("apc_russian", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
  var_0._id_0E02 = 180;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_0._id_C69E = level._id_19A8;
  }
}

_id_1997() {
  var_0 = _id_09E2::_id_10144("apc_russian", 1);
  var_0._id_5FDC = 115;
  var_0._id_2093 = 110;
  var_0._id_919A = 61;
  var_0._id_C862 = 61;
  var_0._id_2954 = 25;
  var_0._id_4B96 = 40;
  var_0._id_98A0 = (0, 0, 50);
}

_id_199A(var_0, var_1) {
  var_2 = _id_09CC::_id_197B(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_1999;
  }

  return var_2;
}

_id_1999() {
  thread _id_199B();
}

_id_199B() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_1._id_C189 = var_0._id_C189;
  var_1._id_BFC5 = var_0._id_BFC5;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("apc_russian", var_1, var_2);

  if(isDefined(var_3)) {
    if(isDefined(var_1._id_C189) && istrue(level._id_FEAF) && level._id_FEAF != 2) {
      var_3._id_C189 = var_1._id_C189;
      var_3.maxhealth = int(max(var_3.maxhealth, var_1._id_BFC5));
      var_3.health = var_3.maxhealth;
      _id_0808::_id_BFC7(var_3);
    }
  }
}