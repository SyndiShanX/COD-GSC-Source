/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_common.gsc
**********************************************************/

_id_194E() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level._id_1913) {
    var_0[var_2] = common_scripts\utility::random(var_4._id_1B49).origin;
    var_1[var_2] = "zone" + var_4.label;
    var_2++;
  }

  _id_194D(var_0, var_1);
}

_id_194F(var_0, var_1, var_2, var_3) {
  wait 1.0;
  var_4 = [];
  var_5 = [];
  var_6 = 0;

  foreach(var_10, var_8 in var_0) {
    if(isDefined(var_0[var_10]._id_1B48)) {
      var_4[var_6] = var_0[var_10]._id_1B48.origin;
    } else {
      var_0[var_10]._id_6638 = _getclosestnodeinsight(var_0[var_10].origin);

      if(!isDefined(var_0[var_10]._id_6638) || var_0[var_10]._id_6638 nodeisdisconnected()) {
        var_9 = _getnodesinradiussorted(var_0[var_10].origin, 256, 0);

        if(var_9.size > 0) {
          var_0[var_10]._id_6638 = var_9[0];
        }
      }

      if(!isDefined(var_0[var_10]._id_6638)) {
        continue;
      }
      if(distance(var_0[var_10]._id_6638.origin, var_0[var_10].origin) > 128) {
        var_0[var_10]._id_6638 = undefined;
        continue;
      }

      var_4[var_6] = var_0[var_10]._id_6638.origin;
    }

    var_5[var_6] = var_1 + var_0[var_10].shootblank;
    var_6++;
  }

  _id_194D(var_4, var_5, var_2, var_3);
}

_id_194D(var_0, var_1, var_2, var_3) {
  var_4 = !isDefined(var_2) || !var_2;
  var_5 = isDefined(var_3) && var_3;
  wait 0.1;

  if(var_5 && var_4) {
    var_6 = _getallnodes();

    foreach(var_8 in var_6) {
      var_8._id_6AA8 = undefined;
    }
  }

  var_10 = [];

  for(var_11 = 0; var_11 < var_0.size; var_11++) {
    var_12 = var_1[var_11];
    var_10[var_12] = _findentrances(var_0[var_11]);
    waitframe();

    for(var_13 = 0; var_13 < var_10[var_12].size; var_13++) {
      var_14 = var_10[var_12][var_13];
      var_14._id_55F0 = 1;
      var_14._id_7779[var_12] = maps\mp\bots\_bots_util::_id_37DF(var_14.origin, var_0[var_11], "prone");
      waitframe();
      var_14._id_2864[var_12] = maps\mp\bots\_bots_util::_id_37DF(var_14.origin, var_0[var_11], "crouch");
      waitframe();
    }
  }

  var_15 = [];

  if(var_4) {
    for(var_11 = 0; var_11 < var_0.size; var_11++) {
      for(var_13 = var_11 + 1; var_13 < var_0.size; var_13++) {
        var_16 = maps\mp\bots\_bots_util::_id_4187(var_0[var_11], var_0[var_13]);

        foreach(var_8 in var_16) {
          var_8._id_6AA8[var_1[var_11]][var_1[var_13]] = 1;
        }
      }
    }
  }

  if(!isDefined(level._id_37DB)) {
    level._id_37DB = [];
  }

  if(!isDefined(level._id_37DA)) {
    level._id_37DA = [];
  }

  if(!isDefined(level._id_37DC)) {
    level._id_37DC = [];
  }

  if(var_5) {
    level._id_37DB = var_0;
    level._id_37DA = var_1;
    level._id_37DC = var_10;
  } else {
    level._id_37DB = common_scripts\utility::_id_0F73(level._id_37DB, var_0);
    level._id_37DA = common_scripts\utility::_id_0F73(level._id_37DA, var_1);
    level._id_37DC = common_scripts\utility::_id_0F76(level._id_37DC, var_10);
  }

  level._id_37DD = 1;
}

_id_192E(var_0, var_1) {
  if(var_1.classname == "trigger_radius") {
    var_2 = _getnodesinradius(var_1.origin, var_1.radius, 0, 100);
    var_3 = common_scripts\utility::_id_0F94(var_2, var_0);

    if(var_3.size > 0) {
      var_0 = common_scripts\utility::_id_0F73(var_0, var_3);
    }
  } else if(var_1.classname == "trigger_multiple" || var_1.classname == "trigger_use_touch") {
    var_4[0] = var_1 getpointinbounds(1, 1, 1);
    var_4[1] = var_1 getpointinbounds(1, 1, -1);
    var_4[2] = var_1 getpointinbounds(1, -1, 1);
    var_4[3] = var_1 getpointinbounds(1, -1, -1);
    var_4[4] = var_1 getpointinbounds(-1, 1, 1);
    var_4[5] = var_1 getpointinbounds(-1, 1, -1);
    var_4[6] = var_1 getpointinbounds(-1, -1, 1);
    var_4[7] = var_1 getpointinbounds(-1, -1, -1);
    var_5 = 0;

    foreach(var_7 in var_4) {
      var_8 = distance(var_7, var_1.origin);

      if(var_8 > var_5) {
        var_5 = var_8;
      }
    }

    var_2 = _getnodesinradius(var_1.origin, var_5, 0, 200);

    foreach(var_11 in var_2) {
      if(!_ispointinvolume(var_11.origin, var_1)) {
        if(_ispointinvolume(var_11.origin + (0, 0, 40), var_1) || _ispointinvolume(var_11.origin + (0, 0, 80), var_1) || _ispointinvolume(var_11.origin + (0, 0, 120), var_1)) {
          var_0 = common_scripts\utility::_id_0F6F(var_0, var_11);
        }
      }
    }
  }

  return var_0;
}

_id_1ADB() {
  wait 1.0;
  _id_1ADC(level._id_1913);
  level._id_1AD2 = 1;
}

_id_1ADC(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_1B49)) {
      var_2._id_1B49 = _id_1A08(var_2._id_9D65);
    }
  }
}

_id_19E1(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_6E97) {
    if(maps\mp\_utility::_id_5800(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_19DF(var_0, var_1, var_2) {
  var_3 = _id_19E2("attacker", var_0);

  foreach(var_5 in level.players) {
    if(!_isai(var_5) && isDefined(var_5.team) && var_5.team == var_0) {
      if(var_5 _id_19E4() || distancesquared(var_1, var_5.origin) > _squared(var_2)) {
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
      }
    }
  }

  return var_3;
}

_id_19E0(var_0, var_1, var_2) {
  var_3 = _id_19E2("defender", var_0);

  foreach(var_5 in level.players) {
    if(!_isai(var_5) && isDefined(var_5.team) && var_5.team == var_0) {
      if(var_5 _id_19E5() || distancesquared(var_1, var_5.origin) <= _squared(var_2)) {
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
      }
    }
  }

  return var_3;
}

_id_19E4() {
  if(isDefined(level._id_19E3)) {
    return self[[level._id_19E3]]();
  }

  return 0;
}

_id_19E5() {
  if(isDefined(level._id_19E6)) {
    return self[[level._id_19E6]]();
  }

  return 0;
}

_id_19E9(var_0) {
  self._id_7ECA = var_0;
  self botclearscriptgoal();
  maps\mp\bots\_bots_strategy::_id_19A3();
}

_id_19E2(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_6E97) {
    if(isDefined(var_4.team) && isalive(var_4) && maps\mp\_utility::_id_5800(var_4) && var_4.team == var_1 && isDefined(var_4._id_7ECA) && var_4._id_7ECA == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_19E7() {
  var_0 = [[level._id_19D6]](self.team);
  var_1 = [[level._id_19D7]](self.team);
  var_2 = [[level._id_19DB]](self.team);
  var_3 = [[level._id_19DE]](self.team);
  var_4 = level._id_1A92[self._id_6F7D];

  if(var_4 == "active") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(_isai(var_7) && level._id_1A92[var_7._id_6F7D] == "stationary" && var_7 _id_195B()) {
          var_7._id_7ECA = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        _id_19E9("attacker");
        return;
      }

      _id_19E9("defender");
      return;
    } else
      _id_19E9("attacker");
  } else if(var_4 == "stationary") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(_isai(var_10) && level._id_1A92[var_10._id_6F7D] == "active" && var_10 _id_195A()) {
          var_10._id_7ECA = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        _id_19E9("defender");
        return;
      }

      _id_19E9("attacker");
      return;
    } else
      _id_19E9("defender");
  }
}

_id_19DA() {
  level notify("bot_gametype_attacker_defender_ai_director_update");
  level endon("bot_gametype_attacker_defender_ai_director_update");
  level endon("game_ended");
  var_0 = ["allies", "axis"];
  var_1 = gettime() + 2000;

  for(;;) {
    if(gettime() > var_1) {
      var_1 = gettime() + 1000;

      foreach(var_3 in var_0) {
        var_4 = [[level._id_19D6]](var_3);
        var_5 = [[level._id_19D7]](var_3);
        var_6 = [[level._id_19DB]](var_3);
        var_7 = [[level._id_19DE]](var_3);

        if(var_4.size > var_6) {
          var_8 = [];
          var_9 = 0;

          foreach(var_11 in var_4) {
            if(_isai(var_11) && var_11 _id_195B()) {
              if(level._id_1A92[var_11._id_6F7D] == "stationary") {
                var_11 _id_19E9("defender");
                var_9 = 1;
                break;
              } else
                var_8 = common_scripts\utility::_id_0F6F(var_8, var_11);
            }
          }

          if(!var_9 && var_8.size > 0) {
            common_scripts\utility::random(var_8) _id_19E9("defender");
          }
        }

        if(var_5.size > var_7) {
          var_13 = [];
          var_14 = 0;

          foreach(var_16 in var_5) {
            if(_isai(var_16) && var_16 _id_195A()) {
              if(level._id_1A92[var_16._id_6F7D] == "active") {
                var_16 _id_19E9("attacker");
                var_14 = 1;
                break;
              } else
                var_13 = common_scripts\utility::_id_0F6F(var_13, var_16);
            }
          }

          if(!var_14 && var_13.size > 0) {
            common_scripts\utility::random(var_13) _id_19E9("attacker");
          }
        }
      }
    }

    waitframe();
  }
}

_id_195A() {
  if(isDefined(level._id_19D8)) {
    return self[[level._id_19D8]]();
  }

  return 1;
}

_id_195B() {
  if(isDefined(level._id_19D9)) {
    return self[[level._id_19D9]]();
  }

  return 1;
}

_id_1B1D(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_1913) {}

  if(!var_1) {
    _id_194E();
  }

  return !var_1;
}

_id_1A08(var_0) {
  var_1 = _getnodesintrigger(var_0, 1);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!var_4 nodeisdisconnected() && var_4.type != "Begin" && var_4.type != "End") {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_1951(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = 0;
    var_5._id_37DA = [];
    var_5._id_AC7F = _id_1E4B(var_5);
    var_5._id_206D = _id_AC85(var_5, 0, 0);
    var_7 = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];

    foreach(var_9 in var_7) {
      var_10 = _id_AC85(var_5, var_9[0], var_9[1]);
      var_1[var_3] = var_10.origin;
      var_11 = var_5.shootblank + "_" + var_6;
      var_2[var_3] = var_11;
      var_5._id_37DA[var_5._id_37DA.size] = var_11;
      var_3++;
      var_6++;
    }
  }

  _id_194D(var_1, var_2, 1);
}

_id_1E4B(var_0) {
  var_1 = spawnStruct();
  var_1._id_61B1 = (999999, 999999, 999999);
  var_1._id_605E = (-999999, -999999, -999999);

  foreach(var_3 in var_0._id_671A) {
    var_1._id_61B1 = (_min(var_3.origin[0], var_1._id_61B1[0]), _min(var_3.origin[1], var_1._id_61B1[1]), _min(var_3.origin[2], var_1._id_61B1[2]));
    var_1._id_605E = (max(var_3.origin[0], var_1._id_605E[0]), max(var_3.origin[1], var_1._id_605E[1]), max(var_3.origin[2], var_1._id_605E[2]));
  }

  var_1._id_206B = ((var_1._id_61B1[0] + var_1._id_605E[0]) / 2, (var_1._id_61B1[1] + var_1._id_605E[1]) / 2, (var_1._id_61B1[2] + var_1._id_605E[2]) / 2);
  var_1._id_4954 = (var_1._id_605E[0] - var_1._id_206B[0], var_1._id_605E[1] - var_1._id_206B[1], var_1._id_605E[2] - var_1._id_206B[2]);
  var_1.radius = max(var_1._id_4954[0], var_1._id_4954[1]);
  return var_1;
}

_id_AC85(var_0, var_1, var_2) {
  var_3 = (var_0._id_AC7F._id_206B[0] + var_1 * var_0._id_AC7F._id_4954[0], var_0._id_AC7F._id_206B[1] + var_2 * var_0._id_AC7F._id_4954[1], 0);
  var_4 = undefined;
  var_5 = 9999999;

  foreach(var_7 in var_0._id_671A) {
    var_8 = _distance2dsquared(var_7.origin, var_3);

    if(var_8 < var_5) {
      var_5 = var_8;
      var_4 = var_7;
    }
  }

  return var_4;
}

_id_6361() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = _getzonenearest(self.origin);

  for(;;) {
    var_1 = "none";

    if(isDefined(self._id_3FCA)) {
      var_1 = self._id_3FCA _id_04D1::_id_45F7();
    }

    if(var_1 == "neutral" || var_1 == "none") {
      _botzonesetteam(var_0, "free");
    } else {
      _botzonesetteam(var_0, var_1);
    }

    wait 1.0;
  }
}

_id_62EA() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = _getzonenearest(self._id_28D4);

  for(;;) {
    if(self._id_18F9) {
      var_1 = common_scripts\utility::_id_416F(self._id_6DB2);
    } else {
      var_1 = self._id_6DB2;
    }

    if(var_1 == "neutral" || var_1 == "any") {
      var_1 = "free";
    }

    _botzonesetteam(var_0, var_1);
    wait 1.0;
  }
}

_id_3B69(var_0) {
  var_1 = undefined;
  var_2 = 999999999;

  foreach(var_4 in level._id_1913) {
    var_5 = distancesquared(var_4._id_28D4, var_0.origin);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

_id_41FB(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_6E97) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(maps\mp\_utility::isreallyalive(var_4) && maps\mp\_utility::_id_5800(var_4) && var_4.team == var_0) {
      if(!isDefined(var_1) || var_1 && _isai(var_4) && isDefined(var_4._id_7ECA)) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_40DF(var_0, var_1) {
  if(var_0._id_1B49.size >= 2) {
    if(var_1) {
      var_2 = self botnodescoremultiple(var_0._id_1B49, "node_exposed");
    } else {
      var_2 = self botnodescoremultiple(var_0._id_1B49, "node_hide_anywhere", "ignore_occupancy");
    }

    var_3 = self botgetdifficultysetting("strategyLevel") * 0.3;
    var_4 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
    var_5 = common_scripts\utility::array_randomize(var_0._id_1B49);

    foreach(var_7 in var_5) {
      if(!common_scripts\utility::_id_0F79(var_2, var_7)) {
        var_2[var_2.size] = var_7;
      }
    }

    if(_randomfloat(1.0) < var_3) {
      return var_2[0];
      return;
    }

    if(_randomfloat(1.0) < var_4) {
      return var_2[1];
      return;
    }

    return common_scripts\utility::random(var_2);
    return;
    return;
  } else
    return var_0._id_1B49[0];
}

_id_40DE(var_0) {
  var_1 = self botnodescoremultiple(var_0._id_1B49, "node_hide_anywhere", "ignore_occupancy");
  var_2 = self botgetdifficultysetting("strategyLevel") * 0.3;
  var_3 = (self botgetdifficultysetting("strategyLevel") + 1) * 0.15;
  var_4 = common_scripts\utility::array_randomize(var_0._id_1B49);

  foreach(var_6 in var_4) {
    if(!common_scripts\utility::_id_0F79(var_1, var_6)) {
      var_1[var_1.size] = var_6;
    }
  }

  if(_randomfloat(1.0) < var_2) {
    return var_1[0];
  } else if(_randomfloat(1.0) < var_3) {
    return var_1[1];
  } else {
    return common_scripts\utility::random(var_1);
  }
}

_id_1911(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_4 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_4 = 80;
  }

  if(randomint(100) < var_4 && !(isDefined(var_3) && var_3)) {
    self botsetstance("prone");
    wait 0.2;
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var_2) {
    childthread _id_6800();
    childthread _id_67FA();
  }

  self botpressbutton("use", var_0);
  var_5 = maps\mp\bots\_bots_util::_id_1B16(var_0, var_1, "use_interrupted");
  self botsetstance("none");
  self botclearbutton("use");
  var_6 = var_5 == var_1;
  return var_6;
}

_id_6800() {
  self endon("stop_usebutton_watcher");
  var_0 = _id_3B69(self);
  self waittill("bulletwhizby", var_1);

  if(!isDefined(var_1.team) || var_1.team != self.team) {
    var_2 = var_0._id_A23F - var_0._id_28D5;

    if(var_2 > 1000) {
      self notify("use_interrupted");
    }
  }
}

_id_67FA() {
  self endon("stop_usebutton_watcher");
  self waittill("damage", var_0, var_1);

  if(!isDefined(var_1.team) || var_1.team != self.team) {
    self notify("use_interrupted");
  }
}

_id_4065(var_0) {
  var_1 = [];
  var_2 = _id_41FB(common_scripts\utility::_id_416F(self.team));

  foreach(var_4 in var_2) {
    if(!_isai(var_4)) {
      continue;
    }
    var_5 = 0;

    if(var_0 == "plant") {
      var_5 = 300 + var_4 botgetdifficultysetting("strategyLevel") * 100;
    } else if(var_0 == "defuse") {
      var_5 = 500 + var_4 botgetdifficultysetting("strategyLevel") * 500;
    }

    if(distancesquared(var_4.origin, self.origin) < _squared(var_5)) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}