/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2548.gsc
*************************************************/

_id_2823() {
  if(!isDefined(level._id_8DAA)) {
    if(!isDefined(level._id_8DAA)) {
      level._id_8DAA = [];
    }

    if(!isDefined(level._id_8DA9)) {
      level._id_8DA9 = [];
    }

    if(!isDefined(level._id_8DAB)) {
      level._id_8DAB = [];
    }

    if(!isDefined(level._id_28EF)) {
      level._id_28EF = [];
    }

    if(istrue(game["isLaunchChunk"])) {
      return;
    }
    if(isDefined(level._id_9AB3)) {
      [[level._id_9AB3]]();
    }
  }
}

_id_28A5(var_0, var_1, var_2, var_3) {
  level._id_8DAA[var_0] = var_1;
  level._id_8DA9[var_0] = var_2;
  level._id_8DAB[var_0] = var_3;
  level._id_28EF[level._id_28EF.size] = var_0;
}

_id_2826(var_0, var_1, var_2) {
  if(_id_281E(var_0, "bots", undefined, var_1)) {
    return 1;
  } else if(var_2) {}

  return 0;
}

_id_281E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(var_0 == "specialist") {
    return 1;
  }

  if(!_id_281F(var_0, var_1)) {
    return 0;
  }

  if(isDefined(var_3)) {
    var_4 = _func_00D6(var_3, 11);

    switch (var_4) {
      case "assault":
        if(!scripts\mp\utility\killstreak::_id_8769(var_0)) {
          return 0;
        }

        break;
      case "support":
        if(!scripts\mp\utility\killstreak::_id_8A81(var_0)) {
          return 0;
        }

        break;
      case "specialist":
        if(!scripts\mp\utility\killstreak::_id_8A52(var_0)) {
          return 0;
        }

        break;
    }
  }

  return 1;
}

_id_281F(var_0, var_1) {
  if(var_1 == "humans") {
    return isDefined(level._id_8DE6[var_0]) && scripts\mp\utility\killstreak::_id_6AE3(var_0) != -1;
  } else if(var_1 == "bots") {
    return isDefined(level._id_8DAA[var_0]);
  }
}

_id_2922() {
  self notify("bot_watch_for_killstreak_use");
  self endon("bot_watch_for_killstreak_use");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("killstreak_use_finished");
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
  }
}

_id_2809(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(level._id_8DAA[var_0])) {
    return 0;
  }

  return 1;
}

_id_2725(var_0) {
  var_1 = level._id_8DA9[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  if(isDefined(var_1) && !self[[var_1]]()) {
    return 0;
  }

  return 1;
}

_id_28FD() {}

_id_2720() {
  return 0;
}

_id_28EC() {}

_id_2820() {}

_id_2721() {
  return 0;
}

_id_11DF() {
  if(scripts\mp\utility\game::_id_873C()) {
    return 0;
  }

  if(_id_102E9()) {
    return 0;
  }

  return 1;
}

_id_102E9() {
  return scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level._id_59E1 + 1 >= scripts\mp\utility\killstreak::maxvehiclesallowed();
}

_id_2724() {
  if(isDefined(level._id_51BA)) {
    return 0;
  }

  var_0 = scripts\mp\utility\teams::_id_6A01(self.owner.team);

  foreach(var_2 in var_0) {
    if(isDefined(level._id_EF6D) && !istrue(level._id_EF6D[var_2])) {
      return 1;
    }
  }

  return 0;
}

_id_2722() {
  return 0;
}

_id_2825(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::_id_26FC()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    return 0;
  }

  _id_28F0(var_0, var_1, var_0._id_04F6);
  return 1;
}

_id_2816(var_0, var_1, var_2, var_3) {
  _id_2815(var_0, var_1, var_2, var_3, "anywhere");
}

_id_2818(var_0, var_1, var_2, var_3) {
  _id_2815(var_0, var_1, var_2, var_3, "outside");
}

_id_2817(var_0, var_1, var_2, var_3) {
  _id_2815(var_0, var_1, var_2, var_3, "hidden");
}

_id_2815(var_0, var_1, var_2, var_3, var_4) {
  wait(randomintrange(2, 4));

  if(!isDefined(var_4)) {
    var_4 = "anywhere";
  }

  if(!scripts\mp\bots\bots_util::_id_26FC()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    return 0;
  }

  var_5 = self getweaponammoclip(var_0._id_04F6) + self getweaponammostock(var_0._id_04F6);

  if(var_5 == 0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.streakname) && var_7.streakname == var_0.streakname) {
        var_7._id_1F84 = 0;
      }
    }

    return 1;
  }

  var_9 = undefined;

  if(var_4 == "outside") {
    var_10 = [];
    var_11 = scripts\mp\bots\bots_util::_id_27CA(0, 750, 0.6, 1);

    foreach(var_13 in var_11) {
      if(_func_0157(var_13)) {
        var_10 = scripts\engine\utility::array_add(var_10, var_13);
      }
    }

    if(var_11.size > 5 && var_10.size > var_11.size * 0.6) {
      var_15 = scripts\engine\utility::_id_6369(self.origin, var_10, undefined, undefined, undefined, 150);

      if(var_15.size > 0) {
        var_9 = scripts\engine\utility::random(var_15);
      } else {
        var_9 = scripts\engine\utility::random(var_10);
      }
    }
  } else if(var_4 == "hidden") {
    var_16 = _func_00B4(self.origin, 256, 0, 40);
    var_17 = self _meth_815E();

    if(isDefined(var_17)) {
      var_18 = [];

      foreach(var_13 in var_16) {
        if(_func_0158(var_17, var_13, 1)) {
          var_18 = scripts\engine\utility::array_add(var_18, var_13);
        }
      }

      var_9 = self _meth_8049(var_18, 1, "node_hide");
    }
  }

  if(isDefined(var_9) || var_4 == "anywhere") {
    self _meth_8054("disable_movement", 1);

    if(isDefined(var_9)) {
      self _meth_8045(var_9.origin, 2.45, "script_forced");
    }

    _id_28F0(var_0, var_1, var_0._id_04F6);
    wait 2.0;
    self _meth_804E("attack");
    wait 1.5;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
    self _meth_8054("disable_movement", 0);
  }

  return 1;
}

_id_28F0(var_0, var_1, var_2) {
  _id_2865(var_0, var_1);
}

_id_2865(var_0, var_1) {
  if(isDefined(var_0._id_887C) && var_0._id_887C) {
    self notify("ks_action_6");
    return;
  }

  for(var_2 = 1; var_2 < 4; var_2++) {
    if(isDefined(var_1[var_2])) {
      if(isDefined(var_1[var_2].streakname)) {
        if(var_1[var_2].streakname == var_0.streakname) {
          var_3 = var_2 + 2;
          self notify("ks_action_" + var_3);
          return;
        }
      }
    }
  }
}

_id_2814(var_0, var_1, var_2, var_3) {
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::_id_26FC()) {
    return;
  }
  var_4 = _func_00F5(self.origin);

  if(!isDefined(var_4)) {
    return;
  }
  self _meth_8054("disable_movement", 1);
  _id_28F0(var_0, var_1, var_0._id_04F6);
  wait 2;
  var_5 = level._id_110E1;
  var_6 = -1;
  var_7 = 0;
  var_8 = [];
  var_9 = randomfloat(100) > 50;

  for(var_10 = 0; var_10 < var_5; var_10++) {
    if(var_9) {
      var_11 = var_5 - 1 - var_10;
    } else {
      var_11 = var_10;
    }

    if(var_11 != var_4 && _func_002A(var_11) < 0.25) {
      var_12 = _func_0029(var_11, self.team, "enemy_predict");

      if(var_12 > var_7) {
        var_6 = var_11;
        var_7 = var_12;
      }

      var_8 = scripts\engine\utility::array_add(var_8, var_11);
    }
  }

  if(var_6 >= 0) {
    var_13 = _func_00F9(var_6);
  } else if(var_8.size > 0) {
    var_13 = _func_00F9(scripts\engine\utility::random(var_8));
  } else {
    var_13 = _func_00F9(randomint(level._id_110E1));
  }

  var_14 = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("confirm_location", var_13 + var_14, randomintrange(0, 360));
  wait 1.0;
  self _meth_8054("disable_movement", 0);
}

_id_2903() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(level._id_8F22)) {
    level._id_8F22 = -10000;
  }

  level._id_8DB3["allies"] = [];
  level._id_8DB3["axis"] = [];
  var_0 = 0;
  var_1 = randomfloatrange(0.05, 4.0);

  for(;;) {
    wait(var_1);
    var_1 = randomfloatrange(0.05, 4.0);

    if(scripts\mp\bots\bots_util::_id_280F()) {
      continue;
    }
    if(self _meth_8030("strategyLevel") == 0) {
      continue;
    }
    var_2 = 0;

    if(isDefined(level._id_3643) && level._id_3643.team != self.team) {
      var_2 = 1;
    }

    if(isDefined(level._id_912B) && level._id_912B.team != self.team) {
      var_2 = 1;
    }

    if(_id_53D1(self.team)) {
      var_2 = 1;
      _id_F719("mortar_strike", ::_id_53D1);
    }

    if(_id_53EE(self.team)) {
      var_2 = 1;
      _id_F719("switchblade", ::_id_53EE);
    }

    if(_id_53D6(self.team)) {
      var_2 = 1;
      _id_F719("odin_assault", ::_id_53D6);
    }

    var_3 = _id_6480();

    if(isDefined(var_3)) {
      var_4 = self getEye();

      if(scripts\engine\utility::_id_10E76(var_4, self getplayerangles(), var_3._id_1DCB.origin, self _meth_8032())) {
        if(_func_0202(var_4, var_3._id_1DCB.origin, 0, self, var_3._id_1DCB)) {
          _func_0018("vanguard_" + var_3 getentitynumber(), var_1 + 0.5, var_3._id_1DCB.origin, 200, 100, self.team);
        }
      }
    }

    if(!var_0 && var_2) {
      var_0 = 1;
      self _meth_8054("hide_indoors", 1);
    }

    if(var_0 && !var_2) {
      var_0 = 0;
      self _meth_8054("hide_indoors", 0);
    }
  }
}

_id_F719(var_0, var_1) {
  if(!isDefined(level._id_8DB3[self.team][var_0])) {
    level._id_8DB3[self.team][var_0] = 0;
  }

  if(!level._id_8DB3[self.team][var_0]) {
    level._id_8DB3[self.team][var_0] = 1;
    level thread _id_A0CC(self.team, var_0, var_1);
  }
}

_id_A0CC(var_0, var_1, var_2) {
  var_3 = 0.5;

  while([[var_2]](var_0)) {
    if(gettime() > level._id_8F22 + 4000) {
      _func_001A("", 5.0, var_0, "only_sky");
      level._id_8F22 = gettime();
    }

    wait(var_3);
  }

  level._id_8DB3[var_0][var_1] = 0;
}

_id_53D1(var_0) {
  if(isDefined(level._id_1364) && level._id_1364) {
    if(var_0 != level._id_1365) {
      return 1;
    }
  }

  return 0;
}

_id_53EE(var_0) {
  if(isDefined(level._id_C341)) {
    foreach(var_2 in level._id_C8B8) {
      if(isDefined(var_2.type) && var_2.type == "remote" && var_2.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_53D6(var_0) {
  foreach(var_2 in level.players) {
    if(!level.teambased || isDefined(var_2.team) && var_0 != var_2.team) {
      if(isDefined(var_2._id_A92A) && var_2._id_A92A._id_A93D == "odin_assault" && gettime() - var_2._id_A92A._id_0094 > 3000) {
        return 1;
      }
    }
  }

  return 0;
}

_id_6480() {
  foreach(var_1 in level.players) {
    if(!level.teambased || isDefined(var_1.team) && self.team != var_1.team) {
      if(isDefined(var_1._id_C344) && var_1._id_C344._id_77E7 == "remote_uav") {
        return var_1._id_C344;
      }
    }
  }

  return undefined;
}

_id_88EC(var_0) {
  return isDefined(level._id_292C) && isDefined(level._id_292C[var_0]) && level._id_292C[var_0];
}

_id_259A(var_0) {
  level._id_292C[var_0] = 1;
}