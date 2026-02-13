/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1936.gsc
*************************************************/

_id_0C12(var_0) {
  if(isbot(self)) {
    return;
  }
  if(self _meth_878F()) {
    return;
  }
  if(getdvarint("#x31ec5716a30751062", 0) == 1) {
    var_1 = getdvarint("#x3752381b38692c8f6", 0);
    var_2 = _id_56F9(var_1);

    if(isDefined(var_2)) {
      var_0 = var_2;
    }
  }

  _id_0B9E();
  var_3 = _id_56FB(var_0);

  if(isDefined(var_3)) {
    self giveweapon(var_3);
    self _meth_8666(_id_56F8(var_0), var_3);
  } else
    self _meth_8666(_id_56F8(var_0));

  self._id_5705 = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    thread _id_10B87();
  }
}

_id_0B9E() {
  if(isDefined(self._id_5705)) {
    self _meth_8667();
    var_0 = _id_56FB(self._id_5705);

    if(isDefined(var_0) && self hasweapon(var_0)) {
      self takeweapon(var_0);
    }

    self._id_5705 = undefined;
  }
}

_id_755D() {
  return isDefined(self._id_5705);
}

_id_56FD(var_0) {
  level._id_56F2 = spawnStruct();
  level._id_524E = ::_id_524F;
  level._id_4AB1 = ::_id_4AB2;
  level._id_5250 = ::_id_5251;
  level._id_4AB3 = ::_id_4AB4;
  _id_56FE(istrue(var_0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("execution", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("execution", "init")]]();
  }
}

_id_524F() {
  self _meth_86C5();
}

_id_4AB2() {
  self _meth_86C4();
}

_id_5251() {
  self _meth_86C7();
}

_id_4AB4() {
  self _meth_86C6();
}

_id_56FE(var_0) {
  level._id_56F2._id_EC5C = [];
  level._id_56F2._id_7CD7 = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp_cp/executiontable.csv", var_1, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tolower(var_2);
    var_4 = spawnStruct();
    var_4._id_C189 = var_3;
    var_5 = tablelookupbyrow("mp_cp/executiontable.csv", var_1, 0);
    var_4._id_7C8C = int(var_5);
    var_6 = tablelookupbyrow("mp_cp/executiontable.csv", var_1, 12);

    if(var_6 != "none") {
      var_4._id_56F2 = var_6;
    }

    if(!var_0) {
      var_7 = tablelookupbyrow("mp_cp/executiontable.csv", var_1, 13);

      if(var_7 != "none") {
        var_4._id_BDBD = makeweapon(var_7);

        if(isnullweapon(var_4._id_BDBD)) {
          var_1++;
          continue;
        }
      }
    }

    level._id_56F2._id_EC5C[var_3] = var_4;
    level._id_56F2._id_7CD7[var_4._id_7C8C] = var_4._id_C189;
    var_1++;
  }
}

_id_56F8(var_0) {
  var_1 = level._id_56F2._id_EC5C[var_0];

  if(isDefined(var_1)) {
    return var_1._id_56F2;
  }

  return undefined;
}

_id_56FB(var_0) {
  var_1 = level._id_56F2._id_EC5C[var_0];

  if(isDefined(var_1)) {
    return var_1._id_BDBD;
  }

  return undefined;
}

_id_56FC(var_0) {
  return var_0._id_5705;
}

_id_56FA(var_0) {
  var_1 = level._id_56F2._id_EC5C[var_0];

  if(isDefined(var_1)) {
    return var_1._id_7C8C;
  }
}

_id_56F9(var_0) {
  return level._id_56F2._id_7CD7[var_0];
}

_id_56F4() {
  if(self isonladder()) {
    if(!istrue(self._id_8E91)) {
      scripts\common\utility::_id_153C(0);
      scripts\common\utility::_id_153D(0);
      self._id_8E91 = 1;
    }
  } else if(istrue(self._id_8E91)) {
    scripts\common\utility::_id_153C(1);
    scripts\common\utility::_id_153D(1);
    self._id_8E91 = undefined;
  }
}

_id_10B87() {
  self endon("disconnect");
  self notify("watchInExecution");
  self endon("watchInExecution");
  var_0 = 0;

  for(;;) {
    var_1 = self _meth_86C8() || self _meth_86C9();

    if(var_1 != var_0) {
      if(var_1) {
        self _meth_865D();
        self _meth_8660(2.5, 60, 20, 20);
      } else
        self _meth_865E();
    }

    var_0 = var_1;
    waitframe();
  }
}