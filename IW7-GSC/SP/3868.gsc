/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3868.gsc
*********************************************/

func_6854() {
  thread func_6860();
  func_6837(1);
}

func_6837(var_0) {
  if(!isDefined(level.var_10E6D.var_4652)) {
    level.var_10E6D.var_4652 = [];
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "bulletwhizby";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "explode";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "footstep";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "footstep_sprint";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "footstep_walk";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "grenade danger";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "gunshot";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "gunshot_teammate";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "projectile_impact";
    level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "silenced_shot";
  }

  if(var_0) {
    foreach(var_2 in level.var_10E6D.var_4652) {
      self getnodeyawfromoffsettable(var_2);
    }

    return;
  }

  foreach(var_2 in level.var_10E6D.var_4652) {
    self _meth_8260(var_2);
  }
}

func_6855() {
  if(!isDefined(level.var_10E6D.var_6879)) {
    level.var_10E6D.var_6879 = [];
  }

  level.var_10E6D.var_6879["investigate"] = 0;
  level.var_10E6D.var_6879["cover_blown"] = 1;
  level.var_10E6D.var_6879["combat"] = 2;
  level lib_0F27::func_F5B4("broadcast", ::func_6800);
  func_6897("investigate", "footstep", 20);
  func_6897("investigate", "footstep_sprint", 20);
  func_6897("investigate", "footstep_walk", 20);
  func_6897("cover_blown", "sight", 3);
  func_6897("cover_blown", "saw_corpse");
  func_6897("cover_blown", "found_corpse");
  func_6897("cover_blown", "gunshot_teammate", 10);
  func_6897("cover_blown", "silenced_shot", 10);
  func_6897("cover_blown", "gunshot", 10);
  func_6897("cover_blown", "explode", 2);
  func_6897("cover_blown", "seek_backup");
  func_6897("combat", "grenade danger");
  func_6897("combat", "projectile_impact");
  func_6897("combat", "bulletwhizby");
  func_6897("combat", "attack");
  func_6897("combat", "damage");
  func_6897("combat", "proximity");
}

func_6894(var_0, var_1) {
  var_2 = level.var_10E6D.var_6879[var_0] - level.var_10E6D.var_6879[var_1];
  return var_2;
}

func_6898(var_0, var_1) {
  var_2 = level.var_10E6D.var_6879[var_0] + var_1;
  foreach(var_5, var_4 in level.var_10E6D.var_6879) {
    if(var_4 == var_2) {
      return var_5;
    }
  }

  return var_0;
}

func_6897(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(level.var_10E6D.var_6893)) {
    level.var_10E6D.var_6893 = [];
  }

  if(!isDefined(level.var_10E6D.var_6838)) {
    level.var_10E6D.var_6838 = [];
  }

  level.var_10E6D.var_6893[var_1] = var_0;
  level.var_10E6D.var_6838[var_1] = var_2;
}

func_6895(var_0) {
  return level.var_10E6D.var_6893[var_0];
}

func_683B(var_0) {
  return level.var_10E6D.var_6838[var_0];
}

func_6839() {
  self.var_10E6D.var_683A = undefined;
}

func_6860() {
  self notify("event_listener_thread");
  self endon("event_listener_thread");
  self endon("death");
  for(;;) {
    scripts\sp\utility::func_65E3("stealth_enabled");
    self waittill("ai_events", var_0);
    if(!scripts\sp\utility::func_65DB("stealth_enabled")) {
      continue;
    }

    if(self.precacheleaderboards || self _meth_81B7()) {
      continue;
    }

    foreach(var_2 in var_0) {
      if(!isDefined(var_2.issplitscreen)) {
        continue;
      }

      if(issentient(var_2.issplitscreen) && var_2.issplitscreen.ignoreme || var_2.issplitscreen.target_gettargetatindex) {
        continue;
      }

      if(isaircraft(var_2.issplitscreen)) {
        continue;
      }

      if(isDefined(var_2.issplitscreen.var_C841)) {
        if(isaircraft(var_2.issplitscreen.var_C841) || var_2.issplitscreen.var_C841.var_380 == "capital_ship") {
          continue;
        }
      }

      var_2.var_12AE9 = var_2.type;
      var_3 = func_6895(var_2.type);
      if(isDefined(var_3)) {
        var_4 = func_683B(var_2.type);
        var_5 = 0;
        if(var_4 > 0) {
          if(!isDefined(self.var_10E6D.var_683A)) {
            self.var_10E6D.var_683A = [];
          }

          if(!isDefined(self.var_10E6D.var_683A[var_2.type])) {
            self.var_10E6D.var_683A[var_2.type] = 1;
          } else {
            self.var_10E6D.var_683A[var_2.type] = self.var_10E6D.var_683A[var_2.type] + 1;
          }

          if(self.var_10E6D.var_683A[var_2.type] >= var_4) {
            var_3 = func_6898(var_3, 1);
          }
        }

        var_2.type = var_3;
      }

      lib_0F18::func_10E8B(var_2.type, var_2);
    }
  }
}

func_67FF(var_0, var_1, var_2, var_3) {
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

    if(!isDefined(var_8.var_10E6D)) {
      continue;
    }

    var_9 = distancesquared(var_8.origin, self.origin);
    var_0A = var_9 <= var_5;
    if(!var_0A && var_9 <= var_6) {
      if(var_8 lib_0F27::func_9D11(self) || var_8 lib_0F27::func_9D11(level.player)) {
        var_0A = 1;
      }
    }

    if(var_0A) {
      var_8 _meth_84F7(var_0, var_1, var_1.origin);
    }
  }
}

func_6800(var_0, var_1, var_2) {
  var_3 = getaiunittypearray("bad_guys");
  var_4 = squared(var_2);
  foreach(var_6 in var_3) {
    if(!isalive(var_6)) {
      continue;
    }

    if(!isDefined(var_6.var_10E6D)) {
      continue;
    }

    if(distancesquared(var_6.origin, var_1) <= var_4) {
      var_6 _meth_84F7(var_0, level.player, var_1);
    }
  }
}