/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1719.gsc
*************************************************/

_id_4055() {
  if(!isDefined(level._id_E482)) {
    level._id_E482 = 4;
  }

  if(!isDefined(level._id_E480)) {
    level._id_E480 = 2;
  }

  setdvarifuninitialized("#x3297af087e6daf3a3", "0");

  if(!isDefined(level._id_E4A8)) {
    level._id_E4A8 = [];
  }

  var_0 = _id_6B79();
  var_1 = gettime();
  level._id_E4A8[var_0] = spawnStruct();
  level._id_E4A8[var_0]._id_9DB5 = [];
  level._id_E4A8[var_0]._id_913A = [];
  level._id_E4A8[var_0]._id_CFE3 = [];
  level._id_E4A8[var_0]._id_E4A2 = 0;
  level._id_E4A8[var_0]._id_A4D9 = var_1 + 1000;
  level._id_E4A8[var_0]._id_A4A1 = var_1 + 1000;
  level._id_E4A8[var_0]._id_A4D8 = var_1 + 3000;
  return var_0;
}

_id_6B79() {
  if(!isDefined(level._id_E4A9)) {
    level._id_E4A9 = 0;
  }

  var_0 = level._id_E4A9;
  level._id_E4A9 = level._id_E4A9 + 1;
  return var_0;
}

_id_1170(var_0, var_1) {
  var_2 = level._id_E4A8[var_0]._id_9DB5.size;
  level._id_E4A8[var_0]._id_9DB5[var_2] = var_1;
  var_1._id_03FD = var_0;
  var_1 thread _id_E4A7(var_1._id_03FD);
  var_1 scripts\engine\utility::_id_D17A(1);
  var_1._id_03FC = 0;

  if(var_2 != 0) {
    var_3 = level._id_E4A8[var_0]._id_9130;
    var_1 _meth_8326(var_3._id_0200);
    var_1._id_0201 = var_3._id_0201;
    var_1 _meth_865B(var_3);
  } else
    level._id_E4A8[var_0]._id_9130 = var_1;

  var_1 _id_E486();
}

_id_E486() {
  var_0 = level._id_E4A8[self._id_03FD];
  var_1 = undefined;

  if(_id_8A5D()) {
    if(var_0._id_913A.size >= level._id_E480) {
      var_1 = var_0._id_913A[0];
      var_0._id_913A[0] = self;
      var_0._id_CFE3[var_0._id_CFE3.size] = var_1;
      return;
    }

    var_0._id_913A[var_0._id_913A.size] = self;
  } else if(var_0._id_913A.size < level._id_E480)
    var_0._id_913A[var_0._id_913A.size] = self;
  else {
    var_0._id_CFE3[var_0._id_CFE3.size] = self;
  }
}

_id_8A5D() {
  return isDefined(level._id_E4A8) && isDefined(level._id_E4A8[self._id_03FD]) && level._id_E4A8[self._id_03FD]._id_9130 == self;
}

_id_E48B(var_0) {
  var_1 = _id_4055();
  var_0 _id_1170(var_1, var_0);
  return var_1;
}

_id_1BCD(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isalive(var_4)) {
      continue;
    }
    if(var_4 == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_C4B8(var_0, var_1) {
  if(!isDefined(level._id_E4A8[var_0])) {
    return;
  }
  var_1._id_03FD = -1;
  level._id_E4A8[var_0]._id_9DB5 = _id_1BCD(level._id_E4A8[var_0]._id_9DB5, var_1);
  level._id_E4A8[var_0]._id_913A = _id_1BCD(level._id_E4A8[var_0]._id_913A, var_1);
  level._id_E4A8[var_0]._id_CFE3 = _id_1BCD(level._id_E4A8[var_0]._id_CFE3, var_1);
  var_2 = level._id_E4A8[var_0]._id_9DB5.size;

  if(var_2 == 0) {
    level._id_E4A8[var_0] = undefined;
  } else if(var_2 <= 2) {
    var_3 = level._id_E4A8[var_0];
    _id_E489(var_0, 0);
    var_4 = var_3._id_9130 _id_5AF7(var_0, 1);

    if(var_4 == -1) {
      _id_E489(var_0, 0);
      return;
    }

    _id_E4A1(var_0, var_4);
    return;
  } else
    _id_E489(var_0, 0);
}

_id_E489(var_0, var_1) {
  var_2 = level._id_E4A8[var_0]._id_9DB5[var_1];
  level._id_E4A8[var_0]._id_9130 = var_2;
  level._id_E4A8[var_0]._id_913A = scripts\engine\utility::array_remove(level._id_E4A8[var_0]._id_913A, var_2);
  level._id_E4A8[var_0]._id_CFE3 = scripts\engine\utility::array_remove(level._id_E4A8[var_0]._id_CFE3, var_2);
  var_2 _id_E486();

  foreach(var_4 in level._id_E4A8[var_0]._id_9DB5) {
    var_4 _meth_865B(var_2);
  }
}

_id_E4A1(var_0, var_1) {
  if(var_0 == -1 || var_1 == -1) {
    return;
  }
  foreach(var_3 in level._id_E4A8[var_0]._id_9DB5) {
    var_3._id_03FD = -1;
    var_3 notify("squad_removed");
    var_3 _id_1170(var_1, var_3);
  }

  level._id_E4A8[var_0] = undefined;
}

_id_E491(var_0) {
  return isDefined(level._id_E4A8[var_0]);
}

_id_D6E8(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1024;
  }

  foreach(var_4 in level._id_E4A8[var_0]._id_9DB5) {
    var_4._id_1D18 = var_1;
    var_4._id_0201 = var_2;
    var_4 _meth_8326(var_1);
    var_4 scripts\engine\utility::_id_D17A(1);
  }
}

_id_88D3() {
  return self._id_03FD >= 0;
}

_id_FD3A() {
  var_0 = gettime();

  if(!_id_88D3()) {
    _id_5AFF();
  } else if(level._id_E4A8[self._id_03FD]._id_A4D8 < var_0 && _id_8A5D()) {
    if(level._id_E4A8[self._id_03FD].size < level._id_E482) {
      var_1 = _id_E492();
      _id_E4A1(self._id_03FD, var_1);
    }

    level._id_E4A8[self._id_03FD]._id_A4D8 = var_0 + 3000;
  }
}

_id_5AFF() {
  if(!isDefined(level._id_E4A8) || level._id_E4A8.size == 0) {
    return _id_E48B(self);
  }

  var_0 = _id_5AF7(-1, 0);

  if(var_0 == -1) {
    return _id_E48B(self);
  }

  _id_1170(var_0, self);
}

_id_5AF7(var_0, var_1) {
  if(!isDefined(level._id_E4A8) || level._id_E4A8.size == 0) {
    return -1;
  }

  var_2 = -1;
  var_3 = 100000000;
  var_4 = level._id_E4A8[var_0];

  foreach(var_8, var_6 in level._id_E4A8) {
    var_6 = var_6._id_9DB5;

    if(var_8 == var_0) {
      continue;
    }
    if(var_6.size >= level._id_E482) {
      continue;
    }
    if(!isalive(var_6[0])) {
      continue;
    }
    if(var_6[0].team != self.team) {
      continue;
    }
    var_7 = distancesquared(var_6[0].origin, self.origin);

    if(var_1) {
      if(var_7 > 1000000) {
        continue;
      }
      if(var_6.size + level._id_E4A8[var_0]._id_9DB5.size > level._id_E482) {
        continue;
      }
    } else if(var_7 > 160000) {
      continue;
    }
    if(var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_6[0]._id_03FD;
    }
  }

  return var_2;
}

_id_E492() {
  return _id_5AF7(self._id_03FD, 1);
}

_id_E4A7(var_0) {
  self endon("squad_removed");
  self waittill("death");

  if(!isDefined(self)) {
    level._id_E4A8[var_0]._id_9DB5 = scripts\engine\utility::_id_1BD1(level._id_E4A8[var_0]._id_9DB5);

    if(level._id_E4A8[var_0]._id_9DB5.size == 0) {
      level._id_E4A8[var_0] = undefined;
    }

    return;
  }

  _id_C4B8(self._id_03FD, self);
}