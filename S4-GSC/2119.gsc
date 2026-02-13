/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2119.gsc
*************************************************/

_id_DEEC() {
  if(!isDefined(level._id_0D00)) {
    level._id_0D00 = spawnStruct();
    level._id_0D00._id_86B5 = 1;
    level._id_0D00._id_0B78 = [];
    level._id_0D00._id_0C77 = [];
    level._id_0D00._id_0D9F = [];
    level._id_0D00._id_0BB4 = "gentity";
    level._id_0D00._id_0BB3 = 0.0;
    level._id_0D00._id_0B78["player_view"] = ::_id_0D8E;
    level._id_0D00._id_0B78["player_angles"] = ::_id_0D8C;
    level._id_0D00._id_0B78["player_fov"] = ::_id_0D8D;
    level._id_0D00._id_88C6 = 1;
    _id_0D33();
    _id_0D30();
    level thread _id_0D31();
  }

  if(!isDefined(level._id_1E72)) {
    level._id_1E72 = spawnStruct();
  }

  _id_DECE();
}

_id_0D31() {
  level._id_0D00._id_85CF = 1;
  waittillframeend;
  level._id_0D00._id_85CF = 0;
}

_id_DEEE() {
  return level._id_0D00._id_85CF;
}

_id_0D30() {
  level._id_0D00.guid = 0;
}

_id_DED3() {
  if(isDefined(level._id_0D00) && isDefined(level._id_0D00._id_0BB4) && istrue(level._id_0D00._id_88C6)) {
    return 1;
  }

  return 0;
}

_id_DF3D() {
  while(_id_DED3() == 0) {
    waitframe();
  }
}

_id_0D33() {
  level._id_0D00._id_9DEA = [];
}

_id_DEF4() {
  level._id_0D00._id_9DEB = [];
}

_id_DEF5() {
  if(isDefined(level._id_0D00._id_9DEB)) {
    foreach(var_1 in level._id_0D00._id_9DEB) {
      if(var_1.size == 1) {
        _id_DEF2(var_1[0]);
        continue;
      }

      if(var_1.size == 2) {
        _id_DEF2(var_1[0], var_1[1]);
        continue;
      }

      if(var_1.size == 3) {
        _id_DEF2(var_1[0], var_1[1], var_1[2]);
        continue;
      }

      if(var_1.size == 4) {
        _id_DEF2(var_1[0], var_1[1], var_1[2], var_1[3]);
      }
    }

    level._id_0D00._id_9DEB = undefined;
  }
}

_id_DF17(var_0, var_1) {
  level._id_0D00._id_9DEA[var_0] = var_1;
}

_id_DEF2(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_0D00._id_9DEA[var_0])) {
    if(isDefined(var_3)) {
      thread[[level._id_0D00._id_9DEA[var_0]]](var_1, var_2, var_3);
    } else if(isDefined(var_2)) {
      thread[[level._id_0D00._id_9DEA[var_0]]](var_1, var_2);
    } else if(isDefined(var_1)) {
      thread[[level._id_0D00._id_9DEA[var_0]]](var_1);
    } else {
      thread[[level._id_0D00._id_9DEA[var_0]]]();
    }
  } else if(isDefined(level._id_0D00._id_9DEB)) {
    var_4 = [];
    var_4[0] = var_0;

    if(isDefined(var_3)) {
      var_4[3] = var_3;
    }

    if(isDefined(var_2)) {
      var_4[2] = var_2;
    }

    if(isDefined(var_1)) {
      var_4[1] = var_1;
    }

    level._id_0D00._id_9DEB[level._id_0D00._id_9DEB.size] = var_4;
  }
}

_id_DF08(var_0, var_1, var_2) {
  var_3 = level._id_0D00._id_0BB4;
  var_4 = _id_0D6B(var_3, var_0, var_1);
  return var_4;
}

_id_DF21(var_0, var_1, var_2) {
  foreach(var_4 in _id_0850::_id_1BF3(var_0)) {
    level thread _id_0D6D(var_4, var_1);
  }
}

_id_DF22(var_0, var_1, var_2) {
  if(_id_0850::_id_DECB(!isDefined(var_0), "snd_stop_alias with undefined soundalias")) {
    return 0;
  }

  var_0 = tolower(var_0);
  var_3 = _id_DEE1(var_1);
  var_4 = 0;

  foreach(var_6 in var_3) {
    if(!isDefined(var_6._id_E05E)) {
      continue;
    }
    if(issubstr(tolower(var_6._id_E05E), var_0)) {
      _id_DF21(var_6, var_2);
      var_4 = int(var_4 + 1);
    }
  }

  return var_4;
}

_id_DF24(var_0, var_1, var_2, var_3) {
  if(_id_0850::_id_DECB(!_id_DEEF(var_0), "snd_stop_on_ent_notify soundObject is not a snd object")) {
    return;
  }
  if(_id_0850::_id_DECB(!isent(var_1), "snd_stop_on_ent_notify notifyEntity is not an entity")) {
    return;
  }
  if(_id_0850::_id_DECB(!_func_0121(var_2), "snd_stop_on_ent_notify notifyString is not a string")) {
    return;
  }
  foreach(var_5 in _id_0850::_id_1BF3(var_0)) {
    var_1 thread _id_0D6E(var_5, var_1, var_2, var_3);
  }
}

_id_DF23(var_0, var_1, var_2) {
  if(_id_0850::_id_DECB(!_id_DEEF(var_0), "stop_on_ent_death soundObject is not a snd object")) {
    return;
  }
  if(_id_0850::_id_DECB(!isent(var_1), "stop_on_ent_death deathEntity is not an entity")) {
    return;
  }
  foreach(var_4 in _id_0850::_id_1BF3(var_0)) {
    var_1 thread _id_0D6E(var_4, var_1, "death", var_2);
  }
}

_id_DF25(var_0, var_1, var_2) {
  if(_id_0850::_id_DECB(!_id_DEEF(var_0), "stop_on_level_notify soundObject is not a snd object")) {
    return;
  }
  if(_id_0850::_id_DECB(!_func_0121(var_1), "snd_stop_on_level_notify: levelNotifyString is not a string")) {
    return;
  }
  foreach(var_4 in _id_0850::_id_1BF3(var_0)) {
    level thread _id_0D6F(var_4, var_1, var_2);
  }
}

_id_DF3C(var_0) {
  if(_id_0850::_id_DECB(!isDefined(var_0), "snd_wait with undefined soundObject")) {
    return 0;
  }

  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    var_3 = 0;
    var_4 = _id_0850::_id_1BF3(var_0);
    var_4 = scripts\engine\utility::_id_1BD1(var_4);

    foreach(var_6 in var_4) {
      if(_id_DEEF(var_6)) {
        var_3 = 1;
        break;
      }
    }

    if(var_3 == 0) {
      break;
    }

    waitframe();
  }

  var_8 = gettime();
  var_2 = var_8 - var_1;
  var_2 = var_2 / 1000.0;
  return var_2;
}

_id_DEEF(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_E06B)) {
    return 1;
  }

  return 0;
}

_id_DEE1(var_0) {
  var_1 = [];

  foreach(var_3 in _id_0850::_id_1BF3(var_0)) {
    if(!isDefined(var_3)) {
      var_1 = scripts\engine\utility::array_combine(var_1, level._id_0D00._id_0C77);
      continue;
    }

    if(_id_0850::_id_DECB(_func_02B7(var_3), "snd: get_sound_objects invalid target was a number")) {
      continue;
    } else {
      if(var_3 == level) {
        var_1 = scripts\engine\utility::array_combine(var_1, level._id_0D00._id_0D9F);
        continue;
      }

      if(isDefined(var_3._id_0D72)) {
        var_1 = scripts\engine\utility::array_combine(var_1, var_3._id_0D72);
      }
    }
  }

  return var_1;
}

_id_DEDF(var_0, var_1) {
  if(_id_0850::_id_DECB(!isDefined(var_0), "snd_get_alias_objects with undefined soundalias")) {
    return 0;
  }

  var_2 = [];

  if(_func_0107(var_0)) {
    foreach(var_4 in var_0) {
      var_2[var_2.size] = tolower(var_4);
    }
  } else if(_func_0121(var_0))
    var_2 = [tolower(var_0)];

  var_6 = _id_DEE1(var_1);
  var_7 = [];

  foreach(var_9 in var_6) {
    if(!isDefined(var_9._id_E05E)) {
      continue;
    }
    foreach(var_4 in var_2) {
      if(issubstr(tolower(var_9._id_E05E), var_4)) {
        var_7[var_7.size] = var_9;
      }
    }
  }

  return var_7;
}

_id_DEFC(var_0) {
  var_0 = scripts\engine\utility::_id_FF6C(var_0, 1);

  if(!isDefined(level._id_0D00._id_5DB2)) {
    level._id_0D00._id_5DB2 = level._id_5DB2;
    level._id_0D00._id_5DB4 = level._id_5DB4;
    level._id_0D00._id_5DAC = level._id_5DAC;
    level._id_0D00._id_5D5B = anim._id_2F52["PlaySoundAtViewHeight"];
  }

  if(var_0) {
    level._id_5DB2 = ::_id_0D49;
    level._id_5DB4 = ::_id_0D4B;
    level._id_5DAC = ::_id_0D34;
    anim._id_2F52["PlaySoundAtViewHeight"] = ::_id_0D47;
  } else {
    level._id_5DB2 = level._id_0D00._id_5DB2;
    level._id_5DB4 = level._id_0D00._id_5DB4;
    level._id_5DAC = level._id_0D00._id_5DAC;
    anim._id_2F52["PlaySoundAtViewHeight"] = level._id_0D00._id_5D5B;
  }
}

_id_DEE4(var_0) {
  if(isDefined(level._id_0D00._id_0B78["volume_get"])) {
    return [[level._id_0D00._id_0B78["volume_get"]]](var_0);
  }

  return 1.0;
}

_id_DF1B(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_0D00._id_0B78["volume_set"])) {
    [[level._id_0D00._id_0B78["volume_set"]]](var_0, var_1, var_2, var_3, var_4);
  }
}

_id_DEE0(var_0) {
  if(isDefined(level._id_0D00._id_0B78["pitch_get"])) {
    return [[level._id_0D00._id_0B78["pitch_get"]]](var_0);
  }

  return 1.0;
}

_id_DF1A(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_0D00._id_0B78["pitch_set"])) {
    [[level._id_0D00._id_0B78["pitch_set"]]](var_0, var_1, var_2, var_3, var_4);
  }
}

_id_DF36() {
  if(istrue(level._id_0D00._id_8573)) {
    return "centity";
  }

  return "gentity";
}

_id_DF37() {
  return level._id_0D00._id_0BB4;
}

_id_DF38(var_0) {
  var_0 = scripts\engine\utility::_id_FF6C(var_0, _id_DF36());
  level._id_0D00._id_0BB4 = _id_DF39(var_0);
}

_id_DEE3(var_0) {
  if(isDefined(var_0._id_E06B)) {
    return var_0._id_E06B;
  }

  return "";
}

_id_DF39(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 0:
    case "entity":
    case "ent":
    case "e":
      var_1 = "gentity";
      break;
    case 1:
    case "cent":
    case "c":
    case "centity":
      var_1 = "centity";
      break;
    case "emitter":
      var_1 = "emitter";
      break;
    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

_id_0D37(var_0, var_1, var_2) {
  switch (var_0) {
    default:
      break;
    case "gentity":
    case "centity":
      level._id_0D00._id_0C77[var_1] = var_2;
      break;
  }
}

_id_0D36(var_0, var_1, var_2) {
  switch (var_0) {
    default:
      break;
    case "gentity":
    case "centity":
      level._id_0D00._id_0C77[var_1] = undefined;
      break;
  }
}

_id_0D35() {
  var_0 = self._id_E06B;
  var_1 = self._id_E066;
  self waittill("death");
  _id_0D36(var_0, var_1, self);
}

_id_0D2A(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_3 = var_2 _id_0850::_id_6DB5(var_3);
    var_4 = (0, 0, 0);
    var_5 = (0, 0, 0);

    if(isDefined(var_1)) {
      var_4 = var_1;
    }

    var_0 linkto(var_2, var_3, var_4, var_5);

    if(!_func_0107(var_2._id_0D72)) {
      var_2._id_0D72 = [];
    }

    var_2._id_0D72[var_0._id_E066] = var_0;
  } else
    level._id_0D00._id_0D9F[var_0._id_E066] = var_0;
}

_id_0D28(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_2) && isDefined(var_3) && isDefined(var_1)) {
    var_5 = var_2 gettagorigin(var_3);
    var_5 = var_5 + var_1;
  } else if(isDefined(var_2) && isDefined(var_3))
    var_5 = var_2 gettagorigin(var_3);
  else if(isDefined(var_2)) {
    var_5 = var_2.origin;
  } else if(!isDefined(var_2) && !isDefined(var_1)) {
    var_6 = (0, 0, -32768);
    var_5 = var_6;
  } else
    var_5 = var_1;

  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = spawn("script_model", var_5);

    if(isent(var_4)) {
      var_4 setModel("tag_origin");
    }
  } else
    var_4 = spawn("script_origin", var_5);

  if(isent(var_4)) {
    var_4._id_E067 = var_2;
    var_4._id_E06B = "gentity";
    var_4._id_E066 = var_4 getentitynumber();
    var_4._id_0481 = "snd " + var_0;
  }

  return var_4;
}

_id_0D29(var_0) {
  if(_id_0850::_id_DECB(!isDefined(var_0) || _func_0458(var_0), "snd: free on deleted entity!")) {
    return;
  }
  if(isDefined(var_0._id_E067) && _func_0107(var_0._id_E067._id_0D72)) {
    var_1 = var_0._id_E067;
    var_2 = isDefined(var_1._id_0D72[var_0._id_E066]);

    if(var_2 == 1) {
      var_1._id_0D72[var_0._id_E066] = undefined;
    } else {}
  } else
    level._id_0D00._id_0D9F[var_0._id_E066] = undefined;

  waittillframeend;
  var_0 delete();
  return;
}

_id_0D2B(var_0, var_1, var_2, var_3) {
  var_4 = var_0;
  var_5 = undefined;
  var_4 endon("death");
  var_5 = _id_DEE4(var_4);

  if(!isDefined(var_2) && isDefined(var_5)) {
    var_2 = var_5;
  }

  if(_id_DED3() == 0) {
    var_6 = !isDefined(var_3) || _func_02B7(var_3) && var_3 == 0;

    if(_id_0850::_id_DECB(var_6, "snd: delayed due to first frame!")) {
      var_3 = 0.05;
    }
  }

  if(_func_02B7(var_3) && var_3 > 0) {
    wait(var_3);
  }

  if(_func_0207(var_1) == 1) {
    var_4 playLoopSound(var_1);
  } else {
    var_7 = "sounddone";

    if(scripts\common\utility::issp()) {
      var_4 playSound(var_1, var_7);
      var_8 = 0;

      if(var_8) {
        var_4 thread _id_0D2D(var_1, var_7);
      } else {
        var_4 thread _id_0D2E(var_7);
      }
    } else {
      if(isDefined(var_4._id_E067) && isDefined(level._id_0D00._id_5DB3)) {
        waitframe();
        var_4[[level._id_0D00._id_5DB3]](var_1);
      } else
        var_4 playSound(var_1);

      var_4 thread _id_0D2D(var_1, var_7);
    }
  }

  var_4._id_E05E = var_1;
}

_id_0D2C(var_0, var_1) {
  var_0 endon("death");
  var_2 = var_0;

  if(_id_0850::_id_DECB(!isDefined(var_2) || _func_0458(var_2), "snd: stop on deleted entity!")) {
    return;
  }
  var_3 = var_2._id_E05E;
  var_1 = scripts\engine\utility::_id_FF6C(var_1, 0.0);

  if(_func_0121(var_3)) {
    if(istrue(_func_0207(var_3))) {
      var_2 stoploopsound();
    } else {
      var_2 _meth_83F8();
    }

    waitframe();
    var_2._id_E05E = undefined;
  }

  var_2._id_E06B = undefined;
  _id_0D29(var_2);
  return;
}

_id_0D2D(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_3 = _func_0142(var_0);
  var_3 = var_3 * 1.25;
  var_3 = var_3 / 1000.0;
  var_4 = _id_0850::_id_6D3C(var_0, "pitch_min");

  if(isDefined(var_4)) {
    var_3 = var_3 * (1.0 / var_4);
  }

  wait(var_3);
  var_2 notify(var_1, var_2._id_E05E);
  _id_0D29(var_2);
}

_id_0D2E(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 waittill(var_0);
  var_1 notify(var_0, var_1._id_E05E);
  _id_0D29(var_1);
}

_id_0D03(var_0, var_1, var_2, var_3) {}

_id_0D01(var_0, var_1, var_2, var_3) {
  return undefined;
}

_id_0D02(var_0) {}

_id_0D04(var_0, var_1, var_2, var_3) {}

_id_0D05(var_0, var_1) {}

_id_0D8E() {
  var_0 = self;
  var_1 = var_0 getEye();
  return var_1;
}

_id_0D8C() {
  var_0 = self;
  var_1 = var_0 getplayerangles();
  return var_1;
}

_id_0D8D() {
  var_0 = self;
  var_1 = getdvarfloat("#x356e0c9e15809767a", 65);
  return var_1;
}

_id_0D69(var_0) {
  var_1 = 0.0;
  var_2 = undefined;
  var_3 = undefined;

  if(_func_0107(var_0)) {
    var_4 = var_0;
    var_2 = undefined;
    var_5 = var_4.size + 1;

    for(var_6 = 0; var_6 < var_4.size; var_6++) {
      var_7 = var_4[var_6];

      if(_func_0121(var_7)) {
        var_2 = var_7;
        var_5 = var_6;
      }

      if(_func_02B7(var_7) && var_6 < var_5) {
        var_1 = var_7;
      }

      if(_func_02B7(var_7) && var_6 > var_5) {
        var_3 = var_7;
      }
    }
  } else if(_func_0121(var_0))
    var_2 = var_0;

  var_8 = [var_1, var_2, var_3];
  return var_8;
}

_id_0D6A(var_0) {
  var_1 = [];

  if(!isDefined(var_0)) {
    foreach(var_3 in _id_0850::_id_6C63()) {
      var_4 = var_3 _id_0850::_id_6DB5("j_head");

      if(var_3.model != "" && var_4 != "") {
        var_1[var_1.size] = [var_3, var_4];
        continue;
      }

      var_1[var_1.size] = var_3;
    }
  } else if(_func_0107(var_0)) {
    if(_id_0850::_id_DECB(var_0.size == 0, "snd: zero-sized array used for targ")) {
      return undefined;
    } else if(var_0.size == 2) {
      if(isent(var_0[0]) && _func_0121(var_0[1])) {
        var_1 = [var_0];
      } else if(isent(var_0[0]) && isvector(var_0[1])) {
        var_1 = [var_0];
      } else if(isent(var_0[0]) && !isDefined(var_0[1])) {
        var_1 = [var_0[0]];
      } else if(_func_0121(var_0[0]) && _func_0121(var_0[1])) {
        var_6 = _id_0850::_id_6DC0(var_0[0]);
        var_7 = _id_0850::_id_6DC0(var_0[1]);
        var_1 = scripts\engine\utility::array_combine(var_6, var_7);
      } else
        var_1 = var_0;
    } else {
      var_1 = [];

      foreach(var_14, var_9 in var_0) {
        if(isent(var_9) || _func_02DE(var_9) && isDefined(var_9.origin) || isvector(var_9) || _func_0107(var_9)) {
          var_1[var_1.size] = var_9;
          continue;
        }

        if(_func_0121(var_9)) {
          var_10 = _id_0850::_id_6DC0(var_9);

          foreach(var_12 in var_10) {
            var_1[var_1.size] = var_12;
          }
        }
      }
    }
  } else if(_func_0121(var_0))
    var_1 = _id_0850::_id_6DC0(var_0);
  else {
    var_1 = [var_0];
  }

  return var_1;
}

_id_0D6B(var_0, var_1, var_2, var_3) {
  if(_id_0850::_id_DECB(!_id_DED3(), "snd was not initialized!")) {
    return undefined;
  }

  if(_id_0850::_id_DECB(!isDefined(var_1), "snd_play: sound alias undefined")) {
    return undefined;
  }

  level._id_0D00._id_0B78["stop"] = ::_id_DF21;
  var_0 = scripts\engine\utility::_id_FF6C(var_0, level._id_0D00._id_0BB4);
  var_4 = [];
  var_5 = [];
  var_6 = _id_0D69(var_1);
  var_7 = var_6[0];
  var_1 = var_6[1];
  var_8 = var_6[2];
  var_9 = undefined;

  if(_id_0850::_id_DECB(_func_0121(var_1) && var_1 == "", "snd_play: empty sound alias \"\"")) {
    return undefined;
  }

  var_10 = _func_0207(var_1);
  var_11 = _func_0205(var_1);

  if(_id_0850::_id_DECB(!var_11, "snd: sound alias '" + var_1 + "' does not exist!")) {
    return undefined;
  }

  if(!isDefined(var_8)) {
    if(var_10) {
      var_8 = level._id_0D00._id_0BB3;
    } else {
      var_8 = 0.0;
    }
  }

  if(isDefined(var_8) && var_8 > 0.0) {
    var_9 = 0.0;
  }

  var_5 = _id_0D6A(var_2);

  if(_id_0850::_id_DECB(!isDefined(var_5), "snd: undefined targets")) {
    return undefined;
  }

  foreach(var_13 in var_5) {
    var_14 = undefined;
    var_15 = undefined;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = isent(var_13);
    var_19 = _func_0458(var_13);
    var_20 = _func_02DE(var_13);
    var_21 = isvector(var_13);
    var_22 = _func_0121(var_13);
    var_23 = _func_0107(var_13);

    if(var_18) {
      var_14 = var_13;
      var_16 = (0, 0, 0);
    } else if(_id_0850::_id_DECB(var_19, "snd: could not play on removed entity"))
      continue;
    else if(var_20) {
      if(_id_0850::_id_DECB(!isDefined(var_13.origin), "snd: sound alias '" + var_1 + "' played on struct with no origin!")) {
        continue;
      } else {
        var_16 = var_13.origin;
      }
    } else if(var_21)
      var_16 = var_13;
    else if(var_22) {} else if(_func_0107(var_13)) {
      if(!isDefined(var_13[0]) || _func_0458(var_13[0])) {
        continue;
      } else if(isent(var_13[0]) && _func_0121(var_13[1])) {
        var_14 = var_13[0];
        var_15 = var_13[1];
        var_16 = (0, 0, 0);
      } else if(isent(var_13[0]) && isvector(var_13[1])) {
        var_14 = var_13[0];
        var_16 = var_13[1];
      } else if(_id_0850::_id_DECB(1, "snd: unexpected target array combination")) {}
    }

    switch (var_0) {
      default:
        break;
      case "gentity":
        var_17 = _id_0D28(var_1, var_16, var_14, var_15);

        if(isent(var_17)) {
          _id_0D2A(var_17, var_16, var_14, var_15);
          _id_0D37("gentity", var_17._id_E066, var_17);
          var_17 thread _id_0D35();
        }

        break;
      case "centity":
        var_17 = _id_0D01(var_1, var_16, var_14, var_15);

        if(isent(var_17)) {
          _id_0D03(var_17, var_16, var_14, var_15);
          _id_0D37("centity", var_17._id_E066, var_17);
          var_17 thread _id_0D35();
        }

        break;
    }

    if(isDefined(var_17) && _id_DEEF(var_17)) {
      switch (var_0) {
        case "gentity":
        default:
          var_17 thread _id_0D2B(var_17, var_1, var_9, var_7);
          break;
        case "centity":
          var_17 thread _id_0D04(var_17, var_1, var_9, var_7);
          break;
      }

      if(var_8 > 0.0) {
        if(var_0 == "gentity" && isDefined(var_14)) {
          var_7 = var_7 + 0.05;
        }

        var_17 thread _id_0D6C(var_17, var_8, var_7);
      }

      var_4[var_4.size] = var_17;
    }
  }

  if(_id_0850::_id_DECB(var_4.size == 0, "snd: zero sound objects played")) {
    return undefined;
  }

  return _id_0850::_id_1BF2(var_4);
}

_id_0D6D(var_0, var_1) {
  if(_id_0850::_id_DECB(!isDefined(level._id_0D00) || !isDefined(level._id_0D00._id_0BB4), "snd was not initialized")) {
    return;
  }
  if(_id_0850::_id_DECB(!isDefined(var_0) || _func_0458(var_0), "snd_stop with undefined soundObject")) {
    return;
  }
  if(_id_0850::_id_DECB(!isDefined(var_0._id_E06B), "snd_stop with unknown type")) {
    return;
  }
  if(var_0._id_E06B == "emitter") {
    var_0 notify("snd_emitter_stop");
    var_0._id_E06B = undefined;
    var_0._id_E05E = undefined;
    var_0._id_E067 = undefined;
    var_0.origin = undefined;
    var_0.angles = undefined;
    return;
  }

  var_0 endon("death");
  var_2 = var_0._id_E06B;
  var_3 = var_0._id_E05E;
  var_4 = scripts\engine\utility::ter_op(_func_0121(var_3), _func_0207(var_3), undefined);

  if(istrue(var_4) && !isDefined(var_1)) {
    var_1 = float(level._id_0D00._id_0BB3);
  } else if(_func_02B7(var_1)) {
    var_1 = float(var_1);
  }

  if(isDefined(var_3) && _func_0110(var_1)) {
    _id_DF1B(var_0, 0.0, var_1);
    wait(var_1);
    waitframe();

    if(_func_0458(var_0)) {
      return;
    }
  }

  switch (var_2) {
    case "gentity":
    default:
      _id_0D2C(var_0, var_1);
      break;
    case "centity":
      _id_0D05(var_0, var_1);
      break;
  }
}

_id_0D6E(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_1 scripts\engine\utility::waittill_any_3("death", "deleted", var_2);
  _id_0D6D(var_0, var_3);
}

_id_0D6F(var_0, var_1, var_2) {
  var_0 endon("death");
  level waittill(var_1);
  _id_0D6D(var_0, var_2);
}

_id_0D6C(var_0, var_1, var_2) {
  if(_id_0850::_id_DECB(!isDefined(var_0) || _func_0458(var_0), "snd: fade in on deleted gentity!")) {
    return;
  }
  var_0 endon("death");
  var_0 endon("stopfade");
  var_2 = scripts\engine\utility::_id_FF6C(var_2, 0.0);
  _id_DF1B(var_0, 0.0, 0.0);

  if(var_2 > 0.0) {
    wait(var_2);
  }

  _id_DF1B(var_0, 1.0, var_1);
}

_id_0D24(var_0) {
  var_1 = undefined;

  if(_id_0850::_id_899D(var_0)) {
    var_1 = var_0 _id_0850::_id_6C6F();
  } else if(!_func_0458(var_0) && isDefined(var_0.origin)) {
    var_1 = var_0.origin;
  } else if(isvector(var_0) == 1) {
    var_1 = var_0;
  } else {}

  return var_1;
}

_id_0D23(var_0) {
  var_1 = randomfloatrange(-180.0, 180.0);
  var_2 = 0;

  if(_func_0107(var_0)) {
    if(var_0.size == 1) {
      var_0 = var_0[0];
    } else if(var_0.size == 2) {
      var_2 = _id_0850::_id_C01F(var_0);
    } else if(var_0.size == 3) {
      var_1 = var_0[0];
      var_2 = _id_0850::_id_C01F(var_0);
      var_3 = [var_0[1], var_0[2]];
      var_2 = _id_0850::_id_C01F(var_3);
    } else if(var_0.size >= 4) {
      var_4 = [var_0[0], var_0[1]];
      var_1 = _id_0850::_id_C01F(var_4);
      var_3 = [var_0[2], var_0[3]];
      var_2 = _id_0850::_id_C01F(var_3);
    }
  }

  if(_func_02B7(var_0) && var_0 != 0) {
    var_5 = abs(var_0);
    var_6 = -1.0 * var_5;
    var_7 = var_5;
    var_2 = randomfloatrange(var_6, var_7);
  }

  return [var_1, var_2];
}

_id_0D25(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("sounddone");

  if(isDefined(var_4) == 0 || var_4 == 0) {
    return;
  }
  var_9 = _id_0850::_id_6D19() * 3.0;
  var_10 = var_4 * var_9;
  var_11 = _id_0D24(var_0);

  while(isent(self) && isDefined(var_0) && isDefined(var_0.origin)) {
    var_11 = _id_0D24(var_0);
    var_12 = _id_0850::_id_AC5D(var_11, var_1, var_2, var_3);
    self moveto(var_12, var_9, 0.0, 0.0);
    var_2 = var_2 + var_10;
    wait(var_9);
  }
}

_id_0D26(var_0) {
  var_1 = _func_02DE(var_0);
  var_2 = isDefined(var_0._id_E06B);
  var_3 = var_0._id_E06B == "emitter";
  var_4 = var_1 && var_2 && var_3;

  if(_id_0850::_id_DECB(var_4 == 0, "snd emitter stop not an emitter")) {
    return;
  }
  level._id_0D00._id_0BD1[var_0._id_E066] = undefined;
  var_0 notify("snd_emitter_stop");
  var_0._id_E06B = undefined;
  var_0._id_E05E = undefined;
  var_0._id_E067 = undefined;
  var_0.origin = undefined;
  var_0.angles = undefined;
  var_0 = undefined;
}

_id_0D22(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("snd_emitter_stop");
  level endon("snd_emitter_stop");

  if(isvector(var_1)) {
    var_1 = self;
  }

  var_6 = undefined;
  var_7 = undefined;
  var_8 = _id_0850::_id_C01F(scripts\engine\utility::_id_FF6C(var_3, 0));
  var_9 = _id_0D23(var_4);
  var_10 = var_9[0];
  var_11 = var_9[1];
  var_12 = _id_0850::_id_C01F(scripts\engine\utility::_id_FF6C(var_5, 0));

  if(_func_0107(var_2) && var_2.size >= 4) {
    var_13 = [var_2[0], var_2[1]];
    var_14 = _id_0850::_id_C01F(var_13, 0.05);
    wait(var_14);
    var_6 = _id_0D24(var_1);
    var_7 = _id_0850::_id_AC5D(var_6, var_8, var_10, var_12);
    var_15 = _id_DF08(var_0, var_7);

    if(isDefined(var_15) && isDefined(var_8) && var_8 > 0 && isDefined(var_11) && var_11 != 0) {
      var_15 thread _id_0D25(var_1, var_8, var_10, var_11);
      var_2 = [var_2[2], var_2[3]];
    }
  }

  for(;;) {
    var_14 = _id_0850::_id_C01F(var_2, 0.05);
    wait(var_14);

    if(!isDefined(var_1)) {
      break;
    }

    var_8 = _id_0850::_id_C01F(scripts\engine\utility::_id_FF6C(var_3, 0));
    var_9 = _id_0D23(var_4);
    var_10 = var_9[0];
    var_11 = var_9[1];
    var_12 = _id_0850::_id_C01F(scripts\engine\utility::_id_FF6C(var_5, 0));
    var_6 = _id_0D24(var_1);
    var_7 = _id_0850::_id_AC5D(var_6, var_8, var_10, var_12);
    var_15 = _id_DF08(var_0, var_7);

    if(isDefined(var_15) && isDefined(var_8) && var_8 > 0 && isDefined(var_11) && var_11 != 0) {
      var_15 thread _id_0D25(var_1, var_8, var_10, var_12, var_11);
    }
  }
}

_id_DEDD(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_7 = var_1;
  var_8 = _func_0207(var_0);
  var_9 = isDefined(var_8);

  if(_id_0850::_id_DECB(!var_9, "snd_emitter soundalias does not exist: " + var_0)) {
    return undefined;
  }

  if(_id_0850::_id_DECB(var_8, "snd_emitter cannot emit looping alias: " + var_0)) {
    return undefined;
  }

  if(!isDefined(level._id_0D00._id_0BD0)) {
    level._id_0D00._id_0BD0 = 2432;
    level._id_0D00._id_0BD1 = [];
  }

  if(_func_0107(var_7) == 0) {
    var_7 = [var_1];
  }

  foreach(var_11 in var_7) {
    var_12 = isent(var_11);
    var_13 = isvector(var_11);

    if(var_12 || var_13) {
      var_14 = spawnStruct();
      var_14._id_E06B = "emitter";
      var_14._id_E05E = var_0;
      var_14._id_E393 = var_2;
      var_14._id_4B95 = var_3;
      var_14._id_037D = var_4;
      var_14._id_5123 = var_5;
      level._id_0D00._id_0BD0 = int(level._id_0D00._id_0BD0 + 1);
      var_14._id_E066 = "" + level._id_0D00._id_0BD0;
      level._id_0D00._id_0BD1[var_14._id_E066] = var_14;

      if(var_12) {
        var_14._id_E067 = var_11;
      }

      if(var_13) {
        var_14.origin = var_11;
        var_14.angles = (0, 0, 0);
      }

      var_14 thread _id_0D22(var_0, var_11, var_2, var_3, var_4, var_5);
      var_6[var_6.size] = var_14;
      continue;
    }

    _id_0850::_id_DECB(var_12 == 0 && var_13 == 0, "snd_emitter target '" + var_11 + "' was not an entity or vector.");
  }

  _id_0850::_id_DECB(var_6.size == 0, "snd_emitter resulted in zero emitter targets");
  return _id_0850::_id_1BF2(var_6);
}

_id_0D4B(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\engine\utility::_id_8599()) {
    return;
  }
  var_5 = [self, var_1];
  var_6 = _id_0D6B(level._id_0D00._id_0BB4, var_0, var_5);

  if(isDefined(var_2)) {
    _id_DF23(var_6, self);
  }

  _id_DF3C(var_6);

  if(isDefined(var_3)) {
    self notify(var_3);
  }
}

_id_0D49(var_0, var_1) {
  _id_0D4B(var_0, undefined, undefined, var_1);
}

_id_0D47(var_0, var_1, var_2) {
  var_2 = scripts\engine\utility::_id_FF6C(var_2, 0);

  if(scripts\engine\utility::_id_8599()) {
    return;
  }
  var_3 = [self, "j_head"];
  var_4 = _id_0D6B(level._id_0D00._id_0BB4, var_0, var_3);

  if(var_2) {
    _id_DF23(var_4, self);
  }

  if(isDefined(var_1)) {
    thread _id_0D48(var_4, var_1);
  }
}

_id_0D48(var_0, var_1) {
  _id_DF3C(var_0);
  self notify(var_1);
}

_id_0D34(var_0) {
  var_1 = _func_00D6(var_0, 0, 3);

  if(var_1 == "ps_") {
    var_2 = _func_00D6(var_0, 3);
    var_3 = strtok(var_2, ",");

    if(var_3.size < 2) {
      thread _id_0D4B(var_2, undefined, 1);
    } else {
      thread _id_0D4B(var_3[0], var_3[1], 1);
    }

    return 1;
  }

  if(var_1 == "vo_") {
    var_2 = _func_00D6(var_0, 3);

    if(isDefined(self._id_17FE)) {
      self thread[[self._id_17FE]](var_2, "j_head", 1);
    } else {
      thread _id_0D4B(var_2, "j_head", 1, var_2);
    }

    return 1;
  }

  if(isDefined(level._id_0D00._id_5DAC)) {
    return self[[level._id_0D00._id_5DAC]](var_0);
  }

  return 0;
}

_id_80B1(var_0, var_1) {
  var_2 = [];
  var_3 = 1.0 / (var_1 - 1);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_4 * var_3;
    var_6 = 0;

    switch (var_0) {
      default:
        break;
      case "linear":
      case "default_vfcurve":
        var_2[0] = 0.0;
        var_2[1] = 1.0;
        return var_2;
      case "sine":
        var_6 = 0.5 + cos(var_5 * 180) * -0.5;
      case "easein":
        var_6 = 1.0 - cos(var_5 * 90);
        break;
      case "easeout":
        var_6 = sin(var_5 * 90);
        break;
      case "easeinout":
        var_6 = 3 * _func_01A6(var_5, 2) - 2 * _func_01A6(var_5, 3);
        break;
      case "circularin":
        var_6 = 1.0 - _func_0218(1.0 - var_5 * var_5);
        break;
      case "circularout":
        var_6 = _func_0218(1.0 - (1.0 - var_5) * (1.0 - var_5));
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
    }

    var_2[var_2.size] = var_6;
  }

  return var_2;
}

_id_DECE(var_0) {
  var_0 = scripts\engine\utility::_id_FF6C(var_0, 11);
  level._id_0B4E = [];
  level._id_0B4E["linear"] = _id_80B1("linear", var_0);
  level._id_0B4E["sine"] = _id_80B1("sine", var_0);
  level._id_0B4E["easein"] = _id_80B1("easein", var_0);
  level._id_0B4E["easeout"] = _id_80B1("easeout", var_0);
  level._id_0B4E["easeinout"] = _id_80B1("easeinout", var_0);
  level._id_0B4E["circularin"] = _id_80B1("circularin", var_0);
  level._id_0B4E["circularout"] = _id_80B1("circularout", var_0);
  level._id_0B4E["exponential_40db"] = _id_80B1("exponential_40db", var_0);
  level._id_0B4E["exponential_60db"] = _id_80B1("exponential_60db", var_0);
  level._id_0B4E["default_vfcurve"] = _id_80B1("default_vfcurve", var_0);
}

_id_0D07(var_0) {
  if(isDefined(var_0) == 0) {
    return "easeout";
  }

  switch (var_0) {
    case "xfade":
      return "easeout";
  }

  return var_0;
}

_id_DECF(var_0) {
  var_1 = level._id_0B4E[_id_0D07(var_0)];

  if(isDefined(var_1)) {
    return var_1.size;
  }

  return 0;
}

_id_DECD(var_0) {
  var_1 = level._id_0B4E[var_0];

  if(isDefined(var_1)) {
    return 1;
  }

  return 0;
}

_id_DED0(var_0, var_1) {
  var_1 = _id_0D07(var_1);
  var_2 = level._id_0B4E[var_1];
  var_0 = clamp(var_0, 0.0, 1.0);
  var_3 = 0.0;
  var_4 = 1.0 / (var_2.size - 1);

  if(var_0 == 0.0) {
    return 0.0;
  }

  if(var_0 == 1.0) {
    return 1.0;
  }

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

_id_0D3B(var_0) {
  if(isDefined(self._id_0B57) == 0) {
    return;
  }
  if(isDefined(var_0)) {
    if(isDefined(self._id_0B57[var_0])) {
      if(isDefined(self._id_0B57[var_0]._id_E8FF)) {
        self[[self._id_0B57[var_0]._id_E8FF]](self._id_0B57[var_0]._id_FEB4);
      }

      self._id_0B57[var_0] = undefined;
    }
  } else {
    foreach(var_2 in self._id_0B57) {
      if(isDefined(var_2._id_E8FF)) {
        self[[var_2._id_E8FF]](var_2._id_FEB4);
      }

      self._id_0B57 = undefined;
    }
  }

  if(isDefined(self._id_0B57) == 0 || self._id_0B57.size == 0) {
    level._id_0B56 = scripts\engine\utility::array_remove(level._id_0B56, self);
    level._id_0B56 = scripts\engine\utility::_id_1BD1(level._id_0B56);
    self._id_0B57 = undefined;
    self._id_0B58 = undefined;
    self notify("param_stop");
  }
}

_id_0D3F() {
  self endon("param_stop");
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  _id_0D3B();
}

_id_0D3E() {
  if(isDefined(self._id_0B58)) {
    return;
  }
  self._id_0B58 = 1;
  thread _id_0D3F();
  self endon("disconnect");
  self endon("param_stop");

  while(_func_0458(self) == 0 && isDefined(self._id_0B57) && self._id_0B57.size > 0) {
    var_0 = gettime();

    foreach(var_2 in self._id_0B57) {
      var_2._id_89C9 = 1;

      if(isDefined(var_2._id_82DD)) {
        var_2._id_82DF = self[[var_2._id_82DD]](var_2._id_FEB4);
      }

      if(isDefined(var_2._id_AD14)) {
        if(var_2._id_FEB4.size > 0) {}

        foreach(var_6, var_4 in var_2._id_AD14) {
          if(isent(self)) {
            var_5 = undefined;

            if(var_2._id_FEB4.size > 0) {
              var_5 = var_2._id_FEB4[var_6];
            }

            self thread[[var_4]](var_2._id_82DF, var_5);
          }
        }
      }

      var_2._id_89C9 = undefined;
    }

    waitframe();
  }

  if(_func_0458(self)) {
    _id_0D3B();
  }
}

_id_0D3C(var_0) {
  if(isDefined(level._id_0B56) == 0) {
    level._id_0B56 = [];
  }

  if(isDefined(self._id_0B57) == 0) {
    self._id_0B57 = [];
  }

  if(isDefined(self._id_0B57[var_0]) == 0) {
    self._id_0B57[var_0] = spawnStruct();
  }

  if(scripts\engine\utility::array_contains(level._id_0B56, self) == 0) {
    level._id_0B56[level._id_0B56.size] = self;
  }
}

_id_DF01(var_0, var_1) {
  _id_0D3C(var_0);
  self._id_0B57[var_0]._id_82DD = var_1;
  self._id_0B57[var_0]._id_82DF = undefined;
  thread _id_0D3E();
}

_id_DF06(var_0, var_1, var_2) {
  _id_0D3C(var_0);

  if(isDefined(self._id_0B57[var_0]._id_AD14) == 0) {
    self._id_0B57[var_0]._id_AD14 = [];
  }

  var_3 = self._id_0B57[var_0]._id_AD14.size;
  self._id_0B57[var_0]._id_AD14[var_3] = var_1;

  if(isDefined(self._id_0B57[var_0]._id_FEB4) == 0) {
    self._id_0B57[var_0]._id_FEB4 = [];
  }

  if(scripts\engine\utility::array_contains(self._id_0B57[var_0]._id_FEB4, var_2) == 0) {
    var_4 = self._id_0B57[var_0]._id_FEB4.size;
    self._id_0B57[var_0]._id_FEB4[var_4] = var_2;
  } else {}

  thread _id_0D3E();
}

_id_0D43(var_0, var_1, var_2) {
  _id_0D3C(var_0);
  self._id_0B57[var_0]._id_E68A = var_1;
  self._id_0B57[var_0]._id_E8FF = var_2;

  if(isDefined(self._id_0B57[var_0]._id_E68A)) {
    self[[self._id_0B57[var_0]._id_E68A]]();
  }
}

_id_DF07(var_0) {
  _id_0D3B(var_0);
}

_id_DEFD(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0D43(var_0, var_1, var_4);
  _id_DF01(var_0, var_2);
  _id_DF06(var_0, var_3, var_5);
}

_id_DEFF(var_0) {
  if(isDefined(self._id_0B57) && isDefined(self._id_0B57[var_0]) && isDefined(self._id_0B57[var_0]._id_82DD)) {
    var_1 = self._id_0B57[var_0];

    if(isDefined(var_1._id_82DF)) {
      return var_1._id_82DF;
    } else {
      return self[[var_1._id_82DD]](var_1._id_FEB4);
    }
  }

  return undefined;
}

_id_DEFE(var_0) {
  if(isDefined(self._id_0B57) && _func_0107(self._id_0B57) && isDefined(self._id_0B57[var_0])) {
    return 1;
  }

  return 0;
}

_id_DF00(var_0) {
  if(isDefined(self._id_0B57) && _func_0107(self._id_0B57)) {
    foreach(var_2 in self._id_0B57) {
      if(var_2._id_82DD == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_DF05(var_0) {
  var_1 = gettime();

  if(isDefined(self._id_AC81) && self._id_AC81 == var_1) {
    return self._id_AC80;
  }

  if(isDefined(self._id_AC7C) == 0) {
    self._id_AC7C = self.origin;
  }

  var_2 = self.origin - self._id_AC7C;
  self._id_AC80 = var_2;
  self._id_AC81 = var_1;
  self._id_AC7C = self.origin;
  return self._id_AC80;
}

_id_DF04(var_0) {
  var_1 = _id_DF05();
  var_2 = length(var_1);
  self._id_AC7F = _id_0850::_id_DE60(var_2, self._id_AC7F, 0.05);
  return self._id_AC7F;
}

_id_DF03(var_0) {
  var_1 = gettime();

  if(isDefined(self._id_1789) && self._id_1789 == var_1) {
    return self._id_0B49;
  }

  var_2 = self.angles;

  if(_id_0850::_id_899D(self)) {
    var_2 = _id_0850::_id_6C6D();
  } else if(isDefined(self.model)) {
    var_3 = 0;

    if(var_3 == 0) {
      var_2 = self gettagangles("tag_origin");
    }
  }

  if(var_2[0] > 180.0) {
    var_2 = var_2 - (360, 0, 0);
  }

  if(var_2[1] > 180.0) {
    var_2 = var_2 - (0, 360, 0);
  }

  if(var_2[2] > 180.0) {
    var_2 = var_2 - (0, 0, 360);
  }

  if(isDefined(self._id_0B49) == 0) {
    self._id_0B49 = var_2;
  }

  if(isDefined(self._id_0B45) == 0) {
    self._id_0B45 = var_2;
  }

  self._id_0B45 = self._id_0B49;
  self._id_0B49 = var_2;
  return self._id_0B49;
}

_id_DF02(var_0) {
  var_1 = _id_DF03(var_0);
  self._id_0B4A = var_1 - self._id_0B45;
  return self._id_0B4A;
}

_id_0D5B(var_0, var_1, var_2) {
  var_0._id_DEC8 = _id_DF08(var_0._id_E05E, var_0.target);
  _id_DF1B(var_0._id_DEC8, var_1, 0.0);
  _id_DF1A(var_0._id_DEC8, var_2, 0.0);
}

_id_0D5C(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_0._id_DEC8)) {
    var_1 = scripts\engine\utility::_id_FF6C(var_1, 0.0);
    var_2 = scripts\engine\utility::_id_FF6C(var_2, "easeinout");

    if(isDefined(var_1) == 1 && var_1 > 0.0) {
      _id_DF1B(var_0._id_DEC8, 0.0, var_1, var_2);
      wait(var_1);
    }

    _id_DF21(var_0._id_DEC8);
    var_0._id_DEC8 = undefined;
  }
}

_id_0D42(var_0, var_1) {
  var_2 = 0.01;
  var_3 = 0.001;
  var_4 = var_0;
  var_5 = var_1;

  if(var_4 < var_2) {
    var_4 = 0.0;
  }

  var_6 = var_5._id_106A4["speed"][0];
  var_7 = var_5._id_106A4["speed"][1];
  var_8 = var_5._id_106A4["scale"][0];
  var_9 = var_5._id_106A4["scale"][1];
  var_10 = var_5._id_106A4["curve"][0];
  var_11 = var_5._id_B13D["speed"][0];
  var_12 = var_5._id_B13D["speed"][1];
  var_13 = var_5._id_B13D["scale"][0];
  var_14 = var_5._id_B13D["scale"][1];
  var_15 = var_5._id_B13D["curve"][0];
  var_16 = _id_0850::_id_CB86(var_4, var_6, var_7, var_8, var_9);
  var_17 = _id_0850::_id_CB86(var_4, var_11, var_12, var_13, var_14);

  if(isDefined(self._id_0B54) && isDefined(self._id_0B54._id_04CB)) {
    var_17 = var_17 * self._id_0B54._id_04CB;
  }

  if(isDefined(var_5._id_DEC8) == 1 && var_16 <= var_3) {
    thread _id_0D5C(var_5);
    return;
  } else if(isDefined(var_5._id_DEC8) == 0 && var_16 > var_3) {
    _id_0D5B(var_5, var_16, var_17);
    var_5._id_0D82 = var_4;
    return;
  }

  if(isDefined(var_5._id_DEC8) && isDefined(var_5._id_0D82)) {
    var_18 = abs(var_4 - var_5._id_0D82);

    if(var_18 > var_2) {
      _id_DF1B(var_5._id_DEC8, var_16, 0.05, var_10);
      _id_DF1A(var_5._id_DEC8, var_17, 0.05, var_15);
      var_5._id_0D82 = var_4;
    }
  }
}

_id_0D46(var_0) {
  var_1 = self._id_0D77;
  var_2 = self._id_0D78;

  if(isDefined(var_0) == 1) {
    foreach(var_4 in var_0) {
      thread _id_0D5C(var_4, var_1, var_2);
    }
  }

  self._id_0D79 = undefined;
  self._id_0D77 = undefined;
  self._id_0D78 = undefined;
  self._id_0D76 = undefined;
}

_id_0D5A(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = _func_0207(var_1);

  if(!_func_0107(var_0)) {
    var_4 = var_0;
  } else if(var_0.size > 0) {
    var_4 = var_0[0];
  }

  if(_id_0850::_id_DECB(!isent(var_4), "snd_speed: target entity not found!")) {
    return;
  }
  if(_id_0850::_id_DECB(!isDefined(var_5), "snd_speed: alias " + _id_0850::_id_EA5C(var_1, "'") + " does not exist!")) {
    return;
  }
  if(_id_0850::_id_DECB(!istrue(var_5), "snd_speed: alias " + _id_0850::_id_EA5C(var_1, "'") + " is not looping!")) {
    return;
  }
  if(_id_0850::_id_DECB(!_func_0107(var_2), "snd_speed: pitchDict is not an array!")) {
    return;
  }
  if(_id_0850::_id_DECB(!_func_0107(var_3), "snd_speed: volumeDict is not an array!")) {
    return;
  }
  var_6 = spawnStruct();
  var_6._id_E05E = var_1;
  var_6.target = var_0;
  var_6._id_B13D = var_2;
  var_6._id_106A4 = var_3;
  var_6._id_B13D["curve"] = ::scripts\engine\utility::_id_FF6C(var_6._id_B13D["curve"], ["linear"]);
  var_6._id_106A4["curve"] = ::scripts\engine\utility::_id_FF6C(var_6._id_106A4["curve"], ["xfade"]);
  var_4._id_0D76 = scripts\engine\utility::_id_FF6C(var_4._id_0D76, []);
  var_4._id_0D76[var_4._id_0D76.size] = var_6;
  var_4._id_AC7F = 0.0;
  var_4 _id_DEFD("speed", undefined, ::_id_DF04, ::_id_0D42, ::_id_0D46, var_6);
}

_id_DF1F(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::_id_FF6C(var_1, 0.05);
  var_2 = scripts\engine\utility::_id_FF6C(var_2, "easeinout");
  var_3 = undefined;

  if(!_func_0107(var_0)) {
    var_3 = var_0;
  } else if(var_0.size > 0) {
    var_3 = var_0[0];
  }

  if(_id_0850::_id_DECB(!isent(var_3), "snd_speed: target entity not found!")) {
    return;
  }
  var_3._id_0D79 = 1;
  var_3._id_0D77 = var_1;
  var_3._id_0D78 = var_2;
  var_3 _id_DF07("speed");
}

_id_DF1E(var_0, var_1, var_2, var_3) {
  level thread _id_0D5A(var_0, var_1, var_2, var_3);
}

_id_DED5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_2 = scripts\engine\utility::_id_FF6C(var_2, 1.0);
  var_5 = scripts\engine\utility::_id_FF6C(var_5, 1.0);
  var_6 = scripts\engine\utility::_id_FF6C(var_6, 343.3);

  if(var_2 == 0.0 && var_5 == 0.0 || var_6 == 0.0) {
    return [0.0, 0.0, 0.0];
  }

  var_7 = _id_0850::_id_9DF1(var_6);
  var_8 = var_0 - var_3;
  var_9 = length(var_8);
  var_10 = 0.0;
  var_11 = 0.0;

  if(var_2 > 0 && var_1 != (0, 0, 0)) {
    var_10 = vectordot(var_1, var_8) / var_9;
    var_10 = var_10 * var_2;
  }

  if(var_5 > 0 && var_4 != (0, 0, 0)) {
    var_11 = vectordot(var_4, var_8) / var_9;
    var_11 = var_11 * var_5;
  }

  var_12 = (var_7 - var_10) / (var_7 - var_11);
  return [var_12, var_10, var_11];
}

_id_0D1A() {}

_id_0D45(var_0) {
  var_1 = _func_0457(level._id_0B56);
  var_2 = 0;
  var_3 = [];
  var_1 = scripts\engine\utility::array_remove(var_1, self);

  foreach(var_5 in var_1) {
    if(var_5 _id_DEFE("doppler")) {
      var_2 = var_2 + 1;

      if(_id_0850::_id_899D(var_5)) {
        var_3[var_3.size] = var_5;
      }
    }
  }

  if(var_2 == var_3.size) {
    foreach(var_8 in var_3) {
      var_8 _id_DF07("doppler");
    }
  }
}

_id_0D41(var_0, var_1) {
  var_2 = var_1;

  if(!_id_0850::_id_899D(var_2)) {
    return;
  }
  var_3 = self.origin;
  var_4 = var_0;
  var_5 = self._id_0B54._id_CB76;
  var_6 = var_2 _id_0850::_id_6C6F();
  var_7 = var_2 _id_DEFF("doppler");
  var_8 = self._id_0B54._id_B78F;

  if(isDefined(var_7) == 0 || self._id_0B54._id_B78F == 0.0) {
    var_7 = (0, 0, 0);
  }

  var_9 = _id_DED5(var_3, var_4, var_5, var_6, var_7, var_8);
  var_10 = var_9[0];

  if(isDefined(self._id_0B54._id_B141)) {
    var_10 = var_10 * self._id_0B54._id_B141;
  }

  var_10 = clamp(var_10, 0.01, 2.0);
  self._id_0B54._id_04CB = var_10;

  if(_id_DEEF(self)) {
    _id_DF1A(self, var_10, _id_0850::_id_6D19());
  }
}

_id_0D19(var_0, var_1, var_2, var_3) {
  var_1 = scripts\engine\utility::_id_FF6C(var_1, 1.0);
  var_2 = scripts\engine\utility::_id_FF6C(var_2, 1.0);
  var_3 = scripts\engine\utility::_id_FF6C(var_3, 1.0);

  if(isDefined(var_0._id_0B54) == 0) {
    var_0._id_0B54 = spawnStruct();
  }

  if(var_3 > 0.0) {
    var_0 _id_DEFD("doppler", undefined, ::_id_DF05);
  }

  if(_func_0458(self)) {
    return;
  }
  self._id_0B54 = spawnStruct();
  self._id_0B54._id_CB76 = var_1;
  self._id_0B54._id_B141 = var_2;
  self._id_0B54._id_B78F = var_3;
  _id_DEFD("doppler", undefined, ::_id_DF05, ::_id_0D41, ::_id_0D45, var_0);
}

_id_DED4(var_0, var_1, var_2, var_3, var_4) {
  if(_id_0850::_id_DECB(isDefined(var_0) == 0, "snd_doppler with undefined soundObject")) {
    return;
  }
  foreach(var_6 in _id_0850::_id_1BF3(var_0)) {
    var_6 thread _id_0D19(var_1, var_2, var_3, var_4);
  }
}

_id_DED6(var_0) {
  if(_id_0850::_id_DECB(isDefined(var_0) == 0, "snd_doppler_stop with undefined soundObject")) {
    return;
  }
  foreach(var_2 in _id_0850::_id_1BF3(var_0)) {
    var_2 _id_0D45();
  }
}

_id_0D5E() {
  level notify("snd_stop_start_changed_notify");
  level endon("snd_stop_start_changed_notify");
  var_0 = _id_0850::_id_6D87();

  for(;;) {
    var_1 = _id_0850::_id_6D87();

    if(var_0 != var_1) {
      var_0 = var_1;
      level notify("start_point_changed", var_1);
    }

    waitframe();
  }
}

_id_0D5D(var_0, var_1) {
  level notify("snd_stop_start");
  level endon("snd_stop_start");
  var_1 = scripts\engine\utility::_id_FF6C(var_1, 1);
  _id_0850::_id_1081D();

  for(;;) {
    var_2 = _id_0850::_id_6D87();

    if(_func_0121(var_2) && var_2 != "") {
      break;
    }

    waitframe();
  }

  waitframe();
  level thread _id_0D5E();
  var_3 = [];

  for(;;) {
    var_2 = _id_0850::_id_6D87();

    if(!_func_0121(var_2) || var_2 == "") {} else if(var_1 || !var_1 && !isDefined(var_3[var_2])) {
      level thread[[var_0]](var_2);
      var_3[var_2] = 1;
    }

    level scripts\engine\utility::waittill_any_2("start_point_changed", "save_restore");
    waittillframeend;
  }
}

_id_DF20(var_0, var_1) {
  level thread _id_0D5D(var_0, var_1);
}

_id_0D65(var_0, var_1) {
  var_2 = 0;

  if(_id_0850::_id_899D(var_1)) {
    if(isent(var_0)) {
      var_2 = var_1 istouching(var_0);
    } else if(var_0 == level) {
      if(!isDefined(var_1._id_0D64) || isDefined(var_1._id_0D64) && var_1._id_0D64 == level) {
        var_2 = 1;
      }
    }
  }

  return var_2;
}

_id_0D66() {
  _id_0850::_id_1081D();
  waitframe();
  waittillframeend;

  foreach(var_1 in _id_0850::_id_6C63()) {
    level notify("trigger", var_1);
  }
}

_id_0D67(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = [level];
  var_2 = self;

  for(;;) {
    var_3 = undefined;
    var_2 waittill("trigger", var_3);
    var_4 = _id_0D65(var_2, var_3);

    if(var_4) {
      var_3._id_0D68 = scripts\engine\utility::_id_FF6C(var_3._id_0D68, var_1);

      if(var_2 != level) {
        var_3._id_0D68[var_3._id_0D68.size] = var_2;
      }

      var_5 = isDefined(var_3._id_0D64._id_CC94) && isDefined(var_2._id_CC94);
      var_6 = var_5 && int(var_3._id_0D64._id_CC94) <= int(var_2._id_CC94);

      if(!isDefined(var_3._id_0D64) || var_5 && var_6 || !var_5) {
        var_3._id_0D64 = var_2;
        var_2 thread[[var_0]](var_3, var_2, 1);
      }

      while(var_4) {
        var_4 = _id_0D65(var_2, var_3);
        waitframe();
      }

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_2 != level) {
        var_3._id_0D68 = scripts\engine\utility::array_remove(var_3._id_0D68, var_2);
      }

      if(var_3._id_0D64 == var_2) {
        var_7 = undefined;

        if(var_5) {
          var_7 = level;
          var_8 = -1;

          for(var_9 = var_3._id_0D68.size - 1; var_9 > 0; var_9--) {
            var_10 = var_3._id_0D68[var_9];

            if(isDefined(var_10._id_CC94)) {
              var_11 = int(var_10._id_CC94);

              if(var_11 > var_8) {
                var_7 = var_10;
                var_8 = var_11;
              }
            }
          }
        } else {
          var_12 = var_3._id_0D68.size - 1;
          var_7 = var_3._id_0D68[var_12];
        }

        if(isDefined(var_7)) {
          var_3._id_0D64 = var_7;
          var_7 thread[[var_0]](var_3, var_7, 0);
        } else {
          var_3._id_0D64 = undefined;
          level notify("trigger", var_3);
        }
      }
    }
  }
}

_id_DF35(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::_id_FF6C(var_1, "ambient_package");
  var_2 = scripts\engine\utility::_id_FF6C(var_2, "targetname");
  var_3 = [level];
  var_4 = undefined;

  if(istrue(level._id_0D00._id_86B5)) {
    var_4 = getEntArray(var_1, var_2);
  } else if(istrue(level._id_0D00._id_8573)) {
    var_4 = getEntArray(0, var_1, var_2);
  }

  if(_func_0107(var_4)) {
    var_3 = scripts\engine\utility::array_combine(var_3, var_4);
  }

  foreach(var_6 in _id_0850::_id_1BF3(var_3)) {
    var_6 thread _id_0D67(var_0);
  }

  level thread _id_0D66();
}

_id_DEDC(var_0, var_1) {
  var_2 = _func_0121(var_0);
  var_3 = _func_0107(var_1) && var_1.size > 0 && _func_0107(var_1[0]);
  var_4 = _func_0107(var_1) && var_1.size >= 3 && _func_0121(var_1[0]);
  var_5 = _func_0121(var_1);
  var_6 = var_2 && (var_3 || var_4 || var_5);

  if(_id_0850::_id_DECB(!var_6, "snd: element_init invalid")) {}

  if(var_5 && !isDefined(level._id_0D00._id_0BCF[var_1])) {}

  if(var_4) {
    var_1 = [var_1];
  }

  level._id_0D00._id_0BCF[var_0] = var_1;
}

_id_0CB5(var_0) {
  if(_func_0121(var_0)) {
    var_1 = level._id_0D00._id_0BCF[var_0];
    var_2 = _func_0107(var_1);
    var_3 = _func_0121(var_1);

    if(var_2) {
      return var_0;
    } else if(var_3 && _func_0107(level._id_0D00._id_0BCF[var_1])) {
      return var_1;
    }
  }

  return undefined;
}

_id_0BF6(var_0) {
  if(_func_0107(var_0)) {
    return var_0;
  } else if(_func_0121(var_0)) {
    var_0 = _id_0CB5(var_0);
    var_1 = level._id_0D00._id_0BCF[var_0];
    var_2 = _func_0107(var_1);

    if(var_2) {
      return var_1;
    }
  }

  return undefined;
}

_id_DF19(var_0, var_1) {
  var_2 = _id_0850::_id_899D(var_0);

  if(_id_0850::_id_DECB(!var_2, "snd: set_element invalid player")) {
    return;
  }
  var_3 = _func_0107(var_1);
  var_4 = _func_0121(var_1);
  var_5 = !isDefined(var_1);
  var_6 = var_3 || var_4 || var_5;

  if(_id_0850::_id_DECB(!var_6, "snd: set_element invalid element")) {
    return;
  }
  if(var_3) {
    var_0._id_0D21 = "**** custom****";
  } else if(var_4) {
    var_7 = _id_0CB5(var_0._id_0D21);
    var_8 = _id_0CB5(var_1);
    var_9 = _func_0121(var_7) && _func_0121(var_8) && var_7 == var_8;
    var_0._id_0D21 = var_1;

    if(var_9) {
      return;
    }
  }

  if(var_2 && _func_0107(var_0._id_0D27)) {
    _id_DF21(var_0._id_0D27);
    var_0._id_0D27 = undefined;
  }

  if(var_5) {
    var_0._id_0D21 = undefined;
    return;
  }

  var_10 = _id_0BF6(var_1);
  var_11 = _func_0107(var_10);

  if(_id_0850::_id_DECB(!var_11, "snd: set_element unexpected")) {
    return;
  }
  var_0._id_0D27 = [];

  foreach(var_13 in var_10) {
    var_14 = var_13[0];
    var_15 = scripts\engine\utility::_id_FF6C(var_13[1], var_0);
    var_16 = var_13[2];
    var_17 = var_13[3];
    var_18 = var_13[4];
    var_19 = var_13[5];
    var_20 = _id_DEDD(var_14, var_15, var_16, var_17, var_18, var_19);

    if(isDefined(var_20)) {
      var_0._id_0D27[var_0._id_0D27.size] = var_20;
    }
  }
}

_id_0D32(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 notify("snd_line_detach");
  var_0 endon("snd_line_detach");

  while(_id_0850::_id_899D(var_1) && _id_DEEF(var_0)) {
    var_4 = var_1 _id_0850::_id_6C6F();
    var_5 = _func_01A4(var_2, var_3, var_4);
    var_0.origin = var_5;
    waitframe();
  }
}

_id_DEF0(var_0, var_1, var_2, var_3) {
  if(_id_0850::_id_DECB(!_id_DEEF(var_0), "snd_line_attach with invalid soundObject")) {
    return;
  }
  if(_id_0850::_id_DECB(!_id_0850::_id_899D(var_1), "snd_line_attach with invalid player")) {
    return;
  }
  if(_id_0850::_id_DECB(!isvector(var_2), "snd_line_attach with invalid start position")) {
    return;
  }
  if(_id_0850::_id_DECB(!isvector(var_3), "snd_line_attach with invalid end position")) {
    return;
  }
  var_0 thread _id_0D32(var_0, var_1, var_2, var_3);
}

_id_DEF1(var_0) {
  if(_id_0850::_id_DECB(!isDefined(var_0), "snd_line_detach with undefined soundObject")) {
    return;
  }
  var_0 notify("snd_line_detach");
}

_snd_transient_init() {
  _id_DF3D();

  if(!_func_0107(level._id_0D00._transient_banks)) {
    level._id_0D00._transient_banks = [];
  }

  if(!isent(level._id_0D00._transient_bank_ent)) {
    level._id_0D00._transient_bank_ent = spawn("sound_transient_soundbanks", (0, 0, 0));
  }
}

snd_transient_is_loaded(var_0) {
  if(isDefined(level._id_0D00) && isDefined(level._id_0D00._transient_banks) && isDefined(level._id_0D00._transient_banks[var_0])) {
    return 1;
  }

  return 0;
}

snd_transient_load(var_0) {
  _snd_transient_init();
  var_1 = snd_transient_is_loaded(var_0);

  if(_id_0850::_id_DECB(var_1, "snd_transient_load loaded '" + var_0 + "'")) {
    return;
  } else {
    level._id_0D00._transient_bank_ent _meth_837B(var_0 + ".all", 1);
    level._id_0D00._transient_banks[var_0] = level._id_0D00._transient_banks.size;
  }
}

snd_transient_unload(var_0) {
  _snd_transient_init();
  var_1 = snd_transient_is_loaded(var_0);

  if(_id_0850::_id_DECB(!var_1, "snd_transient_unload '" + var_0 + "' not loaded")) {
    return;
  } else {
    level._id_0D00._transient_bank_ent _meth_837B(var_0 + ".all", 0);
    level._id_0D00._transient_banks[var_0] = undefined;
  }
}