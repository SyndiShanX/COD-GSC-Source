/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2218.gsc
*************************************************/

_id_3D7D() {
  self._id_0408._id_3D77 = spawnStruct();
}

_id_3D7E() {
  if(isDefined(level._id_0408) && isDefined(level._id_0408._id_3D77)) {
    return;
  }
  level._id_0408._id_3D77 = spawnStruct();
  level._id_0408._id_3D77._id_C5F4 = 30;
  level _id_08B5::_id_D3C4("saw_corpse", ::_id_3D81);
  level _id_08B5::_id_D3C4("found_corpse", ::_id_3D7C);
  _id_D19B();
}

_id_D19B() {
  var_0["sight_dist"] = 600;
  var_0["detect_dist"] = 300;
  var_0["found_dist"] = 100;
  _id_D19A(var_0);
}

_id_D19A(var_0) {
  if(!isDefined(var_0["shadow_dist"])) {
    var_0["shadow_dist"] = var_0["found_dist"];
  }

  level._id_0408._id_3D77._id_D969 = _func_0219(var_0["shadow_dist"]);
  level._id_0408._id_3D77._id_DD32 = _func_0219(var_0["sight_dist"]);
  level._id_0408._id_3D77._id_4894 = _func_0219(var_0["detect_dist"]);
  level._id_0408._id_3D77._id_5F10 = _func_0219(var_0["found_dist"]);
}

_id_D199() {
  level._id_0408._id_7D04[self getentitynumber()] = self.origin;
}

_id_D198() {
  level._id_0408._id_10CD[self getentitynumber()] = self;
}

_id_3D79(var_0) {
  if(!isDefined(self._id_7D79) || distancesquared(self._id_7D79, var_0) > 1.0) {
    self._id_7D78 = undefined;

    if(isDefined(level._id_F5FF)) {
      foreach(var_2 in level._id_F5FF) {
        if(isDefined(var_2) && _func_011A(var_0, var_2)) {
          self._id_7D78 = 1;
          break;
        }
      }
    }

    self._id_7D79 = var_0;
  }

  return istrue(self._id_7D78);
}

_id_3D83() {
  if(isDefined(self._id_0408._id_3D80) && gettime() < self._id_0408._id_3D80) {
    return;
  }
  if(scripts\engine\utility::_id_546E("stealth_hold_position")) {
    return;
  }
  if(self._id_0229) {
    return;
  }
  if(istrue(self._id_0408._id_3D77._id_8528)) {
    return;
  }
  if(isDefined(self._id_0408._id_3D77._id_5469)) {
    self._id_0408._id_3D80 = gettime() + 100;
  } else {
    self._id_0408._id_3D80 = gettime() + 1000;
  }

  var_0 = [];

  if(isDefined(level._id_5D87)) {
    var_0 = [[level._id_5D87]]();
  }

  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = var_4 getentitynumber();

    if(isDefined(level._id_0408._id_7D04) && isDefined(level._id_0408._id_7D04[var_5]) && distancesquared(level._id_0408._id_7D04[var_5], var_4.origin) < _func_0219(100)) {
      level._id_0408._id_7D04[var_5] = undefined;
      var_4._id_5F0F = 1;
    }

    if(isDefined(var_4._id_5F0F)) {
      continue;
    }
    var_6 = var_4 _id_08B5::_id_6987();
    var_7 = distancesquared(self.origin, var_6);
    var_8 = level._id_0408._id_3D77._id_5F10;
    var_9 = level._id_0408._id_3D77._id_DD32;
    var_10 = level._id_0408._id_3D77._id_4894;

    if(isDefined(self._id_0408._id_AD37)) {
      var_8 = self._id_0408._id_AD37 * self._id_0408._id_AD37;
    }

    if(isDefined(self._id_0408._id_AD38)) {
      var_9 = self._id_0408._id_AD38 * self._id_0408._id_AD38;
    }

    if(isDefined(self._id_0408._id_AD36)) {
      var_10 = self._id_0408._id_AD36 * self._id_0408._id_AD36;
    }

    if(var_4 _id_3D79(var_6)) {
      var_9 = level._id_0408._id_3D77._id_D969;
      var_10 = level._id_0408._id_3D77._id_D969;
    }

    if(var_7 < var_8) {
      if(abs(self.origin[2] - var_6[2]) < 60) {
        var_1 = var_4;
        break;
      }
    }

    if(isDefined(self._id_0408._id_3D77._id_5469)) {
      if(self._id_0408._id_3D77._id_5469 == var_4) {
        continue;
      }
      var_11 = self._id_0408._id_3D77._id_5469 _id_08B5::_id_6987();
      var_12 = distancesquared(self.origin, var_11);

      if(var_12 <= var_7) {
        continue;
      }
    }

    if(var_7 > var_9) {
      continue;
    }
    if(var_6[2] - self.origin[2] > 128) {
      continue;
    }
    if(var_7 < var_10) {
      if(!isDefined(var_4._id_D026) && self _meth_8067(var_4)) {
        var_2 = var_4;
        break;
      }
    }

    var_13 = anglesToForward(self gettagangles("tag_eye"));
    var_14 = vectornormalize(var_6 + (0, 0, 30) - self getEye());

    if(vectordot(var_13, var_14) > 0.55) {
      if(!isDefined(var_4._id_D026) && self _meth_8067(var_4)) {
        var_2 = var_4;
        break;
      }
    }
  }

  if(isDefined(var_1)) {
    var_1._id_5F0F = 1;

    if(istrue(var_1._id_D026) && isDefined(self._id_0408._id_3D77._id_5469) && self._id_0408._id_3D77._id_5469 == var_1) {
      self._id_0408._id_AF2E = gettime();
    }

    self _meth_8523("found_corpse", var_1, var_1 _id_08B5::_id_6987());
  } else if(isDefined(var_2)) {
    thread _id_3D82(var_2);
    self _meth_8523("saw_corpse", var_2, var_2 _id_08B5::_id_6987());
  }
}

_id_3D7C(var_0) {
  self notify("corpse_found");
  self endon("corpse_found");
  self endon("death");
  var_1 = var_0._id_019B;
  var_2 = var_1 _id_08B5::_id_6987();

  if(isDefined(self._id_0408._id_3D77._id_5469)) {
    self._id_0408._id_3D77._id_5469._id_D026 = undefined;
  }

  self._id_0408._id_3D77._id_5469 = var_1;
  self._id_0408._id_24DD = 1;

  if(isDefined(level._id_5DBB)) {
    var_1[[level._id_5DBB]](level._id_0408._id_3D77._id_C5F4);
  }
}

_id_3D81(var_0) {
  var_1 = var_0._id_019B;
  var_2 = var_1 _id_08B5::_id_6987();
  self._id_0408._id_3D77.origin = var_2;
  self._id_0408._id_24DD = 1;
  thread _id_3D82(var_1);
}

_id_3D82(var_0) {
  self notify("corpse_seen_claim");
  self endon("corpse_seen_claim");

  if(isDefined(self._id_0408._id_3D77._id_5469)) {
    self._id_0408._id_3D77._id_5469._id_D026 = undefined;
  }

  var_0._id_D026 = 1;
  self._id_0408._id_3D77._id_5469 = var_0;
  self waittill("death");

  if(isDefined(var_0)) {
    var_0._id_D026 = undefined;
  }

  if(isDefined(self)) {
    thread _id_3D7B();
  }
}

_id_3D7B() {
  if(isDefined(self._id_0408) && isDefined(self._id_0408._id_3D77)) {
    if(isDefined(self._id_0408._id_3D77._id_5469)) {
      self._id_0408._id_3D77._id_5469._id_D026 = undefined;
    }

    self._id_0408._id_3D77._id_5469 = undefined;
    self._id_0408._id_3D77._id_8528 = undefined;
  }
}

_id_EBEC() {
  if(!isDefined(self._id_0408._id_EBEA)) {
    self._id_0408._id_EBEA = spawnStruct();
  }

  if(isDefined(self._id_0408._id_EBEA._id_A4E2) && gettime() < self._id_0408._id_EBEA._id_A4E2) {
    return;
  }
  if(scripts\engine\utility::_id_546E("stealth_hold_position")) {
    return;
  }
  if(self._id_0229) {
    return;
  }
  if(istrue(self._id_0408._id_EBEA._id_8528)) {
    return;
  }
  if(isDefined(self._id_0408._id_EBEA._id_5469)) {
    self._id_0408._id_EBEA._id_A4E2 = gettime() + 100;
  } else {
    self._id_0408._id_EBEA._id_A4E2 = gettime() + 1000;
  }

  var_0 = level._id_0408._id_EBEA._id_4E4C;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_0) {
    var_5 = var_3 getentitynumber();

    if(isDefined(var_3._id_5F0F)) {
      continue;
    }
    var_6 = var_3.origin;
    var_7 = distancesquared(self.origin, var_6);
    var_8 = level._id_0408._id_EBEA._id_5F10;
    var_9 = level._id_0408._id_EBEA._id_DD32;
    var_10 = level._id_0408._id_EBEA._id_4894;

    if(var_7 < var_8) {
      if(abs(self.origin[2] - var_6[2]) < 60) {
        var_1 = var_3;
        break;
      }
    }

    if(isDefined(self._id_0408._id_EBEA._id_5469)) {
      if(self._id_0408._id_EBEA._id_5469 == var_3) {
        continue;
      }
      var_11 = self._id_0408._id_EBEA._id_5469.origin;
      var_12 = distancesquared(self.origin, var_11);

      if(var_12 <= var_7) {
        continue;
      }
    }

    if(var_7 > var_9) {
      continue;
    }
    if(var_6[2] - self.origin[2] > 128) {
      continue;
    }
    if(var_7 < var_10) {
      if(!isDefined(var_3._id_D026) && self _meth_8067(var_3) && scripts\engine\utility::_id_30FE(var_3.origin, self, level._id_0408._id_31FA)) {
        var_2 = var_3;
        break;
      }
    }

    var_13 = anglesToForward(self gettagangles("tag_eye"));
    var_14 = vectornormalize(var_6 + (0, 0, 30) - self getEye());

    if(vectordot(var_13, var_14) > 0.55) {
      if(!isDefined(var_3._id_D026) && self _meth_8067(var_3) && scripts\engine\utility::_id_30FE(var_3.origin, self, level._id_0408._id_31FA)) {
        var_2 = var_3;
        break;
      }
    }
  }

  if(isDefined(var_1)) {
    var_1._id_5F0F = 1;
    var_16 = undefined;

    if(istrue(var_1._id_D026) && isDefined(self._id_0408._id_EBEA._id_5469) && self._id_0408._id_EBEA._id_5469 == var_1) {
      self._id_0408._id_AF2E = gettime();
    }

    if(isDefined(var_3._id_2FF0)) {
      var_16 = var_3._id_2FF0[0].origin;
    } else {
      var_16 = var_3.origin;
    }

    self _meth_8523("suspicious_door", var_1, var_16);
  }
}

_id_EBEB(var_0) {
  var_1 = var_0._id_019B;

  if(isDefined(var_1._id_1361)) {
    return;
  }
  var_1._id_1361 = self;

  if(isDefined(var_1._id_2FF0) && isDefined(var_1._id_2FF0[0])) {
    var_2 = var_1._id_2FF0[0].origin;
  } else {
    var_2 = var_1.origin;
  }

  var_3 = _func_02AB(var_2, self);
  var_0.origin = var_2 + anglesToForward((0, randomfloatrange(0, 360), 0)) * 75;
  var_0._id_8512 = _func_02AB(var_0.origin, self);
  _id_08AC::_id_2C64("investigate", var_0);
}