/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3102.gsc
**************************************/

_id_BE5C(var_0) {
  _id_09FF::bt_nativeregisterbehavior(var_0 + "escape_native_api_Escape", "sequence", [var_0 + "Not_jk_hasSpline4", "negate", var_0 + "jk_findAndSetGoal::fnArgsNative04", "action", var_0 + "jk_setBoostMode::fnArgsNative14", "action", var_0 + "jk_setGoalRadius::fnArgsNative24", "action", var_0 + "jk_setFireMode::fnArgsNative34", "action", var_0 + "jk_waitForGoal4", "action", var_0 + "jk_setOrientMode::fnArgsNative14", "action"], 4);
  _id_09FF::bt_nativeregisteraction(var_0 + "jk_hasSpline4", _id_0A0D::_id_8C2C, undefined, undefined, undefined, 4);
  _id_09FF::bt_nativeregisteraction(var_0 + "jk_findAndSetGoal::fnArgsNative04", _id_0A0D::_id_6CAB, ::_id_7180, undefined, undefined, 4);
  _id_09FF::bt_nativeregisteraction(var_0 + "jk_setBoostMode::fnArgsNative14", _id_0A0D::_id_F672, ::_id_7181, undefined, undefined, 4);
  _id_09FF::bt_nativeregisteraction(var_0 + "jk_setGoalRadius::fnArgsNative24", _id_0A0D::_id_F72A, ::_id_7182, undefined, undefined, 4);
  _id_09FF::bt_nativeregisteraction(var_0 + "jk_setFireMode::fnArgsNative34", _id_0A0D::_id_F706, ::_id_7183, undefined, undefined, 4);
  _id_09FF::bt_nativeregisteraction(var_0 + "jk_waitForGoal4", _id_0A0D::_id_136C0, undefined, _id_0A0D::_id_98E0, _id_0A0D::_id_11704, 4);
  _id_09FF::bt_nativeregisteraction(var_0 + "jk_setOrientMode::fnArgsNative14", _id_0A0D::_id_F7C9, ::_id_7181, undefined, undefined, 4);
  _id_09FF::bt_nativeregisterbehavior(var_0 + "Not_jk_hasSpline4", "negate", [var_0 + "jk_hasSpline4", "action"], 4);
}

_id_7180() {
  var_0 = [];
  var_0[0] = "escape";
  return var_0;
}

_id_7181() {
  var_0 = [];
  var_0[0] = "face motion";
  return var_0;
}

_id_7182() {
  var_0 = [];
  var_0[0] = 2048;
  return var_0;
}

_id_7183() {
  var_0 = [];
  var_0[0] = "shoot_at_will";
  return var_0;
}