/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_infect.gsc
**********************************************************/

main() {
  _id_87A7();
  _id_8797();
}

_id_87A7() {
  level.bot_funcs["gametype_think"] = ::_id_1A21;
  level.bot_funcs["should_pickup_weapons"] = ::_id_1AE4;
}

_id_8797() {
  level._id_1B3D = 1;
  level._id_1B3F = 1;
  level._id_1B3E = 1;
  level._id_5119 = "throwingknife_mp";
  thread _id_1A1D();
}

_id_1AE4() {
  if(level._id_5111 && self.team == "axis") {
    return 0;
  }

  return maps\mp\bots\_bots::_id_1AE3();
}

_id_1A21() {
  self notify("bot_infect_think");
  self endon("bot_infect_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  childthread _id_1A20();

  for(;;) {
    if(level._id_5111) {
      if(self.team == "axis" && self botgetpersonality() != "run_and_gun") {
        maps\mp\bots\_bots_util::_id_1AD5("run_and_gun");
      }
    }

    if(self._id_1AFA != self.team) {
      self._id_1AFA = self.team;
    }

    if(self.team == "axis") {
      var_0 = maps\mp\bots\_bots_strategy::_id_1A7A();

      if(!isDefined(var_0) || var_0) {
        self botclearscriptgoal();
      }
    }

    self[[self._id_6F7F]]();
    waitframe();
  }
}

_id_1A1D() {
  level notify("bot_infect_ai_director_update");
  level endon("bot_infect_ai_director_update");
  level endon("game_ended");

  for(;;) {
    var_0 = [];
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3._id_52D5) && var_3.health > 0 && isDefined(var_3.team) && (var_3.team == "allies" || var_3.team == "axis")) {
        var_3._id_52D5 = gettime();
      }

      if(isDefined(var_3._id_52D5) && gettime() - var_3._id_52D5 > 5000) {
        if(!isDefined(var_3.team)) {
          continue;
        }
        if(var_3.team == "axis") {
          var_0[var_0.size] = var_3;
          continue;
        }

        if(var_3.team == "allies") {
          var_1[var_1.size] = var_3;
        }
      }
    }

    if(var_0.size > 0 && var_1.size > 0) {
      var_5 = 1;

      foreach(var_7 in var_1) {
        if(isbot(var_7)) {
          var_5 = 0;
        }
      }

      if(var_5) {
        foreach(var_3 in var_1) {
          if(!isDefined(var_3._id_5B2B)) {
            var_3._id_5B2B = gettime();
            var_3._id_5B2A = var_3.origin;
            var_3._id_99E4 = 0;
          }

          if(gettime() >= var_3._id_5B2B + 5000) {
            var_3._id_5B2B = gettime();
            var_10 = distancesquared(var_3.origin, var_3._id_5B2A);
            var_3._id_5B2A = var_3.origin;

            if(var_10 < 90000) {
              var_3._id_99E4 = var_3._id_99E4 + 5000;

              if(var_3._id_99E4 >= 20000) {
                var_11 = common_scripts\utility::_id_40B0(var_3.origin, var_0);

                foreach(var_13 in var_11) {
                  if(isbot(var_13)) {
                    var_14 = var_13 botgetscriptgoaltype();

                    if(var_14 != "tactical" && var_14 != "critical") {
                      var_13 thread _id_4FA2(var_3);
                      break;
                    }
                  }
                }
              }
            } else {
              var_3._id_99E4 = 0;
              var_3._id_5B2A = var_3.origin;
            }
          }
        }
      }
    }

    wait 1.0;
  }
}

_id_4FA2(var_0) {
  self endon("disconnect");
  self endon("death");
  self botsetscriptgoal(var_0.origin, 0, "critical");
  maps\mp\bots\_bots_util::_id_1B21();
  self botclearscriptgoal();
}

_id_1A20() {
  if(self.team == "axis") {
    self._id_1F1A = 0;
    self._id_60D5 = undefined;
    self._id_60D7 = undefined;
    self._id_60D6 = 0;
    self._id_60DC = undefined;
    self._id_60DB = 0;
    var_0 = self botgetdifficultysetting("throwKnifeChance");

    if(var_0 < 0.25) {
      self botsetdifficultysetting("throwKnifeChance", 0.25);
    }

    self botsetdifficultysetting("allowGrenades", 1);

    for(;;) {
      if(self hasweapon(level._id_5119)) {
        if(maps\mp\_utility::_id_56FF(self._id_0088)) {
          var_1 = gettime();

          if(!isDefined(self._id_60D5) || self._id_60D5 != self._id_0088) {
            self._id_60D5 = self._id_0088;
            self._id_60D7 = self._id_0088 getnearestnode();
            self._id_60D6 = var_1;
          } else {
            var_2 = _squared(self botgetdifficultysetting("meleeDist"));

            if(distancesquared(self._id_0088.origin, self.origin) <= var_2) {
              self._id_1F1A = var_1;
            }

            var_3 = self._id_0088 getnearestnode();
            var_4 = self getnearestnode();

            if(!isDefined(self._id_60D7) || self._id_60D7 != var_3) {
              self._id_60D6 = var_1;
              self._id_60D7 = var_3;
            }

            if(!isDefined(self._id_60DC) || self._id_60DC != var_4) {
              self._id_60DB = var_1;
              self._id_60DC = var_4;
            } else if(distancesquared(self.origin, self._id_60DC.origin) > 9216)
              self._id_60DA = var_1;

            if(self._id_1F1A + 3000 < var_1) {
              if(self._id_60DB + 3000 < var_1) {
                if(self._id_60D6 + 3000 < var_1) {
                  if(_id_1A1E(self.origin, self._id_0088.origin)) {
                    maps\mp\bots\_bots_util::_id_1AA8("find_node_can_see_ent", ::_id_1A1F, self._id_0088, self._id_60DC);
                  }

                  if(!self getammocount(level._id_5119)) {
                    self setweaponammoclip(level._id_5119, 1);
                  }

                  maps\mp\_utility::waitfortimeornotify(30, "enemy");
                  self botclearscriptgoal();
                }
              }
            }
          }
        }
      }

      wait 0.25;
    }
  }
}

_id_1A1E(var_0, var_1) {
  if(_abs(var_0[2] - var_1[2]) > 56.0 && _distance2dsquared(var_0, var_1) < 2304) {
    return 1;
  }

  return 0;
}

_id_1A1F(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = 0;

  if(issubstr(var_1.type, "Begin")) {
    var_2 = 1;
  }

  var_3 = _getlinkednodes(var_1);

  if(isDefined(var_3) && var_3.size) {
    var_4 = common_scripts\utility::array_randomize(var_3);

    foreach(var_6 in var_4) {
      if(var_2 && issubstr(var_6.type, "End")) {
        continue;
      }
      if(_id_1A1E(var_6.origin, var_0.origin)) {
        continue;
      }
      var_7 = self getEye() - self.origin;
      var_8 = var_6.origin + var_7;
      var_9 = var_0.origin;

      if(isPlayer(var_0)) {
        var_9 = var_0 maps\mp\_utility::_id_469E();
      }

      if(_sighttracepassed(var_8, var_9, 0, self, var_0)) {
        var_10 = _vectortoyaw(var_9 - var_8);
        self botsetscriptgoalnode(var_6, "critical", var_10);
        maps\mp\bots\_bots_util::_id_1B21(3.0);
        return;
      }

      waitframe();
    }
  }
}