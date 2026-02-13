/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2221.gsc
*************************************************/

_id_56A2() {
  thread _id_56A4();
  _id_5694(1);
}

_id_5694(var_0) {
  if(!isDefined(level._id_0408._id_3D68)) {
    level._id_0408._id_3D68 = ["bulletwhizby", "explode", "footstep", "footstep_sprint", "footstep_walk", "grenade danger", "gunshot", "gunshot_teammate", "projectile_impact", "silenced_shot", "glass_destroyed"];
  }

  if(var_0) {
    foreach(var_2 in level._id_0408._id_3D68) {
      self _meth_8000(var_2);
    }
  } else {
    foreach(var_2 in level._id_0408._id_3D68) {
      self _meth_8297(var_2);
    }
  }
}

_id_56A3() {
  if(!isDefined(level._id_0408._id_56A7)) {
    level._id_0408._id_56A7 = [];
  }

  level._id_0408._id_56A7["investigate"] = 0;
  level._id_0408._id_56A7["cover_blown"] = 1;
  level._id_0408._id_56A7["combat"] = 2;
  level _id_08B5::_id_D3C4("broadcast", ::_id_5690);
  _id_56AC("investigate", "footstep", 15, 0.07);
  _id_56AC("investigate", "footstep_sprint", 10, 0.1);
  _id_56AC("investigate", "footstep_walk", 20, 0.05);
  _id_56AC("investigate", "unresponsive_teammate", 20, 0.05);
  _id_56AC("investigate", "window_open", 0, 0.2);
  _id_56AC("investigate", "ally_hurt_peripheral", 0, 0.1);
  _id_56AC("cover_blown", "sight", 2, 0.45);
  _id_56AC("cover_blown", "saw_corpse", 0, 0.3);
  _id_56AC("cover_blown", "found_corpse", 0, 0.3);
  _id_56AC("cover_blown", "gunshot_teammate", 10, 0.1);
  _id_56AC("cover_blown", "silenced_shot", 5, 0.23);
  _id_56AC("cover_blown", "gunshot", 3, 0.4);
  _id_56AC("cover_blown", "explode", 2, 0.8);
  _id_56AC("cover_blown", "seek_backup", 0, 0.0);
  _id_56AC("cover_blown", "grenade danger", 0, 0.9);
  _id_56AC("cover_blown", "glass_destroyed", 2, 0.5);
  _id_56AC("cover_blown", "light_killed", 3, 0.4);
  _id_56AC("cover_blown", "bulletwhizby", 3, 0.4);
  _id_56AC("combat", "projectile_impact");
  _id_56AC("combat", "attack");
  _id_56AC("combat", "damage");
  _id_56AC("combat", "proximity");
  _id_56AC("combat", "ally_damaged");
  _id_56AC("combat", "ally_killed");
}

_id_56A9(var_0, var_1) {
  var_2 = level._id_0408._id_56A7[var_0] - level._id_0408._id_56A7[var_1];
  return var_2;
}

_id_56AD(var_0, var_1) {
  var_2 = level._id_0408._id_56A7[var_0] + var_1;

  foreach(var_5, var_4 in level._id_0408._id_56A7) {
    if(var_4 == var_2) {
      return var_5;
    }
  }

  return var_0;
}

_id_56AC(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.0;
  }

  if(!isDefined(level._id_0408._id_56A8)) {
    level._id_0408._id_56A8 = [];
  }

  if(!isDefined(level._id_0408._id_5695)) {
    level._id_0408._id_5695 = [];
  }

  if(!isDefined(level._id_0408._id_569B)) {
    level._id_0408._id_569B = [];
  }

  if(!isDefined(level._id_0408._id_569C)) {
    level._id_0408._id_569C = [];
  }

  level._id_0408._id_56A8[var_1] = var_0;
  level._id_0408._id_5695[var_1] = var_2;
  level._id_0408._id_569B[var_1] = var_3;
  level._id_0408._id_569C[var_1] = var_4;
}

_id_56AA(var_0) {
  return level._id_0408._id_56A8[var_0];
}

_id_5698(var_0) {
  return level._id_0408._id_5695[var_0];
}

_id_569A(var_0) {
  return level._id_0408._id_569B[var_0];
}

_id_569D(var_0) {
  return level._id_0408._id_569C[var_0];
}

_id_5696() {
  self._id_0408._id_5697 = undefined;
  self._id_0408._id_5699 = 0.0;
}

_id_56A4() {
  self notify("event_listener_thread");
  self endon("event_listener_thread");
  self endon("death");

  for(;;) {
    scripts\engine\utility::_id_5476("stealth_enabled");
    self waittill("ai_events", var_0);

    if(!scripts\engine\utility::_id_546E("stealth_enabled")) {
      continue;
    }
    if(self._id_0229 || self _meth_81DF()) {
      continue;
    }
    foreach(var_2 in var_0) {
      if(!isDefined(var_2._id_019B)) {
        continue;
      }
      if(_func_011D(var_2._id_019B) && (var_2._id_019B.ignoreme || var_2._id_019B._id_02FA)) {
        continue;
      }
      if(isDefined(var_2._id_019B._id_ADB4)) {
        if(var_2._id_019B._id_ADB4._id_04DE == "capital_ship") {
          continue;
        }
      }

      var_2._id_F8E4 = var_2.type;
      var_2._id_0362 = self;
      var_3 = _id_56AA(var_2.type);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;

      if(isDefined(var_3)) {
        if(!isDefined(self._id_4AB0) && var_3 != "combat") {
          var_4 = _id_5698(var_2.type);
          var_5 = _id_569A(var_2.type);
          var_6 = _id_569D(var_2.type);

          if(var_4 > 0) {
            if(!isDefined(self._id_0408._id_5697)) {
              self._id_0408._id_5697 = [];
            }

            if(!isDefined(self._id_0408._id_5697[var_2.type])) {
              self._id_0408._id_5697[var_2.type] = 0;
            }

            if(isDefined(var_6) && self._id_0408._id_5697[var_2.type] + 1 >= var_6) {
              var_3 = _id_56AD(var_3, 2);
            } else if(self._id_0408._id_5697[var_2.type] + 1 >= var_4) {
              var_3 = _id_56AD(var_3, 1);
            } else if(self._id_0408._id_5699 + var_5 >= 1.0) {
              var_3 = _id_56AD(var_3, 1);
            }
          }
        }

        var_2.type = var_3;
      }

      var_7 = _id_08A8::_id_E79D(var_2.type, var_2);

      if(istrue(var_7) && isDefined(var_4) && var_2.type != "combat") {
        if(var_4 > 0) {
          self._id_0408._id_5697[var_2._id_F8E4]++;
        }

        self._id_0408._id_5699 = self._id_0408._id_5699 + var_5;
      }
    }
  }
}

_id_54FE(var_0) {
  switch (var_0.classname) {
    case "script_vehicle_blackhornet":
      return 1;
    default:
      return 0;
  }
}

_id_568C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_0074("bad_guys", "all");
  var_6 = _func_0219(var_3);
  var_7 = _func_0219(var_4);
  var_8 = self.team;

  if(!isDefined(var_8)) {
    var_8 = self._id_002E;
  }

  foreach(var_10 in var_5) {
    if(!isalive(var_10)) {
      continue;
    }
    if(var_10 == self) {
      continue;
    }
    if(var_10.team != var_8) {
      continue;
    }
    if(!isDefined(var_10._id_0408)) {
      continue;
    }
    var_11 = 0;
    var_12 = distancesquared(var_10.origin, self.origin);

    if(var_12 <= var_6) {
      var_11 = self _meth_861A(var_10);
    }

    if(!var_11 && var_12 <= var_7) {
      if(var_10 _id_08B5::_id_8712(self) || var_10 _id_08B5::_id_8712(var_2)) {
        var_11 = 1;
      }
    }

    if(var_10[[var_10._id_5D98]]()) {
      if(var_11) {
        var_10 _meth_812E(var_2);
      }

      continue;
    }

    if(var_11) {
      if(var_10 _meth_8205(var_2) == 0) {
        var_10 _meth_8523(var_0, var_2, self.origin);
      } else {
        var_10 _meth_8523(var_0, var_2, var_2.origin);
      }

      continue;
    }

    if(var_10 _meth_8621(self)) {
      var_10 _meth_8523(var_1, var_2, self.origin);
    }
  }
}

_id_5690(var_0, var_1, var_2, var_3) {
  var_4 = _func_0074("bad_guys");

  if(!isDefined(var_3)) {
    var_3 = level.player;
  }

  var_5 = _func_0219(var_2);

  foreach(var_7 in var_4) {
    if(!isalive(var_7)) {
      continue;
    }
    if(!isDefined(var_7._id_0408)) {
      continue;
    }
    if(distancesquared(var_7.origin, var_1) <= var_5) {
      var_7 _meth_8523(var_0, var_3, var_1);
    }
  }
}

_id_568F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _func_0074("bad_guys", "all");
  var_8 = var_3 * var_3;

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_9 = undefined;

  if(isDefined(var_6)) {
    var_9 = var_6 * var_6;
  }

  if(!isDefined(var_5)) {
    var_5 = var_2;
  }

  foreach(var_11 in var_7) {
    if(!isalive(var_11)) {
      continue;
    }
    if(!isDefined(var_11._id_0408)) {
      continue;
    }
    var_12 = distancesquared(var_11.origin, var_2);

    if(var_12 > var_8) {
      continue;
    }
    var_13 = var_4;

    if(var_4 && isDefined(var_9) && var_12 <= var_9) {
      var_13 = 0;
    }

    if(!var_11 _meth_861A(var_5, var_13)) {
      continue;
    }
    var_11 _meth_8523(var_0, var_1, var_2);
  }
}

_id_568D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread _id_568E(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_568E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _func_0074("bad_guys", "all");
  var_8 = var_3 * var_3;

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = var_2;
  }

  var_9 = 3;
  var_10 = 0;

  foreach(var_12 in var_7) {
    if(!isalive(var_12)) {
      continue;
    }
    if(!isDefined(var_12._id_0408)) {
      continue;
    }
    var_13 = distancesquared(var_12.origin, var_2);

    if(var_13 > var_8) {
      continue;
    }
    if(isDefined(var_6) && var_13 <= var_6 * var_6) {
      var_12 _meth_8523(var_0, var_1, var_2);
      continue;
    }

    if(!var_12 _meth_861A(var_5, var_4)) {
      if(var_4 && !var_12 _meth_861D(var_2)) {
        continue;
      }
      var_10++;

      if(var_10 > var_9) {
        waitframe();
        var_10 = 0;
      }

      if(!_func_0202(var_12 getEye(), var_2, 0, var_1)) {
        continue;
      }
    }

    var_12 _meth_8523(var_0, var_1, var_2);
  }
}