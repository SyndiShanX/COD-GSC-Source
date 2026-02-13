/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_spectate.gsc
*************************************************/

_id_E3E0() {
  level thread _id_FBF2();
}

_id_825B() {
  _id_B67C();
}

_id_691A(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0._id_A4C3)) {
    var_2 = _id_6B90(var_0._id_A4C3);
    var_0._id_A4C3 = undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0 scripts\mp\gametypes\br_gulag::_id_B6B5();
  }

  if(!isDefined(var_2)) {
    var_3 = scripts\mp\utility\teams::_id_6A59(var_0.team);
    var_2 = _id_6915(var_0, var_3);
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.team != var_0.team) {
      if(isalive(var_1) && !istrue(var_1._id_7262) && !istrue(var_1.inlaststand)) {
        var_2 = var_1;
      } else {
        var_4 = scripts\mp\utility\teams::_id_6A59(var_1.team);
        var_2 = _id_6915(var_0, var_4);
      }
    }
  }

  if(!isDefined(var_2) && isPlayer(var_1) && isPlayer(var_1) && var_1 != var_0) {
    var_2 = _id_6B90(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = _id_6915(var_0, level.players);
  }

  return var_2;
}

_id_44D0(var_0, var_1, var_2) {
  var_3 = "player: " + var_0.name + ", candidate: " + var_1.name + ", playersChecked.size: " + var_2.size;
  scripts\mp\utility\script::_id_47BB(var_3);
  var_3 = "";
  var_4 = int(min(var_2.size, 3));
  var_5 = 0;

  foreach(var_7 in var_2) {
    var_3 = var_3 + (" - player: " + var_7.name + ", eliminated: " + istrue(var_7._id_2A63));
    var_5++;

    if(var_5 > var_4) {
      break;
    }
  }

  scripts\mp\utility\script::_id_47BB(var_3);
}

_id_6B90(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = var_0; isDefined(var_3) && !_id_8AED(var_3); var_3 = var_3 _id_B6BB()) {
    var_2++;
    var_4 = var_3 getentitynumber();

    if(var_2 >= 150 || isDefined(var_1[var_4])) {
      _id_44D0(var_0, var_3, var_1);
      return;
    }

    var_1[var_4] = var_3;
  }

  return var_3;
}

_id_6915(var_0, var_1) {
  var_2 = undefined;
  var_3 = [];
  var_4 = [];
  var_5 = [];

  foreach(var_7 in var_1) {
    if(!isDefined(var_7) || !_id_8AED(var_7) || var_7 == var_0) {
      continue;
    }
    if(istrue(var_7._id_7262)) {
      var_4[var_4.size] = var_7;
      continue;
    }

    if(istrue(var_7.inlaststand)) {
      var_5[var_5.size] = var_7;
      continue;
    }

    var_3[var_3.size] = var_7;
  }

  if(var_3.size > 0) {
    var_9 = randomint(var_3.size);
    var_2 = var_3[var_9];
  }

  if(!isDefined(var_2) && var_4.size > 0) {
    var_9 = randomint(var_4.size);
    var_2 = var_4[var_9];
  }

  if(!isDefined(var_2) && var_5.size > 0) {
    var_9 = randomint(var_5.size);
    var_2 = var_5[var_9];
  }

  return var_2;
}

_id_8AED(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::_id_8792("isValidSpectateTarget"))) {
    return scripts\mp\gametypes\br_gametypes::_id_CA24("isValidSpectateTarget", var_0);
  }

  if(!isalive(var_0) && (istrue(var_0._id_7263) || !istrue(var_0._id_7262))) {
    return 0;
  }

  return !istrue(var_0._id_2A63);
}

_id_E310(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0._id_E3E3)) {
    var_1 = var_0._id_E3E3;
    var_0._id_E3E3 = undefined;
  } else {
    var_1.origin = var_0.origin + (0, 0, 100);
    var_1.angles = var_0.angles;
  }

  scripts\mp\playerlogic::_id_E30E(var_1, undefined, 0);
}

_id_E37D(var_0, var_1, var_2) {
  if(scripts\mp\gametypes\br_public::_id_8AB8()) {
    return;
  }
  var_3 = self;
  var_3 _id_E310(var_3);

  if(scripts\mp\gametypes\br_gametypes::_id_8853("teamSpectate")) {
    return;
  }
  thread scripts\mp\gametypes\br_gulag::_id_B7D0();

  if(!istrue(var_2)) {
    var_3 thread _id_F61D();
  }

  var_4 = _id_691A(var_3, var_0.attacker);
  _id_1D25(var_3, var_4);

  if(!istrue(var_3._id_2ABB)) {
    var_3 notify("br_spectatorInitialized");
    var_3._id_2ABB = 1;
  }
}

_id_F61D() {
  self endon("disconnect");
  self endon("br_team_fully_eliminated");
  var_0 = scripts\mp\utility\teams::_id_6A59(self.team, 1);

  if(var_0.size > 0) {
    if(scripts\mp\utility\game::_id_6D9E() != "dmz") {
      thread _id_D4AD();
      wait 0.25;
      self setclientomnvar("ui_br_end_game_splash_type", 5);
      wait 1.0;
      self setclientomnvar("ui_br_end_game_splash_type", 0);
    }
  }
}

_id_D4AD() {
  self endon("disconnect");
  self endon("br_team_fully_eliminated");
  self endon("started_spawnPlayer");

  if(scripts\mp\utility\game::getgametype() != "dmz") {
    _id_1096D(self);

    if(scripts\mp\gametypes\br_public::_id_8A02(self)) {
      return;
    }
    _id_0A99::_id_D5EA(75);

    for(;;) {
      waittillframeend;

      if(isDefined(self._id_B800) && istrue(self._id_B800._id_7262)) {
        waitframe();
        continue;
      }

      _id_0A99::_id_D5EA(75);
      var_0 = scripts\engine\utility::_id_10898("buybackRequested", "br_spectator_end_forced_spectator", "playertospectate_set");

      if(var_0 == "buybackRequested") {
        _id_0A99::_id_D5EA(0);
        wait 10;
      }
    }
  }
}

_id_44D1(var_0, var_1) {
  var_2 = "player: " + var_0.name;

  if(isDefined(var_1)) {
    var_2 = var_2 + (", playerToSpectate: " + var_1.name + ", alive: " + isalive(var_1) + ", eliminated: " + istrue(var_1._id_2A63) + ", gulag: " + istrue(var_1._id_7262));
  }

  scripts\mp\utility\script::_id_47BB(var_2);
  waitframe();
  var_2 = "waitframe - playerToSpectate: " + var_1.name + ", alive: " + isalive(var_1) + ", eliminated: " + istrue(var_1._id_2A63) + ", gulag: " + istrue(var_1._id_7262);
  scripts\mp\utility\script::_id_47BB(var_2);
}

_id_B67C() {
  self._id_BC03 = undefined;
  self._id_A4C3 = undefined;
  self._id_B800 = undefined;
  self setclientomnvar("ui_show_spectateHud", -1);
  self notify("forcePlayerSpectateTarget");
  self notify("playerMonitorSpectatorCycle");
}

_id_5EB7(var_0) {
  if(istrue(level._id_2C3C)) {
    return;
  }
  var_1 = self;
  level endon("brSpawnPlayersEnding");
  var_1 endon("disconnect");
  var_1 notify("forcePlayerSpectateTarget");
  var_1 endon("forcePlayerSpectateTarget");
  var_1._id_BC03 = 1;

  if(var_1.sessionstate != "intermission") {
    var_2 = var_1 _id_B6BB();

    if(istrue(var_2._id_10A14)) {
      var_1 scripts\mp\gametypes\br_gulag::_id_B7AA(1);
      level notify("update_circle_omnvars");
    }

    var_1 _id_E310(var_2);
  }

  if(!isDefined(var_0) || !isPlayer(var_0) || !isalive(var_0) && !isDefined(var_0._id_EA1E)) {
    if(level.gameended || level.players.size == 1) {
      var_1 setclientomnvar("ui_show_spectateHud", var_1 getentitynumber());
      var_1._id_BC03 = undefined;
      return;
    }

    thread _id_44D1(var_1, var_0);
    var_0 = _id_691A(var_1);
  }

  var_0 endon("disconnect");
  var_3 = var_0 getentitynumber();
  var_1._id_B800 = var_0;
  var_1 setclientomnvar("ui_show_spectateHud", var_3);

  if(!var_1 _meth_86A5()) {
    var_1 _meth_86A4();
  }

  var_1 _meth_879F(0.0);
  var_4 = var_0.origin;

  if(isDefined(var_0._id_EA1E)) {
    var_4 = var_0._id_EA1E.origin;
    var_1 _meth_86A3(var_4, 1);
  } else
    var_1 _meth_86A3(var_4, 1, 0, var_0);

  var_1 _meth_8215(var_0);
  var_5 = var_0 getweaponslistprimaries();
  var_1 loadweaponsforplayer(var_5, 1);
  waitframe();
  var_6 = getdvarint("#x3760ea6300f43936d", 2500);
  var_7 = getdvarint("#x3644d327242d8684", 500);
  var_8 = getdvarint("#x34fd07a4f95039db4", 9000);
  var_9 = gettime() + var_7;
  var_10 = gettime() + var_8;

  while((!var_1 _meth_86A5() || !var_1 _meth_81A2(var_0) || !var_1 _meth_851A(var_5)) && gettime() < var_10) {
    if(isDefined(var_0) && !isDefined(var_0._id_EA1E) && gettime() > var_9) {
      var_11 = distance2dsquared(var_0.origin, var_4);

      if(var_11 > var_6) {
        var_4 = var_0.origin;
        var_1 _meth_86A3(var_4, 1, 0, var_0);
        var_9 = gettime() + var_7;
      }
    }

    waitframe();
  }

  var_13 = getdvarint("#x3644d327242d8684", 2000);
  var_10 = gettime() + var_8;
  var_14 = 0;

  while((isDefined(var_0._id_EA1E) || !isalive(var_0)) && gettime() < var_10) {
    if(gettime() > var_14) {
      var_1 _meth_86A3(var_4, 1);
      var_14 = gettime() + var_13;
    }

    waitframe();
  }

  var_1 _id_B6AE(var_0);
  var_1 thread _id_B71F();
  var_1 _meth_86A4();

  if(istrue(var_1._id_10A14)) {
    var_1 scripts\mp\gametypes\br_gulag::_id_B7AA(0);
    level notify("update_circle_omnvars");
  }
}

_id_B6AE(var_0) {
  var_1 = self;
  var_2 = var_0 getentitynumber();
  var_1 scripts\mp\utility\player::_id_FD26("spectator");
  var_1._id_01D2 = var_2;
  var_1 scripts\mp\utility\player::_freezecontrols(0);
  var_1 _meth_87A3(0.0);
  var_1 thread scripts\mp\gametypes\br_gulag::_id_B676();
  var_1 setclientomnvar("ui_show_spectateHud", -1);
  var_3 = var_1 getspectatingplayer();

  while(!isDefined(var_3) || var_2 != var_3 getentitynumber()) {
    waitframe();
    var_3 = var_1 getspectatingplayer();

    if(!isDefined(var_0) || !_id_8AED(var_0)) {
      break;
    }
  }

  var_1 notify("br_spectator_end_forced_spectator");
  var_1._id_01D2 = -1;

  if(isDefined(var_0) && _id_8AED(var_0)) {
    var_1 _meth_8606(var_2, 1);
  }

  var_1._id_BC03 = undefined;
}

_id_1D25(var_0, var_1) {
  var_0 _meth_8013("freelook", 0);
  var_0 _meth_8013("none", 0);
  var_0 _meth_8771(0);

  if(level.teambased && isDefined(var_1)) {
    var_0 _meth_8013(var_1.team, 1);
  }

  var_0 thread _id_5EB7(var_1);
  self notify("playertospectate_set");
}

_id_B71F() {
  self notify("playerMonitorSpectatorCycle");
  self endon("playerMonitorSpectatorCycle");
  self endon("forcePlayerSpectateTarget");
  self endon("disconnect");
  self endon("started_spawnPlayer");

  for(;;) {
    self waittill("spectating_cycle_start", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(var_0 scripts\mp\gametypes\br_gulag::_id_B6E4()) {
      scripts\mp\gametypes\br_gulag::_id_B675();
    }

    var_1 = _id_B816(var_0);
    var_2 = self getspectatingplayer();

    if(!istrue(var_1) || !isDefined(var_2)) {
      _func_0346(self getentitynumber(), 1);

      if(_id_8AED(self._id_B800)) {
        if(!self._id_B800 scripts\mp\gametypes\br_gulag::_id_B6E4()) {
          thread scripts\mp\gametypes\br_gulag::_id_B676();
        }

        _id_B6AE(self._id_B800);
      } else {
        var_0 = _id_691A(self);

        if(!self._id_B800 scripts\mp\gametypes\br_gulag::_id_B6E4()) {
          thread scripts\mp\gametypes\br_gulag::_id_B676();
        }

        _id_1D25(self, var_0);
      }

      continue;
    }

    self._id_B800 = var_0;

    if(var_2 != var_0) {
      self._id_B800 = var_2;
    }

    if(self._id_B800 scripts\mp\gametypes\br_gulag::_id_B6E4()) {
      if(!scripts\mp\gametypes\br_gulag::_id_B6E4()) {
        scripts\mp\gametypes\br_gulag::_id_B675();
      }

      continue;
    }

    thread scripts\mp\gametypes\br_gulag::_id_B676();
  }
}

_id_B816(var_0) {
  var_0 endon("death_or_disconnect");
  self waittill("spectating_cycle");
  return 1;
}

_id_B6BB() {
  var_0 = undefined;

  if(!istrue(self._id_03EB)) {
    var_0 = self getspectatingplayer();
  }

  if(!isDefined(var_0) && isDefined(self._id_A4C3)) {
    var_0 = self._id_A4C3;
  }

  if(!isDefined(var_0) && isDefined(self._id_B800)) {
    var_0 = self._id_B800;
  }

  return var_0;
}

_id_6D6B(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(_id_8AED(var_3)) {
      continue;
    }
    if(!istrue(var_3._id_2ABB)) {
      continue;
    }
    var_4 = var_3 _id_B6BB();

    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_9E8F(var_0, var_1, var_2) {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    return;
  }
  var_3 = _id_691A(var_0, var_1);

  if(var_2 && !istrue(var_0._id_7262)) {
    var_0._id_A4C3 = var_3;
  }

  _id_FC5E(var_0, var_3);
}

_id_FC5E(var_0, var_1) {
  var_2 = _id_6D6B(var_0);

  foreach(var_4 in var_2) {
    if(var_0.team == var_4.team && var_1.team != var_0.team && isDefined(var_0._id_EA1E)) {
      _id_1D25(var_4, var_0);
      continue;
    }

    if(isDefined(var_4._id_A4C3)) {
      var_4._id_A4C3 = var_1;
      continue;
    }

    _id_1D25(var_4, var_1);
  }
}

_id_FBF2() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_3 = var_2 getspectatingplayer();

        if(isDefined(var_3)) {
          var_4 = var_3 getentitynumber();
          var_0[var_4] = ::scripts\mp\gametypes\br::_id_6516(var_0[var_4]) + 1;
        }
      }
    }

    var_6 = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_8 = var_2 getentitynumber();
        var_9 = scripts\mp\gametypes\br::_id_6516(var_0[var_8]);
        var_2 setclientomnvar("ui_br_active_spectators", var_9);
        var_6++;

        if(var_6 % 10 == 0) {
          waitframe();
        }
      }
    }

    wait 1.0;
  }
}

_id_48EE(var_0) {
  level notify("devSpectateTest");
  level endon("devSpectateTest");
  var_1 = _id_6AA6(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [scripts\mp\gametypes\br::_id_4051((-21500, 46200, -300), 0, 6000), scripts\mp\gametypes\br::_id_4051((51000, -39000, 1401), 0, 4000), scripts\mp\gametypes\br::_id_4051((32000, 40000, 767), 0, 5500), scripts\mp\gametypes\br::_id_4051((23000, -15000, -158), 0, 6000)];

  if(level.script != "mp_donetsk") {
    var_2 = undefined;
  }

  if(istrue(level._id_FE76)) {
    foreach(var_4 in level._id_7262._id_1ABF) {
      var_4._id_9BC4 = [];
    }

    level._id_7262._id_1ABF = _func_0204(level._id_7262._id_1ABF, level._id_9AB1[0].origin);
    level._id_7262._id_9CB7 = -1;
    level._id_7262._id_F216 = 15;
    setDvar("#x3f57d34518bd1fb99", 15);
    setDvar("#x3bc3ee3e06e7cf669", 95);
  }

  _id_07D1::_id_60C1("prematch_done");
  level notify("prematch_over");
  level.maxteamsize = 3;
  level._id_2AA8 = 1;
  level._id_EF88 = 1;
  level._id_4AE8 = 0;
  level.ignorescoring = 0;
  setDvar("#x39af27e2257d7e1b3", 1);
  setDvar("#x3e03e0043260c3e7f", 150);
  setDvar("#x3e4aa2b4357caabd3", 150);
  setDvar("#x349af86a1165cf104", -1);
  setDvar("#x38060728dcbd02561", 0);
  setDvar("#x32fba1d6469897c8d", 0);

  foreach(var_7 in level.players) {
    if(var_7 _meth_878F()) {
      var_7 allowmovement(0);
      var_7 allowfire(0);
      var_7 allowmelee(0);
    }

    var_7._id_2A61 = undefined;
    var_7._id_7262 = undefined;
    var_7._id_8B5B = undefined;
    var_7._id_7263 = undefined;
    var_7._id_B800 = undefined;
    var_7._id_A4C3 = undefined;
    var_7._id_727A = undefined;
    var_7._id_7288 = undefined;
    var_7._id_97CC = undefined;
    var_7 notify("gulag_end");
    var_7 notify("last_stand_revived");
    var_7 notify("last_stand_start");
    var_7 _meth_87A3(0.0);
    var_7._id_D6DA = undefined;
  }

  if(!isDefined(level._id_48ED)) {
    level._id_48ED = [];
  }

  if(!isDefined(level._id_48EB)) {
    for(var_9 = 0; var_9 < level._id_EF89.size; var_9++) {
      var_10 = level._id_EF89[var_9];

      if(var_10 != var_1.team) {
        if(!isDefined(level._id_48EB)) {
          level._id_48EB = var_10;
          continue;
        }

        level._id_48EC = var_10;
        break;
      }
    }
  }

  _id_C7EC(var_1, var_1.team);
  _id_C7EC(var_1, level._id_48EB);
  _id_C7EC(var_1, level._id_48EC);
  var_11 = _id_6DDC(var_1, var_1.team);
  var_12 = _id_6DDC(var_1, level._id_48EB);
  var_13 = _id_6DDC(var_1, level._id_48EC);

  if(isDefined(var_2)) {
    for(var_9 = 0; var_9 < var_11.size; var_9++) {
      var_14 = var_11[var_9];
      var_15 = var_12[var_9];
      var_16 = var_13[var_9];
      var_17 = var_2[var_9];
      var_18 = 0;
      var_14 _id_B7F6(var_17, var_18);
      var_18++;
      var_15 _id_B7F6(var_17, var_18);
      var_18++;
      var_16 _id_B7F6(var_17, var_18);
    }
  }

  level._id_4AE8 = 1;
  var_1 iprintlnbold("Test ready");
  wait 2;

  if(_id_1B10(var_0, "killcam1") || _id_1B10(var_0, "killchain") || _id_1B10(var_0, "disconnect1") || _id_1B10(var_0, "disconnect2") || _id_1B10(var_0, "disconnect3")) {
    _id_8D92(var_1, var_1, var_12);

    if(_id_1B10(var_0, "disconnect2")) {
      while(var_1.sessionstate != "intermission") {
        waitframe();
      }

      while(var_1.sessionstate == "intermission") {
        waitframe();
      }
    } else if(_id_1B10(var_0, "disconnect3")) {
      while(var_1.sessionstate != "intermission") {
        waitframe();
      }

      wait 0.5;
    } else {
      _id_1096D(var_1);
      wait 3;

      if(_id_1B10(var_0, "disconnect1")) {
        var_1 iprintlnbold("Waiting");
        wait 10;
      }
    }
  }

  if(_id_1B10(var_0, "disconnect1") || _id_1B10(var_0, "disconnect2") || _id_1B10(var_0, "disconnect3")) {
    var_19 = var_1 _id_B6BB();
    kick(var_19 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(_id_1B10(var_0, "killchain")) {
    for(var_19 = var_1 _id_B6BB(); !isDefined(var_19); var_19 = var_1 _id_B6BB()) {
      waitframe();
    }

    _id_8D92(var_1, var_19, var_12);
    _id_1096D(var_1);
    wait 3;
  }

  if(_id_1B10(var_0, "killchain")) {
    for(var_19 = var_1 _id_B6BB(); !isDefined(var_19); var_19 = var_1 _id_B6BB()) {
      waitframe();
    }

    _id_8D92(var_1, var_19, var_12);
    _id_1096D(var_1);
    wait 3;
  }

  if(_id_1B10(var_0, "killchain")) {
    for(var_19 = var_1 _id_B6BB(); !isDefined(var_19); var_19 = var_1 _id_B6BB()) {
      waitframe();
    }

    _id_8D92(var_1, var_19, var_13);
    _id_1096D(var_1);
    wait 3;
  }

  if(_id_1B10(var_0, "killchain")) {
    for(var_19 = var_1 _id_B6BB(); !isDefined(var_19); var_19 = var_1 _id_B6BB()) {
      waitframe();
    }

    _id_8D92(var_1, var_19, var_13);
    _id_1096D(var_1);
    wait 3;
  }

  if(_id_1B10(var_0, "killchain")) {
    for(var_19 = var_1 _id_B6BB(); !isDefined(var_19); var_19 = var_1 _id_B6BB()) {
      waitframe();
    }

    _id_8D92(var_1, var_19, var_13);
    _id_1096D(var_1);
    wait 3;
  }

  if(_id_1B10(var_0, "gulag1")) {
    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        var_7._id_2A61 = 1;
        _id_8D92(var_1, var_7, var_12);
      }
    }

    wait 10;
    _id_8D92(var_1, var_1, var_12);
  }

  if(_id_1B10(var_0, "gulag2") || _id_1B10(var_0, "gulag3")) {
    _id_8D92(var_1, var_1, var_12);
    var_1 waittill("killcam_ended");
    wait 2;

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        var_7._id_2A61 = 1;
        _id_8D92(var_1, var_7, var_12);
      }
    }

    while(!isDefined(var_1 getspectatingplayer())) {
      waitframe();
    }

    var_24 = var_1 getspectatingplayer();
    var_24._id_2A61 = 1;
    wait 1;

    foreach(var_7 in var_12) {
      var_7._id_2A61 = 1;
      _id_8D92(var_1, var_7, var_13);
    }

    while(!istrue(var_24._id_7263)) {
      waitframe();
    }

    wait 5;

    if(_id_1B10(var_0, "gulag2")) {
      var_27 = spawnStruct();
      var_27._id_B7D1 = (26474, -16709, -162);
      var_27._id_B7CB = (85, 135, 0);
      var_24._id_D6DA = var_27;

      foreach(var_7 in var_12) {
        if(istrue(var_7._id_7263)) {
          var_7._id_2A61 = 1;
          _id_8D92(var_1, var_7, var_13);
          break;
        }
      }

      while(!var_24 _meth_81CC()) {
        waitframe();
      }

      while(var_24 _meth_81CC()) {
        waitframe();
      }

      waitframe();
      var_30 = var_24 getplayerangles();
      var_24 setplayerangles((85, var_30[1], 0));
    } else
      _id_8D92(var_1, var_24, var_13);
  }

  if(_id_1B10(var_0, "gulag4")) {
    var_1._id_2A61 = 1;
    var_31 = _id_8D92(var_1, var_1, var_12);
    var_31._id_2A61 = 1;
    _id_8D92(var_1, var_31, var_11);
  }

  if(_id_1B10(var_0, "gulaggulag")) {
    var_32 = getdvarint("#x33e12e7ef3c23657c", 0);
    var_33 = getdvarint("#x33e12eaef3c236c15", 5);
    setDvar("#x3bc3ee3e06e7cf669", 9999);
    setDvar("#x349af86a1165cf104", var_32);
    var_1._id_2A61 = 1;
    var_31 = _id_8D92(var_1, var_1, var_12);
    setDvar("#x349af86a1165cf104", var_33);

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        var_7._id_2A61 = 1;
        _id_8D92(var_1, var_7, var_12);
      }
    }

    setDvar("#x349af86a1165cf104", var_32);
    var_31._id_2A61 = 1;
    _id_8D92(var_1, var_31, var_13);

    while(!istrue(var_1._id_7263) && !istrue(var_31._id_7263)) {
      waitframe();
    }

    wait 5;
    _id_8D92(var_1, var_1, undefined, var_31);
    setDvar("#x3bc3ee3e06e7cf669", 90);
  }

  if(_id_1B10(var_0, "killkill")) {
    var_31 = var_12[0];

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        _id_8D92(var_1, var_7, undefined, var_31);
      }
    }

    _id_8D92(var_1, var_31, undefined, var_1);
    wait 10;
    _id_8D92(var_1, var_1, undefined, var_31);
  }

  if(_id_1B10(var_0, "killcam2")) {
    var_31 = _id_8D92(var_1, var_1, var_12);
    wait 3;
    _id_8D92(var_1, var_1._id_A4C3, var_12);
  }

  if(_id_1B10(var_0, "gulag5") || _id_1B10(var_0, "gulag6")) {
    var_38 = undefined;

    foreach(var_7 in var_11) {
      if(!isDefined(var_38) && var_7 != var_1) {
        var_38 = var_7;
        continue;
      }

      _id_8D92(var_1, var_7, var_12);
      _id_1096D(var_7);
    }

    var_38._id_2A61 = 1;

    if(_id_1B10(var_0, "gulag6")) {
      setDvar("#x3bc3ee3e06e7cf669", 9999);
      var_32 = getdvarint("#x33e12e7ef3c23657c", 5);
      setDvar("#x349af86a1165cf104", var_32);
      var_38._id_97CC = 1;
    }

    _id_8D92(var_1, var_38, var_12);
  }

  if(_id_1B10(var_0, "gulag7")) {
    _id_8D92(var_1, var_1, var_12);
    var_1 waittill("killcam_ended");
    wait 2;
    var_41 = undefined;

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        var_7._id_2A61 = 1;
        var_41 = var_7;
        var_41 scripts\mp\gametypes\br_gulag::_id_8265();
        break;
      }
    }

    while(!isDefined(var_1 getspectatingplayer())) {
      waitframe();
    }

    wait 1;
    var_44 = undefined;

    foreach(var_7 in var_12) {
      var_7._id_2A61 = 1;
      var_44 = var_7;
      _id_8D92(var_1, var_7, var_13);
      break;
    }

    while(!istrue(var_41._id_7263) && !istrue(var_44._id_7263)) {
      waitframe();
    }

    wait 5;
    setDvar("#x32fba1d6469897c8d", 1);
    _id_8D92(var_1, var_44, undefined, var_41);

    while(var_1 getspectatingplayer() != var_41) {
      wait 1;
    }

    wait 5;
    setDvar("#x32fba1d6469897c8d", 0);
  }

  if(_id_1B10(var_0, "gulag8")) {
    level._id_7262._id_F216 = 3;
    setDvar("#x3f57d34518bd1fb99", 3);
    setDvar("#x3bc3ee3e06e7cf669", -1);
    _id_8D92(var_1, var_1, var_12);
    var_1 waittill("killcam_ended");
    wait 2;
    var_41 = undefined;

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        var_7._id_2A61 = 1;
        var_41 = var_7;
        var_41 scripts\mp\gametypes\br_gulag::_id_8265();
        break;
      }
    }

    while(!isDefined(var_1 getspectatingplayer())) {
      waitframe();
    }

    while(var_1 getspectatingplayer() != var_41) {
      iprintlnbold("Switch to spectating gulag player");
      waitframe();
    }

    wait 1;
    var_44 = undefined;

    foreach(var_7 in var_12) {
      var_7._id_2A61 = 1;
      var_44 = var_7;
      _id_8D92(var_1, var_7, var_13);
      break;
    }
  }

  if(_id_1B10(var_0, "twooneframe")) {
    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        _id_8D92(var_1, var_7, var_12);
        break;
      }
    }

    wait 5;

    foreach(var_7 in var_11) {
      if(isalive(var_7)) {
        _id_8D93(var_1, var_7, var_12);
      }
    }
  }

  if(_id_1B10(var_0, "suicide")) {
    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        _id_8D92(var_1, var_7, var_12);
      }
    }

    wait 5;

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
    }

    var_1 suicide();
  }

  if(_id_1B10(var_0, "team")) {
    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        _id_8D93(var_1, var_7, var_12);
      }
    }
  }

  if(_id_1B10(var_0, "moving")) {
    _id_8D93(var_1, var_1, var_12);

    while(!isDefined(var_1._id_B800)) {
      waitframe();
    }

    var_7 = var_1._id_B800;
    var_59 = anglesToForward(var_7.angles);
    var_60 = getdvarint("#x339d7951022433e7d", 5);

    for(var_61 = var_1 getspectatingplayer(); !isDefined(var_61); var_61 = var_1 getspectatingplayer()) {
      var_62 = var_7.origin + var_59 * var_60;
      var_7 setorigin(var_62);
      waitframe();
    }
  }

  if(_id_1B10(var_0, "heli1") || _id_1B10(var_0, "heli2")) {
    var_24 = undefined;

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        if(!isDefined(var_24)) {
          var_24 = var_7;
          continue;
        }

        _id_8D93(var_1, var_7, var_12);
      }
    }

    wait 1;
    _id_8D93(var_1, var_1, var_12);
    _id_1096D(var_1);
    wait 1;
    var_65 = getarraykeys(level.vehicle._id_8300["little_bird"]);
    var_66 = level.vehicle._id_8300["little_bird"][var_65[0]];
    var_67 = var_66 _meth_86EB();
    var_24 setorigin(var_66.origin);
    wait 1;
    _id_09E1::_id_10109(var_67, "single", "vehicle_use", var_24, 0);

    if(_id_1B10(var_0, "heli2")) {
      wait 3;
      kick(var_24 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
    }
  }

  if(_id_1B10(var_0, "water")) {
    var_1 setorigin((28252, -32627, -415));
  }

  if(_id_1B10(var_0, "disconnectswitch1")) {
    _id_8D93(var_1, var_1, var_12);
    _id_1096D(var_1);
    var_24 = var_1 _id_B6BB();

    while(!var_1 _meth_805E("BUTTON_RSHLDR")) {
      waitframe();
    }

    var_68 = undefined;

    foreach(var_7 in var_11) {
      if(var_7 != var_1 && var_7 != var_24) {
        var_68 = var_7;
        break;
      }
    }

    wait 0.5;
    kick(var_68 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(_id_1B10(var_0, "disconnectswitch2")) {
    _id_8D93(var_1, var_1, var_12);
    _id_1096D(var_1);
    var_24 = var_1 _id_B6BB();

    while(!var_1 _meth_805E("BUTTON_RSHLDR")) {
      waitframe();
    }

    wait 0.5;
    kick(var_24 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
  }

  if(_id_1B10(var_0, "endspectate")) {
    level._id_2A60 = 1;
    setDvar("#x3e03e0043260c3e7f", 2);
    level._id_7262._id_9CB7 = 0;
    wait 1;
    _id_8D93(var_1, var_1, var_12);
    _id_1096D(var_1);
    wait 2;

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        _id_8D93(var_1, var_7, var_12);
      }
    }

    _id_1096D(var_1);
    wait 2;
    var_31 = var_1 _id_B6BB();
    _id_8D93(var_1, var_31, var_13);
    _id_1096D(var_1);
    wait 2;
    var_31 = var_1 _id_B6BB();
    _id_8D93(var_1, var_31, var_13);
    _id_1096D(var_1);
    wait 2;
    var_31 = var_1 _id_B6BB();
    _id_8D93(var_1, var_31, var_13);
    _id_1096D(var_1);
    wait 2;
  }

  if(_id_1B10(var_0, "teamwipe")) {
    setDvar("#x38060728dcbd02561", 5);

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        _id_8D93(var_1, var_7, var_12);
      }
    }

    wait(getdvarfloat("#x3c226a568b8f6841f", 5));
    var_31 = _id_8D93(var_1, var_1, var_12);
    wait(getdvarfloat("#x3f181f24ec624aef7", 13));
    _id_8D93(var_1, var_31, var_13);
  }

  if(_id_1B10(var_0, "deathswitch1")) {
    setDvar("#x38060728dcbd02561", 5);
    _id_8D93(var_1, var_1, var_12);
    _id_1096D(var_1);
    var_24 = var_1 _id_B6BB();

    while(!var_1 _meth_805E("BUTTON_RSHLDR")) {
      waitframe();
    }

    var_68 = undefined;

    foreach(var_7 in var_11) {
      if(var_7 != var_1 && var_7 != var_24) {
        var_68 = var_7;
        break;
      }
    }

    wait 0.5;
    _id_8D93(var_1, var_68, var_12);
  }

  if(_id_1B10(var_0, "squadwidget")) {
    setDvar("#x3bc3ee3e06e7cf669", 9999);
    setDvar("#x38060728dcbd02561", 3);

    foreach(var_7 in var_11) {
      if(var_7 != var_1) {
        kick(var_7 getentitynumber(), "EXE/PLAYERKICKED_BOT_BALANCE");
      }
    }

    wait 5;
    var_79 = var_12[0];
    var_80 = var_12[1];
    var_79._id_2A61 = 1;
    _id_8D93(var_1, var_79, undefined, var_1);
    wait(getdvarfloat("#x34ef699e11efe2a91", 4));
    _id_8D93(var_1, var_1, undefined, var_80);
  }
}

_id_B7F6(var_0, var_1) {
  var_2 = self getentitynumber();

  if(isDefined(level._id_48ED[var_2])) {
    var_0 = level._id_48ED[var_2];
  } else {
    level._id_48ED[var_2] = var_0;
  }

  if(self _meth_878F()) {
    self allowmovement(0);
    self allowfire(0);
    self allowmelee(0);
  }

  var_3 = anglesToForward((0, 0, 0));
  var_4 = var_0.origin + var_3 * (var_1 * 50);
  var_5 = getgroundposition(var_4, 15, 100);
  self setorigin(var_5);
  self setplayerangles((0, 0, 0));
}

_id_8D92(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = _id_6B70(var_0, var_1.origin, var_2);
  }

  var_1 dodamage(500, var_3.origin, var_3, undefined, "MOD_EXPLOSIVE", var_3 getcurrentprimaryweapon());
  wait 1;

  while(isalive(var_1)) {
    var_1 dodamage(500, var_3.origin, var_3, undefined, "MOD_EXPLOSIVE", var_3 getcurrentprimaryweapon());
    waitframe();
  }

  return var_3;
}

_id_8D93(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = _id_6B70(var_0, var_1.origin, var_2);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var_1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
  }

  var_1 dodamage(500, var_3.origin, var_3, undefined, "MOD_EXPLOSIVE", var_3 getcurrentprimaryweapon());
  return var_3;
}

_id_1096D(var_0) {
  while(var_0.sessionstate != "intermission") {
    waitframe();
  }

  while(var_0.sessionstate == "intermission") {
    waitframe();
  }

  while(var_0.sessionstate != "spectator") {
    waitframe();
  }
}

_id_6B70(var_0, var_1, var_2) {
  var_2 = _func_0204(var_2, var_1);

  if(isalive(var_2[0])) {
    var_3 = distance2dsquared(var_1, var_2[0].origin);

    if(var_3 < 40000) {
      return var_2[0];
    }
  }

  var_4 = undefined;

  for(var_5 = 1; var_5 < var_2.size; var_5++) {
    var_6 = var_2[var_5];

    if(isalive(var_6)) {
      var_4 = var_6;
      break;
    }
  }

  return var_4;
}

_id_6AA6(var_0) {
  if(isDefined(level._id_48EF)) {
    return level._id_48EF;
  }

  var_1 = scripts\mp\gamelogic::_id_6AA7();

  if(_id_1B10(var_0, "clientHost")) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && !var_3 _meth_878F() && (!isDefined(var_1) || var_3 != var_1)) {
        var_1 = var_3;
        break;
      }
    }
  } else if(!isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && !var_3 _meth_878F()) {
        level._id_48EF = var_3;
        var_1 = var_3;
        break;
      }
    }
  } else
    level.maxteamsize = 3;

  if(!isDefined(level._id_48EF)) {
    level._id_48EF = var_1;
  }

  return var_1;
}

_id_1B10(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_C7EC(var_0, var_1) {
  var_2 = level._id_EF6A[var_1]["players"];
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!isalive(var_5) || var_5.sessionstate != "playing") {
      var_6 = var_5 getentitynumber();

      if(isDefined(level._id_48ED[var_6])) {
        var_5._id_5EC2 = (0, 0, 0);
        var_5._id_5EC7 = level._id_48ED[var_6].origin;
      } else {
        var_5._id_5EC2 = var_5.angles;
        var_5._id_5EC7 = var_5.origin;
      }

      var_5 _id_E287(0);
      var_3 = 1;
    }

    var_5._id_2A63 = undefined;
  }

  if(var_3) {
    var_0 iprintlnbold("Reviving Team: " + var_1);
    wait 1.0;
  }
}

_id_6DDC(var_0, var_1) {
  var_2 = 0;

  if(level._id_EF6A[var_1]["teamCount"] < level.maxteamsize) {
    var_2 = level.maxteamsize - level._id_EF6A[var_1]["teamCount"];
  }

  if(var_2 > 0) {
    level._id_9FEF = ::_id_E287;
    var_3 = level.players.size;
    addbots(var_2, var_1);
    var_0 iprintlnbold("Spawning Team: " + var_1);
    var_4 = gettime() + 10000;

    while(gettime() < var_4 && level._id_EF6A[var_1]["aliveCount"] < level.maxteamsize) {
      waitframe();
    }

    level._id_9FEF = scripts\mp\gametypes\br::_id_E286;
  }

  return level._id_EF6A[var_1]["alivePlayers"];
}

addbots(var_0, var_1) {
  setDvar("#x35bffc5ddc328f85b", "1");

  if(!isDefined(var_1)) {
    var_1 = "autoassign";
  }

  level thread[[level._id_279D["bots_spawn"]]](var_0, var_1);

  if(level.matchmakingmatch) {
    setmatchdata("hasBots", 1);
  }
}

_id_E287(var_0) {
  self.class = scripts\mp\gametypes\br::_id_B074();
  self.pers["class"] = self.class;
  scripts\mp\playerlogic::_id_E337(undefined, 0);
  self freezecontrols(1);
  waitframe();
  self _meth_86B2(0);
  self _meth_86B3(0);
  var_1 = !self _meth_878F();

  if(var_1) {
    while(isalive(self) && isDefined(self.weaponlist) && !self _meth_851A(self.weaponlist)) {
      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self._id_10849 = 0;
  self freezecontrols(0);
}