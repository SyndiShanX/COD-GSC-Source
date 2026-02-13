/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2503.gsc
*************************************************/

_id_CEE7(var_0, var_1, var_2) {
  var_3 = _func_03C0(undefined, undefined, var_0, var_1, "door");

  if(isDefined(var_2)) {
    var_4 = [];

    foreach(var_6 in var_3) {
      var_7 = var_6.origin[2] - var_0[2];

      if(var_7 <= var_2) {
        var_4[var_4.size] = var_6;
      }
    }

    var_3 = var_4;
  }

  return var_3;
}

_id_CEE3(var_0) {
  self notify("scriptable_door_freeze_open");
  self endon("scriptable_door_freeze_open");
  var_1 = undefined;
  var_2 = undefined;

  if(istrue(var_0)) {
    var_1 = "bash_left_90";
    var_2 = self._id_39D6 + (0, 90, 0);
  } else {
    var_1 = "bash_right_90";
    var_2 = self._id_39D6 + (0, -90, 0);
  }

  while(_func_000C(self.angles, var_2) > 1) {
    var_3 = self _meth_8575("door");

    if(var_3 != var_1) {
      self setscriptablepartstate("door", var_1, 0);
    }

    wait 0.05;
  }

  self setscriptablepartstate("door", "ajar", 0);
  self _meth_8727(1);
}

_id_CEEB(var_0) {
  if(self == var_0) {
    return 0;
  }

  var_1 = self._id_39D7;
  var_2 = var_0._id_39D7;
  var_3 = distancesquared(var_1, var_2);

  if(var_3 > 5) {
    return 0;
  }

  return 1;
}

_id_4E11(var_0, var_1) {
  var_2 = !var_0;
  var_3 = scripts\common\input_allow::allow_input_internal("door_frozen", var_2, var_1);

  if(isDefined(var_3)) {
    if(!istrue(self _meth_8883())) {
      self _meth_8727(!var_3);
    }
  }
}

_id_4DF5() {
  return scripts\common\input_allow::_id_860C("door_frozen");
}