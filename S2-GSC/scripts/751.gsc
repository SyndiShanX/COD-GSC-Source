/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\751.gsc
**************************************/

_id_524B() {
  _id_02F0::_id_7FE7();
  _id_525F();
}

_id_57B3() {
  return 0;
}

_id_7FE6() {}

_id_7FE5(var_0, var_1) {
  return var_0;
}

_id_4624(var_0) {
  if(isDefined(var_0) == 1) {
    if(isDefined(var_0.name) == 1)
      return var_0.name;

    if(isDefined(var_0._id_0132) == 1)
      return var_0._id_0132;
  }

  return undefined;
}

_id_56DB(var_0) {
  var_1 = undefined;
  var_2 = 0;

  if(isDefined(var_0) == 1 && _isremovedentity(var_0) == 0 && isDefined(var_0.classname) == 1 && isDefined(var_0._id_003B) == 1)
    var_1 = var_0 getentitynumber();

  if(isDefined(var_1) == 1 && var_1 >= 0)
    var_2 = 1;
  else if(isDefined(var_0.origin) == 1 && isDefined(var_0._id_8F4E) == 1 && var_0._id_8F4E == "sndentity")
    var_2 = 1;
  else
    var_2 = 0;

  return var_2;
}

_id_4625() {
  var_0 = undefined;

  if(common_scripts\utility::issp() == 1)
    var_0 = [level.player];
  else if(_isarray(level.players) == 1)
    var_0 = level.players;

  return var_0;
}

_id_46BD(var_0) {
  var_1 = self;
  var_2 = "tag_origin";
  var_3 = -1;

  if(isDefined(var_0) == 1)
    var_2 = var_0;

  var_3 = var_1 gettagindex(var_2);

  if(isDefined(var_3) == 0 || var_3 == -1)
    var_2 = "";

  return var_2;
}

_id_A77A() {
  while(_isremovedentity(self) == 0)
    common_scripts\utility::_id_A70A("death", "disconnect");
}

_id_7A5C(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(var_0 == var_1)
      return var_0;
    else {
      var_3 = _randomfloatrange(var_0, var_1);
      return var_3;
    }
  } else if(isDefined(var_0) == 1 && isDefined(var_1) == 0)
    return var_0;
  else if(isDefined(var_2))
    return var_2;

  return undefined;
}

startignoringspotlight(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2 - var_1;
  var_6 = clamp(var_0, var_1, var_2);
  var_7 = (var_6 - var_1) / var_5;
  var_8 = var_4 - var_3;
  var_9 = var_3 + var_8 * var_7;
  return var_9;
}

_id_A2BB(var_0, var_1) {
  var_2 = var_0 * (var_1, var_1, var_1);
  return var_2;
}

_id_0760(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 1.0;
  var_4 = var_0;

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = var_0[var_5];

    if(var_6 > var_2) {
      var_1 = var_5;
      var_2 = var_6;
    }
  }

  var_3 = 1.0 / var_2;
  var_4 = _id_A2BB(var_4, var_3);
  return var_4;
}

_id_A2BC(var_0, var_1) {
  var_2 = _id_A2BB(var_0, var_1);
  var_3 = _id_0760(var_2);
  return var_3;
}

_id_A2BD(var_0, var_1) {
  var_2 = _id_A2BB(var_0, var_1);
  var_3 = _vectorclamp(var_2, 1.0, 0.0);
  return var_3;
}

_id_578C(var_0, var_1, var_2) {
  var_3 = distance(var_0, var_1);

  if(var_3 <= var_2)
    return 1;

  return 0;
}

_id_6C21(var_0, var_1, var_2) {
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_3 = var_3 + var_1 * _cos(var_2);
  var_4 = var_4 + var_1 * _sin(var_2);
  var_6 = (var_3, var_4, var_5);
  return var_6;
}

randomarrayelement(var_0) {
  var_1 = _randomintrange(1, var_0.size);
  var_1 = var_1 - 1;
  var_2 = var_0[var_1];
  return var_2;
}

_id_7A5B(var_0, var_1, var_2) {
  var_3 = var_0 - var_2;
  var_4 = var_0 + var_2;
  var_5 = var_4 - var_3;
  var_6 = (_randomfloat(var_5[0]), _randomfloat(var_5[1]), _randomfloat(var_5[2]));

  if(var_1 != (0, 0, 0)) {
    var_3 = var_0 - _rotatevector(var_0 - var_3, var_1);
    var_6 = _rotatevector(var_6, var_1);
  }

  var_7 = var_3 + var_6;
  return var_7;
}

_id_2B5C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0 - var_2;
  var_8 = var_0 + var_2;
  var_9[0] = (var_8[0], var_8[1], var_8[2]);
  var_9[1] = (var_8[0], var_8[1], var_7[2]);
  var_9[2] = (var_7[0], var_8[1], var_7[2]);
  var_9[3] = (var_7[0], var_8[1], var_8[2]);
  var_10[0] = (var_8[0], var_7[1], var_8[2]);
  var_10[1] = (var_8[0], var_7[1], var_7[2]);
  var_10[2] = (var_7[0], var_7[1], var_7[2]);
  var_10[3] = (var_7[0], var_7[1], var_8[2]);

  if(var_1 != (0, 0, 0)) {
    var_9[0] = var_0 + _rotatevector(var_0 - var_9[0], var_1);
    var_9[1] = var_0 + _rotatevector(var_0 - var_9[1], var_1);
    var_9[2] = var_0 + _rotatevector(var_0 - var_9[2], var_1);
    var_9[3] = var_0 + _rotatevector(var_0 - var_9[3], var_1);
    var_10[0] = var_0 + _rotatevector(var_0 - var_10[0], var_1);
    var_10[1] = var_0 + _rotatevector(var_0 - var_10[1], var_1);
    var_10[2] = var_0 + _rotatevector(var_0 - var_10[2], var_1);
    var_10[3] = var_0 + _rotatevector(var_0 - var_10[3], var_1);
  }

  for(var_11 = 0; var_11 < 4; var_11++) {
    var_12 = var_11 + 1;

    if(var_12 == 4)
      var_12 = 0;
  }
}

_id_28BB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = (var_2, var_2, var_2);
  _id_2B5C(var_0, var_1, var_7, var_3, var_4, var_5, var_6);
}

_id_2B50(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = (1, 0, 0);
  var_7 = (0, 1, 0);
  var_8 = (0, 0, 1);

  if(isDefined(var_1) == 0)
    var_1 = 16.0;

  if(isDefined(var_2) == 0)
    var_2 = (0, 0, 0);
  else {
    var_6 = anglesToForward(var_2);
    var_7 = anglestoright(var_2) * -1.0;
    var_8 = anglestoup(var_2);
  }

  if(isDefined(var_3) == 0)
    var_3 = (1, 1, 1);

  if(isDefined(var_4) == 0)
    var_4 = 1.0;

  if(isDefined(var_5) == 0)
    var_5 = 1;

  var_6 = var_6 * var_1;
  var_7 = var_7 * var_1;
  var_8 = var_8 * var_1;
  var_9 = 0.333;
  var_10 = (var_9, var_9, var_9);
  var_11 = var_3 * var_10 + (1, 0, 0);
  var_12 = var_3 * var_10 + (0, 1, 0);
  var_13 = var_3 * var_10 + (0, 0, 1);
}

_id_4719() {
  var_0 = 1920;
  var_1 = 1080;
  var_2 = getDvar("r_dynamicSceneWidth");
  var_3 = getDvar("r_mode");
  var_4 = strtok(var_3, "x");

  if(isDefined(var_4) == 1 && var_4.size >= 2) {
    var_0 = int(var_4[0]);
    var_1 = int(var_4[1]);

    if(isDefined(level._id_0122) == 1 && level._id_0122 != 0) {
      var_5 = getdvarint("vid_width");
      var_6 = getdvarint("vid_height");

      if(isDefined(var_6) == 1 && var_6 > 0) {
        var_0 = var_5;
        var_1 = var_6;
      }
    } else if(isDefined(level._id_0148) == 1 && level._id_0148 != 0)
      var_0 = int(var_2);
    else if(isDefined(level._id_01D4) == 1 && level._id_01D4 != 0)
      var_0 = int(var_2);
  }

  return [var_0, var_1];
}

_id_7FF6(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_7FF7) == 0)
    _id_7FE5(isDefined(level._id_7FF7) == 0, "rvPlayAnimation was not initialized!");
  else {
    if(isDefined(var_2) == 0)
      var_2 = "animnotetrack";

    if(isDefined(var_3) == 0)
      var_3 = 1.0;

    self thread[[level._id_7FF7]](var_0, var_1, var_2, var_3);
  }
}

_id_063B(var_0, var_1, var_2) {
  if(_soundexists(var_0) == 0)
    return undefined;

  var_3 = _getsndaliasvalue(var_0, var_1);

  if(isDefined(var_3) == 0 || "" + var_3 == "")
    return undefined;

  var_4 = _float(var_3);

  for(var_5 = _getsndaliasvalue(var_0, "secondaryaliasname"); isDefined(var_5) == 1 && var_5 != ""; var_5 = _getsndaliasvalue(var_5, "secondaryaliasname")) {
    var_3 = _getsndaliasvalue(var_0, var_1);
    var_3 = _float(var_3);
    var_4 = call[[var_2]](var_4, var_3);
  }

  return var_4;
}

_id_468E(var_0, var_1) {
  var_2 = _id_063B(var_0, var_1, ::_min);
  return var_2;
}

_id_468D(var_0, var_1) {
  var_2 = _id_063B(var_0, var_1, ::max);
  return var_2;
}

_id_05DA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9))
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_8))
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(var_7))
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(var_6))
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_5))
    self[[var_0]](var_1, var_2, var_3, var_4, var_5);

  if(isDefined(var_4))
    self[[var_0]](var_1, var_2, var_3, var_4);

  if(isDefined(var_3))
    self[[var_0]](var_1, var_2, var_3);
  else if(isDefined(var_2))
    self[[var_0]](var_1, var_2);
  else if(isDefined(var_1))
    self[[var_0]](var_1);
  else
    self[[var_0]]();
}

_id_05D9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9))
    self call[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_8))
    self call[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(var_7))
    self call[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(var_6))
    self call[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_5))
    self call[[var_0]](var_1, var_2, var_3, var_4, var_5);

  if(isDefined(var_4))
    self call[[var_0]](var_1, var_2, var_3, var_4);

  if(isDefined(var_3))
    self call[[var_0]](var_1, var_2, var_3);
  else if(isDefined(var_2))
    self call[[var_0]](var_1, var_2);
  else if(isDefined(var_1))
    self call[[var_0]](var_1);
  else
    self call[[var_0]]();
}

_id_1E74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(_func_336(var_0) == 1)
    _id_05DA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else
    _id_05D9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_1E80(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread _id_1E74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_8A7C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = (0, 0, 0);
  var_8 = 39.3701;

  if(isDefined(var_2) == 0)
    var_2 = 1.0;

  if(isDefined(var_5) == 0)
    var_5 = 1.0;

  if(isDefined(var_6) == 0)
    var_6 = 343.3;

  if(var_2 == 0.0 && var_5 == 0.0 || var_6 == 0.0)
    return [0.0, 0.0, 0.0];

  var_9 = var_6 * var_8;
  var_10 = var_0 - var_3;
  var_11 = length(var_10);
  var_12 = 0.0;
  var_13 = 0.0;

  if(var_2 > 0 && var_1 != var_7) {
    var_12 = vectordot(var_1, var_10) / var_11;
    var_12 = var_12 * var_2;
  }

  if(var_5 > 0 && var_4 != var_7) {
    var_13 = vectordot(var_4, var_10) / var_11;
    var_13 = var_13 * var_5;
  }

  var_14 = (var_9 - var_12) / (var_9 - var_13);
  return [var_14, var_12, var_13];
}

_id_525E(var_0, var_1) {
  var_2 = [];
  var_3 = 1.0 / (var_1 - 1);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_4 * var_3;
    var_6 = 0;

    switch (var_0) {
      default:
        break;
      case "linear":
        var_2[0] = 0.0;
        var_2[1] = 1.0;
        return var_2;
      case "sine":
        var_6 = 0.5 + _cos(var_5 * 180) * -0.5;
      case "easein":
        var_6 = 1.0 - _cos(var_5 * 90);
        break;
      case "easeout":
        var_6 = _sin(var_5 * 90);
        break;
      case "easeinout":
        var_6 = 3 * _pow(var_5, 2) - 2 * _pow(var_5, 3);
        break;
      case "circularin":
        var_6 = 1.0 - _sqrt(1.0 - var_5 * var_5);
        break;
      case "circularout":
        var_6 = _sqrt(1.0 - (1.0 - var_5) * (1.0 - var_5));
        break;
      case "exponential_40db":
        var_2[0] = 0.0;
        var_2[1] = 0.0158489;
        var_2[2] = 0.0251189;
        var_2[3] = 0.0398107;
        var_2[4] = 0.0630957;
        var_2[5] = 0.1;
        var_2[6] = 0.158489;
        var_2[7] = 0.251189;
        var_2[8] = 0.398107;
        var_2[9] = 0.630957;
        var_2[10] = 1.0;
        return var_2;
      case "exponential_60db":
        var_2[0] = 0.0;
        var_2[1] = 0.0000197531;
        var_2[2] = 0.000316049;
        var_2[3] = 0.0016;
        var_2[4] = 0.00505679;
        var_2[5] = 0.0123457;
        var_2[6] = 0.0256;
        var_2[7] = 0.0474272;
        var_2[8] = 0.0809086;
        var_2[9] = 0.1296;
        var_2[10] = 0.197531;
        var_2[11] = 0.289205;
        var_2[12] = 0.4096;
        var_2[13] = 0.564168;
        var_2[14] = 0.758835;
        var_2[15] = 1.0;
        return var_2;
      case "default_vfcurve":
        var_2[0] = 0.0;
        var_2[1] = 0.2;
        var_2[2] = 0.42;
        var_2[3] = 0.65;
        var_2[4] = 1.0;
        return var_2;
    }

    var_2[var_2.size] = var_6;
  }

  return var_2;
}

_id_525F(var_0) {
  if(isDefined(var_0) == 0)
    var_0 = 11;

  level._id_05B3 = [];
  level._id_05B3["linear"] = _id_525E("linear", var_0);
  level._id_05B3["sine"] = _id_525E("sine", var_0);
  level._id_05B3["easein"] = _id_525E("easein", var_0);
  level._id_05B3["easeout"] = _id_525E("easeout", var_0);
  level._id_05B3["easeinout"] = _id_525E("easeinout", var_0);
  level._id_05B3["circularin"] = _id_525E("circularin", var_0);
  level._id_05B3["circularout"] = _id_525E("circularout", var_0);
  level._id_05B3["exponential_40db"] = _id_525E("exponential_40db", var_0);
  level._id_05B3["exponential_60db"] = _id_525E("exponential_60db", var_0);
  level._id_05B3["default_vfcurve"] = _id_525E("default_vfcurve", var_0);
}

_id_06DF(var_0) {
  if(isDefined(var_0) == 0)
    return "easeout";

  switch (var_0) {
    case "xfade":
      return "easeout";
  }

  return var_0;
}

_id_8A79(var_0) {
  var_1 = level._id_05B3[_id_06DF(var_0)];

  if(isDefined(var_1) == 1)
    return var_1.size;

  return 0;
}

_id_8A78(var_0) {
  var_1 = level._id_05B3[var_0];

  if(isDefined(var_1) == 1)
    return 1;

  return 0;
}

_id_8A7A(var_0, var_1) {
  var_1 = _id_06DF(var_1);
  var_2 = level._id_05B3[var_1];
  var_0 = clamp(var_0, 0.0, 1.0);
  var_3 = 0.0;
  var_4 = 1.0 / (var_2.size - 1);

  if(var_0 == 0.0)
    return 0.0;

  if(var_0 == 1.0)
    return 1.0;

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_6 = var_5 * var_4;
    var_7 = (var_5 + 1) * var_4;

    if(var_0 >= var_6 && var_0 <= var_7) {
      var_8 = var_0 - var_6;
      var_9 = var_7 - var_6;
      var_10 = var_8 / var_9;
      var_11 = var_2[var_5];
      var_12 = var_2[var_5 + 1];
      var_13 = var_12 - var_11;
      var_3 = var_11 + var_13 * var_10;
      break;
    }
  }

  return var_3;
}

_id_0708() {
  if(isDefined(self) == 1 && _isremovedentity(self) == 0 && isDefined(self._id_05C8) == 0) {
    self._id_05C8 = spawnStruct();
    self._id_05C8._id_A60D = 1.0;
    self._id_05C8._id_6FF7 = 1.0;
    self._id_05C8._id_996E = [];
  }
}

_id_070B(var_0, var_1, var_2) {
  if(isDefined(var_0._id_8F4E) == 1 && var_0._id_8F4E == "clientsnd")
    _func_357(var_0._id_4983, var_1, var_2);
  else if(isDefined(var_0._id_8F4E) == 1 && var_0._id_8F4E == "sndentity")
    var_0 _meth_8641(var_1, var_2);
  else
    var_0 scalevolume(var_1, var_2);
}

_id_070A(var_0, var_1, var_2) {
  if(isDefined(var_0._id_8F4E) == 1 && var_0._id_8F4E == "clientsnd")
    _func_355(var_0._id_4983, var_1, var_2);
  else if(isDefined(var_0._id_8F4E) == 1 && var_0._id_8F4E == "sndentity")
    var_0 _meth_8642(var_1, var_2);
  else
    var_0 scalepitch(var_1, var_2);
}

_id_070C(var_0, var_1) {
  if(_isremovedentity(self) == 1 || isDefined(self) == 0) {
    return;
  }
  _id_0708();

  if(isDefined(var_1) == 1) {
    if(var_1 == ::_id_070B)
      self._id_05C8._id_A60D = var_0;
    else if(var_1 == ::_id_070A)
      self._id_05C8._id_6FF7 = var_0;
  }
}

_id_06F7(var_0) {
  if(isDefined(self._id_05C8) == 1) {
    if(var_0 == ::_id_070B)
      return self._id_05C8._id_A60D;
    else if(var_0 == ::_id_070A)
      return self._id_05C8._id_6FF7;
  }

  return undefined;
}

_id_0707() {
  var_0 = 0;
  var_1 = undefined;
  self waittill("sfx_scale_completed", var_2);

  if(var_2 == ::_id_070B) {
    self._id_05C8._id_57B7 = undefined;
    var_1 = "volume";
  }

  if(var_2 == ::_id_070A) {
    self._id_05C8._id_57B6 = undefined;
    var_1 = "pitch";
  }

  self._id_05C8._id_996E[var_1] = undefined;

  if(isDefined(self._id_05C8._id_57B7) == 0 && isDefined(self._id_05C8._id_57B6) == 0)
    self._id_05C8._id_57B5 = undefined;

  self notify("sfx_stop_scale_" + var_1);
  waittillframeend;
}

_id_0709(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("deleted");
  self endon("death");
  var_5 = _id_8A79(var_0);
  var_6 = _float(var_2) % 0.05;
  var_2 = _float(var_2) + 0.05 - var_6;
  var_7 = _float(var_2) / _float(var_5);
  var_8 = var_7 % 0.05;
  var_7 = var_7 + 0.05 - var_8;
  var_7 = max(var_7, 0.05);
  var_9 = int(var_7 * 1000.0 + 0.5);
  var_10 = int(var_2 * 1000.0 + 0.5);
  var_11 = int(0.0);

  if(isDefined(self._id_05C8._id_57B5) == 1) {
    var_12 = 0;

    if(isDefined(self._id_05C8._id_57B7) == 1 && var_3 == ::_id_070B || isDefined(self._id_05C8._id_57B6) == 1 && var_3 == ::_id_070A)
      var_12 = 1;

    if(var_12 == 1) {
      self notify("sfx_scale_completed", var_3);
      waittillframeend;
      self notify("sfx_scale_interrupted", var_3);
    }
  }

  var_13 = _id_06F7(var_3);
  var_14 = 0.0;

  if(var_13 > var_1)
    var_14 = 1.0;

  while(isDefined(self._id_8F3E) == 0 && isDefined(self.guid) == 0)
    waitframe();

  waittillframeend;
  thread _id_0707();
  self._id_05C8._id_57B5 = 1;
  var_15 = undefined;

  if(var_3 == ::_id_070B) {
    self._id_05C8._id_57B7 = 1;
    var_15 = "volume";
  }

  if(var_3 == ::_id_070A) {
    self._id_05C8._id_57B6 = 1;
    var_15 = "pitch";
  }

  self._id_05C8._id_996E[var_15] = thisthread;
  self endon("sfx_stop_scale_" + var_15);

  while(var_11 < var_10 && isDefined(self) == 1 && isDefined(self._id_05C8._id_996E[var_15]) == 1) {
    var_16 = (var_10 - var_11) * 0.001;

    if(isDefined(self._id_05C8._id_A6F2) == 1)
      var_7 = max(self._id_05C8._id_A6F2, 0.05);

    var_17 = _min(var_7, var_16);
    var_11 = var_11 + int(var_17 * 1000.0 + 0.5);
    var_18 = _float(var_11) / _float(var_10);
    var_19 = 1.0;

    if(var_14 > 0.0) {
      var_18 = clamp(1.0 - var_18, 0.0, 1.0);
      var_20 = _id_8A7A(var_18, var_0);
      var_19 = _func_2CA(var_1, var_13, var_20);
    } else {
      var_20 = _id_8A7A(var_18, var_0);
      var_19 = _func_2CA(var_13, var_1, var_20);
    }

    [[var_3]](self, var_19, var_17);
    wait(var_17);

    if(isDefined(self) == 1 && _isremovedentity(self) == 0)
      _id_070C(var_19, var_3);
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self) == 1)
    self notify("sfx_scale_completed", var_3);

  if(isDefined(var_4) == 1)
    self[[var_4]]();
}

_id_8AAD(var_0) {
  _id_0708();
  self._id_05C8._id_A6F2 = max(var_0, 0.05);
}

_id_8AA9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0.00390625;
  var_6 = 2.0;
  var_7 = 0.0;
  var_8 = 4.0;

  if(_id_7FE5(isDefined(self) == 0, "sfx_scale: called on undefined entity")) {
    return;
  }
  if(_id_7FE5(_isremovedentity(self) == 1, "sfx_scale: called on removed entity")) {
    return;
  }
  _id_0708();
  var_9 = var_1;
  var_10 = undefined;
  var_11 = undefined;

  switch (var_0) {
    case "vol":
    case "Volume":
    case "Vol":
    case "V":
    case "volume":
    case "v":
      var_10 = ::_id_070B;
      var_11 = "volume";
      var_9 = clamp(var_1, var_7, var_8);
      _id_7FE5(var_1 != var_9, "sfx_scale: clamped volume " + var_1 + " -> " + var_9);
      break;
    case "Pitch":
    case "P":
    case "pitch":
    case "p":
      var_10 = ::_id_070A;
      var_11 = "pitch";
      var_9 = clamp(var_1, var_5, var_6);
      _id_7FE5(var_1 != var_9, "sfx_scale: clamped pitch " + var_1 + " -> " + var_9);
      break;
  }

  if(isDefined(var_2) == 0 || var_2 == 0.0) {
    [[var_10]](self, var_9, 0.0);
    _id_070C(var_9, var_10);
    self notify("sfx_scale_completed", var_10);
    self notify("sfx_scale_interrupted");
    self notify("sfx_stop_scale_" + var_11);
    return;
  }

  thread _id_0709(var_3, var_9, var_2, var_10, var_4);

  if(var_10 == ::_id_070B)
    self notify("rvSndAbortInitialFadeIn");
}

_id_8AAF(var_0, var_1, var_2, var_3) {
  _id_8AA9("volume", var_0, var_1, var_2, var_3);
}

_id_8AAC(var_0, var_1, var_2, var_3) {
  _id_8AA9("pitch", var_0, var_1, var_2, var_3);
}

_id_8AAB(var_0) {
  return var_0 _id_06F7(::_id_070B);
}

_id_8AAA(var_0) {
  return var_0 _id_06F7(::_id_070A);
}

_id_06F8(var_0) {
  if(isDefined(self._id_05C6) == 0) {
    return;
  }
  if(isDefined(var_0) == 1) {
    if(isDefined(self._id_05C6[var_0]) == 1) {
      if(isDefined(self._id_05C6[var_0]._id_93F9) == 1)
        self[[self._id_05C6[var_0]._id_93F9]](self._id_05C6[var_0]._id_A22D);

      self._id_05C6[var_0] = undefined;
    }
  } else {
    foreach(var_2 in self._id_05C6) {
      if(isDefined(var_2._id_93F9) == 1)
        self[[var_2._id_93F9]](var_2._id_A22D);

      self._id_05C6 = undefined;
    }
  }

  if(isDefined(self._id_05C6) == 0 || self._id_05C6.size == 0) {
    level._id_05C5 = common_scripts\utility::_id_0F93(level._id_05C5, self);
    level._id_05C5 = common_scripts\utility::_id_0FA0(level._id_05C5);
    self._id_05C6 = undefined;
    self._id_05C7 = undefined;
    self notify("param_stop");
  }
}

_id_06FC() {
  self endon("param_stop");
  common_scripts\utility::_id_A70A("death", "disconnect");
  _id_06F8();
}

_id_06FB() {
  if(isDefined(self._id_05C7) == 1) {
    return;
  }
  self._id_05C7 = thisthread;
  thread _id_06FC();
  self endon("disconnect");
  self endon("param_stop");

  while(_isremovedentity(self) == 0 && isDefined(self._id_05C6) == 1 && self._id_05C6.size > 0) {
    var_0 = gettime();

    foreach(var_2 in self._id_05C6) {
      var_2._id_5796 = 1;

      if(isDefined(var_2._id_53BF) == 1)
        var_2._id_53C2 = self[[var_2._id_53BF]](var_2._id_A22D);

      if(isDefined(var_2._id_6C76) == 1) {
        if(var_2._id_A22D.size > 0) {}

        foreach(var_6, var_4 in var_2._id_6C76) {
          if(_id_56DB(self) == 1) {
            var_5 = undefined;

            if(var_2._id_A22D.size > 0)
              var_5 = var_2._id_A22D[var_6];

            self thread[[var_4]](var_2._id_53C2, var_5);
          }
        }
      }

      var_2._id_5796 = undefined;
    }

    waitframe();
  }

  if(_isremovedentity(self) == 1)
    _id_06F8();
}

_id_06F9(var_0) {
  if(isDefined(level._id_05C5) == 0)
    level._id_05C5 = [];

  if(isDefined(self._id_05C6) == 0)
    self._id_05C6 = [];

  if(isDefined(self._id_05C6[var_0]) == 0)
    self._id_05C6[var_0] = spawnStruct();

  if(common_scripts\utility::_id_0F79(level._id_05C5, self) == 0)
    level._id_05C5[level._id_05C5.size] = self;
}

_id_8A95(var_0, var_1) {
  _id_06F9(var_0);
  self._id_05C6[var_0]._id_53BF = var_1;
  self._id_05C6[var_0]._id_53C2 = undefined;
  thread _id_06FB();
}

_id_8A9A(var_0, var_1, var_2) {
  _id_06F9(var_0);

  if(isDefined(self._id_05C6[var_0]._id_6C76) == 0)
    self._id_05C6[var_0]._id_6C76 = [];

  var_3 = self._id_05C6[var_0]._id_6C76.size;
  self._id_05C6[var_0]._id_6C76[var_3] = var_1;

  if(isDefined(self._id_05C6[var_0]._id_A22D) == 0)
    self._id_05C6[var_0]._id_A22D = [];

  if(common_scripts\utility::_id_0F79(self._id_05C6[var_0]._id_A22D, var_2) == 0) {
    var_4 = self._id_05C6[var_0]._id_A22D.size;
    self._id_05C6[var_0]._id_A22D[var_4] = var_2;
  } else {}

  thread _id_06FB();
}

_id_0700(var_0, var_1, var_2) {
  _id_06F9(var_0);
  self._id_05C6[var_0]._id_92C2 = var_1;
  self._id_05C6[var_0]._id_93F9 = var_2;

  if(isDefined(self._id_05C6[var_0]._id_92C2) == 1)
    self[[self._id_05C6[var_0]._id_92C2]]();
}

_id_8A9B(var_0) {
  _id_06F8(var_0);
}

_id_8A91(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0700(var_0, var_1, var_4);
  _id_8A95(var_0, var_2);
  _id_8A9A(var_0, var_3, var_5);
}

_id_8A93(var_0) {
  if(isDefined(self._id_05C6) == 1 && isDefined(self._id_05C6[var_0]) == 1 && isDefined(self._id_05C6[var_0]._id_53BF) == 1) {
    var_1 = self._id_05C6[var_0];

    if(isDefined(var_1._id_53C2) == 1)
      return var_1._id_53C2;
    else
      return self[[var_1._id_53BF]](var_1._id_A22D);
  }

  return undefined;
}

_id_8A92(var_0) {
  if(isDefined(self._id_05C6) == 1 && _isarray(self._id_05C6) == 1 && isDefined(self._id_05C6[var_0]) == 1)
    return 1;

  return 0;
}

_id_8A94(var_0) {
  if(isDefined(self._id_05C6) == 1 && _isarray(self._id_05C6) == 1) {
    foreach(var_2 in self._id_05C6) {
      if(var_2._id_53BF == var_0)
        return 1;
    }
  }

  return 0;
}

_id_8A99(var_0) {
  var_1 = gettime();

  if(isDefined(self._id_6C46) == 1 && self._id_6C46 == var_1)
    return self._id_6C45;

  if(isDefined(self._id_6C40) == 0)
    self._id_6C40 = self.origin;

  self._id_6C45 = self.origin - self._id_6C40;
  self._id_6C46 = var_1;
  self._id_6C40 = self.origin;
  return self._id_6C45;
}

_id_8A98(var_0) {
  var_1 = _id_8A99();
  self._id_6C44 = length(var_1);
  return self._id_6C44;
}

_id_8A97(var_0) {
  var_1 = gettime();

  if(isDefined(self._id_0DD4) == 1 && self._id_0DD4 == var_1)
    return self._id_05AE;

  var_2 = self.angles;

  if(isPlayer(self) == 1 || _isai(self) == 1)
    var_2 = self getplayerangles();
  else if(isDefined(self.model) == 1) {
    var_3 = 0;

    if(isDefined(var_0) == 1 && _isarray(var_0) == 1 && _isstring(var_0[0]) == 1) {
      var_4 = var_0[0];
      var_5 = self gettagindex(var_4);

      if(var_5 >= 0) {
        var_2 = self gettagangles(var_4);

        if(isDefined(var_2) == 1)
          var_3 = 1;
      }
    }

    if(var_3 == 0)
      var_2 = self gettagangles("tag_origin");
  }

  if(var_2[0] > 180.0)
    var_2 = var_2 - (360, 0, 0);

  if(var_2[1] > 180.0)
    var_2 = var_2 - (0, 360, 0);

  if(var_2[2] > 180.0)
    var_2 = var_2 - (0, 0, 360);

  if(isDefined(self._id_05AE) == 0)
    self._id_05AE = var_2;

  if(isDefined(self._id_05A6) == 0)
    self._id_05A6 = var_2;

  self._id_05A6 = self._id_05AE;
  self._id_05AE = var_2;
  return self._id_05AE;
}

_id_8A96(var_0) {
  var_1 = _id_8A97(var_0);
  self._id_05AF = var_1 - self._id_05A6;
  return self._id_05AF;
}

_id_070D(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", self.origin);
  var_3 linkto(self, var_0._id_95A6, var_0._id_6A15, (0, 0, 0));
  var_3 dontinterpolate();
  return var_3;
}

_id_070F(var_0, var_1, var_2) {
  var_0._id_378F dontinterpolate();
  var_0._id_378F._id_8F47 = _id_02F0::_id_800B(var_0._id_0BB4, var_0._id_378F);
  _id_02F0::disableplayeruse(var_0._id_378F._id_8F47, 0.0, 0.0);
  _id_02F0::enableplayeruse(var_0._id_378F._id_8F47, var_2, 0.0);
  common_scripts\utility::_id_2CB4(0.05, _id_02F0::disableplayeruse, var_0._id_378F._id_8F47, var_1, 0.05);
  common_scripts\utility::_id_2CB4(0.05, _id_02F0::enableplayeruse, var_0._id_378F._id_8F47, var_2, 0.05);
}

_id_0710(var_0, var_1, var_2) {
  if(isDefined(var_0._id_378F) == 0) {
    return;
  }
  var_3 = var_0._id_378F;
  var_4 = var_0._id_378F._id_8F47;

  if(isDefined(var_4) == 1) {
    if(isDefined(var_1) == 1) {
      if(isDefined(var_2) == 0)
        var_2 = "easeinout";

      _id_02F0::disableplayeruse(var_4, 0.0, var_1, var_2);
      wait(var_1);
    }

    _id_02F0::enableammogeneration(var_0._id_378F._id_8F47);
    waitframe();
  }

  var_3 delete();
  var_3 = undefined;
}

_id_06FE(var_0, var_1) {
  var_2 = 0.01;
  var_3 = 0.001;
  var_4 = var_0;
  var_5 = var_1;

  if(var_4 < var_2)
    var_4 = 0.0;

  var_6 = var_5._id_A614["speed"][0];
  var_7 = var_5._id_A614["speed"][1];
  var_8 = var_5._id_A614["scale"][0];
  var_9 = var_5._id_A614["scale"][1];
  var_10 = var_5._id_A614["curve"][0];
  var_11 = var_5._id_6FFC["speed"][0];
  var_12 = var_5._id_6FFC["speed"][1];
  var_13 = var_5._id_6FFC["scale"][0];
  var_14 = var_5._id_6FFC["scale"][1];
  var_15 = var_5._id_6FFC["curve"][0];
  var_16 = startignoringspotlight(var_4, var_6, var_7, var_8, var_9);
  var_17 = startignoringspotlight(var_4, var_11, var_12, var_13, var_14);

  if(isDefined(var_5._id_378F) == 1 && isDefined(var_5._id_378F._id_8F47) == 1 && var_16 <= var_3) {
    thread _id_0710(var_5);
    var_5._id_378F = undefined;
    return;
  } else if(isDefined(var_5._id_378F) == 0 && var_16 > var_3) {
    var_5._id_378F = _id_070D(var_5, var_16, var_17);
    return;
  }

  if(isDefined(var_5._id_378F) == 1) {
    if(isDefined(var_5._id_378F._id_8F47) == 0) {
      thread _id_070F(var_5, var_16, var_17);
      var_5._id_378F._id_90EE = var_4;
    } else {
      var_18 = _abs(var_4 - var_5._id_378F._id_90EE);

      if(var_18 > var_2) {
        _id_02F0::disableplayeruse(var_5._id_378F._id_8F47, var_16, 0.05, var_10);
        _id_02F0::enableplayeruse(var_5._id_378F._id_8F47, var_17, 0.05, var_15);
        var_5._id_378F._id_90EE = var_4;
      }
    }
  }
}

_id_0702(var_0) {
  var_1 = self._id_05CB;
  var_2 = self._id_05CC;

  if(isDefined(var_0) == 1) {
    foreach(var_4 in var_0)
    thread _id_0710(var_4, var_1, var_2);
  }

  self._id_05CD = undefined;
  self._id_05CB = undefined;
  self._id_05CC = undefined;
  self._id_05CA = undefined;
}

_id_070E(var_0, var_1, var_2, var_3, var_4) {
  if(_soundexists(var_0) == 0) {
    return;
  }
  if(isDefined(self._id_05CA) == 0)
    self._id_05CA = [];

  if(isDefined(var_1) == 0)
    var_1 = "tag_origin";

  if(isDefined(var_2) == 0)
    var_2 = (0, 0, 0);

  if(isDefined(var_3["curve"]) == 0)
    var_3["curve"] = ["linear"];

  if(isDefined(var_4["curve"]) == 0)
    var_4["curve"] = ["xfade"];

  var_5 = spawnStruct();
  var_5._id_0BB4 = var_0;
  var_5._id_95A6 = var_1;
  var_5._id_6A15 = var_2;
  var_5._id_6FFC = var_3;
  var_5._id_A614 = var_4;
  self._id_05CA[self._id_05CA.size] = var_5;
  _id_8A91("speed", undefined, ::_id_8A98, ::_id_06FE, ::_id_0702, var_5);
}

_id_8AB7(var_0, var_1) {
  if(isDefined(var_0) == 0)
    var_0 = 0.05;

  if(isDefined(var_1) == 0)
    var_1 = "easeinout";

  self._id_05CD = 1;
  self._id_05CB = var_0;
  self._id_05CC = var_1;
  _id_8A9B("speed");
}

_id_8AAE(var_0, var_1, var_2, var_3, var_4) {
  thread _id_070E(var_0, var_1, var_2, var_3, var_4);
}

_id_0718() {
  if(isDefined(self._id_05D1) == 1) {
    self waittill("sfx_stop_audioTimer");

    if(isDefined(self._id_05D1._id_8F40) == 1)
      self._id_05D1._id_8F40 delete();

    self._id_05D1 = undefined;
  }
}

_id_0719(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_2) == 0)
    var_2 = var_1;

  if(isDefined(var_3) == 0)
    var_3 = 1.0;

  if(isDefined(var_4) == 0)
    var_4 = 1.0;

  if(isDefined(var_5) == 0)
    var_5 = "linear";

  thread _id_0718();
  self endon("sfx_stop_audioTimer");

  while(gettime() <= self._id_05D1._id_36ED) {
    var_7 = gettime();
    var_8 = self._id_05D1._id_36ED - var_7;
    var_9 = 1000;

    if(var_8 <= 5000)
      var_9 = 500;

    if(var_8 <= 3000)
      var_9 = 250;

    if(var_8 <= 1000)
      var_9 = 50;

    var_10 = var_8 - var_9;
    var_11 = var_10 % var_9;
    var_10 = var_10 + var_9 - var_11;

    if(var_8 <= var_10) {
      if(self._id_05D1._id_8F4D != 0) {
        self._id_05D1._id_8F40 playSound(var_1);
        self._id_05D1._id_8F4D = 0;
      } else {
        self._id_05D1._id_8F40 playSound(var_2);
        self._id_05D1._id_8F4D = 1;
      }

      var_12 = startignoringspotlight(var_8, 0, var_0, var_4, var_3);
      self._id_05D1._id_8F40 _id_8AAC(var_12, 0.05, var_5);
    }

    waitframe();
  }

  if(isDefined(var_6) == 1)
    self[[var_6]]();

  self notify("sfx_stop_audioTimer");
}

_id_8AC4() {
  if(isDefined(self._id_05D1) == 1)
    self notify("sfx_stop_audioTimer");
}

_id_8AC3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(self._id_05D1) == 1)
    _id_8AC4();

  var_8 = gettime();
  var_0 = int(var_0 * 1000.0 + 0.5);

  if(isDefined(self._id_05D1) == 0) {
    self._id_05D1 = spawnStruct();
    self._id_05D1._id_36ED = var_8 + var_0;
    self._id_05D1._id_8F4D = 0;
    self._id_05D1._id_8F40 = spawn("script_origin", self.origin);
    self._id_05D1._id_8F40 linkto(self);
  }

  thread _id_0719(var_0, var_1, var_2, var_4, var_5, var_6, var_7);
}

_id_8A81() {
  level notify("sfx_dvar_stop");
}

_id_06F6() {
  level endon("game_ended");
  level endon("sfx_dvar_stop");

  for(;;) {
    foreach(var_1 in level._id_05C0) {
      var_2 = var_1._id_1E61;
      var_3 = var_1._id_59E1;
      var_4 = getDvar(var_3);

      if(isDefined(var_2) && isDefined(var_3) && isDefined(var_4) && var_1.value != var_4) {
        var_5 = [[var_2]](var_3, var_4);

        if(isDefined(var_5)) {
          setDvar(var_3, var_5);
          var_1.value = var_5;
        } else
          var_1.value = var_4;
      }
    }

    waitframe();

    if(isDefined(level.hostmigrationtimer)) {
      _id_A782();

      foreach(var_1 in level._id_05C0)
      _sfx_dvar_init_value(var_1._id_59E1, var_1.value);
    }
  }
}

_id_A782() {
  if(!isDefined(level.hostmigrationtimer))
    return 0;

  var_0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_0;
}

_id_06F5() {
  if(isDefined(level._id_05C0) == 0) {
    level._id_05C0 = [];
    level thread _id_06F6();
  }
}

_id_06F4(var_0, var_1, var_2) {
  _id_8A80(var_0);
  level._id_05C0[var_0] = spawnStruct();
  level._id_05C0[var_0]._id_1E61 = var_2;
  level._id_05C0[var_0]._id_59E1 = var_0;
  level._id_05C0[var_0].value = var_1;
  _sfx_dvar_init_value(var_0, var_1);
}

_sfx_dvar_init_value(var_0, var_1) {
  var_2 = getDvar(var_0);

  if(isDefined(var_2) == 0 || var_2 == "")
    setdvarifuninitialized(var_0, var_1);
}

_id_8A80(var_0) {
  if(isDefined(level._id_05C0[var_0]))
    level._id_05C0[var_0] = undefined;
}

_id_8A7F(var_0, var_1, var_2) {
  _id_06F5();
  _id_06F4(var_0, var_1, var_2);
}

_id_0705() {
  if(isDefined(level._id_05B7) == 1) {
    return;
  }
  level._id_05B7 = thisthread;

  while(isDefined(level._id_05B6) == 1) {
    var_0 = gettime();
    var_1 = [];

    foreach(var_3 in level._id_05B6) {
      if(var_3.duration > 0) {
        var_1[var_1.size] = var_3;

        if(var_3.time == var_0) {
          continue;
        }
        var_3.duration = var_3.duration - 1;

        if(var_3._id_99F9 <= var_0) {
          var_3.alpha = 0.0;
          var_3 settext("");
        }

        continue;
      }

      var_3 destroy();
    }

    level._id_05B6 = var_1;
    waitframe();
  }
}

_id_0704(var_0) {
  var_1 = undefined;
  var_2 = gettime();
  var_3 = var_0 * 50;
  return var_1;
}

_id_0703(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 640;
  var_8 = 480;
  var_9 = var_7 / var_8;
  var_10 = _id_4719();
  var_11 = var_10[0];
  var_12 = var_10[1];
  var_13 = var_11 / var_12;
  var_14 = -0.5 * (var_8 * var_13 - var_7);
  var_15 = var_0 / var_11 * var_7 + (1.0 - var_0 / (var_11 * 0.5)) * var_14;
  var_16 = var_1 / var_12 * var_8;

  if(isDefined(level._id_05B6) == 0)
    level._id_05B6 = [];

  level thread _id_0705();
  var_17 = _id_0704(var_6);
  var_17.x = var_15;
  var_17.y = var_16;
  var_17 settext(var_2);
  var_17.color = var_3;
  var_17.alpha = var_4;
  var_17.fontscale = var_5 * 0.5;
  var_17._id_009A = "smallfixed";
  var_17.alignx = "left";
  var_17.aligny = "bottom";
  var_17._id_4DF6 = "fullscreen";
  var_17._id_01CA = "fullscreen";
  var_17._id_AACD = 0;
  var_17._id_AAEB = 0;
  var_17._id_AACF = 0;
  var_17._id_AAEC = 0;
}

_id_8AA0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_2) == 0 || var_2 == "") {
    return;
  }
  if(isDefined(var_3) == 0)
    var_3 = _id_A2BB((1, 1, 1), 1.0);

  if(isDefined(var_4) == 0)
    var_4 = 1.0;

  if(isDefined(var_5) == 0)
    var_5 = 1.0;

  if(isDefined(var_6) == 0)
    var_6 = 1;

  if(isDefined(level._id_05B5) == 1)
    _id_0703(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  else {}
}

_id_8AA4(var_0) {
  if(isDefined(var_0) == 1 && var_0 != 0)
    level._id_05B5 = 1;
  else
    level._id_05B5 = undefined;
}

_id_8AA2(var_0, var_1) {
  if(isDefined(var_1) == 0)
    var_1 = 1.0;

  var_2 = _id_4719();
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_0.size;
  var_6 = var_5 * 6 * var_1;
  var_7 = var_3 * 0.5 - var_6 * 0.5;
  var_8 = var_4 * 0.5 - 6.0;
  return [var_7, var_8];
}

_id_8AA3(var_0, var_1) {
  var_2 = _id_8AA2(var_0, var_1);
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_4 = var_4 * 0.5 + 6.0;
  return [var_3, var_4];
}

_id_0706(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = int(var_5 / 0.05);
  var_8 = 0;
  var_9 = int(var_6 / 0.05);
  var_10 = 1;
  var_11 = 0;

  if(isDefined(level._id_05AD) == 0)
    level._id_05AD = [];

  if(level._id_05AD.size > 0) {
    var_12 = 12 * var_4;

    foreach(var_14 in level._id_05AD) {
      if(common_scripts\utility::_id_0F79(level._id_05AD, var_1) == 1) {
        var_1 = var_1 + var_12;
        continue;
      }

      break;
    }
  }

  level._id_05AD = common_scripts\utility::_id_0F6F(level._id_05AD, var_1);

  while(var_8 < var_7) {
    if(var_8 < var_9) {
      var_16 = int(_float(var_8) / _float(var_10));
      var_16 = var_16 % 2;

      if(var_16) {
        var_8 = var_8 + 1;
        waitframe();
        continue;
      }
    }

    var_17 = _float(var_8) / _float(var_7);
    var_17 = clamp(var_17, 0.0, 1.0);
    var_18 = _id_8A7A(1.0 - var_17, "easeout");
    var_19 = _id_A2BD(var_3, var_18);
    _id_8AA0(var_0, var_1, var_2, var_19, var_18, var_4, 1);
    var_8 = var_8 + 1;
    waitframe();
  }

  level._id_05AD = common_scripts\utility::_id_0F93(level._id_05AD, var_1);
}

_id_8AA1(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3) == 0)
    var_3 = (1, 0, 0);

  if(isDefined(var_4) == 0)
    var_4 = 2.0;

  if(isDefined(var_5) == 0)
    var_5 = 4.0;

  if(isDefined(var_6) == 0)
    var_6 = 1.0;

  if(isDefined(var_1) == 0 || isDefined(var_2) == 0) {
    var_7 = _id_8AA3(var_0, var_4);

    if(isDefined(var_1) == 0)
      var_1 = var_7[0];

    if(isDefined(var_2) == 0)
      var_2 = var_7[1];
  }

  level thread _id_0706(var_1, var_2, var_0, var_3, var_4, var_5, var_6);
}

_id_8AA5(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_8AA6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_6 * (var_1.size * -2.93) * var_4;
}

_id_0716(var_0) {
  if(var_0 <= 9 && var_0 >= 0)
    return "0" + var_0;

  return "" + var_0;
}

_id_0715(var_0, var_1, var_2) {
  if(isDefined(var_1) == 0)
    var_1 = 20;

  if(isDefined(var_2) == 0)
    var_2 = 0;

  var_3 = int(var_0 / var_1);
  var_4 = int(var_3 / 60.0);
  var_5 = int(var_4 / 60.0);
  var_6 = int(var_5 / 24.0);
  var_7 = var_0 % var_1;
  var_8 = var_7 / var_1 * 100;
  var_9 = var_3 % 60;
  var_10 = var_4 % 60;
  var_11 = var_5 % 60;
  var_12 = var_6 % 99;
  var_13 = _id_0716(var_7);
  var_14 = _id_0716(var_8);
  var_15 = _id_0716(var_9);
  var_16 = _id_0716(var_10);
  var_17 = _id_0716(var_11);
  var_18 = _id_0716(var_12);
  var_19 = var_18 + ":" + var_17 + ":" + var_16 + ":" + var_15;

  if(var_2 == 1)
    var_19 = var_19 + ("." + var_14);
  else
    var_19 = var_19 + (":" + var_13);

  return var_19;
}

_id_0714(var_0, var_1, var_2) {
  if(isDefined(var_0) == 0)
    var_0 = 0;

  var_3 = var_2 / 20;
  var_4 = var_0;
  var_4 = var_4 + var_1 * var_3;
  var_4 = _floor(var_4);
  var_4 = int(var_4);
  return var_4;
}

_id_0717(var_0) {
  if(isDefined(var_0) == 0)
    var_0 = 0;

  var_1 = level._id_05D0._id_3E6B / 20;
  level._id_05D0 endon("sfx_timecode_done");
  level._id_05D0._id_565F = 1;
  level._id_05D0._id_3E71 = 0;
  level._id_05D0._id_52DB = var_0;

  while(isDefined(level._id_05D0) == 1 && level._id_05D0._id_565F == 1) {
    var_2 = level._id_05D0._id_75F6;
    var_3 = level._id_05D0._id_75F7;
    var_4 = 1.0;
    var_5 = level._id_05D0.fadeovertime;
    var_6 = _id_0714(var_0, level._id_05D0._id_3E71, level._id_05D0._id_3E6B);
    var_7 = _id_0715(var_6, level._id_05D0._id_3E6B);
    _id_8AA0(var_2, var_3, var_7, (1, 1, 1), var_4, var_5, 1);

    if(level._id_05D0._id_6014.size > 0) {
      var_3 = var_3 + var_5 * 12;
      _id_8AA0(var_2, var_3, "--------------", (1, 1, 1), var_4, var_5, 1);
      var_3 = var_3 + var_5 * 12;

      foreach(var_9 in level._id_05D0._id_6014) {
        var_10 = var_9[1];
        var_11 = _id_0714(var_0, var_9[0], level._id_05D0._id_3E6B);
        var_12 = _id_0715(var_11, level._id_05D0._id_3E6B);
        var_13 = var_12 + " - " + var_10 + "\n";
        _id_8AA0(var_2, var_3, var_13, (1, 1, 1), var_4, var_5, 1);
        var_3 = var_3 + var_5 * 12;
      }
    }

    level._id_05D0._id_3E71 = level._id_05D0._id_3E71 + 1;
    waitframe();
  }
}

_id_8AC1() {
  if(isDefined(level._id_05D0) == 0) {
    return;
  }
  level._id_05D0 notify("sfx_timecode_done");
  level._id_05D0._id_565F = 0;
  level._id_05D0._id_5848 = 0;
  level._id_05D0._id_6014 = undefined;
  level._id_05D0 = undefined;
}

_id_8ABF(var_0) {
  if(isDefined(level._id_05D0) == 0)
    _id_8ABE();

  var_1 = level._id_05D0._id_6014.size;
  level._id_05D0._id_6014[var_1] = [level._id_05D0._id_3E71, var_0];
}

_id_8AC0() {
  if(isDefined(level._id_05D0) == 1 && isDefined(level._id_05D0._id_6014) == 1) {
    for(var_0 = 0; var_0 < level._id_05D0._id_6014.size; var_0++)
      level._id_05D0._id_6014[var_0] = undefined;
  }
}

_id_8ABE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1;

  if(isDefined(level._id_05D0) == 1)
    _id_8AC1();

  level._id_05D0 = spawnStruct();
  level._id_05D0._id_6014 = [];

  if(isDefined(var_0) == 0)
    var_0 = 20;

  if(isDefined(var_1) == 0)
    var_1 = 2.0;

  var_1 = var_1 / 1;
  var_7 = _id_4719();
  var_8 = var_7[0];
  var_9 = var_7[1];
  var_10 = 84 * var_1;
  var_11 = var_8 * 0.5 - var_10 * 0.5;
  var_12 = var_9 * 0.5 - 6.0;

  if(isDefined(var_2) == 0)
    var_2 = var_11;

  if(isDefined(var_3) == 0) {
    var_13 = 192;
    var_3 = var_12 + var_13;
  }

  level._id_05D0._id_75F6 = var_2;
  level._id_05D0._id_75F7 = var_3;
  level._id_05D0.fadeovertime = var_1;
  level._id_05D0._id_3E6B = var_0;
  level._id_05D0._id_5848 = var_6;
  level._id_05D0._id_A231 = var_4;
  level._id_05D0 thread _id_0717(var_5);
}

_id_06F2(var_0, var_1, var_2, var_3) {
  if(var_2.size < 2) {
    return;
  }
  var_4 = var_2.size - 1;
  var_5 = 1.0;
  var_6 = 1.0 / var_4;

  for(var_7 = var_0; var_4 > 0; var_4--) {
    var_8 = var_2[var_4];
    var_9 = var_2[var_4 - 1];

    if(_isvector(var_8) == 1 && _isvector(var_9) == 1 && var_8 != var_9) {
      if(_isvector(var_3) == 1) {
        var_8 = var_8 + var_3;
        var_9 = var_9 + var_3;
      }
    }

    var_7 = _id_A2BB(var_0, var_5 * 1.5);
    var_5 = var_5 - var_6;
  }
}

_id_06F3(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = [];
  var_5[0] = self.origin;
  self endon("sfx_drawpath_stop");

  while(var_5.size > 0) {
    var_6 = [];

    if(var_4 >= var_2) {
      for(var_7 = 1; var_7 < var_5.size; var_7++)
        var_6[var_7 - 1] = var_5[var_7];
    } else
      var_6 = var_5;

    if(isDefined(self) == 1 && isDefined(self.origin) == 1 && _isremovedentity(self) == 0)
      var_6[var_6.size] = self.origin;

    var_5 = var_6;
    _id_06F2(var_0, var_1, var_5, var_3);
    var_4++;
    waitframe();
  }
}

_id_8A7E(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) == 0)
    var_0 = (1, 1, 1);

  if(isDefined(var_1) == 0)
    var_1 = 0;

  if(isDefined(var_2) == 0)
    var_2 = 5.0;

  var_2 = int(20.0 * var_2);
  thread _id_06F3(var_0, var_1, var_2, var_3);
}

_id_0607(var_0, var_1) {
  var_2 = _id_063D();
  var_3 = var_0;
  var_4 = "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params;adsr_name;adsr_zone_npc;adsr_zone_player";

  foreach(var_6 in var_2) {
    var_7 = _packedtablesectionlookup(var_6, var_3, var_4);

    if(_isarray(var_7) == 1) {
      var_8 = var_7[0];
      var_9 = var_7[1];

      for(var_10 = var_8 + 1; var_10 < var_9; var_10++) {
        var_11 = _tablelookupbyrow(var_6, var_10, 0);

        if(var_11 == var_1)
          return 1;
      }
    }
  }

  return 0;
}

_id_0636(var_0, var_1, var_2) {
  var_3 = var_1[0];
  var_4 = "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params;adsr_name;adsr_zone_npc;adsr_zone_player";
  var_5 = _packedtablesectionlookup(var_0, var_3, var_4);

  if(_isarray(var_5) == 1) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = [];

    for(var_9 = 0; var_9 < var_1.size; var_9++) {
      var_10 = _packedtablelookupwithrange(var_0, 0, var_3, var_9, var_6, var_7);
      var_8[var_8.size] = var_10;
    }

    var_11 = [];

    for(var_9 = var_6 + 1; var_9 < var_7; var_9++) {
      var_12 = _tablelookupbyrow(var_0, var_9, 0);

      if(isDefined(var_2) == 1 && var_12 == var_2 || isDefined(var_2) == 0) {
        var_13 = [];

        for(var_14 = 0; var_14 < var_8.size; var_14++) {
          var_15 = var_8[var_14];
          var_16 = _tablelookupbyrow(var_0, var_9, var_14);
          var_13[var_15] = var_16;
        }

        var_11[var_11.size] = var_13;
      }
    }

    if(var_11.size > 0)
      return var_11;
  }

  return undefined;
}

rvn_audio_include_additional_soundtablefilenames(var_0) {
  level._audioadditionalsountablefiles[var_0] = var_0;
}

_id_063D() {
  var_0 = [];
  var_0[0] = "soundtables/" + level._id_015D + ".csv";

  if(isDefined(level._id_579A) == 1 && level._id_579A == 1 && isDefined(level._id_79C2) == 1)
    var_0[var_0.size] = "soundtables/mp_raid_defaults.csv";

  if(common_scripts\utility::issp() == 1)
    var_0[var_0.size] = "soundtables/sp_defaults.csv";
  else
    var_0[var_0.size] = "soundtables/mp_defaults.csv";

  if(isDefined(level._audioadditionalsountablefiles)) {
    foreach(var_2 in level._audioadditionalsountablefiles)
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_063C(var_0, var_1) {
  var_2 = _id_063D();
  var_3 = [];

  foreach(var_5 in var_2)
  var_3[var_3.size] = _id_0636(var_5, var_0, var_1);

  if(var_3.size > 0)
    return var_3;

  return undefined;
}

_id_94CA(var_0) {
  var_1 = _id_0607("mix_names", var_0);
  return var_1;
}

_id_46B9(var_0) {
  var_1 = ["mix_names", "volmod", "value", "fadein", "fadeout"];
  return _id_063C(var_1, var_0);
}

_id_0711(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_5 notify("sfx_submix_envelope_" + var_0);
  var_5 endon("death");
  var_5 endon("disconnect");
  var_5 endon("sfx_submix_envelope_" + var_0);

  if(isDefined(var_4) == 0)
    var_4 = 1.0;

  var_5 clientaddsoundsubmix(var_0, 0.0);
  var_5 clientblendsoundsubmix(var_0, 0.0, 0.0);
  waitframe();
  var_5 clientblendsoundsubmix(var_0, var_4, var_1);
  wait(var_1);
  wait(var_2);
  var_5 clientblendsoundsubmix(var_0, 0.0, var_3);
  wait(var_3);
  waittillframeend;
  var_5 clientclearsoundsubmix(var_0);
}

_id_8AB8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5) == 0) {
    if(common_scripts\utility::issp() == 1)
      var_5 = [level.player];
    else if(isDefined(level.players) == 1)
      var_5 = level.players;
  }

  foreach(var_7 in var_5)
  var_7 _id_0711(var_0, var_1, var_2, var_3, var_4);
}

_id_42DD(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 2;

  if(!isDefined(level._id_05A9))
    level._id_05A9 = [];

  if(!isDefined(level._id_05A9[var_1]))
    level._id_05A9[var_1] = common_scripts\utility::array_randomize(getarraykeys(var_0));

  if(level._id_05A9[var_1].size <= var_2) {
    var_3 = common_scripts\utility::array_randomize(common_scripts\utility::_id_0F94(getarraykeys(var_0), level._id_05A9[var_1]));
    level._id_05A9[var_1] = common_scripts\utility::_id_0F73(var_3, level._id_05A9[var_1]);
  }

  var_4 = level._id_05A9[var_1][level._id_05A9[var_1].size - 1];
  level._id_05A9[var_1][level._id_05A9[var_1].size - 1] = undefined;
  return var_0[var_4];
}

_id_7FF8(var_0, var_1) {
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = "r";
  var_5 = "default";

  if(isDefined(var_0) && var_0)
    var_4 = "l";

  var_6 = "step_";

  if(isDefined(var_1) && var_1)
    var_6 = var_6 + "run_";
  else
    var_6 = var_6 + "walk_";

  if(isPlayer(self) == 1)
    var_6 = var_6 + "plr_";
  else {
    var_7 = "J_Ball_RI";
    var_8 = 180;

    if(var_0) {
      var_7 = "J_Ball_LE";
      var_8 = 0;
    }

    if(self gettagindex(var_7) >= 0)
      var_2 = self gettagorigin(var_7);
  }

  var_9 = bulletTrace(var_2 + (0, 0, 0), var_2 + (0, 0, -64), 0);

  if(var_9["fraction"] < 1 && var_9["fraction"] > 0 && var_9["surfacetype"] != "none") {
    var_5 = var_9["surfacetype"];
    var_2 = var_9["position"];
    var_10 = var_6 + var_5;

    if(isPlayer(self) == 1)
      var_10 = var_10 + ("_" + var_4);

    if(_soundexists(var_10) == 0)
      var_5 = "default";
  }

  var_6 = var_6 + var_5;

  if(isPlayer(self) == 1)
    var_6 = var_6 + ("_" + var_4);

  if(_soundexists(var_6) == 0) {
    return;
  }
  _id_02F0::_id_800A(var_6, var_2);
  return;
}

_id_8D6A(var_0, var_1) {
  if(var_1 != "" && _isstring(var_1) == 1) {
    _id_7FE5(1, "level notify( \"" + var_1 + "\" )");
    level notify(var_1);
  }

  return "";
}

_id_8DE6(var_0, var_1) {
  var_2 = "snd_enveffectsprio_shellshock";
  var_3 = strtok(var_1, " ");
  var_4 = 1.0;
  var_5 = 1.0;
  var_6 = 0.05;
  var_7 = "default";
  var_8 = ["alcove_carpet", "alcove_concrete", "alcove_marble", "alcove_metal", "alcove_wood", "alley", "bridge_ext", "bunker_concrete", "canyon", "cargo_container_sml", "cave", "city_street", "courtyard", "default", "elevator", "elevator_shaft", "field", "hall_carpet", "hall_concrete", "hall_marble", "hall_metal", "hall_wood", "hallway_carpet", "hallway_concrete", "hallway_concrete_lrg", "hallway_marble", "hallway_metal", "hallway_wood", "hangar", "mountains", "near_death", "parking_lot", "rooftop", "room_carpet", "room_concrete", "room_marble", "room_metal", "room_wood", "sewer", "stairwell", "tunnel", "underpass", "underwater", "veh_int"];

  if(isDefined(var_3[0]) == 1) {
    var_9 = var_3[0];

    if(var_9 == "0" || int(var_9) > 0) {
      var_10 = int(var_9) % var_8.size;
      var_7 = var_8[var_10];
    } else if(int(var_9) >= 0)
      var_7 = var_9;
  }

  if(isDefined(var_3[1]) == 1)
    var_5 = _float(var_3[1]);

  if(isDefined(var_3[2]) == 1)
    var_4 = _float(var_3[2]);

  if(var_1 == "" || int(var_1) < 0) {
    level.player deactivatereverb(var_2, var_6);
    _iprintlnbold("xxxx REVERB DEACTIVATED xxxx");
    var_1 = "";
  } else {
    level.player setreverb(var_2, var_7, var_4, var_5, var_6);
    _iprintlnbold("Reverb: " + var_7 + " Wet: " + var_5 + " Dry: " + var_4);
  }

  return var_1;
}

_id_071E() {
  var_0 = self;
  var_0 endon("stop_crosshair3D");

  for(;;) {
    var_1 = var_0 getEye();
    var_2 = var_0 _meth_8566();
    var_3 = anglesToForward(var_2);
    var_4 = anglestoright(var_2);
    var_5 = var_1 + var_3 * 8192;
    var_6 = bulletTrace(var_1, var_5, 1, var_0, 1, 1);

    if(isDefined(var_6) == 1 && isDefined(var_6["position"]) == 1 && var_6["position"] != var_1) {
      var_7 = var_6["position"];
      var_8 = var_6["surfacetype"];
      var_9 = "( " + var_7[0] + ", " + var_7[1] + ", " + var_7[2] + " )";
      var_10 = distance(var_7, var_1);
      var_11 = var_10 * 0.002;
      var_12 = 1.0 * var_11;
      _id_2B50(var_7, 4.0, (0, 0, 0), (1, 1, 1), 1.0, 1);
      var_13 = -1.5 * var_12 * 12;
      _id_8AA6(var_7 + (0, 0, var_13), var_9, (1, 1, 1), 1.0, var_12, 1, var_4);

      if(isDefined(var_8) == 1) {
        var_14 = "" + var_8 + "";
        var_15 = 1.0 + _abs(var_3[2]);
        var_13 = -3.0 * var_15 * var_12 * 12;
        _id_8AA6(var_7 + (0, 0, var_13), var_14, _id_A2BB((1, 1, 1), 0.666), 0.666, var_12, 1, var_4);
      }
    }

    waitframe();
  }
}

_id_8D1F(var_0, var_1) {
  var_2 = int(var_1);

  foreach(var_4 in level.players) {
    if(var_2 > 0) {
      var_4 thread _id_071E();
      continue;
    }

    var_4 notify("stop_crosshair3D");
  }

  return var_1;
}

_id_8DC9(var_0, var_1) {
  common_scripts\_createfx::_id_0646();
  return "";
}

_id_8DCA(var_0, var_1) {
  level._createfx.selected_fx_ents = [];

  for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
    var_3 = level.createfxent[var_2];

    if(isDefined(var_3.v["type"]) == 0) {
      continue;
    }
    if(isDefined(var_3.v["origin"]) == 1 && common_scripts\utility::_id_9467(var_3.v["type"], "soundfx") == 1) {
      var_4 = var_3.v["origin"];
      var_5 = (270, 0, 0);
      var_4 = (_floor(var_4[0]), _floor(var_4[1]), _floor(var_4[2]));
      var_3.v["angles"] = var_5;
      var_3.v["origin"] = var_4;
      level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = var_3;
    }
  }

  common_scripts\_createfx::update_selected_ents();
  level._createfx.selected_fx_ents = [];
  return "";
}