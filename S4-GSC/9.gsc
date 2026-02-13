/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 9.gsc
*************************************************/

_id_0067(var_0, var_1) {
  return anim._id_1CB7[var_0][var_1];
}

_id_0068() {
  return::_id_1C55;
}

_id_0069(var_0, var_1) {
  return anim._id_1CB9[var_0][var_1];
}

_id_1CA9(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_5D64)) {
    self[[self._id_5D64]](var_0, var_1, var_2, var_3);
  }
}

_id_1CA6(var_0) {
  switch (var_0) {
    case "face node":
      var_1 = 1024.0;

      if(scripts\engine\utility::_id_0F78()) {
        var_2 = self.angles;

        if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < var_1) {
          var_2 = _id_08F1::_id_6B9C(self._id_02ED);
        }

        self _meth_8251("face angle 3d", var_2);
      } else {
        var_3 = self.angles[1];

        if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < var_1) {
          var_3 = _id_08F1::_id_6B9D(self._id_02ED);
        }

        if(isDefined(self._id_02ED) && self._id_02ED.type != "Exposed" && !self._id_024C) {
          self _meth_8251("face angle", var_3);
        }
      }

      break;
    case "face current":
      self _meth_8251("face angle 3d", self.angles);
      break;
    default:
      self _meth_8251(var_0);
      break;
  }
}

_id_1CA3(var_0) {
  if(isDefined(self._id_5D62)) {
    self[[self._id_5D62]](var_0);
    return;
  }

  self _meth_8019(var_0, 0);
}

_id_1C55(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0) {
    case "orientmode":
      _id_1CA6(var_2);
      break;
    case "setupaim":
      _id_1CA9(var_1, var_2, 0.2, undefined);
      break;
    case "setupgesture":
      if(isDefined(self._id_5D65)) {
        self[[self._id_5D65]](var_1, var_2);
      }

      break;
    case "archetype":
      self._id_1C30._id_1A35 = var_2;
      self._id_189C = var_2;
      break;
    case "note":
      var_5 = _id_1C6A(var_1, undefined);
      var_6 = [[self._id_5D5D]](var_3, var_2, var_5, undefined);

      if(!isDefined(var_6)) {
        var_6 = _id_1C70(var_1, var_3, var_2);
      }

      if(isDefined(var_6) && !_id_1C50(var_1, "end")) {
        _id_1C53(var_1, "end");
      }

      break;
    case "waitfordooropen":
      thread _id_08F1::_id_10800(var_1, var_2, var_3);
      break;
    case "move_threads":
      var_7 = var_2;
      thread _id_08F1::_id_107FD(var_1, var_7);
      thread _id_08F1::_id_10826(var_1, var_7);
      break;
    default:
      break;
  }
}

_id_1CA0(var_0, var_1) {
  var_2 = 9999;
  anim._id_1CB9[var_0][var_2] = var_1;
  return var_2;
}

_id_1C6F() {
  if(isDefined(anim._id_1C30)) {
    return;
  }
  anim._id_1C30 = [];
}

_id_1C52(var_0, var_1, var_2) {
  self _meth_85D5(var_0, var_1, var_2);
}

_id_1C78() {
  if(isDefined(self._id_0B67)) {
    return;
  }
  self._id_0B67 = self _meth_85DE();
  self._id_0B67._id_0066 = [];
  self._id_0B67._id_0065 = [];
  self._id_0B67._id_1C4E = [];
  self._id_0B67._id_0091 = 0;
}

_id_1C3E(var_0) {
  if(isDefined(self._id_0B67._id_0066[var_0])) {
    self._id_0B67._id_0066[var_0] = undefined;
  }
}

_id_1CB0(var_0, var_1) {
  self _meth_85D3();
  self _meth_85DF();
  self._id_0B67 = undefined;
  self notify("asm_terminated");

  if(!isDefined(var_1)) {
    var_1 = self._id_1C30._id_1A35;
  }

  _id_1C78();
  self[[self._id_5D5E]](tolower(var_0), var_1);
}

_id_1C6A(var_0, var_1) {
  var_2 = self _meth_85D1(var_0);

  if(var_2 != -1) {
    return anim._id_1CB7[var_0][var_2];
  }

  return undefined;
}

_id_1C43(var_0, var_1) {
  if(isDefined(self._id_5ED2)) {
    return 1;
  }

  return self _meth_85CD(var_0, var_1);
}

_id_1C54(var_0, var_1, var_2) {
  self _meth_85D4(var_0, var_1, var_2);
}

_id_1C53(var_0, var_1, var_2) {
  _id_1C54(var_0, var_1, var_2);

  if(var_1 == "anim_will_finish" || var_1 == "finish") {
    var_1 = "end";
    _id_1C54(var_0, var_1);
  }
}

_id_1C31(var_0, var_1) {
  self._id_0B67._id_1C4E[var_0] = var_1;
}

_id_1C4F(var_0, var_1, var_2) {
  var_3 = self _meth_85D7(var_0, var_1);

  if(var_3) {
    return 1;
  }

  if(!isDefined(var_2) || var_2) {
    _id_1C31(var_0, var_1);
  }

  return 0;
}

_id_1C51(var_0, var_1) {
  return self _meth_85D8(var_0, var_1, 50);
}

_id_1C65(var_0, var_1) {
  return self _meth_85DB(var_0, var_1);
}

_id_1C64(var_0, var_1) {
  return self _meth_85DA(var_0, var_1);
}

_id_1C63(var_0, var_1) {
  return self _meth_85DC(var_0, var_1);
}

_id_1C3C() {
  self _meth_85D9();
}

_id_1CAD(var_0, var_1) {
  if(!isDefined(self._id_29F1) || !self._id_29F1) {
    return 0;
  }

  if(isDefined(self._id_1C30._id_29F2) && self._id_1C30._id_29F2) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(_id_06BD::_id_23CE()) {
    return 0;
  }

  if(isDefined(self._id_0B67._id_2C71)) {
    return 0;
  }

  if(isDefined(self._id_9D39)) {
    return 0;
  }

  return 1;
}

_id_1C50(var_0, var_1) {
  return self _meth_85D6(var_0, var_1);
}

_id_1C37(var_0, var_1, var_2) {
  self _meth_85C7(1);
}

_id_1CA1(var_0, var_1) {
  if(self _meth_85C9(self._id_1CB8, var_0)) {
    self _meth_85CA(self._id_1CB8, var_0, var_1);
  }
}

_id_1CB1() {}

_id_792B(var_0, var_1, var_2, var_3) {
  var_4 = _id_08F1::_id_6A9A();

  if(isDefined(var_4) && var_4 != var_3) {
    return 0;
  }

  return 1;
}

_id_1C61() {
  return self._id_0B67._id_02D7;
}

_id_1CB4() {
  if(!isDefined(self._id_0323) || distancesquared(self.origin, self._id_0323) > 4096.0) {
    self._id_1C30._id_5F3F = _id_06BD::_id_23D1();
  }
}

_id_1C7B() {
  return isDefined(self._id_1C30) && self._id_1C30._id_5F3F;
}

_id_1C7A() {
  return isDefined(self._id_1C30._id_3EBD);
}

_id_1C9D(var_0) {
  self._id_1C30._id_3EBD = var_0;
}

_id_1C9E(var_0, var_1, var_2) {
  self._id_1C30._id_18B7[var_0][var_1] = var_2;
}

_id_1C3D(var_0, var_1) {
  if(_id_1C73(var_0, var_1)) {
    self._id_1C30._id_18B7[var_0][var_1] = undefined;
  }
}

_id_1C73(var_0, var_1) {
  return isDefined(self._id_1C30._id_18B7[var_0]) && isDefined(self._id_1C30._id_18B7[var_0][var_1]);
}

_id_1C62(var_0, var_1) {
  return self._id_1C30._id_18B7[var_0][var_1];
}

_id_1C5F(var_0) {
  return self _meth_85CC(var_0);
}

_id_1C72(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self._id_189C)) {
    var_2 = self._id_189C;
  } else {
    var_2 = self._id_1C30._id_1A35;
  }

  var_3 = _func_031D(var_2, var_0, var_1, _id_1C7B());
  return isDefined(var_3);
}

_id_1C5C(var_0, var_1, var_2) {
  if(_func_0107(var_2)) {
    if(var_2.size == 1) {
      return self _meth_85C8(var_0, var_1, var_2[0]);
    } else if(var_2.size == 2) {
      return self _meth_85C8(var_0, var_1, var_2[0], var_2[1]);
    } else if(var_2.size == 3) {
      return self _meth_85C8(var_0, var_1, var_2[0], var_2[1], var_2[2]);
    } else {}
  } else
    return self _meth_85C8(var_0, var_1, var_2);
}

_id_1C6C(var_0, var_1) {
  var_2 = _id_1C6B(var_1);
  return _id_1C7D(var_1, var_2);
}

_id_1C6B(var_0) {
  var_1 = _func_031E(self._id_1C30._id_1A35, var_0);
  return var_1[randomint(var_1.size)];
}

_id_1C7E(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self._id_189C)) {
    var_2 = self._id_189C;
  } else {
    var_2 = self._id_1C30._id_1A35;
  }

  var_3 = _func_031D(var_2, var_0, var_1, _id_1C7B());
  return var_3;
}

_id_1C7D(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self._id_189C)) {
    var_2 = self._id_189C;
  } else {
    var_2 = self._id_1C30._id_1A35;
  }

  var_3 = _func_031D(var_2, var_0, var_1, _id_1C7B());
  return var_3;
}

_id_1C5A(var_0, var_1) {
  return _id_1C5B(self._id_1C30._id_1A35, var_0, var_1);
}

_id_1C5B(var_0, var_1, var_2) {
  return _id_1C59(var_0, var_1, undefined, var_2);
}

_id_1C59(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_2 = scripts\engine\utility::_id_EA52(var_2);
  }

  var_4 = _func_031E(var_0, var_1);
  var_5 = [];

  foreach(var_7 in var_4) {
    if(!isDefined(var_2) || _func_010D(var_7, var_2)) {
      var_8 = _func_031C(var_0, var_1, var_7, 0);

      if(istrue(var_3)) {
        var_5[var_7] = var_8._id_005C;
      } else if(_func_0107(var_8._id_005C)) {
        var_5 = scripts\engine\utility::array_combine(var_5, var_8._id_005C);
      } else {
        var_5[var_5.size] = var_8._id_005C;
      }
    }
  }

  return var_5;
}

_id_1C58(var_0, var_1, var_2) {
  var_3 = _func_031C(var_0, var_1, var_2, 1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_4 = var_3._id_005C;

  if(!_func_0107(var_4)) {
    var_4 = [var_4];
  }

  return var_4;
}

_id_1C57(var_0, var_1) {
  return _func_038C(self._id_1C30._id_1A35, var_0, var_1);
}

_id_1C87(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3);
  _id_1C8E(var_0, var_1, _id_1C6E(var_1, var_3));
  var_4 = _id_1C45(var_0, var_1, _id_1C6A(var_0, var_1));

  if(var_4 == "code_move") {
    var_4 = _id_1C45(var_0, var_1, _id_1C6A(var_0, var_1));
  }
}

_id_1C74() {
  if(isagent(self) && !istrue(self._id_2C57) && self._id_04B9 != "civilian" && self._id_04B9 != "dog") {
    return 0;
  }

  return 1;
}

_id_1C81(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");

  if(_id_1C74()) {
    var_4 = _id_1C5E();

    if(isDefined(var_3) && var_3) {
      var_5 = _id_1C7E("knobs", "move");

      if(isDefined(var_5)) {
        var_6 = _id_1C6E("knobs", var_5);
        self _meth_851E(var_6);
      }
    }
  }

  var_7 = _id_1C6A(var_0, var_1);
  var_8 = 0.2;
  var_9 = isDefined(var_3) && var_3;
  var_10 = 1;

  for(;;) {
    var_11 = _id_1C5C(var_0, var_1);
    var_12 = _id_1C6E(var_1, var_11);

    if(isDefined(var_3) && var_3) {
      var_2 = _id_1C69();

      if(!isDefined(var_2)) {
        var_2 = 1.0;
      }

      self _meth_851D(var_2);
    } else if(isDefined(self._id_A5AC))
      var_2 = self._id_A5AC;

    if(!var_9) {
      var_10 = self _meth_85F6(var_12) == 0;
    }

    if(_func_02B7(var_11)) {
      self _meth_85ED(var_1, var_11, var_2);
    } else {
      var_13 = _id_1C7D(var_1, "blank");
      self _meth_85ED(var_1, var_13);

      if(var_10) {
        self _meth_8320(var_1, var_11, 1, 0.2, var_2);
      } else {
        self _meth_8317(var_1, var_11, 1, 0.2, var_2);
      }
    }

    if(var_9) {
      var_10 = 0;
    }

    _id_1C8E(var_0, var_1, var_12);
    var_14 = _func_0079(var_12);

    if(var_14 <= 0.05) {
      return;
    }
    var_15 = undefined;
    var_16 = var_2;

    while(!isDefined(var_15)) {
      var_15 = _id_1C4B(var_0, var_1, var_8, var_7);

      if(!isDefined(var_15) && var_9) {
        var_2 = _id_1C69();

        if(!isDefined(var_2)) {
          var_2 = 1.0;
        }

        if(var_2 != var_16) {
          self _meth_851D(var_2);

          if(_func_02B7(var_11)) {
            self _meth_85F5(var_1, var_11, var_2);
            continue;
          }

          self _meth_82E8(var_12, var_2);
        }
      }
    }
  }
}

_id_1C7F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "";

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(var_3) {
    if(_id_1C51(var_1, "pass_left")) {
      var_6 = var_5 + "left";
    } else if(_id_1C51(var_1, "pass_right")) {
      var_6 = var_5 + "right";
    } else if(self._id_1C30._id_5E3A._id_5E36 == "right") {
      var_6 = var_5 + "right";
    } else {
      var_6 = var_5 + "left";
    }
  } else
    var_6 = var_5;

  var_7 = _id_1C7E(var_2, var_6 + var_0);

  if(isDefined(var_7)) {
    return var_7;
  }

  if(var_5 != var_6) {
    var_7 = _id_1C7E(var_2, var_5 + var_0);

    if(isDefined(var_7)) {
      return var_7;
    }
  }

  return undefined;
}

_id_1C9F(var_0) {
  self._id_A246 = var_0;
}

_id_1C69() {
  return self._id_A246;
}

_id_1C60(var_0) {
  return self _meth_85CC(var_0);
}

_id_1C4D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  self waittill(var_5, var_6);

  if(!isDefined(var_6)) {
    var_6 = ["undefined"];
  }

  if(!_func_0107(var_6)) {
    var_6 = [var_6];
  }

  var_7 = undefined;

  foreach(var_9 in var_6) {
    _id_1C53(var_0, var_9);
    var_10 = [[self._id_5D5D]](var_9, var_5, var_2, var_3);

    if(!isDefined(var_10)) {
      var_10 = _id_1C70(var_0, var_9, var_1);
    }

    if(isDefined(var_10)) {
      var_7 = var_10;
    }
  }

  return var_7;
}

_id_1C70(var_0, var_1, var_2) {
  if(_id_1CB2(var_1)) {
    return;
  }
  switch (var_1) {
    case "start_aim":
      if(_id_1C43(var_0, "notetrackAim")) {
        _id_1CA9(var_0, var_2, 0.2);
      }

      break;
  }
}

_id_1CB2(var_0) {
  if(!scripts\engine\utility::string_starts_with(var_0, "ds ")) {
    return 0;
  }

  var_1 = 3;
  self._id_1C30._id_4413 = spawnStruct();
  var_1 = var_1 + 1;

  for(var_2 = ""; var_1 < var_0.size && var_0[var_1] != "]"; var_1 = var_1 + 1) {
    var_2 = var_2 + var_0[var_1];
  }

  self._id_1C30._id_4413._id_E75C = var_2;
  var_1 = var_1 + 1;

  if(var_1 < var_0.size) {
    var_1 = var_1 + 2;

    for(var_3 = ""; var_1 < var_0.size && var_0[var_1] != "]"; var_1 = var_1 + 1) {
      var_3 = var_3 + var_0[var_1];
    }

    self._id_1C30._id_4413._id_AE4A = var_3;
  }

  return 1;
}

_id_1C46(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  self endon(var_5);
  childthread _id_1C47(var_5, var_2);

  for(;;) {
    _id_1C4D(var_0, var_1, var_3, var_4);
  }
}

_id_1C4C(var_0, var_1, var_2) {
  self endon(var_0);
  wait(var_2);
  self notify(var_1);
}

_id_1C4B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  var_6 = var_1 + "_endHelper";
  self endon(var_5);
  childthread _id_1C4C(var_6, var_5, var_2);
  var_7 = _id_1C45(var_0, var_1, var_3, var_4);
  self notify(var_6);
  return var_7;
}

_id_1C45(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  for(;;) {
    var_6 = _id_1C4D(var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_6)) {
      if(var_5 && !_id_1C50(var_0, "end")) {
        _id_1C53(var_0, "end");
      }

      return var_6;
    }
  }
}

_id_1C4A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  for(;;) {
    self waittill(var_5, var_6);

    if(!isDefined(var_6)) {
      var_6 = ["undefined"];
    }

    if(!_func_0107(var_6)) {
      var_6 = [var_6];
    }

    var_7 = undefined;

    foreach(var_9 in var_6) {
      _id_1C53(var_0, var_9);
      var_10 = [[var_2]](var_1, var_9, var_3);

      if(isDefined(var_10) && var_10) {
        continue;
      }
      var_11 = [[self._id_5D5D]](var_9, var_1, undefined, undefined);

      if(!isDefined(var_11)) {
        var_11 = _id_1C70(var_0, var_9, var_1);
      }

      if(isDefined(var_11)) {
        var_7 = var_11;
      }
    }

    if(isDefined(var_7)) {
      return var_7;
    }
  }
}

_id_1C48(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + "_note_loop_end";
  self endon(var_4);
  var_5 = _func_0079(var_2);
  thread _id_1C49(var_4, var_1 + "_finished", var_5);
  _id_1C45(var_0, var_1, var_3);
  self notify(var_4);
}

_id_1C49(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_0);
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

_id_1C47(var_0, var_1) {
  wait(var_1);
  self notify(var_0);
}

_id_1CB5(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 0;

  while(!var_3) {
    self waittill(var_1, var_4);

    if(!_func_0107(var_4)) {
      var_4 = [var_4];
    }

    foreach(var_6 in var_4) {
      if(var_6 == "start_aim") {
        _id_1CA9(var_0, var_1, var_2);
        var_3 = 1;
        break;
      }
    }
  }
}

_id_1C80(var_0, var_1, var_2) {
  var_3 = self._id_1C30._id_1A35;
  var_4 = _func_031E(var_3, var_0);
  var_5 = 0.0;
  var_6 = undefined;
  var_7 = -1;

  if(isDefined(var_1)) {
    var_7 = var_1.size;
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  foreach(var_10 in var_4) {
    if(var_7 < 0 || _func_00D6(var_10, 0, var_7) == var_1) {
      var_5 = var_5 + 1.0;
      var_11 = 1.0 / var_5;

      if(randomfloat(1.0) <= var_11) {
        var_6 = var_10;
      }
    }
  }

  return var_6;
}

_id_1C38(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_3 = _id_1C80(var_1);
    return _id_1C7D(var_1, var_3);
  } else {
    var_4 = undefined;
    var_5 = _id_06BD::_id_23C2(var_2);

    if(isDefined(var_5)) {
      var_3 = _id_1C80(var_1, var_5);
      var_4 = _id_1C7D(var_1, var_3);
    } else
      var_4 = _id_1C7D(var_1, var_2);

    return var_4;
  }
}

_id_1C3F() {
  if(!isDefined(self._id_5891) || self._id_5891 != "filler") {
    if(isai(self)) {
      self _meth_86D8("none");
    } else {
      _id_08F1::_id_D555("none");
    }
  }
}

_id_1C9A() {
  var_0 = self._id_1CB8;
  var_1 = self _meth_85CC(var_0);

  if(var_1 == "animscripted") {
    return;
  }
  _id_1C8E(var_0, var_1, undefined);
}

_id_1C8E(var_0, var_1, var_2) {
  if(isDefined(self._id_5D61)) {
    [[self._id_5D61]](var_0, var_1, var_2);
  }
}

_id_1C6D() {
  var_0 = _id_1C7D("knobs", "root");
  return _id_1C6E("knobs", var_0);
}

_id_1C5E() {
  var_0 = _id_1C7D("knobs", "body");
  return _id_1C6E("knobs", var_0);
}

_id_1C68() {
  var_0 = _id_1C7E("knobs", "inner_root");

  if(isDefined(var_0)) {
    return _id_1C6E("knobs", var_0);
  }

  return _id_1C5E();
}

_id_1C66() {
  var_0 = _id_1C7E("always_on", "facial");

  if(isDefined(var_0)) {
    return _id_1C6E("always_on", var_0);
  }
}

_id_1C67() {
  var_0 = _id_1C7E("knobs", "headlook");

  if(isDefined(var_0)) {
    return _id_1C6E("knobs", var_0);
  }

  return undefined;
}

_id_1C7C() {
  var_0 = self._id_04F6;
  var_1 = getweaponbasename(var_0);
  var_2 = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_2, var_1)) {
    return 1;
  }

  return 0;
}

_id_1C6E(var_0, var_1) {
  if(_func_02B7(var_1)) {
    var_2 = undefined;

    if(!isDefined(self._id_1C30)) {
      var_2 = self._id_189C;
    } else {
      var_2 = self._id_1C30._id_1A35;
    }

    return _func_038B(var_2, var_0, var_1);
  } else
    return var_1;
}

_id_1C8D(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = _id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_4);
  _id_1C8E(var_0, var_1, _id_1C6E(var_1, var_4));
  var_5 = _id_1C4A(var_0, var_1, var_2, var_3);

  if(var_5 == "end") {
    if(!_id_1C50(var_0, "end")) {
      _id_1C53(var_0, "end");
    }
  }
}

_id_1C8B(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3);
  _id_1C8E(var_0, var_1, _id_1C6E(var_1, var_3));
  var_4 = _id_1C45(var_0, var_1, _id_1C6A(var_0, var_1));
}

_id_1C83(var_0, var_1, var_2) {
  [[self._id_5D60]](var_0, var_1, var_2);
}

_id_D7DD() {
  foreach(var_1 in _func_00B3("traverse", "targetname")) {
    var_1 _id_F4F4();
  }
}

_id_BD66(var_0) {
  self._id_4EA3 = var_0.origin;
  self._id_E6FC = self.angles;

  if(isent(var_0)) {
    var_0 delete();
  } else {
    scripts\engine\utility::_id_4794(var_0);
  }
}

_id_F4F4() {
  var_0 = getent(self.target, "targetname");

  if(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getstruct(self.target, "targetname");
  }

  var_1 = _func_00B2(self.target, "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  switch (self._id_005D) {
    case "wall_run":
      _id_BD86(var_0);
      return;
    case "double_jump_mantle":
    case "double_jump_vault":
      _id_BD66(var_0);
      return;
    case "double_jump":
      self._id_E6FC = self.angles;

      if(!isDefined(var_0)) {
        return;
      }
      self._id_8C96 = var_0.origin - self.origin;
      self._id_8C95 = var_0.origin;
      break;
    case "rail_hop_double_jump_down":
      self._id_E6FC = self.angles;
      break;
    default:
      break;
  }

  if(isDefined(var_0.target)) {
    var_3 = getent(var_0.target, "targetname");

    if(!isDefined(var_3)) {
      var_3 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    }

    _id_2EDA(var_0.origin, var_1.origin, var_3.origin);
  } else
    _id_2EDA(var_0.origin, var_1.origin);

  if(isDefined(self._id_0318)) {
    _id_E9B7();
  }

  if(isent(var_0)) {
    var_0 delete();
  } else {
    scripts\engine\utility::_id_4794(var_0);
  }
}

_id_E9B7() {
  self._id_AC86 = spawnStruct();
  self._id_AC86.origin = self.origin;
  self._id_AC86.angles = self.angles;
  self._id_AC86._id_F4DA = self._id_F4DA;
  self._id_AC86._id_F4DB = self._id_F4DB;
  self._id_AC86._id_F4D9 = self._id_F4D9;
  self._id_AC86._id_19AE = self._id_19AE;
  self._id_AC86._id_19AF = _func_01C8(self._id_19AE, self.angles);

  if(isDefined(self._id_0E83)) {
    self._id_AC86._id_0E83 = self._id_0E83;
    self._id_AC86._id_0E84 = _func_01C8(self._id_0E83, self.angles);
  }

  var_0 = _func_00B2(self.target, "targetname");

  if(isDefined(var_0)) {
    self._id_AC86._id_532C = var_0.origin;
  }
}

_id_2EDA(var_0, var_1, var_2) {
  self._id_F4DA = var_0[2];
  self._id_F4DB = var_0[2] - self.origin[2];
  self._id_F4D9 = var_0[2] - var_1[2];
  self._id_19AE = var_0 - self.origin;

  if(isDefined(var_2)) {
    self._id_0E83 = var_2 - var_0;
  }
}

_id_C059(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = self.origin + rotatevector(var_0._id_AC86._id_19AF, self.angles);
  }

  if(!isDefined(var_2)) {
    var_2 = var_0._id_AC86._id_532C;
  }

  if(!isDefined(var_3) && isDefined(var_0._id_AC86._id_0E84)) {
    var_4 = rotatevector(var_0._id_AC86._id_0E84, self.angles);
    var_3 = var_1 + var_4;
  }

  _id_2EDA(var_1, var_2, var_3);
}

_id_BD86(var_0) {
  var_1 = getent(var_0.target, "targetname");

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  }

  self._id_109A0 = spawnStruct();
  var_3 = var_0;
  var_4 = 0;
  self._id_109A0._id_E6FC = self.angles;
  var_6 = undefined;

  while(isDefined(var_3)) {
    self._id_109A0._id_A576[var_4] = var_3.origin - self.origin;
    var_4++;
    var_7 = scripts\engine\utility::getstruct(var_3.target, "targetname");
    scripts\engine\utility::_id_4794(var_3);
    var_3 = var_7;
    self._id_109A0._id_A576[var_4] = var_3.origin - self.origin;
    var_4++;

    if(isDefined(var_3.target)) {
      var_10 = scripts\engine\utility::getstruct(var_3.target, "targetname");
    } else {
      var_10 = undefined;
    }

    scripts\engine\utility::_id_4794(var_3);
    var_3 = var_10;

    if(isDefined(var_3) && isDefined(var_3._id_CEC0)) {
      if(var_3._id_CEC0 == "wallrun_mantle") {
        self._id_109A0._id_9A55 = var_3.origin - self.origin;

        if(isDefined(var_3.angles)) {
          self._id_109A0._id_9A52 = var_3.angles;
        }

        scripts\engine\utility::_id_4794(var_3);
        break;
      } else if(var_3._id_CEC0 == "wallrun_vault") {
        self._id_109A0._id_9A55 = var_3.origin - self.origin;
        self._id_109A0._id_2DE8 = 1;
        scripts\engine\utility::_id_4794(var_3);
        break;
      }
    }
  }
}

_id_1C82() {
  if(istrue(self._id_1C30._id_FF05)) {
    var_0 = _id_06BD::_id_23C8();
    var_1 = self _meth_8182();

    if(isDefined(var_0) && !isDefined(var_1)) {
      return 1;
    }
  }

  return 0;
}