/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1789.gsc
*************************************************/

_id_8252() {
  scripts\engine\utility::_id_5C24("interactions_initialized");
  wait 1;
  level._id_24D2 = undefined;
  level._id_BC3D = undefined;
  var_0 = scripts\engine\utility::getStructArray("soldier_patrol", "script_noteworthy");
  level._id_15ED = var_0;
  var_1 = 1;
  level._id_8F4C = 0;

  foreach(var_3 in var_0) {
    var_3._id_AF4E = 0;
    var_3._id_7C8C = var_1;
    var_3._id_B02A = 0;
    var_1++;
  }

  if(scripts\engine\utility::_id_5C0C("patrolPoints_initialized")) {
    scripts\engine\utility::_id_5C1B("patrolPoints_initialized");
  }

  level thread _id_E09D();
}

_id_D1BC() {
  self._id_A991 = self._id_0201;
  self._id_0201 = 48;
  self._id_0229 = 1;
  self._id_CF4A = 1;
  self._id_42EC = undefined;
  thread _id_575F();
  thread _id_E006();
  self._id_E7B2 = 1;
}

_id_D1B8() {
  self notify("patrol_values_set");
  _id_D644("patrol", "patrol", 0, 0, 0, undefined, 0, 1);
  self._id_A991 = self._id_0201;
  self._id_0201 = 48;
  self._id_0229 = 1;
  self._id_CF4A = 1;
  self._id_42EC = undefined;
  thread _id_575F();
  thread _id_E006();
  self._id_E7B2 = 1;
}

_id_10B31(var_0) {
  var_0 endon("death");
  var_0 notify("watchForNotifies");
  var_0 endon("watchForNotifies");
  var_0._id_A69A = [];
  var_1 = ["death", "alerted", "texthandler", "set_goal_pos_requested", "goal_reached", "stalled", "patrol_path", "stop_patrol_logic", "watchForBulletWhizby", "exit_patrol_mode", "watchForSoldierKilled", "alertNearbyEnemiesAfterDelay", "watchForWeaponFire", "alertNearbyLoop", "soldier_investigate", "alerted_hunt_mode", "hunt_player", "exit_stealth", "soldier_player_listener", "patrol_values_set", "goal"];

  foreach(var_3 in var_1) {
    var_0._id_A69A[var_3] = 0;
  }

  for(;;) {
    var_5 = var_0 scripts\engine\utility::_id_10893(var_1);
    var_0._id_A69A[var_5]++;
  }
}

_id_AF41(var_0) {
  var_0 endon("death");
  var_0 notify("texthandler");
  var_0 endon("texthandler");
  var_1 = var_0 getentitynumber();

  for(;;) {
    if(getDvar("#x385a1810201b75220") == "") {
      level waittill("show_stealth_states");
    }

    if(isDefined(var_0._id_AF40) && isDefined(var_0._id_0B67._id_02D7)) {} else if(isDefined(var_0._id_AF40)) {}

    wait 0.05;
  }
}

_id_EE83(var_0) {
  self endon("stop_patrol_logic");
  self endon("death");
  self endon("alerted");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = var_1[randomint(var_1.size)];

  for(;;) {
    var_2 thread _id_D4E3(var_2, 20);
    _id_D57A(var_2.origin);
    var_2 thread _id_FA74(var_2);

    if(isDefined(var_2.target)) {
      var_1 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
      var_2 = var_1[randomint(var_1.size)];
      continue;
    }

    break;
  }
}

_id_E09D() {
  level endon("game_ended");

  if(!isDefined(level._id_15ED) || level._id_15ED.size < 1) {
    return;
  }
  var_0 = 12;
  level._id_56DC = [];
  var_1 = level._id_15ED;
  var_2 = [];
  var_3 = 9 / var_0;
  var_4 = 3 / var_0;
  var_5 = 5;

  for(;;) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      var_9 = 0;

      if(istrue(var_8._id_3D06) && isDefined(var_8._id_E6CB)) {
        var_10 = var_3 * 500;
        var_9 = var_10 * (var_8._id_3D06 / var_8._id_E6CB);
      }

      var_9 = clamp(var_9, 0, 500);
      var_8._id_AF4E = int(var_9);
      var_6++;

      if(var_6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

_id_110F1() {
  level endon("game_ended");

  if(!isDefined(level._id_1627) || level._id_1627.size < 1) {
    return;
  }
  var_0 = 12;
  level._id_56DC = [];
  var_1 = level._id_1627;
  var_2 = [];
  var_3 = 9 / var_0;
  var_4 = 3 / var_0;
  var_5 = 5;

  for(;;) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      var_9 = 0;

      if(istrue(var_8._id_3D06) && isDefined(var_8._id_E6CB)) {
        var_10 = var_3 * 500;
        var_9 = var_10 * (var_8._id_3D06 / var_8._id_E6CB);
      }

      var_9 = clamp(var_9, 0, 500);
      var_8._id_AF4E = int(var_9);
      var_6++;

      if(var_6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

_id_6D09(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = level._id_15ED;
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = scripts\engine\utility::_id_1BD1(var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = "soldier_agent";
  }

  var_4 = 25;
  var_5 = _id_06FE::_id_6882(var_3);
  var_6 = _func_0204(scripts\engine\utility::_id_1BBF(var_1, var_2), var_0.origin);
  var_7 = [];
  var_8 = scripts\engine\utility::_id_6369(var_0.origin, var_5, undefined, 4, 256).size >= 3;
  var_9 = 5 / var_4;
  var_10 = 20 / var_4;

  foreach(var_12 in var_6) {
    var_13 = var_12._id_AF4E;
    var_12._id_B02A = 0;
    var_14 = 250;

    if(var_8 && distance(var_0.origin, var_12.origin) <= 500) {
      var_14 = 500;
    } else {
      var_15 = scripts\engine\math::_id_645E(var_0.origin, anglesToForward(var_0.angles), var_12.origin);

      if(isDefined(var_12.target)) {
        var_16 = scripts\engine\utility::getStructArray(var_12.target, "targetname");

        if(var_16.size > 1) {
          var_17 = var_10 * 500;
          var_14 = var_14 - var_17;
        }

        var_18 = var_9 * 500;
        var_14 = var_18 * var_15;
      } else
        var_14 = 500 * var_15;
    }

    var_14 = clamp(var_14, 0, 500);
    var_14 = clamp(var_14 + var_13, 0, 999);
    var_12._id_B02A = int(var_14);
    var_7[var_7.size] = var_12;

    if(var_14 <= 50) {
      return var_12;
    }
  }

  var_20 = scripts\cp\utility::_id_1BD5(var_7, ::_id_6C28)[0];
  return var_20;
}

_id_6C28() {
  if(isDefined(self._id_B02A)) {
    return self._id_B02A;
  } else {
    return 999;
  }
}

_id_6C22() {
  if(isDefined(self._id_AF4E)) {
    return self._id_AF4E;
  } else {
    return 0;
  }
}

_id_D4E3(var_0, var_1) {
  level endon("game_ended");
  var_0 notify("setCooldown");
  var_0 endon("setCooldown");
  var_0 endon("unsetCooldown");
  var_2 = 0.5 * var_1;
  var_2 = clamp(var_2, 0.1, var_2);
  var_3 = gettime() + var_2 * 1000;
  var_4 = var_1 / 20;
  var_4 = clamp(var_4, 0.05, var_4);
  var_5 = 0;
  var_0._id_AF4E = 500;
  var_0._id_E6CB = var_1;

  while(gettime() < var_3) {
    var_0._id_3D06 = 20 - var_5;
    var_5++;
    wait(var_4);
  }
}

_id_FA74(var_0) {
  var_0 notify("unsetCooldown");
  var_0._id_3D06 = undefined;
  var_0._id_E6CB = undefined;
}

_id_10B4E(var_0) {
  self notify("watchForStalledPos");
  self endon("watchForStalledPos");
  self endon("death");
  self endon("alerted");
  self endon("goal");
  self endon("goal_reached");

  if(isDefined(var_0)) {
    self endon(var_0);
  }

  var_1 = self.origin;
  var_2 = 0;
  var_3 = 10;

  for(;;) {
    if(self.origin == var_1) {
      var_2++;
    }

    if(var_2 >= var_3) {
      break;
    }

    wait 0.25;
  }

  self notify("stalled");
}

_id_D57A(var_0, var_1, var_2) {
  self notify("setGoalAndTimeout");
  self endon("setGoalAndTimeout");
  self endon("death");
  self endon("alerted");

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_0)) {
    var_3 = _func_02AB(var_0);
    thread _id_10B4E(var_2);
    _id_0CEA(self, var_3, var_1);
  } else
    wait 0.25;
}

_id_0CEA(var_0, var_1, var_2) {
  var_0 notify("set_goal_pos_requested");
  var_0 endon("set_goal_pos_requested");
  var_0 endon("death");
  var_0 endon("stalled");

  if(isDefined(var_2)) {
    var_0._id_0201 = var_2;
  } else {
    var_0._id_0201 = 32;
  }

  var_3 = 0;

  foreach(var_5 in level._id_A3F5) {
    if(distance(var_5, var_1) <= var_0._id_0201) {
      var_3 = 1;
      break;
    }
  }

  var_7 = 1;

  if(var_3) {
    var_8 = _func_02AA(var_1, 50, 10, undefined, _func_02A9(var_1, 32), 25);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_7 = 0;

      foreach(var_5 in level._id_A3F5) {
        if(distance(var_5, var_11) <= 32) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1 = var_11;
        break;
      }
    }
  }

  thread _id_9A2A(var_0, var_1);
  var_0 _meth_84BC(0, var_1);
  var_15 = var_0 scripts\engine\utility::_id_10897("goal", "goal_reached");
}

_id_9A2A(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_A3F5[level._id_A3F5.size] = var_1;
    var_2 = var_0 scripts\engine\utility::_id_10892(["death", "set_goal_pos_requested", "alerted", "exit_stealth", "new_goal", "alerted_by_ai"]);

    if(scripts\engine\utility::array_contains(level._id_A3F5, var_1)) {
      level._id_A3F5 = scripts\engine\utility::array_remove(level._id_A3F5, var_1);
    }
  }
}

_id_AF0F(var_0, var_1) {
  self notify("patrol_path");
  self endon("patrol_path");
  self endon("death");
  self endon("alerted");
  self endon("stop_patrol_logic");

  if(!isDefined(level._id_15ED) || level._id_15ED.size < 1) {
    return;
  }
  if(isDefined(level._id_15ED) || level._id_15ED.size > 1) {
    var_2 = level._id_15ED;
    var_3 = scripts\engine\utility::array_combine([var_0], level._id_56DC);
    var_4 = scripts\engine\utility::_id_6369(var_0.origin, var_2, var_3, 10);

    if(var_4.size < 1) {
      var_2 = scripts\engine\utility::getStructArray(var_0._id_0481, "targetname");
      var_4 = scripts\engine\utility::_id_6369(var_0.origin, scripts\engine\utility::getStructArray(var_0._id_0481, "targetname"), var_3, 5);
    }

    var_5 = scripts\engine\utility::_id_6969(var_0.origin, var_4, 256);

    if(isDefined(var_5)) {
      var_6 = var_5;
    } else {
      var_6 = _id_6D09(self, var_4);
    }

    var_7 = var_6;
    var_3 = scripts\engine\utility::array_combine([var_6, var_7], level._id_56DC);

    for(;;) {
      var_6 thread _id_D4E3(var_6, 20);
      thread _id_C4D2(self, var_6);
      _id_D57A(var_6.origin);
      self._id_AB4B = undefined;
      _id_FA74(var_6);

      if(scripts\engine\utility::cointoss()) {
        wait(randomfloatrange(2.5, 5));
      }

      var_2 = level._id_15ED;

      if(istrue(var_1)) {
        break;
      }

      if(isDefined(var_6)) {
        var_7 = var_6;
      }

      var_3 = scripts\engine\utility::array_combine([var_7, var_6], level._id_56DC);
      var_4 = scripts\engine\utility::_id_6369(self.origin, var_2, var_3, 5);
      var_6 = _id_6D09(self, var_4, var_3);
    }
  } else {}
}

_id_C4D2(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("goal_reached");
  var_0 endon("goal");
  var_0 endon("stalled");
  var_0 endon("death");
  var_0 scripts\engine\utility::waittill_any_2("death", "alerted");
  _id_1166(0, var_1);
}

_id_1166(var_0, var_1) {
  if(istrue(var_0) && !scripts\engine\utility::array_contains(level._id_56DC, var_1)) {
    level._id_56DC = scripts\engine\utility::array_add(level._id_56DC, var_1);
  } else if(scripts\engine\utility::array_contains(level._id_56DC, var_1)) {
    level._id_56DC = scripts\engine\utility::array_remove(level._id_56DC, var_1);
  }
}

_id_10AF6() {
  self notify("watchForBulletWhizby");
  self endon("watchForBulletWhizby");
  level endon("game_ended");
  self endon("death");
  self endon("alerted");

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1, var_2, var_3);

    if(isPlayer(var_0)) {
      self notify("stop_patrol_logic");
      _id_D644("investigating_whizby", "cqb", 0, 1, 0, var_2);
      break;
    }
  }
}

_id_575F() {
  self notify("exit_patrol_mode");
  self endon("exit_patrol_mode");
  self endon("death");
  self endon("alerted");
  thread _id_10B62();
  thread _id_10AF6();
  thread _id_10B4B(self);
  thread _id_0768::_id_E006();

  for(;;) {
    var_0 = scripts\engine\utility::_id_1088C(self, "damage", self, "explode", self, "alerted_by_soldier", level, "large_explosion");

    if(!isDefined(var_0)) {
      continue;
    }
    if(istrue(self._id_BA45)) {
      if(var_0 != "damage") {
        break;
      } else
        continue;

      continue;
    }

    break;
  }

  var_1 = 2;
  var_2 = 1;
  var_3 = 1;
  var_4 = 0;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "alerted_by_soldier":
        _id_D644("alerted_by_soldier", "combat", 1, 0, 0, undefined);
        var_2 = 1;
        var_3 = 0;
        var_4 = 0;
        break;
      case "damage":
        _id_D644("damaged", "combat", 1, 0, 0, undefined, 1);
        self._id_42EC = 1;
        var_3 = 1;
        var_4 = 1;
        break;
    }
  }
}

_id_10B4B(var_0) {
  var_0 notify("watchForSoldierKilled");
  var_0 endon("watchForSoldierKilled");
  var_0 endon("death");
  var_0 endon("alerted");

  for(;;) {
    var_1 = 0;
    level waittill("ai_killed", var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_7 != var_0.team) {
      continue;
    }
    if(istrue(var_0._id_BA45)) {
      continue;
    }
    var_1 = isPlayer(var_5);
    var_8 = scripts\engine\math::_id_645E(var_0.origin, var_0 getplayerangles(1), var_2);

    if(var_8 >= 0.573576 && _func_0202(var_0 getEye(), var_2, 0, var_0, 1)) {
      var_0 _id_D644("witnessed_friendly_death", "sprint", 0, 1, 0, var_2, 0);
      break;
    }
  }
}

_id_D644(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    if(var_1 == "cqb") {
      scripts\common\utility::_id_47A7("cqb");
      var_1 = "combat";
    } else if(var_1 == "combat")
      scripts\common\utility::_id_47A7("combat");

    _id_06BD::_id_23F3(var_1);
  }

  self notify(var_0);
  self._id_AF40 = var_0;
  var_9 = istrue(self._id_24BF);

  if(istrue(var_6)) {
    thread _id_1437(undefined, undefined, 1, 1);
  }

  if(istrue(var_7)) {
    if(isDefined(self._id_E342.target)) {
      thread _id_EE83(self._id_E342);
    } else {
      thread _id_0D86(self);
    }
  } else if(istrue(var_4))
    thread _id_142D(self);
  else if(istrue(var_3)) {
    if(isDefined(var_5)) {
      thread _id_E004(self, var_5);
    } else {
      var_10 = scripts\cp\utility::_id_63E3();

      if(isDefined(var_10)) {
        thread _id_E004(self, var_10.origin);
      } else {
        thread _id_E004(self, _func_02A9(self.origin, 256));
      }
    }
  } else if(istrue(var_2))
    thread _id_5494();
}

_id_1437(var_0, var_1, var_2, var_3) {
  self notify("alertNearbyEnemiesAfterDelay");
  self endon("alertNearbyEnemiesAfterDelay");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  wait(var_1);
  thread _id_1423(var_0, var_2, undefined, var_3);
}

_id_10B62() {
  level endon("game_ended");
  self notify("watchForWeaponFire");
  self endon("watchForWeaponFire");
  self endon("alerted");
  self endon("death");
  var_0 = 1500;

  for(;;) {
    level waittill("weapon_fired", var_1, var_2, var_3);

    if(istrue(self._id_BA45)) {
      continue;
    }
    if(isagent(var_3) && var_3.team == self.team) {
      continue;
    }
    var_0 = 1500;

    if(isPlayer(var_3)) {
      var_0 = var_0 * var_3._id_AFAA["stealth_weapon_noise_scalar"];
    }

    var_4 = 0;

    foreach(var_6 in var_2._id_0070) {
      if(issubstr(var_6, "silencer")) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      continue;
    }
    if(istrue(self._id_42EC)) {
      var_0 = int(var_0 * 1.5);
    }

    if(distance(var_1, self.origin) > var_0) {
      continue;
    } else {
      _id_D644("investigating_weapon_fire", "sprint", 0, 1, 0, var_1, 0);
      break;
    }
  }
}

_id_31AA(var_0, var_1) {
  var_2 = var_0 _meth_847B(var_0.origin, var_1, 0, 0);

  if(var_2.size >= 1 && distance(var_2[var_2.size - 1], var_1) <= 64) {
    return 1;
  } else {
    return 0;
  }
}

_id_1438(var_0) {
  var_0 notify("alertNearbyLoop");
  var_0 endon("alertNearbyLoop");
  var_0 endon("death");
  var_0 endon("patrol_values_set");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_10896("shooting");
    var_0 thread _id_1437();

    if(var_1 == "shooting") {
      wait 0.5;
    }
  }
}

_id_5494() {
  self notify("alerted");
  self notify("enter_combat");
  self._id_0201 = 64;
  self._id_A546 = undefined;
  self._id_0229 = 0;
  self._id_CF4A = 0;
  self._id_54CF = 1;
  scripts\common\utility::_id_47A7("frantic");
  thread _id_6479(5);
}

_id_6479(var_0) {
  level endon("game_ended");
  self notify("get_enemy_info_loop");
  self endon("get_enemy_info_loop");
  self endon("death");
  var_1 = _id_63CF();

  if(!isDefined(var_1)) {
    level notify("no_target_player_found");
    return;
  } else {
    self _meth_807A();
    self _meth_812E(var_1);
    self._id_01BD = var_1;

    if(!isDefined(var_1._id_53C1)) {
      var_1._id_53C1 = [];
    }

    if(!isDefined(self._id_EE6F) || self._id_EE6F != var_1) {
      self notify("changed_target");
      thread scripts\engine\utility::_id_F126("changed_target", ::_id_38CC, var_1);
      thread scripts\engine\utility::_id_F126("death", ::_id_38CC, var_1);

      if(!scripts\engine\utility::array_contains(var_1._id_53C1, self)) {
        var_1._id_53C1[var_1._id_53C1.size] = self;
      }
    }

    self._id_EE6F = var_1;
  }

  if(isDefined(self._id_CD76)) {
    self _meth_8328(self._id_CD76);
  }
}

_id_A271(var_0) {
  self _meth_84BE(1, var_0);
  self _meth_8600(1, self._id_0201);
  self _meth_85FF(1, self._id_01FE);
  self _meth_84BC(0, var_0.origin);
  self._id_A272 = gettime();
  self._id_A271 = var_0;
  thread _id_3926();
}

_id_3926() {
  self endon("death");
  self notify("ClearBTGoalArrival_reset");
  self endon("ClearBTGoalArrival_reset");
  self waittill("goal_reached");
  self _meth_84C0(1);
}

_id_63CF() {
  var_0 = _func_0204(level.players, self.origin);

  foreach(var_2 in var_0) {
    if(var_2 scripts\cp\utility::_id_8708()) {
      if(!isDefined(var_2._id_7BCF) || var_2._id_7BCF.size < 3) {
        return var_2;
      }

      if(!isDefined(var_2._id_53C1) || var_2._id_53C1.size < int(24 / level.players.size)) {
        return var_2;
      }
    }
  }

  if(isDefined(self._id_0192)) {
    return self._id_0192;
  } else {
    return undefined;
  }
}

_id_38CC(var_0) {
  if(isDefined(var_0)) {
    var_0._id_53C1 = scripts\engine\utility::array_remove(var_0._id_53C1, self);
  }
}

_id_38DC(var_0) {
  if(isDefined(var_0)) {
    var_0._id_7BCF = scripts\engine\utility::array_remove(var_0._id_7BCF, self);
  }
}

_id_38F7(var_0) {
  if(isDefined(var_0)) {
    var_0._id_7BCF = scripts\engine\utility::array_remove(var_0._id_7BCF, self);
  }
}

_id_7BBC() {
  self endon("death");
  var_0 = randomintrange(25, 60);
  var_1 = randomintrange(10, 15);
  _id_7BBB(var_0, var_1);
}

_id_E004(var_0, var_1) {
  level endon("game_ended");
  var_0 notify("soldier_investigate");
  var_0 endon("soldier_investigate");
  var_0 endon("alerted");
  var_0 endon("death");
  var_0 _id_D57A(var_1);

  if(var_0 _id_0768::_id_F602(2.6, undefined, "investigate")) {
    wait 5;

    foreach(var_3 in _id_06FE::_id_6882("soldier_agent")) {
      var_3 thread _id_D469(var_3);
    }
  }

  wait 5;
  var_0 thread _id_D469(var_0);
}

_id_142D(var_0) {
  var_0 notify("stop_patrol_logic");
  var_0 notify("alerted_hunt_mode");
  var_0 endon("alerted_hunt_mode");
  var_0 endon("hunt_player");
  var_0 endon("death");
  var_0 endon("patrol_values_set");
  var_0 endon("alerted");
  var_0._id_E00B = undefined;
  var_0._id_142F = undefined;
  var_0._id_142D = 1;
  var_0._id_A50F = 1;

  for(;;) {
    if(istrue(var_0._id_24BF)) {
      var_1 = _func_00B5(var_0.origin, 512, 0, 24, "Cover");
      var_0 _id_D57A(var_1[0].origin);
      continue;
    }

    var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_0 scripts\cp\utility::_id_63E3(), var_0);

    if(!isDefined(var_2)) {
      var_2 = var_0;
    }

    var_3 = _func_02A9(var_2.origin, 1024);

    if(isDefined(var_3)) {
      var_0 _id_D57A(var_3);
    } else {
      var_3 = _func_02A9(var_0.origin, 256);
      var_0 _id_D57A(var_3);
    }
  }
}

_id_7BBB(var_0, var_1) {
  level endon("game_ended");
  self notify("hunt_player");
  self endon("hunt_player");
  self endon("death");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  while(!_id_DAAA()) {
    wait 1;
  }

  self._id_7BDD = 1;
  self._id_A50F = 1;

  for(;;) {
    var_2 = scripts\cp\utility::_id_63E3();

    if(isalive(var_2)) {
      self _meth_812E(var_2);
      self _meth_8323(var_2, 3);
    }

    wait 3;
  }
}

_id_DAAA() {
  var_0 = 0;
  var_1 = _id_06FE::_id_68A1("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_7BDD)) {
      var_0++;
    }
  }

  if(var_0 > level.players.size * 2) {
    return 0;
  } else {
    return 1;
  }
}

_id_C175(var_0) {
  self notify("reduce_goalradius_over_time");
  self endon("reduce_goalradius_over_time");
  self endon("death");
  self endon("patrol_values_set");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  for(;;) {
    var_1 = self._id_0201 - 100;

    if(self._id_0201 < 250) {
      self._id_0201 = 250;
    } else {
      self._id_0201 = var_1;
    }

    wait(var_0);
  }
}

_id_D8ED(var_0) {
  var_0 notify("setWeaponsFree");
  var_0 endon("setWeaponsFree");
  var_0 endon("death");
  level endon("clearWeaponsFree");
  level endon("game_ended");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_108A8(5, "shooting", "spotted_player");

    if(isDefined(var_1)) {
      if(var_1 != "timeout") {
        continue;
      } else {
        var_0 thread _id_D469(var_0);
        return;
      }
    }
  }
}

_id_F2E7(var_0) {
  if(istrue(var_0)) {
    scripts\engine\utility::_id_5C1B("weapons_free");
  } else {
    scripts\engine\utility::_id_5C04("weapons_free");
  }
}

_id_3997() {
  level notify("clearWeaponsFree");

  foreach(var_1 in _id_06FE::_id_6882("soldier_agent")) {
    var_1 thread _id_D469(var_1);
  }
}

_id_D469(var_0) {
  var_0 _id_D1BC();

  if(getdvarint("#x3c894dfd14e8c530a") == 1) {
    var_0 _id_D644("alerted_hunt_mode", "cqb", 0, 0, 1, undefined, 0);
  } else {
    var_0 _id_D644("spotted_player", "combat", 1, 0, 0, undefined, 1);
  }
}

_id_0D86(var_0) {
  var_0 _id_D1BC();
  var_0 thread _id_AF0F(var_0._id_E342, istrue(var_0._id_BA45));
}

_id_E006() {
  level endon("game_ended");
  self notify("soldier_player_listener");
  self endon("soldier_player_listener");
  self endon("alerted");
  self endon("death");
  var_0 = ["dx_otn_usm1_exposed", "dx_otn_usm1_exposed_breaking", "dx_otn_usm1_exposed_open", "dx_otn_usm1_exposed_movement", "dx_otn_usm1_exposed_acquired"];

  for(;;) {
    foreach(var_2 in level.players) {
      if(_id_8996(self, var_2)) {
        if(isDefined(level._id_8F4C) && gettime() >= level._id_8F4C + 5000) {
          level._id_8F4C = gettime();
          scripts\cp\utility::_id_B8ED(self.origin, scripts\engine\utility::random(var_0));
        }

        _id_D644("spotted_player", "combat", 1, 0, 0, undefined, 1);
        return;
      }
    }

    wait 0.1;
  }
}

_id_8996(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(istrue(var_1.ignoreme)) {
    return 0;
  }

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0._id_42EC);

  if(var_3 < 96) {
    if(vectordot(anglesToForward(var_0.angles), vectornormalize(var_1.origin - var_0.origin)) > 0) {
      return 1;
    }
  }

  var_5 = 1;
  var_6 = var_1 getvelocity();
  var_7 = length(var_6);

  if(var_7 < 128) {
    var_5 = 0.75;
  } else if(var_7 < 200 || var_2 && var_1._id_AFAA["stealth_velocity_override"]) {
    var_5 = 1;
  } else {
    var_5 = 1.25;
  }

  if(var_3 > 1500 * var_5) {
    return 0;
  }

  var_8 = var_0 _meth_8067(var_1);

  if(var_8) {
    var_9 = cos(75);
    var_10 = scripts\engine\utility::_id_10E76(var_0 getEye(), var_0 getplayerangles(1), var_1.origin + (0, 0, 40), var_9);

    if(!var_10) {
      return 0;
    }

    var_11 = _func_0202(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

    if(!var_11) {
      return 0;
    }

    var_12 = scripts\engine\trace::_id_3F70(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_12)) {
      return 0;
    }

    var_13 = scripts\engine\math::_id_645E(var_0.origin, anglesToForward(var_0.angles), var_1.origin);
    var_5 = 1;

    if(var_13 >= 0.573576) {
      var_5 = var_5 - 0.34;
    }

    if(var_4) {
      var_5 = var_5 - 0.34;
    }

    var_14 = var_1 getstance();

    if(var_3 <= int(350 / var_5)) {
      if(var_14 == "prone") {
        return 0;
      }

      return 1;
    } else if(var_3 <= int(500 / var_5)) {
      if(var_14 == "prone") {
        return 0;
      }

      return 1;
    } else if(var_3 <= int(950 / var_5)) {
      if(var_14 == "prone" || var_14 == "crouch") {
        return 0;
      }

      return 1;
    }
  }

  return 0;
}

_id_1423(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::_id_5C0C("weapons_free") && !scripts\engine\utility::_id_5C00("weapons_free")) {
    _id_F2E7(1);
  }

  var_4 = _id_06FE::_id_6884("allies");
  var_3 = istrue(var_3);

  foreach(var_6 in var_4) {
    if(!isDefined(var_6) || var_6 == self) {
      continue;
    }
    if(!isDefined(var_6._id_1210) || isDefined(var_6._id_1210) && var_6._id_1210 != "soldier_agent") {
      continue;
    }
    if(!var_3 && isDefined(var_0) && distance2dsquared(self.origin, var_6.origin) > var_0) {
      continue;
    }
    if(!istrue(var_6._id_CF4A)) {
      continue;
    }
    if(var_6.team != self.team) {
      continue;
    }
    if(!istrue(var_2) && istrue(var_6._id_BA45)) {
      continue;
    }
    var_6 notify("alerted_by_soldier");
  }
}

_id_4470() {
  if(!scripts\engine\utility::_id_5C0C("patrolPoints_initialized")) {
    return;
  }
  scripts\engine\utility::_id_5C24("patrolPoints_initialized");

  for(;;) {
    var_0 = getdvarint("#x3673617c93cca63ee", 0);
    var_1 = getdvarint("#x3961f1e556f71051c", 0);

    if(var_0 != 0 && isDefined(level.players[0])) {
      var_2 = [];

      if(var_0 == 1) {
        var_2 = level._id_1627;
      } else if(var_0 == 2) {
        var_2 = level._id_15ED;
      }

      var_3 = _func_0204(var_2, level.players[0].origin);
      var_4 = 0;

      foreach(var_6 in var_3) {
        if(var_1 > 0) {
          if(var_6._id_7C8C != var_1) {
            continue;
          }
        }

        if(isDefined(var_6._id_AF4E)) {
          if(isDefined(var_6.target)) {
            var_7 = scripts\engine\utility::getStructArray(var_6.target, "targetname");

            if(var_7.size >= 1) {
              foreach(var_9 in var_7) {
                thread scripts\engine\utility::_id_4F13(var_6.origin, var_9.origin, 1, 0, 0, 0.1);
              }
            } else
              thread scripts\engine\utility::_id_4F13(var_6.origin, var_6.origin + (0, 0, 128), 1, 1, 0, 0.1);
          }

          level thread _id_446F(var_6, 0.1);
          var_4++;
        }

        if(var_4 >= 30) {
          break;
        }
      }
    }

    wait 0.1;
  }
}

_id_446F(var_0, var_1) {
  var_2 = 0;
  var_3 = 125;
  var_4 = 300;
  var_5 = 500;
  var_6 = var_0._id_AF4E;

  if(var_6 <= 0) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (1, 1, 1));
  } else if(var_6 <= var_3) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (0, 1, 0));
  } else if(var_6 <= var_4) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (1, 1, 0));
  } else {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (1, 0, 0));
  }
}