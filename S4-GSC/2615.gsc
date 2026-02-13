/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2615.gsc
*************************************************/

_id_3585() {
  var_0 = spawnStruct();
  var_0._id_2577 = [];
  var_0._id_2579 = [];
  var_0._id_2574 = [];
  var_0._id_2577[0] = "chilledInit";
  var_0._id_2579[0] = "activeWeak";
  var_0._id_2574[0] = 2;
  var_0._id_2577[1] = "chilledInit";
  var_0._id_2579[1] = "active";
  var_0._id_2574[1] = 2;
  level._id_3582 = var_0;
}

_id_3580(var_0, var_1) {
  if(!isDefined(self._id_3582)) {
    self._id_3582 = spawnStruct();
  }

  var_2 = self._id_3582;
  thread _id_3581();

  if(!isDefined(var_2._id_0026)) {
    self notify("chill");
    var_2._id_0026 = 1;
    var_2._id_E3F9 = 0;
    var_2._id_F266 = [];
    var_1 = var_1 * 1000;
    var_3 = gettime();
    var_4 = var_3 + var_1;
    var_2._id_F266[var_0] = (var_3, var_4, var_1);
    _id_3583();
    self setscriptablepartstate("chilled", "active", 0);
    thread _id_3588();
  } else {
    if(!isDefined(var_2._id_F266[var_0])) {
      var_2._id_0026++;
    }

    var_1 = var_1 * 1000;
    var_3 = gettime();
    var_4 = var_3 + var_1;
    var_2._id_F266[var_0] = (var_3, var_4, var_1);
  }
}

_id_3589(var_0) {
  var_1 = self._id_3582;
  var_1._id_0026--;
  var_1._id_F266[var_0] = undefined;

  if(var_1._id_0026 == 0) {
    self notify("chillEnd");
    _id_3584();
    self setscriptablepartstate("chilled", "neutral", 0);
    self._id_3582 = undefined;
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_87AD() {
  var_0 = self._id_3582;
  return isDefined(var_0) && isDefined(var_0._id_0026);
}

_id_3586() {
  self notify("chillReset");
  self._id_3582 = undefined;
}

_id_3587() {
  self setscriptablepartstate("chilled", "neutral", 0);

  foreach(var_1 in level._id_3582._id_2577) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }
}

_id_3583() {
  scripts\common\utility::_id_1581(0);
  scripts\common\utility::_id_157F(0);
  scripts\common\utility::_id_158C(0);
  scripts\common\utility::_id_1553(0);
}

_id_3584() {
  scripts\common\utility::_id_1581(1);
  scripts\common\utility::_id_157F(1);
  scripts\common\utility::_id_158C(1);
  scripts\common\utility::_id_1553(1);
}

_id_3581() {
  self endon("death_or_disconnect");
  var_0 = self._id_3582;
  var_1 = level._id_3582;
  var_2 = var_0._id_2576;
  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_stun_resistance"), 0, 1);
  var_4 = var_1._id_2577[var_3];
  var_5 = var_1._id_2579[var_3];
  var_6 = var_1._id_2574[var_3];

  if(!isDefined(var_2)) {
    self setscriptablepartstate(var_4, var_5, 0);
    var_0._id_2576 = var_3;
  } else {
    if(var_2 > var_3) {
      return;
    }
    var_7 = var_1._id_2577[var_2];

    if(var_7 != var_4) {
      self setscriptablepartstate(var_7, "neutral", 0);
    }

    self setscriptablepartstate(var_4, var_5, 0);
    var_0._id_2576 = var_3;
  }

  self notify("chillBlind");
  self endon("chillBlind");
  scripts\engine\utility::_id_108A7(var_6, "chillEnd");
  self setscriptablepartstate(var_4, "neutral", 0);
  var_0._id_2576 = undefined;
}

_id_3588() {
  self endon("disconnect");
  self endon("chillReset");
  self endon("chillEnd");
  var_0 = self._id_3582;

  for(;;) {
    var_1 = gettime();
    var_2 = 0;

    foreach(var_10, var_4 in var_0._id_F266) {
      var_5 = var_4[0];
      var_6 = var_4[1];
      var_7 = var_4[2];

      if(var_1 < var_6) {
        var_8 = var_1 - var_5;
        var_9 = 1 - var_8 / var_7;

        if(var_9 > var_2) {
          var_2 = var_9;
        }

        continue;
      }

      thread _id_3589(var_10);
    }

    var_0._id_E3F9 = var_2 * -0.55;
    scripts\mp\weapons::_id_FCCC();
    wait 0.1;
  }
}