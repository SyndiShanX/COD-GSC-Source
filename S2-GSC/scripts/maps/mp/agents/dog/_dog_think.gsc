/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\dog\_dog_think.gsc
*****************************************************/

main() {
  _id_8A16();
  thread _id_9963();
  thread _id_A92D();
  thread _id_A92E();
  thread _id_A92F();
  thread _id_A692();
  thread _id_A6B1();
  level._id_31F3 = ::_id_6ADB;
  level._id_31FB = ::_id_A909;
  level._id_31F4 = ::_id_6AFF;
  level._id_31F2 = ::init;
  level._id_31F8 = ::_id_8A16;
  level._id_31F5 = ::_id_7AC0;
  level._id_31B2 = ::_id_2EE6;
  level._id_31F1 = ::_id_442A;
}

_id_8A16() {
  self._id_17E8 = 0;
  self._id_6DAE = 20736;
  self._id_60F2 = 16384;
  self._id_11AB = 25 + self.radius;
  self._id_11AD = 9437184;
  self._id_A85B = 302500;
  self._id_A85C = 96.0;
  self._id_11B8 = 54;
  self._id_11B9 = -64;
  self._id_6DAB = 2250000;
  self._id_31B1 = 2250000;
  self._id_59DE = 1000000;
  self._id_7673 = 76;
  self._id_621C = 50;
  self._id_3E0B = 0;
  self._id_00CB = 1;
  self._id_0108 = "run";
  self._id_3658 = 1;
  self._id_11B5 = "idle";
  self._id_64CE = "idle";
  self._id_173C = 0;
  self._id_99FC = 0;
  self._id_0012 = 1;
  self scragentsetgoalRadius(24);
}

init() {
  self._id_0EAD = spawnStruct();
  self._id_0EAD._id_6AFE = [];
  self._id_0EAD._id_6AFE["idle"] = maps\mp\agents\dog\_dog_idle::main;
  self._id_0EAD._id_6AFE["move"] = maps\mp\agents\dog\_dog_move::main;
  self._id_0EAD._id_6AFE["traverse"] = maps\mp\agents\dog\_dog_traverse::main;
  self._id_0EAD._id_6AFE["melee"] = maps\mp\agents\dog\_dog_melee::main;
  self._id_0EAD._id_6B2F = [];
  self._id_0EAD._id_6B2F["idle"] = maps\mp\agents\dog\_dog_idle::_id_0085;
  self._id_0EAD._id_6B2F["move"] = maps\mp\agents\dog\_dog_move::_id_0085;
  self._id_0EAD._id_6B2F["melee"] = maps\mp\agents\dog\_dog_melee::_id_0085;
  self._id_0EAD._id_6B2F["traverse"] = maps\mp\agents\dog\_dog_traverse::_id_0085;
  self._id_A8ED = ::_id_A8EC;
  self._id_0BA4 = "idle";
  self._id_0108 = "fastwalk";
  self.radius = 15;
  self._id_00BD = 40;
}

_id_6AFF(var_0, var_1) {
  self notify("killanimscript");

  if(!isDefined(self._id_0EAD._id_6AFE[var_1])) {
    return;
  }
  if(var_0 == var_1 && var_1 != "traverse") {
    return;
  }
  if(isDefined(self._id_0EAD._id_6B2F[var_0])) {
    self[[self._id_0EAD._id_6B2F[var_0]]]();
  }

  _id_38ED(self._id_0BA4);
  self._id_0BA4 = var_1;
  _id_37B8(var_1);
  self[[self._id_0EAD._id_6AFE[var_1]]]();
}

_id_9963() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self._id_0117)) {
    self endon("owner_disconnect");
    thread _id_2DD5(self._id_0117);
  }

  self thread[[self._id_A8ED]]();
  thread _id_6394();

  for(;;) {
    if(self._id_0BA4 != "melee" && !self._id_018F && self[[level._id_31F5]]() && !self[[level._id_31B2]]()) {
      self scragentbeginmelee(self._id_28D2);
    }

    switch (self._id_0BA4) {
      case "idle":
        _id_A127();
        break;
      case "move":
        _id_A13A();
        break;
      case "melee":
        _id_A134();
        break;
    }

    waitframe();
  }
}

_id_2EE7(var_0) {
  if(isDefined(self._id_28D2) && var_0 != self._id_28D2) {
    return 0;
  }

  if(!isDefined(self._id_5BD2) || !isDefined(self._id_5BD1)) {
    return 0;
  }

  if(_distance2dsquared(var_0.origin, self._id_5BD2) > 4) {
    return 0;
  }

  if(self._id_1787) {
    return 1;
  }

  if(distancesquared(self.origin, self._id_5BD1) > 4096 && gettime() - self._id_5BD3 > 2000) {
    return 0;
  }

  return 1;
}

_id_2EE6() {
  if(isDefined(self._id_5BBF) && isDefined(self._id_5BBE) && _distance2dsquared(self._id_28D2.origin, self._id_5BBF) < 4 && distancesquared(self.origin, self._id_5BBE) < 2500) {
    return 1;
  }

  if(_id_A7F8(0)) {
    return 1;
  }

  return 0;
}

_id_37B8(var_0) {
  _id_38ED(self._id_0BA4);
  self._id_0BA4 = var_0;

  switch (var_0) {
    case "idle":
      self._id_64CE = "idle";
      self._id_173C = 0;
      break;
    case "move":
      self._id_64CE = "follow";
      break;
    case "melee":
      break;
    default:
      break;
  }
}

_id_38ED(var_0) {
  switch (var_0) {
    case "move":
      self._id_6DAD = undefined;
      break;
    default:
      break;
  }
}

_id_A127() {
  _id_A13C();
}

_id_A13A() {
  _id_A13C();
}

_id_A134() {
  self scragentsetgoalpos(self.origin);
}

_id_A13C() {
  if(self._id_17E8) {
    return;
  }
  self._id_76E1 = self._id_64CE;
  var_0 = undefined;
  var_1 = 0;
  var_2 = 0;
  var_3 = 500;

  if(self._id_173C && gettime() - self._id_5B75 < var_3) {
    if(isDefined(self._id_0117)) {
      self._id_64CE = "follow";
      var_1 = 1;
    } else {
      self._id_64CE = "idle";
      self scragentsetgoalpos(self.origin);
    }
  } else
    self._id_64CE = _id_4595();

  if(self._id_64CE == "pursuit") {
    var_0 = self[[level._id_31F1]](self._id_0088);
    var_4 = 0;

    if(isDefined(self._id_5B75) && gettime() - self._id_5B75 < 3000) {
      if(_distance2dsquared(var_0, self._id_5B73) < 16) {
        var_4 = 1;
      } else if(isDefined(self._id_5B74) && self._id_5B74 == "pursuit" && _distance2dsquared(self._id_5B76, self._id_0088.origin) < 16) {
        var_4 = 1;
      }
    }

    if(var_4 || _id_A7F8(1) || _id_2EE7(self._id_0088)) {
      if(isDefined(self._id_0117)) {
        self._id_64CE = "follow";
      } else {
        self._id_64CE = "idle";
        self scragentsetgoalpos(self.origin);
      }

      var_2 = 1;
    }
  }

  _id_86F0(var_2);

  if(self._id_64CE == "follow") {
    self._id_28D2 = undefined;
    self._id_0108 = _id_44EA(self._id_0108);
    self._id_15E1 = 1;
    var_5 = self getpathgoalpos();

    if(!isDefined(var_5)) {
      var_5 = self.origin;
    }

    if(self._id_0117.sessionstate == "spectator") {
      return;
    }
    if(gettime() - self._id_99FC < 5000) {
      var_1 = 1;
    }

    var_6 = self._id_0117 getstance();

    if(!isDefined(self._id_0117._id_76E7) && isDefined(self._id_0117)) {
      self._id_0117._id_76E7 = var_6;
    }

    var_7 = !isDefined(self._id_6DAD) || _distance2dsquared(self._id_6DAD, self._id_0117.origin) > 100;

    if(var_7) {
      self._id_6DAD = self._id_0117.origin;
    }

    var_8 = _distance2dsquared(var_5, self._id_0117.origin);

    if(var_1 || var_8 > self._id_6DAE && var_7 || self._id_0117._id_76E7 != var_6 || self._id_76E1 != "idle" && self._id_76E1 != self._id_64CE) {
      self scragentsetgoalpos(_id_3B95());
      self._id_0117._id_76E7 = var_6;
      return;
    }
  } else if(self._id_64CE == "pursuit") {
    self._id_28D2 = self._id_0088;
    self._id_0108 = "sprint";
    self._id_15E1 = 0;
    self scragentsetgoalpos(var_0);
  }
}

_id_4595(var_0) {
  if(isDefined(self._id_0088)) {
    if(isDefined(self._id_0094) && self._id_0088 == self._id_0094) {
      return "pursuit";
    }

    if(_abs(self.origin[2] - self._id_0088.origin[2]) < self._id_A85C && _distance2dsquared(self._id_0088.origin, self.origin) < self._id_11AD) {
      return "pursuit";
    }

    if(isDefined(self._id_28D2) && self._id_28D2 == self._id_0088) {
      if(_distance2dsquared(self._id_28D2.origin, self.origin) < self._id_59DE) {
        return "pursuit";
      }
    }
  } else if(isDefined(self._id_0117))
    return "follow";

  return "idle";
}

_id_86F0(var_0) {
  if(var_0) {
    if(!isDefined(self._id_5BD2)) {
      self._id_5BD2 = self._id_0088.origin;
      self._id_5BD1 = self.origin;
      var_1 = maps\mp\agents\_scriptedagents::_id_34A6(self._id_0088.origin);
      self._id_1787 = !isDefined(var_1);
      self._id_5BD3 = gettime();
    }
  } else {
    self._id_5BD2 = undefined;
    self._id_5BD1 = undefined;
    self._id_1787 = undefined;
    self._id_5BD3 = undefined;
  }
}

_id_A692() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path", var_0);
    self._id_173C = 1;
    self._id_5B75 = gettime();
    self._id_5B73 = var_0;
    self._id_5B74 = self._id_64CE;

    if(self._id_64CE == "follow" && isDefined(self._id_0117)) {
      self._id_5B76 = self._id_0117.origin;
      continue;
    }

    if(self._id_64CE == "pursuit" && isDefined(self._id_0088)) {
      self._id_5B76 = self._id_0088.origin;
    }
  }
}

_id_A6B1() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("path_set");
    self._id_173C = 0;
  }
}

_id_44EA(var_0) {
  var_1 = 40000;
  var_2 = 65536;
  var_3 = self getpathgoalpos();

  if(isDefined(var_3)) {
    var_4 = distancesquared(var_3, self.origin);

    if(var_0 == "run" || var_0 == "sprint") {
      if(var_4 < var_1) {
        return "fastwalk";
      } else if(var_0 == "sprint") {
        return "run";
      }
    } else if(var_0 == "fastwalk") {
      if(var_4 > var_2) {
        return "run";
      }
    }
  }

  return var_0;
}

_id_5859(var_0) {
  var_1 = var_0[2] - self.origin[2];
  return var_1 <= self._id_11B8 && var_1 >= self._id_11B9;
}

_id_A7F8(var_0) {
  if(!isDefined(self._id_28D2)) {
    return 0;
  }

  return !_id_5859(self._id_28D2.origin) && _distance2dsquared(self.origin, self._id_28D2.origin) < self._id_60F2 * 0.75 * 0.75 && (!var_0 || self agentcanseesentient(self._id_28D2));
}

_id_7AC0() {
  if(!isDefined(self._id_28D2)) {
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self._id_28D2)) {
    return 0;
  }

  if(self._id_0BA4 == "traverse") {
    return 0;
  }

  if(_distance2dsquared(self.origin, self._id_28D2.origin) > self._id_60F2) {
    return 0;
  }

  if(!_id_5859(self._id_28D2.origin)) {
    return 0;
  }

  return 1;
}

_id_A7F7() {
  if(!isDefined(self._id_0088)) {
    return 0;
  }

  if(_abs(self.origin[2] - self._id_0088.origin[2]) <= self._id_A85C || self agentcanseesentient(self._id_0088)) {
    var_0 = _distance2dsquared(self.origin, self._id_0088.origin);

    if(var_0 < self._id_A85B) {
      return 1;
    }
  }

  return 0;
}

_id_442A(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_2 = self getpathgoalpos();
  var_3 = self._id_11AB + 4;

  if(isDefined(var_2) && _distance2dsquared(var_2, var_0.origin) < var_3 * var_3 && maps\mp\agents\_scriptedagents::_id_1F5B(var_0.origin, var_2)) {
    return var_2;
  }

  var_4 = var_0.origin - var_1 * self._id_11AB;
  var_4 = maps\mp\agents\_scriptedagents::_id_34A6(var_4);

  if(!isDefined(var_4)) {
    return var_0.origin;
  }

  if(!maps\mp\agents\_scriptedagents::_id_1F5B(var_0.origin, var_4)) {
    var_5 = anglesToForward(var_0.angles);
    var_4 = var_0.origin + var_5 * self._id_11AB;

    if(!maps\mp\agents\_scriptedagents::_id_1F5B(var_0.origin, var_4)) {
      return var_0.origin;
    }
  }

  return var_4;
}

_id_285C(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

_id_3B95() {
  var_0 = vectorNormalize(self.origin - self._id_0117.origin);
  var_1 = anglesToForward(self._id_0117.angles);
  var_1 = (var_1[0], var_1[1], 0);
  var_1 = vectorNormalize(var_1);
  var_2 = _id_285C(var_0, var_1);
  var_3 = _getclosestnodeinsight(self._id_0117.origin);

  if(!isDefined(var_3)) {
    return self.origin;
  }

  var_4 = _getlinkednodes(var_3);
  var_5 = 5;
  var_6 = 10;
  var_7 = 15;
  var_8 = -15;
  var_9 = gettime() - self._id_99FC < 5000;
  var_10 = 0;
  var_11 = 0;
  var_4[var_4.size] = var_3;

  foreach(var_13 in var_4) {
    var_14 = 0;
    var_15 = var_13.origin - self._id_0117.origin;
    var_16 = length(var_15);

    if(var_16 >= self._id_7673) {
      var_14 = var_14 + var_5;
    } else if(var_16 < self._id_621C) {
      var_17 = 1 - (self._id_621C - var_16) / self._id_621C;
      var_14 = var_14 + var_5 * var_17 * var_17;
    } else
      var_14 = var_14 + var_5 * var_16 / self._id_7673;

    if(var_16 == 0) {
      var_16 = 1;
    }

    var_15 = var_15 / var_16;
    var_18 = vectordot(var_1, var_15);
    var_19 = self._id_0117 getstance();

    switch (var_19) {
      case "stand":
        if(var_18 < _cos(35) && var_18 > _cos(45)) {
          var_14 = var_14 + var_6;
        }

        break;
      case "crouch":
        if(var_18 < _cos(75) && var_18 > _cos(90)) {
          var_14 = var_14 + var_6;
        }

        break;
      case "prone":
        if(var_18 < _cos(125) && var_18 > _cos(135)) {
          var_14 = var_14 + var_6;
        }

        break;
    }

    var_20 = _id_285C(var_15, var_1);

    if(var_20 * var_2 > 0) {
      var_14 = var_14 + var_7;
    }

    if(var_9) {
      var_21 = vectordot(self._id_29BC, var_15);
      var_14 = var_14 + var_21 * var_8;
    }

    if(var_14 > var_10) {
      var_10 = var_14;
      var_11 = var_13;
    }
  }

  if(!isDefined(var_11)) {
    return self.origin;
  }

  var_23 = var_11.origin - self._id_0117.origin;
  var_24 = length(var_23);

  if(var_24 > self._id_7673) {
    var_25 = var_3.origin - self._id_0117.origin;

    if(vectordot(var_25, var_23 / var_24) < 0) {
      var_26 = var_11.origin;
    } else {
      var_27 = vectorNormalize(var_11.origin - var_3.origin);
      var_26 = var_3.origin + var_27 * self._id_7673;
    }
  } else
    var_26 = var_11.origin;

  var_26 = maps\mp\agents\_scriptedagents::_id_34A6(var_26);

  if(!isDefined(var_26)) {
    return self.origin;
  }

  if(self._id_173C && _distance2dsquared(var_26, self._id_5B73) < 4) {
    return self.origin;
  }

  return var_26;
}

_id_2DD5(var_0) {
  self endon("death");
  var_0 common_scripts\utility::_id_A70A("disconnect", "joined_team");
  self notify("owner_disconnect");

  if(maps\mp\gametypes\_hostmigration::_id_A782()) {
    waitframe();
  }

  self notify("killanimscript");

  if(isDefined(self._id_0EAD._id_6B2F[self._id_0BA4])) {
    self[[self._id_0EAD._id_6B2F[self._id_0BA4]]]();
  }

  self suicide();
}

_id_A8EC() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(self._id_0BA4 == "melee") {
      if(self._id_11B5 != "melee") {
        self._id_11B5 = "melee";
        _id_8728(undefined);
      }
    } else if(self._id_64CE == "pursuit") {
      if(self._id_11B5 != "attacking") {
        self._id_11B5 = "attacking";
        _id_8728("bark", "attacking");
      }
    } else if(self._id_11B5 != "warning") {
      if(_id_A7F7()) {
        self._id_11B5 = "warning";
        _id_8728("growl", "warning");
      } else {
        self._id_11B5 = self._id_0BA4;
        _id_8728("pant");
      }
    } else if(!_id_A7F7()) {
      self._id_11B5 = self._id_0BA4;
      _id_8728("pant");
    }

    waitframe();
  }
}

_id_8728(var_0, var_1) {
  if(!isDefined(var_0)) {
    self notify("end_dog_sound");
    self._id_8F4B = undefined;
    return;
  }

  if(!isDefined(self._id_8F4B) || self._id_8F4B != var_0) {
    self notify("end_dog_sound");
    self._id_8F4B = var_0;

    if(var_0 == "bark") {
      thread _id_7202(var_1);
    } else if(var_0 == "growl") {
      thread _id_74A6(var_1);
    } else if(var_0 == "pant") {
      thread _id_74CD();
    } else {}
  }
}

_id_7202(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(!isDefined(self._id_159D)) {
    self._id_159D = 1;
    thread _id_A8EF();
  }
}

_id_A8EF() {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");
  wait(_randomintrange(5, 10));
  self._id_159D = undefined;
}

_id_74A6(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self._id_5BA5) && gettime() - self._id_5BA5 < 3000) {
    wait 3;
  }

  for(;;) {
    self._id_5BA5 = gettime();
    wait(_randomintrange(3, 6));
  }
}

_id_74CD(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self._id_5BC9) && gettime() - self._id_5BC9 < 3000) {
    wait 3;
  }

  self._id_5BC9 = gettime();

  for(;;) {
    if(self._id_0BA4 == "idle") {
      wait 3;
      continue;
    }

    self._id_5BC9 = gettime();
    wait(_randomintrange(6, 8));
  }
}

_id_A92D() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self._id_0117)) {
      return;
    }
    self._id_0117 waittill("damage", var_0, var_1);

    if(isPlayer(var_1) && var_1 != self._id_0117) {
      if(self._id_11B5 == "attacking") {
        continue;
      }
      if(distancesquared(self._id_0117.origin, self.origin) > self._id_6DAB) {
        continue;
      }
      if(distancesquared(self._id_0117.origin, var_1.origin) > self._id_6DAB) {
        continue;
      }
      self._id_0094 = var_1;
      self._id_3E0B = 1;
      thread _id_A909();
    }
  }
}

_id_A92E() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self._id_0117)) {
      return;
    }
    self._id_0117 waittill("death");

    switch (level.gametype) {
      case "sd":
        maps\mp\agents\_agent_utility::_id_5A39();
        break;
      case "sr":
        var_0 = level common_scripts\utility::waittill_any_return("sr_player_eliminated", "sr_player_respawned");

        if(isDefined(var_0) && var_0 == "sr_player_eliminated") {
          maps\mp\agents\_agent_utility::_id_5A39();
        }

        break;
    }
  }
}

_id_A92F() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self._id_0117)) {
      return;
    }
    var_0 = self._id_0117 common_scripts\utility::_id_A716("joined_team", "joined_spectators");

    if(isDefined(var_0) && (var_0 == "joined_team" || var_0 == "joined_spectators")) {
      maps\mp\agents\_agent_utility::_id_5A39();
    }
  }
}

_id_A909() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  self._id_0094 common_scripts\utility::_id_A71A(5.0, "death", "disconnect");
  self._id_0094 = undefined;
  self._id_3E0B = 0;
}

_id_6ADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self._id_99FC = gettime();

  if(isDefined(self._id_0117)) {
    self._id_29BC = vectorNormalize(self.origin - self._id_0117.origin);
  }

  if(_id_8B9B(var_2, var_5, var_4)) {
    switch (self._id_0BA4) {
      case "idle":
        thread maps\mp\agents\dog\_dog_idle::_id_6ADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        break;
      case "move":
        thread maps\mp\agents\dog\_dog_move::_id_6ADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        break;
    }
  }
}

_id_8B9B(var_0, var_1, var_2) {
  if(isDefined(var_1) && weaponclass(var_1) == "sniper") {
    return 1;
  }

  if(isDefined(var_2) && _isexplosivedamagemod(var_2) && var_0 >= 10) {
    return 1;
  }

  if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    return 1;
  }

  if(isDefined(var_1) && var_1 == "concussion_grenade_mp") {
    return 1;
  }

  return 0;
}

_id_6394() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && var_3 == self._id_0117) {
      continue;
    }
    switch (self._id_0BA4) {
      case "idle":
        maps\mp\agents\dog\_dog_idle::_id_6B3B();
        break;
      case "move":
        maps\mp\agents\dog\_dog_move::_id_6B3B();
        break;
    }
  }
}