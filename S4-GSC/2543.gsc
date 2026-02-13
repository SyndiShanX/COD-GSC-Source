/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2543.gsc
*************************************************/

_id_1215(var_0) {
  return level._id_11EF[self._id_1210][var_0];
}

_id_D136(var_0, var_1) {
  self.team = var_0;
  self._id_002E = var_0;
  self.pers["team"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

_id_812C() {
  self._id_1210 = "player";
  self.pers = [];
  self._id_7552 = 0;
  self.isactive = 0;
  self._id_8735 = 1;
  self._id_10A22 = 0;
  self._id_E393 = 0;
  self._id_5501 = self getentitynumber();
  self._id_120F = 0;
  self._id_11F0 = 0;
  self._id_002D = undefined;
  self._id_0229 = 0;
  self.ignoreme = 0;
  self _meth_809E();
  _id_826D(0);
}

_id_826D(var_0) {
  if(!var_0) {
    self.class = undefined;
    self._id_8FAF = undefined;
    self._id_A25F = undefined;
    self._id_1FAF = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self._id_A8EC = undefined;
    self._id_F398 = undefined;
    self._id_32EC = undefined;
    self._id_31AC = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    self._id_904F = undefined;
    self._id_904C = undefined;
    scripts\common\input_allow::_id_38B0("weapon");
    scripts\common\input_allow::_id_38B0("weaponSwitch");
    scripts\common\input_allow::_id_38B0("offhandWeaps");
    scripts\common\input_allow::_id_38B0("usability");
    self._id_D9D7 = undefined;
    self._id_C0FB = undefined;
  } else {
    self._id_A25F = 1;
    self._id_1FAF = 5;
    self.guid = scripts\mp\utility\player::getuniqueid();
    self.name = self.guid;
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self._id_D9D7 = 0;
    self._id_C0FB = 0;
    self._id_11F0 = 1;

    if(scripts\mp\utility\entity::_id_8877(self)) {
      self._id_A8EC = 1;
      _id_07D6::_id_805E();
    }
  }
}

_id_6A56(var_0) {
  var_1 = undefined;

  if(isDefined(level.agentarray)) {
    foreach(var_3 in level.agentarray) {
      if(!isDefined(var_3.isactive) || !var_3.isactive) {
        if(isDefined(var_3._id_10847) && var_3._id_10847) {
          continue;
        }
        var_1 = var_3;
        var_1 _id_812C();

        if(isDefined(var_0)) {
          var_1._id_1210 = var_0;
        }

        break;
      }
    }
  }

  return var_1;
}

_id_0EE4() {
  self.isactive = 1;
}

_id_4386() {
  thread _id_4387();
}

_id_4387() {
  self notify("deactivateAgentDelayed");
  self endon("deactivateAgentDelayed");

  if(scripts\mp\utility\entity::_id_8877(self)) {
    _id_0817::_id_C4B0();
  }

  _id_0817::_id_C4A7();
  wait 0.05;
  self.isactive = 0;
  self._id_7552 = 0;
  self.owner = undefined;
  self._id_3B86 = undefined;
  self._id_10847 = undefined;

  foreach(var_1 in level.characters) {
    if(isDefined(var_1._id_1DDE)) {
      foreach(var_4, var_3 in var_1._id_1DDE) {
        if(var_3 == self) {
          var_1._id_1DDE[var_4] = undefined;
        }
      }
    }
  }

  if(isDefined(self._id_7611)) {
    self detach(self._id_7611);
    self._id_7611 = undefined;
  }

  self notify("disconnect");
}

_id_6BAB(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = _id_6882(var_0);
  return var_1.size;
}

_id_6882(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_0 == "all" || var_3._id_1210 == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_6BB4(var_0) {
  return _id_6BB5(var_0, "all");
}

_id_6BB5(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level.agentarray)) {
    return var_2;
  }

  foreach(var_4 in level.agentarray) {
    if(isDefined(var_4.isactive) && var_4.isactive) {
      if(isDefined(var_4.owner) && var_4.owner == var_0) {
        if(var_1 == "all" && var_4._id_1210 != "alien" || var_4._id_1210 == var_1) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

_id_6BB6(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level.agentarray)) {
    return var_2;
  }

  foreach(var_4 in level.agentarray) {
    if(isDefined(var_4.isactive) && var_4.isactive) {
      if(isDefined(var_4.team) && var_4.team == var_0) {
        if(var_1 == "all" && var_4._id_1210 != "alien" || var_4._id_1210 == var_1) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

_id_6DF2(var_0, var_1, var_2) {
  var_3 = _func_00B4(self.origin, 350, 64, 128, "Path");

  if(!isDefined(var_3) || var_3.size == 0) {
    return undefined;
  }

  if(isDefined(level._id_10C5D) && isDefined(level._id_F63D)) {
    var_4 = var_3;
    var_3 = [];

    foreach(var_6 in var_4) {
      if(var_6.origin[2] > level._id_10C5D || !_func_011A(var_6.origin, level._id_F63D)) {
        var_3[var_3.size] = var_6;
      }
    }
  }

  var_8 = anglesToForward(self.angles);
  var_9 = -10;
  var_10 = _id_0817::_id_6C6C(self);
  var_11 = (0, 0, var_10);

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_12 = [];
  var_13 = [];

  foreach(var_15 in var_3) {
    if(!var_15 _meth_80B9("stand") || isDefined(var_15._id_A502)) {
      continue;
    }
    if(isDefined(level._id_20EC) && scripts\engine\utility::array_contains(level._id_20EC, var_15)) {
      continue;
    }
    var_16 = vectornormalize(var_15.origin - self.origin);
    var_17 = vectordot(var_8, var_16);

    for(var_18 = 0; var_18 < var_13.size; var_18++) {
      if(var_17 > var_13[var_18]) {
        for(var_19 = var_13.size; var_19 > var_18; var_19--) {
          var_13[var_19] = var_13[var_19 - 1];
          var_12[var_19] = var_12[var_19 - 1];
        }

        break;
      }
    }

    var_12[var_18] = var_15;
    var_13[var_18] = var_17;
  }

  var_21 = [];

  for(var_18 = 0; var_18 < var_12.size; var_18++) {
    var_15 = var_12[var_18];
    var_22 = self.origin + var_11;
    var_23 = var_15.origin + var_11;

    if(var_18 > 0) {
      wait 0.05;
    }

    if(!_func_0202(var_22, var_23, 0, self)) {
      continue;
    }
    if(var_1) {
      if(var_18 > 0) {
        wait 0.05;
      }

      var_24 = _func_019A(var_15.origin + var_11, var_15.origin);

      if(distancesquared(var_24, var_15.origin) > 1) {
        continue;
      }
    }

    if(var_0) {
      if(var_18 > 0) {
        wait 0.05;
      }

      var_24 = _func_0198(var_22, var_23);

      if(distancesquared(var_24, var_23) > 1) {
        continue;
      }
    }

    var_21[var_21.size] = var_15;

    if(var_21.size == var_2) {
      return var_21;
    }
  }

  return undefined;
}

_id_6E33(var_0, var_1) {
  var_2 = _id_6DF2(var_0, var_1, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  return var_2[0];
}

_id_8D5E(var_0) {
  var_0 dodamage(var_0.health + 500000, var_0.origin);
}

_id_8D71() {
  self[[_id_1215("on_damaged")]](level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0);
}