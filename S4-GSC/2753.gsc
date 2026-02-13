/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2753.gsc
*************************************************/

_id_1022A(var_0, var_1) {
  var_2 = _id_10226();
  var_2._id_AD13[var_0] = var_1;
}

_id_10229(var_0) {
  scripts\mp\outofbounds::_id_C259(var_0, "vehicle");
}

_id_10221(var_0) {
  scripts\mp\outofbounds::_id_4801(var_0);
}

_id_10220(var_0, var_1) {
  scripts\mp\outofbounds::_id_3964(var_0, var_1);
}

_id_10227() {
  var_0 = spawnStruct();
  var_0._id_AD13 = [];
  level.vehicle._id_ABE3 = var_0;
  scripts\mp\outofbounds::_id_C292("vehicle", ::_id_10222);
  scripts\mp\outofbounds::_id_C293("vehicle", ::_id_10224);
  scripts\mp\outofbounds::_id_C294("vehicle", ::_id_10228);
  scripts\mp\outofbounds::_id_C291("vehicle", ::_id_1021F);
}

_id_10226() {
  return level.vehicle._id_ABE3;
}

_id_10222(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

  foreach(var_5 in var_3) {
    _id_10223(var_5, undefined, undefined, var_2);
  }
}

_id_10223(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.gametype == "arm" && isDefined(var_3) && var_3 == "restricted") {
    var_4 = 2;
  }

  var_0 setclientomnvar("ui_out_of_bounds_type", var_4);
  var_0 setclientomnvar("ui_out_of_bounds_countdown", self._id_ABE6);
}

_id_10224(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

  foreach(var_5 in var_3) {
    _id_10225(var_5);
  }
}

_id_10225(var_0, var_1, var_2, var_3) {
  var_0 scripts\mp\outofbounds::_id_B6A5(var_1, var_2, var_3);
}

_id_10228(var_0, var_1) {
  var_2 = _id_10226();
  var_3 = var_2._id_AD13[self._id_1031E];
  self[[var_3]]();
}

_id_1021F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

  foreach(var_2 in var_0) {
    var_2 setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}