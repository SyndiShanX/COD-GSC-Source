/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_conf.gsc
********************************************************/

main() {
  _id_87A7();
  _id_8790();
}

_id_87A7() {
  level.bot_funcs["gametype_think"] = ::_id_197D;
}

_id_8790() {
  level._id_1AF6 = 200;
  level._id_1AF5 = 38;
}

_id_197D() {
  self notify("bot_conf_think");
  self endon("bot_conf_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self._id_66B7 = gettime() + 500;
  self._id_95BB = [];
  childthread _id_1B29();

  if(self._id_6F7D == "camper") {
    self._id_257C = 0;

    if(!isDefined(self._id_257D))
      self._id_257D = 0;
  }

  for(;;) {
    var_0 = isDefined(self._id_95A8);
    var_1 = 0;

    if(var_0 && self bothasscriptgoal()) {
      var_2 = self botgetscriptgoal();

      if(maps\mp\bots\_bots_util::_id_1B1C(self._id_95A8._id_487B, var_2)) {
        if(self botpursuingscriptgoal())
          var_1 = 1;
      } else if(maps\mp\bots\_bots_strategy::_id_1A14("kill_tag") && self._id_95A8 _id_04D1::_id_1F53(self.team)) {
        self._id_95A8 = undefined;
        var_0 = 0;
      }
    }

    self botsetflag("force_sprint", var_1);
    self._id_95BB = _id_1AB5(self._id_95BB);
    var_3 = _id_19C9(self._id_95BB, 1);
    var_4 = isDefined(var_3);

    if(var_0 && !var_4 || !var_0 && var_4 || var_0 && var_4 && self._id_95A8 != var_3) {
      self._id_95A8 = var_3;
      self botclearscriptgoal();
      self notify("stop_camping_tag");
      maps\mp\bots\_bots_personality::_id_23AB();
      maps\mp\bots\_bots_strategy::_id_192C("kill_tag");
    }

    if(isDefined(self._id_95A8)) {
      self._id_257D = 0;

      if(self._id_6F7D == "camper" && self._id_257C) {
        self._id_257D = 1;

        if(maps\mp\bots\_bots_personality::_id_8B73()) {
          if(maps\mp\bots\_bots_personality::_id_3B64(self._id_95A8._id_487B, 1000))
            childthread _id_1954(self._id_95A8, "camp");
          else
            self._id_257D = 0;
        }
      }

      if(!self._id_257D) {
        if(!maps\mp\bots\_bots_strategy::_id_1A14("kill_tag")) {
          var_5 = spawnStruct();
          var_5.isstanceallowed = "objective";
          var_5._id_691E = level._id_1AF6;
          maps\mp\bots\_bots_strategy::_id_1A85("kill_tag", self._id_95A8._id_487B, 25, var_5);
        }
      }
    }

    var_6 = 0;

    if(isDefined(self._id_09B4))
      var_6 = self[[self._id_09B4]]();

    if(!isDefined(self._id_95A8)) {
      if(!var_6)
        self[[self._id_6F7F]]();
    }

    if(gettime() > self._id_66B7) {
      self._id_66B7 = gettime() + 500;
      var_7 = _id_19D1(1);
      self._id_95BB = _id_197C(var_7, self._id_95BB);
    }

    waitframe();
  }
}

_id_196E(var_0) {
  if(isDefined(var_0._id_6AA9) && var_0._id_6AA9) {
    var_1 = self.origin + (0, 0, 55);

    if(_distance2dsquared(var_0._id_28D4, var_1) < 144) {
      var_2 = var_0._id_28D4[2] - var_1[2];

      if(var_2 > 0) {
        if(var_2 < level._id_1AF5) {
          if(!isDefined(self._id_5B60))
            self._id_5B60 = 0;

          if(gettime() - self._id_5B60 > 3000) {
            self._id_5B60 = gettime();
            thread _id_1A3B();
          }
        } else {
          var_0._id_6AA9 = 0;
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_1A3B() {
  self endon("death");
  self endon("disconnect");
  self botsetstance("stand");
  wait 1.0;
  self botpressbutton("jump");
  wait 1.0;
  self botsetstance("none");
}

_id_1B29() {
  for(;;) {
    level waittill("new_tag_spawned", var_0);
    self._id_66B7 = -1;

    if(isDefined(var_0)) {
      if(isDefined(var_0._id_A490) && var_0._id_A490 == self || isDefined(var_0._id_1180) && var_0._id_1180 == self) {
        if(!isDefined(var_0._id_6AA9) && !isDefined(var_0._id_1E5A)) {
          thread _id_1E48(var_0);
          _id_A761(var_0);

          if(var_0._id_6AA9) {
            var_1 = spawnStruct();
            var_1.origin = var_0._id_28D4;
            var_1._id_95A6 = var_0;
            var_2[0] = var_1;
            self._id_95BB = _id_197C(var_2, self._id_95BB);
          }
        }
      }
    }
  }
}

_id_197C(var_0, var_1) {
  var_2 = var_1;

  foreach(var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(var_4._id_95A6 == var_7._id_95A6 && maps\mp\bots\_bots_util::_id_1B1C(var_4.origin, var_7.origin)) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5)
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
  }

  return var_2;
}

_id_1A37(var_0, var_1, var_2) {
  if(!var_0._id_1E4D) {
    var_0._id_6638 = _getclosestnodeinsight(var_0._id_28D4);
    var_0._id_1E4D = 1;
  }

  if(isDefined(var_0._id_1E5A))
    return 0;

  var_3 = var_0._id_6638;
  var_4 = !isDefined(var_0._id_6AA9);

  if(isDefined(var_3) && (var_4 || var_0._id_6AA9)) {
    var_5 = var_3 == var_1 || _nodesvisible(var_3, var_1, 1);

    if(var_5) {
      var_6 = common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_0._id_28D4, var_2);

      if(var_6) {
        if(var_4) {
          thread _id_1E48(var_0);
          _id_A761(var_0);

          if(!var_0._id_6AA9)
            return 0;
        }

        return 1;
      }
    }
  }

  return 0;
}

_id_19D1(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = self getnearestnode();

  var_4 = undefined;

  if(isDefined(var_2))
    var_4 = var_2;
  else
    var_4 = self botgetfovdot();

  var_5 = [];

  if(isDefined(var_3)) {
    foreach(var_7 in level._id_31F9) {
      if(var_7 _id_04D1::_id_1F53(self.team)) {
        var_8 = 0;

        if(!var_0 || var_7._id_1180 == self) {
          if(!isDefined(var_7._id_1E5A)) {
            if(!isDefined(var_7._id_6AA9)) {
              level thread _id_1E48(var_7);
              _id_A761(var_7);
            }

            var_8 = distancesquared(self.origin, var_7._id_487B) < 1000000 && var_7._id_6AA9;
          }
        } else if(_id_1A37(var_7, var_3, var_4))
          var_8 = 1;

        if(var_8) {
          var_9 = spawnStruct();
          var_9.origin = var_7._id_28D4;
          var_9._id_95A6 = var_7;
          var_5 = common_scripts\utility::_id_0F6F(var_5, var_9);
        }
      }
    }
  }

  return var_5;
}

_id_1E48(var_0) {
  var_0 endon("reset");
  var_0._id_1E5A = 1;
  var_0._id_6AA9 = maps\mp\bots\_bots_util::_id_1A9D(var_0._id_28D4, undefined, level._id_1AF5 + 55);

  if(var_0._id_6AA9) {
    var_0._id_487B = _getgroundposition(var_0._id_28D4, 0, 256, 32);

    if(!isDefined(var_0._id_487B))
      var_0._id_6AA9 = 0;
  }

  var_0._id_1E5A = undefined;
}

_id_A761(var_0) {
  while(!isDefined(var_0._id_6AA9))
    waitframe();
}

_id_19C9(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_3 = 1409865409;

    foreach(var_5 in var_0) {
      var_6 = _id_424F(var_5._id_95A6);

      if(!var_1 || var_6 < 2) {
        var_7 = distancesquared(var_5._id_95A6._id_487B, self.origin);

        if(var_7 < var_3) {
          var_2 = var_5._id_95A6;
          var_3 = var_7;
        }
      }
    }
  }

  return var_2;
}

_id_1AB5(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3._id_95A6 _id_04D1::_id_1F53(self.team) && maps\mp\bots\_bots_util::_id_1B1C(var_3._id_95A6._id_28D4, var_3.origin)) {
      if(!_id_196E(var_3._id_95A6) && var_3._id_95A6._id_6AA9)
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
    }
  }

  return var_1;
}

_id_424F(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_6E97) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_3 != self) {
      if(_isai(var_3)) {
        if(isDefined(var_3._id_95A8) && var_3._id_95A8 == var_0)
          var_1++;

        continue;
      }

      if(distancesquared(var_3.origin, var_0._id_28D4) < 160000)
        var_1++;
    }
  }

  return var_1;
}

_id_1954(var_0, var_1, var_2) {
  self notify("bot_camp_tag");
  self endon("bot_camp_tag");
  self endon("stop_camping_tag");

  if(isDefined(var_2))
    self endon(var_2);

  self botsetscriptgoalnode(self._id_6708, var_1, self._id_0D94);
  var_3 = maps\mp\bots\_bots_util::_id_1B21();

  if(var_3 == "goal") {
    var_4 = var_0._id_6638;

    if(isDefined(var_4)) {
      var_5 = _findentrances(self.origin);
      var_5 = common_scripts\utility::_id_0F6F(var_5, var_4);
      childthread maps\mp\bots\_bots_util::_id_1B2A(var_5);
    }
  }
}