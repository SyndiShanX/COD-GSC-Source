/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2128.gsc
*************************************************/

_id_F051(var_0, var_1) {
  return var_0 % var_1;
}

_id_6C6F() {
  var_0 = self;
  var_1 = undefined;

  if(_func_03AC(level._id_0D00._id_0B78["player_view"])) {
    var_1 = var_0[[level._id_0D00._id_0B78["player_view"]]]();
  } else {
    var_1 = var_0 getEye();
  }

  return var_1;
}

_id_6C6D() {
  var_0 = self;
  var_1 = undefined;

  if(_func_03AC(level._id_0D00._id_0B78["player_angles"])) {
    var_1 = var_0[[level._id_0D00._id_0B78["player_angles"]]]();
  } else {
    var_1 = var_0 getplayerangles();
  }

  return var_1;
}

_id_6C4F() {
  var_0 = self;
  var_1 = undefined;

  if(_func_03AC(level._id_0D00._id_0B78["player_fov"])) {
    var_1 = var_0[[level._id_0D00._id_0B78["player_fov"]]]();
  } else {
    var_1 = getdvarfloat("#x356e0c9e15809767a", 65.0);
  }

  return var_1;
}

_id_FFDE(var_0) {
  if(isvector(var_0) == 1) {
    var_1 = 0;
    var_1 = var_1 + var_0[0];
    var_1 = var_1 + var_0[1];
    var_1 = var_1 + var_0[2];
    var_1 = var_1 / 3.0;
    return var_1;
  }

  var_1 = (0, 0, 0);

  if(var_0.size == 0) {
    return var_1;
  } else if(var_0.size == 1) {
    return var_0[0];
  }

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  var_1 = var_1 / var_0.size;
  return var_1;
}

_id_0CA1(var_0, var_1) {}

_id_BCE5(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_87B5(var_0) {
  return _func_03AD(var_0) || _func_03AE(var_0);
}

_id_8A1D(var_0) {
  return _func_03AC(var_0);
}

_id_E389(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  return spawnStruct();
}

_id_6D34(var_0, var_1) {
  return undefined;
}

_id_E065(var_0, var_1) {
  return _id_6D34(var_0, var_1);
}

_id_5BE9(var_0) {
  if(var_0 >= -180 && var_0 <= 180) {
    return var_0;
  }

  while(var_0 < -180) {
    var_0 = var_0 + 360;
  }

  while(var_0 > 180) {
    var_0 = var_0 - 360;
  }

  return var_0;
}

_id_6C58(var_0) {
  if(isDefined(var_0) == 1) {
    if(isDefined(var_0.name) == 1) {
      return var_0.name;
    }

    if(isDefined(var_0._id_B724) == 1) {
      return var_0._id_B724;
    }
  }

  return undefined;
}

_id_BFFC(var_0) {
  if(_func_0107(var_0) == 1) {
    if(var_0.size >= 2) {
      var_1 = var_0[0];
      var_2 = var_0[1];

      if(var_1 > var_2) {
        var_3 = var_2;
        var_2 = var_1;
        var_1 = var_3;
      }

      var_4 = randomfloatrange(var_1, var_2);
      return var_4;
    } else if(var_0.size == 1)
      var_0 = var_0[0];
  }

  return float(var_0);
}

_id_C015(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(var_0 == var_1) {
      return var_0;
    } else {
      var_3 = randomfloatrange(var_0, var_1);
      return var_3;
    }
  } else if(isDefined(var_0) == 1 && isDefined(var_1) == 0)
    return var_0;
  else if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

_id_C01F(var_0, var_1) {
  var_2 = undefined;

  if(_func_0107(var_0) == 1) {
    if(var_0.size == 0) {
      return undefined;
    } else if(var_0.size == 1) {
      return float(var_0[0]);
    } else {
      var_3 = var_0[0];
      var_4 = var_0[1];
      var_2 = _id_C015(var_3, var_4);
      return float(var_2);
    }
  } else if(_func_0107(var_0) == 0 && isDefined(var_1) == 1)
    var_2 = _id_C015(var_1, var_0);
  else {
    var_2 = var_0;
  }

  return float(var_2);
}

_id_1BF2(var_0) {
  if(var_0.size == 0) {
    return undefined;
  } else if(var_0.size == 1) {
    return var_0[0];
  }

  return var_0;
}

_id_1BF3(var_0) {
  if(!isDefined(var_0)) {
    return [];
  } else if(isDefined(var_0) == 1 && _func_0458(var_0) == 0 && _func_0107(var_0) == 1) {} else
    return [var_0];

  return var_0;
}

_id_FFC6(var_0, var_1) {
  var_2 = _func_0107(var_0);
  var_3 = isDefined(var_1);

  if(_id_DECB(!var_3, "snd VarrayAdd undefined entity")) {
    return var_0;
  }

  if(!var_2) {
    if(isDefined(var_0)) {
      var_0 = [var_0, var_1];
    } else {
      var_0 = [var_1];
    }
  } else if(var_2) {
    var_4 = scripts\engine\utility::array_contains(var_0, var_1);

    if(!var_4) {
      var_0[var_0.size] = var_1;
    }
  }

  return var_0;
}

_id_FFC7(var_0, var_1) {
  var_2 = _func_0107(var_0);
  var_3 = isDefined(var_1);

  if(_id_DECB(!var_3, "snd VarrayRemove undefined entity")) {
    return var_0;
  }

  if(!var_2) {
    var_0 = undefined;
  } else if(var_2) {
    var_4 = scripts\engine\utility::array_contains(var_0, var_1);

    if(var_4) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
    }
  }

  return var_0;
}

_id_EA5C(var_0, var_1) {
  var_0 = scripts\engine\utility::_id_FF6C(var_0, "");
  var_1 = scripts\engine\utility::_id_FF6C(var_1, "");
  var_2 = "";
  var_2 = var_2 + (var_1 + var_0 + var_1);
  return var_2;
}

_id_758E(var_0) {
  if(_func_02B7(var_0) == 1) {
    return 1;
  } else if(_func_0121(var_0) == 1 && var_0[0] == "0" || var_0[0] == "1" || var_0[0] == "2" || var_0[0] == "3" || var_0[0] == "4" || var_0[0] == "5" || var_0[0] == "6" || var_0[0] == "7" || var_0[0] == "8" || var_0[0] == "9" || var_0[0] == ".") {
    return 1;
  }

  return 0;
}

_id_1BF1(var_0) {
  foreach(var_5, var_2 in var_0) {
    var_3 = _func_0121(var_2);
    var_4 = _id_758E(var_2);

    if(var_3 == 1 && var_4 == 1) {
      var_0[var_5] = int(var_2);
    }
  }

  return var_0;
}

_id_1BF0(var_0) {
  foreach(var_5, var_2 in var_0) {
    var_3 = _func_0121(var_2);
    var_4 = _id_758E(var_2);

    if(var_3 == 1 && var_4 == 1) {
      var_0[var_5] = float(var_2);
    }
  }

  return var_0;
}

_id_BA0B(var_0) {
  var_1 = undefined;

  if(isent(var_0) == 1) {
    var_1 = var_0.origin;
  } else if(isvector(var_0) == 1) {
    var_1 = var_0;
  } else {}

  return var_1;
}

_id_BFF5(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_1 = randomintrange(1, var_0.size);
  var_1 = var_1 - 1;
  var_2 = var_0[var_1];
  return var_2;
}

_id_8A67(var_0) {
  var_1 = int(var_0);

  if(var_1 > 0) {
    return 1;
  } else if(var_1 < 0) {
    return 1;
  } else if(var_1 == 0 && var_0 == "0") {
    return 1;
  }

  return 0;
}

_id_6DC0(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = scripts\engine\utility::getstructarray(var_0, "targetname");
  var_3 = [];
  var_4 = _func_00E6(var_0, "targetname");

  if(scripts\common\utility::issp() == 1) {
    var_3 = call[[level._id_6B9A]](var_0, "targetname");
  }

  var_5 = scripts\engine\utility::array_combine(var_1, var_2, var_3, var_4);
  return var_5;
}

_id_DE60(var_0, var_1, var_2) {
  if(var_2 == 0.0) {
    return var_0;
  } else if(var_2 == 1.0) {
    return var_1;
  }

  var_2 = clamp(var_2, 0.0, 1.0);
  var_4 = 1.0 - var_2;
  var_1 = var_0 * var_4 + var_1 * var_2;
  return var_1;
}

_id_8AF2(var_0, var_1, var_2) {
  if(var_0 >= var_1 && var_0 <= var_2) {
    return 1;
  }

  return 0;
}

_id_8AF3(var_0, var_1, var_2) {
  var_3 = _id_8AF2(var_0, var_1 - var_2, var_1 + var_2);
  return var_3;
}

_id_10951() {
  while(_func_0458(self) == 0) {
    scripts\engine\utility::_id_1087F("death", "disconnect");
  }
}

_id_10953(var_0, var_1) {
  self endon("death");
  var_2 = self;
  var_3 = undefined;
  var_4 = undefined;

  if(_func_0107(var_1)) {
    var_3 = float(var_1[0]);
    var_4 = float(var_1[1]);
  } else if(_func_02B7(var_1))
    var_3 = float(var_1);

  var_5 = abs(var_3);

  while(isDefined(var_2) && isDefined(var_0)) {
    var_6 = _id_BA0B(var_2);
    var_7 = _id_BA0B(var_0);
    var_8 = distance(var_6, var_7);

    if(_func_0110(var_4)) {
      if(var_8 <= var_4 && var_8 >= var_3) {
        return;
      }
    } else {
      if(var_3 > 0 && var_8 >= var_3) {
        return;
      }
      if(var_3 <= 0 && var_8 <= var_5) {
        return;
      }
    }

    waitframe();
  }
}

_id_FE7B(var_0) {
  if(_func_02B7(var_0)) {
    return var_0;
  }

  switch (var_0) {
    case "duration_none":
      return 0;
    case "duration_short":
    default:
      return 250;
    case "duration_medium":
      return 1000;
    case "duration_long":
      return 5000;
  }

  return 0;
}

_id_B80B(var_0, var_1) {
  var_2 = 250;

  if(_func_0121(var_1)) {
    var_2 = _id_FE7B(var_1);
  } else if(_func_02B7(var_1)) {
    var_2 = var_1;
  }

  var_3 = 0;

  while(var_3 < var_2) {
    var_3 = var_3 + 50;
    waitframe();
    waittillframeend;

    if(!var_0 usebuttonpressed()) {
      break;
    }
  }

  return var_3;
}

_id_F639(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!istrue(var_0._id_0BBF)) {
    var_0 waittill("trigger_progress", var_3);
    var_0._id_0BBF = 1;
    var_0._id_0BBE = var_3;
    return [var_3, 0];
  }

  var_3 = var_0._id_0BBE;
  var_0._id_0BBF = undefined;
  var_0._id_0BBE = undefined;
  var_4 = _id_FE7B(var_1);
  var_5 = _id_B80B(var_3, var_1);
  var_6 = undefined;

  if(var_2) {
    var_6 = [var_3, var_5];
  } else {
    var_7 = var_5 / var_4;
    var_6 = [var_3, var_7];
  }

  return var_6;
}

_id_899D(var_0) {
  if(isDefined(var_0) && isent(var_0) && isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

_id_0C05(var_0) {
  return level.players;
}

_id_6C63(var_0) {
  if(istrue(level._id_0D00._id_8573)) {
    var_1 = _id_0C05(0, var_0);

    foreach(var_3 in var_1) {
      if(!_id_899D(var_3)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      }
    }

    return var_1;
  }

  if(istrue(level._id_0D00._id_86B5)) {
    var_1 = _id_0C05(var_0);
    return var_1;
  }

  return [];
}

_id_6C4E(var_0) {
  var_1 = _id_6C63();

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_96C7) && var_3._id_96C7 == var_0) {
      return var_3;
    }
  }

  return undefined;
}

_id_1081D() {
  for(;;) {
    var_0 = _id_6C63();

    if(_func_0107(var_0) && var_0.size > 0) {
      break;
    }

    waitframe();
  }
}

_id_107D9(var_0) {
  _id_1081D();
  var_1 = _id_6C63(var_0);
  return var_1;
}

_id_6D18() {
  if(istrue(level._id_0D00._id_8573)) {
    return int(60);
  }

  if(istrue(level._id_0D00._id_86B5)) {
    return int(20);
  }

  return float(20);
}

_id_6D19() {
  if(istrue(level._id_0D00._id_8573)) {
    return float(0.0166667);
  }

  if(istrue(level._id_0D00._id_86B5)) {
    return float(0.05);
  }

  return float(0.05);
}

_id_6D87() {
  if(_func_0121(level._id_E628) && _func_0121(level._id_E62A) && level._id_E62A == "no_game") {
    return level._id_E628;
  }

  return level._id_E62A;
}

_id_106CD(var_0, var_1) {
  var_2 = 0.0333333 * var_0;

  if(isDefined(var_1) == 0) {
    var_1 = 0.0;
  }

  var_3 = var_2 + var_1;

  if(var_3 <= 0.0) {
    return;
  }
  wait(var_3);
}

_id_CB86(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == var_2) {
    var_2 = var_2 + 0.001;
  }

  if(var_3 == var_4) {
    var_4 = var_4 + 0.001;
  }

  var_5 = _func_0439(var_1, var_2, var_3, var_4, var_0);
  return var_5;
}

_id_FFE0(var_0, var_1) {
  var_2 = var_0 * (var_1, var_1, var_1);
  return var_2;
}

_id_0DBB(var_0) {
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
  var_4 = _id_FFE0(var_4, var_3);
  return var_4;
}

_id_FFDF(var_0, var_1, var_2) {
  if(_func_02B7(var_1)) {
    var_1 = (var_1, var_1, var_1);
  }

  if(_func_02B7(var_2)) {
    var_2 = (var_2, var_2, var_2);
  }

  var_3 = var_0;
  var_3 = (clamp(var_3[0], var_1[0], var_2[0]), clamp(var_3[1], var_1[1], var_2[1]), clamp(var_3[2], var_1[2], var_2[2]));
  return var_3;
}

_id_FFE1(var_0, var_1) {
  var_2 = _id_FFE0(var_0, var_1);
  var_3 = _id_0DBB(var_2);
  return var_3;
}

_id_FFE2(var_0, var_1) {
  var_2 = _id_FFE0(var_0, var_1);
  var_3 = _id_FFDF(var_2, (0, 0, 0), (1, 1, 1));
  return var_3;
}

_id_7D96(var_0) {
  return float(var_0) * 0.0833333;
}

_id_7D97(var_0) {
  return float(var_0) * 0.0254;
}

_id_9DF1(var_0) {
  return float(var_0) * 39.3701;
}

_id_9DF0(var_0) {
  return float(var_0) * 3.28084;
}

_id_9E92(var_0) {
  return float(var_0) * 63360;
}

_id_FF25(var_0) {
  return _id_7D96(var_0);
}

_id_FF26(var_0) {
  return _id_7D97(var_0);
}

_id_89BB(var_0, var_1, var_2) {
  var_3 = distance(var_0, var_1);

  if(var_3 <= var_2) {
    return 1;
  }

  return 0;
}

_id_AC5D(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) == 0 || var_1 <= 0) {
    return var_0;
  }

  var_2 = scripts\engine\utility::_id_FF6C(var_2, 0.0);
  var_3 = scripts\engine\utility::_id_FF6C(var_3, 0.0);
  var_2 = var_2 + 180;
  var_3 = var_3 + 270;
  var_4 = var_0[0];
  var_5 = var_0[1];
  var_6 = var_0[2];
  var_4 = var_4 + var_1 * sin(var_3) * cos(var_2);
  var_5 = var_5 + var_1 * sin(var_3) * sin(var_2);
  var_6 = var_6 + var_1 * cos(var_3);
  var_7 = (var_4, var_5, var_6);
  return var_7;
}

_id_6DB5(var_0) {
  var_1 = self;
  var_2 = "";
  var_3 = undefined;

  if(isDefined(var_0) == 1) {
    var_2 = var_0;
    var_3 = var_1 gettagorigin(var_2, 1);
  }

  if(isDefined(var_3) == 1) {
    var_2 = tolower(var_2);
  }

  return var_2;
}

_id_C014(var_0, var_1, var_2) {
  var_3 = var_0 - var_2;
  var_4 = var_0 + var_2;
  var_5 = var_4 - var_3;
  var_6 = (randomfloat(var_5[0]), randomfloat(var_5[1]), randomfloat(var_5[2]));

  if(var_1 != (0, 0, 0)) {
    var_3 = var_0 - rotatevector(var_0 - var_3, var_1);
    var_6 = rotatevector(var_6, var_1);
  }

  var_7 = var_3 + var_6;
  return var_7;
}

_id_6E43() {
  var_0 = getdvarint("#x39fe113b415c4ac68", 1920);
  var_1 = getdvarint("#x39c84346661808a9f", 1080);
  return [var_0, var_1];
}

_id_6D35() {
  return 0;
}

_id_8A3F() {
  return 0;
}

_id_8A40() {
  return 0;
}

_id_D6CF() {
  var_0 = ["djalbert", "jgosselin", "mdenis", "ntremblay", "plgrondines", "sarseneault", "sclark", "vleroux", "asanchez", "bdevereaux", "cbello", "csakanai", "dtung", "imika", "jdrelick", "tbader", "carya", "cegert", "cstaples", "cchristensen", "dnatale", "dprior", "drowe", "rorice", "smiller", "sprovine", "tleeamies", "tstasica", "abayless", "rojackson", "gleek-abrown", "abrown", "bkreimeier", "dblondin", "jdenny", "jharley", "jruhala", "jsypult", "jtennies", "mwolf", "ndamato", "rsmsnjmiller", "jmiller", "tischlie", "tschlie", "vnuniyants", "dbrown", "dpetras", "dveca", "dswenson", "elopez", "ewedemeyer", "flabarthe", "kchau", "lhitch", "mcaisley", "mgrimm", "midavies", "rmcsweeney", "tcannan", "bbitonti", "btuey", "cayers", "cdinkel", "hplunkard", "jmccawley", "ksherwood", "lstaples", "rgarigliano", "seckert", "sjimmerson", "wcornell"];
  var_1 = _id_6C63();

  if(_func_0107(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = _id_6C58(var_3);

      if(isDefined(var_4)) {
        foreach(var_6 in var_0) {
          if(issubstr(var_4, var_6)) {
            setDvar("#x3de130160b6d36133", "1");
            return;
          }
        }
      }
    }
  }
}

_id_DECB(var_0, var_1) {
  return var_0;
}

_id_106A6(var_0) {
  var_1 = _func_013F(float(var_0)) / _func_013F(10.0);
  var_2 = 20.0 * var_1;
  return var_2;
}

_id_4518(var_0) {
  var_1 = _func_01A6(10.0, float(var_0) / 20.0);
  return var_1;
}

_id_D091(var_0) {
  var_1 = _func_01A6(2.0, float(var_0) / 12.0);
  return var_1;
}

_id_B142(var_0) {
  var_1 = _func_013F(var_0) / _func_013F(2.0);
  var_2 = 12.0 * var_1;
  return var_2;
}

_id_CAA1(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_CAA2) == 0) {
    _id_DECB(isDefined(level._id_CAA2) == 0, "rvPlayAnimation was not initialized!");
  } else {
    if(isDefined(var_2) == 0) {
      var_2 = "animnotetrack";
    }

    if(isDefined(var_3) == 0) {
      var_3 = 1.0;
    }

    self thread[[level._id_CAA2]](var_0, var_1, var_2, var_3);
  }
}

_id_DEDB() {
  level notify("snd_dvar_stop");
}

_id_0D20() {
  level notify("snd_dvar_stop");
  level endon("snd_dvar_stop");
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level._id_0B55) {
      var_2 = var_1._id_2F23;
      var_3 = var_1._id_8CCF;
      var_4 = "" + var_1._id_04CB;
      var_5 = getDvar(var_3);

      if(isDefined(var_2) && isDefined(var_3) && isDefined(var_5) && var_4 != var_5) {
        var_6 = [[var_2]](var_3, var_5);

        if(isDefined(var_6)) {
          setDvar(var_3, var_6);
          var_1._id_04CB = var_6;
        } else
          var_1._id_04CB = var_5;
      }
    }

    waitframe();

    if(isDefined(level._id_7AAE)) {
      level waittill("host_migration_end");

      foreach(var_1 in level._id_0B55) {
        _id_0D1F(var_1._id_8CCF, var_1._id_04CB);
      }
    }
  }
}

_id_0D1E() {
  if(isDefined(level._id_0B55) == 0) {
    level._id_0B55 = [];
    level thread _id_0D20();
  }
}

_id_0D1D(var_0, var_1, var_2) {
  _id_DEDA(var_0);
  level._id_0B55[var_0] = spawnStruct();
  level._id_0B55[var_0]._id_2F23 = var_2;
  level._id_0B55[var_0]._id_8CCF = var_0;
  level._id_0B55[var_0]._id_04CB = var_1;
  _id_0D1F(var_0, var_1);
}

_id_0D1F(var_0, var_1) {
  var_2 = getDvar(var_0);

  if(isDefined(var_2) == 0 || var_2 == "") {
    setdvarifuninitialized(var_0, var_1);
  }
}

_id_DEDA(var_0) {
  if(isDefined(level._id_0B55[var_0])) {
    level._id_0B55[var_0] = undefined;
  }
}

_id_DED9(var_0, var_1, var_2) {
  _id_0D1E();
  _id_0D1D(var_0, var_1, var_2);
}

_id_0B79(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_8)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(isDefined(var_7)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  if(isDefined(var_6)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5);
  }

  if(isDefined(var_4)) {
    self[[var_0]](var_1, var_2, var_3, var_4);
  }

  if(isDefined(var_3)) {
    self[[var_0]](var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    self[[var_0]](var_1, var_2);
  } else if(isDefined(var_1)) {
    self[[var_0]](var_1);
  } else {
    self[[var_0]]();
  }
}

_id_0B77(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_8)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(isDefined(var_7)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  if(isDefined(var_6)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    self[[var_0]](var_1, var_2, var_3, var_4, var_5);
  }

  if(isDefined(var_4)) {
    self[[var_0]](var_1, var_2, var_3, var_4);
  }

  if(isDefined(var_3)) {
    self[[var_0]](var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    self[[var_0]](var_1, var_2);
  } else if(isDefined(var_1)) {
    self[[var_0]](var_1);
  } else {
    self[[var_0]]();
  }
}

_id_2F47(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(_func_03AC(var_0)) {
    _id_0B79(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(_func_03AE(var_0)) {
    _id_0B77(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

_id_2F5A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread _id_2F47(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_0C0C(var_0, var_1, var_2) {
  if(_func_0205(var_0) == 0) {
    return undefined;
  }

  var_3 = _id_E065(var_0, var_1);

  if(isDefined(var_3) == 0 || "" + var_3 == "") {
    return undefined;
  }

  var_4 = float(var_3);

  for(var_5 = _id_E065(var_0, "secondaryaliasname"); isDefined(var_5) == 1 && var_5 != ""; var_5 = _id_E065(var_5, "secondaryaliasname")) {
    var_3 = _id_E065(var_0, var_1);
    var_3 = float(var_3);

    if(var_2 == "min") {
      var_4 = min(var_4, var_3);
      continue;
    }

    if(var_2 == "max") {
      var_4 = max(var_4, var_3);
    }
  }

  return var_4;
}

_id_6D3C(var_0, var_1) {
  var_2 = _id_0C0C(var_0, var_1, "min");
  return var_2;
}

_id_6D3B(var_0, var_1) {
  var_2 = _id_0C0C(var_0, var_1, "max");
  return var_2;
}

_id_84E4(var_0) {
  var_1 = "0123456789ABCDEF";
  var_2 = int(var_0);

  for(var_3 = ""; var_2 != 0; var_2 = var_2 >> 4) {
    var_4 = var_2 % 16;
    var_3 = var_1[var_4] + var_3;
  }

  return var_3;
}

_id_787F(var_0) {
  var_0 = scripts\engine\utility::_id_EA52(var_0);
  var_1 = int(0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_4 = 0;

    switch (var_3) {
      case "3":
      case "2":
      case "0":
      case "7":
      case "6":
      case "5":
      case "4":
      case "9":
      case "8":
      case "1":
        var_4 = int(var_3);
        break;
      case "A":
      case "a":
        var_4 = 10;
        break;
      case "B":
      case "b":
        var_4 = 11;
        break;
      case "C":
      case "c":
        var_4 = 12;
        break;
      case "d":
      case "D":
        var_4 = 13;
        break;
      case "E":
      case "e":
        var_4 = 14;
        break;
      case "f":
      case "F":
        var_4 = 15;
        break;
    }

    var_1 = int(var_1 << 4 | int(var_4));
  }

  return var_1;
}

_id_6725(var_0, var_1) {
  var_1 = scripts\engine\utility::_id_FF6C(var_1, 1);
  var_2 = [];
  var_3 = scripts\engine\utility::getstructarray(var_0, "scriptbundlename");
  var_2 = scripts\engine\utility::array_combine(var_3, var_2);
  var_4 = [];
  var_2 = scripts\engine\utility::array_combine(var_4, var_2);
  var_5 = [];
  var_2 = scripts\engine\utility::array_combine(var_5, var_2);
  var_6 = [];

  if(_func_0107(var_2) && var_2.size > 0) {
    foreach(var_8 in var_2) {
      if(_func_0107(var_8._id_CBB2)) {
        var_6 = scripts\engine\utility::array_combine(var_8._id_CBB2, var_6);
        var_6 = scripts\engine\utility::_id_1BD1(var_6);

        if(var_1) {
          foreach(var_10 in var_6) {
            if(_id_899D(var_10)) {
              var_6 = scripts\engine\utility::array_remove(var_6, var_10);
            }
          }
        }
      }
    }
  }

  return var_6;
}

_id_0BFE(var_0, var_1, var_2) {
  var_3 = _func_0098(undefined, undefined, var_0, var_1);
  return var_3;
}

_id_0B40(var_0, var_1, var_2, var_3, var_4) {
  var_3 = scripts\engine\utility::_id_FF6C(var_3, 65.0);
  var_5 = cos(var_3);
  var_4 = scripts\engine\utility::_id_FF6C(var_4, 262144);
  var_6 = [];

  foreach(var_8 in var_0) {
    var_9 = distance(var_8.origin, var_1);

    if(var_9 <= var_4) {
      var_10 = var_8.origin - var_1;
      var_11 = vectornormalize(var_10);
      var_12 = vectordot(var_2, var_11);

      if(var_12 >= var_5) {
        var_6[var_6.size] = var_8;
      }
    }
  }

  return var_6;
}

_id_0B3F(var_0, var_1, var_2, var_3) {
  var_3 = scripts\engine\utility::_id_FF6C(var_3, 262144);
  var_4 = undefined;
  var_5 = 0.0;

  foreach(var_7 in var_2) {
    var_8 = distance(var_7.origin, var_0);

    if(var_8 <= var_3) {
      var_9 = var_7.origin - var_0;
      var_10 = vectornormalize(var_9);
      var_11 = vectordot(var_1, var_10);

      if(var_11 > var_5) {
        var_4 = var_7;
        var_5 = var_11;
      }
    }
  }

  return var_4;
}