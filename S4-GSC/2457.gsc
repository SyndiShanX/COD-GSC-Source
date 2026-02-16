/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2457.gsc
*************************************************/

_id_8121() {
  level._id_A464 = ::_id_65DB;
  level._id_10E34 = [];
  level._id_10E3B = scripts\engine\utility::getStructArray("window_entrance", "targetname");
  scripts\engine\utility::_id_1BE2(level._id_10E3B, ::_id_811A);
}

_id_44B7() {
  wait 5;

  for(;;) {
    var_0 = scripts\engine\utility::_id_6969(level.players[0].origin, level._id_10E3B);
    var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
    var_1 = scripts\engine\utility::_id_1B8D(var_1, var_0);

    foreach(var_3 in var_1) {
      var_4 = 0;

      if(isDefined(var_3.angles)) {
        var_4 = var_3.angles[1];
      }

      var_5 = (0, 1, 0);

      if(_id_86CD(var_3)) {
        var_5 = (1, 0, 0);
      }
    }

    wait 0.25;
  }
}

_id_811A() {
  self._id_523F = 0;
  self._id_A927 = undefined;
  var_0 = getEntArray(self.target, "targetname");

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2._id_039B) && var_2._id_039B == "clip") {
        self._id_39A7 = var_2;
        continue;
      }

      self._id_2290 = var_2;
    }
  }

  self._id_2290._id_A74E = 6;
  self._id_2290._id_25C4 = [];
  self._id_2290._id_25C4[0] = "boarded";
  self._id_2290._id_25C4[1] = "boarded";
  self._id_2290._id_25C4[2] = "boarded";
  self._id_2290._id_25C4[3] = "boarded";
  self._id_2290._id_25C4[4] = "boarded";
  self._id_2290._id_25C4[5] = "boarded";
  var_4 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6._id_039B) && var_6._id_039B == "attack_spot") {
      self._id_1DC7 = var_6;
      continue;
    }

    var_6._id_A927 = undefined;
    var_6._id_523F = 0;
    level._id_10E34[level._id_10E34.size] = var_6;
  }

  level._id_10E34[level._id_10E34.size] = self;
  var_8 = scripts\engine\utility::_id_6969(self.origin, scripts\engine\utility::getStructArray("secure_window", "script_noteworthy"));
  self._id_039B = _id_6864(var_8);
  self._id_CD99 = "mid";

  if(isDefined(self._id_CE79) && self._id_CE79 == "extended") {
    self._id_24DE = 1;
  }

  var_9 = anglestoright(self.angles);

  foreach(var_6 in var_4) {
    var_11 = var_6.origin - self.origin;
    var_12 = vectordot(var_11, var_9);

    if(var_12 > 0) {
      var_6._id_CD99 = "left";
    } else {
      var_6._id_CD99 = "right";
    }

    if(istrue(self._id_24DE)) {
      var_6._id_24DE = 1;
    }
  }
}

_id_6864(var_0) {
  var_1 = getEntArray("spawn_volume", "targetname");

  foreach(var_3 in var_1) {
    if(_func_011A(var_0.origin, var_3)) {
      return var_3._id_0398;
    }
  }

  return undefined;
}

_id_5236(var_0) {
  var_0._id_523F = 1;
  var_0._id_A927 = undefined;
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_A927 = undefined;
    var_3._id_523F = 1;
  }
}

_id_4A73(var_0) {
  var_0._id_523F = 0;
  var_0._id_A927 = undefined;
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_A927 = undefined;
    var_3._id_523F = 0;
  }
}

_id_5237(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    _id_5236(var_3);
  }
}

_id_6483(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0._id_FEB3; var_2++) {
    if(var_0._id_FEBB[var_2] == var_1) {
      return var_2;
    }
  }

  return undefined;
}

_id_C3B2(var_0) {
  if(!isDefined(var_0._id_FEBB)) {
    return;
  }
  var_1 = _id_6483(var_0, self);

  if(!isDefined(var_1)) {
    return;
  }
  if(var_0._id_FEB3 == 1) {
    var_0._id_FEBB = [];
    var_0._id_FEB3 = 0;
  } else {
    var_0._id_FEBB[var_1] = var_0._id_FEBB[var_0._id_FEB3 - 1];
    var_0._id_FEBB[var_0._id_FEB3 - 1] = undefined;
    var_0._id_FEB3--;
  }
}

_id_0FD5(var_0) {
  _id_C3B2(var_0);

  if(!isDefined(var_0._id_FEBB)) {
    var_0._id_FEBB = [];
    var_0._id_FEB3 = 0;
  }

  var_1 = var_0._id_FEB3;
  var_0._id_FEBB[var_1] = self;
  var_0._id_FEB3++;
}

_id_51D5() {
  foreach(var_1 in level._id_10E3B) {
    _id_5236(var_1);
  }
}

_id_6619(var_0) {
  var_1 = scripts\engine\utility::_id_6369(var_0, level._id_10E3B);

  foreach(var_3 in var_1) {
    if(!_id_5519(var_3)) {
      return var_3;
    }
  }

  return undefined;
}

_id_65DC(var_0, var_1) {
  var_2 = _func_0204(level._id_10E3B, var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_1)) {
      if(var_4 == var_1) {
        var_1 = undefined;
      }

      continue;
    }

    if(var_4._id_523F) {
      return var_4;
    }
  }

  return undefined;
}

_id_85BD(var_0) {
  return var_0._id_523F;
}

_id_5519(var_0) {
  if(isDefined(var_0._id_2290) && var_0._id_2290._id_A74E > 0) {
    return 1;
  }

  return 0;
}

_id_C2F3(var_0) {
  var_0._id_A927 = undefined;
}

_id_37EF(var_0) {
  var_0._id_A927 = self;
}

_id_86CD(var_0) {
  if(isDefined(var_0._id_A927) && isalive(var_0._id_A927)) {
    return 1;
  }

  return 0;
}

_id_86CC(var_0) {
  return !_id_86CD(var_0);
}

_id_D7AF() {
  var_0 = anglestoright(self.angles);
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3.origin - self.origin;
    var_5 = vectordot(var_4, var_0);

    if(var_5 > 0) {
      self._id_C853 = var_3;
      continue;
    }

    self._id_9188 = var_3;
  }
}

_id_2EAF() {
  var_0 = (0, 0, 0);

  foreach(var_2 in self._id_FEBB) {
    var_0 = var_0 + var_2.origin;
  }

  var_4 = (var_0[0] / self._id_FEB3, var_0[1] / self._id_FEB3, var_0[2] / self._id_FEB3);
  var_5 = _func_0204(self._id_FEBB, var_4);
  return var_5[0];
}

_id_86FA(var_0, var_1) {
  var_2 = self.origin - var_0.origin;
  var_3 = (var_2[0], var_2[1], 0);
  var_4 = vectordot(var_3, var_1);

  if(var_4 > 0) {
    return 1;
  }

  return 0;
}

_id_6503(var_0) {
  if(!isDefined(var_0._id_9188) && !isDefined(var_0._id_C853)) {
    var_0 _id_D7AF();
  }

  if(var_0._id_FEB3 <= 1) {
    return var_0;
  }

  if(var_0._id_FEB3 > 1) {
    var_2 = var_0 _id_2EAF();
    var_3 = anglestoright(var_0.angles);
    var_4 = anglestoleft(var_0.angles);

    if(self == var_2) {
      return var_0;
    }

    if(isDefined(var_0._id_C853) && _id_86FA(var_2, var_3)) {
      return var_0._id_C853;
    }

    if(isDefined(var_0._id_9188) && _id_86FA(var_2, var_4)) {
      return var_0._id_9188;
    }
  }

  var_5 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_5 = scripts\engine\utility::_id_1B8D(var_5, var_0);
  var_6 = _func_0204(var_5, self.origin);
  return var_6[0];
}

_id_6618(var_0) {
  var_1 = _id_6503(var_0);

  if(isDefined(var_1) && _id_86CC(var_1)) {
    return var_1;
  }

  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::_id_1B8D(var_2, var_0);
  var_2 = scripts\engine\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    if(_id_86CC(var_4)) {
      return var_4;
    }
  }

  if(isDefined(var_1)) {
    return var_1;
  }

  return scripts\engine\utility::random(var_2);
}

_id_D177(var_0, var_1, var_2) {
  var_0._id_2290._id_25C4[var_1] = var_2;
}

_id_639A(var_0, var_1) {
  return var_0._id_2290._id_25C4[var_1];
}

_id_65DA(var_0) {
  for(var_1 = 0; var_1 < 6; var_1++) {
    if(var_0._id_2290._id_25C4[var_1] == "boarded") {
      return var_1 + 1;
    }
  }
}

_id_65DB(var_0) {
  for(var_1 = 5; var_1 >= 0; var_1--) {
    if(var_0._id_2290._id_25C4[var_1] == "destroyed") {
      return var_1 + 1;
    }
  }
}

_id_C382(var_0, var_1) {
  if(!_id_5519(var_0)) {
    return;
  }
  var_2 = scripts\engine\utility::getStructArray("secure_window", "script_noteworthy");
  var_3 = scripts\engine\utility::_id_6969(var_0.origin, var_2);

  if(!isDefined(var_1)) {
    var_1 = var_0._id_2290._id_A74E;

    if(var_1 > 6) {
      var_1 = 6;
    } else if(var_1 < 1) {
      var_1 = 1;
    }
  }

  var_0._id_2290 _id_D16E("board_" + var_1, "destroy");
  var_0._id_2290._id_A74E--;

  if(!scripts\engine\utility::array_contains(level._id_417B, var_3)) {
    level._id_417B = scripts\engine\utility::array_add(level._id_417B, var_3);
  }

  var_3._id_4A88 = 0;

  if(var_0._id_2290._id_A74E < 1) {
    var_3._id_4A88 = 0;
  }
}

_id_D16E(var_0, var_1) {
  if(var_0 == "all" && var_1 == "rebuild") {
    self setscriptablepartstate("board_1", "instant_rebuild");
    self setscriptablepartstate("board_2", "instant_rebuild");
    self setscriptablepartstate("board_3", "instant_rebuild");
    self setscriptablepartstate("board_4", "instant_rebuild");
    self setscriptablepartstate("board_5", "instant_rebuild");
    self setscriptablepartstate("board_6", "instant_rebuild");
  } else
    self setscriptablepartstate(var_0, var_1);
}