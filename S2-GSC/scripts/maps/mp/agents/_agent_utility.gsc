/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agent_utility.gsc
*****************************************************/

_id_0A5A(var_0) {
  return isDefined(level._id_0A41[self._id_0A4B][var_0]);
}

_id_0A59(var_0) {
  return level._id_0A41[self._id_0A4B][var_0];
}

hudoutlineenable(var_0, var_1) {
  self.team = var_0;
  self._id_000A = var_0;
  self.pers["team"] = var_0;
  self._id_0117 = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

_id_5291() {
  self._id_0A4B = "player";
  self.pers = [];
  self._id_4B60 = 0;
  self._id_565F = 0;
  self._id_5664 = 1;
  self._id_A87A = 0;
  self._id_57D6 = 0;
  self.entity_number = self getentitynumber();
  self._id_0A4A = 0;
  self._id_0A42 = 0;
  self._id_0009 = undefined;
  self._id_00CA = 0;
  self._id_00CE = 0;
  self detachall();
  _id_5334(0);
}

_id_5334(var_0) {
  if(!var_0) {
    self.class = undefined;
    self.lastclass = undefined;
    self._id_1444 = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.saved_actionslotdata = undefined;
    self._id_6F65 = undefined;
    self._id_696D = undefined;
    self._id_9AC5 = undefined;
    self._id_2016 = undefined;
    self._id_2310 = undefined;
    self._id_1F63 = undefined;
    self._id_5A3E = undefined;
    self._id_0179 = undefined;
    self.sessionstate = undefined;
    self._id_5BE2 = undefined;
    self._id_5BE0 = undefined;
    self._id_2F81 = undefined;
    self._id_2F82 = undefined;
    self._id_2F7E = undefined;
    self._id_2F80 = undefined;
    self._id_8AFE = undefined;
    self._id_8AFD = undefined;
  } else {
    self._id_1444 = 5;
    self.guid = maps\mp\_utility::_id_4704();
    self.name = self.guid;
    self._id_0179 = self.team;
    self.sessionstate = "playing";
    self._id_8AFE = 0;
    self._id_8AFD = 0;
    self._id_0A42 = 1;
    maps\mp\gametypes\_playerlogic::_id_8A40();
    _id_052D::_id_73C7();

    if(maps\mp\_utility::_id_56FF(self)) {
      self._id_696D = 1;
      _id_04D1::_id_5240();
      self._id_2F81 = 0;
      self._id_2F82 = 0;
      self._id_2F7E = 0;
    }
  }

  self._id_2F80 = 1;
}

_id_7D2A() {
  var_0 = undefined;

  if(isDefined(level._id_0A4E)) {
    foreach(var_2 in level._id_0A4E) {
      if(isDefined(var_2._id_565F) && var_2._id_565F) {
        continue;
      }
      if(isDefined(var_2._id_57A5) && var_2._id_57A5) {
        continue;
      }
      if(isDefined(var_2._id_A6ED) && var_2._id_A6ED) {
        continue;
      }
      if(isDefined(level._id_2DA2) && common_scripts\utility::_id_0F79(level._id_2DA2, var_2)) {
        continue;
      }
      var_0 = var_2;
      var_0._id_57A5 = 1;
      break;
    }
  }

  return var_0;
}

_id_34A8() {
  self._id_57A5 = 0;
}

_id_5344(var_0, var_1) {
  var_0 _id_34A8();
  var_0 _id_5291();

  if(isDefined(var_1)) {
    var_0._id_0A4B = var_1;
  }
}

_id_3B8C(var_0) {
  if(isDefined(level._id_0A4E)) {
    foreach(var_2 in level._id_0A4E) {
      if((!isDefined(var_2._id_565F) || !var_2._id_565F) && (!isDefined(var_2._id_57A5) || !var_2._id_57A5)) {
        if(isDefined(var_2._id_A6ED) && var_2._id_A6ED) {
          continue;
        }
        if(isDefined(level._id_2DA2) && common_scripts\utility::_id_0F79(level._id_2DA2, var_2)) {
          continue;
        }
        return var_2;
      }
    }
  }

  return undefined;
}

_id_44EE(var_0) {
  var_1 = _id_3B8C(var_0);

  if(isDefined(var_1)) {
    var_1 _id_5291();

    if(isDefined(var_0)) {
      var_1._id_0A4B = var_0;
    }

    return var_1;
  }

  return undefined;
}

_id_08A7() {
  self._id_565F = 1;
}

_id_2A73() {
  thread _id_2A74();
}

_id_2A74() {
  self notify("deactivateAgentDelayed");
  self endon("deactivateAgentDelayed");

  if(!isDefined(level._id_2DA2)) {
    level._id_2DA2 = [];
  }

  if(!common_scripts\utility::_id_0F79(level._id_2DA2, self)) {
    level._id_2DA2 = common_scripts\utility::_id_0F6F(level._id_2DA2, self);
  }

  if(maps\mp\_utility::_id_56FF(self)) {
    _id_050D::_id_7CDF();
  }

  _removefromcharactersarray(self);
  waitframe();
  self._id_565F = 0;
  self._id_4B60 = 0;
  self._id_0117 = undefined;
  self._id_2589 = undefined;
  self._id_A6ED = undefined;

  foreach(var_1 in _func_2D1()) {
    if(isDefined(var_1._id_1193)) {
      foreach(var_4, var_3 in var_1._id_1193) {
        if(var_3 == self) {
          var_1._id_1193[var_4] = undefined;
        }
      }
    }
  }

  self.headmodel = undefined;
  self detachall();
  self notify("disconnect");
  self agentclearscriptvars();
  level._id_2DA2 = common_scripts\utility::_id_0F93(level._id_2DA2, self);
}

_id_45BB(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = _id_43FD(var_0);
  return var_1.size;
}

_id_43FD(var_0) {
  var_1 = [];

  if(!isDefined(level._id_0A4E)) {
    return var_1;
  }

  foreach(var_3 in level._id_0A4E) {
    if(isDefined(var_3._id_565F) && var_3._id_565F) {
      if(var_0 == "all" || var_3._id_0A4B == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_45C7(var_0) {
  return _id_45C8(var_0, "all");
}

_id_45C8(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level._id_0A4E)) {
    return var_2;
  }

  foreach(var_4 in level._id_0A4E) {
    if(isDefined(var_4._id_565F) && var_4._id_565F) {
      if(isDefined(var_4._id_0117) && var_4._id_0117 == var_0) {
        if(var_1 == "all" || var_4._id_0A4B == var_1) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

_id_45AE(var_0) {
  if(!isDefined(level._id_60A5)) {
    level._id_60A5 = level.maxlives;
  } else {
    level._id_60A5++;
  }

  if(maps\mp\_utility::_id_585F()) {
    if(level._id_60A5 > 10000) {
      level._id_60A5 = level.maxlives;
    }
  }

  level._id_5CC7[level._id_60A5] = gettime();
  return level._id_60A5;
}

_id_470C(var_0, var_1) {
  var_2 = _getnodesinradius(self.origin, 350, 64, 128, "Path");

  if(!isDefined(var_2) || var_2.size == 0) {
    return undefined;
  }

  if(isDefined(level._id_A966) && isDefined(level._id_9DC7)) {
    var_3 = var_2;
    var_2 = [];

    foreach(var_5 in var_3) {
      if(var_5.origin[2] > level._id_A966 || !_ispointinvolume(var_5.origin, level._id_9DC7)) {
        var_2[var_2.size] = var_5;
      }
    }
  }

  var_7 = anglesToForward(self.angles);
  var_8 = -10;
  var_9 = _func_2D4(self);
  var_10 = (0, 0, var_9);

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_11 = [];
  var_12 = [];

  foreach(var_14 in var_2) {
    if(!var_14 doesnodeallowstance("stand")) {
      continue;
    }
    var_15 = vectorNormalize(var_14.origin - self.origin);
    var_16 = vectordot(var_7, var_15);

    for(var_17 = 0; var_17 < var_12.size; var_17++) {
      if(var_16 > var_12[var_17]) {
        for(var_18 = var_12.size; var_18 > var_17; var_18--) {
          var_12[var_18] = var_12[var_18 - 1];
          var_11[var_18] = var_11[var_18 - 1];
        }

        break;
      }
    }

    var_11[var_17] = var_14;
    var_12[var_17] = var_16;
  }

  for(var_17 = 0; var_17 < var_11.size; var_17++) {
    var_14 = var_11[var_17];
    var_20 = self.origin + var_10;
    var_21 = var_14.origin + var_10;

    if(var_17 > 0) {
      waitframe();
    }

    if(!_sighttracepassed(var_20, var_21, 0, self)) {
      continue;
    }
    if(var_1) {
      if(var_17 > 0) {
        waitframe();
      }

      var_22 = _playerphysicstrace(var_14.origin + var_10, var_14.origin);

      if(distancesquared(var_22, var_14.origin) > 1) {
        continue;
      }
    }

    if(var_0) {
      if(var_17 > 0) {
        waitframe();
      }

      var_22 = _physicstrace(var_20, var_21);

      if(distancesquared(var_22, var_21) > 1) {
        continue;
      }
    }

    return var_14;
  }
}

_id_5A28(var_0) {
  var_0 dodamage(var_0.health + 500000, var_0.origin);
}

_id_5A39() {
  self[[_id_0A59("on_damaged")]](level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0, "");
}

deleteentonagentdeath(var_0) {
  if(!isDefined(self.agentondeathcleanup)) {
    self.agentondeathcleanup = [];
  }

  self.agentondeathcleanup[self.agentondeathcleanup.size] = var_0;
  thread watchentdeleteforagentdeath(var_0);
}

watchentdeleteforagentdeath(var_0) {
  self endon("death");
  var_0 common_scripts\utility::_id_A70A("death", "entitydeleted");
  self.agentondeathcleanup = common_scripts\utility::_id_0F93(self.agentondeathcleanup, var_0);
}

cleanupentsonagentdeath() {
  if(isDefined(self.agentondeathcleanup)) {
    foreach(var_1 in self.agentondeathcleanup) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

get_max_agents() {
  var_0 = _getmaxagents();

  if(isDefined(level.overridemaxagents)) {
    var_0 = level.overridemaxagents;
  }

  return var_0;
}