/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3879.gsc
**************************************/

_id_79F5(var_0) {
  if(!isDefined(level._id_10E6D.group.groups[var_0])) {
    return undefined;
  }

  if(level._id_10E6D.group.groups[var_0].size) {
    level._id_10E6D.group.groups[var_0] = ::scripts\sp\utility::_id_22B9(level._id_10E6D.group.groups[var_0]);
  }

  return level._id_10E6D.group.groups[var_0];
}

_id_868A(var_0, var_1) {
  var_2 = _id_79F6(var_0, var_1);
  scripts\engine\utility::flag_clear(var_2);
  var_3 = level._id_10E6D.group.flags[var_0];
  var_4 = 1;

  foreach(var_7, var_6 in var_3) {
    if(!issubstr(var_6, "allies") && scripts\engine\utility::flag(var_6)) {
      return;
    }
  }

  if(scripts\engine\utility::flag(var_2) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::flag_clear(var_0);
}

_id_868C(var_0) {
  var_1 = _id_79F6(var_0);

  if(!scripts\engine\utility::flag(var_1) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::flag_set(var_1);
  scripts\engine\utility::flag_set(var_0);
}

_id_8689(var_0) {
  var_1 = _id_79F6(var_0);
  return scripts\engine\utility::flag(var_1);
}

_id_79F6(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_EED1;
  }

  var_2 = var_0 + "-Group:" + var_1;
  return var_2;
}

_id_868D(var_0) {
  var_1 = _id_79F6(var_0);
  scripts\engine\utility::flag_wait(var_1);
}

_id_868E(var_0) {
  var_1 = _id_79F6(var_0);
  scripts\engine\utility::flag_waitopen(var_1);
}

_id_868B(var_0) {
  if(isDefined(self._id_EED1)) {
    self._id_EED1 = scripts\sp\utility::string(self._id_EED1);
  } else {
    self._id_EED1 = "default";
  }

  if(self.team == "allies") {
    self._id_EED1 = self._id_EED1 + "allies";
  }

  if(!scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_init(var_0);
  }

  var_1 = _id_79F6(var_0);

  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);

    if(!isDefined(level._id_10E6D.group.flags[var_0])) {
      level._id_10E6D.group.flags[var_0] = [];
    }

    level._id_10E6D.group.flags[var_0][level._id_10E6D.group.flags[var_0].size] = var_1;
  }
}

_id_8682() {
  if(!isDefined(level._id_10E6D.group.groups[self._id_EED1])) {
    level._id_10E6D.group.groups[self._id_EED1] = [];
    level._id_10E6D.group notify(self._id_EED1);
  }

  level._id_10E6D.group.groups[self._id_EED1][level._id_10E6D.group.groups[self._id_EED1].size] = self;
}

_id_869D() {
  var_0 = _id_79F6("stealth_spotted");
  return scripts\engine\utility::flag(var_0);
}

_id_7CAD() {
  switch (self._id_10E6D.state) {
    case 0:
      return "normal";
    case 1:
      return "warning";
    case 2:
      return "warning";
    case 3:
      return "attack";
  }
}

_id_F5B7(var_0) {
  switch (var_0) {
    case "attack":
      var_1 = 3;
      break;
    case "warning2":
      var_1 = 2;
      break;
    case "warning1":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
      break;
  }

  self._id_10E6D.state = var_1;
}

_id_3DD1() {}

_id_1B3C() {
  level._id_10E6D._id_1B2C = [];
  level._id_10E6D._id_1B2C["normal"] = "noncombat";
  level._id_10E6D._id_1B2C["reset"] = "noncombat";
  level._id_10E6D._id_1B2C["warning1"] = "alert";
  level._id_10E6D._id_1B2C["warning2"] = "alert";
  level._id_10E6D._id_1B2C["attack"] = "combat";
  level._id_10E6D._id_1B2D = [];
  level._id_10E6D._id_1B2D["normal"] = 0;
  level._id_10E6D._id_1B2D["reset"] = 0;
  level._id_10E6D._id_1B2D["warning1"] = 1;
  level._id_10E6D._id_1B2D["warning2"] = 2;
  level._id_10E6D._id_1B2D["attack"] = 3;
  level._id_10E6D._id_1B2C["combat"] = 3;
}

_id_1B40(var_0) {
  if(isDefined(level._id_10E6D._id_1B2C[var_0])) {
    return level._id_10E6D._id_1B2C[var_0];
  }

  return var_0;
}

_id_F557(var_0) {
  self._id_10E6D._id_D7DE = var_0;
}

_id_F353(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  _id_0F23::_id_F354(var_0, var_1);
}

_id_57C7() {
  switch (self.team) {
    case "team3":
    case "axis":
      level.player _id_0F24::main();
      thread _id_0F1B::main();
      break;
    case "allies":
      thread _id_0F1D::main();
      break;
  }
}

_id_9C1E() {
  if(!isDefined(self._id_10E6D)) {
    return 0;
  }

  if(self.team == "allies") {
    return 1;
  }

  if(self._id_10E6D.state == 4) {
    return 0;
  }

  return 1;
}

_id_EB62() {
  if(isDefined(self._id_10E6D._id_A8C3)) {
    return;
  }
  self._id_EB6E = self._id_EDB0;

  if(isDefined(self._id_A906)) {
    self._id_10E6D._id_A8C3 = self._id_A906;
  } else if(isDefined(self._id_A905)) {
    self._id_10E6D._id_A8C3 = self._id_A905.origin;
  } else if(isDefined(self._id_A907)) {
    self._id_10E6D._id_A8C3 = self._id_A907;
  } else {
    self._id_10E6D._id_A8C3 = self.origin;
  }
}

_id_F4C5(var_0) {
  self._id_10E6D._id_C98D = var_0;
  _id_F4C8(self._id_10E6D._id_C9A8);
}

_id_F341(var_0) {
  self._id_10E6D._id_500C = var_0;

  if(isDefined(self._id_10E6D._id_500C)) {
    _id_F4C8(self._id_10E6D._id_500C, 1);
  }
}

_id_C9A9(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "unaware":
      return 0;
    case "alert":
      return 1;
    case "seek":
    case "run":
      return 2;
    case "combat":
      return 3;
  }

  return 0;
}

_id_F4C8(var_0, var_1, var_2) {
  if(isDefined(self._id_527B) && self._id_527B == "combat") {
    self._id_10E6D._id_C9A8 = "combat";
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = "unaware";
  }

  if(var_0 == "noncombat" || var_0 == "cleared") {
    var_0 = "unaware";
  }

  var_3 = self._id_10E6D._id_C9A8;

  switch (var_0) {
    case "unaware":
    case "alert":
    case "seek":
    case "run":
      self._id_527B = "patrol";
      scripts\asm\asm_bb::_id_2980("patrol", var_0);
      self._id_10E6D._id_C9A8 = var_0;
      break;
    case "combat":
      self._id_527B = "combat";
      self._id_10E6D._id_C9A8 = var_0;
      break;
    default:
      self._id_10E6D._id_C9A8 = "combat";
      break;
  }

  if(isDefined(self._id_10E6D._id_C98D)) {
    if(var_0 != "seek" && var_0 != "combat") {
      self.a._id_C98D = self._id_10E6D._id_C98D;
      self.noturnanims = 1;
    } else {
      self.a._id_C98D = undefined;
      self.noturnanims = undefined;
    }
  }

  if(scripts\engine\utility::is_true(var_1) && isDefined(var_3) && var_3 != self._id_10E6D._id_C9A8) {
    _id_F4C6(var_3, self._id_10E6D._id_C9A8, var_2);
  }
}

_id_7B71() {
  return self._id_10E6D._id_C9A8;
}

_id_7B72() {
  var_0 = self._id_10E6D._id_500C;

  if(!isDefined(var_0)) {
    var_0 = level._id_10E6D._id_500C;
  }

  return var_0;
}

_id_F4C9() {
  var_0 = _id_7B72();

  if(isDefined(var_0)) {
    _id_F4C8(var_0, 1);
  } else {
    _id_F4C8("unaware", 1);
  }
}

_id_F4C6(var_0, var_1, var_2) {
  if(isDefined(self._id_10E6D._id_C999) && _id_C9A9(self._id_10E6D._id_C999) >= _id_C9A9(var_1)) {
    return;
  }
  if(var_1 != "combat" && isDefined(self._id_10E6D._id_C997) && gettime() - self._id_10E6D._id_C997 < 3000) {
    return;
  }
  if(!scripts\engine\utility::is_true(self._id_10E6D._id_4C96)) {
    self._id_10E6D._id_C997 = gettime();
    self._id_10E6D._id_C996 = var_0;
    self._id_10E6D._id_C999 = var_1;
    self._id_10E6D._id_C998 = var_2;
  }

  self notify("stealth_react", var_0, var_1, var_2);
}

_id_8468() {
  self notify("going_back");
  self endon("death");

  if(isDefined(self._id_10E6D._id_8439)) {
    self[[self._id_10E6D._id_8439]]();
  }

  var_0 = self._id_10E6D._id_A8C3;

  if(isDefined(self._id_EB6E)) {
    self._id_EDB0 = self._id_EB6E;
    self._id_EB6E = undefined;
  }

  if(isnode(var_0)) {
    self._id_10E6D._id_A8C3 = undefined;
    _id_10EE4(0);
    return;
  }

  if(isDefined(var_0)) {
    self setgoalpos(var_0);
    self.goalradius = 40;
  }

  if(isDefined(var_0)) {
    thread _id_8469(var_0);
  }

  wait 0.05;
  _id_10EE4(0);
}

_id_8469(var_0) {
  self endon("death");
  scripts\sp\utility::_id_13817(var_0);
  self._id_10E6D.last_spot = undefined;
}

_id_4F6C(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_A88F)) {
    self._id_A88F = gettime();
  } else {
    var_4 = gettime();

    if(var_4 < self._id_A88F + 10000) {
      return;
    } else {
      self._id_A88F = gettime();
    }
  }

  var_5 = _id_79F5(self._id_EED1);
  var_5 = sortbydistance(var_5, self.origin);
  var_6 = 0;

  foreach(var_9, var_8 in var_5) {
    if(!isalive(var_8)) {
      continue;
    }
    if(!isDefined(var_8._id_10E6D)) {
      continue;
    }
    var_8 _meth_84F7("trigger_cover_blown", self, self.origin);

    if(var_8 == self) {
      continue;
    }
    if(isDefined(var_3) && distancesquared(self.origin, var_8.origin) > squared(var_3)) {
      continue;
    }
    if(isDefined(var_8.enemy) || isDefined(var_8.favoriteenemy)) {
      continue;
    }
    if(isDefined(var_8._id_10E6D) && var_8 scripts\sp\utility::_id_65DB("stealth_hold_position")) {
      continue;
    }
    if(isDefined(var_2)) {
      if(var_2 <= 0) {
        continue;
      }
      var_2--;
    }

    var_6 = 1;
    var_8 _meth_84F7(var_0, self, var_1);
  }
}

_id_1B24(var_0) {
  var_1 = distance(self.origin, var_0.origin) * 0.0005;
  var_2 = level._id_10E6D._id_B739 + var_1;
  return var_2;
}

_id_F4C4(var_0) {
  var_0._id_571D = _id_7B6E(self.origin, var_0.origin, self);
}

_id_7B6E(var_0, var_1, var_2) {
  var_3 = self findpath(var_0, var_1);

  if(isDefined(var_2)) {
    var_2.path = var_3;
  }

  var_4 = 0;

  for(var_5 = 1; var_5 < var_3.size; var_5++) {
    var_4 = var_4 + distancesquared(var_3[var_5 - 1], var_3[var_5]);
  }

  return var_4;
}

_id_E06B() {
  self.path = undefined;
  self._id_571D = undefined;
}

_id_9D11(var_0) {
  if(isPlayer(self)) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0.766)) {
      if(isDefined(var_0._id_11413) || _id_0F25::_id_1140D()) {
        return 1;
      }

      if(scripts\sp\utility::_id_CFAC(var_0, 250)) {
        return 1;
      }
    }
  } else
    return self cansee(var_0);

  return 0;
}

_id_54E4(var_0) {
  if(!isarray(var_0)) {
    return;
  }
  var_1 = getarraykeys(var_0);
  var_2 = ["default", "forward", "forward_left", "forward_right", "back", "back_left", "back_right", "left", "right"];

  foreach(var_4 in var_1) {
    if(!scripts\engine\utility::array_contains(var_2, var_4)) {
      return 0;
    }
  }

  return 1;
}

_id_92CF(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_5)) {}

  var_0 _id_3DD1();
  var_7 = var_0 _id_79F6("stealth_spotted");

  if(scripts\engine\utility::flag(var_7)) {
    return;
  }
  if(!_id_54E4(var_2)) {
    return;
  }
  if(isDefined(var_3)) {
    var_0._id_4E2A = var_0 scripts\sp\utility::_id_7ECF(var_3);
  }

  var_0._id_10E6D._id_92CC = 1;

  if(!isDefined(var_5)) {
    thread scripts\sp\anim::_id_1EC9(var_0, "gravity", var_1, var_4);
  } else {
    thread scripts\sp\anim::_id_1ECC(var_0, var_1, undefined, var_4);
  }

  var_0.newenemyreactiondistsq = 0;
  var_0 _id_F321(self, var_2, var_4, var_6);
}

_id_413E() {
  if(!isDefined(self._id_10E6D._id_4C70)) {
    return;
  }
  if(isDefined(self._id_4E2A)) {
    self._id_4E2A = undefined;
  }

  self notify("stop_loop");
  self._id_10E6D._id_4C70.node notify("stop_loop");
  self._id_10E6D._id_4C70 = undefined;
  self._id_10E6D._id_92CC = undefined;
  self.newenemyreactiondistsq = squared(512);
}

_id_F321(var_0, var_1, var_2, var_3) {
  self._id_10E6D._id_4C70 = spawnStruct();
  self._id_10E6D._id_4C70.node = var_0;
  self._id_10E6D._id_4C70._id_1FAF = var_1;
  self._id_10E6D._id_4C70.tag = var_2;
  self._id_10E6D._id_4C70.func = var_3;
}

_id_F320(var_0) {
  if(!_id_54E4(var_0)) {
    return;
  }
  self._id_10E6D._id_4C4F = var_0;
}

_id_CCD3(var_0) {
  if(isDefined(self._id_10E6D._id_4C70._id_CF30)) {
    return;
  }
  self._id_10E6D._id_4C70._id_CF30 = 1;
  var_1 = self._id_10E6D._id_4C70.func;

  if(isDefined(var_1)) {
    [[var_1]]();
  }

  var_2 = self._id_10E6D._id_4C70.node;
  var_3 = self._id_10E6D._id_4C70.tag;

  if(!isarray(self._id_10E6D._id_4C70._id_1FAF)) {
    var_4 = self._id_10E6D._id_4C70._id_1FAF;
  } else {
    var_4 = _id_793D(self._id_10E6D._id_4C70._id_1FAF, level.player.origin);

    if(!isDefined(var_4)) {
      var_4 = self._id_10E6D._id_4C70._id_1FAF[0];
    }
  }

  var_2 notify("stop_loop");

  if(var_0 != "doFlashBanged") {
    if(isDefined(var_3)) {
      var_2 scripts\sp\anim::_id_1EC7(self, var_4, var_3);
    } else {
      var_2 scripts\sp\anim::_id_1EC8(self, "gravity", var_4, var_3);
    }
  }

  self._id_10E6D._id_92CC = undefined;
  self._id_10E6D._id_4C70 = undefined;
  self.newenemyreactiondistsq = squared(512);
}

_id_CCD4(var_0, var_1, var_2) {
  var_3 = self._id_10E6D._id_4C4F;
  var_4 = _id_793D(var_3, var_0.origin);

  if(!isDefined(var_4)) {
    var_4 = var_3[0];
  }

  self._id_10E6D._id_4C70.node notify("stop_loop");

  if(!isDefined(var_1)) {
    self._id_10E6D._id_4C70.node scripts\sp\anim::_id_1EC7(self, var_4);
  } else {
    self._id_10E6D._id_4C70.node scripts\sp\anim::_id_1EC8(self, "gravity", var_4, var_2);
  }

  self._id_10E6D._id_92CC = undefined;
  self._id_10E6D._id_4C70 = undefined;
  self.newenemyreactiondistsq = squared(512);
}

_id_793D(var_0, var_1) {
  var_2 = _id_7AFF(var_1);

  if(!isDefined(var_2)) {
    if(isDefined(var_0["default"])) {
      return var_0["default"];
    } else {
      return undefined;
    }
  }

  if(isDefined(var_0[var_2])) {
    return var_0[var_2];
  }

  switch (var_2) {
    case "back":
      if(isDefined(var_0["back"])) {
        return var_0["back"];
      }

      if(isDefined(var_0["back_left"])) {
        return var_0["back_left"];
      }

      if(isDefined(var_0["back_right"])) {
        return var_0["back_right"];
      }

      break;
    case "back_left":
      if(isDefined(var_0["back_left"])) {
        return var_0["back_left"];
      }

      if(isDefined(var_0["back"])) {
        return var_0["back"];
      }

      break;
    case "back_right":
      if(isDefined(var_0["back_right"])) {
        return var_0["back_right"];
      }

      if(isDefined(var_0["back"])) {
        return var_0["back"];
      }

      break;
    case "forward_left":
      if(isDefined(var_0["forward_left"])) {
        return var_0["forward_left"];
      }

      if(isDefined(var_0["forward"])) {
        return var_0["forward"];
      }

      if(isDefined(var_0["left"])) {
        return var_0["left"];
      }

      break;
    case "left":
      if(isDefined(var_0["left"])) {
        return var_0["left"];
      }

      if(isDefined(var_0["forward"])) {
        return var_0["forward"];
      }

      break;
    case "forward_right":
      if(isDefined(var_0["forward_right"])) {
        return var_0["forward_right"];
      }

      if(isDefined(var_0["forward"])) {
        return var_0["forward"];
      }

      if(isDefined(var_0["right"])) {
        return var_0["right"];
      }

      break;
    case "right":
      if(isDefined(var_0["right"])) {
        return var_0["right"];
      }

      if(isDefined(var_0["forward_right"])) {
        return var_0["forward_right"];
      }
  }

  if(isDefined(var_0["default"])) {
    return var_0["default"];
  }
}

_id_7AFF(var_0) {
  var_1 = self.angles;
  var_2 = self.origin;
  var_3 = 0.85;
  var_4 = 0.5;
  var_5 = undefined;
  var_6 = vectorNormalize(var_0 - var_2);
  var_7 = vectordot(anglesToForward(var_1), var_6);
  var_8 = vectordot(anglestoright(var_1), var_6);

  if(var_7 <= var_3 * -1) {
    return "back";
  } else if(var_7 <= var_4 * -1 && var_8 < 0) {
    return "back_left";
  } else if(var_8 <= var_3 * -1) {
    return "left";
  } else if(var_7 >= var_3) {
    return "forward";
  } else if(var_7 >= var_4 && var_8 < 0) {
    return "forward_left";
  } else if(var_7 >= var_4 && var_8 >= 0) {
    return "forward_right";
  } else if(var_8 >= var_3) {
    return "right";
  } else if(var_7 <= var_4 * -1 && var_8 >= 0) {
    return "back_right";
  }

  return undefined;
}

_id_1FFA(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0 _id_78E7();
  wait 1.5;

  if(isDefined(var_0) && isDefined(var_0._id_10E6D._id_13529)) {
    var_3 = var_0._id_10E6D._id_13529;
    var_1 = var_0.origin + (0, 0, 45);
  } else
    var_3 = randomint(3);

  var_4 = var_2 + var_3 + "_stealth_alert_r";
}

_id_1284A(var_0, var_1) {
  self notify("try_announce_sound_" + var_0);
  self endon("try_announce_sound_" + var_0);
  self endon("death");
  self endon("pain_death");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(!_id_37F7(var_0)) {
    return 0;
  }

  return _id_CE42(var_0);
}

_id_37F7(var_0) {
  if(!isalive(self)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(self._id_939E)) {
    return 0;
  }

  if(!isDefined(level._id_10E6D._id_BF5D) || !isDefined(level._id_10E6D._id_BF5D[var_0])) {
    level._id_10E6D._id_BF5D[var_0] = -10;
  }

  var_1 = gettime();

  if(var_1 < level._id_10E6D._id_BF5D[var_0]) {
    return 0;
  }

  _id_1698(var_0);
  return 1;
}

_id_1698(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(isarray(var_0)) {
    foreach(var_3 in var_0) {
      level._id_10E6D._id_BF5D[var_3] = gettime() + level._id_10E6D._id_BF5E;
    }
  } else
    level._id_10E6D._id_BF5D[var_0] = gettime() + level._id_10E6D._id_BF5E;
}

_id_CE42(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(self._id_10E6D._id_13529)) {
    return 0;
  }

  var_3 = "stealth_";

  if(scripts\engine\utility::is_true(var_1)) {
    var_3 = _id_78E7();
  }

  switch (var_0) {
    case "warning1":
      var_0 = "_enemyalerted";
      break;
    case "hmph":
      var_0 = "_backtopatrol";
      break;
    case "warning2":
      var_0 = scripts\engine\utility::array_randomize(["_enemysearch", "_enemyfindplayer"])[0];
      break;
    case "backup_call":
      var_0 = "_enemybackup";
      break;
    case "acknowledgement":
      var_0 = "_reinforcements";
      break;
    case "spotted":
      var_0 = "_targetfound";
      break;
    case "start_seek":
    case "order_team_seek":
      var_0 = "_enemysearch";
      break;
    case "saw_corpse":
      var_0 = "_enemyalerted";
      break;
    case "found_corpse":
      var_0 = "_corpsefound";
      break;
    case "explosion":
      var_0 = "_noisealert";
      break;
    case "enemysweep":
      var_0 = scripts\engine\utility::array_randomize(["_enemysweep", "_searchreport"])[0];
      break;
    case "chatter":
      var_0 = scripts\engine\utility::array_randomize(["_areasecure", "_confirmclear"])[0];
      break;
  }

  var_4 = var_3 + self._id_10E6D._id_13529 + var_0;
  var_2 = _id_CE43(var_4);
  return var_2;
}

_id_CE43(var_0) {
  var_1 = 0;

  if(soundexists(var_0)) {
    if(!isDefined(self.stealth_vo_ent)) {
      self.stealth_vo_ent = spawn("script_origin", self.origin);
    }

    if(isDefined(self.stealth_vo_ent)) {
      if(isDefined(self.model) && scripts\sp\utility::hastag(self.model, "j_head")) {
        self.stealth_vo_ent linkTo(self, "j_head", (0, 0, 0), (0, 0, 0));
      }

      self.stealth_vo_ent playSound(var_0, "stealth_vo", 1);
    }

    if(isDefined(self._id_10E6D)) {
      self._id_10E6D._id_A90B = gettime();
    }

    var_1 = 1;
  } else {}

  return var_1;
}

_id_78E7() {
  if(!isDefined(anim._id_46BD)) {
    return "";
  }

  if(!isDefined(self.voice) || !isDefined(anim._id_46BD[self.voice])) {
    return "";
  }

  return anim._id_46BD[self.voice] + "_";
}

_id_10ED8(var_0, var_1) {
  self notify("stealth_music");
  self endon("stealth_music");
  thread _id_10ED9();

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");

    foreach(var_3 in level.players) {
      var_3 thread _id_10EDB(var_0);
    }

    scripts\engine\utility::flag_wait("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");

    foreach(var_3 in level.players) {
      var_3 thread _id_10EDB(var_1);
    }
  }
}

_id_10EDA() {
  self notify("stealth_music");
  self notify("stealth_music_pause_monitor");

  foreach(var_1 in level.players) {
    var_1 thread _id_10EDB(undefined);
  }
}

_id_10ED9(var_0, var_1) {
  self notify("stealth_music_pause_monitor");
  self endon("stealth_music_pause_monitor");

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_music_pause");

    foreach(var_3 in level.players) {
      var_3 thread _id_10EDB(undefined);
    }

    scripts\engine\utility::flag_waitopen("stealth_music_pause");

    if(scripts\engine\utility::flag("stealth_spotted")) {
      foreach(var_3 in level.players) {
        var_3 thread _id_10EDB(var_1);
      }

      continue;
    }

    foreach(var_3 in level.players) {
      var_3 thread _id_10EDB(var_0);
    }
  }
}

_id_10EDB(var_0) {
  self notify("stealth_music_transition");
  self endon("stealth_music_transition");
  self endon("disconnect");

  if(!isDefined(self._id_10E6D)) {
    thread _id_0F24::main();
  }

  var_1 = 1.0;
  var_2 = 0.05;

  if(!isDefined(self._id_10E6D.music_ent)) {
    self._id_10E6D.music_ent = [];
  }

  var_3 = var_0;

  if(isDefined(var_3) && !isDefined(self._id_10E6D.music_ent[var_3])) {
    self._id_10E6D.music_ent[var_3] = spawn("script_model", self.origin);
    self._id_10E6D.music_ent[var_3] linkTo(self);
    self._id_10E6D.music_ent[var_3]._id_4B15 = 0.0;
    self._id_10E6D.music_ent[var_3] _meth_8278(0.0);
    self._id_10E6D.music_ent[var_3] playLoopSound(var_3);
  }

  for(;;) {
    wait(var_2);
    var_4 = 0;

    foreach(var_3, var_6 in self._id_10E6D.music_ent) {
      var_7 = undefined;

      if(isDefined(var_0) && var_3 == var_0) {
        var_6._id_4B15 = min(1.0, var_6._id_4B15 + var_2 / var_1);
        var_7 = 1.0;
      } else {
        var_6._id_4B15 = max(0.0, var_6._id_4B15 - var_2 / var_1);
        var_7 = 0.0;
      }

      var_6 _meth_8278(var_6._id_4B15);

      if(var_6._id_4B15 == var_7) {
        var_4++;
      }
    }

    if(var_4 == self._id_10E6D.music_ent.size) {
      foreach(var_3, var_6 in self._id_10E6D.music_ent) {
        if(!isDefined(var_0) || var_3 != var_0) {
          self._id_10E6D.music_ent[var_3] delete();
          self._id_10E6D.music_ent[var_3] = undefined;
        }
      }

      return;
    }
  }
}

_id_F357(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    level._id_10E6D._id_5659 = 1;
    level._id_10E6D._id_117EB = 0.4;
    level._id_10E6D._id_117EA = 0.4;
    level._id_10E6D._id_DAB2 = 0;
    level._id_10E6D._id_DAB3 = 0;
    setsaveddvar("ai_threatSightFacingScale", 0.25);
    setsaveddvar("ai_threatSightFacingScaleDot", cos(90));
    setsaveddvar("ai_threatSightDisplaySpikePoint", 0.025);
    setsaveddvar("ai_threatSightDisplaySpikeValue", 0.25);
  } else {
    level._id_10E6D._id_5659 = undefined;
    level._id_10E6D._id_117EB = undefined;
    level._id_10E6D._id_117EA = undefined;
    level._id_10E6D._id_DAB2 = 50;
    level._id_10E6D._id_DAB3 = 100;
    setsaveddvar("ai_threatSightFacingScale", 0.5);
    setsaveddvar("ai_threatSightFacingScaleDot", cos(180));
    setsaveddvar("ai_threatSightDisplaySpikePoint", 0.01);
    setsaveddvar("ai_threatSightDisplaySpikeValue", 0.1);
  }

  var_1 = getaiarray();

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isDefined(var_3._id_10E6D) && isDefined(var_3._id_10E6D._id_117DB)) {
      var_3 _id_0F26::_id_117D5();
    }
  }
}

_id_10EE4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    scripts\sp\utility::anim_stopanimScripted();
    self._id_E014 = 1;
    scripts\sp\utility::_id_65E1("stealth_override_goal");
    _id_0F1B::_id_F2E0(0);
    self._id_A905 = undefined;
  } else
    scripts\sp\utility::_id_65DD("stealth_override_goal");
}

_id_10E82() {
  return scripts\sp\utility::_id_65DF("stealth_override_goal") && scripts\sp\utility::_id_65DB("stealth_override_goal");
}

_id_10E87() {
  if(_id_10E82()) {
    scripts\sp\utility::_id_65E8("stealth_override_goal");
  }
}

_id_558C() {
  scripts\engine\utility::flag_clear("stealth_enabled");
  var_0 = getaiunittypearray("all", "all");

  foreach(var_2 in var_0) {
    var_2 _id_623D(0);
  }

  foreach(var_5 in level.players) {
    var_5.maxvisibledist = 8192;

    if(var_5 scripts\sp\utility::_id_65DF("stealth_enabled")) {
      var_5 scripts\sp\utility::_id_65DD("stealth_enabled");
    }
  }

  _id_0F23::_id_6806("spotted");
}

_id_623F() {
  scripts\engine\utility::flag_set("stealth_enabled");
  var_0 = getaiunittypearray("all", "all");

  foreach(var_2 in var_0) {
    var_2 _id_623D(1);
  }

  foreach(var_5 in level.players) {
    if(var_5 scripts\sp\utility::_id_65DF("stealth_enabled")) {
      var_5 scripts\sp\utility::_id_65E1("stealth_enabled");
    }
  }
}

_id_623D(var_0) {
  if(!var_0) {
    self.maxvisibledist = 8192;

    if(scripts\sp\utility::_id_65DF("stealth_enabled") && scripts\sp\utility::_id_65DB("stealth_enabled") && self.team == "axis") {
      var_1 = spawnStruct();
      var_1.origin = level.player.origin;
      var_1._id_9B20 = level.player.origin;
      _id_0F1B::_id_6808(var_1);
    }
  }

  if(scripts\sp\utility::_id_65DF("stealth_enabled")) {
    if(var_0) {
      scripts\sp\utility::_id_65E1("stealth_enabled");
    } else {
      scripts\sp\utility::_id_65DD("stealth_enabled");
    }
  }
}

_id_4C75(var_0) {
  if(isDefined(var_0["spotted"])) {
    self._id_10F04["spotted"] = var_0["spotted"];
  }

  if(isDefined(var_0["hidden"])) {
    self._id_10F04["hidden"] = var_0["hidden"];
  }
}

_id_F5B4(var_0, var_1) {
  self._id_10E6D._id_74D5[var_0] = var_1;
}

_id_57D8() {
  self endon("death");
  scripts\sp\utility::_id_57D5();
}

_id_8693() {
  self endon("death");
  var_0 = self._id_EED1;

  if(isDefined(var_0)) {
    var_1 = _id_79F5(var_0);

    if(isDefined(var_1) && var_1.size) {
      foreach(var_3 in var_1) {
        var_4 = var_3 _id_7B71();

        if(var_3 != self && isDefined(var_4) && var_4 == "seek") {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_CD58(var_0, var_1) {
  _id_10EE4(1);
  _id_F4C8("seek", 1, var_0);
  var_2 = var_0 - self.origin;
  var_2 = vectorNormalize((var_2[0], var_2[1], 0));
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = vectortoangles(var_2);
  var_4 = (0, 0, 20);
  var_3.origin = physicstrace(var_3.origin + var_4, var_3.origin - var_4);
  var_5 = getclosestpointonnavmesh(var_3.origin, self);
  var_6 = "goal";
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = isDefined(self._id_1FBB) && isDefined(level._id_EC85[self._id_1FBB]) && isDefined(level._id_EC85[self._id_1FBB][var_1]);

  if(!var_11 || distance2dsquared(var_3.origin, var_5) > 0.1) {
    scripts\sp\utility::_id_F3DC(var_5);
    self.goalradius = 8;
    var_6 = scripts\engine\utility::waittill_any_return("goal", "bad_path");
    var_11 = 0;
  } else {
    var_7 = getstartorigin(var_3.origin, var_3.angles, level._id_EC85[self._id_1FBB][var_1]);
    var_8 = getclosestpointonnavmesh(var_7, self);

    if(distance2dsquared(var_7, var_8) > 0.1) {
      var_11 = 0;
    } else {
      var_9 = var_7 + rotatevector(getmovedelta(level._id_EC85[self._id_1FBB][var_1], 0, 1), var_3.angles);
      var_10 = getclosestpointonnavmesh(var_9, self);

      if(distance2dsquared(var_9, var_10) > 0.1) {
        var_11 = 0;
      } else {
        if(distance2dsquared(var_0, self.origin) < squared(100)) {
          self._id_10E6D._id_C994 = 1;
        }

        var_3 scripts\sp\anim::_id_1ECE(self, var_1);
      }
    }
  }

  if(var_6 == "goal" && var_11) {
    var_3 scripts\sp\anim::_id_1F35(self, var_1);
    var_12 = getclosestpointonnavmesh(self.origin, self);

    if(distance2dsquared(self.origin, var_12) > 0.0001) {
      self _meth_80F1(var_12, self.angles);
    }

    scripts\sp\utility::_id_F3DC(self.origin);
  } else {}
}

_id_F397(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level._id_10E6D) && isDefined(level._id_10E6D._id_74D5)) {
    level._id_10E6D._id_74D5["event_" + var_0] = var_1;
  }
}