/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_util.gsc
***********************************************/

_id_19FA(var_0, var_1, var_2, var_3) {
  var_4 = _getnodesinradius(self.origin, var_1, var_0);
  var_5 = [];
  var_6 = self getnearestnode();
  var_7 = anglesToForward(self getplayerangles());
  var_8 = vectorNormalize(var_7 * (1, 1, 0));

  foreach(var_10 in var_4) {
    var_11 = vectorNormalize((var_10.origin - self.origin) * (1, 1, 0));
    var_12 = vectordot(var_11, var_8);

    if(var_12 > var_2) {
      if(!var_3 || isDefined(var_6) && _nodesvisible(var_10, var_6, 1))
        var_5[var_5.size] = var_10;
    }
  }

  return var_5;
}

_id_1A0B(var_0, var_1) {
  if(var_0 == "none")
    return var_1 == "none";
  else if(var_0 == "hunt")
    return var_1 == "hunt" || var_1 == "none";
  else if(var_0 == "guard")
    return var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  else if(var_0 == "objective")
    return var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  else if(var_0 == "critical")
    return var_1 == "critical" || var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  else if(var_0 == "tactical")
    return 1;
}

_id_1AD5(var_0) {
  self botsetpersonality(var_0);
  maps\mp\bots\_bots_personality::_id_1939();
  self botclearscriptgoal();
}

bot_set_difficulty(var_0, var_1) {
  if(var_0 == "default")
    var_0 = _id_1974();

  var_3 = self botgetdifficulty();
  self botsetdifficulty(var_0);

  if(isPlayer(self) && var_3 != var_0) {
    maps\mp\_utility::_id_8568();
    var_4 = maps\mp\gametypes\_rank::getrankforxp(maps\mp\gametypes\_rank::getrankxp());
    self.pers["rank"] = var_4;
    var_5 = self.pers["prestige"];
    self setrank(var_4, var_5);
  }
}

_id_1974() {
  if(!isDefined(level._id_19AE)) {
    level._id_19AE = [];
    level._id_19AE[level._id_19AE.size] = "easy";
    level._id_19AE[level._id_19AE.size] = "normal";
    level._id_19AE[level._id_19AE.size] = "hard";
  }

  if(!isDefined(level._id_1A86))
    level._id_1A86 = [];

  if(!isDefined(level._id_1A86["allies"]))
    level._id_1A86["allies"] = 0;

  if(!isDefined(level._id_1A86["axis"]))
    level._id_1A86["axis"] = 0;

  if(!isDefined(level._id_1A86["all"]))
    level._id_1A86["all"] = 0;

  if(!isDefined(self.pers["bot_chosen_difficulty"])) {
    var_0 = undefined;

    if(level.teambased) {
      var_1 = self.team;

      if(!isDefined(var_1))
        var_1 = self._id_1AFA;

      if(!isDefined(var_1))
        var_1 = self.pers["team"];
    } else
      var_1 = "all";

    var_0 = level._id_1A86[var_1];
    var_2 = level._id_19AE[var_0];
    self.pers["bot_chosen_difficulty"] = _id_4151(var_2);
    level._id_1A86[var_1] = (level._id_1A86[var_1] + 1) % level._id_19AE.size;
  }

  return self.pers["bot_chosen_difficulty"];
}

_id_4151(var_0) {
  if(var_0 == "easy")
    return "recruit";
  else if(var_0 == "normal")
    return "regular";
  else if(var_0 == "hard")
    return common_scripts\utility::random(["hardened", "veteran"]);
  else {}
}

_id_1A28() {
  if(_id_1A2D()) {
    if(self._id_19AC == "capture" || self._id_19AC == "capture_zone")
      return 1;
  }

  return 0;
}

_id_1A32() {
  if(_id_1A2D()) {
    if(self._id_19AC == "patrol")
      return 1;
  }

  return 0;
}

_id_1A33() {
  if(_id_1A2D()) {
    if(self._id_19AC == "protect" || self._id_19AC == "protect_zone")
      return 1;
  }

  return 0;
}

_id_1A27() {
  if(_id_1A2D()) {
    if(self._id_19AC == "bodyguard")
      return 1;
  }

  return 0;
}

_id_1A2D() {
  return isDefined(self._id_19A6);
}

_id_1A2E(var_0) {
  if(_id_1A2D()) {
    if(_id_1B1C(self._id_19A7, var_0))
      return 1;
  }

  return 0;
}

_id_1A30(var_0) {
  if(_id_1A27() && self._id_19A1 == var_0)
    return 1;

  return 0;
}

_id_37DF(var_0, var_1, var_2) {
  var_3 = (0, 0, 11);
  var_4 = (0, 0, 40);
  var_5 = undefined;

  if(var_2 == "stand")
    return 1;
  else if(var_2 == "crouch")
    var_5 = var_4;
  else if(var_2 == "prone")
    var_5 = var_3;

  return _sighttracepassed(var_1 + var_5, var_0 + var_5, 0, undefined);
}

_id_4187(var_0, var_1) {
  var_2 = _id_3F07(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 = _id_7C84(var_2);
    var_2 = _id_4084(var_2);
  }

  return var_2;
}

_id_3F08(var_0, var_1) {
  return _getpathdist(var_0, var_1);
}

_id_3F07(var_0, var_1) {
  return _getnodesonpath(var_0, var_1);
}

_id_3F03(var_0, var_1, var_2) {
  return _botgetclosestnavigablepoint(var_0, var_1, var_2);
}

_id_670D(var_0, var_1) {
  if(!isDefined(self._id_6AA8))
    return 0;

  if(isDefined(self._id_6AA8[var_0]) && isDefined(self._id_6AA8[var_0][var_1]) && self._id_6AA8[var_0][var_1])
    return 1;

  if(isDefined(self._id_6AA8[var_1]) && isDefined(self._id_6AA8[var_1][var_0]) && self._id_6AA8[var_1][var_0])
    return 1;

  return 0;
}

_id_4084(var_0) {
  var_1 = var_0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = _getlinkednodes(var_0[var_2]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(!common_scripts\utility::_id_0F79(var_1, var_3[var_4]))
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_3[var_4]);
    }
  }

  return var_1;
}

_id_43CA(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_nodesvisible(var_4, var_1, 1))
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
  }

  return var_2;
}

_id_7C84(var_0) {
  var_0[var_0.size - 1] = undefined;
  var_0[0] = undefined;
  return common_scripts\utility::_id_0FA0(var_0);
}

_id_1B20(var_0) {
  while(!_id_194B(var_0))
    wait 0.5;
}

_id_194B(var_0) {
  if(_botautoconnectenabled() != "off")
    return 1;

  if(isDefined(level._id_0AA1) && level._id_0AA1)
    return 1;

  if(_id_1B3C(var_0))
    return 1;

  return 0;
}

_id_1B22(var_0) {
  var_1 = gettime();

  for(;;) {
    if(isDefined(var_0)) {
      if(gettime() > var_1 + var_0)
        return;
    }

    if(!isDefined(self._id_0088))
      return;
    else if(!_id_1A1C()) {
      return;
    }
    waitframe();
  }
}

_id_1A1C(var_0) {
  if(self._id_5B21 == 0)
    return 0;

  var_1 = gettime() - self._id_5B21;
  var_2 = level._id_1A8C;

  if(isDefined(var_0))
    var_2 = var_0;

  return var_1 < var_2;
}

_id_1B21(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) && isDefined(var_2)) {}

  if((!isDefined(var_1) || !isDefined(var_2)) && isDefined(var_3)) {}

  var_4 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];

  if(isDefined(var_1))
    var_4[var_4.size] = var_1;

  if(isDefined(var_2))
    var_4[var_4.size] = var_2;

  if(isDefined(var_3))
    var_4[var_4.size] = var_3;

  if(isDefined(var_0))
    var_5 = common_scripts\utility::_id_A710(var_4, var_0);
  else
    var_5 = common_scripts\utility::_id_A712(var_4);

  return var_5;
}

_id_1B16(var_0, var_1, var_2) {
  level endon("game_ended");
  childthread _id_A1DA();
  var_3 = common_scripts\utility::_id_A71A(var_0, var_1, var_2, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return var_3;
}

_id_A1DA(var_0, var_1) {
  self endon("stop_usebutton_watcher");
  waitframe();

  while(self usebuttonpressed())
    waitframe();

  self notify("use_button_no_longer_pressed");
}

_id_1B3C(var_0) {
  foreach(var_2 in level._id_6E97) {
    if(_isai(var_2)) {
      if(isDefined(var_0) && var_0) {
        if(!maps\mp\_utility::_id_5800(var_2))
          continue;
      }

      return 1;
    }
  }

  return 0;
}

_id_19F1(var_0, var_1, var_2) {
  if(!isDefined(level._id_37DD))
    return undefined;

  if(_isarray(var_1)) {
    if(isDefined(var_2) && var_2) {
      var_3 = undefined;
      var_4 = 999999999;

      foreach(var_6 in var_1) {
        var_7 = common_scripts\utility::_id_0F7E(level._id_37DA, var_6);
        var_8 = level._id_37DB[var_7];
        var_9 = distancesquared(self.origin, var_8);

        if(var_9 < var_4) {
          var_3 = var_6;
          var_4 = var_9;
        }
      }

      var_1 = var_3;
    } else
      var_1 = common_scripts\utility::random(var_1);
  }

  var_11 = level._id_37DC[var_1];

  if(!isDefined(var_0) || var_0 == "stand")
    return var_11;
  else if(var_0 == "crouch") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14._id_2864[var_1])
        var_12 = common_scripts\utility::_id_0F6F(var_12, var_14);
    }

    return var_12;
  } else if(var_0 == "prone") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14._id_7779[var_1])
        var_12 = common_scripts\utility::_id_0F6F(var_12, var_14);
    }

    return var_12;
  }

  return undefined;
}

_id_19CE(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = self._id_19A1 getvelocity();

  if(_lengthsquared(var_4) > 100) {
    var_5 = _getnodesinradius(var_0, var_1 * 1.75, var_1 * 0.5, 500);
    var_6 = [];
    var_7 = vectorNormalize(var_4);

    for(var_8 = 0; var_8 < var_5.size; var_8++) {
      var_9 = vectorNormalize(var_5[var_8].origin - self._id_19A1.origin);

      if(vectordot(var_9, var_7) > 0.1)
        var_6[var_6.size] = var_5[var_8];
    }
  } else
    var_6 = _getnodesinradius(var_0, var_1, 0, 500);

  if(isDefined(var_2) && var_2) {
    var_10 = vectorNormalize(self._id_19A1.origin - self.origin);
    var_11 = var_6;
    var_6 = [];

    foreach(var_13 in var_11) {
      var_9 = vectorNormalize(var_13.origin - self._id_19A1.origin);

      if(vectordot(var_10, var_9) > 0.2)
        var_6[var_6.size] = var_13;
    }
  }

  var_15 = [];
  var_16 = [];
  var_17 = [];

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    var_18 = distancesquared(var_6[var_8].origin, var_0) > 10000;
    var_19 = _abs(var_6[var_8].origin[2] - self._id_19A1.origin[2]) < 50;

    if(var_18)
      var_15[var_15.size] = var_6[var_8];

    if(var_19)
      var_16[var_16.size] = var_6[var_8];

    if(var_18 && var_19)
      var_17[var_17.size] = var_6[var_8];

    if(var_8 % 100 == 99)
      waitframe();
  }

  if(var_17.size > 0)
    var_3 = self botnodepick(var_17, var_17.size * 0.15, "node_capture", var_0, undefined, self._id_2C89);

  if(!isDefined(var_3)) {
    waitframe();

    if(var_16.size > 0)
      var_3 = self botnodepick(var_16, var_16.size * 0.15, "node_capture", var_0, undefined, self._id_2C89);

    if(!isDefined(var_3) && var_15.size > 0) {
      waitframe();
      var_3 = self botnodepick(var_15, var_15.size * 0.15, "node_capture", var_0, undefined, self._id_2C89);
    }
  }

  return var_3;
}

_id_19CC(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = _getnodesinradius(var_0, var_1, 0, 500);

  if(var_4.size > 0)
    var_3 = self botnodepick(var_4, var_4.size * 0.15, "node_capture", var_0, var_2, self._id_2C89);

  return var_3;
}

_id_19CD(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0)
    var_2 = self botnodepick(var_0, var_0.size * 0.15, "node_capture", undefined, var_1, self._id_2C89);

  return var_2;
}

_id_19CF(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0)
    var_2 = self botnodepick(var_0, var_0.size * 0.25, "node_capture", var_1, undefined, self._id_2C89);

  return var_2;
}

_id_19CB(var_0, var_1) {
  var_2 = undefined;
  var_3 = _getnodesinradius(var_0, var_1, 0, 500);

  if(var_3.size > 0)
    var_2 = self botnodepick(var_3, var_3.size * 0.15, "node_protect", var_0, self._id_2C89);

  return var_2;
}

_id_1A99(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = _getnodesinradius(var_0, var_1, 0, 500);

  if(isDefined(var_6) && var_6.size >= 2)
    var_5 = _id_19D0(var_6, var_2);

  if(!isDefined(var_5)) {
    if(!isDefined(var_3))
      var_3 = 0;

    if(!isDefined(var_4))
      var_4 = 1;

    var_7 = _randomfloatrange(self._id_19AA * var_3, self._id_19AA * var_4);
    var_8 = anglesToForward((0, randomint(360), 0));
    var_5 = var_0 + var_8 * var_7;
  }

  return var_5;
}

_id_1A98(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.size >= 2)
    var_3 = _id_19D0(var_1, var_2);

  if(!isDefined(var_3)) {
    var_4 = common_scripts\utility::random(var_1);
    var_5 = var_4.origin - var_0;
    var_3 = var_0 + vectorNormalize(var_5) * length(var_5) * _randomfloat(1.0);
  }

  return var_3;
}

_id_19D0(var_0, var_1) {
  var_2 = undefined;
  var_3 = common_scripts\utility::array_randomize(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    for(var_5 = var_4 + 1; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_4];
      var_7 = var_3[var_5];

      if(_nodesvisible(var_6, var_7, 1)) {
        var_2 = ((var_6.origin[0] + var_7.origin[0]) * 0.5, (var_6.origin[1] + var_7.origin[1]) * 0.5, (var_6.origin[2] + var_7.origin[2]) * 0.5);

        if(isDefined(var_1) && self[[var_1]](var_2) == 1)
          return var_2;
      }
    }
  }

  return var_2;
}

_id_2C6C() {
  if(isDefined(self._id_19A9))
    return self._id_19A9.origin;
  else if(isDefined(self._id_19A7))
    return self._id_19A7;

  return undefined;
}

_id_1937() {
  if(!maps\mp\_utility::_id_0F5C())
    return 0;

  if(maps\mp\_utility::_id_573D())
    return 0;

  if(_id_1A36())
    return 0;

  if(self isusingturret())
    return 0;

  if(isDefined(level._id_685D) || isDefined(level.nukecoolingdown))
    return 0;

  if(isDefined(level.nobotscorestreaks))
    return 0;

  if(isDefined(self._id_A019) && self._id_A019)
    return 0;

  if(isDefined(self.controlsfrozen) && self.controlsfrozen)
    return 0;

  if(!self _meth_85EB())
    return 0;

  if(self isoffhandweaponreadytothrow())
    return 0;

  if(maps\mp\_utility::getgametypenumlives() > 0) {
    var_0 = 1;

    foreach(var_2 in level._id_6E97) {
      if(isalive(var_2) && !_isalliedsentient(self, var_2))
        var_0 = 0;
    }

    if(var_0)
      return 0;
  }

  if(common_scripts\utility::_id_562E(self._id_1B2F))
    return 0;

  if(!_id_1A1C(500))
    return 1;

  if(!isalive(self._id_0088))
    return 1;

  return 0;
}

_id_1AB2() {
  var_0 = undefined;
  var_1 = _botmemoryflags("investigated", "killer_died");
  var_2 = _botmemoryflags("investigated");
  var_3 = common_scripts\utility::random(_botgetmemoryevents(0, gettime() - 10000, 1, "death", var_1, self));

  if(isDefined(var_3)) {
    var_0 = var_3;
    self._id_1A7C = 10000;
  } else {
    var_4 = undefined;

    if(self botgetscriptgoaltype() != "none")
      var_4 = self botgetscriptgoal();

    var_5 = _botgetmemoryevents(0, gettime() - 45000, 1, "kill", var_2, self);
    var_6 = _botgetmemoryevents(0, gettime() - 45000, 1, "death", var_1, self);
    var_3 = common_scripts\utility::random(common_scripts\utility::_id_0F73(var_5, var_6));

    if(isDefined(var_3) > 0 && (!isDefined(var_4) || distancesquared(var_4, var_3) > 1000000)) {
      var_0 = var_3;
      self._id_1A7C = 45000;
    }
  }

  if(isDefined(var_0)) {
    var_7 = _getzonenearest(var_0);
    var_8 = _getzonenearest(self.origin);

    if(isDefined(var_7) && isDefined(var_8) && var_8 != var_7) {
      var_9 = _botzonegetcount(var_7, self.team, "ally") + _botzonegetcount(var_7, self.team, "path_ally");

      if(var_9 > 1)
        var_0 = undefined;
    }
  }

  if(isDefined(var_0))
    self._id_1A7B = var_0;

  return var_0;
}

_id_193A() {
  if(self bothasscriptgoal()) {
    var_0 = self botgetscriptgoal();

    if(distancesquared(self.origin, var_0) < 256)
      return 1;
  }

  return 0;
}

_id_19B9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

_id_19BA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

_id_19B8(var_0, var_1, var_2, var_3, var_4) {}

_id_1A07() {
  var_0 = 0;
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammoclip(var_3);
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  return var_0;
}

_id_1A8B() {
  var_0 = self getweaponlistprimaries();

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0)
      return 0;

    if(self getweaponammostock(var_2) > 0)
      return 0;
  }

  return 1;
}

_id_19F2() {
  var_0 = 0;
  var_1 = self getweaponslistoffhands();

  foreach(var_3 in var_1)
  var_0 = var_0 + self getweaponammostock(var_3);

  return var_0;
}

_id_1A3A(var_0, var_1) {
  switch (var_0) {
    case "trap_directional":
      switch (var_1) {
        case "claymore_mp":
          return 1;
      }

      break;
    case "trap":
      switch (var_1) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "trophy_mp":
          return 1;
      }

      break;
    case "trap_follower":
      switch (var_1) {
        case "tracking_drone_mp":
          return 1;
      }

      break;
    case "c4":
      switch (var_1) {
        case "c4_mp":
          return 1;
      }

      break;
    case "tacticalinsertion":
      switch (var_1) {
        case "s2_tactical_insertion_device_mp":
          return 1;
      }

      break;
  }

  return 0;
}

_id_1B2A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("using_remote");
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_4))
    self endon(var_4);

  if(isDefined(var_5))
    self endon(var_5);

  if(isDefined(var_6))
    self endon(var_6);

  if(isDefined(var_7))
    self endon(var_7);

  wait 0.5;
  var_8 = 1;

  if(self isusingturret())
    var_8 = 0;

  var_9 = _squared(self botgetscriptgoalradius());

  while(var_8) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < var_9) {
        if(length(self getvelocity()) <= 1)
          var_8 = 0;
      }
    }

    if(var_8)
      waitframe();
  }

  var_10 = self.origin;
  var_11 = (0, 0, self getplayerviewheight());

  if(isDefined(var_0)) {
    self._id_A8C9 = [];

    foreach(var_13 in var_0) {
      var_14 = 0;

      if(_distance2dsquared(self.origin, var_13.origin) <= 40)
        var_14 = 1;

      var_15 = self getEye();
      var_16 = vectordot((0, 0, 1), vectorNormalize(var_13.origin + var_11 - var_15));

      if(_abs(var_16) > 0.92)
        var_14 = 1;

      if(!var_14)
        self._id_A8C9[self._id_A8C9.size] = var_13;
    }
  }

  if(!isDefined(self._id_A8C9)) {
    return;
  }
  thread _id_A8CA();
  self._id_A8C9 = common_scripts\utility::array_randomize(self._id_A8C9);

  foreach(var_13 in self._id_A8C9) {
    var_13._id_A8C7[self.entity_number] = 1.0;
    var_13._id_A8C6[self.entity_number] = 1.0;
  }

  var_20 = [];

  for(var_21 = 0; var_21 < self._id_A8C9.size; var_21++) {
    var_20[var_21] = [];
    var_22 = vectorNormalize(self._id_A8C9[var_21].origin - self.origin);

    for(var_23 = 0; var_23 < self._id_A8C9.size; var_23++) {
      if(var_21 == var_23) {
        continue;
      }
      var_24 = vectorNormalize(self._id_A8C9[var_23].origin - self.origin);
      var_25 = vectordot(var_22, var_24);

      if(var_25 > 0.94)
        var_20[var_21] = common_scripts\utility::_id_0F6F(var_20[var_21], var_23);
    }
  }

  for(;;) {
    var_26 = -1;
    var_27 = 0;

    for(var_21 = 0; var_21 < self._id_A8C9.size; var_21++) {
      if(var_20[var_21].size > var_27) {
        var_26 = var_21;
        var_27 = var_20[var_21].size;
      }
    }

    if(var_26 == -1) {
      break;
    }

    self._id_A8C9[var_26]._id_A8C7[self.entity_number] = 0.5;
    self._id_A8C9[var_26]._id_A8C6[self.entity_number] = 0.5;
    var_20[var_26] = [];

    for(var_21 = 0; var_21 < var_20.size; var_21++) {
      if(common_scripts\utility::_id_0F79(var_20[var_21], var_26))
        var_20[var_21] = common_scripts\utility::_id_0F93(var_20[var_21], var_26);
    }
  }

  var_28 = gettime();
  var_29 = var_28;
  var_30 = [];
  var_31 = undefined;

  if(isDefined(var_1))
    var_31 = (0, var_1, 0);

  var_32 = isDefined(var_31) && isDefined(var_2);
  var_33 = undefined;
  var_34 = undefined;
  wait 0.1;

  for(;;) {
    var_35 = gettime();
    self notify("still_watching_nodes");
    var_36 = self botgetfovdot();

    if(isDefined(var_3) && var_35 >= var_3) {
      return;
    }
    if(maps\mp\bots\_bots_strategy::_id_1A14()) {
      self botlookatpoint(undefined);
      wait 0.2;
      continue;
    }

    if(!self bothasscriptgoal() || !self botpursuingscriptgoal()) {
      wait 0.2;
      continue;
    }

    if(isDefined(var_34) && var_34._id_A8C7[self.entity_number] == 0.0)
      var_29 = var_35;

    if(self._id_A8C9.size > 0) {
      var_37 = 0;

      if(isDefined(self._id_0088)) {
        var_38 = self lastknownpos(self._id_0088);
        var_39 = self lastknowntime(self._id_0088);

        if(var_39 && var_35 - var_39 < 5000) {
          var_40 = vectorNormalize(var_38 - self.origin);
          var_41 = 0;

          for(var_21 = 0; var_21 < self._id_A8C9.size; var_21++) {
            var_42 = vectorNormalize(self._id_A8C9[var_21].origin - self.origin);
            var_25 = vectordot(var_40, var_42);

            if(var_25 > var_41) {
              var_41 = var_25;
              var_34 = self._id_A8C9[var_21];
              var_37 = 1;
            }
          }
        }
      }

      if(!var_37 && var_35 >= var_29) {
        var_43 = [];

        for(var_21 = 0; var_21 < self._id_A8C9.size; var_21++) {
          var_13 = self._id_A8C9[var_21];
          var_44 = var_13 getnodenumber();

          if(var_32 && !common_scripts\utility::within_fov(self.origin, var_31, var_13.origin, var_2)) {
            continue;
          }
          if(_distance2dsquared(self.origin, var_13.origin) <= 10) {
            continue;
          }
          if(!isDefined(var_30[var_44]))
            var_30[var_44] = 0;

          if(common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_13.origin, var_36))
            var_30[var_44] = var_35;

          for(var_45 = 0; var_45 < var_43.size; var_45++) {
            if(var_30[var_43[var_45] getnodenumber()] > var_30[var_44]) {
              break;
            }
          }

          var_43 = common_scripts\utility::_id_0F86(var_43, var_13, var_45);
        }

        var_33 = var_34;
        var_34 = undefined;

        if(var_43.size == 1)
          var_34 = var_43[0];
        else if(var_43.size > 1) {
          var_46 = [];
          var_47 = 0;

          for(var_21 = 0; var_21 < var_43.size; var_21++) {
            var_48 = 1.0 - var_21 / (var_43.size - 1) * 0.5;
            var_49 = [var_43[var_21], var_43[var_21]._id_A8C7[self.entity_number] * var_48];
            var_46[var_46.size] = var_49;
            var_47 = var_47 + var_49[1];
          }

          var_50 = _randomfloat(var_47);

          for(var_21 = 0; var_21 < var_46.size; var_21++) {
            if(var_50 < var_46[var_21][1]) {
              var_34 = var_46[var_21][0];
              break;
            }

            var_50 = var_50 - var_46[var_21][1];
          }
        }

        if(isDefined(var_34)) {
          var_29 = var_35 + _randomintrange(3000, 5000);
          var_51 = !isDefined(var_33) || var_33 != var_34;

          if(var_51 && common_scripts\utility::_id_562E(self._id_1957))
            childthread _id_1A10(var_34);
        }
      }

      if(isDefined(var_34)) {
        var_52 = var_34.origin + var_11;

        if(_distance2dsquared(self.origin, var_52) <= 10) {
          self botlookatpoint(undefined);
          var_34 = undefined;
          var_29 = 0;
        } else
          self botlookatpoint(var_52, 0.4, "script_search");
      }
    }

    wait 0.2;
  }
}

_id_1A10(var_0) {
  if(isDefined(self._id_28C8)) {
    var_1 = self._id_28C8;

    if(var_1 == "prone" && self getstance() == "prone") {
      self botsetstance("crouch");
      wait 1.0;
    }

    if(var_1 == "prone") {
      if(_id_A8CD(self getnearestnode(), var_0))
        self botsetstance("prone");
      else
        var_1 = "crouch";
    }

    if(var_1 == "crouch") {
      if(_id_A8CC(self getnearestnode(), var_0))
        self botsetstance("crouch");
      else
        var_1 = "stand";
    }

    if(var_1 == "stand")
      self botsetstance("stand");
  }
}

_id_A8CD(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0._id_777C) || !isDefined(var_0._id_777C[var_2])) {
    var_3 = _sighttracepassed(var_0.origin + (0, 0, 11), var_1.origin + (0, 0, 11), 0, undefined);
    var_0._id_777C[var_2] = var_3;
  }

  return var_0._id_777C[var_2];
}

_id_A8CC(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0._id_777C) || !isDefined(var_0._id_777C[var_2])) {
    var_3 = _sighttracepassed(var_0.origin + (0, 0, 40), var_1.origin + (0, 0, 11), 0, undefined);
    var_0._id_777C[var_2] = var_3;
  }

  return var_0._id_777C[var_2];
}

_id_A8CB() {
  self notify("bot_watch_nodes_stop");

  if(isDefined(self._id_A8C9)) {
    foreach(var_1 in self._id_A8C9)
    _id_A8C8(var_1);
  }

  self._id_A8C9 = undefined;
}

_id_A8C8(var_0) {
  var_0._id_A8C7[self.entity_number] = undefined;
  var_0._id_A8C6[self.entity_number] = undefined;
}

_id_A8CA() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");

  for(;;) {
    var_0 = common_scripts\utility::_id_A71A(0.5, "still_watching_nodes");

    if(!isDefined(var_0) || var_0 != "still_watching_nodes") {
      _id_A8CB();
      return;
    }
  }
}

_id_1A59(var_0, var_1) {
  if(isDefined(var_1) && var_1 != (0, 0, 0)) {
    if(!common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_1, self botgetfovdot())) {
      var_2 = self botpredictseepoint(var_1);

      if(isDefined(var_2))
        self botlookatpoint(var_2 + (0, 0, 40), 1.0, "script_seek");
    }

    self botmemoryevent("known_enemy", undefined, var_1);
  }
}

_id_19F7(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.classname)) {
    if(var_1.classname == "grenade") {
      if(isDefined(var_0) && var_0.classname == "worldspawn")
        return undefined;

      if(!_id_19C0(var_1))
        return var_0;
    } else if(var_1.classname == "rocket") {
      if(isDefined(var_1._id_A319))
        return var_1._id_A319;

      if(isDefined(var_1.type) && (var_1.type == "remote" || var_1.type == "odin"))
        return var_1;

      if(maps\mp\_utility::_id_579B()) {
        if(isDefined(var_1._id_0117) && var_1._id_0117.classname == "worldspawn")
          return undefined;
      }

      if(isDefined(var_1._id_0117))
        return var_1._id_0117;
    } else if(var_1.classname == "worldspawn" || var_1.classname == "trigger_hurt")
      return undefined;

    return var_1;
  }

  return var_0;
}

_id_19C0(var_0) {
  var_1 = var_0._id_A9AB;

  if(!isDefined(var_1))
    var_1 = var_0._id_A9E0;

  if(!isDefined(var_1))
    return 0;

  if(issubstr(var_1, "c4_mp"))
    return 1;

  if(issubstr(var_1, "claymore_mp"))
    return 1;

  if(issubstr(var_1, "proximity_explosive_mp"))
    return 1;

  return 0;
}

_id_1B1C(var_0, var_1) {
  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

_id_1931(var_0) {
  var_0._id_4D3C = [];

  if(var_0._id_1A23 == "use")
    _id_1932(var_0);
  else if(var_0._id_1A23 == "damage")
    _id_1930(var_0);
  else {}
}

_id_1AB4(var_0) {
  var_0._id_0CA3 = 1;
  level._id_5CB7 = common_scripts\utility::_id_0F93(level._id_5CB7, var_0);
}

_id_1932(var_0) {
  if(!issubstr(var_0._id_003B, "trigger_use")) {
    return;
  }
  if(!isDefined(var_0.target)) {
    return;
  }
  if(isDefined(var_0._id_1AF7)) {
    return;
  }
  if(!isDefined(var_0._id_A1F5)) {
    return;
  }
  var_1 = _getnodearray(var_0.target, "targetname");

  if(var_1.size != 1) {
    return;
  }
  var_0._id_1AF7 = var_1[0];

  if(!isDefined(level._id_5CB7))
    level._id_5CB7 = [];

  level._id_5CB7 = common_scripts\utility::_id_0F6F(level._id_5CB7, var_0);
}

_id_1930(var_0) {
  if(!issubstr(var_0._id_003B, "trigger_damage")) {
    return;
  }
  var_1 = _getnodearray(var_0.target, "targetname");

  if(var_1.size != 2) {
    return;
  }
  var_0._id_1AF9 = var_1;

  if(!isDefined(level._id_5CB7))
    level._id_5CB7 = [];

  level._id_5CB7 = common_scripts\utility::_id_0F6F(level._id_5CB7, var_0);
}

_id_1A01(var_0, var_1) {
  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    if(var_2 == var_1)
      return var_5;

    var_2++;
  }

  return undefined;
}

_id_1A09(var_0, var_1) {
  for(var_2 = 0; var_2 < level._id_AC9C; var_2++) {
    var_3 = _getzonenodeforindex(var_2);
    var_3._id_A571 = 0;
  }

  var_4 = _getzonenodeforindex(var_0);
  return _id_1A0A(var_4, var_1);
}

_id_1A0A(var_0, var_1) {
  var_2 = [];
  var_2[0] = _getnodezone(var_0);
  var_0._id_A571 = 1;
  var_3 = _getlinkednodes(var_0);

  foreach(var_5 in var_3) {
    if(!var_5._id_A571) {
      var_6 = distance(var_0.origin, var_5.origin);

      if(var_6 < var_1) {
        var_7 = _id_1A0A(var_5, var_1 - var_6);
        var_2 = common_scripts\utility::_id_0F73(var_7, var_2);
      }
    }
  }

  return var_2;
}

_id_1981(var_0) {
  return isDefined(var_0) && isDefined(var_0._id_253C) && var_0._id_253C;
}

_id_19F9(var_0) {
  return level._id_1A79[var_0];
}

_id_1A02() {
  return int(_id_19EE() / 2);
}

_id_19EE() {
  var_0 = _func_364();
  var_0 = max(var_0, getdvarint("5321", 0));

  if(var_0 > level._id_6079)
    return level._id_6079;

  return var_0;
}

_id_1AA9() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  waitframe();

  for(;;) {
    if(isDefined(level._id_1AAB) && level._id_1AAB.size > 0) {
      var_0 = level._id_1AAB[0];

      if(isDefined(var_0) && isDefined(var_0._id_0117)) {
        var_1 = undefined;

        if(isDefined(var_0._id_6E85))
          var_1 = var_0._id_0117[[var_0._id_3F02]](var_0._id_6E82, var_0._id_6E83, var_0._id_6E84, var_0._id_6E85);
        else if(isDefined(var_0._id_6E84))
          var_1 = var_0._id_0117[[var_0._id_3F02]](var_0._id_6E82, var_0._id_6E83, var_0._id_6E84);
        else if(isDefined(var_0._id_6E83))
          var_1 = var_0._id_0117[[var_0._id_3F02]](var_0._id_6E82, var_0._id_6E83);
        else if(isDefined(var_0._id_6E82))
          var_1 = var_0._id_0117[[var_0._id_3F02]](var_0._id_6E82);
        else
          var_1 = var_0._id_0117[[var_0._id_3F02]]();

        var_0._id_0117 notify(var_0._id_6602, var_1);
      }

      var_2 = [];

      for(var_3 = 1; var_3 < level._id_1AAB.size; var_3++)
        var_2[var_3 - 1] = level._id_1AAB[var_3];

      level._id_1AAB = var_2;
    }

    waitframe();
  }
}

_id_1AA8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_1AAB))
    level._id_1AAB = [];

  foreach(var_8, var_7 in level._id_1AAB) {
    if(var_7._id_0117 == self && var_7.name == var_0) {
      self notify(var_7.name);
      level._id_1AAB[var_8] = undefined;
    }
  }

  var_7 = spawnStruct();
  var_7._id_0117 = self;
  var_7.name = var_0;
  var_7._id_6602 = var_7.name + "_done";
  var_7._id_3F02 = var_1;
  var_7._id_6E82 = var_2;
  var_7._id_6E83 = var_3;
  var_7._id_6E84 = var_4;
  var_7._id_6E85 = var_5;
  level._id_1AAB[level._id_1AAB.size] = var_7;

  if(!isDefined(level._id_1AAA)) {
    level._id_1AAA = 1;
    level thread _id_1AA9();
  }

  self waittill(var_7._id_6602, var_9);
  return var_9;
}

_id_1A36() {
  return maps\mp\_utility::isusingremote() || self islinked();
}

_id_19F8(var_0) {
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    var_4 = _weaponclipsize(var_3);
    var_5 = self getweaponammostock(var_3);

    if(var_5 <= var_4)
      return 1;

    if(self getfractionmaxammo(var_3) <= var_0)
      return 1;
  }

  return 0;
}

_id_1A9D(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 256;

  if(!isDefined(var_2))
    var_2 = 50;

  var_3 = _getnodesinradiussorted(var_0, var_1, 0, var_2, "Path");

  foreach(var_5 in var_3) {
    var_6 = var_0 + (0, 0, 30);
    var_7 = var_5.origin + (0, 0, 30);
    var_8 = _physicstrace(var_6, var_7);

    if(_id_1B1C(var_8, var_7))
      return 1;

    waitframe();
  }

  return 0;
}

_id_1A80(var_0) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level._id_3716 = [];
  level._id_3715 = [];
  level._id_3714 = [];

  for(;;) {
    wait 1.0;
    var_1 = [];

    if(!isDefined(var_0)) {
      continue;
    }
    foreach(var_3 in level._id_6E97) {
      if(!isDefined(var_3.team)) {
        continue;
      }
      if(var_3[[var_0]]() && !isDefined(var_1[var_3.team])) {
        level._id_3714[var_3.team] = undefined;
        level._id_3716[var_3.team] = var_3 botpredictenemycampspots(1);

        if(isDefined(level._id_3716[var_3.team])) {
          if(!isDefined(level._id_3715[var_3.team]) || !common_scripts\utility::_id_0F79(level._id_3716[var_3.team], level._id_3715[var_3.team]))
            level._id_3715[var_3.team] = common_scripts\utility::random(level._id_3716[var_3.team]);

          if(isDefined(level._id_3715[var_3.team])) {
            var_4 = [];

            foreach(var_6 in level._id_6E97) {
              if(!isDefined(var_6.team)) {
                continue;
              }
              if(var_6[[var_0]]() && var_6.team == var_3.team)
                var_4[var_4.size] = var_6;
            }

            var_4 = _sortbydistance(var_4, level._id_3715[var_3.team]);

            if(var_4.size > 0)
              level._id_3714[var_3.team] = var_4[0];
          }
        }

        var_1[var_3.team] = 1;
      }
    }
  }
}

_id_1B17() {
  if(!isDefined(self))
    return 0;

  if(!_isai(self))
    return 0;

  if(!isDefined(self.team))
    return 0;

  if(self.team == "spectator")
    return 0;

  if(!isalive(self))
    return 0;

  if(!maps\mp\_utility::_id_566A(self))
    return 0;

  if(!isDefined(self._id_6F7D) || self._id_6F7D == "camper")
    return 0;

  return 1;
}

_id_1B13() {
  if(!isDefined(level._id_3714)) {
    return;
  }
  if(!isDefined(level._id_3714[self.team])) {
    return;
  }
  if(level._id_3714[self.team] == self) {
    maps\mp\bots\_bots_strategy::_id_19A3();
    self botsetscriptgoal(level._id_3715[self.team], 128, "objective", undefined, 256);
    _id_1B21();
  }
}

_id_19D4(var_0, var_1) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetstance(var_0);
  wait(var_1);
  self botsetstance("none");
}

_id_19AF(var_0) {
  self notify("bot_disable_movement_for_time");
  self endon("bot_disable_movement_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  wait(var_0);
  self botsetflag("disable_movement", 0);
}