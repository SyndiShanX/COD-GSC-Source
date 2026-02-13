/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2044.gsc
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

_id_8AAA() {
  if(istrue(self._id_15AE)) {
    return 0;
  }

  if(!isDefined(level._id_AD0F)) {
    return 0;
  }

  foreach(var_1 in level._id_AD0F) {
    if(!_id_83B3(var_1, self)) {
      continue;
    }
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_89B8(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level._id_AD0F)) {
    return var_2;
  } else {
    foreach(var_4 in level._id_AD0F) {
      if(_func_011A(var_0, var_4)) {
        if(isDefined(var_4._id_CE7D) && isDefined(var_1) && var_4._id_CE7D != var_1) {
          continue;
        } else {
          var_2 = 1;
          break;
        }
      }
    }
  }

  return var_2;
}

_id_824A() {
  thread _id_10BBE();
}

_id_AAC9(var_0) {
  var_1 = undefined;
  var_2 = _id_6AF8(var_0);
  var_3 = _id_6E01(var_0, var_2);

  if(isPlayer(var_0)) {
    var_1 = ::_id_B6A1;
    var_0 playlocalsound("ui_mp_splash_outofbounds");
  } else if(isDefined(var_0._id_ABE8)) {
    var_4 = _id_6BD0();
    var_1 = var_4._id_54CE[var_0._id_ABE8];
  }

  var_0 notify("oob_cooldown_end");

  if(isDefined(var_0._id_ABEA) && _id_BC39(var_0, var_3)) {
    var_5 = var_0._id_ABEA / 1000;
    var_0._id_ABE6 = int(gettime() + var_0._id_ABEA);
    var_0._id_ABEA = undefined;
    thread _id_10BB7(var_0, var_5);
  } else if(isDefined(var_0.oobvehicle) && isDefined(var_0.oobvehicle._id_ABE6) && _id_BC39(var_0.oobvehicle, var_3)) {
    var_6 = var_0.oobvehicle;
    var_5 = (var_6._id_ABE6 - gettime()) / 1000;
    var_0._id_ABE6 = var_6._id_ABE6;
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
    var_0 thread[[var_1]]("exit_oob", "clear_oob", var_3);
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
    var_2 = 1;

    if(level.gametype == "br") {
      if(istrue(level._id_7E6A)) {
        var_2 = 0;
      } else if(isDefined(level._id_9BAA) && level._id_9BAA < 2) {
        var_2 = 0;
      }
    }

    if(var_2) {
      var_1 = ::_id_B733;
    }
  } else if(isDefined(var_0._id_ABE8)) {
    var_3 = _id_6BD0();
    var_1 = var_3._id_AD13[var_0._id_ABE8];
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

_id_B6A1(var_0, var_1, var_2) {
  var_3 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.gametype == "arm" && isDefined(var_2) && var_2 == "restricted") {
    var_3 = 2;
  }

  self setclientomnvar("ui_out_of_bounds_type", var_3);
  self setclientomnvar("ui_out_of_bounds_countdown", self._id_ABE6);
}

_id_B6A5(var_0, var_1, var_2) {
  if(level.gametype == "base") {
    if(isDefined(self._id_41DA) && self._id_41DA.size > 0) {
      if(isDefined(self.base_nebulaoobendtime)) {
        self setclientomnvar("ui_out_of_bounds_type", 4);
        self setclientomnvar("ui_out_of_bounds_countdown", self.base_nebulaoobendtime);
        return;
      }
    }
  }

  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

_id_B733(var_0, var_1) {
  var_2 = _id_6AF8(self);
  var_3 = _id_6E01(self, var_2);

  if(var_3 == "minefield") {
    thread _id_B734(var_0, var_1);
  } else {
    _id_0A8B::_id_0D8A();
  }
}

_id_B679(var_0) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
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

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  var_0 setscriptablepartstate("explosion", "on", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, var_0, "MOD_EXPLOSIVE", "s4_minefield_mp");
  return 1;
}

_id_8DD0(var_0, var_1, var_2) {
  var_3 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.gametype == "arm" && isDefined(var_2) && var_2 == "restricted") {
    var_3 = 2;
  }

  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", var_3);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self._id_ABE6);
  }
}

_id_8DD2(var_0, var_1, var_2) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

_id_8DDF(var_0, var_1) {
  scripts\mp\utility\killstreak::_id_4C56(10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "s4_v2_mp");
}

_id_8DC9() {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
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
  if(scripts\mp\utility\game::_id_98D3() && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "base" && scripts\mp\utility\game::getgametype() != "br") {
    return;
  }
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

  if(scripts\mp\utility\game::getgametype() != "br") {
    _id_07D1::_id_60C2("prematch_done");
  }

  if(!isDefined(var_0)) {
    return;
  }
  thread _id_10BBD(var_0);
  thread _id_10BBC(var_0);
}

_id_10BBC(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1) && (isDefined(var_1._id_2E0E) || isDefined(var_1._id_84E2))) {
      continue;
    }
    if(!_id_83B3(var_0, var_1)) {
      continue;
    }
    if(!_id_83B4(var_1)) {
      continue;
    }
    _id_AACB(var_0, var_1);
  }
}

_id_10BBD(var_0) {
  level endon("game_ended");

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
  _id_07D1::_id_60C2("prematch_done");
  thread _id_10BB9(var_0);
  thread _id_10BBA(var_0);
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

    if(isDefined(var_1)) {
      foreach(var_4, var_3 in var_1) {
        if(!isDefined(var_3)) {
          var_0._id_552B[var_4] = undefined;
        }

        if(isDefined(var_3) && !var_0 istouching(var_3)) {
          _id_AAE1(var_0, var_3);
        }
      }
    }

    waitframe();
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

  var_3 = [var_0];

  foreach(var_5 in var_1._id_ABE9) {
    var_3[var_3.size] = var_5;
  }

  var_1._id_ABE9 = var_3;
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

_id_83B3(var_0, var_1) {
  if(isDefined(var_0._id_CE7D)) {
    if(istrue(level._id_8885)) {
      return 0;
    }

    var_2 = 0;

    if(var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
      var_2 = 1;
    }

    if(var_2) {
      if(var_2 && isDefined(var_1.team) && var_1.team != "neutral" && var_1.team != var_0._id_CE7D) {
        return 0;
      }

      if(var_2 && isDefined(var_1.owner) && var_1.owner.team != var_0._id_CE7D) {
        return 0;
      }

      if(var_2 && isDefined(var_1._id_A924)) {
        foreach(var_4 in var_1._id_A924) {
          if(var_4.team != var_0._id_CE7D) {
            return 0;
          }
        }
      }
    } else if(var_1.team != var_0._id_CE7D)
      return 0;
  }

  return 1;
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
    case "pac_sentry":
    case "radar_drone_recon":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_6E01(var_0, var_1) {
  var_2 = "default";

  if(level.gametype == "br") {
    return "br";
  }

  if(level.gametype == "base") {
    return "base";
  }

  if(isDefined(var_1) && isDefined(var_1._id_CE7D)) {
    return "restricted";
  }

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
    case "restricted":
    case "minefield":
    case "base":
    case "br":
    case "default":
      return scripts\mp\utility\game::_id_6B3E();
  }

  return undefined;
}

_id_6BF0(var_0) {
  switch (var_0) {
    case "minefield":
      return scripts\mp\utility\game::_id_6B3F();
    case "restricted":
      return scripts\mp\utility\game::_id_6B40();
    case "br":
      return scripts\mp\utility\game::_id_6B3D();
    case "base":
      return scripts\mp\utility\game::getarmsraceoutofboundstime();
    case "default":
      return scripts\mp\utility\game::_id_6B41();
  }

  return undefined;
}

_id_6AF8(var_0) {
  if(isDefined(var_0._id_ABEB)) {
    return var_0._id_ABEB[0];
  }

  return undefined;
}

_id_BC39(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0._id_ABEC)) {
    var_3 = var_0._id_ABEC;

    if(var_1 == var_3) {
      var_2 = 1;
    } else if((var_1 == "default" || var_1 == "minefield") && (var_3 == "default" || var_3 == "minefield")) {
      var_2 = 1;
    }
  }

  return var_2;
}