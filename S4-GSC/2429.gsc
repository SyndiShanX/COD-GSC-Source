/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2429.gsc
*************************************************/

_id_1021E(var_0, var_1) {
  var_2 = _id_1021A();
  var_2._id_AD13[var_0] = var_1;
}

_id_1021D(var_0) {
  scripts\cp\cp_outofbounds::_id_C259(var_0, "vehicle");
}

_id_10215(var_0) {
  scripts\cp\cp_outofbounds::_id_4801(var_0);
}

_id_10214(var_0, var_1) {
  scripts\cp\cp_outofbounds::_id_3964(var_0, var_1);
}

_id_1021B() {
  var_0 = spawnStruct();
  var_0._id_AD13 = [];
  level.vehicle._id_ABE3 = var_0;
  scripts\cp\cp_outofbounds::_id_C292("vehicle", ::_id_10216);
  scripts\cp\cp_outofbounds::_id_C293("vehicle", ::_id_10218);
  scripts\cp\cp_outofbounds::_id_C294("vehicle", ::_id_1021C);
  scripts\cp\cp_outofbounds::_id_C291("vehicle", ::_id_10213);
}

_id_1021A() {
  return level.vehicle._id_ABE3;
}

_id_10216(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

  foreach(var_4 in var_2) {
    _id_10217(var_4);
  }
}

_id_10217(var_0, var_1, var_2) {
  var_0 setclientomnvar("ui_out_of_bounds_countdown", self._id_ABE6);
}

_id_10218(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

  foreach(var_5 in var_3) {
    _id_10219(var_5);
  }
}

_id_10219(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("ui_out_of_bounds_countdown", 0);
}

_id_1021C(var_0, var_1) {
  var_2 = _id_1021A();
  var_3 = var_2._id_AD13[self._id_1031E];
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

  foreach(var_6 in var_4) {
    var_6._id_DBD8 = 1;
  }

  self[[var_3]]();
}

_id_10213() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

  foreach(var_2 in var_0) {
    var_2 setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}