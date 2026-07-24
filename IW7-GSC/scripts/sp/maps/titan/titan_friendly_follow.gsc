/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_friendly_follow.gsc
***********************************************************/

_id_8E45() {
  setdvarifuninitialized("allies_use_stealth_system", 1);
  level._id_C47F.goalradius = 120;
  level._id_C47F thread _id_73B8(120, 70, 0.75);
  level._id_2429.goalradius = 60;
  level._id_2429 thread _id_73B8(250, 100);
  level._id_CB99 = level._id_8E42;
  level thread _id_B7D2(level._id_8E42);
  level thread _id_73B2(level._id_8E42);
}

_id_8E38() {
  setdvarifuninitialized("friendly_follow_debug", 0);
  _id_0F27::_id_F5B4("hidden", ::_id_73F4);
  _id_0F27::_id_F5B4("spotted", ::_id_73F6);
}

_id_57A6() {}

_id_73B8(var_0, var_1, var_2) {
  setdvarifuninitialized("friendly_follow_debug", 0);
  self endon("stop_friendly_follow");
  self endon("death");
  self._id_73B7 = 1;
  self.fixednode = 0;
  self._id_73B5 = undefined;
  self._id_4B59 = undefined;

  if(!scripts\sp\utility::_id_65DF("override_follow_mode")) {
    scripts\sp\utility::_id_65E0("override_follow_mode");
  }

  if(!scripts\sp\utility::_id_65DF("override_follow_colors")) {
    scripts\sp\utility::_id_65E0("override_follow_colors");
  }

  scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_54F7();
  var_3 = squared(200);
  wait(randomfloatrange(0.25, 1.5));

  for(;;) {
    if(scripts\sp\utility::_id_65DB("override_follow_mode") || isDefined(self._id_11707)) {
      wait 0.1;
      continue;
    }

    var_4 = _id_7D3D(var_0, var_1);

    if(!isDefined(var_4)) {
      wait 0.1;
      continue;
    }

    thread _id_196F(var_4, var_2);
    thread _id_73AF(level.player.origin, var_4, [0, 0, 1]);

    while(distancesquared(level.player.origin, var_4) < var_3 && !scripts\sp\utility::_id_65DB("override_follow_mode") && !isDefined(self._id_11707)) {
      thread _id_73B4("waiting for player to move");
      wait 0.05;
    }

    wait 0.15;
  }
}

_id_B7D2(var_0) {
  level endon("stop_friendly_follow_mode");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_B7D2)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    }
  }

  if(!var_0.size) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2._id_B7D2 = 1;
  }

  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_51E1, "combat");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_65E0, "pause_mirror_player_speed");

  for(;;) {
    level.player.speed = length(level.player getvelocity());

    foreach(var_2 in var_0) {
      var_7 = 0;
      var_8 = distance2dsquared(var_2.origin, level.player.origin);

      if(var_8 >= 160000) {
        var_7 = 1;
      }

      if(level.player.speed > 235 || var_7) {
        var_2 _id_51E2("sprint");
        continue;
      }

      if(level.player.speed > 80) {
        var_2 _id_51E2("combat");
        continue;
      }

      var_2 _id_51E2("cqb");
    }

    wait 0.15;
  }
}

_id_51E2(var_0) {
  if(scripts\sp\utility::_id_65DB("pause_mirror_player_speed")) {
    return;
  }
  if(isDefined(self.demeanoroverride) && self.demeanoroverride == var_0) {
    return;
  }
  self notify("new_demeanor");
  scripts\sp\utility::_id_4145();
  scripts\sp\utility::_id_51E1(var_0);
}

_id_196F(var_0, var_1) {
  if(isDefined(self._id_11707)) {
    return;
  }
  self notify("new dynamic goal set");
  self endon("new dynamic goal set");
  self endon("override_follow_mode");
  self allowedstances("stand", "crouch", "prone");
  var_2 = squared(200);

  if(distancesquared(self.origin, var_0) < var_2) {
    return;
  }
  if(isDefined(var_1)) {
    wait(var_1);
  }

  self setgoalpos(var_0);
  self._id_73B5 = var_0;
  self waittill("goal");
  var_3 = self _meth_80E3();

  if(isDefined(var_3)) {
    if(isDefined(self.node) && var_3 == self.node) {
      return var_3;
    } else {
      self _meth_82EE(var_3);
      return var_3;
    }
  } else {
    var_4 = 5;
    var_5 = 250;

    for(var_6 = 0; var_6 < var_4; var_6++) {
      var_3 = self _meth_80E5(var_5);

      if(!isDefined(var_3)) {
        var_5 = var_5 + 75;
        continue;
      }

      if(isDefined(self.node) && var_3 == self.node) {
        return var_3;
      } else {
        self _meth_82EE(var_3);
        return var_3;
      }
    }

    self allowedstances("crouch");
    self orientmode("face angle", level.player.angles[1]);
  }
}

_id_73B2(var_0) {
  var_1 = getEntArray("trigger_multiple", "classname");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_ED33)) {
      var_2[var_2.size] = var_4;
    }
  }

  scripts\engine\utility::array_thread(var_2, ::_id_43A1, var_0);
}

_id_43A1(var_0) {
  level endon("stop_friendly_follow_mode");

  for(;;) {
    self waittill("trigger");
    scripts\engine\utility::array_thread(var_0, ::_id_439D, self);

    while(level.player istouching(self)) {
      wait 0.05;
    }

    scripts\engine\utility::array_thread(var_0, ::_id_7222, self);
  }
}

_id_439D(var_0) {
  if(isDefined(self._id_4B59) && self._id_4B59 == var_0) {
    return;
  }
  if(!isDefined(self._id_73B7)) {
    return;
  }
  if(scripts\sp\utility::_id_65DB("override_follow_colors")) {
    return;
  }
  self._id_4B59 = var_0;
  scripts\sp\utility::_id_65E1("override_follow_mode");
  self allowedstances("stand", "crouch", "prone");
  scripts\sp\utility::_id_61C7();
}

_id_7222(var_0) {
  if(!isDefined(self._id_73B7)) {
    return;
  }
  if(isDefined(self._id_4B59) && self._id_4B59 != var_0) {
    return;
  }
  if(scripts\sp\utility::_id_65DB("override_follow_colors")) {
    return;
  }
  scripts\sp\utility::_id_65DD("override_follow_mode");
  scripts\sp\utility::_id_54F7();
  self._id_4B59 = undefined;
}

_id_7D3D(var_0, var_1) {
  var_2 = [];
  var_3 = level.player scripts\sp\maps\titan\titan_code::_id_79D9(var_0, level.player.angles);
  var_4 = scripts\sp\maps\titan\titan_code::_id_7C16(var_3, var_1);
  var_5 = scripts\sp\maps\titan\titan_code::_id_7C16(var_3, var_1, 1);
  var_2[0] = var_4;
  var_2[1] = var_5;

  foreach(var_7 in var_2) {
    if(_id_9C68(var_7)) {
      return var_7;
    } else {
      _id_73B3("!", var_7);
    }
  }

  return undefined;
}

_id_9C68(var_0) {
  var_1 = getdvarint("friendly_follow_debug");

  if(level.player scripts\sp\maps\titan\titan_code::_id_10A5C(var_0)) {
    return 0;
  }

  var_2 = scripts\common\trace::create_default_contents();
  var_3 = [];
  var_4 = 35.0;
  var_5 = physics_getclosestpointtocapsule(var_0 + (0, 0, var_4), 17.0, var_4, (0, 0, 0), 0.0, var_2, var_3, "physicsquery_all");

  if(var_5.size) {
    if(isDefined(var_5[0]["distance"])) {
      if(var_5[0]["distance"] < -2) {
        return 0;
      } else {
        return 1;
      }
    }
  } else
    return 1;

  return 1;
}

_id_73F4() {
  var_0 = "stealth_spotted";
  level endon(var_0);
  self endon("stop_friendly_follow_stealth_logic");
  self._id_73F4 = 1;
  self.grenadeammo = 0;
  self.ignoreme = 1;
  self.ignoreall = 0;
  self._id_10E6D._id_931F = 1;
  self.maxvisibledist = 130;
  self.maxsightdistsqrd = squared(230);
  self.pathenemyfightdist = 200;
  self.dontevershoot = 1;
  var_1 = 1.5;

  if(isDefined(self._id_E45C)) {
    _id_10FD8();
    self.target = self._id_E45C.targetname;
    thread scripts\sp\maps\titan\titan_stealth_street::_id_8E2B();
    self._id_E45C = undefined;
  }

  for(;;) {
    if(!isDefined(self.enemy)) {
      wait 0.05;
      continue;
    }

    var_2 = self.enemy;

    if(_id_73E4(var_2)) {
      if(!scripts\engine\utility::flag(var_0)) {
        wait(var_1);
      }

      _id_73DE(var_2);
    }

    wait 0.05;
  }
}

_id_73F6() {
  if(!scripts\engine\utility::flag("buddy_door_room_entered")) {
    var_0 = undefined;

    if(isDefined(self._id_A906)) {
      var_0 = self._id_A906;
    } else if(isDefined(self._id_A905)) {
      var_0 = self._id_A905;
    }

    if(!isDefined(var_0)) {
      self._id_E45C = var_0;
    }

    self notify("stop_going_to_node");

    if(self == level._id_C47F) {
      thread _id_73B8(120, 70, 0.75);
    } else {
      thread _id_73B8(250, 100);
    }
  }

  _id_10FD9();
  self.dontevershoot = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self._id_2894 = 0.75;
}

_id_1A33() {
  for(;;) {
    if(isDefined(self._id_11707)) {
      wait 1;
      continue;
    }

    if(!isDefined(self._id_11707) && (isDefined(self.enemy) && !level.player scripts\sp\utility::_id_CFAC(self.enemy)) || !isDefined(self.enemy)) {
      self clearenemy();

      if(self.a.movement == "stop" && isDefined(self.goalnode)) {
        self orientmode("face angle", self.goalnode.angles[1]);
      }

      var_0 = getaiarray("axis");

      foreach(var_2 in var_0) {
        if(scripts\sp\utility::_id_CFAC(var_2) && isalive(var_2)) {
          scripts\sp\utility::_id_F39C(var_2);
          break;
        }
      }
    }

    wait 1;
  }
}

_id_73E4(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(isDefined(var_0.ignoreme) && var_0.ignoreme == 1) {
    return 0;
  }

  var_1 = 200;
  var_2 = 850;
  var_3 = distance(self.origin, var_0.origin);
  var_3 = int(var_3);

  if(_id_9BCE(var_0) && var_3 <= var_2) {
    _id_73B4("^5 My enemy is going to attack!");
    return 1;
  }

  if(isDefined(var_0._id_10E6D) && var_0._id_10E6D.state > 0) {
    _id_73B4("^5 Enemy is alert!");
    return 1;
  }

  if(var_3 > var_1) {
    _id_73B4("^5 My dist to enemy: ^2" + var_3 + "^5 Required to attack is: ^2 " + var_1 + "^5 NOT attacking.");
    return 0;
  }

  if(isDefined(var_0._id_10E6D) && var_0._id_10E6D.state == 0 && !isDefined(var_0._id_6592)) {
    _id_73B4("^5 Not clear to attack this enemy unless he sees player!");
    return 0;
  }

  if(scripts\sp\maps\titan\titan_code::_id_10A5C(var_0.origin)) {
    _id_73B4("^5 Enemy is above/below me - not attacking.");
    return 0;
  }

  var_4 = undefined;

  if(!isDefined(var_4)) {
    return 1;
  }

  if(isDefined(var_4) && scripts\sp\maps\titan\titan_code::_id_D283(var_4)) {
    _id_73B4("^5 Player sees required ai.");
    return 1;
  } else {
    _id_73B4("^5 I'm close enough to my enemy to attack but player cant see required AI.");
    return 0;
  }
}

_id_EA10() {
  self._id_6592 = 1;
}

_id_9BCE(var_0) {
  if(var_0 scripts\sp\utility::_id_65DF("stealth_attack") && var_0 scripts\sp\utility::_id_65DB("stealth_attack")) {
    return 1;
  } else {
    return 0;
  }
}

_id_7AE0() {
  var_0 = self.a.pose;
  return level._stealth._id_AFBD._id_53A8["hidden"][var_0];
}

_id_7D4C(var_0, var_1, var_2) {
  var_1 endon("death");
  var_3 = var_2;
  var_4 = 350;
  var_5 = 150;
  var_6 = 100;

  if(var_3 <= var_6) {
    _id_73B4("^5 Player doesn't need to see anyone for me to attack.");
    return undefined;
  } else if(var_3 <= var_5) {
    _id_73B4("^5 Player needs to see only me to attack.");
    return [var_0];
  } else if(var_3 <= var_4) {
    _id_73B4("^5 Player needs to see me AND my enemy to attack.");
    return [var_0, var_1];
  }
}

_id_73DE(var_0) {
  var_1 = "stealth_spotted";

  if(isDefined(self._id_11707)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  _id_73B4("^1 I'm attacking my enemy!");
  self._id_11707 = 1;
  var_2 = self._id_2894;
  self._id_CA15 = 1;
  self._id_2894 = self._id_2894 * 10;
  self.dontevershoot = undefined;

  if(isalive(var_0)) {
    _id_73CF(var_0);
  }

  self._id_2894 = var_2;
  self._id_CA15 = 0;
  self.dontevershoot = 1;
  self._id_11707 = undefined;
  thread _id_8406();
}

_id_73CF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_5951 = undefined;
  thread _id_73F9(var_0);
  var_0 thread _id_992C(self);
  var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_178D(scripts\sp\utility::timeout, 5);
  scripts\sp\utility::_id_57D6();

  if(!isalive(var_0)) {
    return;
  }
  self notify("stop_chasing_enemy");
  return;
}

_id_78FD() {
  if(!isDefined(self._id_EDAD)) {
    return undefined;
  }

  if(isDefined(self._id_4397)) {
    return self._id_4397;
  }

  if(isDefined(self._id_439C)) {
    return self._id_439C;
  }

  return undefined;
}

_id_73F9(var_0) {
  var_0 endon("death");
  self endon("stop_chasing_enemy");
  var_1 = 800;

  while(isalive(var_0)) {
    if(!self cansee(var_0)) {
      var_2 = distance(self.origin, var_0.origin);

      if(var_2 <= var_1) {
        self setgoalpos(var_0.origin);
      }
    } else
      self setgoalpos(self.origin);

    wait 0.25;
  }
}

_id_992C(var_0) {
  for(;;) {
    self waittill("damage", var_1, var_2);

    if(var_2 == var_0) {
      scripts\sp\utility::_id_54C6();
    }
  }
}

_id_73B4(var_0) {}

_id_73B3(var_0, var_1) {}

_id_73AF(var_0, var_1, var_2) {}

_id_79F4(var_0) {
  var_1 = bulletTrace(var_0 + (0, 0, 100), var_0, 0, self, 1, 1, 1);
  return var_1["position"];
}

_id_8406() {
  if(isDefined(self.node)) {
    self _meth_82EE(self.node);
    return;
  } else if(isDefined(self._id_73B5)) {
    self setgoalpos(self._id_73B5);
    return;
  }

  var_0 = undefined;

  if(isDefined(self._id_A906)) {
    var_0 = self._id_A906;
  } else if(isDefined(self._id_A905)) {
    var_0 = self._id_A905;
  }

  if(!isDefined(var_0)) {
    return;
  }
  thread scripts\sp\maps\titan\titan_stealth_street::_id_8E2B(var_0);
}

_id_1017F() {
  level notify("stop_friendly_follow_mode");

  foreach(var_1 in getaiarray("allies")) {
    if(var_1 scripts\sp\utility::_id_65DF("override_follow_mode")) {
      var_1 _id_10FD8();
    }
  }
}

_id_10FD8() {
  self notify("stop_friendly_follow");
  self._id_73B7 = undefined;
  self.fixednode = 1;
  self._id_4B59 = undefined;
  self._id_B7D2 = undefined;

  if(scripts\sp\utility::_id_65DF("override_follow_mode") && scripts\sp\utility::_id_65DB("override_follow_mode")) {
    scripts\sp\utility::_id_65DD("override_follow_mode");
  }

  self allowedstances("stand", "crouch", "prone");
  scripts\sp\utility::_id_4145();
}

_id_10180() {
  foreach(var_1 in getaiarray("allies")) {
    if(isDefined(var_1._id_73F4)) {
      var_1 _id_10FD9();
    }
  }
}

_id_10FD9() {
  self notify("stop_friendly_follow_stealth_logic");
  self._id_73F4 = undefined;
  self.maxsightdistsqrd = 67108864;
  self.maxsightdistsqrd = squared(8192);
  scripts\sp\utility::_id_F340();
}

_id_13511() {
  self._id_134EC["time_between_lines"] = 5000;
  self._id_134EC["contact"]["last_time_said"] = 0;
  self._id_134EC["engaging"]["last_time_said"] = 0;
  self._id_134EC["targetdown"]["last_time_said"] = 0;
}

_id_8E49() {
  if(isDefined(level._id_C47F.enemy)) {
    if(isDefined(level._id_2429.enemy)) {
      return level._id_C47F.enemy == level._id_2429.enemy;
    }
  }

  return 0;
}

_id_1C23() {}