/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_ks_remote_vehicle.gsc
************************************************************/

_id_7C63() {
  while(!isDefined(level._id_1B1B))
    waitframe();

  if(isDefined(level._id_1A22)) {
    return;
  }
  level._id_6C9B = [];

  if(isDefined(level._id_98C5))
    var_0 = [[level._id_98C5]]();
  else {
    var_0 = [];

    for(var_1 = 0; var_1 < level._id_AC9C; var_1++)
      var_0[var_0.size] = var_1;
  }

  foreach(var_3 in var_0) {
    if(_func_1EC(var_3) < 0.25)
      level._id_6C9B = common_scripts\utility::_id_0F6F(level._id_6C9B, var_3);
  }

  level._id_1A22 = 1;
}

_id_1A4C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    return 0;

  var_5 = 1;
  var_6 = 1;
  var_7 = undefined;

  if(isDefined(self._id_6708)) {
    var_8 = self _meth_835D();
    var_9 = distancesquared(self.origin, self._id_6708.origin);

    if(var_9 < _func_0DA(var_8)) {
      var_5 = 0;
      var_6 = 0;
    } else if(var_9 < _func_0DA(200))
      var_5 = 0;
  }

  var_10 = var_0._id_944C == "vanguard" && _id_55A7();

  if(var_10 || var_5) {
    var_11 = _func_0B8(self.origin, 500, 0, 512);

    if(isDefined(var_11) && var_11.size > 0) {
      if(isDefined(var_4) && var_4) {
        var_12 = var_11;
        var_11 = [];

        foreach(var_14 in var_12) {
          if(_func_200(var_14)) {
            var_15 = _func_204(var_14);
            var_16 = 0;

            foreach(var_18 in var_15) {
              if(_func_200(var_18))
                var_16++;
            }

            if(var_16 / var_15.size > 0.5)
              var_11 = common_scripts\utility::_id_0F6F(var_11, var_14);
          }
        }
      }

      if(var_10) {
        var_21 = self _meth_8382(var_11, "node_exposed");

        foreach(var_14 in var_21) {
          if(_func_07E(var_14.origin + (0, 0, 30), var_14.origin + (0, 0, 400), 0, self)) {
            var_7 = var_14;
            break;
          }

          waitframe();
        }
      } else if(var_11.size > 0)
        var_7 = self _meth_8366(var_11, _func_0AF(3, var_11.size), "node_hide");

      if(!isDefined(var_7))
        return 0;

      self _meth_8357(var_7, "tactical");
    }
  }

  if(var_6) {
    var_24 = maps\mp\bots\_bots_util::_id_1B21();

    if(var_24 != "goal") {
      _id_9E08(var_7);
      return 1;
    }
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    _id_9E08(var_7);
    return 0;
  }

  if(!maps\mp\bots\_bots_util::_id_1937()) {
    _id_9E08(var_7);
    return 1;
  }

  if(!isDefined(var_7)) {
    if(self _meth_8178() == "prone")
      self _meth_8354("prone");
    else if(self _meth_8178() == "crouch")
      self _meth_8354("crouch");
  } else if(self _meth_837D("strategyLevel") > 0) {
    if(randomint(100) > 50)
      self _meth_8354("prone");
    else
      self _meth_8354("crouch");
  }

  maps\mp\bots\_bots_ks::_id_1AF4(var_0, var_1, var_0._id_01D0);
  self._id_A2E5 = undefined;
  self thread[[var_3]]();
  thread _id_19BD();
  thread _id_19BF(var_7);
  self waittill("control_func_done");
  return 1;
}

_id_19BD() {
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self waittill("spawned_player");
  self notify("control_func_done");
}

_id_19BF(var_0) {
  self endon("disconnect");
  self waittill("control_func_done");
  _id_9E08(var_0);
  self _meth_8354("none");
  self _meth_8355(0, 0);
  self _meth_8353("disable_movement", 0);
  self _meth_8353("disable_rotation", 0);
  self._id_A2E5 = undefined;
}

_id_9E08(var_0) {
  if(isDefined(var_0) && self _meth_8367() && isDefined(self _meth_8378()) && self _meth_8378() == var_0)
    self _meth_8358();
}

_id_19BE(var_0) {
  var_0 waittill("death");
  self notify("control_func_done");
}

_id_1B23(var_0) {
  var_1 = gettime();

  while(!self[[level._id_1A54["isUsing"][var_0]]]()) {
    waitframe();

    if(gettime() - var_1 > 5000)
      return 0;
  }

  return 1;
}

_id_55A7() {
  return level._id_015D == "mp_sovereign";
}

_id_194A() {
  return isDefined(self);
}

_id_4C7F(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = distancesquared(level._id_1A71, [[level._id_1A54["heli_node_get_origin"][var_1]]](var_5));

    if(var_6 > var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2))
    return var_2;
  else
    return common_scripts\utility::random(var_0);
}

_id_4C76(var_0) {
  return var_0.origin;
}

_id_3B6A(var_0, var_1) {
  var_2 = undefined;
  var_3 = 99999999;

  foreach(var_5 in level._id_1A17) {
    var_6 = _func_211(var_0, [[level._id_1A54["heli_node_get_origin"][var_1]]](var_5));

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2;
}

_id_1A47(var_0) {
  var_1 = _id_1A44(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_AC9C; var_3++)
    var_2[var_3] = [];

  foreach(var_5 in var_1) {
    var_6 = var_5 _meth_838A();
    var_7 = _func_1FB(var_6);

    if(isDefined(var_7))
      var_2[var_7] = common_scripts\utility::_id_0F6F(var_2[var_7], var_5);
  }

  return var_2;
}

_id_1A48(var_0) {
  var_1 = _id_1A45(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_AC9C; var_3++)
    var_2[var_3] = [];

  foreach(var_5 in var_1) {
    var_6 = var_5 _meth_838A();
    var_7 = _func_1FB(var_6);
    var_2[var_7] = common_scripts\utility::_id_0F6F(var_2[var_7], var_5);
  }

  return var_2;
}

_id_1A45(var_0) {
  return _id_1A46(self.team, "enemy", var_0);
}

_id_1A44(var_0) {
  return _id_1A46(self.team, "ally", var_0);
}

_id_1A46(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = level._id_6E97;

  if(isDefined(var_2) && var_2)
    var_4 = level.players;

  foreach(var_6 in var_4) {
    if(var_6 == self || !isalive(var_6)) {
      continue;
    }
    var_7 = 0;

    if(var_1 == "ally")
      var_7 = level.teambased && var_0 == var_6.team;
    else if(var_1 == "enemy")
      var_7 = !level.teambased || var_0 != var_6.team;

    if(var_7) {
      var_8 = var_6 _meth_838A();

      if(isDefined(var_8) && _func_200(var_8))
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_6);
    }
  }

  var_3 = common_scripts\utility::_id_0F93(var_3, self);
  return var_3;
}

_id_1A16(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0._id_6653) {
    if(isDefined(var_4._id_0164)) {
      var_5 = var_4._id_1B1E[self._id_37CD];

      if(var_5 < var_1) {
        var_2 = [];
        var_2[0] = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_197F(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_1 = _id_1B23(var_0);

  if(!var_1)
    self notify("control_func_done");

  foreach(var_3 in level._id_5DD9) {
    if(var_3._id_0117 == self)
      self._id_A2E5 = var_3;
  }

  childthread _id_19BE(self._id_A2E5);
  self._id_A2E5 endon("death");

  if(isDefined(level._id_1A54["control_other"][var_0]))
    self childthread[[level._id_1A54["control_other"][var_0]]]();

  self[[level._id_1A54["waittill_initial_goal"][var_0]]]();
  self childthread[[level._id_1A54["control_aiming"][var_0]]]();
  _id_1980(var_0, 1);
  self notify("control_func_done");
}

_id_19F3(var_0) {
  if(var_0)
    return _func_0DA(100);
  else
    return _func_0DA(30);
}

_id_19F4(var_0) {
  if(var_0)
    return _func_0DA(300);
  else
    return _func_0DA(90);
}

_id_1980(var_0, var_1) {
  foreach(var_3 in level._id_1A17)
  var_3._id_1B1E[self._id_37CD] = 0;

  var_5 = _id_3B6A(self._id_A2E5.origin, var_0);
  var_6 = undefined;
  self._id_66A8 = 0;
  var_7 = "needs_new_goal";
  var_8 = undefined;
  var_9 = self._id_A2E5.origin;
  var_10 = 3.0;
  var_11 = 0.05;

  while(self[[level._id_1A54["isUsing"][var_0]]]()) {
    if(gettime() > self._id_66A8 && var_7 == "needs_new_goal") {
      var_12 = var_5;
      var_5 = [[level._id_1A54["heli_pick_node"][var_0]]](var_5);
      var_6 = undefined;

      if(isDefined(var_5)) {
        var_13 = [[level._id_1A54["heli_node_get_origin"][var_0]]](var_5);

        if(var_1) {
          var_14 = var_5.origin + (maps\mp\_utility::_id_4507() + level._id_1A18);
          var_15 = var_5.origin + (maps\mp\_utility::_id_4507() - level._id_1A18);
          var_16 = bulletTrace(var_14, var_15, 0, undefined, 0, 0, 1);
          var_6 = var_16["position"] - maps\mp\_utility::_id_4507() + level._id_1A55[var_0];
        } else
          var_6 = var_13;
      }

      if(isDefined(var_6)) {
        self _meth_8353("disable_movement", 0);
        var_7 = "waiting_till_goal";
        var_10 = 3.0;
        var_9 = self._id_A2E5.origin;
      } else {
        var_5 = var_12;
        self._id_66A8 = gettime() + 2000;
      }
    } else if(var_7 == "waiting_till_goal") {
      if(!var_1) {
        var_17 = var_6[2] - self._id_A2E5.origin[2];

        if(var_17 > 10)
          self _meth_8380("lethal");
        else if(var_17 < -10)
          self _meth_8380("tactical");
      }

      var_18 = var_6 - self._id_A2E5.origin;

      if(var_1)
        var_8 = _func_0E6(var_18);
      else
        var_8 = _func_0E5(var_18);

      if(var_8 < _id_19F3(var_1)) {
        self _meth_8355(0, 0);
        self _meth_8353("disable_movement", 1);

        if(self _meth_836D() == "recruit")
          self._id_66A8 = gettime() + _func_0A4(5000, 7000);
        else
          self._id_66A8 = gettime() + _func_0A4(3000, 5000);

        var_7 = "needs_new_goal";
      } else {
        var_18 = var_6 - self._id_A2E5.origin;
        var_19 = vectortoangles(var_18);
        var_20 = common_scripts\utility::_id_98E7(var_8 < _id_19F4(var_1), 0.5, 1.0);
        self _meth_8355(var_19[1], var_11, var_20);
        var_10 = var_10 - var_11;

        if(var_10 <= 0.0) {
          if(distancesquared(self._id_A2E5.origin, var_9) < 225) {
            var_5._id_1B1E[self._id_37CD]++;
            var_7 = "needs_new_goal";
          }

          var_9 = self._id_A2E5.origin;
          var_10 = 3.0;
        }
      }
    }

    wait(var_11);
  }
}

_id_42E5() {
  var_0 = [];

  foreach(var_2 in level._id_6C9B) {
    var_3 = _func_1E7(var_2, self.team, "enemy_predict");

    if(var_3 > 0)
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
  }

  var_5 = undefined;

  if(var_0.size > 0) {
    var_6 = common_scripts\utility::random(var_0);
    var_7 = common_scripts\utility::random(_func_1F8(var_6));
    var_5 = var_7.origin;
  } else {
    if(isDefined(level._id_98C4))
      var_8 = [[level._id_98C4]]();
    else
      var_8 = _func_0B7();

    var_9 = 0;

    while(var_9 < 10) {
      var_9++;
      var_10 = var_8[randomint(var_8.size)];
      var_5 = var_10.origin;

      if(_func_200(var_10) && _func_211(var_10.origin, self._id_A2E5.origin) > 62500) {
        break;
      }
    }
  }

  return var_5;
}