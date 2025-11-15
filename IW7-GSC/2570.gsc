/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2570.gsc
************************/

func_97EF(param_00) {
  self.var_3135.var_C2 = spawnStruct();
  self.var_3135.var_C2.var_4C28 = "none";
  self.var_3135.var_C2.target_getindexoftarget = self.target_getindexoftarget;
  self.var_3135.var_C2.starttime = gettime();
  self.var_3135.var_C2.var_BF8A = gettime() + randomintrange(3000, 7000);
  self.var_1198.var_AA3D = self.target_getindexoftarget;
  if(isDefined(self.var_1198.var_522F)) {}

  scripts\aitypes\combat::func_12F28(param_00);
  if(self.target_getindexoftarget.type == "Cover Prone" || self.target_getindexoftarget.type == "Conceal Prone") {
    scripts\asm\asm_bb::bb_requestsmartobject("prone");
  }

  scripts\asm\asm_bb::bb_setcovernode(self.var_3135.var_C2.target_getindexoftarget);
  self.var_46A6 = self.origin;
  if(!isDefined(self.var_3135.var_C2.var_BFA5) || !isDefined(self.var_1198.shufflenode)) {
    func_F7B4();
  }

  func_F7B0();
  return level.success;
}

func_41A3(param_00) {
  if(scripts\asm\asm_bb::func_2932()) {
    scripts\asm\asm_bb::bb_setcovernode(undefined);
    scripts\asm\asm_bb::func_2961("hide");
    self.var_1198.var_522F = undefined;
    if(isDefined(self.vehicle_getspawnerarray)) {
      var_01 = "stand";
      if(isDefined(self.var_71A6)) {
        var_01 = self[[self.var_71A6]]();
      }

      scripts\asm\asm_bb::bb_requestsmartobject(var_01);
    }

    scripts\asm\asm_bb::func_295E(undefined);
    self.var_3135.var_C2 = undefined;
    self.var_BF7F = gettime() + 1000 + randomintrange(0, self.var_C4);
    scripts\asm\asm_bb::bb_setshootparams(undefined);
  }

  return level.success;
}

func_4746(param_00, param_01) {
  func_F6A4(param_01);
  return level.success;
}

func_F6A4(param_00) {
  if(param_00 == "hide" && self.var_3135.var_C2.var_4C28 == "exposed" || self.var_3135.var_C2.var_4C28 == "none") {
    func_9815();
  }

  scripts\asm\asm_bb::func_2961(param_00);
  self.var_3135.var_C2.var_4C28 = param_00;
}

func_7E42() {
  return self.var_3135.var_C2.var_4C28;
}

func_9D71(param_00) {
  return gettime() > self.var_3135.var_BF89;
}

func_F7B0(param_00) {
  if(self.unittype == "c6") {
    var_01 = 0;
    if(isDefined(self.isnodeoccupied)) {
      var_02 = distance(self.isnodeoccupied.origin, self.origin);
      if(var_02 > self.issentient && var_02 < self.issaverecentlyloaded) {
        var_01 = 1;
      }
    }

    if(var_01) {
      self.var_3135.var_BF89 = gettime() + randomintrange(6000, 11000);
      return;
    }

    self.var_3135.var_BF89 = gettime() + randomintrange(2000, 3000);
    return;
  }

  if(scripts\engine\utility::actor_is3d()) {
    if(!isDefined(param_00)) {
      if(isDefined(self.var_3135.var_C2) && isDefined(self.var_3135.var_C2.target_getindexoftarget)) {
        if(scripts\asm\shared_utility::func_C04A(self.var_3135.var_C2.target_getindexoftarget)) {
          param_00 = 1;
        }
      }
    }

    if(scripts\engine\utility::istrue(param_00)) {
      self.var_3135.var_BF89 = gettime() + randomintrange(5000, 9000);
      return;
    }

    self.var_3135.var_BF89 = gettime() + randomintrange(7000, 13000);
    return;
  }

  self.var_3135.var_BF89 = gettime() + randomintrange(6000, 11000);
}

func_BD18(param_00) {
  if(isDefined(self.var_71C4)) {
    self[[self.var_71C4]](param_00);
  }
}

func_10037(param_00) {
  if(isDefined(self.var_71CF)) {
    return self[[self.var_71CF]](param_00);
  }

  return level.failure;
}

func_B01D(param_00) {
  if(isDefined(self.var_71BE)) {
    return self[[self.var_71BE]](param_00);
  }

  return level.failure;
}

func_13059(param_00) {
  var_01 = self.sendmatchdata;
  var_02 = self.sendclientmatchdata;
  self.sendmatchdata = 0;
  self.sendclientmatchdata = 0;
  if(self _meth_83D4(param_00, 0)) {
    func_BD18(param_00);
    return 1;
  } else {}

  self.sendmatchdata = var_01;
  self.sendclientmatchdata = var_02;
  return 0;
}

func_470D() {
  if(self.logstring || self.var_FC) {
    return 0;
  }

  if(gettime() < self.var_3135.var_BF89) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  var_00 = self.var_3135.var_C2;
  if(var_00.var_4C28 == "hide" || isDefined(self.var_280A)) {
    if(!isDefined(self.var_1198.var_522F) || !func_9D96(self.var_1198.var_522F)) {
      return 1;
    }
  }

  return 0;
}

func_B019(param_00) {
  if(func_470D()) {
    var_01 = func_B01A(self.var_3135.var_C2.target_getindexoftarget);
    if(var_01) {
      self.var_3135.var_BF89 = gettime() + 1000;
      thread scripts\anim\battlechatter_ai::func_67D2();
    } else {
      func_F7B0();
    }
  }

  return level.success;
}

func_B01A(param_00) {
  if(self.script == "cover_arrival") {
    return 0;
  }

  var_01 = self getregendata();
  if(isDefined(var_01)) {
    if(!isDefined(self.target_getindexoftarget) || var_01 != self.target_getindexoftarget || isDefined(param_00) && var_01 != param_00) {
      if(func_13059(var_01)) {
        return 1;
      }
    }
  }

  return 0;
}

func_6A0D() {
  if(self.logstring || self.var_FC) {
    return 0;
  }

  if(isDefined(self.var_3135.var_C2)) {
    return 0;
  }

  if(!isDefined(self.var_1198.var_AA3D)) {
    return 0;
  }

  return 1;
}

func_12E92(param_00) {
  if(func_6A0D()) {
    if(!scripts\engine\utility::actor_is3d() && isDefined(self.vehicle_getspawnerarray) && distancesquared(self.vehicle_getspawnerarray, self.origin) > 4) {
      self.var_1198.var_AA3D = undefined;
      self.var_3135.var_BF89 = undefined;
    } else if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget != self.var_1198.var_AA3D) {
      self.var_1198.var_AA3D = undefined;
      self.var_3135.var_BF89 = undefined;
    } else {
      if(!isDefined(self.var_3135.var_BF89)) {
        func_F7B0(1);
      }

      if(gettime() >= self.var_3135.var_BF89) {
        var_01 = func_B01A(self.var_1198.var_AA3D);
        if(var_01) {
          func_F7B0(1);
        } else {
          self.var_3135.var_BF89 = gettime() + 1000;
        }
      }
    }
  }

  return level.success;
}

func_12D78(param_00) {
  var_01 = self.var_3135.var_C2.target_getindexoftarget;
  return level.success;
}

func_12DDF(param_00) {
  return level.success;
}

func_389B(param_00) {
  switch (param_00.type) {
    case "Cover Stand":
    case "Cover Crouch":
    case "Cover Stand 3D":
      return 1;

    default:
      return 0;
  }

  return 0;
}

func_8BEB(param_00) {
  return isDefined(self.var_1198.var_5D3B) && isDefined(self.var_1198.var_522F) && self.var_1198.var_522F == param_00;
}

func_FFE1(param_00) {
  var_01 = isDefined(self.target_getindexoftarget) && func_8BEB(self.target_getindexoftarget) && func_389B(self.target_getindexoftarget);
  var_02 = scripts\anim\utility_common::usingmg() || isDefined(scripts\asm\asm_bb::bb_getrequestedturret()) || var_01;
  if(var_02) {
    return level.success;
  }

  return level.failure;
}

func_12EA7(param_00) {
  func_F6A4("hide");
  return level.success;
}

func_9D96(param_00) {
  return self _meth_8199(param_00) || scripts\engine\utility::istrue(self.var_9327);
}

func_9D98() {
  return self _meth_8199() || scripts\engine\utility::istrue(self.var_9327);
}

func_9E43(param_00) {
  if(!isDefined(self.target_getindexoftarget) || self.target_getindexoftarget.type == "Path" || self.target_getindexoftarget.type == "Exposed" || scripts\engine\utility::isnodeexposed3d(self.target_getindexoftarget)) {
    return level.failure;
  }

  var_01 = 16;
  if(isDefined(self.vehicle_getspawnerarray)) {
    if(distancesquared(self.vehicle_getspawnerarray, self.origin) > var_01) {
      return level.failure;
    }
  } else if(self.sendmatchdata) {
    var_01 = 3600;
  } else if(isDefined(self.var_1198.var_522F) && self.target_getindexoftarget == self.var_1198.var_522F) {
    var_01 = 576;
  } else {
    var_01 = 225;
  }

  var_02 = undefined;
  if(scripts\engine\utility::actor_is3d()) {
    var_02 = distancesquared(self.origin, self.target_getindexoftarget.origin);
  } else {
    if(abs(self.origin[2] - self.target_getindexoftarget.origin[2]) > 80) {
      return level.failure;
    }

    var_02 = distance2dsquared(self.origin, self.target_getindexoftarget.origin);
  }

  if(var_02 > var_01) {
    return level.failure;
  }

  if(isDefined(self.var_3135.var_C2)) {
    if(!isDefined(self.var_3135.var_C2.target_getindexoftarget)) {
      return level.failure;
    }

    if(self.var_3135.var_C2.target_getindexoftarget != self.target_getindexoftarget) {
      return level.failure;
    }

    if(isDefined(self.isnodeoccupied)) {
      var_03 = 0;
      if(func_FFCB()) {
        var_03 = func_9D99(self.var_3135.var_C2.target_getindexoftarget);
      } else {
        var_03 = func_9D98();
      }

      if(!var_03 && !func_6E03()) {
        return level.failure;
      }
    }
  } else if(isDefined(self.isnodeoccupied)) {
    if(!func_9D98() && !func_6E03()) {
      return level.failure;
    }
  }

  return level.success;
}

func_6E03() {
  if(!self.logstring) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied.target_getindexoftarget) && !nodesvisible(self.target_getindexoftarget, self.isnodeoccupied.target_getindexoftarget)) {
    return 1;
  }

  if(!self seerecently(self.isnodeoccupied, 8)) {
    return 1;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return 1;
  }

  if(distancesquared(self.origin, self.isnodeoccupied.origin) > 4096) {
    var_00 = (0, 0, 50);
    var_01 = vectornormalize(self.isnodeoccupied.origin - self.origin);
    var_02 = self.origin + var_00;
    var_03 = var_02 + var_01 * 64;
    return !bullettracepassed(var_02, var_03, 0, self);
  }

  return 0;
}

func_FFCB() {
  return weaponclass(self.var_394) == "mg" || func_8BEB(self.var_3135.var_C2.target_getindexoftarget);
}

func_9D99(param_00) {
  if(!isDefined(self.isnodeoccupied) || !isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  var_01 = param_00.angles[1] - vectortoyaw(self.isnodeoccupied.origin - param_00.origin);
  var_01 = angleclamp180(var_01);
  if(var_01 < 0) {
    var_01 = -1 * var_01;
  }

  if(var_01 <= self.setmatchdatadef) {
    return 1;
  }

  return 0;
}

shouldrefundsuper(param_00, param_01) {
  var_02 = level.success;
  var_03 = level.failure;
  if(self.bulletsinclip > weaponclipsize(self.var_394) * param_01) {
    return var_03;
  }

  thread scripts\anim\battlechatter_ai::func_67D4();
  return var_02;
}

func_98C1(param_00) {
  func_9815();
}

func_4742(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("reload", "end")) {
    return level.failure;
  }

  scripts\asm\asm_bb::bb_requestreload(1);
  func_F6A4("hide");
  return level.running;
}

func_116FD(param_00) {
  scripts\asm\asm_bb::bb_requestreload(0);
}

func_9814(param_00) {
  func_F6A4("hide");
  if(isDefined(self.isnodeoccupied) && !isDefined(self.var_3135.var_C2.var_3C5B)) {
    func_F6A2();
  }
}

func_4721(param_00) {
  func_F6A4("hide");
  if(isDefined(self.isnodeoccupied) && !func_9D98()) {
    self.var_3135.var_BF89 = self.var_3135.var_BF89 - 1000;
  }

  return level.success;
}

func_F7D9(param_00) {
  var_01 = 2500;
  var_02 = 3500;
  self.var_3135.var_C2.var_C9FB = gettime() + randomintrange(var_01, var_02);
}

func_9815() {
  var_00 = gettime();
  self.var_3135.var_C2.var_11934 = var_00;
  func_F7D9(1);
}

func_116F7(param_00) {}

func_9D97(param_00) {
  if(isDefined(self.var_280A)) {
    return level.failure;
  }

  if(scripts\anim\utility_common::issuppressedwrapper()) {
    return level.success;
  }

  return level.failure;
}

func_38CB(param_00) {
  var_01 = self.target_getindexoftarget.type;
  if(var_01 == "Cover Left") {
    return level.success;
  } else if(var_01 == "Cover Right") {
    return level.success;
  } else if(var_01 == "Cover Stand" || var_01 == "Cover Stand 3D") {
    var_02 = self.target_getindexoftarget _meth_8169();
    foreach(var_04 in var_02) {
      if(var_04 == "over") {
        return level.success;
      }
    }

    return level.success;
  } else if(var_05 == "Cover Prone" || var_05 == "Conceal Prone") {
    return level.failure;
  }

  return level.failure;
}

func_10038(param_00) {
  if(func_7E42() != "hide") {
    return level.failure;
  }

  if(self.var_FC) {
    return level.failure;
  }

  if(!isDefined(self.var_3135.var_C2.var_11934)) {
    return level.failure;
  }

  if(!isDefined(self.var_3135.var_C2.var_C9FB)) {
    return level.failure;
  }

  if(gettime() < self.var_3135.var_C2.var_C9FB) {
    return level.failure;
  }

  return level.success;
}

func_9894(param_00) {
  var_01 = 500;
  var_02 = 1500;
  var_03 = gettime();
  self.var_3135.var_C2.var_B026 = var_03;
  self.var_3135.var_C2.var_B016 = randomintrange(var_01, var_02);
  self.var_3135.var_C2.var_B012 = 3000;
}

func_116F9(param_00) {
  if(isDefined(self.var_3135.var_C2)) {
    func_F7D9(0);
  }
}

func_4726(param_00) {
  func_F6A4("look");
  var_01 = self.var_3135.var_C2.var_B026;
  var_02 = self.var_3135.var_C2.var_B016;
  var_03 = self.var_3135.var_C2.var_B012;
  if(isDefined(self.vehicle_getspawnerarray)) {
    return level.success;
  }

  var_04 = gettime();
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end")) {
    var_03 = var_04 - var_01;
  }

  if(var_04 - var_01 > var_03 + var_02) {
    return level.success;
  }

  return level.running;
}

func_38E8(param_00) {
  var_01 = self.target_getindexoftarget.type;
  if(scripts\engine\utility::isnodecovercrouch(self.target_getindexoftarget)) {
    return level.success;
  } else if(var_01 == "Cover Stand" || var_01 == "Cover Stand 3D") {
    var_02 = self.target_getindexoftarget _meth_8169();
    foreach(var_04 in var_02) {
      if(var_04 == "over") {
        return level.success;
      }
    }

    return level.failure;
  } else if(var_05 == "Cover Right") {
    if(self.a.pose == "stand") {
      return level.success;
    } else {
      return level.failure;
    }
  } else if(var_05 == "Cover Left") {
    return level.success;
  } else if(var_05 == "Cover 3D") {
    return level.success;
  }

  return level.failure;
}

func_473E(param_00) {
  func_F6A4("peek");
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_peek", "end")) {
    return level.success;
  }

  return level.running;
}

func_116FC(param_00) {
  if(isDefined(self.var_3135.var_C2)) {
    func_F6A4("hide");
    func_F7D9(0);
  }
}

func_BDF3(param_00) {
  if(!isDefined(self.target_getindexoftarget) && self.a.pose == "prone") {
    return level.success;
  }

  if(self.target_getindexoftarget.type == "Conceal Prone" || self.target_getindexoftarget.type == "Cover Prone") {
    if(self.a.pose != "prone" || scripts\asm\asm_bb::func_292C() != "prone") {
      return level.success;
    }

    return level.failure;
  }

  if(!self getteleportlonertargetplayer(self.a.pose)) {
    return level.success;
  }

  var_01 = undefined;
  if(self.target_getindexoftarget getrandomattachments("stand") && !self.target_getindexoftarget getrandomattachments("crouch")) {
    var_01 = "stand";
  } else if(self.target_getindexoftarget getrandomattachments("crouch") && !self.target_getindexoftarget getrandomattachments("stand")) {
    var_01 = "crouch";
  }

  if(isDefined(var_01)) {
    scripts\asm\asm_bb::bb_requestsmartobject(var_01);
  }

  return level.failure;
}

func_FFD1(param_00) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(isDefined(self.var_DC5C) && self.a.pose == "stand") {
    return level.failure;
  }

  if(self.target_getindexoftarget.type != "Cover Right" && self.target_getindexoftarget.type != "Cover Left") {
    return level.failure;
  }

  if(scripts\engine\utility::isnodecover3d(self.target_getindexoftarget)) {
    return level.failure;
  }

  if(self.a.pose == "stand" && !self.target_getindexoftarget getrandomattachments("crouch")) {
    return level.failure;
  }

  if(self.a.pose == "crouch" && !self.target_getindexoftarget getrandomattachments("stand")) {
    return level.failure;
  }

  if(!isDefined(self.var_3135.var_C2.var_3C5B)) {
    func_F6A2();
  }

  if(gettime() < self.var_3135.var_C2.var_3C5B) {
    return level.failure;
  }

  return level.success;
}

func_F6A2() {
  self.var_3135.var_C2.var_3C5B = gettime() + randomintrange(5000, 20000);
}

func_97E4(param_00) {
  func_F6A2();
  self.a.var_D892 = undefined;
  var_01 = undefined;
  if((self.a.pose != "prone" || scripts\asm\asm_bb::func_292C() != "prone") && isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Conceal Prone" || self.target_getindexoftarget.type == "Cover Prone") {
    var_01 = "prone";
  } else {
    var_02 = ["stand", "crouch", "prone"];
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      var_04 = var_02[var_03];
      if(self getteleportlonertargetplayer(var_04)) {
        var_01 = var_04;
        break;
      }
    }
  }

  scripts\asm\asm_bb::bb_requestsmartobject(var_01);
  self.var_3135.var_C2.var_3C5C = gettime();
}

func_4712(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_stance_trans", "end")) {
    return level.success;
  }

  var_01 = 5000;
  var_02 = self.var_3135.var_C2.var_3C5C;
  if(gettime() - var_02 > var_01) {
    return level.success;
  }

  if(self.a.pose == scripts\asm\asm_bb::func_292C()) {
    return level.success;
  }

  return level.running;
}

func_116F1(param_00) {
  scripts\asm\asm_bb::bb_requestsmartobject(self.a.pose);
}

func_7E40(param_00, param_01) {
  if(param_00.type == "Cover Right") {
    if(param_01 == "stand") {
      return [-180, 12, -40, 0, -180, -38];
    }

    return [-180, 12, -40, 0, -180, -31];
  }

  if(param_00.type == "Cover Left") {
    if(param_01 == "stand") {
      return [-14, 180, 0, 40, 38, 180];
    }

    return [-14, 180, 0, 40, 31, 180];
  }

  return [-45, 45, 0, 0, 0, 0];
}

func_77C3(param_00, param_01) {
  if(param_00.type == "Cover 3D") {
    return [-65, 45, -55, 55];
  }

  return [-45, 45, -45, 45];
}

func_8C20(param_00) {
  var_01 = 36;
  var_02 = param_00.origin;
  if(scripts\engine\utility::isnodecoverright(param_00)) {
    var_02 = var_02 + anglestoright(param_00.angles) * var_01;
  } else {
    var_02 = var_02 + anglestoleft(param_00.angles) * var_01;
  }

  return self maymovetopoint(var_02, 0, 0);
}

func_4749(param_00) {
  if(self.script == "cover_arrival" || self.script == "move") {
    return level.failure;
  }

  if(isDefined(self.var_280A)) {
    return level.success;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.target_getindexoftarget)) {
    if(scripts\engine\utility::isnodeexposed3d(self.target_getindexoftarget)) {
      return level.success;
    }

    var_01 = scripts\asm\shared_utility::getnodeforwardangles(self.target_getindexoftarget, 0);
    var_02 = angleclamp180(self.angles[0] - var_01[0]);
    var_03 = angleclamp180(self.angles[1] - var_01[1]);
    var_04 = angleclamp180(self.angles[2] - var_01[2]);
    if(abs(var_02) > 5 || abs(var_03) > 5 || abs(var_04) > 5) {
      return level.failure;
    }

    var_05 = self.isnodeoccupied.origin + scripts\anim\utility_common::getenemyeyepos() / 2;
    var_06 = var_05 - self.origin;
    var_07 = rotatevectorinverted(var_06, self.target_getindexoftarget.angles);
    var_08 = vectortoangles(var_07);
    var_02 = angleclamp180(var_08[0]);
    var_03 = angleclamp180(var_08[1]);
    var_09 = func_77C3(self.target_getindexoftarget, self.a.pose);
    if(var_02 > var_09[1] || var_02 < var_09[0]) {
      return level.failure;
    }

    if(var_03 > var_09[3] || var_03 < var_09[2]) {
      return level.failure;
    }

    return level.success;
  }

  var_0A = func_7E40(self.target_getindexoftarget, self.a.pose);
  var_0B = self.target_getindexoftarget.origin + scripts\anim\utility_common::getnodeoffset(self.target_getindexoftarget);
  var_06 = self.isnodeoccupied.origin - var_0B;
  var_0C = vectortoangles(var_0B);
  var_08 = angleclamp180(var_0C[1] - self.target_getindexoftarget.angles[1]);
  if(var_08[0] <= var_0C && var_0C <= var_08[1]) {
    if((scripts\engine\utility::isnodecoverright(self.target_getindexoftarget) && var_0C > var_08[3]) || scripts\engine\utility::isnodecoverleft(self.target_getindexoftarget) && var_0C < var_08[2]) {
      if(!func_8C20(self.target_getindexoftarget)) {
        return level.failure;
      }
    }

    return level.success;
  }

  return level.failure;
}

func_9803(param_00) {
  if(func_7E42() != "exposed") {
    self.var_3135.var_C2.var_11933 = gettime() + 3000;
  }

  self.var_3135.shootparams = spawnStruct();
  self.var_3135.shootparams.taskid = param_00;
  self.var_3135.m_bfiring = 0;
  var_01 = scripts\anim\utility_common::isasniper();
  if(var_01) {
    scripts\aitypes\combat::func_FE5D(self.var_3135.shootparams);
  }
}

func_116F4(param_00) {
  if(isDefined(self.var_3135.shootparams) && self.var_3135.shootparams.taskid == param_00) {
    self.var_3135.shootparams = undefined;
    self.var_3135.m_bfiring = undefined;
  }

  scripts\asm\asm_bb::bb_requestfire(0);
  scripts\asm\asm_bb::bb_setshootparams(undefined);
}

func_38C5() {
  if(weaponclass(self.var_394) == "rocketlauncher") {
    return 0;
  }

  return 1;
}

func_4B0B(param_00, param_01) {
  var_02 = ["exposed", "left", "right"];
  var_03 = [(0, 0, 46), (0, 0, 0), (0, 0, 0)];
  var_04 = [(0, 0, 0), (0, 32, 36), (0, -32, 36)];
  var_05 = [(0, 0, 36), (0, 0, 0), (0, 0, 0)];
  if(isDefined(self.var_1198.var_FEF0) && self.var_1198.var_FEF0 == param_00) {
    return self.var_1198.var_FEEF;
  }

  var_06 = [];
  var_07 = undefined;
  switch (param_00.type) {
    case "Cover Stand":
    case "Conceal Stand":
      var_07 = var_03;
      break;

    case "Cover Crouch Window":
    case "Cover Crouch":
    case "Conceal Crouch":
      var_07 = var_04;
      break;

    case "Cover Left":
    case "Cover Right":
      var_07 = var_05;
      break;

    default:
      return param_01;
  }

  foreach(var_09 in param_01) {
    if(var_09 == "full exposed") {
      var_06[var_06.size] = "full exposed";
      continue;
    }

    for(var_0A = 0; var_0A < var_02.size; var_0A++) {
      if(var_02[var_0A] == var_09) {
        break;
      }
    }

    var_0B = var_07[var_0A];
    var_0C = rotatevector(var_0B, param_00.angles) + param_00.origin;
    var_0D = anglesToForward(param_00.angles);
    var_0E = var_0C + var_0D * 32;
    if(sighttracepassed(var_0C, var_0E, 0, undefined)) {
      var_06[var_06.size] = var_09;
      continue;
    }
  }

  self.var_1198.var_FEF0 = param_00;
  self.var_1198.var_FEEF = var_06;
  return var_06;
}

func_471E(param_00) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  var_01 = self getentitynumber() * 3 % 1000;
  var_02 = 8000 + var_01;
  var_03 = 5000 + var_01;
  var_04 = 1000;
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end")) {
    self.var_3135.var_C2.var_11933 = gettime();
  }

  var_05 = self.var_3135.var_C2.var_11933;
  var_06 = gettime() - var_05;
  var_07 = self.var_3135.var_C2.target_getindexoftarget;
  if(isDefined(self.var_280A)) {
    func_4748(param_00);
    if(scripts\engine\utility::isnodecoverleft(var_07) || scripts\engine\utility::isnodecoverright(var_07)) {
      scripts\asm\asm_bb::func_295E("B");
    } else {
      scripts\asm\asm_bb::func_295E("full exposed");
    }

    func_F6A4("exposed");
    if(shouldrefundsuper(param_00, 0) == level.success) {
      scripts\asm\asm_bb::bb_requestreload(1);
    } else {
      scripts\asm\asm_bb::bb_requestreload(0);
    }

    return level.running;
  }

  if(shouldrefundsuper(param_00, 0) == level.success && var_06 > var_04) {
    return level.failure;
  }

  var_08 = undefined;
  var_09 = undefined;
  var_0A = undefined;
  if(scripts\engine\utility::actor_is3d()) {
    var_0B = self.isnodeoccupied.origin + scripts\anim\utility_common::getenemyeyepos() / 2;
    var_0C = var_0B - self getEye();
    if(scripts\engine\utility::isnodeexposed3d(var_07)) {
      var_0A = vectortoangles(var_0C);
    } else if(scripts\engine\utility::isnode3d(var_07)) {
      var_08 = func_77C3(var_07, self.a.pose);
      var_0C = rotatevectorinverted(var_0C, var_07.angles);
      var_0A = vectortoangles(var_0C);
      var_0D = angleclamp180(var_0A[0]);
      var_0E = angleclamp180(var_0A[1]);
      if(var_0D > var_08[1] || var_0D < var_08[0]) {
        return level.failure;
      }

      if(var_0E > var_08[3] || var_0E < var_08[2]) {
        return level.failure;
      }
    }
  } else {
    var_09 = func_7E40(var_08, self.a.pose);
    var_0F = var_08.origin + scripts\anim\utility_common::getnodeoffset(var_08);
    var_0C = scripts\anim\utility_common::getenemyeyepos() - var_0F;
    var_0A = vectortoangles(var_0C);
    var_09 = angleclamp180(var_0A[1] - var_07.angles[1]);
    if(var_09 < var_08[0] || var_09 > var_08[1]) {
      return level.failure;
    }
  }

  var_10 = func_4748(param_00);
  if(!isDefined(self.var_3135.shootparams.var_29AF)) {
    if(!var_10) {
      if(var_06 > var_03) {
        return level.failure;
      }
    } else if(var_06 > var_02) {
      return level.failure;
    }
  }

  if(scripts\engine\utility::isnodecoverleft(var_07) || scripts\engine\utility::isnodecoverright(var_07)) {
    var_11 = scripts\asm\asm_bb::func_2929();
    var_12 = func_7E42() == "exposed";
    var_13 = !isDefined(var_11) || var_12;
    if(!var_13) {
      var_13 = randomint(100) < 20;
    }

    var_14 = isDefined(var_11) && var_11 == "lean" && var_12;
    var_15 = [];
    if(func_38C5() && var_08[2] <= var_09 && var_09 <= var_08[3]) {
      if(var_14) {
        scripts\asm\asm_bb::func_295E("lean");
        return level.running;
      } else if(!var_12 && var_13 || var_11 != "lean") {
        var_15[var_15.size] = "lean";
      }
    } else if(var_14) {
      return level.failure;
    }

    if(isDefined(var_11) && func_7E42() == "exposed") {
      if(var_11 == "A") {
        var_08[4] = var_08[4] - 5;
        var_08[5] = var_08[5] + 5;
      } else {
        var_08[4] = var_08[4] + 5;
        var_08[5] = var_08[5] - 5;
      }
    }

    if(var_08[4] <= var_09 && var_09 <= var_08[5]) {
      if(var_13 || var_11 != "A") {
        var_15[var_15.size] = "A";
      }
    } else if(var_13 || var_11 != "B") {
      if(func_8C20(var_07)) {
        var_15[var_15.size] = "B";
      } else if(var_15.size == 0) {
        return level.failure;
      }
    }

    var_16 = undefined;
    if(var_15.size == 0) {
      var_16 = var_11;
    } else {
      var_16 = var_15[randomint(var_15.size)];
    }

    scripts\asm\asm_bb::func_295E(var_16);
  } else if(var_08.type == "Cover 3D") {
    var_11 = scripts\asm\asm_bb::func_2929();
    if(!isDefined(var_11) || func_7E42() != "exposed") {
      scripts\asm\asm_bb::func_295E("exposed");
    }
  } else {
    var_11 = scripts\asm\asm_bb::func_2929();
    var_17 = scripts\asm\asm_bb::bb_isshort();
    if(!isDefined(var_11) || func_7E42() != "exposed") {
      var_16 = undefined;
      if(scripts\engine\utility::isnodecovercrouch(var_07)) {
        var_18 = scripts\anim\utility_common::getenemyeyepos();
        var_19 = angleclamp180(var_0A[0]);
        if(var_19 > 25 || var_19 > 10 && var_17) {
          var_16 = "leanover";
        } else if(var_19 > 10) {
          var_16 = "full exposed";
        }
      }

      if(!isDefined(var_16)) {
        var_1A = var_07 _meth_8169();
        var_15 = ["full exposed"];
        foreach(var_1C in var_1A) {
          if(var_1C == "over") {
            var_15[var_15.size] = "exposed";
            continue;
          }

          if(hasroomtoplaypeekout(var_07, var_1C)) {
            var_15[var_15.size] = var_1C;
          }
        }

        if(var_17) {
          var_15 = func_4B0B(var_07, var_15);
        }

        var_16 = var_15[randomint(var_15.size)];
      }

      scripts\asm\asm_bb::func_295E(var_16);
    }
  }

  func_F6A4("exposed");
  return level.running;
}

func_4748(param_00) {
  var_01 = scripts\aitypes\combat::shouldshoot();
  if(!var_01) {
    return 0;
  }

  var_02 = self.var_3135.shootparams;
  if(self getpersstat(self.isnodeoccupied)) {
    var_02.pos = self.isnodeoccupied getshootatpos();
    var_02.ent = self.isnodeoccupied;
  } else {
    var_02.pos = self.goodshootpos;
    var_02.ent = undefined;
  }

  if(!isDefined(var_02.objective)) {
    var_02.objective = "normal";
  }

  scripts\asm\asm_bb::bb_setshootparams(var_02, self.isnodeoccupied);
  if(scripts\aitypes\combat::isaimedataimtarget()) {
    if(!self.var_3135.m_bfiring) {
      scripts\aitypes\combat::resetmisstime_code();
      scripts\aitypes\combat::chooseshootstyle(var_02);
      scripts\aitypes\combat::choosenumshotsandbursts(var_02);
    }

    scripts\aitypes\combat::func_3EF8(var_02);
    self.var_3135.m_bfiring = 1;
  } else {
    self.var_3135.m_bfiring = 0;
  }

  if(!isDefined(var_02.pos) && !isDefined(var_02.ent)) {
    self.var_3135.m_bfiring = 0;
    scripts\asm\asm_bb::bb_requestfire(0);
    return 0;
  }

  scripts\asm\asm_bb::bb_requestfire(self.var_3135.m_bfiring);
  return 1;
}

func_9DDA(param_00) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(distancesquared(self.isnodeoccupied.origin, self.var_46A6) < 256) {
    return level.failure;
  }

  if(scripts\anim\utility_common::canseeenemyfromexposed()) {
    return level.success;
  }

  return level.failure;
}

func_F7B4() {
  if(isDefined(self.var_3135.var_C2)) {
    self.var_3135.var_C2.var_BFA5 = gettime() + randomintrange(3000, 12000);
  }
}

func_3875() {
  if(self.team == "allies") {
    return 0;
  }

  if(self.unittype == "c6") {
    return 0;
  }

  if(!scripts\anim\weaponlist::usingautomaticweapon()) {
    return 0;
  }

  if(weaponclass(self.var_394) == "mg") {
    return 0;
  }

  if(isDefined(self.var_5507) && self.var_5507 == 1) {
    return 0;
  }

  if(isDefined(self.var_3135.var_C2.target_getindexoftarget.script_parameters) && self.var_3135.var_C2.target_getindexoftarget.script_parameters == "no_blindfire") {
    return 0;
  }

  var_00 = self.var_3135.var_C2.target_getindexoftarget.type;
  switch (var_00) {
    case "Cover Right":
      return self.a.pose == "stand";

    case "Cover Left":
      return self.a.pose == "stand";

    case "Cover Prone":
    case "Conceal Prone":
    case "Conceal Stand":
    case "Conceal Crouch":
      return 0;

    case "Cover Stand":
      var_01 = self.target_getindexoftarget _meth_8169();
      for(var_02 = 0; var_02 < var_01.size; var_02++) {
        if(var_01[var_02] == "over") {
          return 1;
        }
      }
      return 0;
  }

  return 1;
}

func_FFCC(param_00) {
  if(!func_3875()) {
    return level.failure;
  }

  if(gettime() < self.var_3135.var_C2.var_BFA5) {
    return level.failure;
  }

  if(!func_9DDA() && !scripts\anim\utility_common::cansuppressenemyfromexposed()) {
    return level.failure;
  }

  return level.success;
}

func_4711(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_blindfire", "end")) {
    return level.success;
  }

  scripts\asm\asm_bb::func_295D(1);
  return level.running;
}

func_116F0(param_00) {
  scripts\asm\asm_bb::func_295D(0);
  func_F7B4();
}

func_100AD(param_00) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(self.objective_state <= 0) {
    return level.failure;
  }

  if(self.objective_team == "none") {
    return level.failure;
  }

  if(isDefined(self.isnodeoccupied) && isDefined(self.isnodeoccupied.var_5963)) {
    return level.failure;
  }

  var_01 = self.var_3135.var_C2.target_getindexoftarget;
  if(var_01.type == "Cover Prone" || var_01.type == "Conceal Prone") {
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.var_C062)) {
    return level.failure;
  }

  var_02 = self.isnodeoccupied;
  var_03 = anglesToForward(var_01.angles);
  var_04 = var_02.origin - self.origin;
  var_05 = lengthsquared(var_04);
  var_06 = 2560000;
  if(var_05 > var_06) {
    return level.failure;
  }

  var_07 = vectornormalize(var_04);
  if(vectordot(var_03, var_07) < 0) {
    return level.failure;
  }

  var_08 = 0.4;
  var_09 = gettime();
  if(isDefined(self.var_3135.var_C2.var_A992) && var_09 < self.var_3135.var_C2.var_A992 + var_08) {
    return level.failure;
  }

  self.var_3135.var_C2.var_A992 = var_09;
  if(self.var_FC && !scripts\anim\utility_common::recentlysawenemy()) {
    return level.failure;
  }

  if(isDefined(self.dontevershoot) || isDefined(var_02.var_5951)) {
    return level.failure;
  }

  lib_0A18::func_F62B(self.isnodeoccupied);
  if(!lib_0A18::_meth_85B5(var_02)) {
    return level.failure;
  }

  if(scripts\anim\utility_common::canseeenemyfromexposed()) {
    if(!self _meth_81A2(var_02, var_02.origin)) {
      return level.failure;
    }

    return level.success;
  }

  if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
    return level.success;
  }

  if(!self _meth_81A2(var_02, var_02.origin)) {
    return level.failure;
  }

  return level.success;
}

func_98DB(param_00) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.isnodeoccupied);
  func_F6A4("hide");
  self.var_3135.instancedata[param_00] = gettime() + 3000;
}

func_474F(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0)) {
    self.var_3135.instancedata[param_00] = self.var_3135.instancedata[param_00] + 10000;
  }

  if(gettime() > self.var_3135.instancedata[param_00]) {
    return level.failure;
  }

  return level.running;
}

func_11700(param_00) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.var_3135.instancedata[param_00] = undefined;
}

func_6574(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 scripts\engine\utility::isflashed()) {
    return 1;
  }

  if(isplayer(param_00)) {
    if(isDefined(param_00.health) && param_00.health < param_00.maxhealth) {
      return 1;
    }
  } else if(isai(param_00) && param_00 scripts\anim\utility_common::issuppressedwrapper()) {
    return 1;
  }

  if(isDefined(param_00.isreloading) && param_00.isreloading) {
    return 1;
  }

  return 0;
}

func_B4ED(param_00, param_01) {
  if(isDefined(self.var_29CF) && self.var_29CF) {
    return level.failure;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(!isDefined(self.target_getindexoftarget)) {
    return level.failure;
  }

  if(scripts\engine\utility::isnodecover3d(self.target_getindexoftarget)) {
    return level.failure;
  }

  if(self.logstring || self.var_FC || self.sendclientmatchdata) {
    return level.failure;
  }

  if(isDefined(self.var_1198.coverstate) && self.var_1198.coverstate != "hide") {
    return level.failure;
  }

  var_02 = 16;
  if(!isDefined(self.vehicle_getspawnerarray)) {
    var_02 = 3600;
  }

  if(distancesquared(self.origin, self.target_getindexoftarget.origin) > var_02) {
    return level.failure;
  }

  var_03 = gettime();
  if(isDefined(self.var_1198.var_1016E) && var_03 < self.var_1198.var_1016E + 500) {
    return level.failure;
  }

  if(var_03 < self.var_3135.var_C2.var_BF8A) {
    return level.failure;
  }

  if(isDefined(param_01) && param_01) {
    if(randomint(3) == 0) {
      return level.failure;
    }
  }

  return level.success;
}

func_2546(param_00) {
  var_01 = self _meth_80E8();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  if(var_01 == self.target_getindexoftarget || var_01 == self.var_3135.var_C2.target_getindexoftarget) {
    return level.failure;
  }

  if(distancesquared(self.target_getindexoftarget.origin, var_01.origin) < 16) {
    return level.failure;
  }

  var_02 = self.sendmatchdata;
  self.sendmatchdata = 0;
  var_03 = self _meth_83D4(var_01);
  if(!var_03) {
    self.sendmatchdata = var_02;
    return level.failure;
  }

  self.var_1198.shufflenode = var_01;
  self.var_1198.var_1016E = gettime();
  self.var_1198.var_1016B = self.var_3135.var_C2.target_getindexoftarget;
  return level.running;
}

func_453E(param_00) {
  if(isDefined(self.var_3135.var_C2) && weaponclass(self.var_394) == "mg" && isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < 65536) {
    if(isDefined(self.var_101B4)) {
      scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.var_101B4));
    }
  }

  return level.success;
}

func_12E5D(param_00) {
  if(isDefined(self.var_280A)) {
    if(self.health < self.maxhealth * 0.75) {
      self.var_280A = undefined;
    } else if(isDefined(self.var_1198.scriptableparts) && self.var_1198.scriptableparts.size >= 2) {
      self.var_280A = undefined;
    }
  }

  return level.success;
}

func_9D40(param_00) {
  return isDefined(self.var_280A);
}