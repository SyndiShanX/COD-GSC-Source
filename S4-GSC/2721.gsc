/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2721.gsc
*************************************************/

_id_1096C(var_0) {
  if(level._id_9047 == gettime()) {
    if(isDefined(var_0) && var_0) {
      while(level._id_9047 == gettime()) {
        wait 0.05;
      }
    } else {
      wait 0.05;

      if(level._id_9047 == gettime()) {
        wait 0.05;

        if(level._id_9047 == gettime()) {
          wait 0.05;

          if(level._id_9047 == gettime()) {
            wait 0.05;
          }
        }
      }
    }
  }

  level._id_9047 = gettime();
}

_id_BECD(var_0) {
  if(!isDefined(level._id_BED6)) {
    level._id_BED6 = [];
  }

  level._id_BED6[var_0] = [];
}

_id_BEC7(var_0, var_1) {
  level._id_BED6[var_0][level._id_BED6[var_0].size] = var_1;
}

_id_BED5(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in level._id_BED6[var_0]) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isDefined(var_1)) {
      var_1 = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  level._id_BED6[var_0] = var_2;
  return var_1;
}

_id_BEF7(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = ::_id_4566;
  }

  var_2 = 0;
  var_3 = var_0.size - 1;
  var_4 = [var_2, var_3];
  var_5 = 1;

  while(var_5 >= 0) {
    var_3 = var_4[var_5];
    var_5--;
    var_2 = var_4[var_5];
    var_5--;

    if(var_3 - var_2 <= 9) {
      for(var_3++; var_2 < var_3; var_2 = var_2 + 1) {
        var_6 = var_0[var_2];

        for(var_7 = var_2 - 1; var_7 >= 0 && [[var_1]](var_6, var_0[var_7]); var_7 = var_7 - 1) {
          var_0[var_7 + 1] = var_0[var_7];
        }

        var_0[var_7 + 1] = var_6;
      }

      continue;
    }

    var_6 = var_0[var_3];
    var_8 = var_2 - 1;

    for(var_7 = var_2; var_7 <= var_3 - 1; var_7++) {
      if([[var_1]](var_0[var_7], var_6)) {
        var_8++;
        var_9 = var_0[var_8];
        var_0[var_8] = var_0[var_7];
        var_0[var_7] = var_9;
      }
    }

    var_8++;
    var_9 = var_0[var_8];
    var_0[var_8] = var_0[var_3];
    var_0[var_3] = var_9;

    if(var_8 - 1 > var_2) {
      var_5++;
      var_4[var_5] = var_2;
      var_5++;
      var_4[var_5] = var_8 - 1;
    }

    if(var_8 + 1 < var_3) {
      var_5++;
      var_4[var_5] = var_8 + 1;
      var_5++;
      var_4[var_5] = var_3;
    }
  }

  return var_0;
}

_id_4566(var_0, var_1) {
  return var_0 <= var_1;
}

_id_94D6(var_0, var_1) {
  var_2 = 1;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2 = var_2 * 10;
  }

  var_4 = var_0 * var_2;
  var_4 = int(var_4);
  var_4 = var_4 / var_2;
  return var_4;
}

_id_C93B(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "nearest";
  }

  var_3 = 1;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_3 = var_3 * 10;
  }

  var_5 = var_0 * var_3;

  if(var_2 == "up") {
    var_6 = _func_0037(var_5);
  } else if(var_2 == "down") {
    var_6 = floor(var_5);
  } else {
    var_6 = var_5 + 0.5;
  }

  var_5 = int(var_6);
  var_5 = var_5 / var_3;
  return var_5;
}

_id_EA5F(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);

  if(isDefined(var_1[1])) {
    var_3 = 1;

    for(var_4 = 0; var_4 < var_1[1].size; var_4++) {
      var_3 = var_3 * 0.1;
    }

    var_2 = var_2 + int(var_1[1]) * var_3;
  }

  return var_2;
}

_id_8A68(var_0, var_1) {
  return _func_00D6(var_0, 0, var_1.size) == var_1;
}

_id_1BC5(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_5] = var_4;
    }
  }

  return var_2;
}

_id_46C7(var_0) {
  self endon("death");
  wait(var_0);

  if(isDefined(self)) {
    self delete();
  }
}

rounddown(var_0) {
  if(var_0 < int(var_0)) {
    return int(var_0 - 1);
  } else {
    return int(var_0);
  }
}

_id_2C9F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread _id_2CA0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_2CA0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  level endon("game_ended");
  var_9 = "bufferedNotify_" + var_0;
  self notify(var_9);
  self endon(var_9);

  if(!isDefined(self._id_2C9E)) {
    self._id_2C9E = [];
  }

  if(!isDefined(self._id_2C9E[var_0])) {
    self._id_2C9E[var_0] = [];
  }

  var_10 = spawnStruct();
  var_10._id_AE40 = var_1;
  var_10._id_AE41 = var_2;
  var_10._id_AE42 = var_3;
  var_10._id_AE43 = var_4;
  var_10._id_AE44 = var_5;
  var_10._id_AE45 = var_6;
  var_10._id_AE46 = var_7;
  var_10._id_AE47 = var_8;
  self._id_2C9E[var_0][self._id_2C9E[var_0].size] = var_10;
  waittillframeend;

  while(self._id_2C9E[var_0].size > 0) {
    var_10 = self._id_2C9E[var_0][0];
    self notify(var_0, var_10._id_AE40, var_10._id_AE41, var_10._id_AE42, var_10._id_AE43, var_10._id_AE44, var_10._id_AE45, var_10._id_AE46, var_10._id_AE47);
    self._id_2C9E[var_0] = ::scripts\engine\utility::array_remove_index(self._id_2C9E[var_0], 0);
    waitframe();
  }
}

_id_A695(var_0, var_1) {
  self waittill(var_0);
  waittillframeend;
  self notify(var_1);
}

_id_46DB(var_0, var_1, var_2) {
  self endon("disconnect");
  wait(var_0);
  self setclientomnvar(var_1, var_2);
}

_id_EA63(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(_func_00D6(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return _func_00D6(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

_id_8909(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_2[0], var_2[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

_id_FFE3(var_0, var_1) {
  var_2 = _func_025B(var_0, var_1);
  var_1 = _func_025B(var_2, var_0);
  var_3 = _func_0017(var_0, var_2, var_1);
  return var_3;
}

_id_764F(var_0) {
  var_1 = spawnStruct();
  var_1._id_A79F = 0;
  var_1._id_FF68 = [];

  if(var_0 == "max") {
    var_1._id_EBF6 = ::_id_0C23;
  } else if(var_0 == "min") {
    var_1._id_EBF6 = ::_id_0C20;
  }

  return var_1;
}

_id_7653() {
  return self._id_A79F;
}

_id_7651() {
  return self._id_FF68[1];
}

_id_7652() {
  if(self._id_A79F == 0) {
    return undefined;
  } else if(self._id_A79F == 1) {
    var_0 = self._id_FF68[1];
    self._id_FF68[1] = undefined;
    self._id_A79F = 0;
    return var_0;
  } else {
    var_0 = self._id_FF68[1];
    self._id_FF68[1] = self._id_FF68[self._id_A79F];
    self._id_FF68[self._id_A79F] = undefined;
    _id_0C21(1);
    self._id_A79F = self._id_A79F - 1;
    return var_0;
  }
}

_id_7650(var_0) {
  self._id_FF68[self._id_A79F + 1] = var_0;
  var_1 = self._id_A79F + 1;
  var_2 = _id_0C24(var_1);

  while(isDefined(var_2)) {
    if([[self._id_EBF6]](var_2, var_1)) {
      var_3 = self._id_FF68[var_2];
      self._id_FF68[var_2] = self._id_FF68[var_1];
      self._id_FF68[var_1] = var_3;
      var_1 = var_2;
      var_2 = _id_0C24(var_1);
      continue;
    }

    break;
  }

  self._id_A79F = self._id_A79F + 1;
}

_id_BD16() {
  var_0 = [];
  var_1 = self._id_A79F;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0[var_2] = _id_7652();
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    _id_7650(var_0[var_2]);
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {}
}

_id_0C20(var_0, var_1) {
  return self._id_FF68[var_0] > self._id_FF68[var_1];
}

_id_0C23(var_0, var_1) {
  return self._id_FF68[var_0] < self._id_FF68[var_1];
}

_id_0C21(var_0) {
  var_1 = _id_0C22(var_0);
  var_2 = _id_0C25(var_0);
  var_3 = undefined;
  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = self[[self._id_EBF6]](var_0, var_1);
  }

  var_5 = 0;

  if(isDefined(var_2)) {
    var_5 = self[[self._id_EBF6]](var_0, var_2);
  }

  if(!var_4 && !var_5) {
    return;
  } else if(var_4 && !var_5) {
    var_3 = var_1;
  } else if(!var_4 && var_5) {
    var_3 = var_2;
  } else if(self[[self._id_EBF6]](var_1, var_2)) {
    var_3 = var_2;
  } else {
    var_3 = var_1;
  }

  var_6 = self._id_FF68[var_0];
  self._id_FF68[var_0] = self._id_FF68[var_3];
  self._id_FF68[var_3] = var_6;
  _id_0C21(var_3);
}

_id_0C22(var_0) {
  if(!isDefined(self._id_FF68[2 * var_0])) {
    return undefined;
  }

  return 2 * var_0;
}

_id_0C25(var_0) {
  if(!isDefined(self._id_FF68[2 * var_0 + 1])) {
    return undefined;
  }

  return 2 * var_0 + 1;
}

_id_0C24(var_0) {
  if(var_0 == 1) {
    return undefined;
  }

  return int(floor(var_0 / 2));
}

_id_8956(var_0, var_1) {
  return var_0 > 0 && var_0 % var_1 == 0;
}

_id_47BB(var_0) {
  var_1 = var_0 == undefined;
}