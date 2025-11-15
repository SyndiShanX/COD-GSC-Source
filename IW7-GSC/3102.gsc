/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3102.gsc
***************************************/

func_BE5C(var_00) {
  func_09FF::bt_nativeregisterbehavior(var_00 + "escape_native_api_Escape", "sequence", [var_00 + "Not_jk_hasSpline4", "negate", var_00 + "jk_findAndSetGoal::fnArgsNative04", "action", var_00 + "jk_setBoostMode::fnArgsNative14", "action", var_00 + "jk_setGoalRadius::fnArgsNative24", "action", var_00 + "jk_setFireMode::fnArgsNative34", "action", var_00 + "jk_waitForGoal4", "action", var_00 + "jk_setOrientMode::fnArgsNative14", "action"], 4);
  func_09FF::bt_nativeregisteraction(var_00 + "jk_hasSpline4", func_0A0D::func_8C2C, undefined, undefined, undefined, 4);
  func_09FF::bt_nativeregisteraction(var_00 + "jk_findAndSetGoal::fnArgsNative04", func_0A0D::func_6CAB, ::func_7180, undefined, undefined, 4);
  func_09FF::bt_nativeregisteraction(var_00 + "jk_setBoostMode::fnArgsNative14", func_0A0D::func_F672, ::func_7181, undefined, undefined, 4);
  func_09FF::bt_nativeregisteraction(var_00 + "jk_setGoalRadius::fnArgsNative24", func_0A0D::func_F72A, ::func_7182, undefined, undefined, 4);
  func_09FF::bt_nativeregisteraction(var_00 + "jk_setFireMode::fnArgsNative34", func_0A0D::func_F706, ::func_7183, undefined, undefined, 4);
  func_09FF::bt_nativeregisteraction(var_00 + "jk_waitForGoal4", func_0A0D::func_136C0, undefined, func_0A0D::func_98E0, func_0A0D::func_11704, 4);
  func_09FF::bt_nativeregisteraction(var_00 + "jk_setOrientMode::fnArgsNative14", func_0A0D::func_F7C9, ::func_7181, undefined, undefined, 4);
  func_09FF::bt_nativeregisterbehavior(var_00 + "Not_jk_hasSpline4", "negate", [var_00 + "jk_hasSpline4", "action"], 4);
}

func_7180() {
  var_00 = [];
  var_0[0] = "escape";
  return var_00;
}

func_7181() {
  var_00 = [];
  var_0[0] = "face motion";
  return var_00;
}

func_7182() {
  var_00 = [];
  var_0[0] = 2048;
  return var_00;
}

func_7183() {
  var_00 = [];
  var_0[0] = "shoot_at_will";
  return var_00;
}