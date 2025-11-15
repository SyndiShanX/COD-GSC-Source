/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3879.gsc
************************/

func_79F5(param_00) {
  if(!isDefined(level.var_10E6D.group.groups[param_00])) {
    return undefined;
  }

  if(level.var_10E6D.group.groups[param_00].size) {
    level.var_10E6D.group.groups[param_00] = scripts\sp\utility::func_22B9(level.var_10E6D.group.groups[param_00]);
  }

  return level.var_10E6D.group.groups[param_00];
}

func_868A(param_00, param_01) {
  var_02 = func_79F6(param_00, param_01);
  scripts\engine\utility::flag_clear(var_02);
  var_03 = level.var_10E6D.group.magicbullet[param_00];
  var_04 = 1;
  foreach(var_06 in var_03) {
    if(!issubstr(var_06, "allies") && scripts\engine\utility::flag(var_06)) {
      return;
    }
  }

  if(scripts\engine\utility::flag(var_02) && self != level) {
    self notify(param_00);
  }

  scripts\engine\utility::flag_clear(param_00);
}

func_868C(param_00) {
  var_01 = func_79F6(param_00);
  if(!scripts\engine\utility::flag(var_01) && self != level) {
    self notify(param_00);
  }

  scripts\engine\utility::flag_set(var_01);
  scripts\engine\utility::flag_set(param_00);
}

func_8689(param_00) {
  var_01 = func_79F6(param_00);
  return scripts\engine\utility::flag(var_01);
}

func_79F6(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = self.var_EED1;
  }

  var_02 = param_00 + "-Group:" + param_01;
  return var_02;
}

func_868D(param_00) {
  var_01 = func_79F6(param_00);
  scripts\engine\utility::flag_wait(var_01);
}

func_868E(param_00) {
  var_01 = func_79F6(param_00);
  scripts\engine\utility::flag_waitopen(var_01);
}

func_868B(param_00) {
  if(isDefined(self.var_EED1)) {
    self.var_EED1 = scripts\sp\utility::string(self.var_EED1);
  } else {
    self.var_EED1 = "default";
  }

  if(self.team == "allies") {
    self.var_EED1 = self.var_EED1 + "allies";
  }

  if(!scripts\engine\utility::flag_exist(param_00)) {
    scripts\engine\utility::flag_init(param_00);
  }

  var_01 = func_79F6(param_00);
  if(!scripts\engine\utility::flag_exist(var_01)) {
    scripts\engine\utility::flag_init(var_01);
    if(!isDefined(level.var_10E6D.group.magicbullet[param_00])) {
      level.var_10E6D.group.magicbullet[param_00] = [];
    }

    level.var_10E6D.group.magicbullet[param_00][level.var_10E6D.group.magicbullet[param_00].size] = var_01;
  }
}

func_8682() {
  if(!isDefined(level.var_10E6D.group.groups[self.var_EED1])) {
    level.var_10E6D.group.groups[self.var_EED1] = [];
    level.var_10E6D.group notify(self.var_EED1);
  }

  level.var_10E6D.group.groups[self.var_EED1][level.var_10E6D.group.groups[self.var_EED1].size] = self;
}

func_869D() {
  var_00 = func_79F6("stealth_spotted");
  return scripts\engine\utility::flag(var_00);
}

func_7CAD() {
  switch (self.var_10E6D.state) {
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

func_F5B7(param_00) {
  switch (param_00) {
    case "attack":
      var_01 = 3;
      break;

    case "warning2":
      var_01 = 2;
      break;

    case "warning1":
      var_01 = 1;
      break;

    default:
      var_01 = 0;
      break;
  }

  self.var_10E6D.state = var_01;
}

func_3DD1() {}

func_1B3C() {
  level.var_10E6D.var_1B2C = [];
  level.var_10E6D.var_1B2C["normal"] = "noncombat";
  level.var_10E6D.var_1B2C["reset"] = "noncombat";
  level.var_10E6D.var_1B2C["warning1"] = "alert";
  level.var_10E6D.var_1B2C["warning2"] = "alert";
  level.var_10E6D.var_1B2C["attack"] = "combat";
  level.var_10E6D.var_1B2D = [];
  level.var_10E6D.var_1B2D["normal"] = 0;
  level.var_10E6D.var_1B2D["reset"] = 0;
  level.var_10E6D.var_1B2D["warning1"] = 1;
  level.var_10E6D.var_1B2D["warning2"] = 2;
  level.var_10E6D.var_1B2D["attack"] = 3;
  level.var_10E6D.var_1B2C["combat"] = 3;
}

func_1B40(param_00) {
  if(isDefined(level.var_10E6D.var_1B2C[param_00])) {
    return level.var_10E6D.var_1B2C[param_00];
  }

  return param_00;
}

func_F557(param_00) {
  self.var_10E6D.var_D7DE = param_00;
}

func_F353(param_00, param_01) {
  if(!isDefined(param_00) && !isDefined(param_01)) {}

  lib_0F23::func_F354(param_00, param_01);
}

func_57C7() {
  switch (self.team) {
    case "team3":
    case "axis":
      level.player lib_0F24::main();
      thread lib_0F1B::main();
      break;

    case "allies":
      thread lib_0F1D::main();
      break;
  }
}

func_9C1E() {
  if(!isDefined(self.var_10E6D)) {
    return 0;
  }

  if(self.team == "allies") {
    return 1;
  }

  if(self.var_10E6D.state == 4) {
    return 0;
  }

  return 1;
}

func_EB62() {
  if(isDefined(self.var_10E6D.var_A8C3)) {
    return;
  }

  self.var_EB6E = self.var_EDB0;
  if(isDefined(self.var_A906)) {
    self.var_10E6D.var_A8C3 = self.var_A906;
    return;
  }

  if(isDefined(self.var_A905)) {
    self.var_10E6D.var_A8C3 = self.var_A905.origin;
    return;
  }

  if(isDefined(self.var_A907)) {
    self.var_10E6D.var_A8C3 = self.var_A907;
    return;
  }

  self.var_10E6D.var_A8C3 = self.origin;
}

func_F4C5(param_00) {
  self.var_10E6D.var_C98D = param_00;
  func_F4C8(self.var_10E6D.var_C9A8);
}

func_F341(param_00) {
  self.var_10E6D.var_500C = param_00;
  if(isDefined(self.var_10E6D.var_500C)) {
    func_F4C8(self.var_10E6D.var_500C, 1);
  }
}

func_C9A9(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
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

func_F4C8(param_00, param_01, param_02) {
  if(isDefined(self.var_527B) && self.var_527B == "combat") {
    self.var_10E6D.var_C9A8 = "combat";
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = "unaware";
  }

  if(param_00 == "noncombat" || param_00 == "cleared") {
    param_00 = "unaware";
  }

  var_03 = self.var_10E6D.var_C9A8;
  switch (param_00) {
    case "unaware":
    case "alert":
    case "seek":
    case "run":
      self.var_527B = "patrol";
      scripts\asm\asm_bb::func_2980("patrol", param_00);
      self.var_10E6D.var_C9A8 = param_00;
      break;

    case "combat":
      self.var_527B = "combat";
      self.var_10E6D.var_C9A8 = param_00;
      break;

    default:
      self.var_10E6D.var_C9A8 = "combat";
      break;
  }

  if(isDefined(self.var_10E6D.var_C98D)) {
    if(param_00 != "seek" && param_00 != "combat") {
      self.a.var_C98D = self.var_10E6D.var_C98D;
      self.noturnanims = 1;
    } else {
      self.a.var_C98D = undefined;
      self.noturnanims = undefined;
    }
  }

  if(scripts\engine\utility::istrue(param_01) && isDefined(var_03) && var_03 != self.var_10E6D.var_C9A8) {
    func_F4C6(var_03, self.var_10E6D.var_C9A8, param_02);
  }
}

func_7B71() {
  return self.var_10E6D.var_C9A8;
}

func_7B72() {
  var_00 = self.var_10E6D.var_500C;
  if(!isDefined(var_00)) {
    var_00 = level.var_10E6D.var_500C;
  }

  return var_00;
}

func_F4C9() {
  var_00 = func_7B72();
  if(isDefined(var_00)) {
    func_F4C8(var_00, 1);
    return;
  }

  func_F4C8("unaware", 1);
}

func_F4C6(param_00, param_01, param_02) {
  if(isDefined(self.var_10E6D.var_C999) && func_C9A9(self.var_10E6D.var_C999) >= func_C9A9(param_01)) {
    return;
  }

  if(param_01 != "combat" && isDefined(self.var_10E6D.var_C997) && gettime() - self.var_10E6D.var_C997 < 3000) {
    return;
  }

  if(!scripts\engine\utility::istrue(self.var_10E6D.var_4C96)) {
    self.var_10E6D.var_C997 = gettime();
    self.var_10E6D.var_C996 = param_00;
    self.var_10E6D.var_C999 = param_01;
    self.var_10E6D.var_C998 = param_02;
  }

  self notify("stealth_react", param_00, param_01, param_02);
}

_meth_8468() {
  self notify("going_back");
  self endon("death");
  if(isDefined(self.var_10E6D._meth_8439)) {
    self[[self.var_10E6D._meth_8439]]();
  }

  var_00 = self.var_10E6D.var_A8C3;
  if(isDefined(self.var_EB6E)) {
    self.var_EDB0 = self.var_EB6E;
    self.var_EB6E = undefined;
  }

  if(isnode(var_00)) {
    self.var_10E6D.var_A8C3 = undefined;
    func_10EE4(0);
    return;
  }

  if(isDefined(var_00)) {
    self give_mp_super_weapon(var_00);
    self.objective_playermask_showto = 40;
  }

  if(isDefined(var_00)) {
    thread _meth_8469(var_00);
  }

  wait(0.05);
  func_10EE4(0);
}

_meth_8469(param_00) {
  self endon("death");
  scripts\sp\utility::func_13817(param_00);
  self.var_10E6D.last_spot = undefined;
}

func_4F6C(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_A88F)) {
    self.var_A88F = gettime();
  } else {
    var_04 = gettime();
    if(var_04 < self.var_A88F + 10000) {
      return;
    } else {
      self.var_A88F = gettime();
    }
  }

  var_05 = func_79F5(self.var_EED1);
  var_05 = sortbydistance(var_05, self.origin);
  var_06 = 0;
  foreach(var_08 in var_05) {
    if(!isalive(var_08)) {
      continue;
    }

    if(!isDefined(var_08.var_10E6D)) {
      continue;
    }

    var_08 _meth_84F7("trigger_cover_blown", self, self.origin);
    if(var_08 == self) {
      continue;
    }

    if(isDefined(param_03) && distancesquared(self.origin, var_08.origin) > squared(param_03)) {
      continue;
    }

    if(isDefined(var_08.isnodeoccupied) || isDefined(var_08.loadstartpointtransients)) {
      continue;
    }

    if(isDefined(var_08.var_10E6D) && var_08 scripts\sp\utility::func_65DB("stealth_hold_position")) {
      continue;
    }

    if(isDefined(param_02)) {
      if(param_02 <= 0) {
        continue;
      }

      param_02--;
    }

    var_06 = 1;
    var_08 _meth_84F7(param_00, self, param_01);
  }
}

func_1B24(param_00) {
  var_01 = distance(self.origin, param_00.origin) * 0.0005;
  var_02 = level.var_10E6D.var_B739 + var_01;
  return var_02;
}

func_F4C4(param_00) {
  param_00.var_571D = func_7B6E(self.origin, param_00.origin, self);
}

func_7B6E(param_00, param_01, param_02) {
  var_03 = self findpath(param_00, param_01);
  if(isDefined(param_02)) {
    param_02.path = var_03;
  }

  var_04 = 0;
  for(var_05 = 1; var_05 < var_03.size; var_05++) {
    var_04 = var_04 + distancesquared(var_03[var_05 - 1], var_03[var_05]);
  }

  return var_04;
}

func_E06B() {
  self.path = undefined;
  self.var_571D = undefined;
}

func_9D11(param_00) {
  if(isplayer(self)) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, param_00.origin, 0.766)) {
      if(isDefined(param_00.var_11413) || lib_0F25::func_1140D()) {
        return 1;
      }

      if(scripts\sp\utility::func_CFAC(param_00, 250)) {
        return 1;
      }
    }
  } else {
    return self getpersstat(param_00);
  }

  return 0;
}

func_54E4(param_00) {
  if(!isarray(param_00)) {
    return;
  }

  var_01 = getarraykeys(param_00);
  var_02 = ["default", "forward", "forward_left", "forward_right", "back", "back_left", "back_right", "left", "right"];
  foreach(var_04 in var_01) {
    if(!scripts\engine\utility::array_contains(var_02, var_04)) {
      return 0;
    }
  }

  return 1;
}

func_92CF(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_05)) {}

  param_00 func_3DD1();
  var_07 = param_00 func_79F6("stealth_spotted");
  if(scripts\engine\utility::flag(var_07)) {
    return;
  }

  if(!func_54E4(param_02)) {
    return;
  }

  if(isDefined(param_03)) {
    param_00.var_4E2A = param_00 scripts\sp\utility::func_7ECF(param_03);
  }

  param_00.var_10E6D.var_92CC = 1;
  if(!isDefined(param_05)) {
    thread scripts\sp\anim::func_1EC9(param_00, "gravity", param_01, param_04);
  } else {
    thread scripts\sp\anim::func_1ECC(param_00, param_01, undefined, param_04);
  }

  param_00.target_alloc = 0;
  param_00 func_F321(self, param_02, param_04, param_06);
}

func_413E() {
  if(!isDefined(self.var_10E6D.var_4C70)) {
    return;
  }

  if(isDefined(self.var_4E2A)) {
    self.var_4E2A = undefined;
  }

  self notify("stop_loop");
  self.var_10E6D.var_4C70.target_getindexoftarget notify("stop_loop");
  self.var_10E6D.var_4C70 = undefined;
  self.var_10E6D.var_92CC = undefined;
  self.target_alloc = squared(512);
}

func_F321(param_00, param_01, param_02, param_03) {
  self.var_10E6D.var_4C70 = spawnStruct();
  self.var_10E6D.var_4C70.target_getindexoftarget = param_00;
  self.var_10E6D.var_4C70.var_1FAF = param_01;
  self.var_10E6D.var_4C70.physics_setgravitydynentscalar = param_02;
  self.var_10E6D.var_4C70.func = param_03;
}

func_F320(param_00) {
  if(!func_54E4(param_00)) {
    return;
  }

  self.var_10E6D.var_4C4F = param_00;
}

func_CCD3(param_00) {
  if(isDefined(self.var_10E6D.var_4C70.var_CF30)) {
    return;
  }

  self.var_10E6D.var_4C70.var_CF30 = 1;
  var_01 = self.var_10E6D.var_4C70.func;
  if(isDefined(var_01)) {
    [[var_01]]();
  }

  var_02 = self.var_10E6D.var_4C70.target_getindexoftarget;
  var_03 = self.var_10E6D.var_4C70.physics_setgravitydynentscalar;
  if(!isarray(self.var_10E6D.var_4C70.var_1FAF)) {
    var_04 = self.var_10E6D.var_4C70.var_1FAF;
  } else {
    var_04 = func_793D(self.var_10E6D.var_4C70.var_1FAF, level.player.origin);
    if(!isDefined(var_04)) {
      var_04 = self.var_10E6D.var_4C70.var_1FAF[0];
    }
  }

  var_02 notify("stop_loop");
  if(param_00 != "doFlashBanged") {
    if(isDefined(var_03)) {
      var_02 scripts\sp\anim::func_1EC7(self, var_04, var_03);
    } else {
      var_02 scripts\sp\anim::func_1EC8(self, "gravity", var_04, var_03);
    }
  }

  self.var_10E6D.var_92CC = undefined;
  self.var_10E6D.var_4C70 = undefined;
  self.target_alloc = squared(512);
}

func_CCD4(param_00, param_01, param_02) {
  var_03 = self.var_10E6D.var_4C4F;
  var_04 = func_793D(var_03, param_00.origin);
  if(!isDefined(var_04)) {
    var_04 = var_03[0];
  }

  self.var_10E6D.var_4C70.target_getindexoftarget notify("stop_loop");
  if(!isDefined(param_01)) {
    self.var_10E6D.var_4C70.target_getindexoftarget scripts\sp\anim::func_1EC7(self, var_04);
  } else {
    self.var_10E6D.var_4C70.target_getindexoftarget scripts\sp\anim::func_1EC8(self, "gravity", var_04, param_02);
  }

  self.var_10E6D.var_92CC = undefined;
  self.var_10E6D.var_4C70 = undefined;
  self.target_alloc = squared(512);
}

func_793D(param_00, param_01) {
  var_02 = func_7AFF(param_01);
  if(!isDefined(var_02)) {
    if(isDefined(param_00["default"])) {
      return param_00["default"];
    } else {
      return undefined;
    }
  }

  if(isDefined(param_00[var_02])) {
    return param_00[var_02];
  }

  switch (var_02) {
    case "back":
      if(isDefined(param_00["back"])) {
        return param_00["back"];
      }

      if(isDefined(param_00["back_left"])) {
        return param_00["back_left"];
      }

      if(isDefined(param_00["back_right"])) {
        return param_00["back_right"];
      }
      break;

    case "back_left":
      if(isDefined(param_00["back_left"])) {
        return param_00["back_left"];
      }

      if(isDefined(param_00["back"])) {
        return param_00["back"];
      }
      break;

    case "back_right":
      if(isDefined(param_00["back_right"])) {
        return param_00["back_right"];
      }

      if(isDefined(param_00["back"])) {
        return param_00["back"];
      }
      break;

    case "forward_left":
      if(isDefined(param_00["forward_left"])) {
        return param_00["forward_left"];
      }

      if(isDefined(param_00["forward"])) {
        return param_00["forward"];
      }

      if(isDefined(param_00["left"])) {
        return param_00["left"];
      }
      break;

    case "left":
      if(isDefined(param_00["left"])) {
        return param_00["left"];
      }

      if(isDefined(param_00["forward"])) {
        return param_00["forward"];
      }
      break;

    case "forward_right":
      if(isDefined(param_00["forward_right"])) {
        return param_00["forward_right"];
      }

      if(isDefined(param_00["forward"])) {
        return param_00["forward"];
      }

      if(isDefined(param_00["right"])) {
        return param_00["right"];
      }
      break;

    case "right":
      if(isDefined(param_00["right"])) {
        return param_00["right"];
      }

      if(isDefined(param_00["forward_right"])) {
        return param_00["forward_right"];
      }

      break;
  }

  if(isDefined(param_00["default"])) {
    return param_00["default"];
  }
}

func_7AFF(param_00) {
  var_01 = self.angles;
  var_02 = self.origin;
  var_03 = 0.85;
  var_04 = 0.5;
  var_05 = undefined;
  var_06 = vectornormalize(param_00 - var_02);
  var_07 = vectordot(anglesToForward(var_01), var_06);
  var_08 = vectordot(anglestoright(var_01), var_06);
  if(var_07 <= var_03 * -1) {
    return "back";
  } else if(var_07 <= var_04 * -1 && var_08 < 0) {
    return "back_left";
  } else if(var_08 <= var_03 * -1) {
    return "left";
  } else if(var_07 >= var_03) {
    return "forward";
  } else if(var_07 >= var_04 && var_08 < 0) {
    return "forward_left";
  } else if(var_07 >= var_04 && var_08 >= 0) {
    return "forward_right";
  } else if(var_08 >= var_03) {
    return "right";
  } else if(var_07 <= var_04 * -1 && var_08 >= 0) {
    return "back_right";
  }

  return undefined;
}

func_1FFA(param_00) {
  var_01 = param_00.origin;
  var_02 = param_00 func_78E7();
  wait(1.5);
  if(isDefined(param_00) && isDefined(param_00.var_10E6D.var_13529)) {
    var_03 = param_00.var_10E6D.var_13529;
    var_01 = param_00.origin + (0, 0, 45);
  } else {
    var_03 = randomint(3);
  }

  var_04 = var_02 + var_03 + "_stealth_alert_r";
}

func_1284A(param_00, param_01) {
  self notify("try_announce_sound_" + param_00);
  self endon("try_announce_sound_" + param_00);
  self endon("death");
  self endon("pain_death");
  if(isDefined(param_01) && param_01 > 0) {
    wait(param_01);
  }

  if(!func_37F7(param_00)) {
    return 0;
  }

  return func_CE42(param_00);
}

func_37F7(param_00) {
  if(!isalive(self)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.var_939E)) {
    return 0;
  }

  if(!isDefined(level.var_10E6D.var_BF5D) || !isDefined(level.var_10E6D.var_BF5D[param_00])) {
    level.var_10E6D.var_BF5D[param_00] = -10;
  }

  var_01 = gettime();
  if(var_01 < level.var_10E6D.var_BF5D[param_00]) {
    return 0;
  }

  func_1698(param_00);
  return 1;
}

func_1698(param_00, param_01) {
  self endon("death");
  if(isDefined(param_01) && param_01 > 0) {
    wait(param_01);
  }

  if(isarray(param_00)) {
    foreach(var_03 in param_00) {
      level.var_10E6D.var_BF5D[var_03] = gettime() + level.var_10E6D.var_BF5E;
    }

    return;
  }

  level.var_10E6D.var_BF5D[param_00] = gettime() + level.var_10E6D.var_BF5E;
}

func_CE42(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(self.var_10E6D.var_13529)) {
    return 0;
  }

  var_03 = "stealth_";
  if(scripts\engine\utility::istrue(param_01)) {
    var_03 = func_78E7();
  }

  switch (param_00) {
    case "warning1":
      param_00 = "_enemyalerted";
      break;

    case "hmph":
      param_00 = "_backtopatrol";
      break;

    case "warning2":
      param_00 = scripts\engine\utility::array_randomize(["_enemysearch", "_enemyfindplayer"])[0];
      break;

    case "backup_call":
      param_00 = "_enemybackup";
      break;

    case "acknowledgement":
      param_00 = "_reinforcements";
      break;

    case "spotted":
      param_00 = "_targetfound";
      break;

    case "start_seek":
    case "order_team_seek":
      param_00 = "_enemysearch";
      break;

    case "saw_corpse":
      param_00 = "_enemyalerted";
      break;

    case "found_corpse":
      param_00 = "_corpsefound";
      break;

    case "explosion":
      param_00 = "_noisealert";
      break;

    case "enemysweep":
      param_00 = scripts\engine\utility::array_randomize(["_enemysweep", "_searchreport"])[0];
      break;

    case "chatter":
      param_00 = scripts\engine\utility::array_randomize(["_areasecure", "_confirmclear"])[0];
      break;
  }

  var_04 = var_03 + self.var_10E6D.var_13529 + param_00;
  var_02 = func_CE43(var_04);
  return var_02;
}

func_CE43(param_00) {
  var_01 = 0;
  if(soundexists(param_00)) {
    if(!isDefined(self.stealth_vo_ent)) {
      self.stealth_vo_ent = spawn("script_origin", self.origin);
    }

    if(isDefined(self.stealth_vo_ent)) {
      if(isDefined(self.model) && scripts\sp\utility::hastag(self.model, "j_head")) {
        self.stealth_vo_ent linkto(self, "j_head", (0, 0, 0), (0, 0, 0));
      }

      self.stealth_vo_ent playSound(param_00, "stealth_vo", 1);
    }

    if(isDefined(self.var_10E6D)) {
      self.var_10E6D.var_A90B = gettime();
    }

    var_01 = 1;
  } else {}

  return var_01;
}

func_78E7() {
  if(!isDefined(level.var_46BD)) {
    return "";
  }

  if(!isDefined(self.voice) || !isDefined(level.var_46BD[self.voice])) {
    return "";
  }

  return level.var_46BD[self.voice] + "_";
}

func_10ED8(param_00, param_01) {
  self notify("stealth_music");
  self endon("stealth_music");
  thread func_10ED9();
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    foreach(var_03 in level.players) {
      var_03 thread func_10EDB(param_00);
    }

    scripts\engine\utility::flag_wait("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    foreach(var_03 in level.players) {
      var_03 thread func_10EDB(param_01);
    }
  }
}

func_10EDA() {
  self notify("stealth_music");
  self notify("stealth_music_pause_monitor");
  foreach(var_01 in level.players) {
    var_01 thread func_10EDB(undefined);
  }
}

func_10ED9(param_00, param_01) {
  self notify("stealth_music_pause_monitor");
  self endon("stealth_music_pause_monitor");
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_music_pause");
    foreach(var_03 in level.players) {
      var_03 thread func_10EDB(undefined);
    }

    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    if(scripts\engine\utility::flag("stealth_spotted")) {
      foreach(var_03 in level.players) {
        var_03 thread func_10EDB(param_01);
      }

      continue;
    }

    foreach(var_03 in level.players) {
      var_03 thread func_10EDB(param_00);
    }
  }
}

func_10EDB(param_00) {
  self notify("stealth_music_transition");
  self endon("stealth_music_transition");
  self endon("disconnect");
  if(!isDefined(self.var_10E6D)) {
    thread lib_0F24::main();
  }

  var_01 = 1;
  var_02 = 0.05;
  if(!isDefined(self.var_10E6D.music_ent)) {
    self.var_10E6D.music_ent = [];
  }

  var_03 = param_00;
  if(isDefined(var_03) && !isDefined(self.var_10E6D.music_ent[var_03])) {
    self.var_10E6D.music_ent[var_03] = spawn("script_model", self.origin);
    self.var_10E6D.music_ent[var_03] linkto(self);
    self.var_10E6D.music_ent[var_03].var_4B15 = 0;
    self.var_10E6D.music_ent[var_03] ghostattack(0);
    self.var_10E6D.music_ent[var_03] playLoopSound(var_03);
  }

  for(;;) {
    wait(var_02);
    var_04 = 0;
    foreach(var_03, var_06 in self.var_10E6D.music_ent) {
      var_07 = undefined;
      if(isDefined(param_00) && var_03 == param_00) {
        var_06.var_4B15 = min(1, var_06.var_4B15 + var_02 / var_01);
        var_07 = 1;
      } else {
        var_06.var_4B15 = max(0, var_06.var_4B15 - var_02 / var_01);
        var_07 = 0;
      }

      var_06 ghostattack(var_06.var_4B15);
      if(var_06.var_4B15 == var_07) {
        var_04++;
      }
    }

    if(var_04 == self.var_10E6D.music_ent.size) {
      foreach(var_03, var_06 in self.var_10E6D.music_ent) {
        if(!isDefined(param_00) || var_03 != param_00) {
          self.var_10E6D.music_ent[var_03] delete();
          self.var_10E6D.music_ent[var_03] = undefined;
        }
      }

      return;
    }
  }
}

func_F357(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(param_00) {
    level.var_10E6D.var_5659 = 1;
    level.var_10E6D.var_117EB = 0.4;
    level.var_10E6D.var_117EA = 0.4;
    level.var_10E6D.var_DAB2 = 0;
    level.var_10E6D.var_DAB3 = 0;
    setsaveddvar("ai_threatSightFacingScale", 0.25);
    setsaveddvar("ai_threatSightFacingScaleDot", cos(90));
    setsaveddvar("ai_threatSightDisplaySpikePoint", 0.025);
    setsaveddvar("ai_threatSightDisplaySpikeValue", 0.25);
  } else {
    level.var_10E6D.var_5659 = undefined;
    level.var_10E6D.var_117EB = undefined;
    level.var_10E6D.var_117EA = undefined;
    level.var_10E6D.var_DAB2 = 50;
    level.var_10E6D.var_DAB3 = 100;
    setsaveddvar("ai_threatSightFacingScale", 0.5);
    setsaveddvar("ai_threatSightFacingScaleDot", cos(180));
    setsaveddvar("ai_threatSightDisplaySpikePoint", 0.01);
    setsaveddvar("ai_threatSightDisplaySpikeValue", 0.1);
  }

  var_01 = getaiarray();
  foreach(var_03 in var_01) {
    if(!isalive(var_03)) {
      continue;
    }

    if(isDefined(var_03.var_10E6D) && isDefined(var_03.var_10E6D.var_117DB)) {
      var_03 lib_0F26::func_117D5();
    }
  }
}

func_10EE4(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(param_00) {
    scripts\sp\utility::anim_stopanimscripted();
    self.var_E014 = 1;
    scripts\sp\utility::func_65E1("stealth_override_goal");
    lib_0F1B::func_F2E0(0);
    self.var_A905 = undefined;
    return;
  }

  scripts\sp\utility::func_65DD("stealth_override_goal");
}

func_10E82() {
  return scripts\sp\utility::func_65DF("stealth_override_goal") && scripts\sp\utility::func_65DB("stealth_override_goal");
}

func_10E87() {
  if(func_10E82()) {
    scripts\sp\utility::func_65E8("stealth_override_goal");
  }
}

func_558C() {
  scripts\engine\utility::flag_clear("stealth_enabled");
  var_00 = getaiunittypearray("all", "all");
  foreach(var_02 in var_00) {
    var_02 func_623D(0);
  }

  foreach(var_05 in level.players) {
    var_05.setturretnode = 8192;
    if(var_05 scripts\sp\utility::func_65DF("stealth_enabled")) {
      var_05 scripts\sp\utility::func_65DD("stealth_enabled");
    }
  }

  lib_0F23::func_6806("spotted");
}

func_623F() {
  scripts\engine\utility::flag_set("stealth_enabled");
  var_00 = getaiunittypearray("all", "all");
  foreach(var_02 in var_00) {
    var_02 func_623D(1);
  }

  foreach(var_05 in level.players) {
    if(var_05 scripts\sp\utility::func_65DF("stealth_enabled")) {
      var_05 scripts\sp\utility::func_65E1("stealth_enabled");
    }
  }
}

func_623D(param_00) {
  if(!param_00) {
    self.setturretnode = 8192;
    if(scripts\sp\utility::func_65DF("stealth_enabled") && scripts\sp\utility::func_65DB("stealth_enabled") && self.team == "axis") {
      var_01 = spawnStruct();
      var_01.origin = level.player.origin;
      var_01.var_9B20 = level.player.origin;
      lib_0F1B::func_6808(var_01);
    }
  }

  if(scripts\sp\utility::func_65DF("stealth_enabled")) {
    if(param_00) {
      scripts\sp\utility::func_65E1("stealth_enabled");
      return;
    }

    scripts\sp\utility::func_65DD("stealth_enabled");
  }
}

func_4C75(param_00) {
  if(isDefined(param_00["spotted"])) {
    self.var_10F04["spotted"] = param_00["spotted"];
  }

  if(isDefined(param_00["hidden"])) {
    self.var_10F04["hidden"] = param_00["hidden"];
  }
}

func_F5B4(param_00, param_01) {
  self.var_10E6D.var_74D5[param_00] = param_01;
}

func_57D8() {
  self endon("death");
  scripts\sp\utility::func_57D5();
}

func_8693() {
  self endon("death");
  var_00 = self.var_EED1;
  if(isDefined(var_00)) {
    var_01 = func_79F5(var_00);
    if(isDefined(var_01) && var_01.size) {
      foreach(var_03 in var_01) {
        var_04 = var_03 func_7B71();
        if(var_03 != self && isDefined(var_04) && var_04 == "seek") {
          return 1;
        }
      }
    }
  }

  return 0;
}

func_CD58(param_00, param_01) {
  func_10EE4(1);
  func_F4C8("seek", 1, param_00);
  var_02 = param_00 - self.origin;
  var_02 = vectornormalize((var_02[0], var_02[1], 0));
  var_03 = spawnStruct();
  var_03.origin = param_00;
  var_03.angles = vectortoangles(var_02);
  var_04 = (0, 0, 20);
  var_03.origin = physicstrace(var_03.origin + var_04, var_03.origin - var_04);
  var_05 = getclosestpointonnavmesh(var_03.origin, self);
  var_06 = "goal";
  var_07 = undefined;
  var_08 = undefined;
  var_09 = undefined;
  var_0A = undefined;
  var_0B = isDefined(self.var_1FBB) && isDefined(level.var_EC85[self.var_1FBB]) && isDefined(level.var_EC85[self.var_1FBB][param_01]);
  if(!var_0B || distance2dsquared(var_03.origin, var_05) > 0.1) {
    scripts\sp\utility::func_F3DC(var_05);
    self.objective_playermask_showto = 8;
    var_06 = scripts\engine\utility::waittill_any_return("goal", "bad_path");
    var_0B = 0;
  } else {
    var_07 = getstartorigin(var_03.origin, var_03.angles, level.var_EC85[self.var_1FBB][param_01]);
    var_08 = getclosestpointonnavmesh(var_07, self);
    if(distance2dsquared(var_07, var_08) > 0.1) {
      var_0B = 0;
    } else {
      var_09 = var_07 + rotatevector(getmovedelta(level.var_EC85[self.var_1FBB][param_01], 0, 1), var_03.angles);
      var_0A = getclosestpointonnavmesh(var_09, self);
      if(distance2dsquared(var_09, var_0A) > 0.1) {
        var_0B = 0;
      } else {
        if(distance2dsquared(param_00, self.origin) < squared(100)) {
          self.var_10E6D.var_C994 = 1;
        }

        var_03 scripts\sp\anim::func_1ECE(self, param_01);
      }
    }
  }

  if(var_06 == "goal" && var_0B) {
    var_03 scripts\sp\anim::func_1F35(self, param_01);
    var_0C = getclosestpointonnavmesh(self.origin, self);
    if(distance2dsquared(self.origin, var_0C) > 0.0001) {
      self _meth_80F1(var_0C, self.angles);
    }

    scripts\sp\utility::func_F3DC(self.origin);
  }
}

func_F397(param_00, param_01) {
  if(isDefined(param_00) && isDefined(level.var_10E6D) && isDefined(level.var_10E6D.var_74D5)) {
    level.var_10E6D.var_74D5["event_" + param_00] = param_01;
  }
}