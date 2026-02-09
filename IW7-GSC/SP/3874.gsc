/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3874.gsc
*********************************************/

func_9B1E(var_0, var_1) {
  self endon("death");
  if(isDefined(var_0)) {
    var_0 endon("death");
  }

  self notify("investigate_forget");
  self endon("investigate_forget");
  if(!isDefined(var_1)) {
    var_1 = randomfloatrange(30, 45);
  }

  wait(var_1);
  for(var_2 = 0; var_2 < 10; var_2 = var_2 + var_3) {
    if(scripts\asm\asm::asm_isinstate("patrol_move")) {
      if(isDefined(self.a.var_C98E) && gettime() - self.a.var_C98E >= 1500) {
        self func_84F7("reset", self, self.origin);
        return;
      }
    }

    var_3 = 0.2;
    wait(var_3);
  }

  self func_84F7("reset", self, self.origin);
}

func_9B28(var_0) {
  self.var_10E6D.var_9B1F = var_0;
  if(scripts\engine\utility::istrue(var_0)) {
    self.var_10E6D.var_C985 = undefined;
    return;
  }

  self.var_10E6D.var_C985 = gettime() + randomfloatrange(20, 55);
}

func_9B26(var_0) {
  if(isDefined(self.var_10E6D.beginusegas) && self.var_10E6D.beginusegas == "investigate") {
    var_1 = getclosestpointonnavmesh(var_0.var_9B22, self);
    var_2 = 300;
    var_3 = 1000;
    var_4 = 1;
    thread func_9B1E();
    if(isDefined(self.var_10E6D.var_9B20)) {
      var_5 = vectornormalize(self.objective_playermask_hidefromall - self.origin);
      var_6 = anglesToForward(self.angles);
      var_7 = vectornormalize(var_1 - self.origin);
      if(isPlayer(var_0.issplitscreen) && !isPlayer(self.var_10E6D.var_9B1D)) {
        var_4 = 1;
      } else if(vectordot(var_5, var_7) < 0 && vectordot(var_6, var_7) < 0) {
        var_4 = 1;
      } else if(var_0.var_12AE9 == "saw_corpse") {
        var_4 = 1;
      } else if(var_4 && distancesquared(self.objective_playermask_hidefromall, var_1) < squared(var_2)) {
        var_4 = 0;
      }
    }

    if(var_4) {
      func_F076();
      var_8 = func_F079(var_1, 1, 0, 200);
      if(isDefined(var_8) && var_8.size) {
        if(var_0.var_12AE9 == "saw_corpse") {
          var_8[0].origin = var_0.var_9B22;
        }

        self.var_10E6D.var_9B20 = var_8[0];
        func_F075(var_8);
        self.var_10E6D.var_DD1D = 0;
        func_9B28(1);
      }

      self.var_10E6D.var_9B21 = func_7C3B(var_1, var_2, var_3);
      self notify("stop_runto_and_lookaround");
    }
  }

  return self.var_10E6D.var_9B20;
}

func_9B25() {
  self.var_10E6D.var_9B20 = undefined;
  self.var_10E6D.var_9B21 = undefined;
  self.var_10E6D.var_9B29 = undefined;
  self.var_10E6D.var_9B1D = undefined;
  func_9B28(undefined);
  self notify("investigate_behavior");
}

func_9B2C() {
  if(!isDefined(self.var_10E6D)) {
    return 0;
  }

  return scripts\engine\utility::istrue(self.var_10E6D.var_9B1F);
}

func_9B2B(var_0) {
  if(isPlayer(self.var_10E6D.var_9B1D) && !isPlayer(var_0.issplitscreen)) {
    return 1;
  }

  if(isDefined(self.var_10E6D.var_9B29)) {
    var_1 = lib_0F1C::func_6894(self.var_10E6D.var_9B29, var_0.type);
    if(var_1 >= 0) {
      func_9B26(var_0);
      lib_0F27::func_F4C6("seek", "seek", var_0.var_9B22);
      self.var_10E6D.var_9B29 = var_0.type;
      self.var_10E6D.var_9B1D = var_0.issplitscreen;
      return 1;
    }
  }

  return 0;
}

func_9B24(var_0) {
  func_9B25();
  func_9B23(var_0);
}

func_9B23(var_0) {
  self endon("death");
  self endon("stealth_spotted");
  if(func_9B2B(var_0)) {
    return;
  }

  self notify("investigate_behavior");
  self endon("investigate_behavior");
  self.var_10E6D.var_9B29 = var_0.type;
  self.var_10E6D.var_9B1D = var_0.issplitscreen;
  lib_0F27::func_EB62();
  self.var_EDB0 = 0;
  thread lib_0F19::func_467C();
  self.var_10E6D.beginusegas = "investigate";
  self.var_10E6D.var_9B27 = undefined;
  lib_0F26::func_117D4("investigate");
  var_1 = func_9B26(var_0);
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.origin;
  lib_0F27::func_10EE4(1);
  if(self.var_10E6D.state > 1) {
    lib_0F27::func_F4C8("seek", 1, var_2);
  }

  wait(randomfloatrange(0.2, 0.4));
  if(!scripts\sp\utility::func_65DB("stealth_enabled")) {
    return;
  }

  func_9B28(1);
  self.objective_playermask_showto = 2048;
  var_3 = 300;
  for(;;) {
    while(self.var_10E6D.var_9B1F || self.var_10E6D.var_9B21.size <= 0) {
      var_4 = !self.var_10E6D.var_DD1D && distancesquared(self.var_10E6D.var_9B20.origin, self.origin) > squared(512);
      var_5 = func_E8A7(self.var_10E6D.var_9B20.origin, var_4);
      if(!self.var_10E6D.var_DD1D) {
        self.var_10E6D.var_DD1D = isDefined(var_5) && var_5 != "bad_path";
      }

      if(isDefined(var_5) && var_5 == "bad_path") {
        func_9B28(0);
      } else {
        func_9B28(!self.var_10E6D.var_DD1D);
      }

      if(scripts\engine\utility::istrue(self.var_10E6D.var_F077)) {
        self waittill("got_search_points");
      }

      if(self.var_10E6D.var_9B21.size <= 0) {
        func_9B25();
        return;
      }
    }

    var_6 = func_7B1A();
    if(!isDefined(var_6)) {
      var_6 = func_7A7E(self.var_10E6D.var_9B21, var_3);
    }

    if(!isDefined(var_6)) {
      self.var_10E6D.var_9B21 = func_7C3B(var_2, 300, 1000);
      var_6 = func_7A7E(self.var_10E6D.var_9B21, var_3);
    }

    if(!isDefined(var_6)) {
      self func_84F7("reset", self, self.origin);
      return;
    }

    if(isnode(var_6)) {} else {
      var_6.origin = scripts\engine\utility::drop_to_ground(var_6.origin, 8);
    }

    var_4 = !self.var_10E6D.var_DD1D && distancesquared(var_6.origin, self.origin) > squared(512);
    var_5 = func_E8A7(var_6.origin, var_4);
    if(!self.var_10E6D.var_DD1D) {
      self.var_10E6D.var_DD1D = isDefined(var_5) && var_5 != "bad_path";
    }
  }
}

func_7B1A() {
  if(isDefined(self.var_10E6D.var_9B27) && isDefined(self.var_10E6D.var_9B27.target)) {
    var_0 = getnode(self.var_10E6D.var_9B27.target, "targetname");
    if(isDefined(var_0) && distancesquared(var_0.origin, self.origin) > squared(100)) {
      var_0.var_13070 = gettime();
      return var_0;
    }

    var_0 = scripts\engine\utility::getstruct(self.var_10E6D.var_9B27.target, "targetname");
    if(isDefined(var_0) && distancesquared(var_0.origin, self.origin) > squared(100)) {
      var_0.var_13070 = gettime();
      return var_0;
    }
  }

  return undefined;
}

func_7A7E(var_0, var_1) {
  self.var_10E6D.var_9B27 = undefined;
  foreach(var_3 in var_0) {
    if(!isDefined(var_3.var_13070)) {
      var_3.var_13070 = 0;
    }
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_5 = undefined;
  foreach(var_3 in var_0) {
    if(distancesquared(var_3.origin, self.origin) < squared(100)) {
      continue;
    }

    if(!isDefined(var_5)) {
      var_5 = var_3;
      continue;
    }

    if(isDefined(var_5) && var_3.var_13070 < var_5.var_13070) {
      var_5 = var_3;
    }
  }

  if(isDefined(var_5)) {
    var_5.var_13070 = gettime();
    if(isDefined(var_5.var_336) && var_5.var_336 == "seek_patrol") {
      self.var_10E6D.var_9B27 = var_5;
    }
  }

  return var_5;
}

func_F07B(var_0) {
  var_1 = squared(100);
  if(!isDefined(level.var_10E6D.var_F074)) {
    level.var_10E6D.var_F074 = [];
  }

  foreach(var_3 in level.var_10E6D.var_F074) {
    if(isalive(var_3.var_10EF6) && var_3.var_10EF6 != self) {
      var_4 = distancesquared(var_3.origin, var_0);
      if(var_4 < var_1) {
        return 1;
      }
    }
  }

  return 0;
}

func_F076() {
  if(!isDefined(level.var_10E6D.var_F074)) {
    return;
  }

  var_0 = [];
  foreach(var_2 in level.var_10E6D.var_F074) {
    if(isalive(var_2.var_10EF6)) {
      if(var_2.var_10EF6 != self) {
        var_0[var_0.size] = var_2;
        continue;
      }

      var_2.var_10EF6 = undefined;
    }
  }

  level.var_10E6D.var_F074 = var_0;
}

func_F075(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(level.var_10E6D)) {
    return;
  }

  if(!isarray(var_0)) {
    var_1 = [var_0];
    var_0 = var_1;
  }

  if(!isDefined(level.var_10E6D.var_F074)) {
    level.var_10E6D.var_F074 = [];
  }

  level.var_10E6D.var_F074 = scripts\engine\utility::array_combine(level.var_10E6D.var_F074, var_0);
}

func_F079(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  thread func_F07A(var_0, var_1, var_2, var_3);
  self waittill("search_points_random_near_complete");
  if(isDefined(self.var_10E6D.var_F078)) {
    var_4 = self.var_10E6D.var_F078;
  }

  self.var_10E6D.var_F078 = undefined;
  return var_4;
}

func_F07A(var_0, var_1, var_2, var_3) {
  self notify("search_points_random_near_thread");
  self endon("search_points_random_near_thread");
  self endon("death");
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 1000;
  }

  var_4 = squared(var_3);
  var_5 = squared(var_2);
  var_6 = [];
  if(!isDefined(level.var_10E6D.var_F07C)) {
    level.var_10E6D.var_F07C = [];
  }

  level.var_10E6D.var_F07C = scripts\sp\utility::func_DFEB(level.var_10E6D.var_F07C);
  if(!scripts\engine\utility::array_contains(level.var_10E6D.var_F07C, self)) {
    level.var_10E6D.var_F07C[level.var_10E6D.var_F07C.size] = self;
  }

  wait(0.05);
  while(level.var_10E6D.var_F07C.size > 0 && level.var_10E6D.var_F07C[0] != self) {
    wait(0.05);
  }

  var_7 = getrandomnavpoints(var_0, var_3, 64, self);
  if(isDefined(var_7)) {
    foreach(var_9 in var_7) {
      var_10 = distancesquared(var_9, var_0);
      if(var_10 < var_5) {
        continue;
      }

      if(func_F07B(var_9)) {
        continue;
      }

      var_11 = spawnStruct();
      var_11.origin = var_9;
      var_11.var_10EF6 = self;
      var_6[var_6.size] = var_11;
      if(var_6.size >= var_1) {
        break;
      }
    }
  }

  level.var_10E6D.var_F07C = scripts\engine\utility::array_remove(level.var_10E6D.var_F07C, self);
  self.var_10E6D.var_F078 = var_6;
  self notify("search_points_random_near_complete");
}

func_7C3B(var_0, var_1, var_2) {
  var_3 = 3;
  self.var_10E6D.var_F077 = 1;
  var_0 = getclosestpointonnavmesh(var_0, self);
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 1000;
  }

  var_4 = squared(var_2);
  var_5 = squared(var_1);
  var_6 = [];
  var_7 = [];
  var_8 = getnodearray("seek_patrol", "targetname");
  var_6 = scripts\engine\utility::array_combine(var_8, var_6);
  var_8 = scripts\engine\utility::getstructarray("seek_patrol", "targetname");
  var_6 = scripts\engine\utility::array_combine(var_8, var_6);
  var_6 = sortbydistance(var_6, var_0);
  foreach(var_10 in var_6) {
    if(isalive(var_10.var_10EF6) && var_10.var_10EF6 != self) {
      continue;
    }

    var_11 = distancesquared(var_10.origin, var_0);
    if(var_11 < var_5) {
      continue;
    }

    if(var_11 > var_4) {
      break;
    }

    var_7[var_7.size] = var_10;
    var_10.var_10EF6 = self;
  }

  if(var_7.size < var_3) {
    var_13 = func_F079(var_0, var_3 - var_7.size, var_1, var_2);
    if(isDefined(var_13) && var_13.size) {
      var_7 = scripts\engine\utility::array_combine(var_7, var_13);
    }
  }

  func_F075(var_7);
  self.var_10E6D.var_F077 = undefined;
  self notify("got_search_points");
  return var_7;
}

func_E8A7(var_0, var_1) {
  self notify("stop_runto_and_lookaround");
  self endon("stop_runto_and_lookaround");
  self endon("death");
  var_2 = lib_0F27::func_79F6("stealth_spotted");
  level endon(var_2);
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self.var_10E6D.var_4684 = undefined;
  lib_0F27::func_10EE4(1);
  lib_0F27::func_F4C8("seek", 1, var_0);
  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  if(var_1) {
    lib_0F27::func_F4C8("run");
    self.objective_playermask_showto = 256;
  } else {
    lib_0F27::func_F4C8("seek");
    self.objective_playermask_showto = 100;
  }

  scripts\sp\utility::func_F3DC(var_0);
  var_3 = scripts\engine\utility::waittill_any_return("goal", "bad_path");
  self.var_10E6D.var_9B1D = undefined;
  lib_0F27::func_F4C8("seek");
  self.objective_playermask_showto = 100;
  if(var_3 == "goal") {
    func_B001(randomfloatrange(5, 8));
  }

  return var_3;
}

func_B001(var_0) {
  wait(var_0);
  scripts\sp\utility::func_4154();
}