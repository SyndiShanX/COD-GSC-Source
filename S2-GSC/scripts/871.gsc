/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\871.gsc
**************************************/

_id_8E3A(var_0, var_1, var_2, var_3) {
  _id_0378::_id_307C(var_0, var_2, var_3);
  _id_0378::_id_307F(var_1);
  level._id_071D._id_7502 = [];
}

snd_zmb_plr_dlg_play_line_on_each_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in level.players) {
    var_7 _id_8E3D(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_8E3C(var_0, var_1, var_2, var_3, var_4, var_5) {
  return _id_8EA3(var_0, var_1, var_2, var_3, undefined, var_4, var_5);
}

_id_8E3D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "dlg_done_notify_" + _id_0378::_id_8D86();
  var_7 = _id_8EA3(var_0, var_1, var_2, var_3, var_6, var_4, var_5);

  if(!isDefined(var_7)) {
    var_6 = undefined;
  }

  return var_6;
}

_id_8EA3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(common_scripts\utility::_id_562E(var_7._id_324E)) {
    return undefined;
  }

  var_8 = var_7 _id_8E9F();

  if(isDefined(var_6)) {
    var_8 = var_6;
  }

  if(isDefined(var_5) && (var_5 == "_hi" || var_5 == "_md" || var_5 == "_lo")) {
    var_9 = var_5;
  } else {
    var_9 = var_7 _id_8EA0();
  }

  if(!isDefined(var_8) || !isDefined(var_9)) {
    return undefined;
  }

  var_10 = var_8 + var_0 + var_9;

  if(_soundexists(var_10)) {
    var_7 _id_0378::_id_307E(var_10, var_1, var_2, var_3, var_4);
    return 1;
  } else if(_soundexists(var_8 + var_0)) {
    var_7 _id_0378::_id_307E(var_8 + var_0, var_1, var_2, var_3, var_4);
    return 1;
  }

  return undefined;
}

_id_8E38(var_0, var_1) {
  level._id_071D._id_7502[var_0] = var_1;
}

_id_8E3B(var_0, var_1) {
  var_2 = _id_0378::_id_3083();
  var_3 = var_2 _id_8EA1();
  var_4 = var_3[var_0];
  var_5 = self;
  var_6 = undefined;

  if(var_5.health < 10) {
    _id_0378::_id_8D64("EXITING CONV: Plr Health to Low");
  } else {
    var_7 = var_5._id_20D8;
    var_8 = var_2 _id_0378::_id_307B(var_7);
    var_9 = var_4["primary"][var_8];

    if(!isDefined(var_9)) {
      _id_0378::_id_8D64("EXITING CONV: No line for: " + var_8);
      return;
    }

    var_10 = var_9[0];
    var_11 = var_9[1];
    var_12 = undefined;
    var_13 = undefined;
    var_14 = undefined;
    var_15 = undefined;
    var_16 = 10000000;

    foreach(var_18 in level.players) {
      if(var_18 == var_5 || var_18.health < 10) {
        continue;
      }
      var_19 = var_18._id_20D8;
      var_20 = var_2 _id_0378::_id_307B(var_19);
      var_21 = var_4["secondary"][var_20];

      if(isDefined(var_21)) {
        var_22 = distance(var_5.origin, var_18.origin);
        var_23 = 1.0;
        var_24 = 180;

        if(var_22 < 900 && var_22 < var_16 && var_5 common_scripts\utility::_id_7237(var_18, var_23, var_24)) {
          var_15 = var_18;
          var_16 = var_22;
          var_12 = var_21[0];
          var_13 = var_21[1];
        }
      }
    }

    if(isDefined(var_15)) {
      var_6 = var_15;
      var_14 = var_16;
    }

    var_26 = var_5 _id_8EA3(var_10, var_6);

    if(!isDefined(var_26)) {
      return undefined;
    }

    if(isDefined(var_11)) {
      wait(var_11);
    }

    if(isDefined(var_6)) {
      var_6 _id_8EA3(var_12, var_5);

      if(isDefined(var_13)) {
        wait(var_13);
      }
    }

    if(_isstring(var_1)) {
      self notify(var_1);
    }
  }
}

_id_8E3E(var_0) {
  level._id_071D._id_5FDF = var_0;
  level._id_071D._id_7501 = "zmb_" + var_0 + "_";
}

_id_8E39() {
  var_0 = _id_0378::_id_3083();
  return var_0 _id_0378::_id_307B(self._id_20D8);
}

_id_8E43(var_0, var_1) {}

_id_8E42(var_0, var_1) {}

_id_8EA4(var_0) {
  var_1 = undefined;

  if(_soundexists(var_0 + "hi")) {
    var_1 = var_0 + "hi";
  } else if(_soundexists(var_0 + "md")) {
    var_1 = var_0 + "md";
  } else if(_soundexists(var_0 + "lo")) {
    var_1 = var_0 + "lo";
  } else if(_soundexists(var_0)) {
    var_1 = var_0;
  }

  return var_1;
}

_id_8EA1() {
  return level._id_071D._id_7502;
}

_id_8EA2() {
  return level._id_071D._id_5FDF;
}

_id_8E9F() {
  var_0 = self;
  var_1 = var_0._id_20D8;

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = _id_0378::_id_307B(var_1);

  if(!isDefined(level._id_071D._id_7501)) {
    return undefined;
  } else {
    return level._id_071D._id_7501 + var_2 + "_";
  }
}

_id_8EA0(var_0, var_1) {
  var_2 = "_md";
  var_3 = self;
  var_4 = var_3 _id_0366::_id_8E14();
  var_5 = _id_0378::_id_8D49(0, var_1);

  if(isDefined(var_0)) {
    foreach(var_7 in var_0) {
      var_8 = var_7 _id_0366::_id_8E14();
      var_4 = max(var_4, var_8);
    }
  }

  var_10 = 0.1;
  var_11 = 0.5;
  var_12 = 299.7;
  var_13 = 599.4;

  if(var_4 < var_10 && var_5 < var_12) {
    var_2 = "_lo";
  } else if(var_4 > var_11 || var_5 > var_13) {
    var_2 = "_hi";
  }

  return var_2;
}