/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2227.gsc
*************************************************/

main() {
  if(isDefined(self._id_0408)) {
    return;
  }
  self endon("death");
  self endon("stealth_disabled");
  self._id_0408 = spawnStruct();
  _id_08B5::_id_720C("stealth_spotted");
  scripts\engine\utility::_id_5473("stealth_enabled");
  scripts\engine\utility::_id_5474("stealth_enabled");
  scripts\engine\utility::_id_5473("stealth_in_shadow");
  scripts\engine\utility::_id_5473("stealth_use_real_lighting");
  scripts\engine\utility::_id_5474("stealth_use_real_lighting");
  self._id_0408._id_E439 = [];
  _id_08B5::_id_71F7();
  thread _id_9CBC();

  if(scripts\common\utility::issp()) {
    thread _id_E7FC();
  }
}

_id_9CBC() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(_id_9CBB()) {
      self._id_02A1 = _id_6449();
    }

    waitframe();
  }
}

_id_9CBB() {
  if(istrue(self._id_9CBD)) {
    return 0;
  }

  if(!scripts\engine\utility::_id_546E("stealth_enabled")) {
    return 0;
  }

  if(scripts\engine\utility::_id_546E("stealth_in_shadow")) {
    return 1;
  }

  if(isDefined(self._id_9494) && gettime() < self._id_9494) {
    return 0;
  }

  return 1;
}

_id_6449() {
  var_0 = self getstance();

  if(_id_08B5::_id_721C()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level._id_0408._id_4892._id_C01B[var_1][var_0];
  var_3 = 0;

  if(scripts\engine\utility::_id_546E("stealth_in_shadow")) {
    var_2 = var_2 * level._id_0408._id_4892._id_C01B[var_1]["shadow"];
    var_3 = 1;
  } else if(scripts\engine\utility::_id_546E("stealth_use_real_lighting")) {
    var_2 = var_2 * self _meth_8626();
    var_3 = 1;
  }

  if(var_3) {
    var_2 = max(var_2, level._id_0408._id_4892._id_9F37[var_1][var_0]);
  }

  return var_2;
}

_id_3AC9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!var_0) {
    self notify("stop_player_combat_state_thread");
    self._id_0408._id_3AC6 = undefined;
    return;
  } else if(isDefined(self._id_0408._id_3AC6)) {
    return;
  }
  self endon("death");
  self endon("stealth_disabled");
  self endon("stop_player_combat_state_thread");
  self endon("disconnect");
  childthread _id_B660();
  childthread _id_3ACA();
  self._id_0408._id_3AC6 = spawnStruct();
  self._id_0408._id_3AC6.name = "stealth";
  self._id_0408._id_3AC6.type = "idle";
  self._id_0408._id_3AC6._id_FC74 = [];
  var_1 = [];
  var_2 = [];

  for(;;) {
    scripts\engine\utility::_id_5476("stealth_enabled");
    var_1 = scripts\engine\utility::_id_1BD1(var_1);
    var_1 = scripts\engine\utility::_id_1BCA(var_1);
    var_2 = scripts\engine\utility::_id_1BD1(var_2);
    var_2 = scripts\engine\utility::_id_1BCA(var_2);
    var_3 = [];
    var_4 = [];
    var_5 = 0;

    if(isDefined(self._id_8F91) && !scripts\engine\utility::_id_F1EB(self._id_8F91, 10)) {
      var_5 = 1;
    }

    foreach(var_7 in _func_0070("axis")) {
      if(!isalive(var_7)) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(var_1, var_7)) {
        if(var_7._id_017C) {
          continue;
        }
        if(scripts\engine\utility::is_equal(var_7.script, "pain")) {
          continue;
        }
      }

      if(var_7[[var_7._id_5D98]]()) {
        if(isDefined(self._id_0408._id_3AC6._id_9C5E)) {
          var_8 = self._id_0408._id_3AC6._id_9C5E;

          if(distancesquared(self.origin, var_7.origin) > _func_0219(var_8)) {
            var_4[var_4.size] = var_7;
            continue;
          }
        }

        var_3[var_3.size] = var_7;

        if(var_5) {
          continue;
        }
        if(!scripts\engine\utility::is_equal(var_7._id_0192, self)) {
          continue;
        }
        if(var_7 _meth_8067(self)) {
          var_5 = 1;
        }

        continue;
      }

      if(var_7[[var_7._id_5D99]]()) {
        var_4[var_4.size] = var_7;
      }
    }

    var_10 = self._id_0408._id_3AC6.name;
    var_11 = self._id_0408._id_3AC6.type;
    var_12 = var_10;
    var_13 = undefined;

    if(var_10 == "combat") {
      if(var_3.size == 0) {
        var_12 = "stealth";

        if(scripts\engine\utility::_id_1BB4(var_1, var_4).size > 0) {
          var_13 = "hunt";
        } else if(var_4.size == 0) {
          var_13 = "all_clear";
        } else {
          var_13 = "combat_clear";
        }
      } else if(scripts\engine\utility::is_equal(var_11, "unaware") && var_5)
        var_13 = "aware";
    } else if(var_3.size > 0) {
      var_12 = "combat";

      if(var_5) {
        var_13 = "aware";
      } else {
        var_13 = "unaware";
      }
    } else if(scripts\engine\utility::is_equal(var_11, "hunt") && var_4.size == 0)
      var_13 = "all_clear";

    if(var_12 != var_10 || isDefined(var_13) && !scripts\engine\utility::is_equal(var_13, var_11)) {
      self._id_0408._id_3AC6.name = var_12;
      self._id_0408._id_3AC6.type = var_13;
      self notify("player_combat_state_updated", var_12, var_13);
    }

    var_1 = var_3;
    var_2 = var_4;
    waitframe();
  }
}

_id_3ACA() {
  for(;;) {
    self waittill("player_combat_state_updated", var_0, var_1);

    foreach(var_3 in self._id_0408._id_3AC6._id_FC74) {
      self thread[[var_3]](var_0, var_1);
    }
  }
}

_id_3AC7(var_0, var_1) {
  self._id_0408._id_3AC6._id_FC74[var_0] = var_1;
}

_id_3AC8(var_0) {
  self._id_0408._id_3AC6._id_FC74 = scripts\engine\utility::_id_1BC6(self._id_0408._id_3AC6._id_FC74, var_0);
}

_id_B660() {
  for(;;) {
    level scripts\engine\utility::waittill_any_2("an_enemy_shot", "enemy_grenade_fire");
    self._id_8F91 = gettime();
  }
}

_id_E7FC() {
  self endon("stealth_disabled");
  self._id_0408._id_7998 = spawnStruct();
  self._id_0408._id_7998._id_334A = undefined;
  self._id_0408._id_7998._id_852A = [];
  self._id_0408._id_7998._id_43EE["footstep_sprint"] = 6;
  self._id_0408._id_7998._id_43EE["gunshot"] = 8;
  self._id_0408._id_7998._id_43EE["proximity_speed"] = 16;
  self._id_0408._id_7998._id_43EE["sight_standing"] = 19;
  childthread _id_E7FB();
  childthread _id_E7FA();
  childthread _id_E7F9();
}

_id_E7FB() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::_id_5476("stealth_enabled");
    level waittill("stealth_event", var_0, var_1);

    if(!isalive(var_1)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(var_0._id_019B, level.player)) {
      continue;
    }
    if(!scripts\engine\utility::_id_546E("stealth_enabled")) {
      self._id_0408._id_7998._id_334A = undefined;
      self._id_0408._id_7998._id_852A = [];
      continue;
    }

    if(_id_08B5::_id_1907()) {
      if(var_0.type != "combat") {
        continue;
      }
      var_2 = 0;

      foreach(var_4 in _func_0070(var_1.team)) {
        if(var_4 == var_1) {
          continue;
        }
        if(var_4[[var_4._id_5D98]]()) {
          var_2 = 1;
          break;
        }
      }

      if(var_2) {
        continue;
      }
    }

    var_6 = var_0._id_F8E4;

    if(var_6 == "gunshot" && !istrue(level._id_75BA)) {
      continue;
    }
    if((var_6 == "sight" || var_6 == "proximity") && self issprinting()) {
      var_6 = "footstep_sprint";
    } else if(var_6 == "proximity" && _func_0134(level.player getvelocity()) > 11025) {
      var_6 = "proximity_speed";
    } else if(var_6 == "sight" && self getstance() == "stand") {
      var_6 = "sight_standing";
    }

    if(!isDefined(self._id_0408._id_7998._id_43EE[var_6])) {
      continue;
    }
    if(scripts\engine\utility::array_contains(self._id_0408._id_7998._id_852A, var_1)) {
      continue;
    }
    childthread _id_E7F8(var_1, var_6);
  }
}

_id_E7F8(var_0, var_1) {
  self endon("combat_started");
  self endon("stealth_enabled");
  self._id_0408._id_7998._id_852A[self._id_0408._id_7998._id_852A.size] = var_0;

  if(var_0[[var_0._id_5D99]]()) {
    var_0 scripts\engine\utility::delaythread(10, scripts\engine\utility::_id_D0AE, "stealthHints_timeout");
    var_0 scripts\engine\utility::waittill_any_3("stealth_combat", "death", "stealthHints_timeout");
  } else if(var_0[[var_0._id_5D9C]]())
    var_0 scripts\engine\utility::waittill_any_3("stealth_idle", "stealth_combat", "death");

  self._id_0408._id_7998._id_852A = scripts\engine\utility::array_remove(self._id_0408._id_7998._id_852A, var_0);

  if(!isalive(var_0) || !var_0[[var_0._id_5D98]]()) {
    return;
  }
  self._id_0408._id_7998._id_334A = var_1;
  self._id_0408._id_7998._id_852A = [];
  self notify("combat_started");
}

_id_E7FA() {
  self waittill("death");

  if(!scripts\engine\utility::_id_546E("stealth_enabled")) {
    return;
  }
  if(isDefined(level._id_4235)) {
    return;
  }
  if(!isDefined(self._id_0408._id_7998._id_334A)) {
    return;
  }
  level._id_4235 = self._id_0408._id_7998._id_43EE[self._id_0408._id_7998._id_334A];
}

_id_E7F9() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::_id_5476("stealth_enabled");

    while(!isDefined(self._id_0408._id_7998._id_334A)) {
      waitframe();
    }

    while(_id_08B5::_id_1907()) {
      waitframe();
    }

    self._id_0408._id_7998._id_334A = undefined;
  }
}