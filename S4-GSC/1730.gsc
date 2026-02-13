/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1730.gsc
*************************************************/

_id_B911(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");

  if(isDefined(var_2) && tolower(var_2) == "waitfordooropen") {
    thread _id_08F1::_id_10800(var_0, var_1, 0);
  }

  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  _id_06BD::_id_23F7("stand");
  var_5 = self _meth_8161();

  if(!isDefined(var_5) && isDefined(self._id_F4C9)) {
    var_5 = self._id_F4C9;
  }

  if(isDefined(var_5._id_F4DB)) {
    var_5._id_F4DA = var_5.origin[2] + var_5._id_F4DB;
  }

  var_6 = self _meth_815F();

  if(!isDefined(var_6) && isDefined(self._id_F4C6)) {
    var_6 = self._id_F4C6;
  }

  if(!isDefined(var_6)) {}

  self._id_F4F1 = var_5;
  self._id_F4E7 = var_6;
  self _meth_8019("noclip");
  self._id_F4F3 = self.origin[2];
  self _meth_8251("face angle", self.angles[1]);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  self._id_F4F6 = var_4;
  self._id_F4E0 = _id_0009::_id_1C5E();
  self _meth_85ED(var_1, var_3);
  self _meth_8845(var_5);
  self._id_F4E6 = 0;
  self._id_F4E5 = undefined;
  self._id_04C2 = 1;
  var_7 = _id_0009::_id_1C45(var_0, var_1, ::_id_74A2);
  self _meth_8019("gravity");

  if(self._id_015A) {
    _id_0903::_id_F09F(var_0, var_1);
    return;
  }
}

_id_B90F(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");

  if(isDefined(var_2) && tolower(var_2) == "waitfordooropen") {
    thread _id_08F1::_id_10800(var_0, var_1, 0);
  }

  _id_356A(var_1);
  var_3 = self _meth_8161();

  if(!isDefined(var_3)) {
    _id_0903::_id_F09F(var_0, var_1);
    return;
  }

  if(isDefined(self._id_F4E1) && self._id_F4E1._id_02ED != var_3) {
    self._id_F4E1 = undefined;
  }

  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  var_5 = _id_0009::_id_1C6E(var_1, var_4);
  _id_06BD::_id_23F7("stand");

  if(!_func_0335(var_5)) {
    var_6 = self _meth_815F();

    if(!isDefined(var_6) && isDefined(self._id_F4C6)) {
      var_6 = self._id_F4C6;
    }

    if(isDefined(var_6)) {
      self _meth_80F9(var_6.origin, self.angles);
    }

    _id_0903::_id_F09F(var_0, var_1);
    return;
  }

  var_7 = _func_00BB(var_5, "code_move");

  if(var_7.size > 0) {
    thread _id_08F1::_id_107FD(var_0, var_1);
    thread _id_08F1::_id_10826(var_0, var_1);
  }

  var_3 = self _meth_8161();

  if(!isDefined(var_3) && isDefined(self._id_F4C9)) {
    var_3 = self._id_F4C9;
  }

  if(isDefined(var_3._id_F4DB)) {
    var_3._id_F4DA = var_3.origin[2] + var_3._id_F4DB;
  }

  var_6 = self _meth_815F();

  if(!isDefined(var_6) && isDefined(self._id_F4C6)) {
    var_6 = self._id_F4C6;
  }

  if(!isDefined(var_6)) {}

  self._id_F4F1 = var_3;
  self._id_F4E7 = var_6;
  self _meth_8019("noclip");
  self._id_F4F3 = self.origin[2];
  self _meth_8251("face angle", self.angles[1]);
  var_8 = _id_08F1::_id_DC0C(var_5);
  var_9 = _id_DC0B(var_5);

  if(var_8) {
    var_10 = _id_08F1::_id_74A7;
  } else {
    var_10 = _id_08F1::_id_74A5;
    self _meth_8251("face angle", var_3.angles[1]);

    if(!_func_0011(var_5, "traverse_align")) {
      _id_08F1::_id_74A1();
    }
  }

  _id_0009::_id_1C8E(var_0, var_1, var_5);
  self._id_F4F6 = var_5;
  self._id_F4E0 = _id_0009::_id_1C5E();

  if(var_1 == "traverse_external") {
    self _meth_85ED(var_1, 0);
    self _meth_8077(_id_0009::_id_1C68(), 0.2);
    self _meth_8317(var_1, self._id_F4F6);
  } else
    self _meth_85ED(var_1, var_4);

  if(var_9 && !isagent(self) && (!isDefined(self._id_F4E1) || isDefined(self._id_F4E1._id_4C3E) && !self._id_F4E1._id_4C3E)) {
    var_11 = _func_00BB(var_5, "warp_arrival_end")[0];
    self _meth_82E7(var_5, var_11);
  }

  self._id_F4E6 = 0;
  self._id_F4E5 = undefined;
  self._id_04C2 = 1;
  var_12 = _id_0009::_id_1C45(var_0, var_1, var_10);

  if(var_12 == "code_move") {
    if(isDefined(self._id_0323)) {
      self _meth_85FC();
      self _meth_8019("normal");
      self _meth_8251("face motion");
    }

    if(!_id_0009::_id_1C50(var_0, "finish") && !_id_0009::_id_1C50(var_0, "end")) {
      _id_0009::_id_1C45(var_0, var_1, var_10);
    }
  }

  self _meth_8019("gravity");

  if(self._id_015A) {
    _id_0903::_id_F09F(var_0, var_1);
    return;
  }

  self._id_0DDF._id_A567 = 0;
  self._id_0DDF._id_A235 = "run";
  self._id_F4E0 = undefined;
  self._id_F4F6 = undefined;
  self._id_43D3 = undefined;
  self._id_F4F1 = undefined;
  _id_0903::_id_F09F(var_0, var_1);
}

_id_DC0B(var_0) {
  if(_func_0011(var_0, "warp_arrival_start")) {
    return 1;
  }

  return 0;
}

_id_D8BC(var_0, var_1, var_2) {
  var_3 = self _meth_8525(_id_6DFA(), 1);

  if(!isDefined(var_3)) {
    return 0;
  }

  var_4 = var_3["node"];
  var_5 = var_3["position"];
  var_6 = var_3["finish"];

  if(!isDefined(var_4) || !isDefined(var_4._id_005D)) {
    return 0;
  }

  self._id_F4C9 = var_4;
  self._id_F4C7 = var_5;
  self._id_F4C6 = var_6;
  return 1;
}

_id_DB46(var_0, var_1, var_2, var_3) {
  if(self._id_F4E1._id_F4F5 != var_3) {
    return 0;
  }

  if(!isDefined(self._id_F4CF)) {
    return 0;
  }

  if(!self._id_F4CF) {
    return 0;
  }

  var_4 = distance2d(_id_08F1::_id_6890(self._id_F4C9), self.origin);
  var_5 = anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][self._id_F4E1._id_1446]._id_F4A8;
  var_6 = _func_0133(var_5);
  var_7 = var_4 - var_6;

  if(var_7 > 10) {
    return 0;
  }

  var_8 = abs(_func_000B(self.angles[1] - self._id_F4C9.angles[1]));

  if(var_4 < 20 && var_8 < 30) {
    return 0;
  }

  return 1;
}

_id_DB14(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_F4C9)) {
    return 0;
  }

  if(!_id_EBA0(self._id_F4C9._id_005D)) {
    return 0;
  }

  var_4 = distance2d(self.origin, self._id_F4C9.origin);

  if(var_4 > _id_6DFA()) {
    return 0;
  }

  return 1;
}

_id_DBEF(var_0, var_1, var_2, var_3) {
  if(self._id_F4E1._id_F4F5 != var_3) {
    return 0;
  }

  var_4 = _id_08F1::_id_6890(self._id_F4C9);

  if(!self _meth_822C(self.origin, var_4)) {
    return 0;
  }

  var_5 = distance2d(var_4, self.origin);

  if(var_5 < 4) {
    self._id_F4E1._id_4C3E = 0;
  } else {
    var_6 = anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][self._id_F4E1._id_1446]._id_F4A8;
    var_7 = _func_0133(var_6);
    var_8 = abs(var_5 - var_7);

    if(var_8 > 10) {
      return 0;
    }
  }

  self _meth_8845(self._id_F4C9);
  return 1;
}

_id_F4D6(var_0, var_1, var_2) {
  self _meth_85FC();
  self _meth_85F9();
  self._id_F4E1 = undefined;
  self._id_F4C9 = undefined;
  self._id_F4C6 = undefined;
}

_id_2EC7(var_0, var_1, var_2) {
  if(isDefined(self._id_F4E1) && self._id_F4E1._id_02ED == self._id_F4C9) {
    return;
  }
  self._id_F4E1 = spawnStruct();
  self._id_F4E1._id_F4F5 = self._id_F4C9._id_005D;
  self._id_F4E1._id_02ED = self._id_F4C9;
  var_3 = [];
  var_3["height"] = self._id_F4C9._id_F4DB;
  var_3["drop_height"] = self._id_F4C9._id_F4D9;
  var_3["arrival_yaw"] = _func_000B(self._id_F4C9.angles[1] - self.angles[1]);
  var_3["speed"] = self _meth_864B();

  if(self._id_F4E1._id_F4F5 == "traverse_warp_across" || self._id_F4E1._id_F4F5 == "traverse_warp_jump_across") {
    var_3["length"] = _func_0133(self._id_F4C9._id_0E83);
  }

  var_4 = scripts\anim\animselector::_id_6DFC();
  var_5 = scripts\anim\animselector::_id_D051(self._id_F4E1._id_F4F5, var_3, var_4);
  var_6 = _id_0009::_id_1C7D(self._id_F4E1._id_F4F5, var_5);
  var_7 = _id_0009::_id_1C6E(self._id_F4E1._id_F4F5, var_6);
  self._id_F4E1._id_1446 = var_5;
  _id_FD6C(self._id_F4E1._id_F4F5, var_4, var_5);
  var_8 = self._id_F4E1._id_F4F5 + "_arrival";
  self._id_F4CF = 0;
  var_9 = undefined;
  var_10 = _id_0009::_id_1C7E(var_8, var_5);

  if(isDefined(var_10)) {
    var_9 = _id_0009::_id_1C6E(var_8, var_10);
    self._id_F4CF = 1;
    self._id_F4E1._id_4C3E = 1;
  } else {}

  if(!isDefined(anim._id_F4D1)) {
    anim._id_F4D1 = spawnStruct();
    anim._id_F4D1._id_1C05 = [];
  }

  if(!isDefined(anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5])) {
    anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5] = [];
  }

  if(!isDefined(anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][var_5])) {
    var_11 = var_7;

    if(isDefined(var_9)) {
      var_11 = var_9;
    }

    var_12 = _func_00BB(var_11, "warp_arrival_start")[0];
    var_13 = _func_00BB(var_11, "warp_arrival_end")[0];
    var_14 = _func_00BB(var_11, "finish")[0];

    if(isDefined(var_9)) {
      var_15 = _func_00B0(var_11, 0, var_14);
    } else {
      var_15 = _func_00B0(var_11, 0, var_13);
    }

    anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][var_5] = spawnStruct();
    anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][var_5]._id_1C16 = var_11;
    anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][var_5]._id_F4A8 = var_15;
    anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][var_5]._id_10A00 = var_12;
    anim._id_F4D1._id_1C05[self._id_F4E1._id_F4F5][var_5]._id_109FF = var_13;
  }
}

_id_F4ED(var_0, var_1, var_2, var_3) {
  var_4 = self _meth_8161();

  if(isDefined(var_4)) {
    return 0;
  }

  return 1;
}

_id_F4E3(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self._id_F4E1) && isDefined(self._id_F4E1._id_F4F5) && isDefined(self._id_F4E1._id_1446)) {
    var_1 = self._id_F4E1._id_F4F5;
    var_3 = self._id_F4E1._id_1446;
  } else {
    var_4 = _id_D8BC(var_0, var_1, var_2);
    _id_2EC7(var_0, var_1, var_2);
    var_5 = distance2d(_id_08F1::_id_6890(self._id_F4C9), self.origin);

    if(var_5 < 4) {
      self._id_F4E1._id_4C3E = 0;
    }

    var_1 = self._id_F4E1._id_F4F5;
    var_3 = self._id_F4E1._id_1446;
  }

  return _id_0009::_id_1C38(var_0, var_1, var_3);
}

_id_EBA0(var_0) {
  switch (var_0) {
    case "traverse_warp_across":
    case "traverse_warp_up":
    case "traverse_warp_external":
    case "traverse_warp_down":
    case "traverse_warp_over":
    case "traverse_warp_jump_across":
      return 1;
  }

  return 0;
}

_id_74A2(var_0) {
  if(var_0 == "warp_arrival_start") {
    return _id_08F1::_id_74AD();
  }
}

_id_356A(var_0) {}

_id_FD6C(var_0, var_1, var_2) {
  var_3 = anim._id_18D7[var_0][var_1];
  self._id_F4F2 = var_3._id_FF6E[var_2]["start_offset"];
  self._id_F4E8 = var_3._id_FF6E[var_2]["end_offset"];

  if(!isDefined(self._id_F4F2)) {
    self._id_F4F2 = 0;
  }

  if(!isDefined(self._id_F4E8)) {
    self._id_F4E8 = 0;
  }
}

_id_6DFD() {
  if(isDefined(self._id_F4F2)) {
    return self._id_F4F2;
  }

  return 0;
}

_id_6DFB() {
  if(isDefined(self._id_F4E8)) {
    return self._id_F4E8;
  }

  return 0;
}

_id_6DFA() {
  if(self._id_04B9 == "dog") {
    return 120;
  } else {
    return 120;
  }
}