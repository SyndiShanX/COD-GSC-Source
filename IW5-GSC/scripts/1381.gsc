/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1381.gsc
**************************************/

_id_42CB() {
  _id_4232();
  var_0 = self._id_0B6E._id_41D0._id_41D1["accuracy"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_0, "accuracy_friendly");
  var_0 = self._id_0B6E._id_41D0._id_41D1["accuracy"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_0, "accuracy_friendly");
}

_id_42CC() {
  self._id_20AF = self._id_0B6E._id_41D0._id_42CD;
  self.accuracy = self._id_0B6E._id_41D0._id_42CD;
}

_id_42CE() {
  self._id_20AF = self._id_0B6E._id_41D0._id_42CF;
  self.accuracy = self._id_0B6E._id_41D0._id_42D0;
}

_id_4232() {
  self._id_0B6E._id_41D0._id_42CD = 50;
  self._id_0B6E._id_41D0._id_42CF = self._id_20AF;
  self._id_0B6E._id_41D0._id_42D0 = self.accuracy;
  _id_42D3();
  self._id_0B6E._id_423A._id_42D1 = 1;
}

_id_42D2(var_0) {
  foreach(var_3, var_2 in var_0) {}
  maps\_stealth_shared_utilities::_id_41CF("accuracy", var_3, var_2);

  var_4 = self._id_0B6E._id_41D0._id_41D1["accuracy"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_4, "accuracy_friendly");
  var_4 = self._id_0B6E._id_41D0._id_41D1["accuracy"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_4, "accuracy_friendly");
}

_id_42D3() {
  var_0 = [];
  var_0["hidden"] = ::_id_42CC;
  var_0["spotted"] = ::_id_42CE;
  _id_42D2(var_0);
}