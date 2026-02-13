/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1882.gsc
*************************************************/

_id_826C() {
  _id_D66E(0);
}

_id_FD00() {
  self setclientomnvar("zm_salvage", int(_id_6C5D()));
}

_id_6C5D() {
  return self._id_A38A;
}

_id_D66E(var_0) {
  self._id_A38A = int(var_0);
  _id_FD00();
}

_id_6FCE(var_0, var_1) {
  var_2 = var_0 * _id_0945::_id_664E("salvage_pickup_value");
  self._id_A38A = self._id_A38A + var_2;
  _id_FD00();
  scripts\cp\telemetry_cp::logevent_salvageearned(self, var_2, var_1);
}

_id_EDD0(var_0) {
  self._id_A38A = self._id_A38A - var_0;
  _id_FD00();
}