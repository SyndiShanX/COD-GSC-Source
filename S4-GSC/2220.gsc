/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2220.gsc
*************************************************/

main() {
  _id_80AB();
  _id_7F83();
  _id_08AF::_id_115D(self._id_CE6E, self);
  _id_D645();
  _id_08AD::_id_56A2();
  thread _id_A0C5(level._id_0408._id_42B8, level._id_0408._id_42D9);
  _id_D13D("reset");
  _id_2C64("idle");
  _id_E7B0();

  if(isDefined(level._id_0408._id_5D96)) {
    self thread[[level._id_0408._id_5D96]]();
  }
}

_id_7F83() {
  scripts\engine\utility::_id_5473("stealth_enabled");
  scripts\engine\utility::_id_5474("stealth_enabled");
  scripts\engine\utility::_id_5473("stealth_override_goal");
  scripts\engine\utility::_id_5473("stealth_hold_position");
  scripts\engine\utility::_id_5473("stealth_attack");
  scripts\engine\utility::_id_5473("stealth_cover_blown");
  scripts\engine\utility::_id_5473("stealth_local_investigation_only");
  scripts\engine\utility::_id_5473("stealth_disable_unresponsive_ai_check");
  scripts\engine\utility::_id_5473("stealth_non_player_combat");
  _id_08B5::_id_720C("stealth_spotted");
  _id_08B5::_id_720C("stealth_cover_blown");
  _id_08B5::_id_720C("stealth_combat_hunting");
  _id_08B5::_id_720C("stealth_disable_unresponsive_ai_check");
}

_id_E7B0() {
  if(isDefined(self._id_03A0)) {
    self._id_0201 = self._id_03A0;
    return;
  }

  if(!isDefined(self _meth_8138())) {
    self._id_0201 = level._id_4570;
  }
}

_id_80AB() {
  self._id_0408 = spawnStruct();
  self._id_0408._id_6035 = [];
  self._id_0408._id_9C42 = 2;
  self._id_0408._id_C06F = 0;
  self._id_02E3 = _func_0219(level._id_0408._id_0031["#x3f9f87892596f8c5b"]["hidden"]);
  _id_08AA::_id_3D7D();
  self._id_0408._id_5699 = 0.0;

  if(!isDefined(level._id_0408._id_42B8)) {
    level._id_0408._id_42B8 = 175;
  }

  if(!isDefined(level._id_0408._id_42D9)) {
    level._id_0408._id_42D9 = 600;
  }

  self._id_0207 = 0.0;
  self._id_00D3 = 0;
  self._id_0408._id_2C56 = -1;
}

_id_43AF() {
  if(isDefined(self)) {
    _id_08B4::_id_F152("death");
  } else {
    foreach(var_1 in level.players) {
      foreach(var_4, var_3 in var_1._id_0408._id_F142) {
        if(!isDefined(var_3)) {
          var_1._id_0408._id_F142[var_4] = undefined;
        }
      }

      foreach(var_4, var_3 in var_1._id_0408._id_F15A) {
        if(!isDefined(var_3)) {
          var_1._id_0408._id_F15A[var_4] = undefined;
        }
      }
    }
  }

  if(isDefined(self._id_E7EE)) {
    self._id_E7EE thread _id_43D1();
  }
}

_id_43D1() {
  self _meth_83F8();
  waitframe();
  self delete();
}

_id_0F8B(var_0) {
  if(!isDefined(self._id_0408._id_0F2D)) {
    self._id_0408._id_0F2D = [];
  }

  self._id_0408._id_0F2D[self._id_0408._id_0F2D.size] = var_0;
}

_id_BDCB() {
  if(self._id_0229) {
    return;
  }
  if(!isDefined(level._id_0408)) {
    return;
  }
  var_0 = self _meth_86A9();
  var_1 = (self.origin + var_0) / 2;
  var_2 = (0, 0, 35);

  if(isDefined(self._id_BDCA)) {
    var_3 = self._id_BDCA;
  } else {
    var_3 = 1764;
  }

  var_4 = 11025;
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in level.players) {
    var_9 = 0;
    var_10 = 0;

    if(!isalive(var_8)) {
      continue;
    }
    if(_func_011D(var_8) && (var_8.ignoreme || var_8._id_02FA)) {
      continue;
    }
    var_11 = distancesquared(var_1, var_8.origin + var_2);

    if(distance2dsquared(self.origin, var_8.origin) < var_3) {
      var_12 = self.origin[2] - var_8.origin[2];

      if(var_12 * var_12 < 5184) {
        var_10 = 1;
        var_9 = 1;
      }
    }

    if(!var_9 && isDefined(level._id_0408._id_BDCD) && level._id_0408._id_BDCD > 0) {
      if(var_11 < level._id_0408._id_BDCD * level._id_0408._id_BDCD) {
        if(!isDefined(self._id_0408._id_2572)) {
          var_13 = var_8.origin - self.origin;
          var_13 = (var_13[0], var_13[1], 0);
          var_14 = anglesToForward((0, self.angles[1], 0));

          if(vectordot(var_14, var_13) > 0) {
            var_10 = 1;
            var_9 = 1;
          }
        }
      }
    }

    if(!var_9 && isDefined(level._id_0408._id_BDCC) && level._id_0408._id_BDCC > 0) {
      if(var_11 < level._id_0408._id_BDCC * level._id_0408._id_BDCC) {
        var_15 = _func_0134(var_8 getvelocity());

        if(var_15 > var_4) {
          var_10 = 1;
          var_9 = 1;
        }
      }
    }

    if(!var_9 && isDefined(level._id_0408._id_BDCE) && level._id_0408._id_BDCE > 0) {
      if(var_11 < level._id_0408._id_BDCE * level._id_0408._id_BDCE) {
        if(self _meth_8067(var_8, 0)) {
          var_9 = 1;
        }
      }
    }

    if(var_9 && var_10) {
      var_9 = scripts\engine\trace::ray_trace_passed(self _meth_86A9(), var_8 getEye(), [self, var_8]);
    }

    if(var_9) {
      self _meth_8523("proximity", var_8, var_8.origin);
      scripts\engine\utility::_id_46A5(0.05, ::_meth_812E, var_8);
      return;
    }
  }
}

_id_D173(var_0, var_1) {
  if(!isDefined(self._id_0408)) {
    return;
  }
  if(!var_0 && !isDefined(self._id_0408._id_2572)) {
    return;
  }
  var_2 = isDefined(self._id_5D98) && self[[self._id_5D98]]();
  var_3 = isDefined(self._id_5D99) && self[[self._id_5D99]]();
  var_4 = var_2 || var_3;

  if(var_0 && (!var_4 || istrue(var_1))) {
    self._id_0408._id_2572 = 1;
    _id_D3A0("blind");
  } else {
    self._id_0408._id_2572 = undefined;

    if(var_4) {
      _id_D3A0("spotted");
    } else {
      _id_D3A0("hidden");
    }
  }
}

_id_D3A0(var_0) {
  switch (var_0) {
    case "blind":
      _id_08B4::_id_F152("blind");
      self._id_01D9 = 0.98;
      self._id_01DA = 0.98;
      self._id_01DD = 0;
      self._id_01DF = 0;
      self._id_01DB = 0.99;
      self._id_01DC = 1;
      break;
    case "unaware":
    case "hidden":
    case "idle":
      _id_08B4::_id_F152("hidden");
      self._id_01D9 = 0.7;
      self._id_01DA = 0.86;
      self._id_01DD = 0.97;
      self._id_01DF = 1;
      self._id_01DB = 0.01;
      self._id_01DC = 90000;
      break;
    case "investigate":
      _id_08B4::_id_F152("investigate");
      self._id_01D9 = 0.7;
      self._id_01DA = 0.86;
      self._id_01DD = 0.97;
      self._id_01DF = 1;
      self._id_01DB = 0.01;
      self._id_01DC = 90000;
      break;
    case "combat_hunt":
    case "hunt":
      _id_08B4::_id_F152("combat_hunt");
      self._id_01D9 = 0.7;
      self._id_01DA = 0.86;
      self._id_01DD = 0.97;
      self._id_01DF = 1;
      self._id_01DB = 0.01;
      self._id_01DC = 90000;
      break;
    case "spotted":
    case "combat":
      _id_08B4::_id_F152("spotted");
      self._id_01D9 = 0.01;
      self._id_01DA = 0.574;
      self._id_01DD = 0;
      self._id_01DF = 0;
      self._id_01DB = 0.01;
      self._id_01DC = 16384;
      break;
    case "flashlight_in_dark":
      break;
    case "townhouse":
      break;
    case "elevated":
      break;
  }
}

_id_1433(var_0) {
  thread _id_08B5::_id_10AC("stealth", "announce5", "alertreset");
  _id_D13D("reset");
  _id_2C64("idle");
  _id_08B5::_id_70F7();
}

_id_D13D(var_0, var_1) {
  if(!scripts\engine\utility::_id_546E("stealth_enabled")) {
    return;
  }
  if(isDefined(self._id_1436) && self._id_1436 == var_0) {
    return;
  }
  self notify("set_alert_level");
  self endon("set_alert_level");
  self endon("death");

  if(isDefined(var_1) && isDefined(self._id_1436) && _id_08B5::_id_1435(self._id_1436) < _id_08B5::_id_1435(var_0)) {
    if(isDefined(level.players) && level.players.size > 0) {
      foreach(var_3 in level.players) {
        var_1._id_1428 = _id_08B5::_id_1435(var_0);
        var_3 scripts\engine\utility::_id_CD61("logStealthAlertIfNeeded", var_1);
      }
    }
  }

  self._id_1436 = var_0;

  while(isDefined(self._id_0426)) {
    wait 0.05;
  }

  _id_08B5::_id_D3C9(var_0);
  self notify("stealth_alertlevel_change", var_0);
  self._id_0038 = _id_08B5::_id_1434(var_0);
  var_5 = self._id_0039 > 2;
  _id_08AD::_id_5694(!var_5);
  self._id_022B = !var_5;
}

_id_D1C0() {
  level _id_08B5::_id_D3C4("go_to_node_wait", ::_id_7071);
  level _id_08B5::_id_D3C4("go_to_node_arrive", ::_id_7067);
  level _id_08B5::_id_D3C4("go_to_node_post_wait", ::_id_706A);
  level _id_08B5::_id_D3C4("reset", ::_id_1433);
  level _id_08B5::_id_D3C4("set_patrol_style", _id_08B5::_id_D2E8);
  level _id_08B5::_id_D3C4("trigger_cover_blown", ::_id_F598);
  level _id_08B5::_id_D3C4("set_blind", ::_id_D173);
  level _id_08B5::_id_D3C4("investigate", ::_id_2C62);
  level _id_08B5::_id_D3C4("cover_blown", ::_id_2C62);
  level _id_08B5::_id_D3C4("combat", ::_id_2C62);
}

_id_A0C5(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;

  for(;;) {
    if(!isalive(self)) {
      return;
    }
    self waittill("damage", var_4, var_5, var_6, var_7);
    _id_3486(var_4, var_5, var_7);
    var_8 = self.origin;

    if(isalive(self) && !scripts\engine\utility::_id_546E("stealth_enabled")) {
      continue;
    }
    if(isalive(var_5)) {
      var_2 = var_5;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    self _meth_8523("damage", var_2, var_2.origin);

    if(isPlayer(var_2) || isDefined(var_2.team) && var_2.team != var_3) {
      break;
    }

    if(isDefined(var_2.classname) && var_2.classname == "script_model") {
      if(var_2._id_8779) {
        break;
      }
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_0408._id_AD3A)) {
    var_0 = self._id_0408._id_AD3A;
  } else if(isDefined(level._id_0408._id_AD3A)) {
    var_0 = level._id_0408._id_AD3A;
  }

  if(isDefined(self._id_0408._id_AD3B)) {
    var_1 = self._id_0408._id_AD3B;
  } else if(isDefined(level._id_0408._id_AD3B)) {
    var_1 = level._id_0408._id_AD3B;
  }

  if(isalive(self)) {
    _id_08AD::_id_568C("ally_damaged", "ally_hurt_peripheral", var_2, var_0, var_1);
  } else {
    _id_08AD::_id_568C("ally_killed", "ally_hurt_peripheral", var_2, var_0, var_1);
  }
}

_id_3486(var_0, var_1, var_2) {
  if(isDefined(self._id_4AAE)) {
    return;
  }
  if(var_0 > 0 && self.damagemod != "MOD_MELEE" && self._id_1436 != "attack" && self._id_1436 != "combat") {
    var_3 = self getEye();

    if(distancesquared(var_2, var_3) < _func_0219(level._id_0408._id_75E5)) {
      self dodamage(self.health, var_2, var_1, var_1, "MOD_HEAD_SHOT");
    }
  }
}

_id_DA60(var_0) {
  var_1 = _func_0074("bad_guys", "all");
  var_2 = [];
  var_3 = _func_0219(level._id_0408._id_42B8);
  var_4 = _func_0219(level._id_0408._id_42D9);

  foreach(var_6 in var_1) {
    if(var_6 == var_0) {
      continue;
    }
    var_7 = distancesquared(var_0.origin, var_6.origin);

    if(var_7 < var_3) {
      return 0;
    }

    if(var_7 < var_4) {
      if(var_6 _meth_8515(self) > 0) {
        return 0;
      }

      if(var_6 scripts\engine\math::_id_B9AB(var_0.origin, 0) && var_6 _meth_861A(var_0)) {
        return 0;
      }

      var_2[var_2.size] = var_6;
    }
  }

  foreach(var_6 in var_2) {
    if(var_6 _meth_8067(var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_DA5F(var_0) {
  var_1 = _func_0074("bad_guys", "all");
  var_2 = [];
  var_3 = _func_0219(level._id_0408._id_42B8);
  var_4 = _func_0219(level._id_0408._id_42D9);

  foreach(var_6 in var_1) {
    if(var_6 == var_0) {
      continue;
    }
    var_7 = distancesquared(var_0.origin, var_6.origin);

    if(var_7 < var_3) {
      return 1;
    }

    if(var_7 < var_4) {
      if(var_6 _meth_8515(self) > 0) {
        return 1;
      }

      if(var_6 scripts\engine\math::_id_B9AB(var_0.origin, 0)) {
        if(var_6 _meth_861A(var_0)) {
          return 1;
        }

        var_2[var_2.size] = var_6;
      }
    }
  }

  foreach(var_6 in var_2) {
    if(var_6 _meth_8067(var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_7621(var_0) {
  if(var_0) {
    if(!isDefined(self._id_0408._id_15C8)) {
      self._id_0408._id_15C8 = 1;
    } else if(!self._id_0408._id_15C8) {
      return;
    }
    if(!isDefined(self._id_0408._id_9800)) {
      self._id_0408._id_9800 = level.player;
    }

    scripts\common\utility::_id_97EE(level.player);
  } else if(isDefined(self._id_0408._id_9800)) {
    self._id_0408._id_9800 = undefined;
    scripts\common\utility::_id_97EE();
  }
}

_id_96E7(var_0) {
  self endon("death");
  self notify("lock_headtracking_off");
  self endon("lock_headtracking_off");
  _id_4A35();
  wait(var_0);
  _id_5216();
}

_id_4A35() {
  self._id_0408._id_15C8 = 0;
  _id_7621(0);
}

_id_5216() {
  self._id_0408._id_15C8 = 1;
}

_id_569E(var_0) {
  var_1 = self._id_0408._id_56AB;

  if(!isDefined(var_1)) {
    var_1 = level._id_0408._id_56AB;
  }

  if(isDefined(var_1)) {
    var_2 = _id_08AD::_id_56A9(var_1, var_0.type);

    if(var_2 > 0) {
      return 1;
    }
  }

  if(istrue(level._id_0408._id_4B39) && _id_56A6(var_0)) {
    return 1;
  }

  if(var_0._id_F8E4 == "explode") {
    if(isDefined(var_0._id_019B) && isDefined(var_0._id_019B.team) && var_0._id_019B.team == self.team) {
      return 1;
    }
  }

  if(var_0._id_F8E4 == "footstep_sprint") {
    if(_id_DAAD(var_0)) {
      return 1;
    }
  }

  if(var_0._id_F8E4 == "silenced_shot") {
    if(isPlayer(var_0._id_019B) && distancesquared(var_0._id_019B getEye(), var_0.origin) > 1296) {
      return 1;
    }
  }

  if(var_0._id_F8E4 == "gunshot" || var_0._id_F8E4 == "gunshot_teammate" || var_0._id_F8E4 == "bulletwhizby") {
    if(isai(var_0._id_019B) && var_0._id_019B _meth_81C7()) {
      return 1;
    }
  }

  if(istrue(_id_08A8::_id_E79C("event_should_ignore", var_0))) {
    return 1;
  }

  var_3 = _id_08A8::_id_E7AD("event_" + var_0.type);

  if(isDefined(var_3)) {
    return _id_08A8::_id_E79C("event_" + var_0.type, var_0);
  }

  return 0;
}

_id_DAAD(var_0) {
  var_1 = (0, 0, 18);
  var_2 = level._id_0408._id_31FA;

  if(isDefined(self._id_0408._id_31FA)) {
    var_2 = scripts\engine\utility::array_combine(var_2, self._id_0408._id_31FA);
  }

  if(isPlayer(var_0._id_019B) && scripts\engine\utility::_id_30FE(var_0.origin + var_1, self, var_2)) {
    var_3 = distancesquared(self.origin, var_0.origin);
    var_4 = 250;

    if(isDefined(self._id_E45F)) {
      var_4 = self._id_E45F;
    }

    if(var_3 < var_4 * var_4) {
      return 0;
    }

    var_5 = self _meth_8067(var_0._id_019B);

    if(!var_5 && var_0._id_019B _id_08B4::_id_B51A(self)) {
      return 0;
    }
  }

  return 1;
}

_id_56A6(var_0) {
  if(_func_011D(var_0._id_019B)) {
    switch (var_0._id_F8E4) {
      case "footstep_walk":
      case "footstep":
      case "footstep_sprint":
      case "proximity":
        thread _id_08B4::_id_F147(var_0._id_019B, 1.0);
        return 1;
    }
  }

  return 0;
}

_id_56A5(var_0) {
  if(_func_011D(var_0._id_019B)) {
    switch (var_0._id_F8E4) {
      case "proximity":
        return 1;
      case "silenced_shot":
      case "gunshot":
      case "grenade danger":
      case "projectile_impact":
      case "bulletwhizby":
      case "explode":
        var_0.type = "combat";
        return 0;
    }
  }

  if(var_0.type != "combat") {
    return 1;
  }

  return 0;
}

_id_568B(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = _func_0074("bad_guys", "all");

  foreach(var_5 in var_3) {
    if(distancesquared(var_0, var_5.origin) <= var_2) {
      return 1;
    }
  }

  return 0;
}

_id_569F(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_F8E4)) {
    return;
  }
  if(self[[self._id_5D99]]()) {
    if(var_0.type == "investigate") {
      var_0.type = "cover_blown";
    }
  }

  switch (var_0._id_F8E4) {
    case "sight":
      if(self._id_EAB8 == "dog") {
        var_0.type = "investigate";
      } else if(isDefined(self._id_0408._id_F14A)) {
        var_1 = undefined;

        if(isDefined(var_0._id_019B) && _func_011D(var_0._id_019B)) {
          var_1 = var_0._id_019B getentitynumber();
        }

        if(isDefined(var_1) && isDefined(self._id_0408._id_F14A[var_1]) && self._id_0408._id_F14A[var_1] == 0) {
          var_2 = var_0._id_019B;

          if(isPlayer(var_0._id_019B)) {
            var_3 = var_0._id_019B _id_08B5::_id_666E();

            if(isDefined(var_3) && !self _meth_8067(var_0._id_019B)) {
              var_2 = var_3;
            }
          }

          self _meth_812E(var_2);
          var_0.type = "combat";
        }
      }

      break;
    case "grenade danger":
      if(_id_568B(var_0.origin, 128)) {
        var_0.type = "combat";
      }

      break;
    case "explode":
      if(_id_568B(var_0.origin, 192)) {
        var_0.type = "combat";
      } else if(distancesquared(var_0.origin, self.origin) <= 1048576) {
        var_0.type = "combat";
      }

      break;
    case "gunshot":
      if(distancesquared(var_0.origin, self.origin) < 640000) {
        var_0.type = "combat";
      }

      break;
    case "glass_destroyed":
      if(self _meth_861A(var_0.origin, 0) && distance2dsquared(var_0.origin, self.origin) < 36864) {
        var_0.type = "combat";
      }

      break;
  }
}

_id_F598(var_0, var_1) {
  if(!isDefined(self._id_0408)) {
    return;
  }
  self._id_0408._id_243B = 1;
  self._id_0408._id_2465 = var_1;
}

_id_C07D(var_0) {
  self endon("death");
  var_1 = randomfloatrange(0.5, 1.1);

  switch (var_0.type) {
    case "investigate":
      thread _id_08B5::_id_10AC("stealth", "announce5", "investigate", var_1);
      return 1;
    case "cover_blown":
      thread _id_08B5::_id_10AC("stealth", "announce5", "coverblown", var_1);
      return 1;
    case "combat":
      thread _id_08B5::_id_10AC("stealth", "announce2", "combat", 1);
      return 1;
  }

  return 0;
}

_id_C07E(var_0) {
  self endon("death");

  if(isDefined(var_0._id_F8E4)) {
    var_1 = randomfloatrange(0.5, 1.0);

    switch (var_0._id_F8E4) {
      case "sight":
        thread _id_08B5::_id_10AC("stealth", "announce2", "sight", var_1);
        return 1;
      case "explode":
        thread _id_08B5::_id_10AC("stealth", "announce1", "explosion", var_1);
        return 1;
      case "grenade danger":
        thread _id_08B5::_id_10AC("stealth", "announce2", "grenade_danger", var_1);
        return 1;
      case "seek_backup":
        thread _id_08B5::_id_10AC("stealth", "announce4", "seek_backup", randomfloatrange(2, 2.5), var_0);
        return 1;
      case "found_corpse":
      case "saw_corpse":
        thread _id_08B5::_id_10AC("stealth", "announce4", var_0._id_F8E4, var_1);
        return 1;
      case "unresponsive_teammate":
        thread _id_08B5::_id_10AC("stealth", "announce4", "unresponsive_teammate");
        return 1;
      case "bulletwhizby":
        thread _id_08B5::_id_10AC("stealth", "announce2", "bulletwhizby", 0.2, var_0);
        return 1;
      case "silenced_shot":
        thread _id_08B5::_id_10AC("stealth", "announce2", "silenced_shot", randomfloatrange(0.8, 1.3), var_0);
        return 1;
      case "gunshot":
        thread _id_08B5::_id_10AC("stealth", "announce1", "gunshot", 0.2, var_0);
        return 1;
      case "gunshot_teammate":
        thread _id_08B5::_id_10AC("stealth", "announce1", "gunshot_teammate", 0.2, var_0);
        return 1;
      case "ally_damaged":
        thread _id_08B5::_id_10AC("stealth", "announce1", "gunshot", randomfloatrange(0.8, 1.3), var_0);
        return 1;
      case "ally_killed":
        thread _id_08B5::_id_10AC("stealth", "announce1", "ally_killed", 0.5);
        return 1;
      case "proximity":
        thread _id_08B5::_id_10AC("stealth", "announce1", "proximity", 0.5);
        return 1;
      case "footstep":
        thread _id_08B5::_id_10AC("stealth", "announce5", "footstep", var_1);
        return 1;
      case "footstep_sprint":
        thread _id_08B5::_id_10AC("stealth", "announce5", "footstep_sprint", var_1);
        return 1;
      case "light_killed":
        thread _id_08B5::_id_10AC("stealth", "announce4", "light_killed", var_1);
        return 1;
      case "glass_destroyed":
        thread _id_08B5::_id_10AC("stealth", "announce4", "glass_destroyed", var_1);
        return 1;
      case "window_open":
        thread _id_08B5::_id_10AC("stealth", "announce4", "window_open", var_1);
        return 1;
      case "damage":
        return 1;
      default:
    }
  }

  return 0;
}

_id_7073(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = !var_2;

  while(_id_08B5::_id_E797() || !var_3) {
    _id_08B5::_id_E798();
    self[[var_0]](var_1);
    var_3 = 1;
    self waittill("goal");
  }
}

_id_7071(var_0, var_1) {
  self endon("death");
  self._id_0B67._id_7CCD = undefined;
  _id_7073(var_0, var_1);
}

_id_706A(var_0, var_1) {
  self endon("death");
  self notify("gotonode_post_wait");

  if(isDefined(self._id_0408._id_7CA9) && isDefined(var_1.target)) {}

  if(isDefined(var_1.target)) {
    self._id_0B67._id_7CCD = undefined;
  }
}

_id_7067(var_0, var_1) {
  _id_7073(var_0, var_1, 0);

  if(isDefined(var_1._id_CDC6)) {
    self._id_A246 = var_1._id_CDC6;
  }

  if((istrue(var_1._id_0393) || istrue(var_1._id_CCFD) || istrue(var_1._id_CEB7) || isDefined(var_1._id_CD86) || istrue(var_1._id_AF43) || !isDefined(var_1.target)) && isDefined(var_1.angles)) {
    self._id_0B67._id_7CCD = var_1;

    if(!istrue(var_1._id_0393) && !istrue(var_1._id_CEB7)) {
      waitframe();
    }
  }

  if(isDefined(var_1._id_CC9D)) {
    var_2 = var_1._id_CC9D;
    _id_08B5::_id_18A9(self, "gravity", var_2);
  } else if(isDefined(var_1._id_CD86))
    self._id_0B67._id_7CCD = var_1;

  if(isDefined(var_1._id_CC9E)) {
    _id_08B5::_id_18A9(self, "gravity", var_1._id_CC9E);
  }
}

_id_D645() {
  var_0 = _id_08B5::_id_664D();
  var_1 = isDefined(var_0) && var_0 != "unaware";
  var_2 = _id_08AF::_id_6A80(self._id_CE6E);

  if(isDefined(var_0) && var_0 == "cqb") {
    _id_08B5::_id_D2E8("cqb");
  } else if(var_1 || isDefined(self._id_0408._id_243B) || isDefined(var_2._id_243B)) {
    var_3 = isDefined(self._id_0408._id_2465) && self._id_0408._id_2465;
    var_4 = _id_0009::_id_1C61() == "patrol" && var_3;
    _id_08B5::_id_D2E8("alert", var_4, undefined, "small");
  } else
    _id_08B5::_id_D2E8("unaware");
}

_id_2C64(var_0, var_1) {
  self[[self._id_5DBF]](var_0, var_1);
}

_id_2C62(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0._id_019B) && var_0._id_F8E4 == "sight") {
    var_2 = var_0._id_019B _id_08B5::_id_666E();

    if(isDefined(var_2) && !self _meth_8067(var_0._id_019B)) {
      var_1 = var_2;
    }
  }

  var_0._id_8512 = var_0.origin;

  if(isDefined(self._id_0192) && isDefined(var_0._id_019B) && var_0._id_019B == self._id_0192) {
    var_0._id_8512 = self _meth_8204(self._id_0192);
  } else if(isDefined(var_0._id_019B) && var_0._id_F8E4 == "bulletwhizby") {
    var_0._id_8512 = var_0._id_019B.origin;
  } else if(isDefined(var_1)) {
    var_0._id_8512 = var_1.origin;
  }

  _id_569F(var_0);

  if(_id_569E(var_0)) {
    return 0;
  }

  if(isDefined(var_1)) {
    var_0._id_019B = var_1;
  }

  self._id_0408._id_8F5A = gettime();

  if(!_id_08B5::_id_2434()) {
    if(!_id_C07E(var_0)) {
      _id_C07D(var_0);
    }
  }

  switch (var_0.type) {
    case "investigate":
      thread _id_2C63(var_0);
      break;
    case "cover_blown":
      thread _id_2C61(var_0);
      break;
    case "combat":
      thread _id_2C60(var_0);
      break;
  }

  level notify("stealth_event", var_0, self);
  var_3 = _id_08A8::_id_E7AD(var_0._id_F8E4);

  if(isDefined(var_3) && var_3 != ::_id_2C62) {
    self thread[[var_3]](var_0);
  }

  return 1;
}

_id_2C63(var_0) {
  _id_D13D("warning1", var_0);
  _id_2C64("investigate", var_0);
}

_id_2C61(var_0) {
  _id_D13D("warning2", var_0);

  if(isDefined(var_0._id_019B) && isDefined(var_0._id_019B.classname) && var_0._id_019B.classname == "script_vehicle_blackhornet") {
    return;
  }
  if(istrue(level._id_0408._id_4B39)) {
    switch (var_0._id_F8E4) {
      case "silenced_shot":
      case "gunshot":
      case "explode":
        _id_08B5::_id_D1DC(0);
        level scripts\engine\utility::delaythread(20, _id_08B5::_id_D1DC, 1);
        break;
    }
  }

  if(var_0._id_F8E4 == "light_killed") {
    var_0._id_97DB = var_0._id_8512;
    var_0._id_8512 = scripts\engine\utility::_id_5000(var_0._id_8512, 24, -256);
  }

  if(!self[[self._id_5D98]]()) {
    if(self[[self._id_5D99]]()) {
      var_1 = _id_08AF::_id_7220(self, var_0._id_8512);

      if(!isDefined(self._id_0323) || distancesquared(var_1, self._id_0323) > 576) {
        _id_0009::_id_1C52("hunt", "knownpos", var_0._id_8512);
        _id_08B5::_id_D2E7(var_0._id_8512, "small");
        return;
      }
    } else
      _id_2C64("investigate", var_0);
  }
}

_id_2C60(var_0) {
  self notify("investigate_behavior");
  self notify("stop_going_to_node");
  _id_D13D("attack", var_0);
  _id_2C64("combat", var_0);

  if(isDefined(var_0) && _func_011D(var_0._id_019B)) {
    if(!isDefined(self._id_0192)) {
      self _meth_8622();
    }

    thread _id_D368();
  }

  scripts\engine\utility::_id_5474("stealth_attack");
}

_id_D368() {
  self._id_0352 = 1;
  self endon("death");
  self endon("stealth_investigate");
  self endon("stealth_hunt");
  self endon("stealth_combat");
  wait 5;
  self._id_0352 = 0;
}