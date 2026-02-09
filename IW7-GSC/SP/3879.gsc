/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3879.gsc
*********************************************/

func_79F5(var_0) {
  if(!isDefined(level.var_10E6D.group.groups[var_0])) {
    return undefined;
  }

  if(level.var_10E6D.group.groups[var_0].size) {
    level.var_10E6D.group.groups[var_0] = ::scripts\sp\utility::func_22B9(level.var_10E6D.group.groups[var_0]);
  }

  return level.var_10E6D.group.groups[var_0];
}

func_868A(var_0, var_1) {
  var_2 = func_79F6(var_0, var_1);
  scripts\engine\utility::flag_clear(var_2);
  var_3 = level.var_10E6D.group.magicbullet[var_0];
  var_4 = 1;
  foreach(var_6 in var_3) {
    if(!issubstr(var_6, "allies") && scripts\engine\utility::flag(var_6)) {
      return;
    }
  }

  if(scripts\engine\utility::flag(var_2) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::flag_clear(var_0);
}

func_868C(var_0) {
  var_1 = func_79F6(var_0);
  if(!scripts\engine\utility::flag(var_1) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::flag_set(var_1);
  scripts\engine\utility::flag_set(var_0);
}

func_8689(var_0) {
  var_1 = func_79F6(var_0);
  return scripts\engine\utility::flag(var_1);
}

func_79F6(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.var_EED1;
  }

  var_2 = var_0 + "-Group:" + var_1;
  return var_2;
}

func_868D(var_0) {
  var_1 = func_79F6(var_0);
  scripts\engine\utility::flag_wait(var_1);
}

func_868E(var_0) {
  var_1 = func_79F6(var_0);
  scripts\engine\utility::flag_waitopen(var_1);
}

func_868B(var_0) {
  if(isDefined(self.var_EED1)) {
    self.var_EED1 = scripts\sp\utility::string(self.var_EED1);
  } else {
    self.var_EED1 = "default";
  }

  if(self.team == "allies") {
    self.var_EED1 = self.var_EED1 + "allies";
  }

  if(!scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_init(var_0);
  }

  var_1 = func_79F6(var_0);
  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);
    if(!isDefined(level.var_10E6D.group.magicbullet[var_0])) {
      level.var_10E6D.group.magicbullet[var_0] = [];
    }

    level.var_10E6D.group.magicbullet[var_0][level.var_10E6D.group.magicbullet[var_0].size] = var_1;
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
  var_0 = func_79F6("stealth_spotted");
  return scripts\engine\utility::flag(var_0);
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

func_F5B7(var_0) {
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

  self.var_10E6D.state = var_1;
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

func_1B40(var_0) {
  if(isDefined(level.var_10E6D.var_1B2C[var_0])) {
    return level.var_10E6D.var_1B2C[var_0];
  }

  return var_0;
}

func_F557(var_0) {
  self.var_10E6D.var_D7DE = var_0;
}

func_F353(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  lib_0F23::func_F354(var_0, var_1);
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

func_F4C5(var_0) {
  self.var_10E6D.var_C98D = var_0;
  func_F4C8(self.var_10E6D.var_C9A8);
}

func_F341(var_0) {
  self.var_10E6D.var_500C = var_0;
  if(isDefined(self.var_10E6D.var_500C)) {
    func_F4C8(self.var_10E6D.var_500C, 1);
  }
}

func_C9A9(var_0) {
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

func_F4C8(var_0, var_1, var_2) {
  if(isDefined(self.var_527B) && self.var_527B == "combat") {
    self.var_10E6D.var_C9A8 = "combat";
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = "unaware";
  }

  if(var_0 == "noncombat" || var_0 == "cleared") {
    var_0 = "unaware";
  }

  var_3 = self.var_10E6D.var_C9A8;
  switch (var_0) {
    case "unaware":
    case "alert":
    case "seek":
    case "run":
      self.var_527B = "patrol";
      scripts\asm\asm_bb::func_2980("patrol", var_0);
      self.var_10E6D.var_C9A8 = var_0;
      break;

    case "combat":
      self.var_527B = "combat";
      self.var_10E6D.var_C9A8 = var_0;
      break;

    default:
      self.var_10E6D.var_C9A8 = "combat";
      break;
  }

  if(isDefined(self.var_10E6D.var_C98D)) {
    if(var_0 != "seek" && var_0 != "combat") {
      self.a.var_C98D = self.var_10E6D.var_C98D;
      self.noturnanims = 1;
    } else {
      self.a.var_C98D = undefined;
      self.noturnanims = undefined;
    }
  }

  if(scripts\engine\utility::istrue(var_1) && isDefined(var_3) && var_3 != self.var_10E6D.var_C9A8) {
    func_F4C6(var_3, self.var_10E6D.var_C9A8, var_2);
  }
}

func_7B71() {
  return self.var_10E6D.var_C9A8;
}

func_7B72() {
  var_0 = self.var_10E6D.var_500C;
  if(!isDefined(var_0)) {
    var_0 = level.var_10E6D.var_500C;
  }

  return var_0;
}

func_F4C9() {
  var_0 = func_7B72();
  if(isDefined(var_0)) {
    func_F4C8(var_0, 1);
    return;
  }

  func_F4C8("unaware", 1);
}

func_F4C6(var_0, var_1, var_2) {
  if(isDefined(self.var_10E6D.var_C999) && func_C9A9(self.var_10E6D.var_C999) >= func_C9A9(var_1)) {
    return;
  }

  if(var_1 != "combat" && isDefined(self.var_10E6D.var_C997) && gettime() - self.var_10E6D.var_C997 < 3000) {
    return;
  }

  if(!scripts\engine\utility::istrue(self.var_10E6D.var_4C96)) {
    self.var_10E6D.var_C997 = gettime();
    self.var_10E6D.var_C996 = var_0;
    self.var_10E6D.var_C999 = var_1;
    self.var_10E6D.var_C998 = var_2;
  }

  self notify("stealth_react", var_0, var_1, var_2);
}

func_8468() {
  self notify("going_back");
  self endon("death");
  if(isDefined(self.var_10E6D.func_8439)) {
    self[[self.var_10E6D.func_8439]]();
  }

  var_0 = self.var_10E6D.var_A8C3;
  if(isDefined(self.var_EB6E)) {
    self.var_EDB0 = self.var_EB6E;
    self.var_EB6E = undefined;
  }

  if(isnode(var_0)) {
    self.var_10E6D.var_A8C3 = undefined;
    func_10EE4(0);
    return;
  }

  if(isDefined(var_0)) {
    self give_mp_super_weapon(var_0);
    self.objective_playermask_showto = 40;
  }

  if(isDefined(var_0)) {
    thread func_8469(var_0);
  }

  wait(0.05);
  func_10EE4(0);
}

func_8469(var_0) {
  self endon("death");
  scripts\sp\utility::func_13817(var_0);
  self.var_10E6D.last_spot = undefined;
}

func_4F6C(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_A88F)) {
    self.var_A88F = gettime();
  } else {
    var_4 = gettime();
    if(var_4 < self.var_A88F + 10000) {
      return;
    } else {
      self.var_A88F = gettime();
    }
  }

  var_5 = func_79F5(self.var_EED1);
  var_5 = sortbydistance(var_5, self.origin);
  var_6 = 0;
  foreach(var_8 in var_5) {
    if(!isalive(var_8)) {
      continue;
    }

    if(!isDefined(var_8.var_10E6D)) {
      continue;
    }

    var_8 func_84F7("trigger_cover_blown", self, self.origin);
    if(var_8 == self) {
      continue;
    }

    if(isDefined(var_3) && distancesquared(self.origin, var_8.origin) > squared(var_3)) {
      continue;
    }

    if(isDefined(var_8.enemy) || isDefined(var_8.loadstartpointtransients)) {
      continue;
    }

    if(isDefined(var_8.var_10E6D) && var_8 scripts\sp\utility::func_65DB("stealth_hold_position")) {
      continue;
    }

    if(isDefined(var_2)) {
      if(var_2 <= 0) {
        continue;
      }

      var_2--;
    }

    var_6 = 1;
    var_8 func_84F7(var_0, self, var_1);
  }
}

func_1B24(var_0) {
  var_1 = distance(self.origin, var_0.origin) * 0.0005;
  var_2 = level.var_10E6D.var_B739 + var_1;
  return var_2;
}

func_F4C4(var_0) {
  var_0.var_571D = func_7B6E(self.origin, var_0.origin, self);
}

func_7B6E(var_0, var_1, var_2) {
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

func_E06B() {
  self.path = undefined;
  self.var_571D = undefined;
}

func_9D11(var_0) {
  if(isPlayer(self)) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0.766)) {
      if(isDefined(var_0.var_11413) || lib_0F25::func_1140D()) {
        return 1;
      }

      if(scripts\sp\utility::func_CFAC(var_0, 250)) {
        return 1;
      }
    }
  } else {
    return self cansee(var_0);
  }

  return 0;
}

func_54E4(var_0) {
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

func_92CF(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_5)) {}

  var_0 func_3DD1();
  var_7 = var_0 func_79F6("stealth_spotted");
  if(scripts\engine\utility::flag(var_7)) {
    return;
  }

  if(!func_54E4(var_2)) {
    return;
  }

  if(isDefined(var_3)) {
    var_0.var_4E2A = var_0 scripts\sp\utility::func_7ECF(var_3);
  }

  var_0.var_10E6D.var_92CC = 1;
  if(!isDefined(var_5)) {
    thread scripts\sp\anim::func_1EC9(var_0, "gravity", var_1, var_4);
  } else {
    thread scripts\sp\anim::func_1ECC(var_0, var_1, undefined, var_4);
  }

  var_0.target_alloc = 0;
  var_0 func_F321(self, var_2, var_4, var_6);
}

func_413E() {
  if(!isDefined(self.var_10E6D.var_4C70)) {
    return;
  }

  if(isDefined(self.var_4E2A)) {
    self.var_4E2A = undefined;
  }

  self notify("stop_loop");
  self.var_10E6D.var_4C70.node notify("stop_loop");
  self.var_10E6D.var_4C70 = undefined;
  self.var_10E6D.var_92CC = undefined;
  self.target_alloc = squared(512);
}

func_F321(var_0, var_1, var_2, var_3) {
  self.var_10E6D.var_4C70 = spawnStruct();
  self.var_10E6D.var_4C70.node = var_0;
  self.var_10E6D.var_4C70.var_1FAF = var_1;
  self.var_10E6D.var_4C70.physics_setgravitydynentscalar = var_2;
  self.var_10E6D.var_4C70.func = var_3;
}

func_F320(var_0) {
  if(!func_54E4(var_0)) {
    return;
  }

  self.var_10E6D.var_4C4F = var_0;
}

func_CCD3(var_0) {
  if(isDefined(self.var_10E6D.var_4C70.var_CF30)) {
    return;
  }

  self.var_10E6D.var_4C70.var_CF30 = 1;
  var_1 = self.var_10E6D.var_4C70.func;
  if(isDefined(var_1)) {
    [[var_1]]();
  }

  var_2 = self.var_10E6D.var_4C70.node;
  var_3 = self.var_10E6D.var_4C70.physics_setgravitydynentscalar;
  if(!isarray(self.var_10E6D.var_4C70.var_1FAF)) {
    var_4 = self.var_10E6D.var_4C70.var_1FAF;
  } else {
    var_4 = func_793D(self.var_10E6D.var_4C70.var_1FAF, level.player.origin);
    if(!isDefined(var_4)) {
      var_4 = self.var_10E6D.var_4C70.var_1FAF[0];
    }
  }

  var_2 notify("stop_loop");
  if(var_0 != "doFlashBanged") {
    if(isDefined(var_3)) {
      var_2 scripts\sp\anim::func_1EC7(self, var_4, var_3);
    } else {
      var_2 scripts\sp\anim::func_1EC8(self, "gravity", var_4, var_3);
    }
  }

  self.var_10E6D.var_92CC = undefined;
  self.var_10E6D.var_4C70 = undefined;
  self.target_alloc = squared(512);
}

func_CCD4(var_0, var_1, var_2) {
  var_3 = self.var_10E6D.var_4C4F;
  var_4 = func_793D(var_3, var_0.origin);
  if(!isDefined(var_4)) {
    var_4 = var_3[0];
  }

  self.var_10E6D.var_4C70.node notify("stop_loop");
  if(!isDefined(var_1)) {
    self.var_10E6D.var_4C70.node scripts\sp\anim::func_1EC7(self, var_4);
  } else {
    self.var_10E6D.var_4C70.node scripts\sp\anim::func_1EC8(self, "gravity", var_4, var_2);
  }

  self.var_10E6D.var_92CC = undefined;
  self.var_10E6D.var_4C70 = undefined;
  self.target_alloc = squared(512);
}

func_793D(var_0, var_1) {
  var_2 = func_7AFF(var_1);
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

      break;
  }

  if(isDefined(var_0["default"])) {
    return var_0["default"];
  }
}

func_7AFF(var_0) {
  var_1 = self.angles;
  var_2 = self.origin;
  var_3 = 0.85;
  var_4 = 0.5;
  var_5 = undefined;
  var_6 = vectornormalize(var_0 - var_2);
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

func_1FFA(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0 func_78E7();
  wait(1.5);
  if(isDefined(var_0) && isDefined(var_0.var_10E6D.var_13529)) {
    var_3 = var_0.var_10E6D.var_13529;
    var_1 = var_0.origin + (0, 0, 45);
  } else {
    var_3 = randomint(3);
  }

  var_4 = var_2 + var_3 + "_stealth_alert_r";
}

func_1284A(var_0, var_1) {
  self notify("try_announce_sound_" + var_0);
  self endon("try_announce_sound_" + var_0);
  self endon("death");
  self endon("pain_death");
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(!func_37F7(var_0)) {
    return 0;
  }

  return func_CE42(var_0);
}

func_37F7(var_0) {
  if(!isalive(self)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.var_939E)) {
    return 0;
  }

  if(!isDefined(level.var_10E6D.var_BF5D) || !isDefined(level.var_10E6D.var_BF5D[var_0])) {
    level.var_10E6D.var_BF5D[var_0] = -10;
  }

  var_1 = gettime();
  if(var_1 < level.var_10E6D.var_BF5D[var_0]) {
    return 0;
  }

  func_1698(var_0);
  return 1;
}

func_1698(var_0, var_1) {
  self endon("death");
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(isarray(var_0)) {
    foreach(var_3 in var_0) {
      level.var_10E6D.var_BF5D[var_3] = gettime() + level.var_10E6D.var_BF5E;
    }

    return;
  }

  level.var_10E6D.var_BF5D[var_0] = gettime() + level.var_10E6D.var_BF5E;
}

func_CE42(var_0, var_1) {
  var_2 = 0;
  if(!isDefined(self.var_10E6D.var_13529)) {
    return 0;
  }

  var_3 = "stealth_";
  if(scripts\engine\utility::istrue(var_1)) {
    var_3 = func_78E7();
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

  var_4 = var_3 + self.var_10E6D.var_13529 + var_0;
  var_2 = func_CE43(var_4);
  return var_2;
}

func_CE43(var_0) {
  var_1 = 0;
  if(soundexists(var_0)) {
    if(!isDefined(self.stealth_vo_ent)) {
      self.stealth_vo_ent = spawn("script_origin", self.origin);
    }

    if(isDefined(self.stealth_vo_ent)) {
      if(isDefined(self.model) && scripts\sp\utility::hastag(self.model, "j_head")) {
        self.stealth_vo_ent linkto(self, "j_head", (0, 0, 0), (0, 0, 0));
      }

      self.stealth_vo_ent playSound(var_0, "stealth_vo", 1);
    }

    if(isDefined(self.var_10E6D)) {
      self.var_10E6D.var_A90B = gettime();
    }

    var_1 = 1;
  }

  return var_1;
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

func_10ED8(var_0, var_1) {
  self notify("stealth_music");
  self endon("stealth_music");
  thread func_10ED9();
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    foreach(var_3 in level.players) {
      var_3 thread func_10EDB(var_0);
    }

    scripts\engine\utility::flag_wait("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    foreach(var_3 in level.players) {
      var_3 thread func_10EDB(var_1);
    }
  }
}

func_10EDA() {
  self notify("stealth_music");
  self notify("stealth_music_pause_monitor");
  foreach(var_1 in level.players) {
    var_1 thread func_10EDB(undefined);
  }
}

func_10ED9(var_0, var_1) {
  self notify("stealth_music_pause_monitor");
  self endon("stealth_music_pause_monitor");
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_music_pause");
    foreach(var_3 in level.players) {
      var_3 thread func_10EDB(undefined);
    }

    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    if(scripts\engine\utility::flag("stealth_spotted")) {
      foreach(var_3 in level.players) {
        var_3 thread func_10EDB(var_1);
      }

      continue;
    }

    foreach(var_3 in level.players) {
      var_3 thread func_10EDB(var_0);
    }
  }
}

func_10EDB(var_0) {
  self notify("stealth_music_transition");
  self endon("stealth_music_transition");
  self endon("disconnect");
  if(!isDefined(self.var_10E6D)) {
    thread lib_0F24::main();
  }

  var_1 = 1;
  var_2 = 0.05;
  if(!isDefined(self.var_10E6D.music_ent)) {
    self.var_10E6D.music_ent = [];
  }

  var_3 = var_0;
  if(isDefined(var_3) && !isDefined(self.var_10E6D.music_ent[var_3])) {
    self.var_10E6D.music_ent[var_3] = spawn("script_model", self.origin);
    self.var_10E6D.music_ent[var_3] linkto(self);
    self.var_10E6D.music_ent[var_3].var_4B15 = 0;
    self.var_10E6D.music_ent[var_3] ghostattack(0);
    self.var_10E6D.music_ent[var_3] playLoopSound(var_3);
  }

  for(;;) {
    wait(var_2);
    var_4 = 0;
    foreach(var_3, var_6 in self.var_10E6D.music_ent) {
      var_7 = undefined;
      if(isDefined(var_0) && var_3 == var_0) {
        var_6.var_4B15 = min(1, var_6.var_4B15 + var_2 / var_1);
        var_7 = 1;
      } else {
        var_6.var_4B15 = max(0, var_6.var_4B15 - var_2 / var_1);
        var_7 = 0;
      }

      var_6 ghostattack(var_6.var_4B15);
      if(var_6.var_4B15 == var_7) {
        var_4++;
      }
    }

    if(var_4 == self.var_10E6D.music_ent.size) {
      foreach(var_3, var_6 in self.var_10E6D.music_ent) {
        if(!isDefined(var_0) || var_3 != var_0) {
          self.var_10E6D.music_ent[var_3] delete();
          self.var_10E6D.music_ent[var_3] = undefined;
        }
      }

      return;
    }
  }
}

func_F357(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
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

  var_1 = getaiarray();
  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }

    if(isDefined(var_3.var_10E6D) && isDefined(var_3.var_10E6D.var_117DB)) {
      var_3 lib_0F26::func_117D5();
    }
  }
}

func_10EE4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
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
  var_0 = getaiunittypearray("all", "all");
  foreach(var_2 in var_0) {
    var_2 func_623D(0);
  }

  foreach(var_5 in level.players) {
    var_5.maxvisibledist = 8192;
    if(var_5 scripts\sp\utility::func_65DF("stealth_enabled")) {
      var_5 scripts\sp\utility::func_65DD("stealth_enabled");
    }
  }

  lib_0F23::func_6806("spotted");
}

func_623F() {
  scripts\engine\utility::flag_set("stealth_enabled");
  var_0 = getaiunittypearray("all", "all");
  foreach(var_2 in var_0) {
    var_2 func_623D(1);
  }

  foreach(var_5 in level.players) {
    if(var_5 scripts\sp\utility::func_65DF("stealth_enabled")) {
      var_5 scripts\sp\utility::func_65E1("stealth_enabled");
    }
  }
}

func_623D(var_0) {
  if(!var_0) {
    self.maxvisibledist = 8192;
    if(scripts\sp\utility::func_65DF("stealth_enabled") && scripts\sp\utility::func_65DB("stealth_enabled") && self.team == "axis") {
      var_1 = spawnStruct();
      var_1.origin = level.player.origin;
      var_1.var_9B20 = level.player.origin;
      lib_0F1B::func_6808(var_1);
    }
  }

  if(scripts\sp\utility::func_65DF("stealth_enabled")) {
    if(var_0) {
      scripts\sp\utility::func_65E1("stealth_enabled");
      return;
    }

    scripts\sp\utility::func_65DD("stealth_enabled");
  }
}

func_4C75(var_0) {
  if(isDefined(var_0["spotted"])) {
    self.var_10F04["spotted"] = var_0["spotted"];
  }

  if(isDefined(var_0["hidden"])) {
    self.var_10F04["hidden"] = var_0["hidden"];
  }
}

func_F5B4(var_0, var_1) {
  self.var_10E6D.var_74D5[var_0] = var_1;
}

func_57D8() {
  self endon("death");
  scripts\sp\utility::func_57D5();
}

func_8693() {
  self endon("death");
  var_0 = self.var_EED1;
  if(isDefined(var_0)) {
    var_1 = func_79F5(var_0);
    if(isDefined(var_1) && var_1.size) {
      foreach(var_3 in var_1) {
        var_4 = var_3 func_7B71();
        if(var_3 != self && isDefined(var_4) && var_4 == "seek") {
          return 1;
        }
      }
    }
  }

  return 0;
}

func_CD58(var_0, var_1) {
  func_10EE4(1);
  func_F4C8("seek", 1, var_0);
  var_2 = var_0 - self.origin;
  var_2 = vectornormalize((var_2[0], var_2[1], 0));
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
  var_11 = isDefined(self.var_1FBB) && isDefined(level.var_EC85[self.var_1FBB]) && isDefined(level.var_EC85[self.var_1FBB][var_1]);
  if(!var_11 || distance2dsquared(var_3.origin, var_5) > 0.1) {
    scripts\sp\utility::func_F3DC(var_5);
    self.objective_playermask_showto = 8;
    var_6 = scripts\engine\utility::waittill_any_return("goal", "bad_path");
    var_11 = 0;
  } else {
    var_7 = getstartorigin(var_3.origin, var_3.angles, level.var_EC85[self.var_1FBB][var_1]);
    var_8 = getclosestpointonnavmesh(var_7, self);
    if(distance2dsquared(var_7, var_8) > 0.1) {
      var_11 = 0;
    } else {
      var_9 = var_7 + rotatevector(getmovedelta(level.var_EC85[self.var_1FBB][var_1], 0, 1), var_3.angles);
      var_10 = getclosestpointonnavmesh(var_9, self);
      if(distance2dsquared(var_9, var_10) > 0.1) {
        var_11 = 0;
      } else {
        if(distance2dsquared(var_0, self.origin) < squared(100)) {
          self.var_10E6D.var_C994 = 1;
        }

        var_3 scripts\sp\anim::func_1ECE(self, var_1);
      }
    }
  }

  if(var_6 == "goal" && var_11) {
    var_3 scripts\sp\anim::func_1F35(self, var_1);
    var_12 = getclosestpointonnavmesh(self.origin, self);
    if(distance2dsquared(self.origin, var_12) > 0.0001) {
      self func_80F1(var_12, self.angles);
    }

    scripts\sp\utility::func_F3DC(self.origin);
  }
}

func_F397(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level.var_10E6D) && isDefined(level.var_10E6D.var_74D5)) {
    level.var_10E6D.var_74D5["event_" + var_0] = var_1;
  }
}