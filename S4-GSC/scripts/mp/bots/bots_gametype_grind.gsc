/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_grind.gsc
***************************************************/

main() {
  _id_D795();
  scripts\mp\bots\bots_gametype_conf::_id_D769();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_27E1;
}

_id_27E1() {
  self notify("bot_grind_think");
  self endon("bot_grind_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self._id_719F = 0;
  self._id_7083 = undefined;
  self._id_3B71 = 0;
  self._id_10D1 = ::_id_27E0;

  if(self _meth_8030("strategyLevel") > 0) {
    childthread _id_5403();
  }

  scripts\mp\bots\bots_gametype_conf::_id_273C();
}

_id_27E0() {
  if(!isDefined(self._id_ED39)) {
    if(self._id_ED74 > 0) {
      var_0 = _func_0219(500 + self._id_ED74 * 250);

      if(game["teamScores"][self.team] + self._id_ED74 >= level._id_C948) {
        var_0 = _func_0219(5000);
      } else if(!isDefined(self._id_0192) && !scripts\mp\bots\bots_util::_id_27F7()) {
        var_0 = _func_0219(1500 + self._id_ED74 * 250);
      }

      var_1 = undefined;

      foreach(var_3 in level._id_A8E8) {
        var_4 = distancesquared(self.origin, var_3.trigger.origin);

        if(var_4 < var_0) {
          var_0 = var_4;
          var_1 = var_3;
        }
      }

      if(isDefined(var_1)) {
        var_6 = 1;

        if(self._id_719F) {
          if(isDefined(self._id_7083) && self._id_7083 == var_1) {
            var_6 = 0;
          }
        }

        if(var_6) {
          self._id_719F = 1;
          self._id_7083 = var_1;
          self _meth_802B();
          self notify("stop_going_to_zone");
          self notify("stop_camping_zone");
          self._id_3B71 = 0;
          _id_09F7::_id_38BF();
          _id_09F9::_id_26EF("kill_tag");
          childthread _id_27DE(var_1, "tactical");
        }
      }

      if(self._id_719F) {
        if(game["teamScores"][self.team] + self._id_ED74 >= level._id_C948) {
          self _meth_8054("force_sprint", 1);
        }
      }
    } else if(self._id_719F) {
      self._id_719F = 0;
      self._id_7083 = undefined;
      self notify("stop_going_to_zone");
      self _meth_802B();
    }

    if(self._id_B023 == "camper" && !self._id_3B70 && !self._id_719F) {
      var_0 = undefined;
      var_1 = undefined;

      foreach(var_3 in level._id_A8E8) {
        var_4 = distancesquared(self.origin, var_3.trigger.origin);

        if(!isDefined(var_0) || var_4 < var_0) {
          var_0 = var_4;
          var_1 = var_3;
        }
      }

      if(isDefined(var_1)) {
        if(_id_09F7::_id_DACD()) {
          if(_id_09F7::_id_5AB1(var_1.trigger.origin)) {
            self._id_3B71 = 1;
            self notify("stop_going_to_zone");
            self._id_719F = 0;
            self _meth_802B();
            childthread _id_2718(var_1, "camp");
          } else {
            self notify("stop_camping_zone");
            self._id_3B71 = 0;
            _id_09F7::_id_38BF();
          }
        }
      } else
        self._id_3B71 = 1;
    }
  } else {
    self notify("stop_going_to_zone");
    self._id_719F = 0;
    self._id_7083 = undefined;
    self notify("stop_camping_zone");
    self._id_3B71 = 0;
  }

  return self._id_719F || self._id_3B71;
}

_id_27DE(var_0, var_1) {
  self endon("stop_going_to_zone");

  if(!isDefined(var_0._id_2EE4)) {
    var_0._id_A3F8 = _func_0080(var_0.trigger.origin);
    var_0._id_2EE4 = 1;
  }

  var_2 = var_0._id_A3F8;
  self _meth_8058(var_2.origin, 32, var_1);
  var_3 = scripts\mp\bots\bots_util::_id_291C();
}

_id_2718(var_0, var_1) {
  self endon("stop_camping_zone");
  self _meth_8059(self._id_A54D, var_1, self._id_16CA);
  var_2 = scripts\mp\bots\bots_util::_id_291C();

  if(var_2 == "goal") {
    if(!isDefined(var_0._id_2EE4)) {
      var_0._id_A3F8 = _func_0080(var_0.trigger.origin);
      var_0._id_2EE4 = 1;
    }

    var_3 = var_0._id_A3F8;

    if(isDefined(var_3)) {
      var_4 = _func_0066(self.origin);
      var_4 = scripts\engine\utility::array_add(var_4, var_3);
      childthread scripts\mp\bots\bots_util::_id_2925(var_4);
    }
  }
}

_id_5403() {
  self._id_4578 = self _meth_8030("meleeChargeDist");

  for(;;) {
    if(self _meth_8030("strategyLevel") < 2) {
      wait 0.5;
    } else {
      wait 0.2;
    }

    if(isDefined(self._id_0192) && isPlayer(self._id_0192) && isDefined(self._id_0192._id_ED74) && self._id_0192._id_ED74 >= 3 && self _meth_8028(self._id_0192) && distance(self.origin, self._id_0192.origin) <= 500) {
      self _meth_8053("meleeChargeDist", 500);
      self _meth_8054("prefer_melee", 1);
      continue;
    }

    self _meth_8053("meleeChargeDist", self._id_4578);
    self _meth_8054("prefer_melee", 0);
  }
}