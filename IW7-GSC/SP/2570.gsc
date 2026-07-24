/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2570.gsc
**************************************/

_id_97EF(var_0) {
  self.bt.cover = spawnStruct();
  self.bt.cover._id_4C28 = "none";
  self.bt.cover.node = self.node;
  self.bt.cover.starttime = gettime();
  self.bt.cover._id_BF8A = gettime() + randomintrange(3000, 7000);
  self._blackboard._id_AA3D = self.node;

  if(isDefined(self._blackboard._id_522F)) {}

  scripts\aitypes\combat::_id_12F28(var_0);

  if(self.node.type == "Cover Prone" || self.node.type == "Conceal Prone")
    scripts\asm\asm_bb::bb_requestsmartobject("prone");

  scripts\asm\asm_bb::bb_setcovernode(self.bt.cover.node);
  self._id_46A6 = self.origin;

  if(!isDefined(self.bt.cover._id_BFA5) || !isDefined(self._blackboard.shufflenode))
    _id_F7B4();

  _id_F7B0();
  return anim.success;
}

_id_41A3(var_0) {
  if(scripts\asm\asm_bb::_id_2932()) {
    scripts\asm\asm_bb::bb_setcovernode(undefined);
    scripts\asm\asm_bb::_id_2961("hide");

    if(isDefined(self.pathgoalpos)) {
      var_1 = "stand";

      if(isDefined(self._id_71A6))
        var_1 = self[[self._id_71A6]]();

      scripts\asm\asm_bb::bb_requestsmartobject(var_1);
    }

    scripts\asm\asm_bb::_id_295E(undefined);
    self.bt.cover = undefined;
    self._id_BF7F = gettime() + 1000 + randomintrange(0, self.coversearchinterval);
    scripts\asm\asm_bb::bb_setshootparams(undefined);
  }

  return anim.success;
}

_id_4746(var_0, var_1) {
  _id_F6A4(var_1);
  return anim.success;
}

_id_F6A4(var_0) {
  if(var_0 == "hide" && (self.bt.cover._id_4C28 == "exposed" || self.bt.cover._id_4C28 == "none"))
    _id_9815();

  scripts\asm\asm_bb::_id_2961(var_0);
  self.bt.cover._id_4C28 = var_0;
}

_id_7E42() {
  return self.bt.cover._id_4C28;
}

_id_9D71(var_0) {
  return gettime() > self.bt._id_BF89;
}

_id_F7B0(var_0) {
  if(self.unittype == "c6") {
    var_1 = 0;

    if(isDefined(self.enemy)) {
      var_2 = distance(self.enemy.origin, self.origin);

      if(var_2 > self.engagemindist && var_2 < self.engagemaxdist)
        var_1 = 1;
    }

    if(var_1) {
      self.bt._id_BF89 = gettime() + randomintrange(6000, 11000);
      return;
    }

    self.bt._id_BF89 = gettime() + randomintrange(2000, 3000);
    return;
  } else if(scripts\engine\utility::actor_is3d()) {
    if(!isDefined(var_0)) {
      if(isDefined(self.bt.cover) && isDefined(self.bt.cover.node)) {
        if(scripts\asm\shared\utility::_id_C04A(self.bt.cover.node))
          var_0 = 1;
      }
    }

    if(scripts\engine\utility::is_true(var_0))
      self.bt._id_BF89 = gettime() + randomintrange(5000, 9000);
    else
      self.bt._id_BF89 = gettime() + randomintrange(7000, 13000);
  } else
    self.bt._id_BF89 = gettime() + randomintrange(6000, 11000);
}

_id_BD18(var_0) {
  if(isDefined(self._id_71C4))
    self[[self._id_71C4]](var_0);
}

_id_10037(var_0) {
  if(isDefined(self._id_71CF))
    return self[[self._id_71CF]](var_0);

  return anim.failure;
}

_id_B01D(var_0) {
  if(isDefined(self._id_71BE))
    return self[[self._id_71BE]](var_0);

  return anim.failure;
}

_id_13059(var_0) {
  var_1 = self.keepclaimednodeifvalid;
  var_2 = self.keepclaimednode;
  self.keepclaimednodeifvalid = 0;
  self.keepclaimednode = 0;

  if(self _meth_83D4(var_0, 0)) {
    _id_BD18(var_0);
    return 1;
  } else {}

  self.keepclaimednodeifvalid = var_1;
  self.keepclaimednode = var_2;
  return 0;
}

_id_470D() {
  if(self.fixednode || self.doingambush)
    return 0;

  if(gettime() < self.bt._id_BF89)
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  var_0 = self.bt.cover;

  if(var_0._id_4C28 == "hide" || isDefined(self._id_280A)) {
    if(!isDefined(self._blackboard._id_522F) || !_id_9D96(self._blackboard._id_522F))
      return 1;
  }

  return 0;
}

_id_B019(var_0) {
  if(_id_470D()) {
    var_1 = _id_B01A(self.bt.cover.node);

    if(var_1) {
      self.bt._id_BF89 = gettime() + 1000;
      thread scripts\anim\battlechatter_ai::_id_67D2();
    } else
      _id_F7B0();
  }

  return anim.success;
}

_id_B01A(var_0) {
  if(self.script == "cover_arrival")
    return 0;

  var_1 = self _meth_80E3();

  if(isDefined(var_1)) {
    if(!isDefined(self.node) || var_1 != self.node || isDefined(var_0) && var_1 != var_0) {
      if(_id_13059(var_1))
        return 1;
    }
  }

  return 0;
}

_id_6A0D() {
  if(self.fixednode || self.doingambush)
    return 0;

  if(isDefined(self.bt.cover))
    return 0;

  if(!isDefined(self._blackboard._id_AA3D))
    return 0;

  return 1;
}

_id_12E92(var_0) {
  if(_id_6A0D()) {
    if(!scripts\engine\utility::actor_is3d() && isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, self.origin) > 4.0) {
      self._blackboard._id_AA3D = undefined;
      self.bt._id_BF89 = undefined;
    } else if(isDefined(self.node) && self.node != self._blackboard._id_AA3D) {
      self._blackboard._id_AA3D = undefined;
      self.bt._id_BF89 = undefined;
    } else {
      if(!isDefined(self.bt._id_BF89))
        _id_F7B0(1);

      if(gettime() >= self.bt._id_BF89) {
        var_1 = _id_B01A(self._blackboard._id_AA3D);

        if(var_1)
          _id_F7B0(1);
        else
          self.bt._id_BF89 = gettime() + 1000;
      }
    }
  }

  return anim.success;
}

_id_12D78(var_0) {
  var_1 = self.bt.cover.node;
  return anim.success;
}

_id_12DDF(var_0) {
  return anim.success;
}

_id_389B(var_0) {
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

_id_8BEB(var_0) {
  return isDefined(self._blackboard._id_5D3B) && isDefined(self._blackboard._id_522F) && self._blackboard._id_522F == var_0;
}

_id_FFE1(var_0) {
  var_1 = isDefined(self.node) && _id_8BEB(self.node) && _id_389B(self.node);
  var_2 = scripts\anim\utility_common::usingmg() || isDefined(scripts\asm\asm_bb::bb_getrequestedturret()) || var_1;

  if(var_2)
    return anim.success;

  return anim.failure;
}

_id_12EA7(var_0) {
  _id_F6A4("hide");
  return anim.success;
}

_id_9D96(var_0) {
  return self _meth_8199(var_0) || scripts\engine\utility::is_true(self._id_9327);
}

_id_9D98() {
  return self _meth_8199() || scripts\engine\utility::is_true(self._id_9327);
}

_id_9E43(var_0) {
  if(!isDefined(self.node) || self.node.type == "Path" || self.node.type == "Exposed" || scripts\engine\utility::isnodeexposed3d(self.node))
    return anim.failure;

  var_1 = 16;

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > var_1)
      return anim.failure;
  } else if(self.keepclaimednodeifvalid)
    var_1 = 3600;
  else if(isDefined(self._blackboard._id_522F) && self.node == self._blackboard._id_522F)
    var_1 = 576;
  else
    var_1 = 225;

  var_2 = undefined;

  if(scripts\engine\utility::actor_is3d())
    var_2 = distancesquared(self.origin, self.node.origin);
  else {
    if(abs(self.origin[2] - self.node.origin[2]) > 80.0)
      return anim.failure;

    var_2 = distance2dsquared(self.origin, self.node.origin);
  }

  if(var_2 > var_1)
    return anim.failure;

  if(isDefined(self.bt.cover)) {
    if(!isDefined(self.bt.cover.node))
      return anim.failure;

    if(self.bt.cover.node != self.node)
      return anim.failure;

    if(isDefined(self.enemy)) {
      var_3 = 0;

      if(_id_FFCB())
        var_3 = _id_9D99(self.bt.cover.node);
      else
        var_3 = _id_9D98();

      if(!var_3 && !_id_6E03())
        return anim.failure;
    }
  } else if(isDefined(self.enemy)) {
    if(!_id_9D98() && !_id_6E03())
      return anim.failure;
  }

  return anim.success;
}

_id_6E03() {
  if(!self.fixednode)
    return 0;

  if(isDefined(self.enemy.node) && !nodesvisible(self.node, self.enemy.node))
    return 1;

  if(!self seerecently(self.enemy, 8))
    return 1;

  if(scripts\engine\utility::actor_is3d())
    return 1;

  if(distancesquared(self.origin, self.enemy.origin) > 4096.0) {
    var_0 = (0, 0, 50);
    var_1 = vectorNormalize(self.enemy.origin - self.origin);
    var_2 = self.origin + var_0;
    var_3 = var_2 + var_1 * 64.0;
    return !bullettracepassed(var_2, var_3, 0, self);
  }

  return 0;
}

_id_FFCB() {
  return weaponclass(self.weapon) == "mg" || _id_8BEB(self.bt.cover.node);
}

_id_9D99(var_0) {
  if(!isDefined(self.enemy) || !isDefined(self.node))
    return 0;

  var_1 = var_0.angles[1] - vectortoyaw(self.enemy.origin - var_0.origin);
  var_1 = angleclamp180(var_1);

  if(var_1 < 0)
    var_1 = -1 * var_1;

  if(var_1 <= self.leftaimlimit)
    return 1;

  return 0;
}

shouldrefundsuper(var_0, var_1) {
  var_2 = anim.success;
  var_3 = anim.failure;

  if(self.bulletsinclip > weaponclipsize(self.weapon) * var_1)
    return var_3;

  thread scripts\anim\battlechatter_ai::_id_67D4();
  return var_2;
}

_id_98C1(var_0) {
  _id_9815();
}

_id_4742(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("reload", "end"))
    return anim.failure;

  scripts\asm\asm_bb::bb_requestreload(1);
  _id_F6A4("hide");
  return anim.running;
}

_id_116FD(var_0) {
  scripts\asm\asm_bb::bb_requestreload(0);
}

_id_9814(var_0) {
  _id_F6A4("hide");

  if(isDefined(self.enemy) && !isDefined(self.bt.cover._id_3C5B))
    _id_F6A2();
}

_id_4721(var_0) {
  _id_F6A4("hide");

  if(isDefined(self.enemy) && !_id_9D98())
    self.bt._id_BF89 = self.bt._id_BF89 - 1000;

  return anim.success;
}

_id_F7D9(var_0) {
  var_1 = 2500;
  var_2 = 3500;
  self.bt.cover._id_C9FB = gettime() + randomintrange(var_1, var_2);
}

_id_9815() {
  var_0 = gettime();
  self.bt.cover._id_11934 = var_0;
  _id_F7D9(1);
}

_id_116F7(var_0) {}

_id_9D97(var_0) {
  if(isDefined(self._id_280A))
    return anim.failure;

  if(scripts\anim\utility_common::issuppressedwrapper())
    return anim.success;

  return anim.failure;
}

_id_38CB(var_0) {
  var_1 = self.node.type;

  if(var_1 == "Cover Left")
    return anim.success;
  else if(var_1 == "Cover Right")
    return anim.success;
  else if(var_1 == "Cover Stand" || var_1 == "Cover Stand 3D") {
    var_2 = self.node _meth_8169();

    foreach(var_4 in var_2) {
      if(var_4 == "over")
        return anim.success;
    }

    return anim.success;
  } else if(var_1 == "Cover Prone" || var_1 == "Conceal Prone")
    return anim.failure;

  return anim.failure;
}

_id_10038(var_0) {
  if(_id_7E42() != "hide")
    return anim.failure;

  if(self.doingambush)
    return anim.failure;

  if(!isDefined(self.bt.cover._id_11934))
    return anim.failure;

  if(!isDefined(self.bt.cover._id_C9FB))
    return anim.failure;

  if(gettime() < self.bt.cover._id_C9FB)
    return anim.failure;

  return anim.success;
}

_id_9894(var_0) {
  var_1 = 500;
  var_2 = 1500;
  var_3 = gettime();
  self.bt.cover._id_B026 = var_3;
  self.bt.cover._id_B016 = randomintrange(var_1, var_2);
  self.bt.cover._id_B012 = 3000;
}

_id_116F9(var_0) {
  if(isDefined(self.bt.cover))
    _id_F7D9(0);
}

_id_4726(var_0) {
  _id_F6A4("look");
  var_1 = self.bt.cover._id_B026;
  var_2 = self.bt.cover._id_B016;
  var_3 = self.bt.cover._id_B012;

  if(isDefined(self.pathgoalpos))
    return anim.success;

  var_4 = gettime();

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end"))
    var_3 = var_4 - var_1;

  if(var_4 - var_1 > var_3 + var_2)
    return anim.success;

  return anim.running;
}

_id_38E8(var_0) {
  var_1 = self.node.type;

  if(scripts\engine\utility::isnodecovercrouch(self.node))
    return anim.success;
  else if(var_1 == "Cover Stand" || var_1 == "Cover Stand 3D") {
    var_2 = self.node _meth_8169();

    foreach(var_4 in var_2) {
      if(var_4 == "over")
        return anim.success;
    }

    return anim.failure;
  } else if(var_1 == "Cover Right") {
    if(self.a.pose == "stand")
      return anim.success;
    else
      return anim.failure;
  } else if(var_1 == "Cover Left")
    return anim.success;
  else if(var_1 == "Cover 3D")
    return anim.success;

  return anim.failure;
}

_id_473E(var_0) {
  _id_F6A4("peek");

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_peek", "end"))
    return anim.success;

  return anim.running;
}

_id_116FC(var_0) {
  if(isDefined(self.bt.cover)) {
    _id_F6A4("hide");
    _id_F7D9(0);
  }
}

_id_BDF3(var_0) {
  if(!isDefined(self.node) && self.a.pose == "prone")
    return anim.success;

  if(self.node.type == "Conceal Prone" || self.node.type == "Cover Prone") {
    if(self.a.pose != "prone" || scripts\asm\asm_bb::_id_292C() != "prone")
      return anim.success;

    return anim.failure;
  }

  if(!self _meth_81BF(self.a.pose))
    return anim.success;

  var_1 = undefined;

  if(self.node doesnodeallowstance("stand") && !self.node doesnodeallowstance("crouch"))
    var_1 = "stand";
  else if(self.node doesnodeallowstance("crouch") && !self.node doesnodeallowstance("stand"))
    var_1 = "crouch";

  if(isDefined(var_1))
    scripts\asm\asm_bb::bb_requestsmartobject(var_1);

  return anim.failure;
}

_id_FFD1(var_0) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(isDefined(self._id_DC5C) && self.a.pose == "stand")
    return anim.failure;

  if(self.node.type != "Cover Right" && self.node.type != "Cover Left")
    return anim.failure;

  if(scripts\engine\utility::isnodecover3d(self.node))
    return anim.failure;

  if(self.a.pose == "stand" && !self.node doesnodeallowstance("crouch"))
    return anim.failure;

  if(self.a.pose == "crouch" && !self.node doesnodeallowstance("stand"))
    return anim.failure;

  if(!isDefined(self.bt.cover._id_3C5B))
    _id_F6A2();

  if(gettime() < self.bt.cover._id_3C5B)
    return anim.failure;

  return anim.success;
}

_id_F6A2() {
  self.bt.cover._id_3C5B = gettime() + randomintrange(5000, 20000);
}

_id_97E4(var_0) {
  _id_F6A2();
  self.a._id_D892 = undefined;
  var_1 = undefined;

  if((self.a.pose != "prone" || scripts\asm\asm_bb::_id_292C() != "prone") && isDefined(self.node) && (self.node.type == "Conceal Prone" || self.node.type == "Cover Prone"))
    var_1 = "prone";
  else {
    var_2 = ["stand", "crouch", "prone"];

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(self _meth_81BF(var_4)) {
        var_1 = var_4;
        break;
      }
    }
  }

  scripts\asm\asm_bb::bb_requestsmartobject(var_1);
  self.bt.cover._id_3C5C = gettime();
}

_id_4712(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_stance_trans", "end"))
    return anim.success;

  var_1 = 5000;
  var_2 = self.bt.cover._id_3C5C;

  if(gettime() - var_2 > var_1)
    return anim.success;

  if(self.a.pose == scripts\asm\asm_bb::_id_292C())
    return anim.success;

  return anim.running;
}

_id_116F1(var_0) {
  scripts\asm\asm_bb::bb_requestsmartobject(self.a.pose);
}

_id_7E40(var_0, var_1) {
  if(var_0.type == "Cover Right") {
    if(var_1 == "stand")
      return [-180, 12, -40, 0, -180, -38];
    else
      return [-180, 12, -40, 0, -180, -31];
  } else if(var_0.type == "Cover Left") {
    if(var_1 == "stand")
      return [-14, 180, 0, 40, 38, 180];
    else
      return [-14, 180, 0, 40, 31, 180];
  } else
    return [-45, 45, 0, 0, 0, 0];
}

_id_77C3(var_0, var_1) {
  if(var_0.type == "Cover 3D")
    return [-65, 45, -55, 55];
  else
    return [-45, 45, -45, 45];
}

_id_8C20(var_0) {
  var_1 = 36;
  var_2 = var_0.origin;

  if(scripts\engine\utility::isnodecoverright(var_0))
    var_2 = var_2 + anglestoright(var_0.angles) * var_1;
  else
    var_2 = var_2 + anglestoleft(var_0.angles) * var_1;

  return self maymovetopoint(var_2, 0, 0);
}

_id_4749(var_0) {
  if(self.script == "cover_arrival" || self.script == "move")
    return anim.failure;

  if(isDefined(self._id_280A))
    return anim.success;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.node)) {
    if(scripts\engine\utility::isnodeexposed3d(self.node))
      return anim.success;

    var_1 = scripts\asm\shared\utility::getnodeforwardangles(self.node, 0);
    var_2 = angleclamp180(self.angles[0] - var_1[0]);
    var_3 = angleclamp180(self.angles[1] - var_1[1]);
    var_4 = angleclamp180(self.angles[2] - var_1[2]);

    if(abs(var_2) > 5 || abs(var_3) > 5 || abs(var_4) > 5)
      return anim.failure;

    var_5 = (self.enemy.origin + scripts\anim\utility_common::getenemyeyepos()) / 2;
    var_6 = var_5 - self.origin;
    var_7 = rotatevectorinverted(var_6, self.node.angles);
    var_8 = vectortoangles(var_7);
    var_2 = angleclamp180(var_8[0]);
    var_3 = angleclamp180(var_8[1]);
    var_9 = _id_77C3(self.node, self.a.pose);

    if(var_2 > var_9[1] || var_2 < var_9[0])
      return anim.failure;

    if(var_3 > var_9[3] || var_3 < var_9[2])
      return anim.failure;

    return anim.success;
  } else {
    var_10 = _id_7E40(self.node, self.a.pose);
    var_11 = self.node.origin + scripts\anim\utility_common::getnodeoffset(self.node);
    var_6 = self.enemy.origin - var_11;
    var_12 = vectortoangles(var_6);
    var_8 = angleclamp180(var_12[1] - self.node.angles[1]);

    if(var_10[0] <= var_8 && var_8 <= var_10[1]) {
      if(scripts\engine\utility::isnodecoverright(self.node) && var_8 > var_10[3] || scripts\engine\utility::isnodecoverleft(self.node) && var_8 < var_10[2]) {
        if(!_id_8C20(self.node))
          return anim.failure;
      }

      return anim.success;
    }

    return anim.failure;
  }
}

_id_9803(var_0) {
  if(_id_7E42() != "exposed")
    self.bt.cover._id_11933 = gettime() + 3000;

  self.bt.shootparams = spawnStruct();
  self.bt.shootparams.taskid = var_0;
  self.bt.m_bfiring = 0;
  var_1 = scripts\anim\utility_common::isasniper();

  if(var_1)
    scripts\aitypes\combat::_id_FE5D(self.bt.shootparams);
}

_id_116F4(var_0) {
  if(isDefined(self.bt.shootparams) && self.bt.shootparams.taskid == var_0) {
    self.bt.shootparams = undefined;
    self.bt.m_bfiring = undefined;
  }

  scripts\asm\asm_bb::bb_requestfire(0);
  scripts\asm\asm_bb::bb_setshootparams(undefined);
}

_id_38C5() {
  if(weaponclass(self.weapon) == "rocketlauncher")
    return 0;

  return 1;
}

_id_4B0B(var_0, var_1) {
  var_2 = ["exposed", "left", "right"];
  var_3 = [(0, 0, 46), (0, 0, 0), (0, 0, 0)];
  var_4 = [(0, 0, 0), (0, 32, 36), (0, -32, 36)];
  var_5 = [(0, 0, 36), (0, 0, 0), (0, 0, 0)];

  if(isDefined(self._blackboard._id_FEF0) && self._blackboard._id_FEF0 == var_0)
    return self._blackboard._id_FEEF;

  var_6 = [];
  var_7 = undefined;

  switch (var_0.type) {
    case "Cover Stand":
    case "Conceal Stand":
      var_7 = var_3;
      break;
    case "Conceal Crouch":
    case "Cover Crouch Window":
    case "Cover Crouch":
      var_7 = var_4;
      break;
    case "Cover Right":
    case "Cover Left":
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

    for(var_10 = 0; var_10 < var_2.size; var_10++) {
      if(var_2[var_10] == var_9) {
        break;
      }
    }

    var_11 = var_7[var_10];
    var_12 = rotatevector(var_11, var_0.angles) + var_0.origin;
    var_13 = anglesToForward(var_0.angles);
    var_14 = var_12 + var_13 * 32.0;

    if(sighttracepassed(var_12, var_14, 0, undefined)) {
      var_6[var_6.size] = var_9;
      continue;
    }
  }

  self._blackboard._id_FEF0 = var_0;
  self._blackboard._id_FEEF = var_6;
  return var_6;
}

_id_471E(var_0) {
  if(!isDefined(self.enemy))
    return anim.failure;

  var_1 = self getentitynumber() * 3 % 1000;
  var_2 = 8000 + var_1;
  var_3 = 5000 + var_1;
  var_4 = 1000;

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end"))
    self.bt.cover._id_11933 = gettime();

  var_5 = self.bt.cover._id_11933;
  var_6 = gettime() - var_5;
  var_7 = self.bt.cover.node;

  if(isDefined(self._id_280A)) {
    _id_4748(var_0);

    if(scripts\engine\utility::isnodecoverleft(var_7) || scripts\engine\utility::isnodecoverright(var_7))
      scripts\asm\asm_bb::_id_295E("B");
    else
      scripts\asm\asm_bb::_id_295E("full exposed");

    _id_F6A4("exposed");

    if(shouldrefundsuper(var_0, 0) == anim.success)
      scripts\asm\asm_bb::bb_requestreload(1);
    else
      scripts\asm\asm_bb::bb_requestreload(0);

    return anim.running;
  }

  if(shouldrefundsuper(var_0, 0) == anim.success && var_6 > var_4)
    return anim.failure;

  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(scripts\engine\utility::actor_is3d()) {
    var_11 = (self.enemy.origin + scripts\anim\utility_common::getenemyeyepos()) / 2;
    var_12 = var_11 - self getEye();

    if(scripts\engine\utility::isnodeexposed3d(var_7))
      var_10 = vectortoangles(var_12);
    else if(scripts\engine\utility::isnode3d(var_7)) {
      var_8 = _id_77C3(var_7, self.a.pose);
      var_12 = rotatevectorinverted(var_12, var_7.angles);
      var_10 = vectortoangles(var_12);
      var_13 = angleclamp180(var_10[0]);
      var_14 = angleclamp180(var_10[1]);

      if(var_13 > var_8[1] || var_13 < var_8[0])
        return anim.failure;

      if(var_14 > var_8[3] || var_14 < var_8[2])
        return anim.failure;
    }
  } else {
    var_8 = _id_7E40(var_7, self.a.pose);
    var_15 = var_7.origin + scripts\anim\utility_common::getnodeoffset(var_7);
    var_12 = scripts\anim\utility_common::getenemyeyepos() - var_15;
    var_10 = vectortoangles(var_12);
    var_9 = angleclamp180(var_10[1] - var_7.angles[1]);

    if(var_9 < var_8[0] || var_9 > var_8[1])
      return anim.failure;
  }

  var_16 = _id_4748(var_0);

  if(!isDefined(self.bt.shootparams._id_29AF)) {
    if(!var_16) {
      if(var_6 > var_3)
        return anim.failure;
    } else if(var_6 > var_2)
      return anim.failure;
  }

  if(scripts\engine\utility::isnodecoverleft(var_7) || scripts\engine\utility::isnodecoverright(var_7)) {
    var_17 = scripts\asm\asm_bb::_id_2929();
    var_18 = _id_7E42() == "exposed";
    var_19 = !isDefined(var_17) || var_18;

    if(!var_19)
      var_19 = randomint(100) < 20;

    var_20 = isDefined(var_17) && var_17 == "lean" && var_18;
    var_21 = [];

    if(_id_38C5() && var_8[2] <= var_9 && var_9 <= var_8[3]) {
      if(var_20) {
        scripts\asm\asm_bb::_id_295E("lean");
        return anim.running;
      } else if(!var_18 && (var_19 || var_17 != "lean"))
        var_21[var_21.size] = "lean";
    } else if(var_20)
      return anim.failure;

    if(isDefined(var_17) && _id_7E42() == "exposed") {
      if(var_17 == "A") {
        var_8[4] = var_8[4] - 5;
        var_8[5] = var_8[5] + 5;
      } else {
        var_8[4] = var_8[4] + 5;
        var_8[5] = var_8[5] - 5;
      }
    }

    if(var_8[4] <= var_9 && var_9 <= var_8[5]) {
      if(var_19 || var_17 != "A")
        var_21[var_21.size] = "A";
    } else if(var_19 || var_17 != "B") {
      if(_id_8C20(var_7))
        var_21[var_21.size] = "B";
      else if(var_21.size == 0)
        return anim.failure;
    }

    var_22 = undefined;

    if(var_21.size == 0)
      var_22 = var_17;
    else
      var_22 = var_21[randomint(var_21.size)];

    scripts\asm\asm_bb::_id_295E(var_22);
  } else if(var_7.type == "Cover 3D") {
    var_17 = scripts\asm\asm_bb::_id_2929();

    if(!isDefined(var_17) || _id_7E42() != "exposed")
      scripts\asm\asm_bb::_id_295E("exposed");
  } else {
    var_17 = scripts\asm\asm_bb::_id_2929();
    var_23 = scripts\asm\asm_bb::bb_isshort();

    if(!isDefined(var_17) || _id_7E42() != "exposed") {
      var_22 = undefined;

      if(scripts\engine\utility::isnodecovercrouch(var_7)) {
        var_24 = scripts\anim\utility_common::getenemyeyepos();
        var_25 = angleclamp180(var_10[0]);

        if(var_25 > 25 || var_25 > 10 && var_23)
          var_22 = "leanover";
        else if(var_25 > 10)
          var_22 = "full exposed";
      }

      if(!isDefined(var_22)) {
        var_26 = var_7 _meth_8169();
        var_21 = ["full exposed"];

        foreach(var_28 in var_26) {
          if(var_28 == "over") {
            var_21[var_21.size] = "exposed";
            continue;
          }

          if(hasroomtoplaypeekout(var_7, var_28))
            var_21[var_21.size] = var_28;
        }

        if(var_23)
          var_21 = _id_4B0B(var_7, var_21);

        var_22 = var_21[randomint(var_21.size)];
      }

      scripts\asm\asm_bb::_id_295E(var_22);
    }
  }

  _id_F6A4("exposed");
  return anim.running;
}

_id_4748(var_0) {
  var_1 = scripts\aitypes\combat::shouldshoot();

  if(!var_1)
    return 0;

  var_2 = self.bt.shootparams;

  if(self cansee(self.enemy)) {
    var_2.pos = self.enemy getshootatpos();
    var_2.ent = self.enemy;
  } else {
    var_2.pos = self.goodshootpos;
    var_2.ent = undefined;
  }

  if(!isDefined(var_2.objective))
    var_2.objective = "normal";

  scripts\asm\asm_bb::bb_setshootparams(var_2, self.enemy);

  if(scripts\aitypes\combat::isaimedataimtarget()) {
    if(!self.bt.m_bfiring) {
      scripts\aitypes\combat::resetmisstime_code();
      scripts\aitypes\combat::chooseshootstyle(var_2);
      scripts\aitypes\combat::choosenumshotsandbursts(var_2);
    }

    scripts\aitypes\combat::_id_3EF8(var_2);
    self.bt.m_bfiring = 1;
  } else
    self.bt.m_bfiring = 0;

  if(!isDefined(var_2.pos) && !isDefined(var_2.ent)) {
    self.bt.m_bfiring = 0;
    scripts\asm\asm_bb::bb_requestfire(0);
    return 0;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return 1;
}

_id_9DDA(var_0) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(distancesquared(self.enemy.origin, self._id_46A6) < 256)
    return anim.failure;
  else if(scripts\anim\utility_common::canseeenemyfromexposed())
    return anim.success;
  else
    return anim.failure;
}

_id_F7B4() {
  if(isDefined(self.bt.cover))
    self.bt.cover._id_BFA5 = gettime() + randomintrange(3000, 12000);
}

_id_3875() {
  if(self.team == "allies")
    return 0;

  if(self.unittype == "c6")
    return 0;

  if(!scripts\anim\weaponlist::usingautomaticweapon())
    return 0;

  if(weaponclass(self.weapon) == "mg")
    return 0;

  if(isDefined(self._id_5507) && self._id_5507 == 1)
    return 0;

  if(isDefined(self.bt.cover.node.script_parameters) && self.bt.cover.node.script_parameters == "no_blindfire")
    return 0;

  var_0 = self.bt.cover.node.type;

  switch (var_0) {
    case "Cover Right":
      return self.a.pose == "stand";
    case "Cover Left":
      return self.a.pose == "stand";
    case "Cover Prone":
    case "Conceal Stand":
    case "Conceal Prone":
    case "Conceal Crouch":
      return 0;
    case "Cover Stand":
      var_1 = self.node _meth_8169();

      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        if(var_1[var_2] == "over")
          return 1;
      }

      return 0;
  }

  return 1;
}

_id_FFCC(var_0) {
  if(!_id_3875())
    return anim.failure;

  if(gettime() < self.bt.cover._id_BFA5)
    return anim.failure;

  if(!_id_9DDA() && !scripts\anim\utility_common::cansuppressenemyfromexposed())
    return anim.failure;

  return anim.success;
}

_id_4711(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_blindfire", "end"))
    return anim.success;

  scripts\asm\asm_bb::_id_295D(1);
  return anim.running;
}

_id_116F0(var_0) {
  scripts\asm\asm_bb::_id_295D(0);
  _id_F7B4();
}

_id_100AD(var_0) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(self.grenadeammo <= 0)
    return anim.failure;

  if(self.grenadeweapon == "none")
    return anim.failure;

  if(isDefined(self.enemy) && isDefined(self.enemy._id_5963))
    return anim.failure;

  var_1 = self.bt.cover.node;

  if(var_1.type == "Cover Prone" || var_1.type == "Conceal Prone")
    return anim.failure;

  if(scripts\engine\utility::is_true(self._id_C062))
    return anim.failure;

  var_2 = self.enemy;
  var_3 = anglesToForward(var_1.angles);
  var_4 = var_2.origin - self.origin;
  var_5 = lengthsquared(var_4);
  var_6 = 2560000;

  if(var_5 > var_6)
    return anim.failure;

  var_7 = vectorNormalize(var_4);

  if(vectordot(var_3, var_7) < 0)
    return anim.failure;

  var_8 = 0.4;
  var_9 = gettime();

  if(isDefined(self.bt.cover._id_A992) && var_9 < self.bt.cover._id_A992 + var_8)
    return anim.failure;

  self.bt.cover._id_A992 = var_9;

  if(self.doingambush && !scripts\anim\utility_common::recentlysawenemy())
    return anim.failure;

  if(isDefined(self.dontevershoot) || isDefined(var_2._id_5951))
    return anim.failure;

  _id_0A18::_id_F62B(self.enemy);

  if(!_id_0A18::_id_85B5(var_2))
    return anim.failure;

  if(scripts\anim\utility_common::canseeenemyfromexposed()) {
    if(!self _meth_81A2(var_2, var_2.origin))
      return anim.failure;

    return anim.success;
  }

  if(scripts\anim\utility_common::cansuppressenemyfromexposed())
    return anim.success;

  if(!self _meth_81A2(var_2, var_2.origin))
    return anim.failure;

  return anim.success;
}

_id_98DB(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.enemy);
  _id_F6A4("hide");
  self.bt.instancedata[var_0] = gettime() + 3000;
}

_id_474F(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end"))
    return anim.success;

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0))
    self.bt.instancedata[var_0] = self.bt.instancedata[var_0] + 10000;

  if(gettime() > self.bt.instancedata[var_0])
    return anim.failure;

  return anim.running;
}

_id_11700(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var_0] = undefined;
}

_id_6574(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 scripts\engine\utility::isflashed())
    return 1;

  if(isPlayer(var_0)) {
    if(isDefined(var_0.health) && var_0.health < var_0.maxhealth)
      return 1;
  } else if(isai(var_0) && var_0 scripts\anim\utility_common::issuppressedwrapper())
    return 1;

  if(isDefined(var_0.isreloading) && var_0.isreloading)
    return 1;

  return 0;
}

_id_B4ED(var_0, var_1) {
  if(isDefined(self._id_29CF) && self._id_29CF)
    return anim.failure;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(!isDefined(self.node))
    return anim.failure;

  if(scripts\engine\utility::isnodecover3d(self.node))
    return anim.failure;

  if(self.fixednode || self.doingambush || self.keepclaimednode)
    return anim.failure;

  if(isDefined(self._blackboard.coverstate) && self._blackboard.coverstate != "hide")
    return anim.failure;

  var_2 = 16;

  if(!isDefined(self.pathgoalpos))
    var_2 = 3600;

  if(distancesquared(self.origin, self.node.origin) > var_2)
    return anim.failure;

  var_3 = gettime();

  if(isDefined(self._blackboard._id_1016E) && var_3 < self._blackboard._id_1016E + 500)
    return anim.failure;

  if(var_3 < self.bt.cover._id_BF8A)
    return anim.failure;

  if(isDefined(var_1) && var_1) {
    if(randomint(3) == 0)
      return anim.failure;
  }

  return anim.success;
}

_id_2546(var_0) {
  var_1 = self _meth_80E8();

  if(!isDefined(var_1))
    return anim.failure;

  if(var_1 == self.node || var_1 == self.bt.cover.node)
    return anim.failure;

  if(distancesquared(self.node.origin, var_1.origin) < 16)
    return anim.failure;

  var_2 = self.keepclaimednodeifvalid;
  self.keepclaimednodeifvalid = 0;
  var_3 = self _meth_83D4(var_1);

  if(!var_3) {
    self.keepclaimednodeifvalid = var_2;
    return anim.failure;
  }

  self._blackboard.shufflenode = var_1;
  self._blackboard._id_1016E = gettime();
  self._blackboard._id_1016B = self.bt.cover.node;
  return anim.running;
}

_id_453E(var_0) {
  if(isDefined(self.bt.cover) && weaponclass(self.weapon) == "mg" && isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536.0) {
    if(isDefined(self._id_101B4))
      scripts\asm\asm_bb::bb_requestweapon(weaponclass(self._id_101B4));
  }

  return anim.success;
}

_id_12E5D(var_0) {
  if(isDefined(self._id_280A)) {
    if(self.health < self.maxhealth * 0.75)
      self._id_280A = undefined;
    else if(isDefined(self._blackboard.scriptableparts) && self._blackboard.scriptableparts.size >= 2)
      self._id_280A = undefined;
  }

  return anim.success;
}

_id_9D40(var_0) {
  return isDefined(self._id_280A);
}