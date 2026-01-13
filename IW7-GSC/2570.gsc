/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2570.gsc
************************/

func_97EF(var_0) {
  self.bt.var_C2 = spawnStruct();
  self.bt.var_C2.var_4C28 = "none";
  self.bt.var_C2.target_getindexoftarget = self.target_getindexoftarget;
  self.bt.var_C2.starttime = gettime();
  self.bt.var_C2.var_BF8A = gettime() + randomintrange(3000, 7000);
  self._blackboard.var_AA3D = self.target_getindexoftarget;
  if(isDefined(self._blackboard.var_522F)) {}

  scripts\aitypes\combat::func_12F28(var_0);
  if(self.target_getindexoftarget.type == "Cover Prone" || self.target_getindexoftarget.type == "Conceal Prone") {
    scripts\asm\asm_bb::bb_requestsmartobject("prone");
  }

  scripts\asm\asm_bb::bb_setcovernode(self.bt.var_C2.target_getindexoftarget);
  self.var_46A6 = self.origin;
  if(!isDefined(self.bt.var_C2.var_BFA5) || !isDefined(self._blackboard.shufflenode)) {
    func_F7B4();
  }

  func_F7B0();
  return level.success;
}

func_41A3(var_0) {
  if(scripts\asm\asm_bb::func_2932()) {
    scripts\asm\asm_bb::bb_setcovernode(undefined);
    scripts\asm\asm_bb::func_2961("hide");
    self._blackboard.var_522F = undefined;
    if(isDefined(self.vehicle_getspawnerarray)) {
      var_1 = "stand";
      if(isDefined(self.var_71A6)) {
        var_1 = self[[self.var_71A6]]();
      }

      scripts\asm\asm_bb::bb_requestsmartobject(var_1);
    }

    scripts\asm\asm_bb::func_295E(undefined);
    self.bt.var_C2 = undefined;
    self.var_BF7F = gettime() + 1000 + randomintrange(0, self.var_C4);
    scripts\asm\asm_bb::bb_setshootparams(undefined);
  }

  return level.success;
}

func_4746(var_0, var_1) {
  func_F6A4(var_1);
  return level.success;
}

func_F6A4(var_0) {
  if(var_0 == "hide" && self.bt.var_C2.var_4C28 == "exposed" || self.bt.var_C2.var_4C28 == "none") {
    func_9815();
  }

  scripts\asm\asm_bb::func_2961(var_0);
  self.bt.var_C2.var_4C28 = var_0;
}

func_7E42() {
  return self.bt.var_C2.var_4C28;
}

func_9D71(var_0) {
  return gettime() > self.bt.var_BF89;
}

func_F7B0(var_0) {
  if(self.unittype == "c6") {
    var_1 = 0;
    if(isDefined(self.isnodeoccupied)) {
      var_2 = distance(self.isnodeoccupied.origin, self.origin);
      if(var_2 > self.issentient && var_2 < self.issaverecentlyloaded) {
        var_1 = 1;
      }
    }

    if(var_1) {
      self.bt.var_BF89 = gettime() + randomintrange(6000, 11000);
      return;
    }

    self.bt.var_BF89 = gettime() + randomintrange(2000, 3000);
    return;
  }

  if(scripts\engine\utility::actor_is3d()) {
    if(!isDefined(var_0)) {
      if(isDefined(self.bt.var_C2) && isDefined(self.bt.var_C2.target_getindexoftarget)) {
        if(scripts\asm\shared_utility::func_C04A(self.bt.var_C2.target_getindexoftarget)) {
          var_0 = 1;
        }
      }
    }

    if(scripts\engine\utility::istrue(var_0)) {
      self.bt.var_BF89 = gettime() + randomintrange(5000, 9000);
      return;
    }

    self.bt.var_BF89 = gettime() + randomintrange(7000, 13000);
    return;
  }

  self.bt.var_BF89 = gettime() + randomintrange(6000, 11000);
}

func_BD18(var_0) {
  if(isDefined(self.var_71C4)) {
    self[[self.var_71C4]](var_0);
  }
}

func_10037(var_0) {
  if(isDefined(self.var_71CF)) {
    return self[[self.var_71CF]](var_0);
  }

  return level.failure;
}

func_B01D(var_0) {
  if(isDefined(self.var_71BE)) {
    return self[[self.var_71BE]](var_0);
  }

  return level.failure;
}

func_13059(var_0) {
  var_1 = self.sendmatchdata;
  var_2 = self.sendclientmatchdata;
  self.sendmatchdata = 0;
  self.sendclientmatchdata = 0;
  if(self _meth_83D4(var_0, 0)) {
    func_BD18(var_0);
    return 1;
  }

  self.sendmatchdata = var_1;
  self.sendclientmatchdata = var_2;
  return 0;
}

func_470D() {
  if(self.logstring || self.var_FC) {
    return 0;
  }

  if(gettime() < self.bt.var_BF89) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  var_0 = self.bt.var_C2;
  if(var_0.var_4C28 == "hide" || isDefined(self.var_280A)) {
    if(!isDefined(self._blackboard.var_522F) || !func_9D96(self._blackboard.var_522F)) {
      return 1;
    }
  }

  return 0;
}

func_B019(var_0) {
  if(func_470D()) {
    var_1 = func_B01A(self.bt.var_C2.target_getindexoftarget);
    if(var_1) {
      self.bt.var_BF89 = gettime() + 1000;
      thread scripts\anim\battlechatter_ai::func_67D2();
    } else {
      func_F7B0();
    }
  }

  return level.success;
}

func_B01A(var_0) {
  if(self.script == "cover_arrival") {
    return 0;
  }

  var_1 = self getregendata();
  if(isDefined(var_1)) {
    if(!isDefined(self.target_getindexoftarget) || var_1 != self.target_getindexoftarget || isDefined(var_0) && var_1 != var_0) {
      if(func_13059(var_1)) {
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

  if(isDefined(self.bt.var_C2)) {
    return 0;
  }

  if(!isDefined(self._blackboard.var_AA3D)) {
    return 0;
  }

  return 1;
}

func_12E92(var_0) {
  if(func_6A0D()) {
    if(!scripts\engine\utility::actor_is3d() && isDefined(self.vehicle_getspawnerarray) && distancesquared(self.vehicle_getspawnerarray, self.origin) > 4) {
      self._blackboard.var_AA3D = undefined;
      self.bt.var_BF89 = undefined;
    } else if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget != self._blackboard.var_AA3D) {
      self._blackboard.var_AA3D = undefined;
      self.bt.var_BF89 = undefined;
    } else {
      if(!isDefined(self.bt.var_BF89)) {
        func_F7B0(1);
      }

      if(gettime() >= self.bt.var_BF89) {
        var_1 = func_B01A(self._blackboard.var_AA3D);
        if(var_1) {
          func_F7B0(1);
        } else {
          self.bt.var_BF89 = gettime() + 1000;
        }
      }
    }
  }

  return level.success;
}

func_12D78(var_0) {
  var_1 = self.bt.var_C2.target_getindexoftarget;
  return level.success;
}

func_12DDF(var_0) {
  return level.success;
}

func_389B(var_0) {
  switch (var_0.type) {
    case "Cover Stand":
    case "Cover Crouch":
    case "Cover Stand 3D":
      return 1;

    default:
      return 0;
  }

  return 0;
}

func_8BEB(var_0) {
  return isDefined(self._blackboard.var_5D3B) && isDefined(self._blackboard.var_522F) && self._blackboard.var_522F == var_0;
}

func_FFE1(var_0) {
  var_1 = isDefined(self.target_getindexoftarget) && func_8BEB(self.target_getindexoftarget) && func_389B(self.target_getindexoftarget);
  var_2 = scripts\anim\utility_common::usingmg() || isDefined(scripts\asm\asm_bb::bb_getrequestedturret()) || var_1;
  if(var_2) {
    return level.success;
  }

  return level.failure;
}

func_12EA7(var_0) {
  func_F6A4("hide");
  return level.success;
}

func_9D96(var_0) {
  return self _meth_8199(var_0) || scripts\engine\utility::istrue(self.var_9327);
}

func_9D98() {
  return self _meth_8199() || scripts\engine\utility::istrue(self.var_9327);
}

func_9E43(var_0) {
  if(!isDefined(self.target_getindexoftarget) || self.target_getindexoftarget.type == "Path" || self.target_getindexoftarget.type == "Exposed" || scripts\engine\utility::isnodeexposed3d(self.target_getindexoftarget)) {
    return level.failure;
  }

  var_1 = 16;
  if(isDefined(self.vehicle_getspawnerarray)) {
    if(distancesquared(self.vehicle_getspawnerarray, self.origin) > var_1) {
      return level.failure;
    }
  } else if(self.sendmatchdata) {
    var_1 = 3600;
  } else if(isDefined(self._blackboard.var_522F) && self.target_getindexoftarget == self._blackboard.var_522F) {
    var_1 = 576;
  } else {
    var_1 = 225;
  }

  var_2 = undefined;
  if(scripts\engine\utility::actor_is3d()) {
    var_2 = distancesquared(self.origin, self.target_getindexoftarget.origin);
  } else {
    if(abs(self.origin[2] - self.target_getindexoftarget.origin[2]) > 80) {
      return level.failure;
    }

    var_2 = distance2dsquared(self.origin, self.target_getindexoftarget.origin);
  }

  if(var_2 > var_1) {
    return level.failure;
  }

  if(isDefined(self.bt.var_C2)) {
    if(!isDefined(self.bt.var_C2.target_getindexoftarget)) {
      return level.failure;
    }

    if(self.bt.var_C2.target_getindexoftarget != self.target_getindexoftarget) {
      return level.failure;
    }

    if(isDefined(self.isnodeoccupied)) {
      var_3 = 0;
      if(func_FFCB()) {
        var_3 = func_9D99(self.bt.var_C2.target_getindexoftarget);
      } else {
        var_3 = func_9D98();
      }

      if(!var_3 && !func_6E03()) {
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
    var_0 = (0, 0, 50);
    var_1 = vectornormalize(self.isnodeoccupied.origin - self.origin);
    var_2 = self.origin + var_0;
    var_3 = var_2 + var_1 * 64;
    return !bullettracepassed(var_2, var_3, 0, self);
  }

  return 0;
}

func_FFCB() {
  return weaponclass(self.var_394) == "mg" || func_8BEB(self.bt.var_C2.target_getindexoftarget);
}

func_9D99(var_0) {
  if(!isDefined(self.isnodeoccupied) || !isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  var_1 = var_0.angles[1] - vectortoyaw(self.isnodeoccupied.origin - var_0.origin);
  var_1 = angleclamp180(var_1);
  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

  if(var_1 <= self.setmatchdatadef) {
    return 1;
  }

  return 0;
}

shouldrefundsuper(var_0, var_1) {
  var_2 = level.success;
  var_3 = level.failure;
  if(self.bulletsinclip > weaponclipsize(self.var_394) * var_1) {
    return var_3;
  }

  thread scripts\anim\battlechatter_ai::func_67D4();
  return var_2;
}

func_98C1(var_0) {
  func_9815();
}

func_4742(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("reload", "end")) {
    return level.failure;
  }

  scripts\asm\asm_bb::bb_requestreload(1);
  func_F6A4("hide");
  return level.running;
}

func_116FD(var_0) {
  scripts\asm\asm_bb::bb_requestreload(0);
}

func_9814(var_0) {
  func_F6A4("hide");
  if(isDefined(self.isnodeoccupied) && !isDefined(self.bt.var_C2.var_3C5B)) {
    func_F6A2();
  }
}

func_4721(var_0) {
  func_F6A4("hide");
  if(isDefined(self.isnodeoccupied) && !func_9D98()) {
    self.bt.var_BF89 = self.bt.var_BF89 - 1000;
  }

  return level.success;
}

func_F7D9(var_0) {
  var_1 = 2500;
  var_2 = 3500;
  self.bt.var_C2.var_C9FB = gettime() + randomintrange(var_1, var_2);
}

func_9815() {
  var_0 = gettime();
  self.bt.var_C2.var_11934 = var_0;
  func_F7D9(1);
}

func_116F7(var_0) {}

func_9D97(var_0) {
  if(isDefined(self.var_280A)) {
    return level.failure;
  }

  if(scripts\anim\utility_common::issuppressedwrapper()) {
    return level.success;
  }

  return level.failure;
}

func_38CB(var_0) {
  var_1 = self.target_getindexoftarget.type;
  if(var_1 == "Cover Left") {
    return level.success;
  } else if(var_1 == "Cover Right") {
    return level.success;
  } else if(var_1 == "Cover Stand" || var_1 == "Cover Stand 3D") {
    var_2 = self.target_getindexoftarget _meth_8169();
    foreach(var_4 in var_2) {
      if(var_4 == "over") {
        return level.success;
      }
    }

    return level.success;
  } else if(var_5 == "Cover Prone" || var_5 == "Conceal Prone") {
    return level.failure;
  }

  return level.failure;
}

func_10038(var_0) {
  if(func_7E42() != "hide") {
    return level.failure;
  }

  if(self.var_FC) {
    return level.failure;
  }

  if(!isDefined(self.bt.var_C2.var_11934)) {
    return level.failure;
  }

  if(!isDefined(self.bt.var_C2.var_C9FB)) {
    return level.failure;
  }

  if(gettime() < self.bt.var_C2.var_C9FB) {
    return level.failure;
  }

  return level.success;
}

func_9894(var_0) {
  var_1 = 500;
  var_2 = 1500;
  var_3 = gettime();
  self.bt.var_C2.var_B026 = var_3;
  self.bt.var_C2.var_B016 = randomintrange(var_1, var_2);
  self.bt.var_C2.var_B012 = 3000;
}

func_116F9(var_0) {
  if(isDefined(self.bt.var_C2)) {
    func_F7D9(0);
  }
}

func_4726(var_0) {
  func_F6A4("look");
  var_1 = self.bt.var_C2.var_B026;
  var_2 = self.bt.var_C2.var_B016;
  var_3 = self.bt.var_C2.var_B012;
  if(isDefined(self.vehicle_getspawnerarray)) {
    return level.success;
  }

  var_4 = gettime();
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end")) {
    var_3 = var_4 - var_1;
  }

  if(var_4 - var_1 > var_3 + var_2) {
    return level.success;
  }

  return level.running;
}

func_38E8(var_0) {
  var_1 = self.target_getindexoftarget.type;
  if(scripts\engine\utility::isnodecovercrouch(self.target_getindexoftarget)) {
    return level.success;
  } else if(var_1 == "Cover Stand" || var_1 == "Cover Stand 3D") {
    var_2 = self.target_getindexoftarget _meth_8169();
    foreach(var_4 in var_2) {
      if(var_4 == "over") {
        return level.success;
      }
    }

    return level.failure;
  } else if(var_5 == "Cover Right") {
    if(self.a.pose == "stand") {
      return level.success;
    } else {
      return level.failure;
    }
  } else if(var_5 == "Cover Left") {
    return level.success;
  } else if(var_5 == "Cover 3D") {
    return level.success;
  }

  return level.failure;
}

func_473E(var_0) {
  func_F6A4("peek");
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_peek", "end")) {
    return level.success;
  }

  return level.running;
}

func_116FC(var_0) {
  if(isDefined(self.bt.var_C2)) {
    func_F6A4("hide");
    func_F7D9(0);
  }
}

func_BDF3(var_0) {
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

  var_1 = undefined;
  if(self.target_getindexoftarget getrandomattachments("stand") && !self.target_getindexoftarget getrandomattachments("crouch")) {
    var_1 = "stand";
  } else if(self.target_getindexoftarget getrandomattachments("crouch") && !self.target_getindexoftarget getrandomattachments("stand")) {
    var_1 = "crouch";
  }

  if(isDefined(var_1)) {
    scripts\asm\asm_bb::bb_requestsmartobject(var_1);
  }

  return level.failure;
}

func_FFD1(var_0) {
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

  if(!isDefined(self.bt.var_C2.var_3C5B)) {
    func_F6A2();
  }

  if(gettime() < self.bt.var_C2.var_3C5B) {
    return level.failure;
  }

  return level.success;
}

func_F6A2() {
  self.bt.var_C2.var_3C5B = gettime() + randomintrange(5000, 20000);
}

func_97E4(var_0) {
  func_F6A2();
  self.a.var_D892 = undefined;
  var_1 = undefined;
  if((self.a.pose != "prone" || scripts\asm\asm_bb::func_292C() != "prone") && isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Conceal Prone" || self.target_getindexoftarget.type == "Cover Prone") {
    var_1 = "prone";
  } else {
    var_2 = ["stand", "crouch", "prone"];
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];
      if(self getteleportlonertargetplayer(var_4)) {
        var_1 = var_4;
        break;
      }
    }
  }

  scripts\asm\asm_bb::bb_requestsmartobject(var_1);
  self.bt.var_C2.var_3C5C = gettime();
}

func_4712(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_stance_trans", "end")) {
    return level.success;
  }

  var_1 = 5000;
  var_2 = self.bt.var_C2.var_3C5C;
  if(gettime() - var_2 > var_1) {
    return level.success;
  }

  if(self.a.pose == scripts\asm\asm_bb::func_292C()) {
    return level.success;
  }

  return level.running;
}

func_116F1(var_0) {
  scripts\asm\asm_bb::bb_requestsmartobject(self.a.pose);
}

func_7E40(var_0, var_1) {
  if(var_0.type == "Cover Right") {
    if(var_1 == "stand") {
      return [-180, 12, -40, 0, -180, -38];
    }

    return [-180, 12, -40, 0, -180, -31];
  }

  if(var_0.type == "Cover Left") {
    if(var_1 == "stand") {
      return [-14, 180, 0, 40, 38, 180];
    }

    return [-14, 180, 0, 40, 31, 180];
  }

  return [-45, 45, 0, 0, 0, 0];
}

func_77C3(var_0, var_1) {
  if(var_0.type == "Cover 3D") {
    return [-65, 45, -55, 55];
  }

  return [-45, 45, -45, 45];
}

func_8C20(var_0) {
  var_1 = 36;
  var_2 = var_0.origin;
  if(scripts\engine\utility::isnodecoverright(var_0)) {
    var_2 = var_2 + anglestoright(var_0.angles) * var_1;
  } else {
    var_2 = var_2 + anglestoleft(var_0.angles) * var_1;
  }

  return self maymovetopoint(var_2, 0, 0);
}

func_4749(var_0) {
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

    var_1 = scripts\asm\shared_utility::getnodeforwardangles(self.target_getindexoftarget, 0);
    var_2 = angleclamp180(self.angles[0] - var_1[0]);
    var_3 = angleclamp180(self.angles[1] - var_1[1]);
    var_4 = angleclamp180(self.angles[2] - var_1[2]);
    if(abs(var_2) > 5 || abs(var_3) > 5 || abs(var_4) > 5) {
      return level.failure;
    }

    var_5 = self.isnodeoccupied.origin + scripts\anim\utility_common::getenemyeyepos() / 2;
    var_6 = var_5 - self.origin;
    var_7 = rotatevectorinverted(var_6, self.target_getindexoftarget.angles);
    var_8 = vectortoangles(var_7);
    var_2 = angleclamp180(var_8[0]);
    var_3 = angleclamp180(var_8[1]);
    var_9 = func_77C3(self.target_getindexoftarget, self.a.pose);
    if(var_2 > var_9[1] || var_2 < var_9[0]) {
      return level.failure;
    }

    if(var_3 > var_9[3] || var_3 < var_9[2]) {
      return level.failure;
    }

    return level.success;
  }

  var_0A = func_7E40(self.target_getindexoftarget, self.a.pose);
  var_0B = self.target_getindexoftarget.origin + scripts\anim\utility_common::getnodeoffset(self.target_getindexoftarget);
  var_6 = self.isnodeoccupied.origin - var_0B;
  var_0C = vectortoangles(var_0B);
  var_8 = angleclamp180(var_0C[1] - self.target_getindexoftarget.angles[1]);
  if(var_8[0] <= var_0C && var_0C <= var_8[1]) {
    if((scripts\engine\utility::isnodecoverright(self.target_getindexoftarget) && var_0C > var_8[3]) || scripts\engine\utility::isnodecoverleft(self.target_getindexoftarget) && var_0C < var_8[2]) {
      if(!func_8C20(self.target_getindexoftarget)) {
        return level.failure;
      }
    }

    return level.success;
  }

  return level.failure;
}

func_9803(var_0) {
  if(func_7E42() != "exposed") {
    self.bt.var_C2.var_11933 = gettime() + 3000;
  }

  self.bt.shootparams = spawnStruct();
  self.bt.shootparams.taskid = var_0;
  self.bt.m_bfiring = 0;
  var_1 = scripts\anim\utility_common::isasniper();
  if(var_1) {
    scripts\aitypes\combat::func_FE5D(self.bt.shootparams);
  }
}

func_116F4(var_0) {
  if(isDefined(self.bt.shootparams) && self.bt.shootparams.taskid == var_0) {
    self.bt.shootparams = undefined;
    self.bt.m_bfiring = undefined;
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

func_4B0B(var_0, var_1) {
  var_2 = ["exposed", "left", "right"];
  var_3 = [(0, 0, 46), (0, 0, 0), (0, 0, 0)];
  var_4 = [(0, 0, 0), (0, 32, 36), (0, -32, 36)];
  var_5 = [(0, 0, 36), (0, 0, 0), (0, 0, 0)];
  if(isDefined(self._blackboard.var_FEF0) && self._blackboard.var_FEF0 == var_0) {
    return self._blackboard.var_FEEF;
  }

  var_6 = [];
  var_7 = undefined;
  switch (var_0.type) {
    case "Cover Stand":
    case "Conceal Stand":
      var_7 = var_3;
      break;

    case "Cover Crouch Window":
    case "Cover Crouch":
    case "Conceal Crouch":
      var_7 = var_4;
      break;

    case "Cover Left":
    case "Cover Right":
      var_7 = var_5;
      break;

    default:
      return var_1;
  }

  foreach(var_9 in var_1) {
    if(var_9 == "full exposed") {
      var_6[var_6.size] = "full exposed";
      continue;
    }

    for(var_0A = 0; var_0A < var_2.size; var_0A++) {
      if(var_2[var_0A] == var_9) {
        break;
      }
    }

    var_0B = var_7[var_0A];
    var_0C = rotatevector(var_0B, var_0.angles) + var_0.origin;
    var_0D = anglesToForward(var_0.angles);
    var_0E = var_0C + var_0D * 32;
    if(sighttracepassed(var_0C, var_0E, 0, undefined)) {
      var_6[var_6.size] = var_9;
      continue;
    }
  }

  self._blackboard.var_FEF0 = var_0;
  self._blackboard.var_FEEF = var_6;
  return var_6;
}

func_471E(var_0) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  var_1 = self getentitynumber() * 3 % 1000;
  var_2 = 8000 + var_1;
  var_3 = 5000 + var_1;
  var_4 = 1000;
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end")) {
    self.bt.var_C2.var_11933 = gettime();
  }

  var_5 = self.bt.var_C2.var_11933;
  var_6 = gettime() - var_5;
  var_7 = self.bt.var_C2.target_getindexoftarget;
  if(isDefined(self.var_280A)) {
    func_4748(var_0);
    if(scripts\engine\utility::isnodecoverleft(var_7) || scripts\engine\utility::isnodecoverright(var_7)) {
      scripts\asm\asm_bb::func_295E("B");
    } else {
      scripts\asm\asm_bb::func_295E("full exposed");
    }

    func_F6A4("exposed");
    if(shouldrefundsuper(var_0, 0) == level.success) {
      scripts\asm\asm_bb::bb_requestreload(1);
    } else {
      scripts\asm\asm_bb::bb_requestreload(0);
    }

    return level.running;
  }

  if(shouldrefundsuper(var_0, 0) == level.success && var_6 > var_4) {
    return level.failure;
  }

  var_8 = undefined;
  var_9 = undefined;
  var_0A = undefined;
  if(scripts\engine\utility::actor_is3d()) {
    var_0B = self.isnodeoccupied.origin + scripts\anim\utility_common::getenemyeyepos() / 2;
    var_0C = var_0B - self getEye();
    if(scripts\engine\utility::isnodeexposed3d(var_7)) {
      var_0A = vectortoangles(var_0C);
    } else if(scripts\engine\utility::isnode3d(var_7)) {
      var_8 = func_77C3(var_7, self.a.pose);
      var_0C = rotatevectorinverted(var_0C, var_7.angles);
      var_0A = vectortoangles(var_0C);
      var_0D = angleclamp180(var_0A[0]);
      var_0E = angleclamp180(var_0A[1]);
      if(var_0D > var_8[1] || var_0D < var_8[0]) {
        return level.failure;
      }

      if(var_0E > var_8[3] || var_0E < var_8[2]) {
        return level.failure;
      }
    }
  } else {
    var_9 = func_7E40(var_8, self.a.pose);
    var_0F = var_8.origin + scripts\anim\utility_common::getnodeoffset(var_8);
    var_0C = scripts\anim\utility_common::getenemyeyepos() - var_0F;
    var_0A = vectortoangles(var_0C);
    var_9 = angleclamp180(var_0A[1] - var_7.angles[1]);
    if(var_9 < var_8[0] || var_9 > var_8[1]) {
      return level.failure;
    }
  }

  var_10 = func_4748(var_0);
  if(!isDefined(self.bt.shootparams.var_29AF)) {
    if(!var_10) {
      if(var_6 > var_3) {
        return level.failure;
      }
    } else if(var_6 > var_2) {
      return level.failure;
    }
  }

  if(scripts\engine\utility::isnodecoverleft(var_7) || scripts\engine\utility::isnodecoverright(var_7)) {
    var_11 = scripts\asm\asm_bb::func_2929();
    var_12 = func_7E42() == "exposed";
    var_13 = !isDefined(var_11) || var_12;
    if(!var_13) {
      var_13 = randomint(100) < 20;
    }

    var_14 = isDefined(var_11) && var_11 == "lean" && var_12;
    var_15 = [];
    if(func_38C5() && var_8[2] <= var_9 && var_9 <= var_8[3]) {
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
        var_8[4] = var_8[4] - 5;
        var_8[5] = var_8[5] + 5;
      } else {
        var_8[4] = var_8[4] + 5;
        var_8[5] = var_8[5] - 5;
      }
    }

    if(var_8[4] <= var_9 && var_9 <= var_8[5]) {
      if(var_13 || var_11 != "A") {
        var_15[var_15.size] = "A";
      }
    } else if(var_13 || var_11 != "B") {
      if(func_8C20(var_7)) {
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
  } else if(var_8.type == "Cover 3D") {
    var_11 = scripts\asm\asm_bb::func_2929();
    if(!isDefined(var_11) || func_7E42() != "exposed") {
      scripts\asm\asm_bb::func_295E("exposed");
    }
  } else {
    var_11 = scripts\asm\asm_bb::func_2929();
    var_17 = scripts\asm\asm_bb::bb_isshort();
    if(!isDefined(var_11) || func_7E42() != "exposed") {
      var_16 = undefined;
      if(scripts\engine\utility::isnodecovercrouch(var_7)) {
        var_18 = scripts\anim\utility_common::getenemyeyepos();
        var_19 = angleclamp180(var_0A[0]);
        if(var_19 > 25 || var_19 > 10 && var_17) {
          var_16 = "leanover";
        } else if(var_19 > 10) {
          var_16 = "full exposed";
        }
      }

      if(!isDefined(var_16)) {
        var_1A = var_7 _meth_8169();
        var_15 = ["full exposed"];
        foreach(var_1C in var_1A) {
          if(var_1C == "over") {
            var_15[var_15.size] = "exposed";
            continue;
          }

          if(hasroomtoplaypeekout(var_7, var_1C)) {
            var_15[var_15.size] = var_1C;
          }
        }

        if(var_17) {
          var_15 = func_4B0B(var_7, var_15);
        }

        var_16 = var_15[randomint(var_15.size)];
      }

      scripts\asm\asm_bb::func_295E(var_16);
    }
  }

  func_F6A4("exposed");
  return level.running;
}

func_4748(var_0) {
  var_1 = scripts\aitypes\combat::shouldshoot();
  if(!var_1) {
    return 0;
  }

  var_2 = self.bt.shootparams;
  if(self getpersstat(self.isnodeoccupied)) {
    var_2.pos = self.isnodeoccupied getshootatpos();
    var_2.ent = self.isnodeoccupied;
  } else {
    var_2.pos = self.goodshootpos;
    var_2.ent = undefined;
  }

  if(!isDefined(var_2.objective)) {
    var_2.objective = "normal";
  }

  scripts\asm\asm_bb::bb_setshootparams(var_2, self.isnodeoccupied);
  if(scripts\aitypes\combat::isaimedataimtarget()) {
    if(!self.bt.m_bfiring) {
      scripts\aitypes\combat::resetmisstime_code();
      scripts\aitypes\combat::chooseshootstyle(var_2);
      scripts\aitypes\combat::choosenumshotsandbursts(var_2);
    }

    scripts\aitypes\combat::func_3EF8(var_2);
    self.bt.m_bfiring = 1;
  } else {
    self.bt.m_bfiring = 0;
  }

  if(!isDefined(var_2.pos) && !isDefined(var_2.ent)) {
    self.bt.m_bfiring = 0;
    scripts\asm\asm_bb::bb_requestfire(0);
    return 0;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return 1;
}

func_9DDA(var_0) {
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
  if(isDefined(self.bt.var_C2)) {
    self.bt.var_C2.var_BFA5 = gettime() + randomintrange(3000, 12000);
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

  if(isDefined(self.bt.var_C2.target_getindexoftarget.script_parameters) && self.bt.var_C2.target_getindexoftarget.script_parameters == "no_blindfire") {
    return 0;
  }

  var_0 = self.bt.var_C2.target_getindexoftarget.type;
  switch (var_0) {
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
      var_1 = self.target_getindexoftarget _meth_8169();
      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        if(var_1[var_2] == "over") {
          return 1;
        }
      }
      return 0;
  }

  return 1;
}

func_FFCC(var_0) {
  if(!func_3875()) {
    return level.failure;
  }

  if(gettime() < self.bt.var_C2.var_BFA5) {
    return level.failure;
  }

  if(!func_9DDA() && !scripts\anim\utility_common::cansuppressenemyfromexposed()) {
    return level.failure;
  }

  return level.success;
}

func_4711(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_blindfire", "end")) {
    return level.success;
  }

  scripts\asm\asm_bb::func_295D(1);
  return level.running;
}

func_116F0(var_0) {
  scripts\asm\asm_bb::func_295D(0);
  func_F7B4();
}

func_100AD(var_0) {
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

  var_1 = self.bt.var_C2.target_getindexoftarget;
  if(var_1.type == "Cover Prone" || var_1.type == "Conceal Prone") {
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.var_C062)) {
    return level.failure;
  }

  var_2 = self.isnodeoccupied;
  var_3 = anglesToForward(var_1.angles);
  var_4 = var_2.origin - self.origin;
  var_5 = lengthsquared(var_4);
  var_6 = 2560000;
  if(var_5 > var_6) {
    return level.failure;
  }

  var_7 = vectornormalize(var_4);
  if(vectordot(var_3, var_7) < 0) {
    return level.failure;
  }

  var_8 = 0.4;
  var_9 = gettime();
  if(isDefined(self.bt.var_C2.var_A992) && var_9 < self.bt.var_C2.var_A992 + var_8) {
    return level.failure;
  }

  self.bt.var_C2.var_A992 = var_9;
  if(self.var_FC && !scripts\anim\utility_common::recentlysawenemy()) {
    return level.failure;
  }

  if(isDefined(self.dontevershoot) || isDefined(var_2.var_5951)) {
    return level.failure;
  }

  lib_0A18::func_F62B(self.isnodeoccupied);
  if(!lib_0A18::_meth_85B5(var_2)) {
    return level.failure;
  }

  if(scripts\anim\utility_common::canseeenemyfromexposed()) {
    if(!self _meth_81A2(var_2, var_2.origin)) {
      return level.failure;
    }

    return level.success;
  }

  if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
    return level.success;
  }

  if(!self _meth_81A2(var_2, var_2.origin)) {
    return level.failure;
  }

  return level.success;
}

func_98DB(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.isnodeoccupied);
  func_F6A4("hide");
  self.bt.instancedata[var_0] = gettime() + 3000;
}

func_474F(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0)) {
    self.bt.instancedata[var_0] = self.bt.instancedata[var_0] + 10000;
  }

  if(gettime() > self.bt.instancedata[var_0]) {
    return level.failure;
  }

  return level.running;
}

func_11700(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var_0] = undefined;
}

func_6574(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 scripts\engine\utility::isflashed()) {
    return 1;
  }

  if(isplayer(var_0)) {
    if(isDefined(var_0.health) && var_0.health < var_0.maxhealth) {
      return 1;
    }
  } else if(isai(var_0) && var_0 scripts\anim\utility_common::issuppressedwrapper()) {
    return 1;
  }

  if(isDefined(var_0.isreloading) && var_0.isreloading) {
    return 1;
  }

  return 0;
}

func_B4ED(var_0, var_1) {
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

  if(isDefined(self._blackboard.coverstate) && self._blackboard.coverstate != "hide") {
    return level.failure;
  }

  var_2 = 16;
  if(!isDefined(self.vehicle_getspawnerarray)) {
    var_2 = 3600;
  }

  if(distancesquared(self.origin, self.target_getindexoftarget.origin) > var_2) {
    return level.failure;
  }

  var_3 = gettime();
  if(isDefined(self._blackboard.var_1016E) && var_3 < self._blackboard.var_1016E + 500) {
    return level.failure;
  }

  if(var_3 < self.bt.var_C2.var_BF8A) {
    return level.failure;
  }

  if(isDefined(var_1) && var_1) {
    if(randomint(3) == 0) {
      return level.failure;
    }
  }

  return level.success;
}

func_2546(var_0) {
  var_1 = self _meth_80E8();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  if(var_1 == self.target_getindexoftarget || var_1 == self.bt.var_C2.target_getindexoftarget) {
    return level.failure;
  }

  if(distancesquared(self.target_getindexoftarget.origin, var_1.origin) < 16) {
    return level.failure;
  }

  var_2 = self.sendmatchdata;
  self.sendmatchdata = 0;
  var_3 = self _meth_83D4(var_1);
  if(!var_3) {
    self.sendmatchdata = var_2;
    return level.failure;
  }

  self._blackboard.shufflenode = var_1;
  self._blackboard.var_1016E = gettime();
  self._blackboard.var_1016B = self.bt.var_C2.target_getindexoftarget;
  return level.running;
}

func_453E(var_0) {
  if(isDefined(self.bt.var_C2) && weaponclass(self.var_394) == "mg" && isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < 65536) {
    if(isDefined(self.var_101B4)) {
      scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.var_101B4));
    }
  }

  return level.success;
}

func_12E5D(var_0) {
  if(isDefined(self.var_280A)) {
    if(self.health < self.maxhealth * 0.75) {
      self.var_280A = undefined;
    } else if(isDefined(self._blackboard.scriptableparts) && self._blackboard.scriptableparts.size >= 2) {
      self.var_280A = undefined;
    }
  }

  return level.success;
}

func_9D40(var_0) {
  return isDefined(self.var_280A);
}