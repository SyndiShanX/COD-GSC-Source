/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_to_air.gsc
****************************************************/

main() {
  _id_D795();
  _id_D762();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_26F7;
}

_id_D762() {
  level._id_28F3 = 200;
  level._id_28F2 = 38;
}

_id_26F7() {
  self notify("bot_air_think");
  self endon("bot_air_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self._id_A487 = gettime() + 500;
  self._id_ED71 = [];
  childthread _id_2924();

  if(self._id_B023 == "camper") {
    self._id_3B6F = 0;

    if(!isDefined(self._id_3B70)) {
      self._id_3B70 = 0;
    }
  }

  for(;;) {
    var_0 = isDefined(self._id_ED39);
    var_1 = 0;

    if(var_0 && self _meth_8042()) {
      var_2 = self _meth_803B();

      if(scripts\mp\bots\bots_util::_id_2916(self._id_ED39._id_4140, var_2)) {
        if(self _meth_804F()) {
          var_1 = 1;
        }
      } else if(_id_09F9::_id_27ED("kill_tag") && self._id_ED39 _id_07D6::_id_318C(self.team)) {
        self._id_ED39 = undefined;
        var_0 = 0;
      }
    }

    self _meth_8054("force_sprint", var_1);
    self._id_ED71 = _id_28A7(self._id_ED71);
    var_3 = _id_278D(self._id_ED71, 1);
    var_4 = isDefined(var_3);

    if(var_0 && !var_4 || !var_0 && var_4 || var_0 && var_4 && self._id_ED39 != var_3) {
      self._id_ED39 = var_3;
      self _meth_802B();
      self notify("stop_camping_tag");
      _id_09F7::_id_38BF();
      _id_09F9::_id_26EF("kill_tag");
    }

    if(isDefined(self._id_ED39)) {
      self._id_3B70 = 0;

      if(self._id_B023 == "camper" && self._id_3B6F) {
        self._id_3B70 = 1;

        if(_id_09F7::_id_DACD()) {
          if(_id_09F7::_id_5AB1(self._id_ED39._id_4140, 1000)) {
            childthread _id_2717(self._id_ED39, "camp");
          } else {
            self._id_3B70 = 0;
          }
        }
      }

      if(!self._id_3B70) {
        if(!_id_09F9::_id_27ED("kill_tag")) {
          var_5 = spawnStruct();
          var_5._id_CD73 = "objective";
          var_5._id_A8A8 = level._id_28F3;
          _id_09F9::_id_2862("kill_tag", self._id_ED39._id_4140, 25, var_5);
        }
      }
    }

    var_6 = 0;

    if(isDefined(self._id_10D1)) {
      var_6 = self[[self._id_10D1]]();
    }

    if(!isDefined(self._id_ED39)) {
      if(!var_6) {
        self[[self._id_B025]]();
      }
    }

    if(gettime() > self._id_A487) {
      self._id_A487 = gettime() + 500;
      var_7 = _id_2796(1);
      self._id_ED71 = _id_273B(var_7, self._id_ED71);
    }

    wait 0.05;
  }
}

_id_272C(var_0) {
  if(isDefined(var_0._id_AA5C) && var_0._id_AA5C) {
    var_1 = self.origin + (0, 0, 55);

    if(distance2dsquared(var_0._id_4140, var_1) < 144) {
      var_2 = var_0._id_4140[2] - var_1[2];

      if(var_2 > 0) {
        if(var_2 < level._id_28F2) {
          if(!isDefined(self._id_8F6F)) {
            self._id_8F6F = 0;
          }

          if(gettime() - self._id_8F6F > 3000) {
            self._id_8F6F = gettime();
            thread _id_2813();
          }
        } else {
          var_0._id_AA5C = 0;
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_2813() {
  self endon("death_or_disconnect");
  self _meth_805B("stand");
  wait 1.0;
  self _meth_804E("jump");
  wait 1.0;
  self _meth_805B("none");
}

_id_2924() {
  for(;;) {
    level waittill("new_tag_spawned", var_0);
    self._id_A487 = -1;

    if(isDefined(var_0)) {
      if(isDefined(var_0._id_103C2) && var_0._id_103C2 == self || isDefined(var_0.attacker) && var_0.attacker == self) {
        if(!isDefined(var_0._id_AA5C) && !isDefined(var_0._id_2F09)) {
          thread _id_2ED7(var_0);
          _id_10930(var_0);

          if(var_0._id_AA5C) {
            var_1 = spawnStruct();
            var_1.origin = var_0._id_4140;
            var_1._id_0427 = var_0;
            var_2[0] = var_1;
            self._id_ED71 = _id_273B(var_2, self._id_ED71);
          }
        }
      }
    }
  }
}

_id_273B(var_0, var_1) {
  var_2 = var_1;

  foreach(var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(var_4._id_0427 == var_7._id_0427 && scripts\mp\bots\bots_util::_id_2916(var_4.origin, var_7.origin)) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

_id_2810(var_0, var_1, var_2) {
  if(!var_0._id_2EE4) {
    var_0._id_A3F8 = _func_0080(var_0._id_4140);
    var_0._id_2EE4 = 1;
  }

  if(isDefined(var_0._id_2F09)) {
    return 0;
  }

  var_3 = var_0._id_A3F8;
  var_4 = !isDefined(var_0._id_AA5C);

  if(isDefined(var_3) && (var_4 || var_0._id_AA5C)) {
    var_5 = var_3 == var_1 || _func_0158(var_3, var_1, 1);

    if(var_5) {
      var_6 = scripts\engine\utility::_id_10E76(self.origin, self.angles, var_0._id_4140, var_2);

      if(var_6) {
        if(var_4) {
          thread _id_2ED7(var_0);
          _id_10930(var_0);

          if(!var_0._id_AA5C) {
            return 0;
          }
        }

        return 1;
      }
    }
  }

  return 0;
}

_id_2796(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = self _meth_815E();
  }

  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = self _meth_8032();
  }

  var_5 = [];

  if(isDefined(var_3) && isDefined(level._id_4CE8)) {
    foreach(var_7 in level._id_4CE8) {
      if(var_7 _id_07D6::_id_318C(self.team)) {
        var_8 = 0;

        if(!var_0) {
          if(!isDefined(var_7._id_2F09)) {
            if(!isDefined(var_7._id_AA5C)) {
              level thread _id_2ED7(var_7);
              _id_10930(var_7);
            }

            var_8 = distancesquared(self.origin, var_7._id_4140) < 1000000 && var_7._id_AA5C;
          }
        } else if(_id_2810(var_7, var_3, var_4))
          var_8 = 1;

        if(var_8) {
          var_9 = spawnStruct();
          var_9.origin = var_7._id_4140;
          var_9._id_0427 = var_7;
          var_5 = scripts\engine\utility::array_add(var_5, var_9);
        }
      }
    }
  }

  return var_5;
}

_id_2ED7(var_0) {
  scripts\mp\bots\bots_gametype_conf::_id_2ED7(var_0);
}

_id_10930(var_0) {
  while(!isDefined(var_0._id_AA5C)) {
    wait 0.05;
  }
}

_id_278D(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_3 = 1409865409;

    foreach(var_5 in var_0) {
      var_6 = _id_65F6(var_5._id_0427);

      if(!var_1 || var_6 < 2) {
        var_7 = distancesquared(var_5._id_0427._id_4140, self.origin);

        if(var_7 < var_3) {
          var_2 = var_5._id_0427;
          var_3 = var_7;
        }
      }
    }
  }

  return var_2;
}

_id_28A7(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3._id_0427 _id_07D6::_id_318C(self.team) && scripts\mp\bots\bots_util::_id_2916(var_3._id_0427._id_4140, var_3.origin)) {
      if(!_id_272C(var_3._id_0427) && var_3._id_0427._id_AA5C) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

_id_65F6(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_AE7C) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_3 != self) {
      if(isai(var_3)) {
        if(isDefined(var_3._id_ED39) && var_3._id_ED39 == var_0) {
          var_1++;
        }

        continue;
      }

      if(distancesquared(var_3.origin, var_0._id_4140) < 160000) {
        var_1++;
      }
    }
  }

  return var_1;
}

_id_2717(var_0, var_1, var_2) {
  self notify("bot_camp_tag");
  self endon("bot_camp_tag");
  self endon("stop_camping_tag");

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  self _meth_8059(self._id_A54D, var_1, self._id_16CA);
  var_3 = scripts\mp\bots\bots_util::_id_291C();

  if(var_3 == "goal") {
    var_4 = var_0._id_A3F8;

    if(isDefined(var_4)) {
      var_5 = _func_0066(self.origin);
      var_5 = scripts\engine\utility::array_add(var_5, var_4);
      childthread scripts\mp\bots\bots_util::_id_2925(var_5);
    }
  }
}