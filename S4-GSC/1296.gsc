/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1296.gsc
*************************************************/

_id_A5D9(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_6016)) {
    return;
  }
  if(!isDefined(level._id_6016[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    call[[level._id_6016[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    call[[level._id_6016[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    call[[level._id_6016[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    call[[level._id_6016[var_0]]](var_1, var_2, var_3);
    return;
  }

  call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
}

_id_A5DA(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_6016)) {
    return undefined;
  }

  if(!isDefined(level._id_6016[var_0])) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    return call[[level._id_6016[var_0]]]();
  }

  if(!isDefined(var_2)) {
    return call[[level._id_6016[var_0]]](var_1);
  }

  if(!isDefined(var_3)) {
    return call[[level._id_6016[var_0]]](var_1, var_2);
  }

  if(!isDefined(var_4)) {
    return call[[level._id_6016[var_0]]](var_1, var_2, var_3);
  }

  return call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
}

_id_D07A(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_6016[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    self call[[level._id_6016[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    self call[[level._id_6016[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    self call[[level._id_6016[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    self call[[level._id_6016[var_0]]](var_1, var_2, var_3);
    return;
  }

  self call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
}

_id_CD61(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_6016[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    return self[[level._id_6016[var_0]]]();
  } else if(!isDefined(var_2)) {
    return self[[level._id_6016[var_0]]](var_1);
  } else if(!isDefined(var_3)) {
    return self[[level._id_6016[var_0]]](var_1, var_2);
  } else if(!isDefined(var_4)) {
    return self[[level._id_6016[var_0]]](var_1, var_2, var_3);
  }

  return self[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
}

_id_C019(var_0) {
  return (_func_008D(var_0) - var_0 * 0.5, _func_008D(var_0) - var_0 * 0.5, _func_008D(var_0) - var_0 * 0.5);
}

_id_C01A(var_0, var_1) {
  var_2 = _func_008E(var_0, var_1);

  if(getDvar(2) == 0) {
    var_2 = var_2 * -1;
  }

  var_3 = _func_008E(var_0, var_1);

  if(getDvar(2) == 0) {
    var_3 = var_3 * -1;
  }

  var_4 = _func_008E(var_0, var_1);

  if(getDvar(2) == 0) {
    var_4 = var_4 * -1;
  }

  return (var_2, var_3, var_4);
}

_id_DD3F(var_0) {
  if(var_0 >= 0) {
    return 1;
  }

  return -1;
}

_id_C013() {
  var_0 = _func_008D(180);
  var_1 = _func_008D(360);
  var_2 = _func_0014(var_1) * _func_0014(var_0);
  var_3 = _func_0014(var_1) * _func_0044(var_0);
  var_4 = _func_0044(var_1);
  return (var_2, var_3, var_4);
}

_id_9FC4(var_0, var_1) {
  var_2 = _func_002C(var_0 / var_1);

  if(var_0 * var_1 < 0) {
    var_2 = var_2 - 1;
  }

  return var_0 - var_2 * var_1;
}

_id_647F(var_0) {
  var_1 = [];
  var_1["axis"] = "allies";
  var_1["allies"] = "axis";
  return var_1[var_0];
}

_id_38D0(var_0) {
  self._id_56D2[var_0] = anim._id_45B1;
}

cointoss() {
  return getDvar(100) >= 50;
}

_id_3590(var_0, var_1) {
  var_2 = getDvar(var_1[var_1.size - 1] + 1);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3]) {
      return var_0[var_3];
    }
  }
}

_id_10927(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

_id_1095E(var_0, var_1, var_2) {
  if(var_1 != "death") {
    self endon("death");
  }

  var_2 endon("die");
  self waittillmatch(var_0, var_1);
  var_2 notify("returned", var_1);
}

_id_10928(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

_id_108EA(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = _func_008C();
  var_5._id_F13E = 0;

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_5);
    var_5._id_F13E++;
  }

  while(var_5._id_F13E) {
    var_5 waittill("returned");
    var_5._id_F13E--;
  }

  var_5 notify("die");
}

_id_1095D(var_0, var_1, var_2) {
  self endon("death");
  self waittillmatch(var_0, var_1);
  self notify(var_2);
}

waittill_any_return(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death")) {
    self endon("death");
  }

  var_6 = _func_008C();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_6);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_1095B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = _func_008C();

  if(isDefined(var_1)) {
    childthread _id_1095E(var_0, var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_1095E(var_0, var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_1095E(var_0, var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_1095E(var_0, var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_1095E(var_0, var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread _id_1095E(var_0, var_6, var_7);
  }

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_1089D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _func_008C();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_6);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread _id_10928(var_5, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_10892(var_0) {
  var_1 = _func_008C();
  var_2 = 0;
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];
    childthread _id_10927(var_4, var_1);

    if(var_4 == "death") {
      var_2 = 1;
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)

  if(!var_2) {
    self endon("death");
  }

  var_1 waittill("returned", var_6);
  var_1 notify("die");
  return var_6;
}

_id_10893(var_0) {
  var_1 = _func_008C();
  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];
    childthread _id_10928(var_3, var_1);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

_id_10890(var_0, var_1) {
  var_2 = _func_008C();
  var_3 = 0;
  var_4 = var_0;

  for(var_6 = _func_0022(var_4); isDefined(var_6); var_6 = _func_0024(var_4, var_6)) {
    var_5 = var_4[var_6];
    childthread _id_10927(var_5, var_2);

    if(var_5 == "death") {
      var_3 = 1;
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)

  if(!var_3) {
    self endon("death");
  }

  var_2 childthread _id_0D95(var_1);
  var_2 waittill("returned", var_7);
  var_2 notify("die");
  return var_7;
}

_id_10891(var_0, var_1) {
  var_2 = _func_008C();
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];
    childthread _id_10928(var_4, var_2);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  var_2 thread _id_0D95(var_1);
  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

_id_10879(var_0) {
  while(var_0.size) {
    var_1 = _id_10892(var_0);
    var_0 = array_remove(var_0, var_1);
  }
}

_id_108A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = _func_008C();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread _id_10927(var_6, var_7);
  }

  var_7 childthread _id_0D95(var_0);
  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_0D95(var_0) {
  self endon("die");
  wait(var_0);
  self notify("returned", "timeout");
}

_id_108AD(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _func_008C();

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread _id_10928(var_5, var_6);
  }

  var_6 childthread _id_0D95(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_1087F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_7);
  }

  self waittill(var_0);
}

_id_108B4(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  self waittill(var_0);
}

_id_10888(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 endon(var_3);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 endon(var_5);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 endon(var_7);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 endon(var_9);
  }

  if(isDefined(var_10) && isDefined(var_11)) {
    var_10 endon(var_11);
  }

  if(isDefined(var_12) && isDefined(var_13)) {
    var_12 endon(var_13);
  }

  var_0 waittill(var_1);
}

_id_1088C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("death");
  var_14 = _func_008C();
  var_0 childthread _id_10927(var_1, var_14);

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 childthread _id_10927(var_3, var_14);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 childthread _id_10927(var_5, var_14);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 childthread _id_10927(var_7, var_14);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 childthread _id_10927(var_9, var_14);
  }

  if(isDefined(var_10) && isDefined(var_11)) {
    var_10 childthread _id_10927(var_11, var_14);
  }

  if(isDefined(var_12) && isDefined(var_13)) {
    var_12 childthread _id_10927(var_13, var_14);
  }

  var_14 waittill("returned", var_15);
  var_14 notify("die");
  return var_15;
}

_id_10889(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0;

  for(var_10 = _func_0022(var_8); isDefined(var_10); var_10 = _func_0024(var_8, var_10)) {
    var_9 = var_8[var_10];

    if(var_9 != var_0[0]) {
      var_9 endon(var_1);
    }

    if(isDefined(var_2)) {
      var_9 endon(var_2);
    }

    if(isDefined(var_3)) {
      var_9 endon(var_3);
    }

    if(isDefined(var_4)) {
      var_9 endon(var_4);
    }

    if(isDefined(var_5)) {
      var_9 endon(var_5);
    }

    if(isDefined(var_6)) {
      var_9 endon(var_6);
    }

    if(isDefined(var_7)) {
      var_9 endon(var_7);
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  var_0[0] waittill(var_1);
}

_id_0393() {
  if(isDefined(self._id_0393)) {
    wait(self._id_0393);
    return 1;
  } else if(isDefined(self._id_CCFD) && isDefined(self._id_CCFB)) {
    wait(_func_008E(self._id_CCFD, self._id_CCFB));
    return 1;
  }

  return 0;
}

_id_5C0C(var_0) {
  if(!isDefined(level._id_5C00)) {
    return 0;
  }

  return isDefined(level._id_5C00[var_0]);
}

_id_5C00(var_0) {
  return _id_5C0C(var_0) && level._id_5C00[var_0];
}

_id_5C11(var_0) {
  if(!isDefined(level._id_5C00)) {
    _id_050F::_id_7F83();
  }

  level._id_5C00[var_0] = 0;
  _id_80E1();

  if(!isDefined(level._id_F5B2[var_0])) {
    level._id_F5B2[var_0] = [];
  }
}

_id_51C7(var_0) {}

_id_5C1B(var_0, var_1) {
  if(!_id_5C0C(var_0)) {
    _id_5C11(var_0);
  }

  level._id_5C00[var_0] = 1;
  _id_D3F0(var_0);

  if(isDefined(var_1)) {
    level notify(var_0, var_1);
  } else {
    level notify(var_0);
  }
}

_id_5C24(var_0) {
  var_1 = undefined;

  while(!_id_5C00(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1)) {
    return var_1;
  }
}

_id_5C04(var_0) {
  if(!_id_5C00(var_0)) {
    return;
  }
  level._id_5C00[var_0] = 0;
  _id_D3F0(var_0);
  level notify(var_0);
}

_id_5C30(var_0) {
  while(_id_5C00(var_0)) {
    level waittill(var_0);
  }
}

_id_108C5(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
  return var_1;
}

_id_F5E2(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = _func_001E(var_0, var_1);
    _id_1BE2(var_2, ::_id_F5E3);
  } else
    _id_F5E3();
}

_id_F5E3() {
  if(isDefined(self._id_C0B1)) {
    self.origin = self._id_C0B1;
  }

  self._id_F5E0 = undefined;
}

_id_F5E0(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = _func_001E(var_0, var_1);
    _id_1BE2(var_2, ::_id_F5E1);
  } else
    _id_F5E1();
}

_id_F5E1() {
  if(!isDefined(self._id_C0B1)) {
    self._id_C0B1 = self.origin;
  }

  if(self.origin == self._id_C0B1) {
    self.origin = self.origin + (0, 0, -10000);
  }

  self._id_F5E0 = 1;
  self notify("trigger_off");
}

_id_D3F0(var_0) {
  if(!isDefined(level._id_F5B2)) {
    return;
  }
  level._id_F5B2[var_0] = _id_1BD1(level._id_F5B2[var_0]);
  _id_1BE2(level._id_F5B2[var_0], ::_id_FBE0);
}

_id_FBE0() {
  var_0 = 1;

  if(isDefined(self._id_CD4A)) {
    var_0 = 0;
    var_1 = _id_3F17(self._id_CD4A);
    var_2 = var_1;

    for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
      var_3 = var_2[var_4];

      if(_id_5C00(var_3)) {
        var_0 = 1;
        break;
      }
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }

  var_5 = 1;

  if(isDefined(self._id_CD47)) {
    var_1 = _id_3F17(self._id_CD47);
    var_6 = var_1;

    for(var_7 = _func_0022(var_6); isDefined(var_7); var_7 = _func_0024(var_6, var_7)) {
      var_3 = var_6[var_7];

      if(_id_5C00(var_3)) {
        var_5 = 0;
        break;
      }
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }

  [[level._id_F5B5[var_0 && var_5]]]();
}

_id_3F17(var_0) {
  var_1 = _func_004A(var_0, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(level._id_5C00[var_1[var_2]])) {
      _id_5C11(var_1[var_2]);
    }
  }

  return var_1;
}

_id_80E1() {
  if(!_id_0FE2("trigger_flags", ::_id_80E1)) {
    return;
  }
  level._id_F5B2 = [];
  level._id_F5B5[1] = ::_id_F5E2;
  level._id_F5B5[0] = ::_id_F5E0;
}

getstruct(var_0, var_1) {
  var_2 = level._id_EA70[var_1][var_0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

getstructarray(var_0, var_1) {
  var_2 = level._id_EA70[var_1][var_0];

  if(!isDefined(var_2)) {
    return [];
  }

  return var_2;
}

_id_1019(var_0) {
  if(!isDefined(anim._id_DE28)) {
    anim._id_DE28 = [];
  }

  anim._id_DE28[anim._id_DE28.size] = var_0;
}

_id_E9B4() {
  if(!isDefined(anim._id_DE28)) {
    return;
  }
  var_0 = anim._id_DE28;

  for(var_6 = _func_0022(var_0); isDefined(var_6); var_6 = _func_0024(var_0, var_6)) {
    var_1 = var_0[var_6];

    if(isDefined(var_1._id_0399)) {
      var_2 = var_1 _id_655C();
      var_3 = var_2;

      for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
        var_4 = var_3[var_5];

        if(var_4 == var_1) {
          continue;
        }
        if(!isDefined(var_4._id_CE48)) {
          continue;
        }
        if(!isDefined(var_1._id_950A)) {
          var_1._id_950A = [];
        }

        var_1._id_950A[var_1._id_950A.size] = var_4;
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

_id_80CB() {
  if(!_id_0FE2("struct_classes", ::_id_80CB)) {
    return;
  }
  level._id_EA70 = [];
  level._id_EA70["target"] = [];
  level._id_EA70["targetname"] = [];
  level._id_EA70["script_noteworthy"] = [];
  level._id_EA70["script_linkname"] = [];
  var_0 = level._id_EA6A;

  for(var_3 = _func_0022(var_0); isDefined(var_3); var_3 = _func_0024(var_0, var_3)) {
    var_1 = var_0[var_3];

    if(isDefined(var_1._id_CE48)) {
      _id_1019(var_1);
    }

    if(isDefined(var_1._id_0481)) {
      if(var_1._id_0481 == "delete_on_load") {
        level._id_EA6A[var_3] = undefined;
        continue;
      }

      if(isDefined(level._id_EA71)) {
        if(![[level._id_EA71]](var_1)) {
          level._id_EA6A[var_3] = undefined;
          continue;
        }
      }

      if(!isDefined(level._id_EA70["targetname"][var_1._id_0481])) {
        level._id_EA70["targetname"][var_1._id_0481] = [];
      }

      var_2 = level._id_EA70["targetname"][var_1._id_0481].size;
      level._id_EA70["targetname"][var_1._id_0481][var_2] = var_1;
    }

    if(isDefined(var_1.target)) {
      if(!isDefined(level._id_EA70["target"][var_1.target])) {
        level._id_EA70["target"][var_1.target] = [];
      }

      var_2 = level._id_EA70["target"][var_1.target].size;
      level._id_EA70["target"][var_1.target][var_2] = var_1;
    }

    if(isDefined(var_1._id_039B)) {
      if(!isDefined(level._id_EA70["script_noteworthy"][var_1._id_039B])) {
        level._id_EA70["script_noteworthy"][var_1._id_039B] = [];
      }

      var_2 = level._id_EA70["script_noteworthy"][var_1._id_039B].size;
      level._id_EA70["script_noteworthy"][var_1._id_039B][var_2] = var_1;
    }

    if(isDefined(var_1._id_0398)) {
      if(!isDefined(level._id_EA70["script_linkname"][var_1._id_0398])) {
        level._id_EA70["script_linkname"][var_1._id_0398] = [];
      }

      var_2 = level._id_EA70["script_linkname"][var_1._id_0398].size;
      level._id_EA70["script_linkname"][var_1._id_0398][var_2] = var_1;
    }
  }

  __asm_var_clear(2)
  _id_E9B4();
}

_id_4795(var_0, var_1, var_2) {
  var_3 = getstructarray(var_0, var_1);
  _id_4796(var_3, var_2);
}

_id_4794(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0._id_0398;

  if(isDefined(var_1) && isDefined(level._id_EA70["script_linkname"]) && isDefined(level._id_EA70["script_linkname"][var_1])) {
    var_2 = level._id_EA70["script_linkname"][var_1];

    for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
      var_3 = var_2[var_4];

      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["script_linkname"][var_1][var_4] = undefined;
      }
    }

    __asm_var_clear(2)

    if(level._id_EA70["script_linkname"][var_1].size == 0) {
      level._id_EA70["script_linkname"][var_1] = undefined;
    }
  }

  var_1 = var_0._id_039B;

  if(isDefined(var_1) && isDefined(level._id_EA70["script_noteworthy"]) && isDefined(level._id_EA70["script_noteworthy"][var_1])) {
    var_5 = level._id_EA70["script_noteworthy"][var_1];

    for(var_4 = _func_0022(var_5); isDefined(var_4); var_4 = _func_0024(var_5, var_4)) {
      var_3 = var_5[var_4];

      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["script_noteworthy"][var_1][var_4] = undefined;
      }
    }

    __asm_var_clear(2)

    if(level._id_EA70["script_noteworthy"][var_1].size == 0) {
      level._id_EA70["script_noteworthy"][var_1] = undefined;
    }
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level._id_EA70["target"]) && isDefined(level._id_EA70["target"][var_1])) {
    var_6 = level._id_EA70["target"][var_1];

    for(var_4 = _func_0022(var_6); isDefined(var_4); var_4 = _func_0024(var_6, var_4)) {
      var_3 = var_6[var_4];

      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["target"][var_1][var_4] = undefined;
      }
    }

    __asm_var_clear(2)

    if(level._id_EA70["target"][var_1].size == 0) {
      level._id_EA70["target"][var_1] = undefined;
    }
  }

  var_1 = var_0._id_0481;

  if(isDefined(var_1) && isDefined(level._id_EA70["targetname"]) && isDefined(level._id_EA70["targetname"][var_1])) {
    var_7 = level._id_EA70["targetname"][var_1];

    for(var_4 = _func_0022(var_7); isDefined(var_4); var_4 = _func_0024(var_7, var_4)) {
      var_3 = var_7[var_4];

      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["targetname"][var_1][var_4] = undefined;
      }
    }

    __asm_var_clear(2)

    if(level._id_EA70["targetname"][var_1].size == 0) {
      level._id_EA70["targetname"][var_1] = undefined;
    }
  }

  if(isDefined(level._id_EA6A)) {
    var_8 = level._id_EA6A;

    for(var_4 = _func_0022(var_8); isDefined(var_4); var_4 = _func_0024(var_8, var_4)) {
      var_3 = var_8[var_4];

      if(var_0 == var_3) {
        level._id_EA6A[var_4] = undefined;
      }
    }

    __asm_var_clear(2)
  }
}

_id_4796(var_0, var_1) {
  if(!isDefined(var_0) || !_func_002E(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = ter_op(isDefined(var_1), var_1, 0);
  var_1 = ter_op(var_1 > 0, var_1, 0);

  if(var_1 > 0) {
    var_2 = var_0;

    for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
      var_3 = var_2[var_4];
      _id_4794(var_3);
      wait(var_1);
    }

    __asm_var_clear(1)
    __asm_var_clear(0)
  } else {
    var_5 = var_0;

    for(var_6 = _func_0022(var_5); isDefined(var_6); var_6 = _func_0024(var_5, var_6)) {
      var_3 = var_5[var_6];
      _id_4794(var_3);
    }

    __asm_var_clear(1)
    __asm_var_clear(0)
  }
}

_id_6D99(var_0, var_1) {
  var_2 = getstruct(var_0, var_1);
  _id_4794(var_2);
  return var_2;
}

_id_6D9B(var_0, var_1, var_2) {
  var_3 = getstructarray(var_0, var_1);
  _id_4796(var_3, var_2);
  return var_3;
}

_id_2F17(var_0, var_1, var_2, var_3) {
  childthread _id_2F19(var_0, var_1, var_2, var_3);
}

_id_2F16(var_0, var_1, var_2, var_3) {
  self endon("death");
  childthread _id_2F19(var_0, var_1, var_2, var_3);
}

_id_2F19(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3)) {
    self call[[var_1]](var_2, var_3);
  } else if(isDefined(var_2)) {
    self call[[var_1]](var_2);
  } else {
    self call[[var_1]]();
  }
}

_id_F126(var_0, var_1, var_2, var_3, var_4) {
  childthread _id_F127(var_0, var_1, var_2, var_3, var_4);
}

_id_F125(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(isDefined(var_5) && isDefined(var_6)) {
    if(!_func_002E(var_5)) {
      var_5 = [var_5];
    }

    if(!_func_002E(var_6)) {
      var_6 = [var_6];
    }

    var_7 = var_5;

    for(var_12 = _func_0022(var_7); isDefined(var_12); var_12 = _func_0024(var_7, var_12)) {
      var_8 = var_7[var_12];
      var_9 = var_6;

      for(var_11 = _func_0022(var_9); isDefined(var_11); var_11 = _func_0024(var_9, var_11)) {
        var_10 = var_9[var_11];
        var_8 endon(var_10);
      }

      __asm_var_clear(3)
      __asm_var_clear(1)
    }

    __asm_var_clear(5)
    __asm_var_clear(0)
  }

  childthread _id_F127(var_0, var_1, var_2, var_3, var_4);
}

_id_F127(var_0, var_1, var_2, var_3, var_4) {
  self waittill(var_0);

  if(!isDefined(var_4)) {
    var_4 = self;
  }

  if(isDefined(var_3)) {
    var_4 thread[[var_1]](var_2, var_3);
  } else if(isDefined(var_2)) {
    var_4 thread[[var_1]](var_2);
  } else {
    var_4 thread[[var_1]]();
  }
}

_id_46A5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread _id_46A6(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

_id_46A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  wait(var_1);

  if(isDefined(var_13)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  } else if(isDefined(var_12)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  } else if(isDefined(var_11)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  } else if(isDefined(var_10)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_9)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_8)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    self call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    self call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    self call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    self call[[var_0]](var_2);
  } else {
    self call[[var_0]]();
  }
}

string_starts_with(var_0, var_1) {
  if(var_0.size < var_1.size) {
    return 0;
  }

  var_2 = _func_002A(var_0, 0, var_1.size);

  if(var_2 == var_1) {
    return 1;
  }

  return 0;
}

array_add(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

_id_1B8D(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0)) {
    var_0[0] = var_1;
  } else {
    var_0[var_0.size] = var_1;
  }

  return var_0;
}

_id_1BB3(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}

array_combine(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_0)) {
    var_6 = var_0;

    for(var_8 = _func_0022(var_6); isDefined(var_8); var_8 = _func_0024(var_6, var_8)) {
      var_7 = var_6[var_8];
      var_5[var_5.size] = var_7;
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }

  if(isDefined(var_1)) {
    var_9 = var_1;

    for(var_10 = _func_0022(var_9); isDefined(var_10); var_10 = _func_0024(var_9, var_10)) {
      var_7 = var_9[var_10];
      var_5[var_5.size] = var_7;
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }

  if(isDefined(var_2)) {
    var_11 = var_2;

    for(var_12 = _func_0022(var_11); isDefined(var_12); var_12 = _func_0024(var_11, var_12)) {
      var_7 = var_11[var_12];
      var_5[var_5.size] = var_7;
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }

  if(isDefined(var_3)) {
    var_13 = var_3;

    for(var_14 = _func_0022(var_13); isDefined(var_14); var_14 = _func_0024(var_13, var_14)) {
      var_7 = var_13[var_14];
      var_5[var_5.size] = var_7;
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }

  if(isDefined(var_4)) {
    var_15 = var_4;

    for(var_16 = _func_0022(var_15); isDefined(var_16); var_16 = _func_0024(var_15, var_16)) {
      var_7 = var_15[var_16];
      var_5[var_5.size] = var_7;
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }

  return var_5;
}

_id_1B9B(var_0) {
  var_1 = [];
  var_2 = var_0;

  for(var_7 = _func_0022(var_2); isDefined(var_7); var_7 = _func_0024(var_2, var_7)) {
    var_3 = var_2[var_7];
    var_4 = var_3;

    for(var_6 = _func_0022(var_4); isDefined(var_6); var_6 = _func_0024(var_4, var_6)) {
      var_5 = var_4[var_6];
      var_1[var_1.size] = var_5;
    }

    __asm_var_clear(3)
    __asm_var_clear(1)
  }

  __asm_var_clear(5)
  __asm_var_clear(0)
  return var_1;
}

_id_1B9D(var_0, var_1) {
  var_2 = [];
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];
    var_2[var_2.size] = var_4;
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  var_6 = var_1;

  for(var_7 = _func_0022(var_6); isDefined(var_7); var_7 = _func_0024(var_6, var_7)) {
    var_4 = var_6[var_7];

    if(array_contains(var_2, var_4)) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  __asm_var_clear(1)
  __asm_var_clear(0)
  return var_2;
}

_id_1B9C(var_0, var_1) {
  var_2 = [];
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];
    var_2[var_5] = var_4;
  }

  __asm_var_clear(2)
  var_6 = var_1;

  for(var_5 = _func_0022(var_6); isDefined(var_5); var_5 = _func_0024(var_6, var_5)) {
    var_4 = var_6[var_5];
    var_2[var_5] = var_4;
  }

  __asm_var_clear(0)
  return var_2;
}

_id_1BB4(var_0, var_1) {
  var_2 = [];
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];

    if(array_contains(var_1, var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  return var_2;
}

array_randomize(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = getdvarfloat(var_1, var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

_id_1BBD(var_0) {
  var_1 = [];

  for(var_2 = var_0; var_2.size > 0; var_2 = var_4) {
    var_3 = getdvarfloat(0, var_2.size);
    var_4 = [];
    var_5 = 0;
    var_6 = var_2;

    for(var_8 = _func_0022(var_6); isDefined(var_8); var_8 = _func_0024(var_6, var_8)) {
      var_7 = var_6[var_8];

      if(var_5 == var_3) {
        var_1[ter_op(_func_0034(var_8), var_8, var_1.size)] = var_7;
      } else {
        var_4[ter_op(_func_0034(var_8), var_8, var_4.size)] = var_7;
      }

      var_5++;
    }

    __asm_var_clear(2)
  }

  return var_1;
}

_id_1BD2(var_0) {
  var_1 = [];

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

array_contains(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;
  }

  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];

    if(var_3 == var_1) {
      return 1;
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  return 0;
}

_id_1BA1(var_0, var_1) {
  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];

    if(var_4 == var_1) {
      return 1;
    }
  }

  __asm_var_clear(2)
  return 0;
}

_id_1BAB(var_0, var_1) {
  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];

    if(var_3 == var_1) {
      return var_4;
    }
  }

  __asm_var_clear(2)
  return undefined;
}

array_remove(var_0, var_1) {
  var_2 = [];
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];

    if(var_4 != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  return var_2;
}

_id_1BBF(var_0, var_1) {
  var_2 = var_1;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];
    var_0 = array_remove(var_0, var_3);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  return var_0;
}

array_remove_index(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = var_0;

  for(var_7 = _func_0022(var_4); isDefined(var_7); var_7 = _func_0024(var_4, var_7)) {
    var_5 = var_4[var_7];

    if(var_7 == var_1) {
      continue;
    }
    if(istrue(var_2)) {
      var_6 = var_7;
    } else {
      var_6 = var_3.size;
    }

    var_3[var_6] = var_5;
  }

  __asm_var_clear(3)
  return var_3;
}

_id_1BD1(var_0) {
  var_1 = [];
  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];

    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  __asm_var_clear(2)
  return var_1;
}

_id_1BC6(var_0, var_1) {
  var_2 = [];
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];

    if(var_1 == var_5) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  __asm_var_clear(2)
  return var_2;
}

_id_1BC1(var_0) {
  var_1 = [];
  var_2 = var_0;

  for(var_8 = _func_0022(var_2); isDefined(var_8); var_8 = _func_0024(var_2, var_8)) {
    var_3 = var_2[var_8];

    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = 1;
    var_5 = var_1;

    for(var_7 = _func_0022(var_5); isDefined(var_7); var_7 = _func_0024(var_5, var_7)) {
      var_6 = var_5[var_7];

      if(var_3 == var_6) {
        var_4 = 0;
        break;
      }
    }

    __asm_var_clear(3)
    __asm_var_clear(1)

    if(var_4) {
      var_1[var_1.size] = var_3;
    }
  }

  __asm_var_clear(6)
  __asm_var_clear(0)
  return var_1;
}

_id_1BB7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = var_0;

    for(var_7 = _func_0022(var_5); isDefined(var_7); var_7 = _func_0024(var_5, var_7)) {
      var_6 = var_5[var_7];
      thread[[var_1]](var_6, var_2, var_3, var_4);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_3)) {
    var_8 = var_0;

    for(var_9 = _func_0022(var_8); isDefined(var_9); var_9 = _func_0024(var_8, var_9)) {
      var_6 = var_8[var_9];
      thread[[var_1]](var_6, var_2, var_3);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_2)) {
    var_10 = var_0;

    for(var_11 = _func_0022(var_10); isDefined(var_11); var_11 = _func_0024(var_10, var_11)) {
      var_6 = var_10[var_11];
      thread[[var_1]](var_6, var_2);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  var_12 = var_0;

  for(var_13 = _func_0022(var_12); isDefined(var_13); var_13 = _func_0024(var_12, var_13)) {
    var_6 = var_12[var_13];
    thread[[var_1]](var_6);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

_id_1BB6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = var_0;

    for(var_7 = _func_0022(var_5); isDefined(var_7); var_7 = _func_0024(var_5, var_7)) {
      var_6 = var_5[var_7];
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_3)) {
    var_8 = var_0;

    for(var_9 = _func_0022(var_8); isDefined(var_9); var_9 = _func_0024(var_8, var_9)) {
      var_6 = var_8[var_9];
      call[[var_1]](var_6, var_2, var_3);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_2)) {
    var_10 = var_0;

    for(var_11 = _func_0022(var_10); isDefined(var_11); var_11 = _func_0024(var_10, var_11)) {
      var_6 = var_10[var_11];
      call[[var_1]](var_6, var_2);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  var_12 = var_0;

  for(var_13 = _func_0022(var_12); isDefined(var_13); var_13 = _func_0024(var_12, var_13)) {
    var_6 = var_12[var_13];
    call[[var_1]](var_6);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

_id_1BD6(var_0, var_1) {
  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_4 = var_2 - 1; var_4 >= 0 && ![[var_1]](var_0[var_4], var_3); var_4--) {
      var_0[var_4 + 1] = var_0[var_4];
    }

    var_0[var_4 + 1] = var_3;
  }

  return var_0;
}

_id_1B97(var_0) {
  return _id_1BE1(var_0) / var_0.size;
}

_id_1BE1(var_0) {
  var_1 = 0;
  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];
    var_1 = var_1 + var_3;
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  return var_1;
}

_id_1BA7(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] = var_0[var_2] / var_1;
  }

  return var_0;
}

random(var_0) {
  var_1 = [];
  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];
    var_1[var_1.size] = var_3;
  }

  __asm_var_clear(2)

  if(!var_1.size) {
    return undefined;
  }

  return var_1[getDvar(var_1.size)];
}

_id_BFF2(var_0) {
  var_1 = [];
  var_2 = var_0;

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];
    var_1[var_1.size] = var_3;
  }

  __asm_var_clear(2)

  if(!var_1.size) {
    return undefined;
  }

  var_5 = getDvar(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - _func_002C(_func_0047(var_5))];
}

_id_163E(var_0) {
  if(var_0.size <= 1) {
    return var_0;
  }

  var_1 = 0;

  for(var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
      var_6 = var_0[var_5];

      if(_func_0049(var_6, var_3) > 0) {
        var_3 = var_6;
        var_4 = var_5;
      }
    }

    if(var_4 != var_2) {
      var_0[var_4] = var_0[var_2];
      var_0[var_2] = var_3;
    }
  }

  return var_0;
}

_id_1BE3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_3)) {
    var_12 = var_0;

    for(var_14 = _func_0022(var_12); isDefined(var_14); var_14 = _func_0024(var_12, var_14)) {
      var_13 = var_12[var_14];
      var_13 thread[[var_1]]();
      wait(var_2);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  } else {
    if(!isDefined(var_4)) {
      var_15 = var_0;

      for(var_16 = _func_0022(var_15); isDefined(var_16); var_16 = _func_0024(var_15, var_16)) {
        var_13 = var_15[var_16];
        var_13 thread[[var_1]](var_3);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    if(!isDefined(var_5)) {
      var_17 = var_0;

      for(var_18 = _func_0022(var_17); isDefined(var_18); var_18 = _func_0024(var_17, var_18)) {
        var_13 = var_17[var_18];
        var_13 thread[[var_1]](var_3, var_4);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    if(!isDefined(var_6)) {
      var_19 = var_0;

      for(var_20 = _func_0022(var_19); isDefined(var_20); var_20 = _func_0024(var_19, var_20)) {
        var_13 = var_19[var_20];
        var_13 thread[[var_1]](var_3, var_4, var_5);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    if(!isDefined(var_7)) {
      var_21 = var_0;

      for(var_22 = _func_0022(var_21); isDefined(var_22); var_22 = _func_0024(var_21, var_22)) {
        var_13 = var_21[var_22];
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    if(!isDefined(var_8)) {
      var_23 = var_0;

      for(var_24 = _func_0022(var_23); isDefined(var_24); var_24 = _func_0024(var_23, var_24)) {
        var_13 = var_23[var_24];
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    if(!isDefined(var_9)) {
      var_25 = var_0;

      for(var_26 = _func_0022(var_25); isDefined(var_26); var_26 = _func_0024(var_25, var_26)) {
        var_13 = var_25[var_26];
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    if(!isDefined(var_10)) {
      var_27 = var_0;

      for(var_28 = _func_0022(var_27); isDefined(var_28); var_28 = _func_0024(var_27, var_28)) {
        var_13 = var_27[var_28];
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    if(!isDefined(var_11)) {
      var_29 = var_0;

      for(var_30 = _func_0022(var_29); isDefined(var_30); var_30 = _func_0024(var_29, var_30)) {
        var_13 = var_29[var_30];
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
        wait(var_2);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
      return;
    }

    var_31 = var_0;

    for(var_32 = _func_0022(var_31); isDefined(var_32); var_32 = _func_0024(var_31, var_32)) {
      var_13 = var_31[var_32];
      var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      wait(var_2);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
  }
}

_id_1BE2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_10)) {
    var_11 = var_0;

    for(var_13 = _func_0022(var_11); isDefined(var_13); var_13 = _func_0024(var_11, var_13)) {
      var_12 = var_11[var_13];
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_9)) {
    var_14 = var_0;

    for(var_15 = _func_0022(var_14); isDefined(var_15); var_15 = _func_0024(var_14, var_15)) {
      var_12 = var_14[var_15];
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_8)) {
    var_16 = var_0;

    for(var_17 = _func_0022(var_16); isDefined(var_17); var_17 = _func_0024(var_16, var_17)) {
      var_12 = var_16[var_17];
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_7)) {
    var_18 = var_0;

    for(var_19 = _func_0022(var_18); isDefined(var_19); var_19 = _func_0024(var_18, var_19)) {
      var_12 = var_18[var_19];
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_6)) {
    var_20 = var_0;

    for(var_21 = _func_0022(var_20); isDefined(var_21); var_21 = _func_0024(var_20, var_21)) {
      var_12 = var_20[var_21];
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_5)) {
    var_22 = var_0;

    for(var_23 = _func_0022(var_22); isDefined(var_23); var_23 = _func_0024(var_22, var_23)) {
      var_12 = var_22[var_23];
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_4)) {
    var_24 = var_0;

    for(var_25 = _func_0022(var_24); isDefined(var_25); var_25 = _func_0024(var_24, var_25)) {
      var_12 = var_24[var_25];
      var_12 thread[[var_1]](var_2, var_3, var_4);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_3)) {
    var_26 = var_0;

    for(var_27 = _func_0022(var_26); isDefined(var_27); var_27 = _func_0024(var_26, var_27)) {
      var_12 = var_26[var_27];
      var_12 thread[[var_1]](var_2, var_3);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_2)) {
    var_28 = var_0;

    for(var_29 = _func_0022(var_28); isDefined(var_29); var_29 = _func_0024(var_28, var_29)) {
      var_12 = var_28[var_29];
      var_12 thread[[var_1]](var_2);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  var_30 = var_0;

  for(var_31 = _func_0022(var_30); isDefined(var_31); var_31 = _func_0024(var_30, var_31)) {
    var_12 = var_30[var_31];
    var_12 thread[[var_1]]();
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

_id_1B98(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9)) {
    var_10 = var_0;

    for(var_12 = _func_0022(var_10); isDefined(var_12); var_12 = _func_0024(var_10, var_12)) {
      var_11 = var_10[var_12];
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_8)) {
    var_13 = var_0;

    for(var_14 = _func_0022(var_13); isDefined(var_14); var_14 = _func_0024(var_13, var_14)) {
      var_11 = var_13[var_14];
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_7)) {
    var_15 = var_0;

    for(var_16 = _func_0022(var_15); isDefined(var_16); var_16 = _func_0024(var_15, var_16)) {
      var_11 = var_15[var_16];
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_6)) {
    var_17 = var_0;

    for(var_18 = _func_0022(var_17); isDefined(var_18); var_18 = _func_0024(var_17, var_18)) {
      var_11 = var_17[var_18];
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_5)) {
    var_19 = var_0;

    for(var_20 = _func_0022(var_19); isDefined(var_20); var_20 = _func_0024(var_19, var_20)) {
      var_11 = var_19[var_20];
      var_11 call[[var_1]](var_2, var_3, var_4, var_5);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_4)) {
    var_21 = var_0;

    for(var_22 = _func_0022(var_21); isDefined(var_22); var_22 = _func_0024(var_21, var_22)) {
      var_11 = var_21[var_22];
      var_11 call[[var_1]](var_2, var_3, var_4);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_3)) {
    var_23 = var_0;

    for(var_24 = _func_0022(var_23); isDefined(var_24); var_24 = _func_0024(var_23, var_24)) {
      var_11 = var_23[var_24];
      var_11 call[[var_1]](var_2, var_3);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_2)) {
    var_25 = var_0;

    for(var_26 = _func_0022(var_25); isDefined(var_26); var_26 = _func_0024(var_25, var_26)) {
      var_11 = var_25[var_26];
      var_11 call[[var_1]](var_2);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  var_27 = var_0;

  for(var_28 = _func_0022(var_27); isDefined(var_28); var_28 = _func_0024(var_27, var_28)) {
    var_11 = var_27[var_28];
    var_11 call[[var_1]]();
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

_id_5CD9(var_0) {
  var_1 = (0, var_0[1], 0);
  return var_1;
}

_id_5CDA(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  return var_1;
}

_id_5CDB(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 1);
  }

  var_2 = earthquake(var_0 - distance2dsquared(var_1, var_0) * var_1);
  return var_2;
}

getfx(var_0) {
  return level._effect[var_0];
}

_id_608B(var_0) {
  return isDefined(level._effect[var_0]);
}

_id_108F5(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_108F7(var_0, var_1) {
  var_2 = _func_008C();
  thread _id_108F8(var_2, var_0);
  thread _id_10934(var_2, var_1);
  var_2 waittill("waittill_proc", var_3);
  return var_3;
}

_id_108F8(var_0, var_1) {
  var_0 endon("waittill_proc");
  self waittill(var_1);
  var_0 notify("waittill_proc", var_1);
}

_id_10934(var_0, var_1) {
  var_0 endon("waittill_proc");
  wait(var_1);
  var_0 notify("waittill_proc", "timeout");
}

_id_1BE7(var_0, var_1, var_2) {
  var_3 = _func_008C();

  if(istrue(var_2)) {
    thread _id_1BEB(var_3, var_2);
    var_3 endon("array_wait_timeout");
  }

  var_4 = var_0;

  for(var_6 = _func_0022(var_4); isDefined(var_6); var_6 = _func_0024(var_4, var_6)) {
    var_5 = var_4[var_6];
    thread _id_1BEA(var_3, var_5, var_1);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_3 waittill("array_wait_proc");
  }

  var_3 notify("array_wait_success");
}

_id_1BEA(var_0, var_1, var_2) {
  var_0 endon("array_wait_success");
  var_1 _id_1087F(var_2, "death");
  var_0 notify("array_wait_proc");
}

_id_1BEB(var_0, var_1) {
  var_0 endon("array_wait_success");
  wait(var_1);
  var_0 notify("array_wait_timeout");
}

_id_6562() {
  return _func_004A(self._id_0399, " ");
}

ter_op(var_0, var_1, var_2) {
  if(var_0) {
    return var_1;
  }

  return var_2;
}

_id_3F35(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(level._id_96E1)) {
    level._id_96E1 = [];
  }

  var_2 = _func_008C();
  var_2._id_9C0E = var_1;
  var_2._id_011A = 0;
  level._id_96E1[var_0] = var_2;
}

_id_96E1(var_0) {
  var_1 = level._id_96E1[var_0];

  while(var_1._id_011A >= var_1._id_9C0E) {
    var_1 waittill("unlocked");
  }

  var_1._id_011A++;
}

_id_F981(var_0) {
  thread _id_F987(var_0);
}

_id_F987(var_0) {
  wait 0.05;
  var_1 = level._id_96E1[var_0];
  var_1._id_011A--;
  var_1 notify("unlocked");
}

_id_F98A(var_0) {
  thread _id_F987(var_0);
  wait 0.05;
}

_id_4B8C(var_0, var_1) {
  return _func_0038(var_0 - var_1);
}

_id_10E76(var_0, var_1, var_2, var_3) {
  var_4 = earthquake(var_2 - var_0);
  var_5 = _func_0007(var_1);
  var_6 = distance2dsquared(var_5, var_4);
  return var_6 >= var_3;
}

_id_3F1B(var_0, var_1) {
  if(!isDefined(level._id_6016)) {
    level._id_6016 = [];
  }

  level._id_6016[var_0] = var_1;
}

_id_3F04(var_0) {
  if(!isDefined(level._id_6016)) {
    level._id_6016 = [];
  }

  if(!isDefined(level._id_6016[var_0])) {
    _id_3F1B(var_0, ::_id_51C7);
  }
}

_id_602B(var_0) {
  return isDefined(level._id_6016) && isDefined(level._id_6016[var_0]);
}

_id_0FE2(var_0, var_1) {
  if(!isDefined(level._id_809F)) {
    level._id_809F = [];
  }

  if(isDefined(level._id_809F[var_0])) {
    return 0;
  }

  level._id_809F[var_0] = var_1;
  return 1;
}

_id_0FDA(var_0) {
  if(!isDefined(self._id_5F37)) {
    self._id_5F37 = [var_0];
    thread _id_BD4E();
  } else
    self._id_5F37[self._id_5F37.size] = var_0;
}

_id_BD4E() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var_0 = self._id_5F37;

    for(var_2 = _func_0022(var_0); isDefined(var_2); var_2 = _func_0024(var_0, var_2)) {
      var_1 = var_0[var_2];
      self thread[[var_1]]();
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    waitframe();
  }
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_46E5(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_46E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(var_1);

  if(isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    thread[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    thread[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    thread[[var_0]](var_2);
  } else {
    thread[[var_0]]();
  }
}

_id_430E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self._id_0148)) {
    if(!isDefined(var_0)) {
      return 0;
    }

    if(self._id_0148 == var_0) {
      return 1;
    }

    if(!isDefined(var_1)) {
      return 0;
    }

    if(self._id_0148 == var_1) {
      return 1;
    }

    if(!isDefined(var_2)) {
      return 0;
    }

    if(self._id_0148 == var_2) {
      return 1;
    }

    if(!isDefined(var_3)) {
      return 0;
    }

    if(self._id_0148 == var_3) {
      return 1;
    }

    if(!isDefined(var_4)) {
      return 0;
    }

    if(self._id_0148 == var_4) {
      return 1;
    }

    if(!isDefined(var_5)) {
      return 0;
    }

    if(self._id_0148 == var_5) {
      return 1;
    }

    if(!isDefined(var_6)) {
      return 0;
    }

    if(self._id_0148 == var_6) {
      return 1;
    }

    if(!isDefined(var_7)) {
      return 0;
    }

    if(self._id_0148 == var_7) {
      return 1;
    }

    if(!isDefined(var_8)) {
      return 0;
    }

    if(self._id_0148 == var_8) {
      return 1;
    }

    if(!isDefined(var_9)) {
      return 0;
    }

    if(self._id_0148 == var_9) {
      return 1;
    }

    if(!isDefined(var_10)) {
      return 0;
    }

    if(self._id_0148 == var_10) {
      return 1;
    }
  }

  return _id_432E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_432E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self._id_42F8)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(self._id_42F8 == var_0) {
    return 1;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(self._id_42F8 == var_1) {
    return 1;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(self._id_42F8 == var_2) {
    return 1;
  }

  if(!isDefined(var_3)) {
    return 0;
  }

  if(self._id_42F8 == var_3) {
    return 1;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  if(self._id_42F8 == var_4) {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 0;
  }

  if(self._id_42F8 == var_5) {
    return 1;
  }

  if(!isDefined(var_6)) {
    return 0;
  }

  if(self._id_42F8 == var_6) {
    return 1;
  }

  if(!isDefined(var_7)) {
    return 0;
  }

  if(self._id_42F8 == var_7) {
    return 1;
  }

  if(!isDefined(var_8)) {
    return 0;
  }

  if(self._id_42F8 == var_8) {
    return 1;
  }

  if(!isDefined(var_9)) {
    return 0;
  }

  if(self._id_42F8 == var_9) {
    return 1;
  }

  if(!isDefined(var_10)) {
    return 0;
  }

  if(self._id_42F8 == var_10) {
    return 1;
  }

  return 0;
}

_id_8794(var_0) {
  var_1 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(_func_0035(var_1, var_0)) {
    return 1;
  }

  return 0;
}

is_equal(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && var_0 == var_1) {
    return 1;
  }

  return 0;
}

_id_5C1C(var_0, var_1, var_2) {
  wait(var_1);
  _id_5C1B(var_0, var_2);
}

_id_A5D6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = var_0;

    for(var_7 = _func_0022(var_5); isDefined(var_7); var_7 = _func_0024(var_5, var_7)) {
      var_6 = var_5[var_7];
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_3)) {
    var_8 = var_0;

    for(var_9 = _func_0022(var_8); isDefined(var_9); var_9 = _func_0024(var_8, var_9)) {
      var_6 = var_8[var_9];
      call[[var_1]](var_6, var_2, var_3);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  if(isDefined(var_2)) {
    var_10 = var_0;

    for(var_11 = _func_0022(var_10); isDefined(var_11); var_11 = _func_0024(var_10, var_11)) {
      var_6 = var_10[var_11];
      call[[var_1]](var_6, var_2);
    }

    __asm_var_clear(2)
    __asm_var_clear(0)
    return;
  }

  var_12 = var_0;

  for(var_13 = _func_0022(var_12); isDefined(var_13); var_13 = _func_0024(var_12, var_13)) {
    var_6 = var_12[var_13];
    call[[var_1]](var_6);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

_id_5C02(var_0) {}

_id_5C2B(var_0, var_1) {
  for(;;) {
    if(_id_5C00(var_0)) {
      return;
    }
    if(_id_5C00(var_1)) {
      return;
    }
    level _id_108C5(var_0, var_1);
  }
}

_id_5C2D(var_0, var_1) {
  for(;;) {
    if(_id_5C00(var_0)) {
      return var_0;
    }

    if(_id_5C00(var_1)) {
      return var_1;
    }

    var_2 = level waittill_any_return(var_0, var_1);
    return var_2;
  }
}

_id_5C27(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_5)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = var_5;
  } else if(isDefined(var_4)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
  } else if(isDefined(var_3)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
  } else if(isDefined(var_2)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
  } else if(isDefined(var_1)) {
    _id_5C2B(var_0, var_1);
    return;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(_id_5C00(var_6[var_7])) {
        return;
      }
    }

    level _id_1087F(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_5C29(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_4)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
    var_5[var_5.size] = var_4;
  } else if(isDefined(var_3)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
  } else if(isDefined(var_2)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
  } else if(isDefined(var_1)) {
    var_6 = _id_5C2D(var_0, var_1);
    return var_6;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(_id_5C00(var_5[var_7])) {
        return var_5[var_7];
      }
    }

    var_6 = level waittill_any_return(var_0, var_1, var_2, var_3, var_4);
    return var_6;
  }
}

_id_5C25(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    _id_5C24(var_0);
  }

  if(isDefined(var_1)) {
    _id_5C24(var_1);
  }

  if(isDefined(var_2)) {
    _id_5C24(var_2);
  }

  if(isDefined(var_3)) {
    _id_5C24(var_3);
  }
}

_id_1070F(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

_id_A5D7(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_A5D8(var_1, var_0, var_2, var_3, var_4, var_5);
}

_id_A5D8(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_1);

  if(isDefined(var_5)) {
    call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    call[[var_0]](var_2);
  } else {
    call[[var_0]]();
  }
}

_id_6420(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

_id_10699() {}

_id_108E4(var_0, var_1, var_2) {
  var_3 = _func_008C();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::_id_D0AE, "complete");
  self waittillmatch(var_0, var_1);
}

_id_108E5(var_0, var_1, var_2) {
  var_3 = _func_008C();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::_id_D0AE, "complete");
  self waittill(var_0, var_1);
  return var_1;
}

_id_D0AE(var_0, var_1) {
  if(isDefined(var_1)) {
    self notify(var_0, var_1);
  } else {
    self notify(var_0);
  }
}

_id_A2AF(var_0) {
  return var_0 * 17.6;
}

_id_853A(var_0) {
  return var_0 * 0.056818;
}

_id_39ED(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_2;
  var_5 = var_3 - var_2;

  if(abs(var_5[0]) < 0.000001 && abs(var_5[1]) < 0.000001 && abs(var_5[2]) < 0.000001) {
    return undefined;
  }

  var_6 = var_1 - var_0;

  if(abs(var_6[0]) < 0.000001 && abs(var_6[1]) < 0.000001 && abs(var_6[2]) < 0.000001) {
    return undefined;
  }

  var_7 = var_4[0] * var_5[0] + var_4[1] * var_5[1] + var_4[2] * var_5[2];
  var_8 = var_5[0] * var_6[0] + var_5[1] * var_6[1] + var_5[2] * var_6[2];
  var_9 = var_4[0] * var_6[0] + var_4[1] * var_6[1] + var_4[2] * var_6[2];
  var_10 = var_5[0] * var_5[0] + var_5[1] * var_5[1] + var_5[2] * var_5[2];
  var_11 = var_6[0] * var_6[0] + var_6[1] * var_6[1] + var_6[2] * var_6[2];
  var_12 = var_11 * var_10 - var_8 * var_8;

  if(abs(var_12) < 0.000001) {
    return undefined;
  }

  var_13 = var_7 * var_8 - var_9 * var_10;
  var_14 = var_13 / var_12;
  var_15 = (var_7 + var_8 * var_14) / var_10;
  var_16 = var_0 + var_14 * var_6;
  var_17 = var_2 + var_15 * var_5;
  var_18 = [var_16, var_17, _func_0015(var_16, var_17)];
  return var_18;
}

_id_39EE(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = var_3 - var_2;
  var_6 = var_0 - var_2;
  var_7 = distance2dsquared(var_4, var_4);
  var_8 = distance2dsquared(var_4, var_5);
  var_9 = distance2dsquared(var_5, var_5);
  var_10 = distance2dsquared(var_4, var_6);
  var_11 = distance2dsquared(var_5, var_6);
  var_12 = var_7 * var_9 - var_8 * var_8;
  var_13 = var_12;
  var_14 = var_12;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;

  if(var_12 < 0.00000001) {
    var_16 = 0;
    var_13 = 1;
    var_18 = var_11;
    var_14 = var_9;
  } else {
    var_16 = var_8 * var_11 - var_9 * var_10;
    var_18 = var_7 * var_11 - var_8 * var_10;

    if(var_16 < 0.0) {
      var_16 = 0;
      var_18 = var_11;
      var_14 = var_9;
    } else if(var_16 > var_13) {
      var_16 = var_13;
      var_18 = var_11 + var_8;
      var_14 = var_9;
    }
  }

  if(var_18 < 0.0) {
    var_18 = 0.0;

    if(var_10 * -1 < 0.0) {
      var_16 = 0.0;
    } else if(var_10 * -1 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_10 * -1;
      var_13 = var_7;
    }
  } else if(var_18 > var_14) {
    var_18 = var_14;

    if(var_8 - var_10 < 0.0) {
      var_16 = 0;
    } else if(var_8 - var_10 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_8 - var_10;
      var_13 = var_7;
    }
  }

  if(abs(var_16) > 0.00000001) {
    var_15 = var_16 / var_13;
  }

  if(abs(var_18) > 0.00000001) {
    var_17 = var_18 / var_14;
  }

  var_19 = var_0 + var_15 * var_4;
  var_20 = var_2 + var_17 * var_5;
  var_21 = [var_19, var_20, _func_0015(var_19, var_20)];
  return var_21;
}

_id_EA52(var_0) {
  return "" + var_0;
}

_id_1088B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self endon("death");
  var_15 = _func_008C();
  var_1 childthread _id_10927(var_2, var_15);

  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 childthread _id_10927(var_4, var_15);
  }

  if(isDefined(var_5) && isDefined(var_6)) {
    var_5 childthread _id_10927(var_6, var_15);
  }

  if(isDefined(var_7) && isDefined(var_8)) {
    var_7 childthread _id_10927(var_8, var_15);
  }

  if(isDefined(var_9) && isDefined(var_10)) {
    var_9 childthread _id_10927(var_10, var_15);
  }

  if(isDefined(var_11) && isDefined(var_12)) {
    var_11 childthread _id_10927(var_12, var_15);
  }

  if(isDefined(var_13) && isDefined(var_14)) {
    var_13 childthread _id_10927(var_14, var_15);
  }

  var_15 childthread _id_0D95(var_0);
  var_15 waittill("returned", var_16);
  var_15 notify("die");
  return var_16;
}

_id_5476(var_0) {
  while(isDefined(self) && !_id_546E(var_0)) {
    self waittill(var_0);
  }
}

_id_1BA8(var_0, var_1) {
  var_2 = _func_008C();
  var_3 = var_0;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];

    if(var_4 _id_546E(var_1)) {
      var_0 = array_remove(var_0, var_4);
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
  _id_1BE2(var_0, ::_id_1BA9, var_2, var_1);

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_2 waittill("notify");
  }
}

_id_1BA9(var_0, var_1) {
  _id_5476(var_1);
  var_0 notify("notify");
}

_id_547A(var_0) {
  while(isDefined(self) && !_id_546E(var_0)) {
    self waittill(var_0);
  }
}

_id_5478(var_0, var_1) {
  while(isDefined(self)) {
    if(_id_546E(var_0)) {
      return;
    }
    if(_id_546E(var_1)) {
      return;
    }
    _id_108C5(var_0, var_1);
  }
}

_id_5484(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_547B(var_0) {
  while(isDefined(self) && _id_546E(var_0)) {
    self waittill(var_0);
  }
}

_id_546F(var_0) {}

_id_547E(var_0, var_1) {
  while(isDefined(self)) {
    if(!_id_546E(var_0)) {
      return;
    }
    if(!_id_546E(var_1)) {
      return;
    }
    _id_108C5(var_0, var_1);
  }
}

_id_5473(var_0) {
  if(!isDefined(self._id_546E)) {
    self._id_546E = [];
    self._id_547F = [];
  }

  self._id_546E[var_0] = 0;
}

_id_5472(var_0) {
  if(isDefined(self._id_546E) && isDefined(self._id_546E[var_0])) {
    return 1;
  }

  return 0;
}

_id_5475(var_0, var_1) {
  self endon("death");
  wait(var_1);
  _id_5474(var_0);
}

_id_5474(var_0) {
  if(!_id_5472(var_0)) {
    _id_5473(var_0);
  }

  self._id_546E[var_0] = 1;
  self notify(var_0);
}

_id_5470(var_0, var_1) {
  if(_id_546E(var_0)) {
    self._id_546E[var_0] = 0;
    self notify(var_0);
  }

  if(_id_5472(var_0) && istrue(var_1)) {
    self._id_546E[var_0] = undefined;
  }
}

_id_5471(var_0, var_1) {
  wait(var_1);

  if(isDefined(self)) {
    _id_5470(var_0);
  }
}

_id_546E(var_0) {
  return _id_5472(var_0) && self._id_546E[var_0];
}

_id_655C() {
  var_0 = [];

  if(isDefined(self._id_0399)) {
    var_1 = _id_6562();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getstructarray(var_1[var_2], "script_linkname");

      if(var_3.size > 0) {
        var_0 = array_combine(var_0, var_3);
      }
    }
  }

  return var_0;
}

_id_5097(var_0, var_1) {
  var_0 = _func_0056(var_0);
  _func_00E0(var_0, var_1);
}