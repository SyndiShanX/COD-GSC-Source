/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2817.gsc
*************************************************/

main() {
  self endon("killanimscript");

  if(!isDefined(level._id_4CED)) {
    _id_8183();
  }

  var_0 = self _meth_8161();
  var_1 = self _meth_815F();
  var_2 = undefined;
  var_2 = level._id_4CED[var_0._id_005D];

  if(!isDefined(var_2)) {
    return;
  }
  self._id_2596 = 1;
  var_3 = var_1.origin - var_0.origin;
  var_4 = (var_3[0], var_3[1], 0);
  var_5 = vectortoangles(var_4);
  self _meth_82C1("face angle abs", var_5);
  self _meth_82B9("anim deltas");
  var_6 = self _meth_810C(var_2, 0);
  var_7 = _func_00BB(var_6, "code_move");

  if(var_7.size > 0) {
    var_8 = _func_00B0(var_6, 0, var_7[0]);
  } else {
    var_8 = _func_00B0(var_6, 0, 1);
  }

  var_9 = _id_0017::_id_68C5(var_3, var_8);
  self _meth_82C2("noclip");

  if(var_3[2] > 0) {
    if(var_8[2] > 0) {
      var_10 = _func_00BB(var_6, "traverse_jump_start");

      if(var_10.size > 0) {
        var_11 = 1;
        var_12 = 1;

        if(_func_0134(var_4) < 0.64 * _func_0134(var_8)) {
          var_11 = 0.4;
        }

        if(var_3[2] < 0.75 * var_8[2]) {
          var_12 = 0.5;
        }

        self _meth_82BA(var_11, var_12);
        _id_0017::_id_B356(var_2, 0, "traverse", "traverse_jump_start");
        var_13 = _func_00BB(var_6, "traverse_jump_end");
        var_14 = _func_00B0(var_6, 0, var_10[0]);
        var_15 = _func_00B0(var_6, 0, var_13[0]);
        var_11 = 1;
        var_12 = 1;
        var_16 = var_1.origin - self.origin;
        var_17 = var_8 - var_14;

        if(_func_0134(var_16) < 0.5625 * _func_0134(var_17)) {
          var_11 = 0.75;
        }

        if(var_16[2] < 0.75 * var_17[2]) {
          var_12 = 0.75;
        }

        var_18 = var_8 - var_15;
        var_19 = (var_18[0] * var_11, var_18[1] * var_11, var_18[2] * var_12);
        var_20 = rotatevector(var_19, var_5);
        var_21 = var_1.origin - var_20;
        var_22 = var_15 - var_14;
        var_23 = rotatevector(var_22, var_5);
        var_24 = var_21 - self.origin;
        var_9 = _id_0017::_id_68C5(var_24, var_23, 1);
        self _meth_82BA(var_9._id_10FDD, var_9._id_050C);
        _id_0017::_id_10980("traverse", "traverse_jump_end");
        self _meth_82BA(var_11, var_12);
        _id_0017::_id_10980("traverse", "code_move");
        return;
      }

      self _meth_82BA(var_9._id_10FDD, var_9._id_050C);
      _id_0017::_id_B356(var_2, 0, "traverse");
      return;
    } else {
      var_25 = _func_00BB(var_6, "gravity on");

      if(var_25.size > 0) {
        var_26 = var_0 _id_6DBD();

        if(isDefined(var_26)) {
          var_27 = var_26 - self.origin;
          var_28 = var_1.origin - var_26;
          var_29 = _func_00B0(var_6, 0, var_25[0]);
          var_9 = _id_0017::_id_68C5(var_27, var_29);
          self _meth_82BA(var_9._id_10FDD, var_9._id_050C);
          _id_0017::_id_B356(var_2, 0, "traverse", "gravity on");
          var_30 = _func_00B0(var_6, var_25[0], 1);
          var_9 = _id_0017::_id_68C5(var_28, var_30);
          self _meth_82BA(var_9._id_10FDD, var_9._id_050C);
          _id_0017::_id_10980("traverse", "code_move");
          return;
        }
      }

      var_31 = _func_0079(var_6);
      self _meth_82B3(var_0.origin, var_1.origin, var_31);
      _id_0017::_id_B356(var_2, 0, "traverse");
    }
  } else {
    var_25 = _func_00BB(var_6, "gravity on");

    if(var_25.size > 0) {
      self _meth_82BA(var_9._id_10FDD, 1);
      _id_0017::_id_B356(var_2, 0, "traverse", "gravity on");
      var_32 = _func_00B0(var_6, 0, var_25[0]);
      var_33 = var_32[2] - var_8[2];

      if(abs(var_33) > 0) {
        var_34 = self.origin[2] - var_1.origin[2];
        var_12 = var_34 / var_33;
        self _meth_82BA(var_9._id_10FDD, var_12);
        var_35 = clamp(2 / var_12, 0.5, 1);
        var_36 = var_2 + "_norestart";
        self _meth_82E6(var_36, 0, var_35);
      }

      _id_0017::_id_10980("traverse", "code_move");
    } else {
      self _meth_82BA(var_9._id_10FDD, var_9._id_050C);
      var_35 = clamp(2 / var_9._id_050C, 0.5, 1);
      var_13 = _func_00BB(var_6, "traverse_jump_end");

      if(var_13.size > 0) {
        _id_0017::_id_B353(var_2, 0, var_35, "traverse", "traverse_jump_end");
        var_36 = var_2 + "_norestart";
        self _meth_82E6(var_36, 0, 1);
        _id_0017::_id_10980("traverse", "code_move");
      } else
        _id_0017::_id_B356(var_2, 0, "traverse");
    }

    self _meth_82BA(1, 1);
  }
}

_id_0191() {
  self _meth_82BA(1, 1);
  self._id_2596 = 0;
}

_id_6DBD() {
  if(isDefined(self._id_EEA3)) {
    return self._id_EEA3;
  }

  var_0 = getent(self.target, "targetname");

  if(!isDefined(var_0)) {
    return undefined;
  }

  self._id_EEA3 = var_0.origin;
  var_0 delete();
  return self._id_EEA3;
}

_id_8183() {
  level._id_4CED = [];
  level._id_4CED["hjk_tree_hop"] = "traverse_jump_over_24";
  level._id_4CED["jump_across_72"] = "traverse_jump_over_24";
  level._id_4CED["wall_hop"] = "traverse_jump_over_36";
  level._id_4CED["window_2"] = "traverse_jump_over_36";
  level._id_4CED["wall_over_40"] = "traverse_jump_over_36";
  level._id_4CED["wall_over"] = "traverse_jump_over_36";
  level._id_4CED["window_divethrough_36"] = "traverse_jump_over_36";
  level._id_4CED["window_over_40"] = "traverse_jump_over_36";
  level._id_4CED["window_over_quick"] = "traverse_jump_over_36";
  level._id_4CED["jump_up_80"] = "traverse_jump_up_70";
  level._id_4CED["jump_standing_80"] = "traverse_jump_up_70";
  level._id_4CED["jump_down_80"] = "traverse_jump_down_70";
  level._id_4CED["jump_up_40"] = "traverse_jump_up_40";
  level._id_4CED["jump_down_40"] = "traverse_jump_down_40";
  level._id_4CED["step_up"] = "traverse_jump_up_24";
  level._id_4CED["step_up_24"] = "traverse_jump_up_24";
  level._id_4CED["step_down"] = "traverse_jump_down_24";
  level._id_4CED["jump_down"] = "traverse_jump_down_24";
  level._id_4CED["jump_across"] = "traverse_jump_over_36";
  level._id_4CED["jump_across_100"] = "traverse_jump_over_36";
}