/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1380.gsc
**************************************/

_id_42C5() {
  _id_4232();
  var_0 = self._id_0B6E._id_41D0._id_41D1["color"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_0, "color_friendly");
  var_0 = self._id_0B6E._id_41D0._id_41D1["color"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_0, "color_friendly");
}

_id_42C6() {
  maps\_utility::_id_123B();
  self.fixednode = 0;
}

_id_42C7() {
  maps\_utility::_id_2686();
}

_id_4232() {
  _id_42CA();
  self._id_0B6E._id_423A._id_42C8 = 1;
}

_id_42C9(var_0) {
  foreach(var_3, var_2 in var_0) {}
  maps\_stealth_shared_utilities::_id_41CF("color", var_3, var_2);

  var_4 = self._id_0B6E._id_41D0._id_41D1["color"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_4, "color_friendly");
  var_4 = self._id_0B6E._id_41D0._id_41D1["color"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_4, "color_friendly");
}

_id_42CA() {
  var_0 = [];
  var_0["hidden"] = ::_id_42C6;
  var_0["spotted"] = ::_id_42C7;
  _id_42C9(var_0);
}