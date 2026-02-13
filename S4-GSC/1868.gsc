/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1868.gsc
*************************************************/

_id_C259(var_0, var_1) {
  var_0._id_ABE8 = var_1;
}

_id_4801(var_0) {
  var_0._id_ABE8 = undefined;
}

_id_C292(var_0, var_1) {
  var_2 = _id_6BD0();
  var_2._id_54CE[var_0] = var_1;
}

_id_C293(var_0, var_1) {
  var_2 = _id_6BD0();
  var_2._id_5777[var_0] = var_1;
}

_id_C294(var_0, var_1) {
  var_2 = _id_6BD0();
  var_2._id_AD13[var_0] = var_1;
}

_id_C291(var_0, var_1) {
  var_2 = _id_6BD0();
  var_2._id_3928[var_0] = var_1;
}

_id_8965(var_0, var_1) {
  if(_id_8966(var_0)) {
    return 0;
  }

  if(istrue(var_1) && _id_8966(var_0)) {
    return 0;
  }

  return isDefined(var_0._id_ABE3) && var_0._id_ABE3 > 0;
}

_id_5261(var_0) {
  if(!isDefined(var_0._id_ABE3)) {
    var_0._id_ABE3 = 0;
  }

  var_0._id_ABE3++;

  if(var_0._id_ABE3 == 1) {
    if(!isDefined(var_0._id_ABE7) || var_0._id_ABE7 <= 0) {
      _id_AAC9(var_0);
    }
  }
}

_id_4AD4(var_0) {
  var_0._id_ABE3--;

  if(var_0._id_ABE3 == 0) {
    var_0._id_ABE3 = undefined;

    if(!isDefined(var_0._id_ABE7) || var_0._id_ABE7 <= 0) {
      _id_AAE0(var_0, 0);
    }
  }
}

_id_8966(var_0) {
  return isDefined(var_0._id_ABE7) && var_0._id_ABE7 > 0;
}

enableoobimmunity(var_0) {
  if(!isDefined(var_0._id_ABE7)) {
    var_0._id_ABE7 = 0;
  }

  var_0._id_ABE7++;

  if(var_0._id_ABE7 == 1) {
    if(isDefined(var_0._id_ABE3) && var_0._id_ABE3 > 0) {
      _id_AAE0(var_0, 0);
    }
  }
}

disableoobimmunity(var_0) {
  var_0._id_ABE7--;

  if(var_0._id_ABE7 == 0) {
    var_0._id_ABE7 = undefined;

    if(isDefined(var_0._id_ABE3) && var_0._id_ABE3 > 0) {
      _id_AAC9(var_0);
    }
  }
}

_id_3964(var_0, var_1) {
  var_0 notify("clear_oob");

  if(_id_8965(var_0, 1)) {
    _id_AAE0(var_0, var_1, 1);
  }

  var_2 = undefined;

  if(isPlayer(var_0)) {
    var_2 = ::_id_B679;
  } else if(isDefined(var_0._id_ABE8)) {
    var_3 = _id_6BD0();
    var_2 = var_3._id_3928[var_0._id_ABE8];
  }

  if(isDefined(var_2)) {
    var_0[[var_2]]();
  }

  var_0._id_ABE8 = undefined;
  var_0._id_ABE3 = undefined;
  var_0._id_ABE7 = undefined;
  var_0._id_ABEA = undefined;
  var_0._id_ABE6 = undefined;
  var_0._id_ABEC = undefined;

  if(isDefined(var_0._id_ABEB)) {
    foreach(var_5 in var_0._id_ABEB) {
      var_5._id_552B[var_0 getentitynumber()] = undefined;
    }

    var_0._id_ABEB = undefined;
  }

  if(isDefined(var_0._id_ABE9)) {
    foreach(var_5 in var_0._id_ABE9) {
      var_5._id_552B[var_0 getentitynumber()] = undefined;
    }

    var_0._id_ABE9 = undefined;
  }
}

_id_824A() {
  if(!isDefined(level._id_AD0F)) {
    level._id_AD0F = [];
  }

  var_0 = getEntArray("OutOfBounds", "targetname");

  foreach(var_2 in var_0) {
    level._id_AD0F[level._id_AD0F.size] = var_2;
  }

  thread _id_10BBE();
}

_id_1069(var_0) {
  if(isDefined(level._id_AD0F)) {
    level._id_AD0F[level._id_AD0F.size] = var_0;
  } else {
    level._id_AD0F[0] = var_0;
  }

  thread _id_10BBB(var_0);
}

_id_AAC9(var_0) {
  var_1 = undefined;
  var_2 = _id_6AF8(var_0);
  var_3 = _id_6E01(var_0, var_2);

  if(isPlayer(var_0)) {
    var_1 = ::_id_B6A1;
  } else if(isDefined(var_0._id_ABE8)) {
    var_4 = _id_6BD0();
    var_1 = var_4._id_54CE[var_0._id_ABE8];
  }

  var_0 notify("oob_cooldown_end");

  if(isDefined(var_0._id_ABEA)) {
    var_5 = var_0._id_ABEA / 1000;
    var_0._id_ABE6 = int(gettime() + var_0._id_ABEA);
    var_0._id_ABEA = undefined;
    thread _id_10BB7(var_0, var_5);
  } else {
    var_0._id_ABEA = undefined;
    var_0._id_ABEC = var_3;
    var_5 = _id_6BF0(var_3);
    var_0._id_ABE6 = int(gettime() + var_5 * 1000);
    thread _id_10BB7(var_0, var_5);
  }

  if(isDefined(var_1)) {
    var_0 thread[[var_1]]("exit_oob", "clear_oob");
  }
}

_id_AAE0(var_0, var_1, var_2) {
  var_0 notify("exit_oob");
  var_3 = undefined;

  if(isPlayer(var_0)) {
    var_3 = ::_id_B6A5;
  } else if(isDefined(var_0._id_ABE8)) {
    var_4 = _id_6BD0();
    var_3 = var_4._id_5777[var_0._id_ABE8];
  }

  var_0 notify("oob_timeout_end");

  if(!istrue(var_2)) {
    if(isDefined(var_0._id_ABE6)) {
      var_0._id_ABEA = int(max(0, var_0._id_ABE6 - gettime()));
      var_0._id_ABE6 = undefined;
      var_5 = _id_6AF8(var_0);
      var_6 = _id_6E01(var_0, var_5);
      var_7 = _id_6982(var_6);
      thread _id_10BB6(var_0, var_7);
    }
  }

  if(isDefined(var_3)) {
    var_0 thread[[var_3]](var_1, var_2, "clear_oob");
  }
}

_id_AB48(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0)) {
    var_1 = ::_id_B733;
  } else if(isDefined(var_0._id_ABE8)) {
    var_2 = _id_6BD0();
    var_1 = var_2._id_AD13[var_0._id_ABE8];
  }

  if(isDefined(var_1)) {
    var_0 thread[[var_1]]("oob_timeout_end", "clear_oob");
  }
}

_id_10BB7(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 endon("death_or_disconnect");
  } else {
    var_0 endon("death");
  }

  var_0 notify("oob_timeout_end");
  var_0 endon("oob_timeout_end");
  var_0 endon("clear_oob");
  wait(var_1);
  thread _id_AB48(var_0);
}

_id_10BB6(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 endon("death_or_disconnect");
  } else {
    var_0 endon("death");
  }

  var_0 notify("oob_cooldown_end");
  var_0 endon("oob_cooldown_end");
  var_0 endon("clear_oob");
  wait(var_1);
  var_0._id_ABEA = undefined;
  var_0._id_ABEC = undefined;
}

_id_B6A1(var_0, var_1) {
  self setclientomnvar("ui_out_of_bounds_countdown", self._id_ABE6);
}

_id_B6A5(var_0, var_1, var_2) {
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

_id_B733(var_0, var_1) {
  var_2 = _id_6AF8(self);
  var_3 = _id_6E01(self, var_2);

  if(var_3 == "minefield") {
    thread _id_B734(var_0, var_1);
  } else {
    self._id_ABE3 = 1;
    self._id_DBD8 = 1;
    self dodamage(self.health + 100, self.origin);
  }
}

_id_B679(var_0) {
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

_id_B734(var_0, var_1) {
  var_2 = self.origin;
  var_3 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(var_3["hittype"] != "hittype_none") && isDefined(var_3["position"])) {
    var_2 = var_3["position"];
  }

  var_4 = spawn("script_model", var_2);
  var_4 setModel("ks_minefield_mp");
  var_4 setentityowner(self);
  var_4 setotherent(self);
  var_4 setscriptablepartstate("warning_click", "on", 0);
  var_5 = _id_B735(var_4, var_0, var_1);

  if(istrue(var_5)) {
    wait 2;
  }

  var_4 delete();
}

_id_B735(var_0, var_1, var_2) {
  self endon("death_or_disconnect");

  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  _id_0733::waitlongdurationwithhostmigrationpause(0.3);
  var_0 setscriptablepartstate("explosion", "on", 0);
  self._id_DBD8 = 1;
  self dodamage(2000, self.origin, self, self, "MOD_EXPLOSIVE", "minefield_mp");
  return 1;
}

_id_8DD0(var_0, var_1) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self._id_ABE6);
  }
}

_id_8DD2(var_0, var_1, var_2) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

_id_8DDF(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_mp");
  }
}

_id_8DC9() {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

_id_8DE1() {
  _id_C292("killstreak", ::_id_8DD0);
  _id_C293("killstreak", ::_id_8DD2);
  _id_C294("killstreak", ::_id_8DDF);
  _id_C291("killstreak", ::_id_8DC9);
}

_id_10BBE() {
  if(isDefined(level._id_AD0F)) {
    foreach(var_1 in level._id_AD0F) {
      thread _id_10BBB(var_1);
    }

    if(isDefined(level._id_AD0E)) {
      foreach(var_1 in level._id_AD0E) {
        thread _id_10BB8(var_1);
      }
    }
  }
}

_id_10BBB(var_0) {
  var_0._id_552B = [];
  thread _id_10BBD(var_0);
  thread _id_10BBC(var_0);
}

_id_10BBC(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      if(isDefined(var_1._id_2E0E)) {
        continue;
      }
      if(istrue(var_1.inlaststand) && !scripts\cp\utility::_id_86C9()) {
        var_1 notify("force_bleed_out");
        continue;
      }
    }

    if(isDefined(var_0._id_CE7D)) {
      var_2 = 0;

      if(var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
        var_2 = 1;
      }

      if(var_2 && isDefined(var_1.owner) && var_1.owner.team != var_0._id_CE7D) {
        continue;
      }
      if(!var_2 && var_1.team != var_0._id_CE7D) {
        continue;
      }
    }

    if(!_id_83B4(var_1)) {
      continue;
    }
    _id_AACB(var_0, var_1);
  }
}

_id_10BBD(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  for(;;) {
    var_1 = var_0._id_552B;

    foreach(var_4, var_3 in var_1) {
      if(!isDefined(var_3)) {
        var_0._id_552B[var_4] = undefined;
      }

      if(isDefined(var_3) && !var_0 istouching(var_3)) {
        _id_AAE2(var_0, var_3);
      }
    }

    waitframe();
  }
}

_id_AACB(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0._id_552B[var_2])) {
    return;
  }
  var_0._id_552B[var_2] = var_1;

  if(!isDefined(var_1._id_ABEB)) {
    var_1._id_ABEB = [];
  }

  var_3 = [var_0];

  foreach(var_5 in var_1._id_ABEB) {
    var_3[var_3.size] = var_5;
  }

  var_1._id_ABEB = var_3;
  _id_5261(var_1);
}

_id_AAE2(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0._id_552B[var_2] = undefined;
  _id_4AD4(var_1);
  var_1._id_ABEB = scripts\engine\utility::array_remove(var_1._id_ABEB, var_0);

  if(var_1._id_ABEB.size == 0) {
    var_1._id_ABEB = undefined;
  }
}

_id_10BB8(var_0) {
  var_0._id_552B = [];
  wait 10;
  thread _id_10BB9();
  thread _id_10BBA();
}

_id_10BBA(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!_id_83B4(var_1)) {
      continue;
    }
    _id_AACA(var_0, var_1);
  }
}

_id_10BB9(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = var_0._id_552B;

    foreach(var_4, var_3 in var_1) {
      if(!isDefined(var_3)) {
        var_0._id_552B[var_4] = undefined;
      }

      if(!var_0 istouching(var_3)) {
        _id_AAE1(var_0, var_3);
      }
    }
  }
}

_id_AACA(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0._id_552B[var_2])) {
    return;
  }
  var_0._id_552B[var_2] = var_1;

  if(!isDefined(var_1._id_ABE9)) {
    var_1._id_ABE9 = [];
  }

  var_1._id_ABE9[var_0 getentitynumber()] = var_0;
  enableoobimmunity(var_1);
}

_id_AAE1(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0._id_552B[var_2] = undefined;
  var_1._id_ABE9[var_0 getentitynumber()] = undefined;

  if(var_1._id_ABE9.size == 0) {
    var_1._id_ABE9 = undefined;
  }

  disableoobimmunity(var_1);
}

_id_83B4(var_0) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        return 1;
      }
    }

    if(isDefined(var_0._id_ABE8)) {
      if(var_0 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
        if(!istrue(var_0._id_87FB)) {
          return 1;
        }
      }

      if(isDefined(var_0.streakinfo) && _id_88EB(var_0.streakinfo.streakname)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_6BD0() {
  var_0 = level._id_ABE5;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0._id_54CE = [];
    var_0._id_5777 = [];
    var_0._id_AD13 = [];
    var_0._id_3928 = [];
    level._id_ABE5 = var_0;
  }

  return var_0;
}

_id_88EB(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "radar_drone_recon":
    case "pac_sentry":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_6E01(var_0, var_1) {
  var_2 = "default";

  if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
    return "default";
  }

  if(isDefined(var_0) && isDefined(var_0.streakinfo)) {
    return "default";
  }

  if(isDefined(var_1) && isDefined(var_1._id_039B) && var_1._id_039B == "MineField") {
    var_2 = "minefield";
  }

  return var_2;
}

_id_6982(var_0) {
  switch (var_0) {
    case "minefield":
      return _id_6B3E();
    case "default":
      return _id_6B3F();
  }

  return undefined;
}

_id_6BF0(var_0) {
  switch (var_0) {
    case "minefield":
      return _id_6B3F();
    case "default":
      return _id_6B41();
  }

  return undefined;
}

_id_6AF8(var_0) {
  if(isDefined(var_0._id_ABEB)) {
    return var_0._id_ABEB[0];
  }

  return undefined;
}

_id_6B41() {
  var_0 = level._id_AD0A;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("#x3d069d6df30e4aa2", 3));
    level._id_AD0A = var_0;
  }

  return var_0;
}

_id_6B3E() {
  var_0 = level._id_AD09;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("#x329497bd766f81f0e", 3));
    level._id_AD09 = var_0;
  }

  return var_0;
}

_id_6B3F() {
  var_0 = level._id_AD0C;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("#x3785af42abd0629c3", 3));
    level._id_AD0C = var_0;
  }

  return var_0;
}