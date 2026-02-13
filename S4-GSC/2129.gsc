/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2129.gsc
*************************************************/

_id_DF16(var_0) {}

_id_1E7C(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 thread _id_1F03(var_0);
  var_1 waittill("slo_mo_wait_done");
  var_1 delete();
}

_id_1F03(var_0) {
  var_1 = 0;

  while(var_1 < var_0) {
    var_2 = getdvarfloat("#x3cab10ed8ca8c226b");
    var_1 = var_1 + 0.05 / var_2;
    wait 0.05;
  }

  self notify("slo_mo_wait_done");
}

_id_1E78(var_0, var_1) {
  var_2 = var_0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  return var_2;
}

_id_DEFB() {
  level._id_0D00.guid++;
  return level._id_0D00.guid;
}

_id_DF3A(var_0) {
  var_1 = 0;

  if(isDefined(level.players)) {
    foreach(var_3 in level.players) {
      if(var_0 == var_3) {
        return 1;
      }
    }
  }

  return var_1;
}

_id_DF3B(var_0) {
  var_1 = 1;

  if(!_func_0107(var_0)) {
    var_1 = 0;
  } else {
    foreach(var_3 in var_0) {
      var_4 = 1;

      foreach(var_6 in level.players) {
        if(var_3 == var_6) {
          var_4 = 0;
          break;
        }
      }

      if(var_4) {
        var_1 = 0;
        break;
      }
    }
  }

  return var_1;
}

_id_DECC(var_0, var_1) {
  var_2 = level.player;
  var_3 = 0;
  var_4 = anglesToForward(var_2.angles);
  var_5 = var_0 - var_2.origin;
  var_6 = vectordot(var_4, var_5);

  if(isDefined(var_1)) {
    var_3 = var_1;

    if(var_1 > 90) {
      var_1 = 90;
    }

    if(var_3 < 0) {
      var_3 = 0;
    }
  }

  return var_6 > var_3;
}

_id_DED2(var_0, var_1) {
  if(!isDefined(level._id_0D00._id_BFCF)) {
    level._id_0D00._id_BFCF = spawnStruct();
    level._id_0D00._id_BFCF._id_EACC = var_0;
    level._id_0D00._id_BFCF._id_BFCE = 0;
  }

  var_2 = [var_0, var_1];

  foreach(var_4 in var_2) {
    if(var_4 > 100) {
      var_4 = 100;
    }

    if(var_4 < 1) {
      var_4 = 1;
    }
  }

  var_6 = randomintrange(1, 100);
  var_7 = level._id_0D00._id_BFCF._id_EACC + level._id_0D00._id_BFCF._id_BFCE;

  if(var_6 <= var_7) {
    level._id_0D00._id_BFCF._id_BFCE = 0;
    return 1;
  }

  if(var_6 >= var_7) {
    level._id_0D00._id_BFCF._id_BFCE = level._id_0D00._id_BFCF._id_BFCE + var_1;
    return 0;
  }
}

_id_DEDE() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1.0;
  var_0._id_01D6 = 1;
  wait 0.05;
  var_0 destroy();
}

_id_DF1C(var_0) {
  _id_DEDE();
  _id_DF16("SLATE: " + var_0);
}

_id_DF1D(var_0, var_1, var_2, var_3) {
  var_4 = _id_1E78(var_2, var_3);
  var_5 = 1.0;

  if(var_1 > var_0) {
    var_5 = var_2;
  } else if(var_1 < var_0) {
    var_5 = var_4;
  }

  return var_0 + var_5 * (var_1 - var_0);
}

_id_DF2F() {
  if(self._id_011A >= self._id_9C0B) {
    wait 0.05;
  } else {
    self._id_011A++;
  }

  if(!self._id_C5F2) {
    thread _id_DF30();
  }
}

_id_DF30() {
  self._id_C5F2 = 1;
  waittillframeend;
  self._id_C5F2 = 0;
  self._id_011A = 0;
}

_id_DEE2(var_0) {
  var_1 = spawnStruct();
  var_1.name = "throttle_waiter";
  var_1._id_011A = 0;
  var_1._id_C5F2 = 0;
  var_2 = 10;

  if(isDefined(var_0)) {
    var_2 = max(var_0, 1);
  }

  var_1._id_9C0B = var_2;
  return var_1;
}

_id_DEF6(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_B9FE = [];
  var_3._id_B17B = var_0;
  var_3._id_3C80 = _id_1E78(0, var_2);
  var_4 = _id_1E78([10, 10], var_1);
  var_5 = 11;
  var_6 = 1;
  var_7 = [];

  foreach(var_9 in var_3._id_B17B) {
    var_7[var_7.size] = var_9["name"];
  }

  var_3._id_7B25 = _id_DEE6(var_7, var_4, var_5, var_6);
  var_3 thread _id_DF41();
  return var_3;
}

_id_DF41() {
  for(;;) {
    foreach(var_1 in self._id_B17B) {
      var_2 = distance(level.player.origin, var_1["origin"]);

      if(self._id_3C80) {
        var_2 = var_2 / 36 + "yds";
      }

      self._id_7B25 _id_DEEB(var_1["name"], var_2);
    }

    waitframe();
  }
}

_id_DEE6(var_0, var_1, var_2, var_3) {}

_id_DEEB(var_0, var_1) {}

_id_DEE7(var_0) {
  foreach(var_2 in self._id_8E80) {
    _id_DEEB(var_2, "");
  }
}

_id_DEEA(var_0, var_1) {}

_id_DEE8(var_0, var_1, var_2) {}

_id_DF3F(var_0, var_1, var_2) {}

_id_DF40(var_0) {}

_id_DEE9() {}