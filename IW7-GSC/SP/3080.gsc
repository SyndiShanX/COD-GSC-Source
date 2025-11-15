/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3080.gsc
************************/

func_7FD3() {
  if(isDefined(self.var_10AB7) && self.var_10AB7) {
    return "sprint";
  }

  if(isDefined(self.var_527B)) {
    return self.var_527B;
  }

  return scripts\aitypes\bt_util::func_75();
}

func_12E90(param_00) {
  if(!isalive(self)) {
    return level.failure;
  }

  scripts\asm\asm_bb::bb_requestmovetype(func_7FD3());
  return level.success;
}

func_9D5B(param_00) {
  if(self.var_290A) {
    return level.success;
  }

  return level.failure;
}

func_3596() {
  return ["left", "right"];
}

func_351D(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  self.var_3135.var_13C83[param_00] = param_01;
}

func_357A() {
  var_00 = [];
  var_01 = func_3596();
  foreach(var_03 in var_01) {
    if(func_8C3C(var_03)) {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

func_357C() {
  var_00 = [];
  var_01 = func_3596();
  foreach(var_03 in var_01) {
    if(func_8C3C(var_03) && func_9F5B(var_03)) {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

func_357D() {
  var_00 = [];
  var_01 = func_3596();
  foreach(var_03 in var_01) {
    if(func_8C3C(var_03) && func_9F5B(var_03)) {
      var_04 = self.var_1198.shootparams.var_13CC3[var_03];
      if(isDefined(var_04) && isDefined(var_04.var_3124) && var_04.var_3124 && isDefined(var_04.var_2AB9) && var_04.var_2AB9) {
        var_00[var_00.size] = var_03;
      }
    }
  }

  return var_00;
}

func_8C3C(param_00) {
  return isDefined(self.var_13CC3[param_00]);
}

func_9F5B(param_00) {
  if(!self.var_3135.var_13C83[param_00]) {
    return 0;
  }

  return self.var_13C83[param_00];
}

func_B2AB(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.state = 0;
  var_02.var_1158D = param_01;
  if(self.var_13CC3[param_00] == "minigun") {
    var_02.var_71A2 = ::func_FEE5;
    var_02.var_DCE8 = 100;
  } else {
    var_02.var_71A2 = ::func_FEE9;
    var_02.var_DCE8 = 250;
    if(!isDefined(var_02.var_C241)) {
      var_02.var_C241 = randomintrange(1, 3);
    }
  }

  var_02.var_29A9 = 1;
  var_02.var_29A1 = 1;
  var_02.var_3124 = 1;
  var_02.var_2AB9 = 1;
  var_02.var_312A = 1;
  var_02.var_3139 = 0;
  return var_02;
}

func_97EB(param_00) {
  var_01 = spawnStruct();
  var_01.var_11590 = [];
  var_02 = func_357A();
  foreach(var_04 in var_02) {
    var_05 = func_B2AB(var_04, undefined);
    var_01.var_13CC3[var_04] = var_05;
  }

  var_01.var_A98F = gettime();
  var_01.var_A993 = gettime();
  self.var_1198.shootparams = var_01;
  self.setthermalbodymaterial = 1024;
  if(!isDefined(self.var_3135.lasttimefired)) {
    self.var_3135.lasttimefired = 0;
  }

  return level.success;
}

func_40E9(param_00) {
  if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.var_13CC3) && !isDefined(self.var_EF6D)) {
    var_01 = func_3596();
    foreach(var_03 in var_01) {
      self.var_1198.shootparams.var_13CC3[var_03] = undefined;
    }

    self.var_1198.shootparams = undefined;
  }

  return level.success;
}

func_12E77(param_00) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    self.var_3135.lasttimefired = gettime();
  }

  return level.success;
}

func_FB1E(param_00, param_01) {
  if(!isDefined(self.var_1198.shootparams)) {
    return level.failure;
  }

  self.var_1198.shootparams.var_12F1C = param_01;
  return level.success;
}

func_7E30(param_00) {
  if(!isDefined(self.var_1198.shootparams)) {
    return undefined;
  }

  var_01 = gettime();
  var_02 = undefined;
  var_03 = 999999999;
  foreach(var_05 in func_357A()) {
    var_06 = self.var_1198.shootparams.var_13CC3[var_05];
    if(isDefined(var_06.ent)) {
      if(var_06.var_3124 || isDefined(param_00) && var_01 - var_06.var_A9AB <= param_00) {
        var_07 = distancesquared(self.origin, var_06.ent.origin);
        if(var_07 < var_03) {
          var_03 = var_07;
          var_02 = var_06.ent;
        }
      }

      continue;
    }

    if(isDefined(var_06.var_EF76) && var_06.var_EF76.size > 0) {
      foreach(var_09 in var_06.var_EF76) {
        if(isDefined(var_09)) {
          var_07 = distancesquared(self.origin, var_09.origin);
          if(var_07 < var_03) {
            var_03 = var_07;
            var_02 = var_09;
          }
        }
      }
    }
  }

  return var_02;
}

func_FE5F(param_00, param_01) {
  self[[param_00.var_71A2]](param_00, param_01);
}

canseetarget(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = var_01.var_13CC3[param_00];
  if(!isDefined(var_02)) {
    return 0;
  }

  var_03 = undefined;
  if(isDefined(var_02.var_EF76) && var_02.var_EF76.size > 0) {
    var_03 = var_02.var_EF76[0];
  } else if(isDefined(var_02.ent)) {
    var_03 = var_02.ent;
  }

  if(isDefined(var_03)) {
    return self getpersstat(var_03);
  }

  return 1;
}

func_8C27(param_00, param_01) {
  if(!isDefined(param_01)) {
    return 1;
  }

  var_02 = self.var_1198.shootparams;
  var_03 = var_02.var_13CC3[param_00];
  if(!isDefined(var_03)) {
    return 0;
  }

  var_04 = undefined;
  if(self.var_13CC3[param_00] == "minigun") {
    var_04 = lib_0C41::func_3587(param_00);
  } else if(self.var_13CC3[param_00] == "rocket") {
    var_04 = lib_0C41::func_3593(param_00, "top");
  }

  var_05 = 256;
  var_06 = param_01 - var_04;
  var_07 = length(var_06);
  if(var_07 > var_05) {
    var_08 = var_04 + var_06 / var_07 * 256;
  } else {
    var_08 = var_02;
  }

  return sighttracepassed(var_04, var_08, 0, self);
}

func_8BEC(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(param_00.ent) && !isDefined(param_00.var_EF76) && !isDefined(param_00.pos)) {
    return 0;
  }

  return 1;
}

shouldshoot(param_00) {
  if(isDefined(self.dontevershoot)) {
    return level.failure;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  return level.success;
}

func_FE7B(param_00, param_01) {
  var_02 = self.var_1198.shootparams;
  if(!isDefined(var_02.var_13CC3[param_00])) {
    return;
  }

  if(!isDefined(param_01) || !isDefined(var_02.var_13CC3[param_00].ent) || var_02.var_13CC3[param_00].ent != param_01) {
    var_03 = func_B2AB(param_00, var_02.var_13CC3[param_00].var_1158D);
    var_02.var_13CC3[param_00].state = -1;
    var_03.var_C249 = var_02.var_13CC3[param_00].var_C249;
    var_02.var_13CC3[param_00] = var_03;
    var_04 = gettime();
    var_03.var_656E = var_04;
    if(isDefined(param_01)) {
      var_03.lastenemypos = param_01.origin;
      var_03.var_A97D = var_04;
    }
  }

  var_05 = var_02.var_13CC3[param_00];
  var_05.ent = param_01;
}

func_FE8B(param_00) {
  var_01 = func_3596();
  var_02 = undefined;
  foreach(var_04 in var_01) {
    if(self.var_1198.shootparams.var_13CC3[var_04] == param_00) {
      var_02 = var_04;
      break;
    }
  }

  var_06 = gettime();
  if(isDefined(param_00.ent)) {
    param_00.var_29A1 = self getpersstat(param_00.ent);
    param_00.var_3124 = self seerecently(param_00.ent, 1);
    if(issentient(param_00.ent)) {
      param_00.var_A9AB = self lastknowntime(param_00.ent);
    } else {
      param_00.var_A9AB = var_06;
    }

    var_07 = 1024;
    var_08 = 500;
    if(var_06 > param_00.var_A97D + var_08) {
      if(distancesquared(param_00.ent.origin, param_00.lastenemypos) > var_07) {
        param_00.var_3139 = 0;
      } else {
        param_00.var_3139 = 1;
      }

      param_00.lastenemypos = param_00.ent.origin;
      param_00.var_A97D = var_06;
    }
  } else {
    param_00.var_29A1 = 1;
    param_00.var_3124 = 1;
    param_00.var_A9AB = var_06;
  }

  var_09 = self.var_13CC3[var_02] == "rocket";
  param_00.var_1A46 = func_FE67(param_00, var_09);
  param_00.var_1A47 = var_06;
  param_00.var_312A = param_00.var_3124;
  param_00.var_2AB9 = func_8C27(var_02, param_00.var_1A46);
}

func_FE8C(param_00) {
  var_01 = self.var_1198.shootparams;
  if(isDefined(self.var_7212) && gettime() < self.var_7212) {
    if(func_9F5B("left")) {
      var_02 = level.player;
    } else {
      var_02 = undefined;
    }

    if(func_9F5B("right")) {
      var_03 = level.player;
    } else {
      var_03 = undefined;
    }
  } else {
    var_02 = self.isnodeoccupied;
    var_03 = self.isnodeoccupied;
    if(self.var_27F7) {
      if(func_8C3C("left") && func_9F5B("left") && func_8C3C("right") && func_9F5B("right")) {
        var_04 = self _meth_848B();
        if(isDefined(var_04) && var_04.size > 0) {
          var_05 = var_04[0];
          var_06 = self.isnodeoccupied.origin - self.origin;
          var_07 = var_05.origin - self.origin;
          var_08 = vectornormalize(var_07);
          var_09 = self.isnodeoccupied.origin + var_05.origin * 0.5;
          var_0A = vectornormalize(var_09 - self.origin);
          var_0B = vectortoangles(var_0A);
          var_0C = anglesToForward(self.angles);
          if(vectordot(var_0A, var_0C) > 0) {
            var_0D = anglestoright(var_0B);
            if(vectordot(var_08, var_0A) > 0) {
              var_0E = vectordot(var_0D, var_06);
              var_0F = vectordot(var_0D, var_07);
              if(var_0F > var_0E) {
                var_03 = var_05;
              } else {
                var_02 = var_05;
              }
            }
          }
        }
      }
    }

    if(!func_9F5B("left")) {
      var_02 = undefined;
    } else if(isDefined(var_01.var_13CC3["left"]) && isDefined(var_01.var_13CC3["left"].var_313A) && isDefined(var_01.var_13CC3["left"].ent)) {
      var_02 = var_01.var_13CC3["left"].ent;
    }

    if(!func_9F5B("right")) {
      var_03 = undefined;
    } else if(isDefined(var_01.var_13CC3["right"]) && isDefined(var_01.var_13CC3["right"].var_313A) && isDefined(var_01.var_13CC3["right"].ent)) {
      var_03 = var_01.var_13CC3["right"].ent;
    }
  }

  func_FE7B("left", var_02);
  func_FE7B("right", var_03);
  func_FE8B(var_01.var_13CC3["left"]);
  func_FE8B(var_01.var_13CC3["right"]);
  return level.success;
}

func_FE7A(param_00) {
  if(isDefined(param_00)) {
    self.var_1198.shootparams.var_BFB6 = param_00;
    return;
  }

  self.var_1198.shootparams.var_BFB6 = gettime() + randomintrange(1000, 1500);
}

func_3873(param_00) {
  setdvarifuninitialized("enable_c12_berserk", 0);
  if(!getdvarint("enable_c12_berserk")) {
    return 0;
  }

  if(!isDefined(param_00.ent)) {
    return 0;
  }

  var_01 = self.var_1198.shootparams;
  var_02 = ["left", "right"];
  var_03 = undefined;
  foreach(var_05 in var_02) {
    if(var_01.var_13CC3[var_05] == param_00) {
      if(self.var_13CC3[var_05] != "minigun") {
        return 0;
      }

      var_03 = var_05;
      break;
    }
  }

  var_07 = "left";
  if(var_07 == var_03) {
    var_07 = "right";
  }

  if(!scripts\asm\asm_bb::ispartdismembered(var_07 + "_arm")) {
    return 0;
  }

  var_08 = gettime();
  if(!isDefined(var_01.var_BF71)) {
    var_01.var_BF71 = var_08;
  }

  return var_08 >= var_01.var_BF71;
}

func_FE79() {
  var_00 = self.var_1198.shootparams;
  if(isDefined(var_00)) {
    var_00.var_BF71 = gettime() + randomintrange(10000, 20000);
  }
}

func_FE78(param_00) {
  param_00.var_2763 = gettime() + 2000;
}

func_FE63() {
  var_00 = func_357A();
  foreach(var_02 in var_00) {
    if(self.var_13CC3[var_02] == "minigun") {
      return var_02;
    }
  }

  return undefined;
}

func_FE65() {
  var_00 = func_357A();
  foreach(var_02 in var_00) {
    if(self.var_13CC3[var_02] == "rocket") {
      return var_02;
    }
  }

  return undefined;
}

func_FE68(param_00) {
  if(isDefined(param_00.unittype) && param_00.unittype == "c12") {
    return 1000;
  }

  if(scripts\sp\vehicle::func_9FEF(param_00)) {
    return 500;
  }

  return 10;
}

func_FE62() {
  var_00 = self.var_1198.shootparams;
  var_01 = 0;
  var_02 = undefined;
  var_03 = func_357C();
  foreach(var_05 in var_03) {
    var_06 = var_00.var_13CC3[var_05];
    if(isDefined(var_06) && isDefined(var_06.ent)) {
      var_07 = func_FE68(var_06.ent);
      if(var_07 > var_01) {
        var_02 = var_05;
        var_01 = var_07;
      }
    }
  }

  return var_02;
}

func_41EC(param_00) {
  return level.failure;
}

func_FE8E(param_00) {
  func_FE8C(param_00);
  var_01 = func_FE8D(param_00);
  func_FE8A(var_01);
  return level.success;
}

func_FE8D(param_00) {
  var_01 = self.var_1198.shootparams;
  if(isDefined(self.var_9DD2) && self.var_9DD2) {
    return func_FE63();
  }

  if(isDefined(var_01.var_1675) && func_9F5B(var_01.var_1675)) {
    var_02 = var_01.var_13CC3[var_01.var_1675];
    if(var_02.state != 0) {
      return var_01.var_1675;
    }
  }

  var_03 = func_357D();
  if(var_03.size == 0) {
    return undefined;
  }

  var_04 = var_03;
  foreach(var_06 in var_03) {
    var_02 = var_01.var_13CC3[var_06];
    if(self.var_13CC3[var_06] == "rocket") {
      var_07 = var_02.ent;
      if(isDefined(var_07)) {
        if(distancesquared(var_07.origin, self.origin) < -25536) {
          var_04 = scripts\engine\utility::array_remove(var_04, var_06);
        } else if(!var_02.var_3139) {
          var_04 = scripts\engine\utility::array_remove(var_04, var_06);
        }
      }

      continue;
    }

    if(isDefined(var_01.var_1675) && var_01.var_1675 == var_06) {
      if(var_02.var_3124 && var_01.var_C24A >= 3) {
        var_04 = scripts\engine\utility::array_remove(var_04, var_06);
      }
    }
  }

  if(var_04.size == 0) {
    var_03 = func_357D();
    if(var_03.size > 0) {
      return var_03[randomint(var_03.size)];
    }

    return;
  }

  if(var_04.size == 1) {
    return var_04[0];
  }

  return var_04[randomint(var_04.size)];
}

func_FE8A(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = func_357A();
  foreach(var_04 in var_02) {
    if(!func_9F5B(var_04) && isDefined(var_01.var_13CC3[var_04])) {
      func_FE5F(var_01.var_13CC3[var_04], 0);
    }
  }

  if(!isDefined(var_01.var_1675)) {
    func_FE7A(gettime());
  }

  var_06 = isDefined(param_00);
  if(var_06 && isDefined(var_01.var_1675) && param_00 == var_01.var_1675) {
    if(var_01.var_13CC3[param_00].var_29A9 && !var_01.var_13CC3[param_00].var_29A1) {
      func_FE5F(var_01.var_13CC3[param_00], 0);
    } else {
      if(var_01.var_13CC3[param_00].state == 0) {
        if(!isDefined(var_01.var_BFB6)) {
          func_FE7A();
        }

        if(gettime() > var_01.var_BFB6) {
          var_01.var_BFB6 = undefined;
          var_01.var_C24A++;
          func_FE5F(var_01.var_13CC3[param_00], 1);
        }
      }

      return;
    }
  }

  var_02 = func_357A();
  foreach(var_08 in var_02) {
    if(!var_06 || var_08 != param_00) {
      var_09 = var_01.var_13CC3[var_08];
      func_FE5F(var_09, 0);
    }
  }

  var_01.var_1675 = param_00;
  var_01.var_C24A = 0;
  if(var_06 && var_01.var_13CC3[param_00].var_29A1) {
    if(!isDefined(var_01.var_BFB6)) {
      func_FE7A();
    }

    if(gettime() > var_01.var_BFB6) {
      var_09 = var_01.var_13CC3[param_00];
      var_01.var_C24A = 1;
      var_01.var_BFB6 = undefined;
      func_FE5F(var_09, 1);
    }
  }
}

func_10079(param_00) {
  var_01 = self.var_1198.shootparams.var_13CC3[param_00];
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01.state == 2 || var_01.state == 3;
}

func_9F7B(param_00) {
  var_01 = self.var_1198.shootparams.var_13CC3[param_00];
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01.state == 3;
}

func_1391C(param_00) {
  return param_00.state == 3;
}

func_A004(param_00) {
  var_01 = self.var_1198.shootparams.var_13CC3[param_00];
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01.state == 4;
}

func_A005(param_00) {
  var_01 = self.var_1198.shootparams.var_12F1C;
  var_02 = self.var_1198.shootparams.var_13CC3[var_01];
  if(!isDefined(var_02)) {
    return level.failure;
  }

  if(var_02.state == 0) {
    return level.failure;
  }

  return level.success;
}

func_A006(param_00, param_01) {
  var_02 = self.var_1198.shootparams.var_12F1C;
  if(func_A007(var_02, param_01)) {
    return level.success;
  }

  return level.failure;
}

func_A007(param_00, param_01) {
  if(!func_8C3C(param_00)) {
    return 0;
  }

  if(self.var_13CC3[param_00] == param_01) {
    return 1;
  }

  return 0;
}

func_FE66(param_00) {
  if(!func_8C3C(param_00)) {
    return undefined;
  }

  var_01 = self.var_1198.shootparams;
  var_02 = var_01.var_13CC3[param_00];
  var_03 = self.var_13CC3[param_00] == "rocket";
  return func_FE67(var_02, var_03);
}

func_FE67(param_00, param_01) {
  if(param_00.state == 4) {
    return self.origin + anglesToForward(self.angles) * 192;
  }

  if(isDefined(param_00.var_E5E0)) {
    return param_00.var_E5E0;
  }

  if(isDefined(param_00.var_EF76)) {
    var_02 = (0, 0, 0);
    var_03 = 0;
    foreach(var_07, var_05 in param_00.var_EF76) {
      if(isDefined(var_05)) {
        if(param_01) {
          var_06 = var_05.origin;
        } else {
          var_06 = var_07 getshootatpos();
        }

        var_02 = var_02 + var_06;
        var_03++;
      }
    }

    if(var_03 == 0) {
      return undefined;
    }

    var_08 = var_02 / var_03;
    return var_08 + func_FE69(param_00, var_08);
  }

  if(isDefined(var_07.ent)) {
    var_09 = func_3596();
    var_0A = undefined;
    foreach(var_0C in var_09) {
      if(self.var_1198.shootparams.var_13CC3[var_0C] == var_07) {
        var_0A = var_0C;
        break;
      }
    }

    if(self getpersstat(var_07.ent)) {
      if(var_08) {
        return var_07.ent.origin;
      }

      var_0E = var_07.ent getshootatpos();
      return var_0E + func_FE69(var_07, var_0E);
    } else {
      var_0E = self lastknownpos(var_08.ent) + (0, 0, 60);
      return var_0E + func_FE69(var_07, var_0E);
    }
  }

  if(isDefined(var_08.pos)) {
    return var_08.pos + func_FE69(var_08, var_08.pos);
  }

  return undefined;
}

func_FE69(param_00, param_01) {
  if(!func_1391C(param_00)) {
    return (0, 0, 0);
  }

  var_02 = gettime() - param_00.var_110D8 / 1000;
  var_03 = int(var_02 * 256);
  var_04 = var_03 % 256;
  if(var_04 > 128) {
    var_04 = 256 - var_04;
  }

  if(int(var_03 / 256) % 2) {
    var_04 = var_04 * -1;
  }

  return rotatevector((0, var_04, 0), vectortoangles(self.origin - param_01));
}

func_FEE6(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = self.var_1198.shootparams.var_12F1C;
  var_01.var_11590[param_00] = var_02;
  var_03 = var_01.var_13CC3[var_02];
  var_03.var_1158D = param_00;
  func_FEE5(var_03, 1);
}

func_FEE5(param_00, param_01) {
  var_02 = -999;
  var_03 = param_00.state;
  if(!isDefined(var_03)) {
    var_03 = var_02;
  }

  if(var_03 == param_01) {
    return;
  }

  param_00.state = param_01;
  switch (param_01) {
    case 0:
      break;

    case 1:
      if(var_03 == 0) {
        param_00.var_DCE8 = 100;
        param_00.var_C21B = randomintrange(2, 4);
        param_00.var_BF72 = gettime();
        param_00.var_927E = 0;
      } else if(var_03 == 2) {
        param_00.var_BF72 = gettime() + 1000;
      }

      func_FE78(param_00);
      break;

    case 2:
      param_00.var_927E++;
      param_00.var_32BC = gettime() + randomintrange(2000, 4000);
      scripts\sp\gameskill::func_F288();
      break;

    case 3:
      param_00.var_DCE8 = 33.33333;
      param_00.var_110D8 = gettime();
      param_00.var_32BC = gettime() + 12000;
      param_00.var_313A = 1;
      break;
  }
}

func_FEE3(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = var_01.var_12F1C;
  var_03 = var_01.var_13CC3[var_02];
  if(!func_8BEC(var_03)) {
    func_FEE5(var_03, 0);
    return level.success;
  }

  var_04 = gettime();
  if(var_04 > var_01.var_A993 + 30000) {
    func_128AE(var_02, var_03);
  }

  switch (var_03.state) {
    case 1:
      if(!isDefined(var_03.var_2763)) {
        func_FE78(var_03);
      }

      if(var_04 > var_03.var_2763) {
        func_128AE(var_02, var_03);
        func_FEE5(var_03, 0);
        return level.failure;
      }

      if(var_04 >= var_03.var_BF72 && func_9EA0(var_02, var_03.var_1A46)) {
        var_05 = 1;
        if(var_03.var_29A9) {
          var_05 = canseetarget(var_02);
        }

        if(var_05) {
          if(isDefined(self.var_3131)) {
            func_FEE5(var_03, 3);
          } else {
            func_FEE5(var_03, 2);
          }
        }
      }
      break;

    case 2:
      if(var_04 >= var_03.var_32BC) {
        if(var_03.var_927E >= var_03.var_C21B) {
          func_FEE5(var_03, 0);
          func_FE7A();
          return level.success;
        } else {
          func_FEE5(var_03, 1);
        }
      }
      break;

    case 3:
      if(var_04 >= var_03.var_32BC) {
        func_FEE5(var_03, 0);
        func_FE7A();
        return level.success;
      }
      break;

    case 0:
      return level.failure;
  }

  return level.running;
}

func_FEE4(param_00) {
  var_01 = self.var_1198.shootparams;
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = var_01.var_11590[param_00];
  var_03 = var_01.var_13CC3[var_02];
  if(var_03.var_1158D == param_00) {
    func_FEE5(var_03, 0);
  }
}

func_FEE9(param_00, param_01) {
  var_02 = param_00.state;
  if(var_02 == param_01) {
    return;
  }

  param_00.state = param_01;
  if(param_01 == 1) {
    func_FE78(param_00);
  }

  if(param_01 == 2) {
    param_00.var_313A = 1;
    param_00.var_29A9 = 0;
    return;
  }

  param_00.var_313A = undefined;
  param_00.var_29A9 = 1;
}

func_FEEA(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = var_01.var_12F1C;
  var_01.var_11590[param_00] = var_02;
  var_03 = var_01.var_13CC3[var_02];
  var_03.var_1158D = param_00;
  var_03.state = 1;
  if(isDefined(var_03.var_EF76)) {
    var_03.var_C241 = var_03.var_EF76.size;
  } else {
    var_03.var_C241 = randomintrange(1, 3);
  }

  var_03.var_DCE8 = 250;
  scripts\sp\gameskill::func_F288();
  func_FE78(var_03);
}

func_FEE7(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = var_01.var_12F1C;
  var_03 = self.var_1198.shootparams.var_13CC3[var_02];
  if(scripts\asm\asm::asm_ephemeraleventfired("rocket_shoot_complete", var_02)) {
    func_FE7A();
    if(isDefined(var_03)) {
      var_03.var_2720 = undefined;
    }

    return level.success;
  }

  var_04 = var_03.var_1A46;
  if(!isDefined(var_04)) {
    return level.failure;
  }

  var_05 = gettime();
  if(var_05 > var_01.var_A993 + 30000) {
    func_128AE(var_02, var_03);
  }

  if(var_03.state == 1) {
    if(!isDefined(var_03.var_2763)) {
      func_FE78(var_03);
    }

    if(var_05 > var_03.var_2763) {
      func_128AE(var_02, var_03);
      func_FE5F(var_03, 0);
      return level.failure;
    }
  }

  if(var_03.state != 2) {
    if(distancesquared(self.origin, var_04) > 65536) {
      if(func_9F30(var_02, var_04)) {
        var_06 = 1;
        if(var_03.var_29A9) {
          var_06 = var_03.var_2AB9;
        }

        if(var_06) {
          func_FE5F(var_03, 2);
        }
      }
    }
  }

  return level.running;
}

func_FEE8(param_00) {
  var_01 = self.var_1198.shootparams;
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = var_01.var_11590[param_00];
  if(!isDefined(var_02)) {
    return;
  }

  var_03 = self.var_1198.shootparams.var_13CC3[var_02];
  if(var_03.var_1158D == param_00) {
    var_03.state = 0;
  }
}

func_9F30(param_00, param_01) {
  var_02 = lib_0C41::func_3593(param_00, "top");
  var_03 = lib_0C41::func_3592(param_00, "top");
  if(isDefined(self.var_E5C4)) {
    var_04 = anglesToForward(var_03);
    var_04 = rotatevector(var_04, (self.var_E5C4, 0, 0));
    var_03 = vectortoangles(var_04);
  }

  var_05 = 15;
  var_06 = func_9FFA(var_02, var_03, param_01, var_05);
  if(var_06) {
    return 1;
  }

  if(isDefined(self.var_E5C4)) {
    var_07 = lib_0C41::func_3628(param_00, "pitch", "min");
    var_08 = lib_0C41::func_3628(param_00, "pitch", "max");
    if(var_03[0] > var_07 - 3 || var_03[0] < var_08 + 3) {
      return 1;
    }
  }

  return 0;
}

func_9EA0(param_00, param_01) {
  var_02 = lib_0C41::func_3587(param_00);
  var_03 = lib_0C41::func_3585(param_00);
  var_04 = 15;
  return func_9FFA(var_02, var_03, param_01, var_04);
}

func_9FFA(param_00, param_01, param_02, param_03) {
  var_04 = vectornormalize(param_02 - param_00);
  var_05 = anglesToForward(param_01);
  var_06 = cos(param_03);
  return vectordot(var_04, var_05) >= var_06;
}

func_8C23(param_00) {
  if(isDefined(self.var_EF6D)) {
    foreach(var_02 in self.var_EF6D) {
      var_03 = var_02.size;
      if(var_03 > 0) {
        for(var_04 = 0; var_04 < var_03; var_04++) {
          if(isDefined(var_02[var_04])) {
            return level.success;
          }
        }
      }
    }
  }

  return level.failure;
}

func_FE90(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = var_01.var_13CC3[param_00];
  func_FE8B(var_02);
  if(isDefined(var_01.var_BFB6)) {
    if(gettime() < var_01.var_BFB6) {
      return;
    }
  }

  var_03 = 1;
  if(isDefined(var_02.var_EF76)) {
    var_03 = !scripts\sp\utility::array_compare(self.var_EF6D[param_00], var_02.var_EF76);
  }

  if(var_03) {
    var_04 = var_02.var_1158D;
    var_02.state = -1;
    var_02 = func_B2AB(param_00, var_04);
    var_01.var_13CC3[param_00] = var_02;
  }

  var_02.var_EF76 = self.var_EF6D[param_00];
  var_02.var_EF77 = self.var_EF70[param_00];
  var_02.var_29A9 = self.var_EF6E[param_00];
  var_02.var_C241 = self.var_EF6D[param_00].size;
  if(!isDefined(var_02.var_656E)) {
    var_02.var_656E = gettime();
  }

  func_FE8B(var_02);
  if(var_02.state == 0) {
    func_FE5F(var_02, 1);
  }
}

func_FE8F(param_00) {
  var_01 = self.var_1198.shootparams;
  if(!isDefined(var_01)) {
    func_97EB(undefined);
    var_01 = self.var_1198.shootparams;
  }

  var_02 = func_357A();
  foreach(var_04 in var_02) {
    if(func_9F5B(var_04) && isDefined(self.var_EF6D[var_04])) {
      func_FE90(var_04);
      continue;
    }

    var_05 = self.var_1198.shootparams.var_13CC3[var_04];
    if(isDefined(var_05)) {
      func_FE5F(var_05, 0);
    }
  }

  return level.success;
}

func_F811(param_00) {
  var_01 = getrandomnavpoint(self.origin, 2048, self);
  self _meth_8481(var_01);
  self give_mp_super_weapon((0, 0, 0));
  return level.success;
}

func_1383A(param_00) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    return level.running;
  }

  self _meth_8484();
  return level.success;
}

func_3906(param_00) {
  var_01 = self.var_1198.shootparams;
  var_02 = func_357C();
  foreach(var_04 in var_02) {
    var_05 = var_01.var_13CC3[var_04];
    if(isDefined(var_05)) {
      if(isDefined(var_05.ent)) {
        if(self getpersstat(var_05.ent)) {
          return level.success;
        }

        continue;
      }

      if(isDefined(var_05.var_EF76)) {
        foreach(var_07 in var_05.var_EF76) {
          if(self getpersstat(var_07)) {
            return level.success;
          }
        }
      }
    }
  }

  return level.failure;
}

func_8C25(param_00, param_01) {
  var_02 = self.var_1198.shootparams;
  var_03 = func_357C();
  foreach(var_05 in var_03) {
    var_06 = var_02.var_13CC3[var_05];
    if(isDefined(var_06)) {
      if(isDefined(var_06.ent)) {
        if(self seerecently(var_06.ent, param_01)) {
          return level.success;
        }

        continue;
      }

      if(isDefined(var_06.var_EF76)) {
        foreach(var_08 in var_06.var_EF76) {
          if(!isent(var_06.ent) || self seerecently(var_08, param_01)) {
            return level.success;
          }
        }
      }
    }
  }

  return level.failure;
}

func_2CD6(param_00) {
  var_01 = 6000;
  var_02 = gettime();
  if(var_02 - self.var_3135.lasttimefired > var_01) {
    return level.success;
  }

  return level.failure;
}

func_7FCB() {
  var_00 = self.var_1198.shootparams;
  var_01 = [];
  var_02 = func_357C();
  foreach(var_04 in var_02) {
    var_05 = var_00.var_13CC3[var_04];
    if(isDefined(var_05)) {
      if(isDefined(var_05.ent)) {
        var_01[var_01.size] = var_05.ent;
        continue;
      }

      if(isDefined(var_05.var_EF76)) {
        foreach(var_07 in var_05.var_EF76) {
          var_01[var_01.size] = var_07;
        }
      }
    }
  }

  var_0A = undefined;
  var_0B = undefined;
  var_0C = 0;
  foreach(var_0E in var_01) {
    var_0F = self lastknowntime(var_0E);
    if(var_0F > var_0C) {
      var_0C = var_0F;
      var_0A = var_0E;
    }
  }

  return var_0A;
}

func_B4EA(param_00) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    return level.failure;
  }

  if(self.script == "cover_arrival") {
    return level.failure;
  }

  if(gettime() - self.var_3135.lasttimefired < 1000) {
    return level.failure;
  }

  return level.success;
}

enableweapons(param_00) {
  if(isDefined(param_00)) {
    var_01 = 24;
    if(!isDefined(self.var_DD25)) {
      self.var_DD25 = 0;
    }

    var_02 = self lastknownpos(param_00);
    var_03 = 256 + self.var_DD25 * var_01;
    var_04 = getrandomnavpoints(var_02, var_03, 1, self);
    if(!isDefined(var_04) || var_04.size == 0) {
      return undefined;
    }

    return var_04[0];
  }

  return undefined;
}

func_4459(param_00, param_01, param_02) {
  var_03 = distance2dsquared(param_02, param_00.origin);
  var_04 = distance2dsquared(param_02, param_01.origin);
  return var_03 < var_04;
}

func_1043E(param_00, param_01) {
  var_02 = param_01.origin;
  for(var_03 = 1; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    for(var_05 = var_03 - 1; var_05 >= 0; var_05--) {
      if(func_4459(param_00[var_05], var_04, var_02)) {
        break;
      }

      param_00[var_05 + 1] = param_00[var_05];
    }

    param_00[var_05 + 1] = var_04;
  }

  return param_00;
}

enableweaponswitch(param_00) {
  if(isDefined(param_00)) {
    var_01 = param_00.target_getindexoftarget;
    if(!isDefined(var_01)) {
      var_01 = getclosestnodeinsight(param_00.origin);
    }

    if(isDefined(var_01)) {
      var_02 = getnodesinradius(self.origin, 512, 72, 72);
      var_03 = [];
      var_04 = var_02.size;
      for(var_05 = 0; var_05 < var_04; var_05++) {
        var_06 = var_02[var_05];
        if(nodesvisible(var_06, var_01) && distance2dsquared(var_06.origin, param_00.origin) >= squared(256)) {
          var_03[var_03.size] = var_06;
        }
      }

      if(var_03.size > 0) {
        var_07 = func_1043E(var_03, param_00);
        var_08 = var_07[0];
        var_09 = getclosestpointonnavmesh(var_08.origin, self);
        if(distance2dsquared(var_09, self.origin) > 16384) {
          return var_09;
        }
      }
    }
  }

  return undefined;
}

func_F814(param_00) {
  var_01 = func_7FCB();
  if(!self _meth_84BA() && !isDefined(var_01) || !self _meth_84BA(var_01.origin)) {
    return level.failure;
  }

  if(isDefined(var_01)) {
    var_02 = enableweaponswitch(var_01);
    if(!isDefined(var_02)) {
      var_02 = enableweapons(var_01);
    }

    if(isDefined(var_02)) {
      self.var_6D = 128;
      self _meth_8481(var_02);
      self.var_1198.var_C974 = var_01;
      return level.success;
    }
  }

  return level.failure;
}

func_12845(param_00) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return level.failure;
  }

  var_01 = self _meth_84B6();
  if(!isDefined(var_01) || distancesquared(var_01, self.origin) < 1296) {
    self clearpath();
    self _meth_8484();
    return level.failure;
  }

  self _meth_8481(var_01);
  return level.success;
}

func_41D4(param_00) {
  self.var_DD25 = undefined;
}

func_9E1B(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = self.var_1198.shootparams;
  var_02 = func_357C();
  foreach(var_04 in var_02) {
    var_05 = var_01.var_13CC3[var_04];
    if(isDefined(var_05)) {
      if(isDefined(var_05.ent) && var_05.ent == param_00) {
        return 1;
      }
    }
  }

  return 0;
}

func_213A() {
  var_00 = self.var_1198.shootparams;
  var_01 = 0;
  var_02 = anglesToForward(self.angles);
  var_03 = func_357C();
  foreach(var_05 in var_03) {
    var_06 = var_00.var_13CC3[var_05];
    if(isDefined(var_06) && isDefined(var_06.ent)) {
      var_07 = var_06.ent.origin - self.origin;
      if(vectordot(var_07, var_02) < 0) {
        var_01 = 1;
        break;
      }
    }
  }

  return var_01;
}

func_1382A(param_00) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return level.success;
  }

  if(func_3906(param_00) == level.success) {
    return level.success;
  }

  if(!isDefined(self.var_1198.var_C974)) {
    return level.success;
  }

  if(!func_9E1B(self.var_1198.var_C974)) {
    return level.success;
  }

  var_01 = self pathdisttogoal();
  if(var_01 < 175 && func_213A()) {
    return level.success;
  }

  return level.running;
}

func_41B3(param_00) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_01 = 84;
    var_02 = self getposonpath(var_01);
    self _meth_8481(var_02);
  }

  return level.success;
}

func_128A9(param_00) {
  if(!self.var_3135.var_E5FA) {
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

  var_01 = undefined;
  if(scripts\asm\asm_bb::bb_canrodeo("left")) {
    var_01 = "left";
  } else if(scripts\asm\asm_bb::bb_canrodeo("right")) {
    var_01 = "right";
  }

  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = anglestoright(self gettagangles("j_spineupper"));
  var_03 = level.player.origin - self gettagorigin("j_spineupper");
  var_04 = angleclamp180(vectortoyaw(var_03) - vectortoyaw(var_02));
  var_05 = 1;
  if(var_01 == "right") {
    var_05 = var_05 * -1;
  }

  var_06 = 0;
  if(func_1E76(var_04, var_05 * -60, var_05 * 60)) {
    var_06 = 1;
    self.var_E5F8 = "front";
  } else if(func_1E76(var_04, var_05 * 60, var_05 * 120)) {
    self.var_E5F8 = var_01;
  } else if(func_1E76(var_04, var_05 * -60, var_05 * -160)) {
    var_06 = 1;
    if(var_01 == "left") {
      self.var_E5F8 = "right";
    } else {
      self.var_E5F8 = "left";
    }
  } else {
    self.var_E5F8 = "rear";
  }

  if(!isplayerusing(var_06)) {
    return level.failure;
  }

  if(isDefined(self.melee)) {
    self notify("asm_stop_grabtargetthread");
  }

  scripts\asm\asm_bb::bb_setrodeorequest(var_01);
  return level.success;
}

func_1E76(param_00, param_01, param_02) {
  return (param_00 >= param_01 && param_00 <= param_02) || param_00 <= param_01 && param_00 >= param_02;
}

isplayerusing(param_00) {
  var_01 = self gettagorigin("j_spineupper");
  var_02 = vectortoangles(anglestoright(self gettagangles("j_spineupper")));
  var_03 = var_01 + rotatevector((-20, 0, 30), var_02);
  var_04 = level.player getEye();
  if(var_04[2] < var_03[2] - 90) {
    return 0;
  }

  if(var_04[2] < var_03[2] && param_00 || level.player getvelocity()[2] < 1) {
    return 0;
  }

  if(var_04[2] > var_03[2] + 90) {
    return 0;
  }

  if(distance2dsquared(var_04, var_03) > 12000) {
    return 0;
  }

  if(!level.player scripts\common\trace::player_trace_passed(level.player.origin, var_01, level.player.angles, [self, level.player])) {
    return 0;
  }

  return 1;
}

func_4F40() {}

func_4F3E() {}

func_4F3D(param_00) {}

func_4F3F(param_00, param_01, param_02) {}

func_4F43() {}

func_E602(param_00) {
  if(isDefined(self.var_1198.var_E5FD) && !self.var_1198.var_E5FD) {
    if(isDefined(self.var_3135.var_E5FB)) {
      self.var_3135.var_E5FB = undefined;
      self.var_6D = 32;
      self _meth_8481(self.origin);
    }

    if(isDefined(self.var_30EA)) {
      scripts\asm\asm_bb::bb_setcanrodeo(self.var_1198.rodeorequested, 0);
    }

    self.var_1198.rodeorequested = undefined;
    self.var_1198.var_E5FD = undefined;
    return level.failure;
  }

  if(!isDefined(self.var_3135.var_E5FB)) {
    var_01 = scripts\engine\utility::getstructarray("c12_rodeo_struct", "targetname");
    if(var_01.size == 0) {
      self.var_3135.var_E5FB = self.origin;
      self.var_6D = 32;
    } else {
      var_02 = sortbydistance(var_01, self.origin)[0];
      self.var_3135.var_E5FB = getclosestpointonnavmesh(var_02.origin, self);
      self.var_6D = max(var_02.fgetarg - 180, 32);
    }

    self _meth_8481(self.var_3135.var_E5FB);
  }

  return level.running;
}

func_12F13(param_00) {
  if(isDefined(self.var_3135.var_F1F8)) {
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
  self.var_3135.var_F1F8 = 1;
  wait(0.2);
  playFXOnTag(level.var_7649["c12_selfdestruct_buildup"], self, "j_spineupper");
  self playSound("c12_selfdestruct_1beep", "beep_done", 1);
  self waittill("beep_done");
  func_F1FB();
  self.asm.var_F1FD = 1;
  self _meth_81D0(self.origin, level.player);
}

func_F1FA() {
  self endon("death");
  self.var_6D = 128;
  var_00 = self.origin;
  for(;;) {
    if(distance2dsquared(var_00, level.player.origin) > squared(self.var_6D)) {
      var_00 = getclosestpointonnavmesh(level.player.origin, self);
      self _meth_8481(var_00);
    }

    wait(1);
  }
}

func_F1FB() {
  self endon("death");
  var_00 = 1;
  for(var_01 = 0; var_01 < 4; var_01++) {
    if(soundexists("c12_selfdestruct_beep")) {
      self playSound("c12_selfdestruct_beep");
      wait(0.8);
    } else {
      wait(1);
    }

    var_00 = var_00 - 0.2;
    var_00 = max(0, var_00);
    if(var_00 > 0) {
      wait(var_00);
    }
  }
}

func_35AD(param_00, param_01) {
  if(scripts\asm\asm_bb::ispartdismembered("right_arm") || scripts\asm\asm_bb::ispartdismembered("right_leg") || scripts\asm\asm_bb::ispartdismembered("left_leg")) {
    return 0;
  }

  if(scripts\asm\asm_bb::bb_isrodeorequested()) {
    return 0;
  }

  var_02 = self.isnodeoccupied;
  if(isDefined(param_00)) {
    var_02 = param_00;
  }

  if(!isplayer(var_02)) {
    return 0;
  }

  var_03 = vectortoyaw(var_02.origin - self.origin);
  if(abs(angleclamp180(var_03 - self.angles[1])) > 90) {
    return level.failure;
  }

  return lib_0A10::ismeleevalid(param_00, param_01);
}

func_128AE(param_00, param_01) {
  var_02 = self.var_1198.shootparams;
  var_03 = gettime();
  if(isDefined(self.asm.var_2AD2)) {
    var_02.var_A993 = var_03;
    return;
  }

  if(var_03 - var_02.var_A98F < 500) {
    return;
  }

  if(var_03 - var_02.var_A993 < 10000) {
    return;
  }

  if(!isDefined(param_01.ent)) {
    return;
  }

  var_04 = param_01.ent;
  var_05 = var_04.origin - self.origin;
  var_06 = lengthsquared(var_05);
  if(var_06 < -25536) {
    return;
  }

  var_02.var_A98F = var_03;
  var_07 = 128;
  var_08 = sqrt(var_06);
  if(var_08 < 800) {
    var_07 = var_07 * 1 - 800 - var_08 / 800;
  }

  var_07 = randomfloat(var_07);
  var_09 = randomfloat(360);
  var_0A = var_04.origin + (var_07 * cos(var_09), var_07 * sin(var_09), 0);
  if(param_00 == "left") {
    var_0B = "tag_brass_le";
  } else {
    var_0B = "tag_brass_ri";
  }

  var_0C = self gettagangles(var_0B);
  var_0D = self gettagorigin(var_0B) + rotatevector((0, -10, 0), var_0C);
  var_0E = self _meth_81ED(var_0D, var_0A);
  if(isDefined(var_0E)) {
    self playSound("c12_grenade_launch");
    var_0E makeunusable();
    var_02.var_A993 = var_03;
  }
}