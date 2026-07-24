/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3868.gsc
**************************************/

_id_6854() {
  thread _id_6860();
  _id_6837(1);
}

_id_6837(var_0) {
  if(!isDefined(level._id_10E6D._id_4652)) {
    level._id_10E6D._id_4652 = [];
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "bulletwhizby";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "explode";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "footstep";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "footstep_sprint";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "footstep_walk";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "grenade danger";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "gunshot";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "gunshot_teammate";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "projectile_impact";
    level._id_10E6D._id_4652[level._id_10E6D._id_4652.size] = "silenced_shot";
  }

  if(var_0) {
    foreach(var_2 in level._id_10E6D._id_4652) {
      self addaieventlistener(var_2);
    }
  } else {
    foreach(var_2 in level._id_10E6D._id_4652) {
      self _meth_8260(var_2);
    }
  }
}

_id_6855() {
  if(!isDefined(level._id_10E6D._id_6879)) {
    level._id_10E6D._id_6879 = [];
  }

  level._id_10E6D._id_6879["investigate"] = 0;
  level._id_10E6D._id_6879["cover_blown"] = 1;
  level._id_10E6D._id_6879["combat"] = 2;
  level _id_0F27::_id_F5B4("broadcast", ::_id_6800);
  _id_6897("investigate", "footstep", 20);
  _id_6897("investigate", "footstep_sprint", 20);
  _id_6897("investigate", "footstep_walk", 20);
  _id_6897("cover_blown", "sight", 3);
  _id_6897("cover_blown", "saw_corpse");
  _id_6897("cover_blown", "found_corpse");
  _id_6897("cover_blown", "gunshot_teammate", 10);
  _id_6897("cover_blown", "silenced_shot", 10);
  _id_6897("cover_blown", "gunshot", 10);
  _id_6897("cover_blown", "explode", 2);
  _id_6897("cover_blown", "seek_backup");
  _id_6897("combat", "grenade danger");
  _id_6897("combat", "projectile_impact");
  _id_6897("combat", "bulletwhizby");
  _id_6897("combat", "attack");
  _id_6897("combat", "damage");
  _id_6897("combat", "proximity");
}

_id_6894(var_0, var_1) {
  var_2 = level._id_10E6D._id_6879[var_0] - level._id_10E6D._id_6879[var_1];
  return var_2;
}

_id_6898(var_0, var_1) {
  var_2 = level._id_10E6D._id_6879[var_0] + var_1;

  foreach(var_5, var_4 in level._id_10E6D._id_6879) {
    if(var_4 == var_2) {
      return var_5;
    }
  }

  return var_0;
}

_id_6897(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(level._id_10E6D._id_6893)) {
    level._id_10E6D._id_6893 = [];
  }

  if(!isDefined(level._id_10E6D._id_6838)) {
    level._id_10E6D._id_6838 = [];
  }

  level._id_10E6D._id_6893[var_1] = var_0;
  level._id_10E6D._id_6838[var_1] = var_2;
}

_id_6895(var_0) {
  return level._id_10E6D._id_6893[var_0];
}

_id_683B(var_0) {
  return level._id_10E6D._id_6838[var_0];
}

_id_6839() {
  self._id_10E6D._id_683A = undefined;
}

_id_6860() {
  self notify("event_listener_thread");
  self endon("event_listener_thread");
  self endon("death");

  for(;;) {
    scripts\sp\utility::_id_65E3("stealth_enabled");
    self waittill("ai_events", var_0);

    if(!scripts\sp\utility::_id_65DB("stealth_enabled")) {
      continue;
    }
    if(self.ignoreall || self _meth_81B7()) {
      continue;
    }
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.entity)) {
        continue;
      }
      if(issentient(var_2.entity) && (var_2.entity.ignoreme || var_2.entity.notarget)) {
        continue;
      }
      if(isaircraft(var_2.entity)) {
        continue;
      }
      if(isDefined(var_2.entity._id_C841)) {
        if(isaircraft(var_2.entity._id_C841) || var_2.entity._id_C841.vehicletype == "capital_ship") {
          continue;
        }
      }

      var_2._id_12AE9 = var_2.type;
      var_3 = _id_6895(var_2.type);

      if(isDefined(var_3)) {
        var_4 = _id_683B(var_2.type);
        var_5 = 0;

        if(var_4 > 0) {
          if(!isDefined(self._id_10E6D._id_683A)) {
            self._id_10E6D._id_683A = [];
          }

          if(!isDefined(self._id_10E6D._id_683A[var_2.type])) {
            self._id_10E6D._id_683A[var_2.type] = 1;
          } else {
            self._id_10E6D._id_683A[var_2.type] = self._id_10E6D._id_683A[var_2.type] + 1;
          }

          if(self._id_10E6D._id_683A[var_2.type] >= var_4) {
            var_3 = _id_6898(var_3, 1);
          }
        }

        var_2.type = var_3;
      }

      _id_0F18::_id_10E8B(var_2.type, var_2);
    }
  }
}

_id_67FF(var_0, var_1, var_2, var_3) {
  var_4 = getaiunittypearray("bad_guys", "all");
  var_5 = squared(var_2);
  var_6 = squared(var_3);

  foreach(var_8 in var_4) {
    if(!isalive(var_8)) {
      continue;
    }
    if(var_8 == self) {
      continue;
    }
    if(var_8.team != self.team) {
      continue;
    }
    if(!isDefined(var_8._id_10E6D)) {
      continue;
    }
    var_9 = distancesquared(var_8.origin, self.origin);
    var_10 = var_9 <= var_5;

    if(!var_10 && var_9 <= var_6) {
      if(var_8 _id_0F27::_id_9D11(self) || var_8 _id_0F27::_id_9D11(level.player)) {
        var_10 = 1;
      }
    }

    if(var_10) {
      var_8 _meth_84F7(var_0, var_1, var_1.origin);
    }
  }
}

_id_6800(var_0, var_1, var_2) {
  var_3 = getaiunittypearray("bad_guys");
  var_4 = squared(var_2);

  foreach(var_6 in var_3) {
    if(!isalive(var_6)) {
      continue;
    }
    if(!isDefined(var_6._id_10E6D)) {
      continue;
    }
    if(distancesquared(var_6.origin, var_1) <= var_4) {
      var_6 _meth_84F7(var_0, level.player, var_1);
    }
  }
}