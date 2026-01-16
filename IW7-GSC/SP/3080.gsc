/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3080.gsc
*********************************************/

func_7FD3() {
  if(isDefined(self.var_10AB7) && self.var_10AB7) {
    return "sprint";
  }

  if(isDefined(self.var_527B)) {
    return self.var_527B;
  }

  return scripts\aitypes\bt_util::func_75();
}

func_12E90(var_0) {
  if(!isalive(self)) {
    return level.failure;
  }

  scripts\asm\asm_bb::bb_requestmovetype(func_7FD3());
  return level.success;
}

func_9D5B(var_0) {
  if(self.var_290A) {
    return level.success;
  }

  return level.failure;
}

func_3596() {
  return ["left", "right"];
}

func_351D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self.bt.var_13C83[var_0] = var_1;
}

func_357A() {
  var_0 = [];
  var_1 = func_3596();
  foreach(var_3 in var_1) {
    if(func_8C3C(var_3)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

func_357C() {
  var_0 = [];
  var_1 = func_3596();
  foreach(var_3 in var_1) {
    if(func_8C3C(var_3) && func_9F5B(var_3)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

func_357D() {
  var_0 = [];
  var_1 = func_3596();
  foreach(var_3 in var_1) {
    if(func_8C3C(var_3) && func_9F5B(var_3)) {
      var_4 = self._blackboard.shootparams.var_13CC3[var_3];
      if(isDefined(var_4) && isDefined(var_4.var_3124) && var_4.var_3124 && isDefined(var_4.var_2AB9) && var_4.var_2AB9) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

func_8C3C(var_0) {
  return isDefined(self.var_13CC3[var_0]);
}

func_9F5B(var_0) {
  if(!self.bt.var_13C83[var_0]) {
    return 0;
  }

  return self.var_13C83[var_0];
}

func_B2AB(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.state = 0;
  var_2.var_1158D = var_1;
  if(self.var_13CC3[var_0] == "minigun") {
    var_2.var_71A2 = ::func_FEE5;
    var_2.var_DCE8 = 100;
  } else {
    var_2.var_71A2 = ::func_FEE9;
    var_2.var_DCE8 = 250;
    if(!isDefined(var_2.var_C241)) {
      var_2.var_C241 = randomintrange(1, 3);
    }
  }

  var_2.var_29A9 = 1;
  var_2.var_29A1 = 1;
  var_2.var_3124 = 1;
  var_2.var_2AB9 = 1;
  var_2.var_312A = 1;
  var_2.var_3139 = 0;
  return var_2;
}

func_97EB(var_0) {
  var_1 = spawnStruct();
  var_1.var_11590 = [];
  var_2 = func_357A();
  foreach(var_4 in var_2) {
    var_5 = func_B2AB(var_4, undefined);
    var_1.var_13CC3[var_4] = var_5;
  }

  var_1.var_A98F = gettime();
  var_1.var_A993 = gettime();
  self._blackboard.shootparams = var_1;
  self.setthermalbodymaterial = 1024;
  if(!isDefined(self.bt.lasttimefired)) {
    self.bt.lasttimefired = 0;
  }

  return level.success;
}

func_40E9(var_0) {
  if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.var_13CC3) && !isDefined(self.var_EF6D)) {
    var_1 = func_3596();
    foreach(var_3 in var_1) {
      self._blackboard.shootparams.var_13CC3[var_3] = undefined;
    }

    self._blackboard.shootparams = undefined;
  }

  return level.success;
}

func_12E77(var_0) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    self.bt.lasttimefired = gettime();
  }

  return level.success;
}

func_FB1E(var_0, var_1) {
  if(!isDefined(self._blackboard.shootparams)) {
    return level.failure;
  }

  self._blackboard.shootparams.var_12F1C = var_1;
  return level.success;
}

func_7E30(var_0) {
  if(!isDefined(self._blackboard.shootparams)) {
    return undefined;
  }

  var_1 = gettime();
  var_2 = undefined;
  var_3 = 999999999;
  foreach(var_5 in func_357A()) {
    var_6 = self._blackboard.shootparams.var_13CC3[var_5];
    if(isDefined(var_6.ent)) {
      if(var_6.var_3124 || isDefined(var_0) && var_1 - var_6.var_A9AB <= var_0) {
        var_7 = distancesquared(self.origin, var_6.ent.origin);
        if(var_7 < var_3) {
          var_3 = var_7;
          var_2 = var_6.ent;
        }
      }

      continue;
    }

    if(isDefined(var_6.var_EF76) && var_6.var_EF76.size > 0) {
      foreach(var_9 in var_6.var_EF76) {
        if(isDefined(var_9)) {
          var_7 = distancesquared(self.origin, var_9.origin);
          if(var_7 < var_3) {
            var_3 = var_7;
            var_2 = var_9;
          }
        }
      }
    }
  }

  return var_2;
}

func_FE5F(var_0, var_1) {
  self[[var_0.var_71A2]](var_0, var_1);
}

canseetarget(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1.var_13CC3[var_0];
  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = undefined;
  if(isDefined(var_2.var_EF76) && var_2.var_EF76.size > 0) {
    var_3 = var_2.var_EF76[0];
  } else if(isDefined(var_2.ent)) {
    var_3 = var_2.ent;
  }

  if(isDefined(var_3)) {
    return self cansee(var_3);
  }

  return 1;
}

func_8C27(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 1;
  }

  var_2 = self._blackboard.shootparams;
  var_3 = var_2.var_13CC3[var_0];
  if(!isDefined(var_3)) {
    return 0;
  }

  var_4 = undefined;
  if(self.var_13CC3[var_0] == "minigun") {
    var_4 = lib_0C41::func_3587(var_0);
  } else if(self.var_13CC3[var_0] == "rocket") {
    var_4 = lib_0C41::func_3593(var_0, "top");
  }

  var_5 = 256;
  var_6 = var_1 - var_4;
  var_7 = length(var_6);
  if(var_7 > var_5) {
    var_8 = var_4 + var_6 / var_7 * 256;
  } else {
    var_8 = var_2;
  }

  return sighttracepassed(var_4, var_8, 0, self);
}

func_8BEC(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.ent) && !isDefined(var_0.var_EF76) && !isDefined(var_0.pos)) {
    return 0;
  }

  return 1;
}

shouldshoot(var_0) {
  if(isDefined(self.dontevershoot)) {
    return level.failure;
  }

  if(!isDefined(self.enemy)) {
    return level.failure;
  }

  return level.success;
}

func_FE7B(var_0, var_1) {
  var_2 = self._blackboard.shootparams;
  if(!isDefined(var_2.var_13CC3[var_0])) {
    return;
  }

  if(!isDefined(var_1) || !isDefined(var_2.var_13CC3[var_0].ent) || var_2.var_13CC3[var_0].ent != var_1) {
    var_3 = func_B2AB(var_0, var_2.var_13CC3[var_0].var_1158D);
    var_2.var_13CC3[var_0].state = -1;
    var_3.var_C249 = var_2.var_13CC3[var_0].var_C249;
    var_2.var_13CC3[var_0] = var_3;
    var_4 = gettime();
    var_3.var_656E = var_4;
    if(isDefined(var_1)) {
      var_3.lastenemypos = var_1.origin;
      var_3.var_A97D = var_4;
    }
  }

  var_5 = var_2.var_13CC3[var_0];
  var_5.ent = var_1;
}

func_FE8B(var_0) {
  var_1 = func_3596();
  var_2 = undefined;
  foreach(var_4 in var_1) {
    if(self._blackboard.shootparams.var_13CC3[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  var_6 = gettime();
  if(isDefined(var_0.ent)) {
    var_0.var_29A1 = self cansee(var_0.ent);
    var_0.var_3124 = self seerecently(var_0.ent, 1);
    if(issentient(var_0.ent)) {
      var_0.var_A9AB = self lastknowntime(var_0.ent);
    } else {
      var_0.var_A9AB = var_6;
    }

    var_7 = 1024;
    var_8 = 500;
    if(var_6 > var_0.var_A97D + var_8) {
      if(distancesquared(var_0.ent.origin, var_0.lastenemypos) > var_7) {
        var_0.var_3139 = 0;
      } else {
        var_0.var_3139 = 1;
      }

      var_0.lastenemypos = var_0.ent.origin;
      var_0.var_A97D = var_6;
    }
  } else {
    var_0.var_29A1 = 1;
    var_0.var_3124 = 1;
    var_0.var_A9AB = var_6;
  }

  var_9 = self.var_13CC3[var_2] == "rocket";
  var_0.var_1A46 = func_FE67(var_0, var_9);
  var_0.var_1A47 = var_6;
  var_0.var_312A = var_0.var_3124;
  var_0.var_2AB9 = func_8C27(var_2, var_0.var_1A46);
}

func_FE8C(var_0) {
  var_1 = self._blackboard.shootparams;
  if(isDefined(self.var_7212) && gettime() < self.var_7212) {
    if(func_9F5B("left")) {
      var_2 = level.player;
    } else {
      var_2 = undefined;
    }

    if(func_9F5B("right")) {
      var_3 = level.player;
    } else {
      var_3 = undefined;
    }
  } else {
    var_2 = self.enemy;
    var_3 = self.enemy;
    if(self.var_27F7) {
      if(func_8C3C("left") && func_9F5B("left") && func_8C3C("right") && func_9F5B("right")) {
        var_4 = self func_848B();
        if(isDefined(var_4) && var_4.size > 0) {
          var_5 = var_4[0];
          var_6 = self.enemy.origin - self.origin;
          var_7 = var_5.origin - self.origin;
          var_8 = vectornormalize(var_7);
          var_9 = self.enemy.origin + var_5.origin * 0.5;
          var_10 = vectornormalize(var_9 - self.origin);
          var_11 = vectortoangles(var_10);
          var_12 = anglesToForward(self.angles);
          if(vectordot(var_10, var_12) > 0) {
            var_13 = anglestoright(var_11);
            if(vectordot(var_8, var_10) > 0) {
              var_14 = vectordot(var_13, var_6);
              var_15 = vectordot(var_13, var_7);
              if(var_15 > var_14) {
                var_3 = var_5;
              } else {
                var_2 = var_5;
              }
            }
          }
        }
      }
    }

    if(!func_9F5B("left")) {
      var_2 = undefined;
    } else if(isDefined(var_1.var_13CC3["left"]) && isDefined(var_1.var_13CC3["left"].var_313A) && isDefined(var_1.var_13CC3["left"].ent)) {
      var_2 = var_1.var_13CC3["left"].ent;
    }

    if(!func_9F5B("right")) {
      var_3 = undefined;
    } else if(isDefined(var_1.var_13CC3["right"]) && isDefined(var_1.var_13CC3["right"].var_313A) && isDefined(var_1.var_13CC3["right"].ent)) {
      var_3 = var_1.var_13CC3["right"].ent;
    }
  }

  func_FE7B("left", var_2);
  func_FE7B("right", var_3);
  func_FE8B(var_1.var_13CC3["left"]);
  func_FE8B(var_1.var_13CC3["right"]);
  return level.success;
}

func_FE7A(var_0) {
  if(isDefined(var_0)) {
    self._blackboard.shootparams.var_BFB6 = var_0;
    return;
  }

  self._blackboard.shootparams.var_BFB6 = gettime() + randomintrange(1000, 1500);
}

func_3873(var_0) {
  setdvarifuninitialized("enable_c12_berserk", 0);
  if(!getdvarint("enable_c12_berserk")) {
    return 0;
  }

  if(!isDefined(var_0.ent)) {
    return 0;
  }

  var_1 = self._blackboard.shootparams;
  var_2 = ["left", "right"];
  var_3 = undefined;
  foreach(var_5 in var_2) {
    if(var_1.var_13CC3[var_5] == var_0) {
      if(self.var_13CC3[var_5] != "minigun") {
        return 0;
      }

      var_3 = var_5;
      break;
    }
  }

  var_7 = "left";
  if(var_7 == var_3) {
    var_7 = "right";
  }

  if(!scripts\asm\asm_bb::ispartdismembered(var_7 + "_arm")) {
    return 0;
  }

  var_8 = gettime();
  if(!isDefined(var_1.var_BF71)) {
    var_1.var_BF71 = var_8;
  }

  return var_8 >= var_1.var_BF71;
}

func_FE79() {
  var_0 = self._blackboard.shootparams;
  if(isDefined(var_0)) {
    var_0.var_BF71 = gettime() + randomintrange(10000, 20000);
  }
}

func_FE78(var_0) {
  var_0.var_2763 = gettime() + 2000;
}

func_FE63() {
  var_0 = func_357A();
  foreach(var_2 in var_0) {
    if(self.var_13CC3[var_2] == "minigun") {
      return var_2;
    }
  }

  return undefined;
}

func_FE65() {
  var_0 = func_357A();
  foreach(var_2 in var_0) {
    if(self.var_13CC3[var_2] == "rocket") {
      return var_2;
    }
  }

  return undefined;
}

func_FE68(var_0) {
  if(isDefined(var_0.unittype) && var_0.unittype == "c12") {
    return 1000;
  }

  if(scripts\sp\vehicle::func_9FEF(var_0)) {
    return 500;
  }

  return 10;
}

func_FE62() {
  var_0 = self._blackboard.shootparams;
  var_1 = 0;
  var_2 = undefined;
  var_3 = func_357C();
  foreach(var_5 in var_3) {
    var_6 = var_0.var_13CC3[var_5];
    if(isDefined(var_6) && isDefined(var_6.ent)) {
      var_7 = func_FE68(var_6.ent);
      if(var_7 > var_1) {
        var_2 = var_5;
        var_1 = var_7;
      }
    }
  }

  return var_2;
}

func_41EC(var_0) {
  return level.failure;
}

func_FE8E(var_0) {
  func_FE8C(var_0);
  var_1 = func_FE8D(var_0);
  func_FE8A(var_1);
  return level.success;
}

func_FE8D(var_0) {
  var_1 = self._blackboard.shootparams;
  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return func_FE63();
  }

  if(isDefined(var_1.var_1675) && func_9F5B(var_1.var_1675)) {
    var_2 = var_1.var_13CC3[var_1.var_1675];
    if(var_2.state != 0) {
      return var_1.var_1675;
    }
  }

  var_3 = func_357D();
  if(var_3.size == 0) {
    return undefined;
  }

  var_4 = var_3;
  foreach(var_6 in var_3) {
    var_2 = var_1.var_13CC3[var_6];
    if(self.var_13CC3[var_6] == "rocket") {
      var_7 = var_2.ent;
      if(isDefined(var_7)) {
        if(distancesquared(var_7.origin, self.origin) < -25536) {
          var_4 = scripts\engine\utility::array_remove(var_4, var_6);
        } else if(!var_2.var_3139) {
          var_4 = scripts\engine\utility::array_remove(var_4, var_6);
        }
      }

      continue;
    }

    if(isDefined(var_1.var_1675) && var_1.var_1675 == var_6) {
      if(var_2.var_3124 && var_1.var_C24A >= 3) {
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
      }
    }
  }

  if(var_4.size == 0) {
    var_3 = func_357D();
    if(var_3.size > 0) {
      return var_3[randomint(var_3.size)];
    }

    return;
  }

  if(var_4.size == 1) {
    return var_4[0];
  }

  return var_4[randomint(var_4.size)];
}

func_FE8A(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = func_357A();
  foreach(var_4 in var_2) {
    if(!func_9F5B(var_4) && isDefined(var_1.var_13CC3[var_4])) {
      func_FE5F(var_1.var_13CC3[var_4], 0);
    }
  }

  if(!isDefined(var_1.var_1675)) {
    func_FE7A(gettime());
  }

  var_6 = isDefined(var_0);
  if(var_6 && isDefined(var_1.var_1675) && var_0 == var_1.var_1675) {
    if(var_1.var_13CC3[var_0].var_29A9 && !var_1.var_13CC3[var_0].var_29A1) {
      func_FE5F(var_1.var_13CC3[var_0], 0);
    } else {
      if(var_1.var_13CC3[var_0].state == 0) {
        if(!isDefined(var_1.var_BFB6)) {
          func_FE7A();
        }

        if(gettime() > var_1.var_BFB6) {
          var_1.var_BFB6 = undefined;
          var_1.var_C24A++;
          func_FE5F(var_1.var_13CC3[var_0], 1);
        }
      }

      return;
    }
  }

  var_2 = func_357A();
  foreach(var_8 in var_2) {
    if(!var_6 || var_8 != var_0) {
      var_9 = var_1.var_13CC3[var_8];
      func_FE5F(var_9, 0);
    }
  }

  var_1.var_1675 = var_0;
  var_1.var_C24A = 0;
  if(var_6 && var_1.var_13CC3[var_0].var_29A1) {
    if(!isDefined(var_1.var_BFB6)) {
      func_FE7A();
    }

    if(gettime() > var_1.var_BFB6) {
      var_9 = var_1.var_13CC3[var_0];
      var_1.var_C24A = 1;
      var_1.var_BFB6 = undefined;
      func_FE5F(var_9, 1);
    }
  }
}

func_10079(var_0) {
  var_1 = self._blackboard.shootparams.var_13CC3[var_0];
  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1.state == 2 || var_1.state == 3;
}

func_9F7B(var_0) {
  var_1 = self._blackboard.shootparams.var_13CC3[var_0];
  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1.state == 3;
}

func_1391C(var_0) {
  return var_0.state == 3;
}

func_A004(var_0) {
  var_1 = self._blackboard.shootparams.var_13CC3[var_0];
  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1.state == 4;
}

func_A005(var_0) {
  var_1 = self._blackboard.shootparams.var_12F1C;
  var_2 = self._blackboard.shootparams.var_13CC3[var_1];
  if(!isDefined(var_2)) {
    return level.failure;
  }

  if(var_2.state == 0) {
    return level.failure;
  }

  return level.success;
}

func_A006(var_0, var_1) {
  var_2 = self._blackboard.shootparams.var_12F1C;
  if(func_A007(var_2, var_1)) {
    return level.success;
  }

  return level.failure;
}

func_A007(var_0, var_1) {
  if(!func_8C3C(var_0)) {
    return 0;
  }

  if(self.var_13CC3[var_0] == var_1) {
    return 1;
  }

  return 0;
}

func_FE66(var_0) {
  if(!func_8C3C(var_0)) {
    return undefined;
  }

  var_1 = self._blackboard.shootparams;
  var_2 = var_1.var_13CC3[var_0];
  var_3 = self.var_13CC3[var_0] == "rocket";
  return func_FE67(var_2, var_3);
}

func_FE67(var_0, var_1) {
  if(var_0.state == 4) {
    return self.origin + anglesToForward(self.angles) * 192;
  }

  if(isDefined(var_0.var_E5E0)) {
    return var_0.var_E5E0;
  }

  if(isDefined(var_0.var_EF76)) {
    var_2 = (0, 0, 0);
    var_3 = 0;
    foreach(var_7, var_5 in var_0.var_EF76) {
      if(isDefined(var_5)) {
        if(var_1) {
          var_6 = var_5.origin;
        } else {
          var_6 = var_7 getshootatpos();
        }

        var_2 = var_2 + var_6;
        var_3++;
      }
    }

    if(var_3 == 0) {
      return undefined;
    }

    var_8 = var_2 / var_3;
    return var_8 + func_FE69(var_0, var_8);
  }

  if(isDefined(var_7.ent)) {
    var_9 = func_3596();
    var_10 = undefined;
    foreach(var_12 in var_9) {
      if(self._blackboard.shootparams.var_13CC3[var_12] == var_7) {
        var_10 = var_12;
        break;
      }
    }

    if(self cansee(var_7.ent)) {
      if(var_8) {
        return var_7.ent.origin;
      }

      var_14 = var_7.ent getshootatpos();
      return var_14 + func_FE69(var_7, var_14);
    } else {
      var_14 = self lastknownpos(var_8.ent) + (0, 0, 60);
      return var_14 + func_FE69(var_7, var_14);
    }
  }

  if(isDefined(var_8.pos)) {
    return var_8.pos + func_FE69(var_8, var_8.pos);
  }

  return undefined;
}

func_FE69(var_0, var_1) {
  if(!func_1391C(var_0)) {
    return (0, 0, 0);
  }

  var_2 = gettime() - var_0.var_110D8 / 1000;
  var_3 = int(var_2 * 256);
  var_4 = var_3 % 256;
  if(var_4 > 128) {
    var_4 = 256 - var_4;
  }

  if(int(var_3 / 256) % 2) {
    var_4 = var_4 * -1;
  }

  return rotatevector((0, var_4, 0), vectortoangles(self.origin - var_1));
}

func_FEE6(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = self._blackboard.shootparams.var_12F1C;
  var_1.var_11590[var_0] = var_2;
  var_3 = var_1.var_13CC3[var_2];
  var_3.var_1158D = var_0;
  func_FEE5(var_3, 1);
}

func_FEE5(var_0, var_1) {
  var_2 = -999;
  var_3 = var_0.state;
  if(!isDefined(var_3)) {
    var_3 = var_2;
  }

  if(var_3 == var_1) {
    return;
  }

  var_0.state = var_1;
  switch (var_1) {
    case 0:
      break;

    case 1:
      if(var_3 == 0) {
        var_0.var_DCE8 = 100;
        var_0.var_C21B = randomintrange(2, 4);
        var_0.var_BF72 = gettime();
        var_0.var_927E = 0;
      } else if(var_3 == 2) {
        var_0.var_BF72 = gettime() + 1000;
      }

      func_FE78(var_0);
      break;

    case 2:
      var_0.var_927E++;
      var_0.var_32BC = gettime() + randomintrange(2000, 4000);
      scripts\sp\gameskill::func_F288();
      break;

    case 3:
      var_0.var_DCE8 = 33.33333;
      var_0.var_110D8 = gettime();
      var_0.var_32BC = gettime() + 12000;
      var_0.var_313A = 1;
      break;
  }
}

func_FEE3(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1.var_12F1C;
  var_3 = var_1.var_13CC3[var_2];
  if(!func_8BEC(var_3)) {
    func_FEE5(var_3, 0);
    return level.success;
  }

  var_4 = gettime();
  if(var_4 > var_1.var_A993 + 30000) {
    func_128AE(var_2, var_3);
  }

  switch (var_3.state) {
    case 1:
      if(!isDefined(var_3.var_2763)) {
        func_FE78(var_3);
      }

      if(var_4 > var_3.var_2763) {
        func_128AE(var_2, var_3);
        func_FEE5(var_3, 0);
        return level.failure;
      }

      if(var_4 >= var_3.var_BF72 && func_9EA0(var_2, var_3.var_1A46)) {
        var_5 = 1;
        if(var_3.var_29A9) {
          var_5 = canseetarget(var_2);
        }

        if(var_5) {
          if(isDefined(self.var_3131)) {
            func_FEE5(var_3, 3);
          } else {
            func_FEE5(var_3, 2);
          }
        }
      }
      break;

    case 2:
      if(var_4 >= var_3.var_32BC) {
        if(var_3.var_927E >= var_3.var_C21B) {
          func_FEE5(var_3, 0);
          func_FE7A();
          return level.success;
        } else {
          func_FEE5(var_3, 1);
        }
      }
      break;

    case 3:
      if(var_4 >= var_3.var_32BC) {
        func_FEE5(var_3, 0);
        func_FE7A();
        return level.success;
      }
      break;

    case 0:
      return level.failure;
  }

  return level.running;
}

func_FEE4(var_0) {
  var_1 = self._blackboard.shootparams;
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.var_11590[var_0];
  var_3 = var_1.var_13CC3[var_2];
  if(var_3.var_1158D == var_0) {
    func_FEE5(var_3, 0);
  }
}

func_FEE9(var_0, var_1) {
  var_2 = var_0.state;
  if(var_2 == var_1) {
    return;
  }

  var_0.state = var_1;
  if(var_1 == 1) {
    func_FE78(var_0);
  }

  if(var_1 == 2) {
    var_0.var_313A = 1;
    var_0.var_29A9 = 0;
    return;
  }

  var_0.var_313A = undefined;
  var_0.var_29A9 = 1;
}

func_FEEA(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1.var_12F1C;
  var_1.var_11590[var_0] = var_2;
  var_3 = var_1.var_13CC3[var_2];
  var_3.var_1158D = var_0;
  var_3.state = 1;
  if(isDefined(var_3.var_EF76)) {
    var_3.var_C241 = var_3.var_EF76.size;
  } else {
    var_3.var_C241 = randomintrange(1, 3);
  }

  var_3.var_DCE8 = 250;
  scripts\sp\gameskill::func_F288();
  func_FE78(var_3);
}

func_FEE7(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1.var_12F1C;
  var_3 = self._blackboard.shootparams.var_13CC3[var_2];
  if(scripts\asm\asm::asm_ephemeraleventfired("rocket_shoot_complete", var_2)) {
    func_FE7A();
    if(isDefined(var_3)) {
      var_3.var_2720 = undefined;
    }

    return level.success;
  }

  var_4 = var_3.var_1A46;
  if(!isDefined(var_4)) {
    return level.failure;
  }

  var_5 = gettime();
  if(var_5 > var_1.var_A993 + 30000) {
    func_128AE(var_2, var_3);
  }

  if(var_3.state == 1) {
    if(!isDefined(var_3.var_2763)) {
      func_FE78(var_3);
    }

    if(var_5 > var_3.var_2763) {
      func_128AE(var_2, var_3);
      func_FE5F(var_3, 0);
      return level.failure;
    }
  }

  if(var_3.state != 2) {
    if(distancesquared(self.origin, var_4) > 65536) {
      if(func_9F30(var_2, var_4)) {
        var_6 = 1;
        if(var_3.var_29A9) {
          var_6 = var_3.var_2AB9;
        }

        if(var_6) {
          func_FE5F(var_3, 2);
        }
      }
    }
  }

  return level.running;
}

func_FEE8(var_0) {
  var_1 = self._blackboard.shootparams;
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.var_11590[var_0];
  if(!isDefined(var_2)) {
    return;
  }

  var_3 = self._blackboard.shootparams.var_13CC3[var_2];
  if(var_3.var_1158D == var_0) {
    var_3.state = 0;
  }
}

func_9F30(var_0, var_1) {
  var_2 = lib_0C41::func_3593(var_0, "top");
  var_3 = lib_0C41::func_3592(var_0, "top");
  if(isDefined(self.var_E5C4)) {
    var_4 = anglesToForward(var_3);
    var_4 = rotatevector(var_4, (self.var_E5C4, 0, 0));
    var_3 = vectortoangles(var_4);
  }

  var_5 = 15;
  var_6 = func_9FFA(var_2, var_3, var_1, var_5);
  if(var_6) {
    return 1;
  }

  if(isDefined(self.var_E5C4)) {
    var_7 = lib_0C41::func_3628(var_0, "pitch", "min");
    var_8 = lib_0C41::func_3628(var_0, "pitch", "max");
    if(var_3[0] > var_7 - 3 || var_3[0] < var_8 + 3) {
      return 1;
    }
  }

  return 0;
}

func_9EA0(var_0, var_1) {
  var_2 = lib_0C41::func_3587(var_0);
  var_3 = lib_0C41::func_3585(var_0);
  var_4 = 15;
  return func_9FFA(var_2, var_3, var_1, var_4);
}

func_9FFA(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = cos(var_3);
  return vectordot(var_4, var_5) >= var_6;
}

func_8C23(var_0) {
  if(isDefined(self.var_EF6D)) {
    foreach(var_2 in self.var_EF6D) {
      var_3 = var_2.size;
      if(var_3 > 0) {
        for(var_4 = 0; var_4 < var_3; var_4++) {
          if(isDefined(var_2[var_4])) {
            return level.success;
          }
        }
      }
    }
  }

  return level.failure;
}

func_FE90(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = var_1.var_13CC3[var_0];
  func_FE8B(var_2);
  if(isDefined(var_1.var_BFB6)) {
    if(gettime() < var_1.var_BFB6) {
      return;
    }
  }

  var_3 = 1;
  if(isDefined(var_2.var_EF76)) {
    var_3 = !scripts\sp\utility::array_compare(self.var_EF6D[var_0], var_2.var_EF76);
  }

  if(var_3) {
    var_4 = var_2.var_1158D;
    var_2.state = -1;
    var_2 = func_B2AB(var_0, var_4);
    var_1.var_13CC3[var_0] = var_2;
  }

  var_2.var_EF76 = self.var_EF6D[var_0];
  var_2.var_EF77 = self.var_EF70[var_0];
  var_2.var_29A9 = self.var_EF6E[var_0];
  var_2.var_C241 = self.var_EF6D[var_0].size;
  if(!isDefined(var_2.var_656E)) {
    var_2.var_656E = gettime();
  }

  func_FE8B(var_2);
  if(var_2.state == 0) {
    func_FE5F(var_2, 1);
  }
}

func_FE8F(var_0) {
  var_1 = self._blackboard.shootparams;
  if(!isDefined(var_1)) {
    func_97EB(undefined);
    var_1 = self._blackboard.shootparams;
  }

  var_2 = func_357A();
  foreach(var_4 in var_2) {
    if(func_9F5B(var_4) && isDefined(self.var_EF6D[var_4])) {
      func_FE90(var_4);
      continue;
    }

    var_5 = self._blackboard.shootparams.var_13CC3[var_4];
    if(isDefined(var_5)) {
      func_FE5F(var_5, 0);
    }
  }

  return level.success;
}

func_F811(var_0) {
  var_1 = getrandomnavpoint(self.origin, 2048, self);
  self func_8481(var_1);
  self give_mp_super_weapon((0, 0, 0));
  return level.success;
}

func_1383A(var_0) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    return level.running;
  }

  self func_8484();
  return level.success;
}

func_3906(var_0) {
  var_1 = self._blackboard.shootparams;
  var_2 = func_357C();
  foreach(var_4 in var_2) {
    var_5 = var_1.var_13CC3[var_4];
    if(isDefined(var_5)) {
      if(isDefined(var_5.ent)) {
        if(self cansee(var_5.ent)) {
          return level.success;
        }

        continue;
      }

      if(isDefined(var_5.var_EF76)) {
        foreach(var_7 in var_5.var_EF76) {
          if(self cansee(var_7)) {
            return level.success;
          }
        }
      }
    }
  }

  return level.failure;
}

func_8C25(var_0, var_1) {
  var_2 = self._blackboard.shootparams;
  var_3 = func_357C();
  foreach(var_5 in var_3) {
    var_6 = var_2.var_13CC3[var_5];
    if(isDefined(var_6)) {
      if(isDefined(var_6.ent)) {
        if(self seerecently(var_6.ent, var_1)) {
          return level.success;
        }

        continue;
      }

      if(isDefined(var_6.var_EF76)) {
        foreach(var_8 in var_6.var_EF76) {
          if(!isent(var_6.ent) || self seerecently(var_8, var_1)) {
            return level.success;
          }
        }
      }
    }
  }

  return level.failure;
}

func_2CD6(var_0) {
  var_1 = 6000;
  var_2 = gettime();
  if(var_2 - self.bt.lasttimefired > var_1) {
    return level.success;
  }

  return level.failure;
}

func_7FCB() {
  var_0 = self._blackboard.shootparams;
  var_1 = [];
  var_2 = func_357C();
  foreach(var_4 in var_2) {
    var_5 = var_0.var_13CC3[var_4];
    if(isDefined(var_5)) {
      if(isDefined(var_5.ent)) {
        var_1[var_1.size] = var_5.ent;
        continue;
      }

      if(isDefined(var_5.var_EF76)) {
        foreach(var_7 in var_5.var_EF76) {
          var_1[var_1.size] = var_7;
        }
      }
    }
  }

  var_10 = undefined;
  var_11 = undefined;
  var_12 = 0;
  foreach(var_14 in var_1) {
    var_15 = self lastknowntime(var_14);
    if(var_15 > var_12) {
      var_12 = var_15;
      var_10 = var_14;
    }
  }

  return var_10;
}

func_B4EA(var_0) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    return level.failure;
  }

  if(self.script == "cover_arrival") {
    return level.failure;
  }

  if(gettime() - self.bt.lasttimefired < 1000) {
    return level.failure;
  }

  return level.success;
}

enableweapons(var_0) {
  if(isDefined(var_0)) {
    var_1 = 24;
    if(!isDefined(self.var_DD25)) {
      self.var_DD25 = 0;
    }

    var_2 = self lastknownpos(var_0);
    var_3 = 256 + self.var_DD25 * var_1;
    var_4 = getrandomnavpoints(var_2, var_3, 1, self);
    if(!isDefined(var_4) || var_4.size == 0) {
      return undefined;
    }

    return var_4[0];
  }

  return undefined;
}

func_4459(var_0, var_1, var_2) {
  var_3 = distance2dsquared(var_2, var_0.origin);
  var_4 = distance2dsquared(var_2, var_1.origin);
  return var_3 < var_4;
}

func_1043E(var_0, var_1) {
  var_2 = var_1.origin;
  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    for(var_5 = var_3 - 1; var_5 >= 0; var_5--) {
      if(func_4459(var_0[var_5], var_4, var_2)) {
        break;
      }

      var_0[var_5 + 1] = var_0[var_5];
    }

    var_0[var_5 + 1] = var_4;
  }

  return var_0;
}

enableweaponswitch(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0.node;
    if(!isDefined(var_1)) {
      var_1 = getclosestnodeinsight(var_0.origin);
    }

    if(isDefined(var_1)) {
      var_2 = getnodesinradius(self.origin, 512, 72, 72);
      var_3 = [];
      var_4 = var_2.size;
      for(var_5 = 0; var_5 < var_4; var_5++) {
        var_6 = var_2[var_5];
        if(nodesvisible(var_6, var_1) && distance2dsquared(var_6.origin, var_0.origin) >= squared(256)) {
          var_3[var_3.size] = var_6;
        }
      }

      if(var_3.size > 0) {
        var_7 = func_1043E(var_3, var_0);
        var_8 = var_7[0];
        var_9 = getclosestpointonnavmesh(var_8.origin, self);
        if(distance2dsquared(var_9, self.origin) > 16384) {
          return var_9;
        }
      }
    }
  }

  return undefined;
}

func_F814(var_0) {
  var_1 = func_7FCB();
  if(!self func_84BA() && !isDefined(var_1) || !self func_84BA(var_1.origin)) {
    return level.failure;
  }

  if(isDefined(var_1)) {
    var_2 = enableweaponswitch(var_1);
    if(!isDefined(var_2)) {
      var_2 = enableweapons(var_1);
    }

    if(isDefined(var_2)) {
      self.var_6D = 128;
      self func_8481(var_2);
      self._blackboard.var_C974 = var_1;
      return level.success;
    }
  }

  return level.failure;
}

func_12845(var_0) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return level.failure;
  }

  var_1 = self func_84B6();
  if(!isDefined(var_1) || distancesquared(var_1, self.origin) < 1296) {
    self clearpath();
    self func_8484();
    return level.failure;
  }

  self func_8481(var_1);
  return level.success;
}

func_41D4(var_0) {
  self.var_DD25 = undefined;
}

func_9E1B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = self._blackboard.shootparams;
  var_2 = func_357C();
  foreach(var_4 in var_2) {
    var_5 = var_1.var_13CC3[var_4];
    if(isDefined(var_5)) {
      if(isDefined(var_5.ent) && var_5.ent == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

func_213A() {
  var_0 = self._blackboard.shootparams;
  var_1 = 0;
  var_2 = anglesToForward(self.angles);
  var_3 = func_357C();
  foreach(var_5 in var_3) {
    var_6 = var_0.var_13CC3[var_5];
    if(isDefined(var_6) && isDefined(var_6.ent)) {
      var_7 = var_6.ent.origin - self.origin;
      if(vectordot(var_7, var_2) < 0) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

func_1382A(var_0) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return level.success;
  }

  if(func_3906(var_0) == level.success) {
    return level.success;
  }

  if(!isDefined(self._blackboard.var_C974)) {
    return level.success;
  }

  if(!func_9E1B(self._blackboard.var_C974)) {
    return level.success;
  }

  var_1 = self pathdisttogoal();
  if(var_1 < 175 && func_213A()) {
    return level.success;
  }

  return level.running;
}

func_41B3(var_0) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_1 = 84;
    var_2 = self getposonpath(var_1);
    self func_8481(var_2);
  }

  return level.success;
}

func_128A9(var_0) {
  if(!self.bt.var_E5FA) {
    return level.failure;
  }

  if(scripts\asm\asm_bb::bb_isrodeorequested()) {
    return level.success;
  }

  if(isDefined(level.player.var_883D) && level.player.var_883D != "none") {
    return level.failure;
  }

  if(isDefined(self.var_30E7) && self.var_30E7) {
    return level.failure;
  }

  if(!isDefined(level.player)) {
    return level.failure;
  }

  if(!isalive(level.player)) {
    return level.failure;
  }

  if(self.team == level.player.team) {
    return level.failure;
  }

  if(distancesquared(level.player.origin, self.origin) > 90000) {
    return level.failure;
  }

  var_1 = undefined;
  if(scripts\asm\asm_bb::bb_canrodeo("left")) {
    var_1 = "left";
  } else if(scripts\asm\asm_bb::bb_canrodeo("right")) {
    var_1 = "right";
  }

  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = anglestoright(self gettagangles("j_spineupper"));
  var_3 = level.player.origin - self gettagorigin("j_spineupper");
  var_4 = angleclamp180(vectortoyaw(var_3) - vectortoyaw(var_2));
  var_5 = 1;
  if(var_1 == "right") {
    var_5 = var_5 * -1;
  }

  var_6 = 0;
  if(func_1E76(var_4, var_5 * -60, var_5 * 60)) {
    var_6 = 1;
    self.var_E5F8 = "front";
  } else if(func_1E76(var_4, var_5 * 60, var_5 * 120)) {
    self.var_E5F8 = var_1;
  } else if(func_1E76(var_4, var_5 * -60, var_5 * -160)) {
    var_6 = 1;
    if(var_1 == "left") {
      self.var_E5F8 = "right";
    } else {
      self.var_E5F8 = "left";
    }
  } else {
    self.var_E5F8 = "rear";
  }

  if(!isplayerusing(var_6)) {
    return level.failure;
  }

  if(isDefined(self.melee)) {
    self notify("asm_stop_grabtargetthread");
  }

  scripts\asm\asm_bb::bb_setrodeorequest(var_1);
  return level.success;
}

func_1E76(var_0, var_1, var_2) {
  return (var_0 >= var_1 && var_0 <= var_2) || var_0 <= var_1 && var_0 >= var_2;
}

isplayerusing(var_0) {
  var_1 = self gettagorigin("j_spineupper");
  var_2 = vectortoangles(anglestoright(self gettagangles("j_spineupper")));
  var_3 = var_1 + rotatevector((-20, 0, 30), var_2);
  var_4 = level.player getEye();
  if(var_4[2] < var_3[2] - 90) {
    return 0;
  }

  if(var_4[2] < var_3[2] && var_0 || level.player getvelocity()[2] < 1) {
    return 0;
  }

  if(var_4[2] > var_3[2] + 90) {
    return 0;
  }

  if(distance2dsquared(var_4, var_3) > 12000) {
    return 0;
  }

  if(!level.player scripts\common\trace::player_trace_passed(level.player.origin, var_1, level.player.angles, [self, level.player])) {
    return 0;
  }

  return 1;
}

func_4F40() {}

func_4F3E() {}

func_4F3D(var_0) {}

func_4F3F(var_0, var_1, var_2) {}

func_4F43() {}

func_E602(var_0) {
  if(isDefined(self._blackboard.var_E5FD) && !self._blackboard.var_E5FD) {
    if(isDefined(self.bt.var_E5FB)) {
      self.bt.var_E5FB = undefined;
      self.var_6D = 32;
      self func_8481(self.origin);
    }

    if(isDefined(self.var_30EA)) {
      scripts\asm\asm_bb::bb_setcanrodeo(self._blackboard.rodeorequested, 0);
    }

    self._blackboard.rodeorequested = undefined;
    self._blackboard.var_E5FD = undefined;
    return level.failure;
  }

  if(!isDefined(self.bt.var_E5FB)) {
    var_1 = scripts\engine\utility::getstructarray("c12_rodeo_struct", "targetname");
    if(var_1.size == 0) {
      self.bt.var_E5FB = self.origin;
      self.var_6D = 32;
    } else {
      var_2 = sortbydistance(var_1, self.origin)[0];
      self.bt.var_E5FB = getclosestpointonnavmesh(var_2.origin, self);
      self.var_6D = max(var_2.fgetarg - 180, 32);
    }

    self func_8481(self.bt.var_E5FB);
  }

  return level.running;
}

func_12F13(var_0) {
  if(isDefined(self.bt.var_F1F8)) {
    return level.running;
  }

  self notify("self_destruct");
  thread func_F1F8();
  thread func_F1FA();
  return level.running;
}

func_F1F8() {
  self endon("death");
  createnavrepulsor("c12_selfdestruct", -1, self, 1024, 1);
  self.ignoreme = 1;
  self.bt.var_F1F8 = 1;
  wait(0.2);
  playFXOnTag(level.var_7649["c12_selfdestruct_buildup"], self, "j_spineupper");
  self playSound("c12_selfdestruct_1beep", "beep_done", 1);
  self waittill("beep_done");
  func_F1FB();
  self.asm.var_F1FD = 1;
  self func_81D0(self.origin, level.player);
}

func_F1FA() {
  self endon("death");
  self.var_6D = 128;
  var_0 = self.origin;
  for(;;) {
    if(distance2dsquared(var_0, level.player.origin) > squared(self.var_6D)) {
      var_0 = getclosestpointonnavmesh(level.player.origin, self);
      self func_8481(var_0);
    }

    wait(1);
  }
}

func_F1FB() {
  self endon("death");
  var_0 = 1;
  for(var_1 = 0; var_1 < 4; var_1++) {
    if(soundexists("c12_selfdestruct_beep")) {
      self playSound("c12_selfdestruct_beep");
      wait(0.8);
    } else {
      wait(1);
    }

    var_0 = var_0 - 0.2;
    var_0 = max(0, var_0);
    if(var_0 > 0) {
      wait(var_0);
    }
  }
}

func_35AD(var_0, var_1) {
  if(scripts\asm\asm_bb::ispartdismembered("right_arm") || scripts\asm\asm_bb::ispartdismembered("right_leg") || scripts\asm\asm_bb::ispartdismembered("left_leg")) {
    return 0;
  }

  if(scripts\asm\asm_bb::bb_isrodeorequested()) {
    return 0;
  }

  var_2 = self.enemy;
  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(!isplayer(var_2)) {
    return 0;
  }

  var_3 = vectortoyaw(var_2.origin - self.origin);
  if(abs(angleclamp180(var_3 - self.angles[1])) > 90) {
    return level.failure;
  }

  return lib_0A10::ismeleevalid(var_0, var_1);
}

func_128AE(var_0, var_1) {
  var_2 = self._blackboard.shootparams;
  var_3 = gettime();
  if(isDefined(self.asm.var_2AD2)) {
    var_2.var_A993 = var_3;
    return;
  }

  if(var_3 - var_2.var_A98F < 500) {
    return;
  }

  if(var_3 - var_2.var_A993 < 10000) {
    return;
  }

  if(!isDefined(var_1.ent)) {
    return;
  }

  var_4 = var_1.ent;
  var_5 = var_4.origin - self.origin;
  var_6 = lengthsquared(var_5);
  if(var_6 < -25536) {
    return;
  }

  var_2.var_A98F = var_3;
  var_7 = 128;
  var_8 = sqrt(var_6);
  if(var_8 < 800) {
    var_7 = var_7 * 1 - 800 - var_8 / 800;
  }

  var_7 = randomfloat(var_7);
  var_9 = randomfloat(360);
  var_10 = var_4.origin + (var_7 * cos(var_9), var_7 * sin(var_9), 0);
  if(var_0 == "left") {
    var_11 = "tag_brass_le";
  } else {
    var_11 = "tag_brass_ri";
  }

  var_12 = self gettagangles(var_11);
  var_13 = self gettagorigin(var_11) + rotatevector((0, -10, 0), var_12);
  var_14 = self func_81ED(var_13, var_10);
  if(isDefined(var_14)) {
    self playSound("c12_grenade_launch");
    var_14 makeunusable();
    var_2.var_A993 = var_3;
  }
}