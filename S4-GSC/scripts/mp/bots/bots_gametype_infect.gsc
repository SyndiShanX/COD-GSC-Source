/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_infect.gsc
****************************************************/

main() {
  _id_D795();
  _id_D776();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_27FC;
  level._id_279D["should_pickup_weapons"] = ::_id_28D9;
}

_id_D776() {
  level._id_2943 = 1;
  level._id_2946 = 1;
  level._id_2944 = 1;
  thread _id_27F8();
}

_id_28D9() {
  if(level._id_7E0C && self.team == "axis") {
    return 0;
  }

  return scripts\mp\bots\bots::_id_28D8();
}

_id_27FC() {
  self notify("bot_infect_think");
  self endon("bot_infect_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  childthread _id_27FB();

  for(;;) {
    if(level._id_7E0C) {
      if(self.team == "axis" && self _meth_803A() != "run_and_gun") {
        scripts\mp\bots\bots_util::_id_28C8("run_and_gun");
      }
    }

    if(self._id_28F7 != self.team) {
      self._id_28F7 = self.team;
    }

    if(self.team == "axis") {
      var_0 = _id_09F9::_id_2855();

      if(!isDefined(var_0) || var_0) {
        self _meth_802B();
      }
    }

    self[[self._id_B025]]();
    wait 0.05;
  }
}

_id_27F8() {
  level notify("bot_infect_ai_director_update");
  level endon("bot_infect_ai_director_update");
  level endon("game_ended");

  for(;;) {
    var_0 = [];
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3._id_81BF) && var_3.health > 0 && isDefined(var_3.team) && (var_3.team == "allies" || var_3.team == "axis")) {
        var_3._id_81BF = gettime();
      }

      if(isDefined(var_3._id_81BF) && gettime() - var_3._id_81BF > 5000) {
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
          if(!isDefined(var_3._id_8F30)) {
            var_3._id_8F30 = gettime();
            var_3._id_8F2F = var_3.origin;
            var_3._id_F1F8 = 0;
          }

          if(gettime() >= var_3._id_8F30 + 5000) {
            var_3._id_8F30 = gettime();
            var_10 = distancesquared(var_3.origin, var_3._id_8F2F);
            var_3._id_8F2F = var_3.origin;

            if(var_10 < 90000) {
              var_3._id_F1F8 = var_3._id_F1F8 + 5000;

              if(var_3._id_F1F8 >= 20000) {
                var_11 = scripts\engine\utility::_id_6369(var_3.origin, var_0);

                foreach(var_13 in var_11) {
                  if(isbot(var_13)) {
                    var_14 = var_13 _meth_803E();

                    if(var_14 != "tactical" && var_14 != "critical") {
                      var_13 thread _id_7BA7(var_3);
                      break;
                    }
                  }
                }
              }
            } else {
              var_3._id_F1F8 = 0;
              var_3._id_8F2F = var_3.origin;
            }
          }
        }
      }
    }

    wait 1.0;
  }
}

_id_7BA7(var_0) {
  self endon("death_or_disconnect");
  self _meth_8058(var_0.origin, 0, "critical");
  scripts\mp\bots\bots_util::_id_291C();
  self _meth_802B();
}

_id_27FB() {
  if(self.team == "axis") {
    self._id_30D2 = 0;
    self._id_9D46 = undefined;
    self._id_9D48 = undefined;
    self._id_9D47 = 0;
    self._id_9D53 = undefined;
    self._id_9D52 = 0;
    var_0 = self _meth_8030("throwKnifeChance");

    if(var_0 < 0.25) {
      self _meth_8053("throwKnifeChance", 0.25);
    }

    self _meth_8053("allowGrenades", 1);

    for(;;) {
      if(self hasweapon("s4_throwing_knife_mp")) {
        if(scripts\mp\utility\entity::_id_8877(self._id_0192)) {
          var_1 = gettime();

          if(!isDefined(self._id_9D46) || self._id_9D46 != self._id_0192) {
            self._id_9D46 = self._id_0192;
            self._id_9D48 = self._id_0192 _meth_815E();
            self._id_9D47 = var_1;
          } else {
            var_2 = _func_0219(self _meth_8030("meleeDist"));

            if(distancesquared(self._id_0192.origin, self.origin) <= var_2) {
              self._id_30D2 = var_1;
            }

            var_3 = self._id_0192 _meth_815E();
            var_4 = self _meth_815E();

            if(!isDefined(self._id_9D48) || self._id_9D48 != var_3) {
              self._id_9D47 = var_1;
              self._id_9D48 = var_3;
            }

            if(!isDefined(self._id_9D53) || self._id_9D53 != var_4) {
              self._id_9D52 = var_1;
              self._id_9D53 = var_4;
            } else if(distancesquared(self.origin, self._id_9D53.origin) > 9216)
              self._id_9D51 = var_1;

            if(self._id_30D2 + 3000 < var_1) {
              if(self._id_9D52 + 3000 < var_1) {
                if(self._id_9D47 + 3000 < var_1) {
                  if(_id_27F9(self.origin, self._id_0192.origin)) {
                    scripts\mp\bots\bots_util::_id_289B("find_node_can_see_ent", ::_id_27FA, self._id_0192, self._id_9D53);
                  }

                  if(!self _meth_8109("s4_throwing_knife_mp")) {
                    self setweaponammoclip("s4_throwing_knife_mp", 1);
                  }

                  scripts\engine\utility::_id_108AE(30, "enemy");
                  self _meth_802B();
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

_id_27F9(var_0, var_1) {
  if(abs(var_0[2] - var_1[2]) > 56.0 && distance2dsquared(var_0, var_1) < 2304) {
    return 1;
  }

  return 0;
}

_id_27FA(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = 0;

  if(issubstr(var_1.type, "Begin")) {
    var_2 = 1;
  }

  var_3 = _func_00A6(var_1);

  if(isDefined(var_3) && var_3.size) {
    var_4 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_6 in var_4) {
      if(var_2 && issubstr(var_6.type, "End")) {
        continue;
      }
      if(_id_27F9(var_6.origin, var_0.origin)) {
        continue;
      }
      var_7 = self getEye() - self.origin;
      var_8 = var_6.origin + var_7;
      var_9 = var_0.origin;

      if(isPlayer(var_0)) {
        var_9 = var_0 scripts\mp\utility\player::_id_6D7F();
      }

      if(_func_0202(var_8, var_9, 0, self, var_0)) {
        var_10 = _func_0261(var_9 - var_8);
        self _meth_8059(var_6, "critical", var_10);
        scripts\mp\bots\bots_util::_id_291C(3.0);
        return;
      }

      wait 0.05;
    }
  }
}