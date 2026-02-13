/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2552.gsc
*************************************************/

_id_2822(var_0, var_1, var_2, var_3) {
  self endon("bot_sentry_exited");
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));

  while(isDefined(self._id_D0E7) && gettime() < self._id_D0E7) {
    wait 1;
  }

  if(isDefined(self._id_0192) && self._id_0192.health > 0 && self _meth_8028(self._id_0192)) {
    return 1;
  }

  var_4 = self.origin;

  if(var_3 != "hide_nonlethal") {
    var_4 = _id_28BB(var_3);

    if(!isDefined(var_4)) {
      return 1;
    }
  }

  _id_28B6(var_0, var_4, var_3, var_1);

  while(_id_09F9::_id_27ED("sentry_placement")) {
    wait 0.5;
  }

  return 1;
}

_id_28B6(var_0, var_1, var_2, var_3) {
  var_4 = _id_28BA(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    _id_09F9::_id_26EF("sentry_placement");
    var_5 = spawnStruct();
    var_5._id_A860 = var_4;
    var_5._id_CD74 = var_4._id_10FE6;
    var_5._id_CD72 = 10;
    var_5._id_E656 = ::_id_28BE;
    var_5._id_52CD = ::_id_28B7;
    var_5._id_DA6E = ::_id_28C0;
    var_5._id_0E86 = ::_id_28B5;
    self._id_B181 = var_0.streakname;
    _id_09F9::_id_2862("sentry_placement", var_4._id_02ED.origin, 0, var_5);
  }
}

_id_28C0(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self._id_0192) && self._id_0192.health > 0 && self _meth_8028(self._id_0192)) {
    return 1;
  }

  self._id_D0E7 = gettime() + 1000;
  return 0;
}

_id_28B8() {
  self endon("death_or_disconnect");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_ensure_exit");
  level endon("game_ended");

  for(;;) {
    if(isDefined(self._id_0192) && self._id_0192.health > 0 && self _meth_8028(self._id_0192)) {
      thread _id_28B7();
    }

    wait 0.05;
  }
}

_id_28BE(var_0) {
  thread _id_28BF(var_0);
}

_id_28BF(var_0) {
  self endon("stop_tactical_goal");
  self endon("stop_goal_aborted_watch");
  self endon("bot_sentry_canceled");
  self endon("bot_sentry_exited");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(isDefined(var_0._id_A860) && isDefined(var_0._id_A860._id_04F6)) {
    if(distance2d(self.origin, var_0._id_A860._id_02ED.origin) < 400) {
      thread scripts\mp\bots\bots_util::_id_279B("stand", 5.0);
      thread _id_28B8();
      _id_09F4::_id_28F0(var_0._id_A860._id_8DB4, var_0._id_A860._id_8DE3, var_0._id_A860._id_04F6);
      return;
    }

    wait 0.05;
  }
}

_id_28BB(var_0) {
  var_1 = scripts\mp\bots\bots_util::_id_45E3();

  if(isDefined(var_1)) {
    return var_1;
  }

  if(isDefined(self._id_A54D)) {
    return self._id_A54D.origin;
  }

  var_2 = _func_00B4(self.origin, 1000, 0, 512);
  var_3 = 5;

  if(var_0 != "turret") {
    if(self _meth_8030("strategyLevel") == 1) {
      var_3 = 10;
    } else if(self _meth_8030("strategyLevel") == 0) {
      var_3 = 15;
    }
  }

  if(var_0 == "turret_air") {
    var_4 = self _meth_8049(var_2, var_3, "node_traffic", "ignore_no_sky");
  } else {
    var_4 = self _meth_8049(var_2, var_3, "node_traffic");
  }

  if(isDefined(var_4)) {
    return var_4.origin;
  }
}

_id_28BA(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = _func_00B4(var_1, 1000, 0, 512);
  var_6 = 5;

  if(var_2 != "turret") {
    if(self _meth_8030("strategyLevel") == 1) {
      var_6 = 10;
    } else if(self _meth_8030("strategyLevel") == 0) {
      var_6 = 15;
    }
  }

  if(var_2 == "turret_air") {
    var_7 = self _meth_8049(var_5, var_6, "node_sentry", var_1, "ignore_no_sky");
  } else if(var_2 == "trap") {
    var_7 = self _meth_8049(var_5, var_6, "node_traffic");
  } else if(var_2 == "hide_nonlethal") {
    var_7 = self _meth_8049(var_5, var_6, "node_hide");
  } else {
    var_7 = self _meth_8049(var_5, var_6, "node_sentry", var_1);
  }

  if(isDefined(var_7)) {
    var_4 = spawnStruct();
    var_4._id_02ED = var_7;

    if(var_1 != var_7.origin && var_2 != "hide_nonlethal") {
      var_4._id_10FE6 = _func_0261(var_1 - var_7.origin);
    } else {
      var_4._id_10FE6 = undefined;
    }

    var_4._id_04F6 = var_0._id_04F6;
    var_4._id_8DB4 = var_0;
    var_4._id_8DE3 = var_3;
  }

  return var_4;
}

_id_28B9() {
  if(isDefined(self._id_32D2)) {
    return self._id_32D2;
  }

  if(isDefined(self._id_32CC)) {
    return self._id_32CC;
  }

  if(isDefined(self._id_32CD)) {
    return self._id_32CD;
  }
}

_id_28B5(var_0) {
  var_1 = 0;
  var_2 = _id_28B9();

  if(isDefined(var_2)) {
    var_3 = 0;

    if(!var_2._id_314C) {
      var_4 = 0.75;
      var_5 = gettime();
      var_6 = self.angles[1];

      if(isDefined(var_0._id_A860._id_10FE6)) {
        var_6 = var_0._id_A860._id_10FE6;
      }

      var_7 = [];
      var_7[0] = var_6 + 180;
      var_7[1] = var_6 + 135;
      var_7[2] = var_6 - 135;
      var_8 = 1000;

      foreach(var_10 in var_7) {
        var_11 = _func_019A(var_0._id_A860._id_02ED.origin, var_0._id_A860._id_02ED.origin + anglesToForward((0, var_10 + 180, 0)) * 100);
        var_12 = distance2d(var_11, var_0._id_A860._id_02ED.origin);

        if(var_12 < var_8) {
          var_8 = var_12;
          self _meth_805A(var_10, var_4);
          self _meth_8045(var_0._id_A860._id_02ED.origin, var_4, "script_forced");
        }
      }

      while(!var_3 && isDefined(var_2) && !var_2._id_314C) {
        var_14 = float(gettime() - var_5) / 1000.0;

        if(!var_2._id_314C && var_14 > var_4) {
          var_3 = 1;
          self._id_D0E7 = gettime() + 30000;
        }

        wait 0.05;
      }
    }

    if(isDefined(var_2) && var_2._id_314C) {
      _id_28B4();
      var_1 = 1;
    }
  }

  wait 0.25;
  _id_28BC();
  return var_1;
}

_id_28B4() {
  self notify("place_sentry");
  self notify("place_ims");
  self notify("placePlaceable");
}

_id_28B3() {
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
  self notify("cancel_sentry");
  self notify("cancel_ims");
  self notify("cancelPlaceable");
}

_id_28B7(var_0) {
  self notify("bot_sentry_canceled");
  _id_28B3();
  _id_28BC();
}

_id_28BC() {
  self notify("bot_sentry_abort_goal_think");
  self notify("bot_sentry_ensure_exit");
  self endon("bot_sentry_ensure_exit");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self switchtoweapon("none");
  self _meth_802B();
  self _meth_805B("none");
  self enableweapons();
  self enableweaponswitch();
  wait 0.25;
  var_0 = 0;

  while(isDefined(_id_28B9())) {
    var_0++;
    _id_28B3();
    wait 0.25;

    if(var_0 > 2) {
      _id_28BD();
    }
  }

  self notify("bot_sentry_exited");
}

_id_28BD() {
  if(isDefined(self._id_32D2)) {
    self._id_32D2 _id_0A35::_id_D0E9();
  }

  if(isDefined(self._id_32CD)) {
    self._id_32CD _id_0A58::_id_AA7E(self._id_B181, 0);
  }

  self._id_32D2 = undefined;
  self._id_32CC = undefined;
  self._id_32CD = undefined;
  self switchtoweapon("none");
  self enableweapons();
  self enableweaponswitch();
}